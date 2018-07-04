Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B34C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 06:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04A4D2075E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 06:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="EBIlXPrS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cOjC2B5Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04A4D2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933534AbeGDG2k (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 02:28:40 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:55609 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932500AbeGDG2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 02:28:36 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 4F0E221EF0;
        Wed,  4 Jul 2018 02:28:33 -0400 (EDT)
Received: from web3 ([10.202.2.213])
  by compute4.internal (MEProxy); Wed, 04 Jul 2018 02:28:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=o804IhJpAAaDyoYg0erTFtPTcX/OD
        484+sOHWFcefH4=; b=EBIlXPrSZJoBsVBeflQkA00oxLftdyY5aEo15C+TR6oB3
        971pQVbfwGamemqINpxHkbuqC+0FQ2G2FIiW5K1cExz5oQJ/H/YmgPJUnQj0sLIn
        DjTdtLsCvEfcObznVHtqCLwfdh9K7Z2vybMyN4fmirz71XjhP1MOth4/a3f/I+fz
        IJez+sN7cptbzAd+O7utgMkxhDQ/BzJ0V1ynb/c+ouHpBLKfGiYckCD5cUEqMYRj
        Za7GkS9uq0nMCs9iNpqkLyy+oi3ZLrwQHXYOdt8dJZI1zFyNBRZ9c6CgqjUNziK8
        N+IepJPJVuo/U+W4IjqMiL9wLjtpdanNuOKPBsipA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=o804Ih
        JpAAaDyoYg0erTFtPTcX/OD484+sOHWFcefH4=; b=cOjC2B5Z2AXJQAk3nY6m2L
        7PTQBjLR2JRRWC90yOpHRHU00WydI4f8NYBqNxOgV9Uh/Kl2YCoHBcyiZtF+sb6V
        5otTv/8AlNQw8PUdq/Fa4prqt4LFLQucYojx4Tm5XUY5iBvFFqda/u27IGeNUxVa
        vR79gy1DF25ZOTJbnHsNreUGaJtIEwDWslN4VGqqEb3YEGp4OUAXS+wKTyZ2pyjH
        6BezOfrY86feK/vX8T1tuhPd8Vi0GD9MekMOrZ8nw7R8w0RaeA3ymZ5wK9/e2Q6q
        kZTxoXKDYTe88p98KK2e8YuHFf7WcdCrSnjyk5LV2BdcPclUI6EX+hxhJZ4VN79Q
        ==
X-ME-Proxy: <xmx:D2k8W-CjpCAw94b4F4iBHu9NzjI_5izFguQwOZP6IJVtfiiWReLVwQ>
    <xmx:D2k8Ww6fGY7eHIaaepVwH3KGfbmSxaEJNdhIfqVD4hVhxX6iurnCdQ>
    <xmx:D2k8Wzyle3WZNoO6IzJFEZ5KraPQXcee4Du2NFVq97GB_aA5iEFWYQ>
    <xmx:D2k8W0l0x2hk1cR67Q6GxbOOFFI4G_dRvvM-nUS5E_gnxxbBalTVbQ>
    <xmx:D2k8W1WCg5rQBos6CJv-JvwHmrSOgmoptaUm_nnpCZ5taOQnA1BH8g>
    <xmx:EWk8W6fB8UlVAKJ5XeuJ4ItJFiQtTZC2tZLH4NrwyRBYSTF80UVeAg>
X-ME-Sender: <xms:D2k8WwCIX5--YSZC1rfJTeSCMarHEWnm54kaiaZpBRTfsVrqmsaZhA>
Received: by mailuser.nyi.internal (Postfix, from userid 99)
        id 982689E48F; Wed,  4 Jul 2018 02:28:31 -0400 (EDT)
Message-Id: <1530685711.3894608.1429457792.4DE9E784@webmail.messagingengine.com>
From:   Andrew Jeffery <andrew@aj.id.au>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, joel@jms.id.au, Eugene.Cho@dell.com,
        a.amelkin@yadro.com, stewart@linux.ibm.com,
        benh@kernel.crashing.org, openbmc@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Mailer: MessagingEngine.com Webmail Interface - ajax-0d8ea36c
In-Reply-To: <20180703075009.GA27649@kroah.com>
References: <20180703070413.28756-1-andrew@aj.id.au>
 <20180703070413.28756-2-andrew@aj.id.au>
 <20180703075009.GA27649@kroah.com>
Subject: Re: [RFC PATCH 1/4] dts: misc: Add bindings documentation for
 bmc-misc-ctrl
Date:   Wed, 04 Jul 2018 15:58:31 +0930
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Tue, 3 Jul 2018, at 17:20, Greg KH wrote:
> On Tue, Jul 03, 2018 at 05:04:10PM +1000, Andrew Jeffery wrote:
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > ---
> 
> I can't take patches without any changelog text at all :(
> 

I wasn't expecting you to put them into your tree - the general concept/implementation is still too immature for that, let alone the commit messages :) However, I'll address this before sending another spin of the patches.

Sorry for the noise and thanks for the quick response.

Andrew
