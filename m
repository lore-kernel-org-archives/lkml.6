Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC720C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 09:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A375C2082D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 09:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="JCzq0RTD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oFIVYeF7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A375C2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbeJZR6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 13:58:37 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:53655 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725914AbeJZR6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 13:58:37 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id E763021FC9;
        Fri, 26 Oct 2018 05:22:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 26 Oct 2018 05:22:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=MWTuqLtPdX+q4391VmqgsX/aQft
        OCnSfYfi1iSCSuE0=; b=JCzq0RTDQ9ocGYnG7lEeEn3PnzchOIQu1DDEAh8/d5S
        IHD5mvUJ/q5SldbMGd9HfjW/5B5mQj9t46U7wFRcfmkND8Q5lklB5skBaPcd21s9
        Dof5JeQ1mI22gNKkGTfpdFXffkP8xiBQfQt/hWsIck/D5XpeUS4Sb9jvO+4DkuUR
        RXa82GIjJh1gl9Yct+R+Pkj2LoVhMTc0hzPZCTSAZFXEbKltCuUxzHB8+3WMs6+h
        LExP54wnxgtqqepLCdRE9bphUlsU2RnKFSWhLPhXH6enwgs1in/v6vYGR4+HsQds
        pmjQ7x2Qpbg7M9Fz0a7LwwLrggdq4usTsravnNuCh/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=MWTuqL
        tPdX+q4391VmqgsX/aQftOCnSfYfi1iSCSuE0=; b=oFIVYeF7F0YPC9pc6u6lOD
        hU0JCYSlxjemIPcp2Yb0dZWr3uEokt+/Rn+ubeTMWOpwiAGm5HqFdnWo4NrSxhFX
        KzXUiNSwzbhXwWlwT/f+45PQwZugXblAzSge50ui/7ubwv3HLIn6sejI0JOiGk06
        dwbPXEQ40zTiVWpLMHfmwRJ7gKqB07mk6EDveZKCev+ADraCRWGfqZISJ9iUEcFR
        xblbTn08yFPMIHeo7xzSffuuuZBhfaChkAAkmp0vbvMKB3P2Foh7dKYtA3CxYp0A
        B4XsMDTUWnUD07r0yMT/wEBIwp5/IEqSfrhRA41KPPxKusjTzGTP39ctl9Y+VCzg
        ==
X-ME-Sender: <xms:yNzSWwz2wiFIEQVwWFch5mmNydgKjgszHlG7ifUN4PRmRaVhTnQojg>
X-ME-Proxy: <xmx:yNzSW5MdKo1vVA62Q5okqGXc0roPRZpIEWzx22NQH8dnVZRpVIn5ww>
    <xmx:yNzSW0P0gR1hBtgZK_98X5xKNDpsY-drCTpcfjWZNxBnEtrDYSFYfg>
    <xmx:yNzSW-KCapdxAVEimOBGMcqgE3KRI7QSNxJ3CZRA86cScxFMlkMHzw>
    <xmx:yNzSW3bioknjmQf4nF8JE_Xs3dGJU4P0g3dxRPsHd0CNpiIQrWOI_g>
    <xmx:yNzSW3J0YE2geyK_who9w9OLq9ntlovLQEQ1kfCC3sSUB2WmI3WnPQ>
    <xmx:yNzSWy0OJBd6H4-cQ2udss8_-4yAblttoBFfzkBB-JIt3CfXqdKrKg>
Received: from localhost (unknown [80.169.156.100])
        by mail.messagingengine.com (Postfix) with ESMTPA id CB3D5102E8;
        Fri, 26 Oct 2018 05:22:15 -0400 (EDT)
Date:   Fri, 26 Oct 2018 10:22:14 +0100
From:   Greg KH <greg@kroah.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH AUTOSEL 4.14 02/15] s390/hibernate: fix error handling
 when suspend cpu != resume cpu
Message-ID: <20181026092214.GA4307@kroah.com>
References: <20181022102026.40869-1-sashal@kernel.org>
 <20181022102026.40869-2-sashal@kernel.org>
 <20181026090543.GC20200@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181026090543.GC20200@amd>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 11:05:43AM +0200, Pavel Machek wrote:
> On Mon 2018-10-22 06:20:13, Sasha Levin wrote:
> > From: Gerald Schaefer <gerald.schaefer@de.ibm.com>
> > 
> > [ Upstream commit 55a5542a546238354d1f209f794414168cf8c71d ]
> > 
> > The resume code checks if the resume cpu is the same as the suspend cpu.
> > If not, and if it is also not possible to switch to the suspend cpu, an
> > error message should be printed and the resume process should be stopped
> > by loading a disabled wait psw.
> > 
> > The current logic is broken in multiple ways, the message is never printed,
> > and the disabled wait psw never loaded because the kernel panics before that:
> > - sam31 and SIGP_SET_ARCHITECTURE to ESA mode is wrong, this will break
> >   on the first 64bit instruction in sclp_early_printk().
> > - The init stack should be used, but the stack pointer is not set up correctly
> >   (missing aghi %r15,-STACK_FRAME_OVERHEAD).
> > - __sclp_early_printk() checks the sclp_init_state. If it is not
> >   sclp_init_state_uninitialized, it simply returns w/o printing anything.
> >   In the resumed kernel however, sclp_init_state will never be uninitialized.
> 
> Stable patches should fix one bug, and one bug only.

So should upstream patches, but the rule of "stable patches match
upstream identically" overrules this :)
