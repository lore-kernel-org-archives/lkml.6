Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99E0C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 05:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AB122083A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 05:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="yb2dr4YI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GBR3hlGh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AB122083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbeJRNzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 09:55:05 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:36993 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727328AbeJRNzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 09:55:05 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id C26DEADC;
        Thu, 18 Oct 2018 01:55:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 18 Oct 2018 01:55:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=/gmtANx+g6D4uBk1nSO7ny8MYo9
        /xJFoSjbtfB7b2uM=; b=yb2dr4YIN8BBqTzFs+PoFVIboqNAT1bNV57gMi0pbsD
        up7DtBG2O4b+dl+JLunlShm0tkoIhwdbZCFJJAytombcNybmSzDNZgDpMvlPRARE
        LUxaGGmv/gC/OoKl8/EApJwEL+Y1cafqpwh7DZRkqCoLa1a7/3lfuJKUpakCiIIt
        smEGLq/otSsIZhflYmUkmuCePUue6eKZ/H5lpYxz+dVYaJ3BeF6pYoFcEgoN2jBa
        QUWcoCFayyYA8A4Rwob0Y0IPC/sixkWuhYZ0KnOPD5OBuebif5t7deN1lF2fWYRo
        cHOhwLkghzsUPq4SOXpAWl9fEr09RianhBk4Hs4Z3/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=/gmtAN
        x+g6D4uBk1nSO7ny8MYo9/xJFoSjbtfB7b2uM=; b=GBR3hlGhrJhWx9bgQxfL1F
        4PG6yO4JLMyNaUsnKFwozLF6Ad5VzUcw7rUbfe4CQkWEoEyntGoz8jD4xSWZa88b
        pT4ZGKIRXjbZEEI7b8HuyjsWf5W33urAr3eCAuKb5b8JyWuQcfuBUjWxKQeCABJJ
        1hSibocH+kwHQ9i24DpPR7Sc/5JwHEmBzh7VqJiWIUc+q5pYvUHobsqLb333Cwuw
        d6YvFbFujk8tC9QU4pO8SlomZkydJ8Ky1b75eez2LiyD++/CS0RkwdfZAcncsQjT
        VcBce/hIZDIjWhF2su4m+67SndUrN+o28y/2ClDNMyRKj60v/ifdBgWXa/L/Fu9w
        ==
X-ME-Sender: <xms:YSDIW75aV11AeX0SgQFdwePknBNwiYkV3Ubprh7gdYQdLkkVy3shQw>
X-ME-Proxy: <xmx:YSDIW38CmBQTnzwlUmTEfiP5JfdBkN064el7Py7r8txY6wE5kPVneA>
    <xmx:YSDIWycssZyO_XLe8Lwqh14B2fzyMNgXILZOF1CPAW48SpI-jfKVjg>
    <xmx:YSDIW3OPYdtU1FYIMI-uv1H_PZvvNgZJbZ0dQLNzsw553hwwfjrE3g>
    <xmx:YSDIW3_7MgnbBZ1MO9Kixg3gtBBKCnSvo5YzPgmm-H0-wPTBVQ_Huw>
    <xmx:YSDIWwfZB1EaEKsVEObK9EBE4ubFB7SCf8HJu0gvLWaea_6ILyE-3g>
    <xmx:YSDIW8JoRDeFyfEZONQCcAOWUj-cokGXRxYEGTF31Pv2llG5CKNjXQ>
Received: from localhost (ppp121-44-203-227.bras1.syd2.internode.on.net [121.44.203.227])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7CBAB102E0;
        Thu, 18 Oct 2018 01:55:44 -0400 (EDT)
Date:   Thu, 18 Oct 2018 16:55:38 +1100
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] tty: Remove trailing whitespace
Message-ID: <20181018055538.GO9944@eros>
References: <20181016232130.728-1-tobin@kernel.org>
 <20181016232130.728-3-tobin@kernel.org>
 <20181018051933.GA26505@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181018051933.GA26505@kroah.com>
X-Mailer: Mutt 1.9.4 (2018-02-28)
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 07:19:33AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Oct 17, 2018 at 10:21:25AM +1100, Tobin C. Harding wrote:
> > From: "Tobin C. Harding" <me@tobin.cc>
> > 
> > Currently files under drivers/tty/ contain trailing whitespace.  This is
> > easy to fix and easy to review so lets do it now before we do other
> > kernel-docs cleanups.
> > 
> > Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> 
> This patch is an example of the from and signed-off-by line not
> matching.  Seems like it happened on every-other-one.
> 
> Perhaps your git setup was wrong for when you committed the patches?

Thanks Greg, tunnel vision I only read the first 'From:' header!  I
rekon I must of done some of these patches before I setup git with the
new address.

This has the serendipitous outcome of explaining why people add that
second 'From:' in patches with a different email of their own - I've
always wondered why that was :)

Will fix and re-spin.

thanks,
Tobin.
