Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9409CC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5498F21473
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="GC7fW0/q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mGguCQxb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5498F21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbeJEAB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 20:01:57 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:58835 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727505AbeJEAB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 20:01:57 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 2B3737FB;
        Thu,  4 Oct 2018 13:00:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 04 Oct 2018 13:00:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=9+WCR58BL/H0yUWo2MtsnnH+6Rb
        O3iPic2NQlCqHKDU=; b=GC7fW0/q2jvixRQ9mTOzMS1kgPf9A6I4STu21tjYIhD
        Z9hw/kQDeA0K+VpCRJ3+kH0XXCDWXF04XPXchi+gJbs5j/FodOGyzbpzcHNpbQDs
        KoSS6Jf5H9tPtY39cZMsrdnx0ctDqZZ7YD2LVO3yHL+SX0cjOXiuw4dU8GLL41W4
        i7nHszy8mDcJKSCY2GlUgOtE2b2lfXzMkJzFTqp7Y4uUfeG0Vphow/kYlA/5dR3j
        pBLD1yZlyEtYDSWke1OdADKrVH4QFD4ZIdF9+njHLBQDI0VAJGKDTdkrReFefxfO
        LBCGJELTQ1pfwER29N0h1aNvPOk+BZ397heRuwUfqNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=9+WCR5
        8BL/H0yUWo2MtsnnH+6RbO3iPic2NQlCqHKDU=; b=mGguCQxbXHoDwb4JgLRwOv
        cVtNoSGUJyXLCNCqlKLpcAzXE0jXXepXl4nS4iPBjUSXMM7iPBs3n/fnA/mw5opD
        b2ubrDfWxvuKxq4qHzEz2WXZZi9ctVPsxgFbkkBdUGNB2A2IYI34ysVRFEnyAwEq
        hNIG8cmsQ8+2aOO/Kq3Zo82fsCfm4EAGfeuvi/KQgw/BvMrpiEY8oWGlcfMG5Kw4
        4AMg9UjeixPmMQqMtQ2iuyvr5g0NmLs0SRtyIOQ0IZfHpFOXtiFprpDRpu4Vu35P
        BKrheT6Gt/ig4NKl5RqpOVdrElSe7UP8Cv5s+tM0SuiQ7TdhtAZPGUCo69bU0NbA
        ==
X-ME-Sender: <xms:Mke2W3P3iT0Pp1BbQChNv0Z3QnRGen77Hej4YBcdhkeQyN1sAY3jxw>
X-ME-Proxy: <xmx:Mke2W1MYnw3WgGdYTBNX9Ki0HVONGaCA8qWnuxnruJ76syJWDd3WkA>
    <xmx:Mke2W8iAlwXiQTfXZjNDNPa7tCnaQ6SqJ65nn72tJs21HcYuSro2uQ>
    <xmx:Mke2WxYFduibHWlXUrPdSM8LULtKCYnCWKwG-yoNOamau0Xip48JBw>
    <xmx:Mke2W4h_1QmRLll0-dG82s4KOGZdCdD5eJXer1bc5cdI0tl6Enkbdg>
    <xmx:Mke2W7aREAnxwXQxK0wReBPteFVKiUr_XsDp7lBHOjPl_8VRDJtxvA>
    <xmx:M0e2W__7iu5kbGPosX1obzHqfnUZtPmeZFEnmwe5clmHOFEs_dfVHw>
Received: from localhost (unknown [104.132.1.111])
        by mail.messagingengine.com (Postfix) with ESMTPA id 877ED102E7;
        Thu,  4 Oct 2018 13:00:33 -0400 (EDT)
Date:   Thu, 4 Oct 2018 10:00:32 -0700
From:   Greg Kroah-Hartman <greg@kroah.com>
To:     Steve Sakoman <steve@sakoman.com>
Cc:     sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andreas Steinmetz <ast@domdv.de>,
        Eric C Gallimore <egallimore@ucsd.edu>
Subject: Re: linux-next: build failure after merge of the tty tree
Message-ID: <20181004170032.GA7344@kroah.com>
References: <20181004151501.280d8282@canb.auug.org.au>
 <CAOSpxdYzm6fTd88gP_OdrTuqbf-kJr3t+3ObPU9vMCHqYJSgHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOSpxdYzm6fTd88gP_OdrTuqbf-kJr3t+3ObPU9vMCHqYJSgHg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 06:34:31AM -1000, Steve Sakoman wrote:
> Interesting indeed. Who would have thought someone would be using the
> "unused" padding variable!

Ugh :(

> How would folks prefer we fix this, in the referenced patch or by
> eliminating the use of "unused" in samsung.c?

We should just get rid of the "unused" fields entirely.  They aren't
needed here as this is not a structure that anyone really cares about.
We can move things around a bit if the padding is an issue.

I've reverted this patch first for now.  I suggest a patch to the uart
core to drop the unused fields and fix up the samsung driver and then
your patch can go on top of that.  Can you work on this?

thanks,

greg k-h
