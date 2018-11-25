Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A42C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 22:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB21B20855
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 22:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="nSeO3fqg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E/Zl1GBp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB21B20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=themaw.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbeKZJt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 04:49:59 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:54303 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726025AbeKZJt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 04:49:59 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 3DA2C244CB;
        Sun, 25 Nov 2018 17:57:46 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sun, 25 Nov 2018 17:57:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
        0fRQlfy9jPRt2U3ba3ZoWMzPERVH4t84BYRp/3qP9iM=; b=nSeO3fqgWdelbS32
        NVHv++5P2FLUE6kFvVQ27N7d7h4VqIt8QfpqZjNimQq7gzEE2yt9jTRVaQ8WIKgm
        pEQaOFBLYK3MG2fbqPpa2NnJRkxYYNvY6k6/OmaeoEyyfh/2Bn+EWX44BmANe4m6
        wpBUYnXLxYe2q2Wh7ULKpXIEZm0yphsJ2ZrcIhKob3kiNW5lwxG54QyuRFcXaN7a
        Z2q1Fv7w0EIjDve9h9sOLYFQI41XsgHBaPCXnTcks/DHjd3Sv+S0hFNKybGf3q5V
        aoclTfHIuywesNPd470hG8RsCVSKD5YRxI/EeTSKEpObVC8ocqK0OVqNSIYLxd2h
        d3QmAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=0fRQlfy9jPRt2U3ba3ZoWMzPERVH4t84BYRp/3qP9
        iM=; b=E/Zl1GBpITQc1ltnn1zbRdzdUgPAQ01fqg9crrer2MQOQxhyrqAVMvTT+
        EtGq7Zvypopxl+kyV5btP6l6Dhczq2KSSiz4pS+770nHpFftO8TUABq/XX65N85R
        4Kx1s0dAgWMoHmJXNzorj/kCbLYWeffNLKACLdyNwvmhrThGWZRlrOyCnLrAjPsM
        1NOYjaUrSgnUUO+rNSCLa9u6LkSg52S23I1ouZSi37fgKqmls1Gx/dP8EtEHFD/l
        sN0Fd3w6D0ZT83SxTfzIfzEuI2z9R3thUiPtC0LumAMDR4/3q2ue7OpH5wWKoV9O
        96bjiDC5dC353kMyoT0clX0VUhPyw==
X-ME-Sender: <xms:6Sj7WwJ9V-SGhGYfHApX-0t0BXTnCb8GnuBQ1310q2Bo__gt_LpjSQ>
X-ME-Proxy: <xmx:6Sj7W7Wu0wNcqZMT7PkTng3atVHWyxeXa_RB0fhLd1rJ38UbJpacUg>
    <xmx:6Sj7W-BLbe4zmeIMWAMKvg-f5uao0Pl4eVweXF89u2Pf044C_7mhfw>
    <xmx:6Sj7W7XSM7HopTFrq6wNM7stfrg5VReYHsEJuW6oVxD6FmvQHBlsjg>
    <xmx:6Sj7W9AuLMnIYBCzralf9ofpPnkmPK7Z_AT1KPx7FpANXPv7K_c_TA>
    <xmx:6Sj7W4V1Bgpyx9MtAcoD-BntWICxZ6NVQyoH82MoVMeGxoAKiFLhpg>
    <xmx:6ij7W-Hmga9yHB9ZBRbeAl5B9q7oZhIr_zJjNf_e8OcslwfjKbySMA>
Received: from localhost (unknown [118.209.163.9])
        by mail.messagingengine.com (Postfix) with ESMTPA id 890E1102DD;
        Sun, 25 Nov 2018 17:57:43 -0500 (EST)
Message-ID: <1550e021bf61b0f3d6d91f342e4546320f385bd5.camel@themaw.net>
Subject: Re: [PATCH v2 1/5] autofs - improve ioctl sbi checks
From:   Ian Kent <raven@themaw.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        autofs mailing list <autofs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 26 Nov 2018 06:57:40 +0800
In-Reply-To: <20181123152922.de3ed41c5b97ac84eaa22846@linux-foundation.org>
References: <154296962626.9889.644199825100770992.stgit@pluto-themaw-net>
         <154296970987.9889.1597442413573683096.stgit@pluto-themaw-net>
         <20181123152922.de3ed41c5b97ac84eaa22846@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-11-23 at 15:29 -0800, Andrew Morton wrote:
> On Fri, 23 Nov 2018 18:41:50 +0800 Ian Kent <raven@themaw.net> wrote:
> 
> > Al Viro made some suggestions to improve the implementation
> > of commit 0633da48f0 "fix autofs_sbi() does not check super
> > block type".
> > 
> > The check is unnessesary in all cases except for ioctl usage
> > so placing the check in the super block accessor function
> > adds a small overhead to the common case where it isn't
> > needed.
> > 
> > So it's sufficient to do this in the ioctl code only.
> > 
> > Also the check in the ioctl code is needlessly complex.
> > 
> > ...
> > 
> > --- a/fs/autofs/dev-ioctl.c
> > +++ b/fs/autofs/dev-ioctl.c
> > @@ -14,6 +14,8 @@
> >  
> >  #include "autofs_i.h"
> >  
> > +extern struct file_system_type autofs_fs_type;
> > +
> >  /*
> >   * This module implements an interface for routing autofs ioctl control
> >   * commands via a miscellaneous device file.
> 
> It's naughty to declare externs in C files, for various reasons.  Is
> this OK?

OK, I understand the reasoning I guess.

The change below is fine.

Thanks, Ian.

> 
> --- a/fs/autofs/autofs_i.h~autofs-improve-ioctl-sbi-checks-fix
> +++ a/fs/autofs/autofs_i.h
> @@ -42,6 +42,8 @@
>  #endif
>  #define pr_fmt(fmt) KBUILD_MODNAME ":pid:%d:%s: " fmt, current->pid, __func__
>  
> +extern struct file_system_type autofs_fs_type;
> +
>  /*
>   * Unified info structure.  This is pointed to by both the dentry and
>   * inode structures.  Each file in the filesystem has an instance of this
> --- a/fs/autofs/dev-ioctl.c~autofs-improve-ioctl-sbi-checks-fix
> +++ a/fs/autofs/dev-ioctl.c
> @@ -14,8 +14,6 @@
>  
>  #include "autofs_i.h"
>  
> -extern struct file_system_type autofs_fs_type;
> -
>  /*
>   * This module implements an interface for routing autofs ioctl control
>   * commands via a miscellaneous device file.
> _
> 

