Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E08C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 01:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D83724011
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 01:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="OUpGL5s1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JGVdCdgE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D83724011
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=themaw.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753924AbeGFBJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 21:09:00 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:57259 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753900AbeGFBI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 21:08:58 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id B35A321F27;
        Thu,  5 Jul 2018 21:08:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 05 Jul 2018 21:08:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=osgjEHQIkXfjfeLid5BeMiyRD1Xm/
        RRhQgZ4ngn9hsQ=; b=OUpGL5s1vbnL1FECaTJ3qkVNbA77zwRdjA0nEv8CEwyrm
        Ir3g6zfO1X3KPst0PIxZolMNCLo3aKjDcBC2HL1BVIhV2mjCUczCDyVXLq7sNtf5
        8sSkVPfrd0atmQJ69t07Elk6NEDN7wogqSfSXC7m07GqidUYq1pNiWiGjeNGTP1v
        /n1YwL+9SWlCvQxKxevxFnIL3QN+I/NI20iwiUCJO3QkT2XVNgk3Cq3tajAjVLHw
        lrf8vcQZRGNaAqCm9DrvU1EtiT/375YilvYHhslKXcZKhHjmR67ELFzgqSb6u1zq
        gN9BpqRFlh/8bqWz6eb091AHlGDXXvm33pQSVbUqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=osgjEH
        QIkXfjfeLid5BeMiyRD1Xm/RRhQgZ4ngn9hsQ=; b=JGVdCdgELUNnYzyPF/jBKj
        9YKLkw//O7u5lt46sogDNYe4eg86Xzgjt+vE+Q8T1GGEV3Noxf/LFqp/0wOhyi3I
        zdPtrJlbPKynOYyptCvBWxi1RjTIGJeauD3HVOaTCtipiJdftx+qicn9xdjd/vV2
        ZzLpZN581ikt2DaTQ2sulfFllu2NdBuN1cpKULHdrl3UOicQvfP7FWTXjHQkD7FA
        wJsD0Pc/HLPdL+ljf3S4uII+001vj6KvDDzsL5c/7Z9rqKCyXMkUAs1A+ahWKn1H
        rxeEAIl41PYMmDTgKpPv16rw3rnD5KYdmKbLeVNoyP3upugVMYa7wP5zN1V8FQZQ
        ==
X-ME-Proxy: <xmx:KcE-W1z5JhPJ6XSVdpTIv9hFnRSKVimlkpQTLjkn6SDp9PEIOlA7Ng>
    <xmx:KcE-W8CjeISP_WHU9aODfqqkkLi4liNpjoHpRtYlPC3MG7eQ2eLGLg>
    <xmx:KcE-W22STRK5NXmwHQ6YhhzN3Hv_GS6yLhcvLo71PWWRPPA_w7vuWQ>
    <xmx:KcE-W1vq82kOz-QRLwr9u02ZCP5jorzfdtSG2tC2nWMvPN6EMWAUUw>
    <xmx:KcE-W_60nBhX2j2bcXdJWwlIvzhReg2261CESGq3NWPqWPECivniyQ>
    <xmx:KcE-W0gn8K1XXaWEJLetdRhTIUdkN_StFPLDdIR-GyLAKwHhekxDUw>
X-ME-Sender: <xms:KcE-W7nraKOTQAjUC1yOyMma7imAb0LgChnjZktKxi356uVjgYUc9g>
Received: from localhost (unknown [121.44.171.84])
        by mail.messagingengine.com (Postfix) with ESMTPA id 52B50E405A;
        Thu,  5 Jul 2018 21:08:46 -0400 (EDT)
Message-ID: <1530839316.2940.5.camel@themaw.net>
Subject: Re: [PATCH] autofs - fix slab out of bounds read in getname_kernel()
From:   Ian Kent <raven@themaw.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Tomas Bortoli <tomasbortoli@gmail.com>,
        autofs mailing list <autofs@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 06 Jul 2018 09:08:36 +0800
In-Reply-To: <20180705165842.856d66594bf695f4f688ccfa@linux-foundation.org>
References: <153060031527.26631.18306637892746301555.stgit@pluto.themaw.net>
         <20180705165842.856d66594bf695f4f688ccfa@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-07-05 at 16:58 -0700, Andrew Morton wrote:
> On Tue, 03 Jul 2018 14:45:15 +0800 Ian Kent <raven@themaw.net> wrote:
> 
> > Initial patch contributed by Tomas Bortoli.
> > 
> > The autofs subsystem does not check that the "path" parameter is
> > present for all cases where it is required when it is passed in
> > via the "param" struct.
> > 
> > In particular it isn't checked for the AUTOFS_DEV_IOCTL_OPENMOUNT_CMD
> > ioctl command.
> > 
> > To solve it, modify validate_dev_ioctl() function to check that a
> > path has been provided for ioctl commands that require it.
> > 
> > Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
> > Signed-off-by: Ian Kent <raven@themaw.net>
> > Reported-by: syzbot+60c837b428dc84e83a93@syzkaller.appspotmail.com
> 
> So who is the primary author of this?  I'm assuming "Tomas" from the
> signoff order?

Yes, Tomas was the originator but I did change it somewhat so added
my Signed-off-by as well.

> 
> The way of signifying this is to put the other author's From: line right
> at the top of changelog.

Oh, ok, will do in future, although my changes were fairly significant.

IMHO it was a joint effort more or less equal by both of us.
Nevertheless I would have been happy to list Tomas as the From author.

> 
> I assume this is a root-only bug, so we don't need to backport the fix?

It is, so yes that's right, unless Tomas has other recommendations.

Ian
