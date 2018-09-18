Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE1EC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD66021471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="hECrc/DX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lti/NopC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD66021471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbeIRNHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 09:07:36 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:44301 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729147AbeIRNHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 09:07:36 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 3F35021C48;
        Tue, 18 Sep 2018 03:36:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 18 Sep 2018 03:36:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=6eZXh48KsgjguqWNJja+Ky/BDj4RhSTiWvNicU3oWok=; b=hECrc/DX
        4nzYFUHz/LlCi+3mehe5ZSiJaEMwz6pNOzzeZPKPhyjJoPnwwAOtLovRpJf50vFm
        VF18HTebU7ucI63bDX3jae6xxzwGWf3h4LTlMr/bxToJiNptzNLi0Q9y/jNeELeV
        8kU9grmJagZg6pJ05F2d4iRq9B9VZkII1erOxt8cido426uX9kAMpQ/dKGw/F9A6
        RlR7fUnOuhhEaYRg+0gD7uGBYs1xygtn4RG/Ry3G8RuKk60NDjVffPd8crtKz9Ht
        Ze4hoT2z5T9nArUGqazoAeb61mZdrpUQ5e0HI0ngCBc5sMFc35WhkGOSz0n8vlB3
        icPhwWDTfQYy/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=6eZXh48KsgjguqWNJja+Ky/BDj4Rh
        STiWvNicU3oWok=; b=Lti/NopCL81bekbkFnj6SGmvnvI5Y65XoFlZQIDrqyKt7
        d9O4Ix+o5EauLvQoCXNX75h657ghKkkZU4zFiXM65RMcGgpI+BWuGKlNdkGp/+2A
        8nlTuugeAWlrEAltguWCpkqbCspHzYPU3ZWwc+Ku/jENEycJWzIqGxvfLj6U1I8n
        JMI+wWRCzgMb9BL6pxE7RHzPnQOZBTrLCmx+H88t/qQpt0M2bwOUU9vqsf6sky7w
        zhRnMOOXATNTQqXsgcKt6EJrnm64iGTbjjPaqtGqXcGxn9c1zuLkO6CxXJ1y5xQ+
        /Gt7DFaCHvm8hGHrIm1Ugk4UHQS1AwXoiFxh6xD9Q==
X-ME-Proxy: <xmx:7qqgW2IogrYus3C1Ux7x_90V7cZDsZAMEf7iNG16xh0ykapVhMs-Mg>
    <xmx:7qqgW-UzVBCuZj39WI9N2ltV9h4BzX5GSlhjZ_rPzaclNymXyOnSxA>
    <xmx:7qqgW4gfcC91fOeIvRLxvndKO1kAzSIrBUzWIuIG_jBYwnT4WrEejg>
    <xmx:7qqgW58aONowXfAnlCVtQR9YUZQ02fhopve-LG8uqt6B_yXMAyMPBA>
    <xmx:7qqgWyAb-lsvNd3c8bJQna6iBjZHNSYkUBkMdjPvE_zIbzYGfTglWQ>
    <xmx:76qgW8ScggIQXAympDwRek4fTByP7Q9DwyAdOn_M8JBR_EOJucYkqA>
X-ME-Sender: <xms:7qqgW630nRt1HAnuzCPR5seitWsMtD11DCjXyzDR2YeCmMyYoiXUoQ>
Received: from localhost (unknown [147.67.4.98])
        by mail.messagingengine.com (Postfix) with ESMTPA id C5AC1E454E;
        Tue, 18 Sep 2018 03:36:13 -0400 (EDT)
Date:   Tue, 18 Sep 2018 09:30:21 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Nicolas Ferre <nicolas.ferre@atmel.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>
Subject: Re: linux-next: manual merge of the staging tree with the at91 tree
Message-ID: <20180918073020.GB4067@kroah.com>
References: <20180918131238.2838bedd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918131238.2838bedd@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 01:12:38PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the staging tree got a conflict in:
> 
>   MAINTAINERS
> 
> between commit:
> 
>   5ae2f1f30197 ("MAINTAINERS: move former ATMEL entries to proper MICROCHIP locatioat91n")
> 
> from the at91 tree and commit:
> 
>   010de20412fc ("MAINTAINERS: Add entry for mcp3911 ADC driver")
> 
> from the staging tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Looks good to me.

greg k-h
