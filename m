Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E98FEC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 09:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8D2021479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 09:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="EQx4p2yE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MexzRYcW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8D2021479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbeJIQev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 12:34:51 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:48717 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725927AbeJIQev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 12:34:51 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 1DD5C22131;
        Tue,  9 Oct 2018 05:18:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 09 Oct 2018 05:18:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=yvcDF3gpaIc8zcTjVViadgwF3s3
        4pBUXefBpEo4YTlk=; b=EQx4p2yEwcAkPYUu2I19F8P6tmavMkbBuVbfno+Mzfw
        Sz7XoKKt6IoUnxYHd5KY9bEeMNP+iYfMsFxJvBwN/bPMy89Lfh5qjLi1qFoJdtvP
        JQIHtZLrga4qybwjUY3i33DYcmK1O8eEb2wtyUnKhl0/y9CL7mbkWnsBseKQLQCN
        fxxE1ptDWrb+TkZSqE+MUWDIoOsx3stoQ6gsfef5feeYE81AKE3oD+WYdCQhYHTE
        Sgat6++1Q6UOshlAYBj2kNCsgXV+lTzsgXeOHA1BioqWGZKjA/nU+M4pvUW1WuQD
        ZQuxylAounmgGogeLyC7qvLBMrEkHi8ndE1n2Em3rNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=yvcDF3
        gpaIc8zcTjVViadgwF3s34pBUXefBpEo4YTlk=; b=MexzRYcWjuR+7DdXr6DnUb
        nw9XliizVJM/fES/aDFWa68Bdga/+lJeQMIabtP7LnnO+Uc4YAjm7Owxr5Tb0YsT
        q0L4pEh5cRptH/DcMcL1SmfiJ1Jp3PLRXDFUDqEmywLSRP/r2bJAA39AkvoAcuo3
        YtRn046SdjgHRTWZg1HcnJlKwtOlQ2gMDrXoQ9xtosxpupEiTpQEcnhCkis1s1sU
        F12MEK5ttb6q5mcIalL5URN5IUkMRFzgQGdrBkUJMuUmxjgf/b4zWX++M/NNuxLv
        ll8wTgjvoySU1MtDhiEngYtTrE3G2iF9z2JxokiCJUCYj73JqvYfIwQyHJA4LF5A
        ==
X-ME-Sender: <xms:fXK8W2vBGtNYsVmmwx0l7AXwtyVenR2EagjokbPSuOswsxbYFX7hyA>
X-ME-Proxy: <xmx:fXK8WwBDbrgVJh-A8ETqpNUeDiV3GE4vtWvL9wnA9oIof8gYwiXABg>
    <xmx:fXK8Wyt9bY9ufVduDwoXEvEWSABclakmjqUD0vm2Aaa5mlp3TPVPRA>
    <xmx:fXK8W1Y2kUVnSMeH0mTr-0ua0Oe4xB_jTikGscaq-VCJ-_5w3ReyiQ>
    <xmx:fXK8W1Xks6riDuOKyYEt-3RE8CB8bl2iMCS29QvsUArcggkaeCS9Og>
    <xmx:fXK8W56BsB-mMW0K2IOsqS8G4mDYd8R6Y2Y0yeyGMSSdHVeO5R4APg>
    <xmx:fnK8W_lFKI-N16OeL4a15zbNQC6UFCwn2SYcdemIsVQaX3R-DCs3Yw>
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0F0C8102EB;
        Tue,  9 Oct 2018 05:18:52 -0400 (EDT)
Date:   Tue, 9 Oct 2018 11:18:52 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the staging tree with the vfs tree
Message-ID: <20181009091851.GB19241@kroah.com>
References: <20181009155945.1b66ee78@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181009155945.1b66ee78@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 03:59:45PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the staging tree got a conflict in:
> 
>   drivers/staging/dgnc/dgnc_tty.c
> 
> between commits:
> 
>   b68166ef8fd9 ("dgnc: leave TIOC[GS]SOFTCAR to ldisc")
>   e002c6f1ccb9 ("dgnc: don't bother with (empty) stub for TCXONC")
>   79273fc94ee9 ("dgnc: break-related ioctls won't reach ->ioctl()")
>   246d394c9cc5 ("dgnc: TIOCM... won't reach ->ioctl()")
> 
> from the vfs tree and commit:
> 
>   3268357865d6 ("staging: dgnc: delete the driver")
> 
> from the staging tree.
> 
> I fixed it up (I just removed the file) and can carry the fix as
> necessary.

Removing the file is correct, thanks.

greg k-h
