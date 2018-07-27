Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADECC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 23:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 854B320647
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 23:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fosne1aG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 854B320647
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388922AbeG1AjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 20:39:13 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:38623 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388660AbeG1AjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 20:39:13 -0400
Received: by mail-oi0-f65.google.com with SMTP id v8-v6so11868201oie.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 16:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R3TvEBkiClcrYllBRC+rEaB41bTFLPUZ6g+nqgIiF1Q=;
        b=fosne1aGDR2HV3BihBk2K5+PwFg/yh52cDxMpmxg+jCpaYpgIIljn4GD/VhYoyA+bQ
         X2yKxVOdzl3Y5f1oB0r4qNsMNXramwLrjUzD9cohoQjnXIy02N3smtJUG8Jhm+rYu/Hy
         nZ/EWxCx7vm/bNvxpqoOMBJPJkOj2IaYPNiGMWCzoRfd5lR5YjzDiCUHub2QGNY/51jm
         0vMUch/z/wz0PhnS0kgeWBpQks4Oe5bAV6zGLXE/JTN1L0fgB1Bg/Sab0/1WAbOc+GKY
         UNKnvjBGvs39Uxt2bVOgm/Eg85AIEk+6X+2DQ45xyjVfRgczPmC1Bgo/Z/MqEthzI8Y+
         PFtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R3TvEBkiClcrYllBRC+rEaB41bTFLPUZ6g+nqgIiF1Q=;
        b=uHXYjQ2J4udFiJhOxfxHflQDaIdaB/7gAl0lm1WAZRr2IxH1gzRfsG6MX3ROvM1z0B
         8gk0N8cq/s8W/PYUoJUVh+qhmmgzaRHdM9PTiRmkWzidoZvMQnXUUzdcAmVKsVqQnDdO
         v8PsH/3yUlRsWs9vWaBZNaqVAbR5bokawfc2vTsM4qmyu0CxFGZ0IAX+9NR4MMdrVQHX
         O24VINNklGG97LgxOZtg2oW/+1ZE/60YZtUStyRRRj4r9iJHhttJhGpgZIF3jM7EKLmz
         E2Cmy5R4WXi3WSIx++s4InAWdon+BsuZILmx2NDvDehXde1QH1JEFV2KMo9R9UaXzSUI
         4dzQ==
X-Gm-Message-State: AOUpUlF9m9IB1V95IoORIrs7bqnNNGcpjTsM4rn0AMu9yeOGtnvoGZZ3
        toK8lKgojQbUhtKUjq/HlFjyo5WKx2XLa9gyav4ZWA==
X-Google-Smtp-Source: AAOMgpeLR4cUI3qtHNDgwHJTJzvR/fNRlNQJsR5gLdPox9Bmu4NHByAFSeJnzwhlJ/YIvgNqxapG+8/uHcWptESsat8=
X-Received: by 2002:aca:fc94:: with SMTP id a142-v6mr8035496oii.29.1532733307320;
 Fri, 27 Jul 2018 16:15:07 -0700 (PDT)
MIME-Version: 1.0
References: <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk>
 <153271291017.9458.7827028432894772673.stgit@warthog.procyon.org.uk>
In-Reply-To: <153271291017.9458.7827028432894772673.stgit@warthog.procyon.org.uk>
From:   Jann Horn <jannh@google.com>
Date:   Sat, 28 Jul 2018 01:14:40 +0200
Message-ID: <CAG48ez0SdSPkimsk-MW7oSQO-Y64X-LD4JXnuPsZXKuz=y1_Kg@mail.gmail.com>
Subject: Re: [PATCH 34/38] vfs: syscall: Add fsinfo() to query filesystem
 information [ver #10]
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 7:36 PM David Howells <dhowells@redhat.com> wrote:
>
> Add a system call to allow filesystem information to be queried.  A request
> value can be given to indicate the desired attribute.  Support is provided
> for enumerating multi-value attributes.
[...]
> +static int fsinfo_generic_ids(struct dentry *dentry,
> +                             struct fsinfo_ids *p)
> +{
[...]
> +       strcpy(p->f_fs_name, dentry->d_sb->s_type->name);

Can you use strlcpy() instead? From a quick look, I don't see anything
that actually limits the size of filesystem names, even though
everything in-kernel probably fits into the 16 bytes you've allocated
for the name.

[...]
> +static int fsinfo_generic_name_encoding(struct dentry *dentry, char *buf)
> +{
> +       static const char encoding[] = "utf8";
> +
> +       if (buf)
> +               memcpy(buf, encoding, sizeof(encoding) - 1);
> +       return sizeof(encoding) - 1;
> +}

Is this meant to be "encoding to be used by userspace" or "encoding of
on-disk filenames"? If the former: That's always utf8, right? Are
there any plans to create filesystems that behave differently? If the
latter: This is wrong for e.g. a vfat mount that uses a codepage,
right? Should the default in that case not be "I don't know"?
