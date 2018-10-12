Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8582C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 812332086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QtVmnNEo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 812332086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbeJLSXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 14:23:21 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:45403 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726664AbeJLSXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 14:23:21 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 055F52204F;
        Fri, 12 Oct 2018 06:51:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 12 Oct 2018 06:51:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=78rBah
        5v3yoL+MxomNQAXjpHNTxVRrq+hNBPSgMJEN0=; b=QtVmnNEoXRO+yImyUe4CCm
        QC0riP9VDt0vWirfj4gebUqj7HrG6vabR9muUifAV9957oYO39sESbqE5niVSSi+
        j1gqjMQWWiDK3SQ7tqkSwxs/F5b+dqv/1fP8699aNu1T9MaBbfzP7CKL3IYF9BV9
        eO4UV52PDDTlZzCZK7Vq/teLXaRc3s5H7P4c2WB7wnFpd7EcBBGQeK5zXErriCGj
        7G5CdBPxgSfPrM32mx3BVekLiTFS0KqTEo03wj1jx42q+VY4ZDEZ1pX4Bf/+qKzK
        gPbTYqB8axmsP95RpMxQKZ/0Yqtp9QQJwixv8QsRi/21UdkLt2pyy7F11wwMvsXg
        ==
X-ME-Sender: <xms:r3zAWxYwI6mWPo_kVKERvBoiXaLxJYbOd0P79035YFhS1kC0zp74nA>
X-ME-Proxy: <xmx:r3zAW8RZ6Tj5Ub1iIlry2UvfrZNcZ-yscgUzWTNv7zB97nQ4N08nUA>
    <xmx:r3zAW_nnV8oAFnl2IKN2Rum7GU_D2uiOdgHwws_8zpdeGaNI8FBMCQ>
    <xmx:r3zAW76Q1Q6T9aKi2FEOHyz6olD_VGZZaTAeKnadETl8QquilzbuNg>
    <xmx:r3zAW4lrwlbCLfFpkKZi76nDATufdmox7h0HbrxtyVDlzCfr8f352w>
    <xmx:r3zAW0rvXvC8oqTb4O8x25OwPlt77igp_YjA_ZpHG84t9UHaNB_7mA>
    <xmx:sXzAWw9yMl6oJhcAvMNwwXSjO527C1PGnG_kgaBQC_Oy56DoLJvo3Q>
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        by mail.messagingengine.com (Postfix) with ESMTPA id 572AE102D7;
        Fri, 12 Oct 2018 06:51:27 -0400 (EDT)
Date:   Fri, 12 Oct 2018 12:51:26 +0200
From:   Greg KH <gregkh@linux-foundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] A couple of warning fixes
Message-ID: <20181012105126.GA19643@kroah.com>
References: <20180826171058.e07f99e6e03f7497e5a46ed3@kernel.org>
 <20180828072333.36af4d5d@canb.auug.org.au>
 <20180828094341.d20d8fbcb9dca310d44df951@kernel.org>
 <f0ca0036-abe1-4252-6d30-b810dd22097d@linux.ibm.com>
 <20181011114809.5590ecb3@canb.auug.org.au>
 <d5b166d6-461c-f382-e3d2-8993b845bd5a@linux.ibm.com>
 <20181011205849.6f6645fa@canb.auug.org.au>
 <20181011103750.GA29735@kroah.com>
 <CAK8P3a3DTbcSgOEqt-zAsX9DpVSOmS6apYXXkRHK2FKc5mvW2Q@mail.gmail.com>
 <20181012091246.05e8d4ef@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012091246.05e8d4ef@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 09:12:46AM +1100, Stephen Rothwell wrote:
> Hi Greg,
> 
> [Hopefully you and others don't mind fetching these from me directly.]
> [My first pull request, let me know if I did something wrong.]
> 
> The following changes since commit 0778a9f2dd924c3af41971ba40eec44793aea531:
> 
>   Merge branch 'for-4.19-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup (2018-10-11 19:24:01 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/sfr/next-fixes.git tags/next-fixes-20181012

Now merged, thanks.

greg k-h
