Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 253E7ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9B49214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="CQvOAYr1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UBjHws61"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9B49214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbeJQPb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 11:31:57 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:44427 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726947AbeJQPb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 11:31:57 -0400
X-Greylist: delayed 467 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Oct 2018 11:31:56 EDT
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id CAADDC0C;
        Wed, 17 Oct 2018 03:29:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 17 Oct 2018 03:29:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=HPK1vVaI9E02zdmitQ/0ehQ3w23
        dICQMGMTcHP0GKQ4=; b=CQvOAYr1GR6BA1+Jhv0g1hEBjEuA4T6Ie9w6J4pZBUN
        Z/yhPLKBVdHnA37/ux9oq0olOgwHmmB8CxqRwAa+9MxYdPwK4kPvu32SrlkrlM8M
        brTHZ5VKtW55XITPKfla8hFOzRRpoG7IXAjd9kv2e0xVWlFK0AaBgMio8BM1aOVE
        0ilYukkBscn1TIdmwIt2Al2gtRHifCCFbXxzhb5FkAD+socEuxtlp6bjfegYsDar
        c/twEOnKBFbzGbCQDsfL54ti7Kew34iciYK2nte/j00KIQIUYQF1MpObBDmp6ST6
        jDlSkj4QUzpNBz/eCWcBAGRIg6jJBX9bLBea5BNw6XQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=HPK1vV
        aI9E02zdmitQ/0ehQ3w23dICQMGMTcHP0GKQ4=; b=UBjHws61ywB69FhFILG1vH
        my6qF3Oz8TV8q9jS9WfG+Bu0dIXTG3J67AVt8CDb5ab5UnEy4qaGJfqIrTYdG+Om
        tkiin4fW4HcV9RjGbqIAtUUk82+PQRhhAj18hSCKk1WHpIBTvKzEZ84IeyYpA5h8
        6z/sSm+yDtTcrsTiFYrO+MG5SfORfReKfW0vlJAS4zaM9vYj6JqtvQ4xK4WSTgcO
        abXcmk6sKEEM450dX3smrhnTfxbbEEO8eNeX9VTT777bgdYNPpqli1BZqpQnvf4I
        6BSy0tv7D76x42mEi1aTJT70d7rZCXljl2nqTpS+X4+AnBddrh54UyWxFD6YtI/Q
        ==
X-ME-Sender: <xms:6-TGWxFfoOFzo8VvM3dUFFDUnBV6QapltQfaTfliRAAF16-5DtDPFA>
X-ME-Proxy: <xmx:6-TGW9M4TDC0YXCywLc1n9Z_EVYg-KIOzz5o2l79wdJK5otCYxMr7Q>
    <xmx:6-TGW6rJskZS-2WCZ_IJXbhbnLTDsVA3vXe9cpdFc8HEBWkua77mgQ>
    <xmx:6-TGW09jiL283n2nNQqrzXMm3eYJIxVKCaoT4UV0sLXpKNtY16Wj6A>
    <xmx:6-TGWw3lFAXYTZQkqBrbFh8aa5c8_J9TfNmLagVWo_2vrQRHgx7QUw>
    <xmx:6-TGW3Dz76YIH1Ofz2iB9-pLw2D2y6RPEclOsPTuLKbUbbf1PhhWsQ>
    <xmx:7OTGW9RzUXm_63GFLYKpdq6rihi7aw7kRUZKjUGON9tqttLqsq0sOw>
Received: from localhost (ppp121-44-203-227.bras1.syd2.internode.on.net [121.44.203.227])
        by mail.messagingengine.com (Postfix) with ESMTPA id 04AF3E4074;
        Wed, 17 Oct 2018 03:29:46 -0400 (EDT)
Date:   Wed, 17 Oct 2018 18:29:39 +1100
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     tobin@kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/7] drivers: tty: Fix kernel-docs comments
Message-ID: <20181017072939.GF9944@eros>
References: <20181016232130.728-1-tobin@kernel.org>
 <CAMuHMdUKxHhvWHpQZ=ssghsZBRa4YqTFrvYj1h8jP1bdZQEqNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUKxHhvWHpQZ=ssghsZBRa4YqTFrvYj1h8jP1bdZQEqNQ@mail.gmail.com>
X-Mailer: Mutt 1.9.4 (2018-02-28)
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 09:00:26AM +0200, Geert Uytterhoeven wrote:
> Hi Tobin,
> 
> Thanks for your series!
> 
> On Wed, Oct 17, 2018 at 1:23 AM Tobin C. Harding <tobin@kernel.org> wrote:
> > My first patch set using kernel.org email address.  I've been so careful
> > with this one I'm expecting some epic fail :)
> 
> WARNING: Missing Signed-off-by: line by nominal patch author 'Tobin C.
> Harding <me@tobin.cc>'
> 
> The From line in the body of the patch emails doesn't match the SoB.

Thanks Geert.  A fail definitely but not epic by any means ;)  Will
resend tomorrow from the correct address and fix my git configuration.

thanks,
Tobin.
