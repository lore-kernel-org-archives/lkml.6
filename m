Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 953D1ECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17B6E21550
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="Xo8oXul2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17B6E21550
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390415AbeIUVo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 17:44:28 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35870 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727392AbeIUVo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 17:44:28 -0400
Received: by mail-ed1-f65.google.com with SMTP id f4-v6so11145674edq.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 08:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IKV/x/rx2wjMX+5R6wR2+HFjgK3BozrIdSFsVbF74s4=;
        b=Xo8oXul25cmedb5yuej1t8ZFXbdvrletMXIkrdtwQtvs9gQneHzOOS2d4znZ2XgGf3
         77wtRNQw60gK+JY0aXRB14LN69YoJlDnbbxukVhxb+Sd95yM8QxcP/oUITN3i9Cnwr8g
         kW4PWMTNYwELf7ZUD1/QcxIcS84N5UkPG0CeASRjGZbHy+nqjiXqHUe0LnyDoOPB0iWp
         SQiFP/c6ZGRH7QKLCeoOWpBm5f7V6e0BpafDc5WyvYD0fiV8J1EVsUwXl3AmQ4KBY6ue
         UgSENLt7TxGobi5Cm3GZH2C2tTN+3zi2JSSb3ExQwPrcDbUZUI+Td1bmbrGopnoELc1p
         L+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IKV/x/rx2wjMX+5R6wR2+HFjgK3BozrIdSFsVbF74s4=;
        b=P6uX3/dSm8blL5h+Bl46ORFaes0FB0l01qa98H1fBp+vk6IG0BjulnEdLC54NH9b6r
         xlpNiIlAwpXy4dWi6eHBmG9FpjELp6UV3R0iijeuFUX1pMWH3G8aSV4msjqu9PkjqzZo
         ec6C9C6Kkmcw9Jaqm4wbzi9Gl7m4YWapoGI6DV4CNWF5BUDmNlp+BY/8BpA1pyWtj1hu
         JfBEfUfhWoRfqSKPPmnR8w/9U3WxcR9VDgQfwQj3HvX8Pi6mv/IXjtXLnAoCebqsNFhb
         0FrqIdXo9LTg0DZ+65qguMT+6Rr6KWMoR6yOdVuCsVc8LysvY5UpdXYUpcZoPlMfRp4W
         WXIQ==
X-Gm-Message-State: APzg51C568+u0+HXtcutgeUhClenl4rRRUaT+28qsKATE6aDaCSTUi/s
        s8uuwkdVg6o7arDji+spV4gXqXrCIZT4Sw==
X-Google-Smtp-Source: ANB0VdYHk6Gx31sj1FwBZuHTB1fygm8KgmDE3W8TTFosNXZdn02PLng1yjTwZ48Gep9lv73NhlUalw==
X-Received: by 2002:a50:eb96:: with SMTP id y22-v6mr12333786edr.38.1537545297565;
        Fri, 21 Sep 2018 08:54:57 -0700 (PDT)
Received: from brauner.io (84-199-88-155.iFiber.telenet-ops.be. [84.199.88.155])
        by smtp.gmail.com with ESMTPSA id w2-v6sm2458771edw.83.2018.09.21.08.54.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 08:54:56 -0700 (PDT)
Date:   Fri, 21 Sep 2018 17:54:56 +0200
From:   Christian Brauner <christian@brauner.io>
To:     David Howells <dhowells@redhat.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] fsmount: do not use legacy MS_ flags
Message-ID: <20180921155455.flkf5vdrm3vgn6do@brauner.io>
References: <20180920151214.15484-6-mszeredi@redhat.com>
 <20180920151214.15484-1-mszeredi@redhat.com>
 <17157.1537542475@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <17157.1537542475@warthog.procyon.org.uk>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 04:07:55PM +0100, David Howells wrote:
> Miklos Szeredi <mszeredi@redhat.com> wrote:
> 
> > What happens if we introduce new flags for fsmount(2) and are already out
> > of flags for mount(2)?  I see a big mess that way.
> > 
> > So let's instead start a clean new set, to be used in the new API.

If I may chime in. I think this is a really good idea.

> 
> If we must.  But let's not call them just M_* please.  Let's call them
> MOUNT_ATTR_* or something.
> 
> > The MS_RELATIME flag was accepted but ignored.  Simply leave this out of
> > the new set, since "relatime" is the default.
> 
> Can we make RELATIME, STRICTATIME and NOATIME an enum rather than individual
> flags?
> 
> 	#define MOUNT_ATTR_RDONLY	0x01
> 	#define MOUNT_ATTR_NOSUID	0x02
> 	#define MOUNT_ATTR_NODEV	0x04
> 	#define MOUNT_ATTR_NOEXEC	0x08
> 	#define MOUNT_ATTR_RELATIME	0x00
> 	#define MOUNT_ATTR_NOATIME	0x10
> 	#define MOUNT_ATTR_STRICTATIME	0x20
> 	#define MOUNT_ATTR_ATIME_MASK	0x30
> 	#define MOUNT_ATTR_NODIRATIME	0x40
> 
> We can also use these for a mount_setattr() syscall:

So a - maybe stupid - question I had when recently working on a patch
was how to add new mount properties in the new api.
What I would expect is that once the new mount API has landed the old
mount() syscall should not see any new features added since I take it
that we want userspace to very slowly over time have sufficient
incentive to only use the new mount API.

So from reading the patch I got the impression that superblock mount
options passed via fsconfig() are passed as strings like "ro" and are
translated into approriate objects (e.g. flags etc.) by the kernel. That
seems like a future proof mechanism to extend mount options for
userspace without having to worry about exceeding any integer types in
the future. Maybe this would make sense for non-superblock options as
well? I can see that this is less performant that checking flags and
string parsing is a thing that is not particularly nice but it would be
one option to solve the running out of flags problem.

> 
> 	mount_setattr(int dfd, const char *path, unsigned int atflags,
> 		      unsigned int attr_values,
> 		      unsigned int attr_mask);

If we go with the flag arguments wouldn't it make sense to use a larger
integer type?

> 
> where atflags can potentially include AT_RECURSIVE.

Very much in favor of having this operate recursively!

Christian
