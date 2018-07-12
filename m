Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F152AECDFAA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 21:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91BB22087C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 21:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BW/ooRkr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91BB22087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733111AbeGLVk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 17:40:58 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:36014 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbeGLVk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 17:40:58 -0400
Received: by mail-it0-f67.google.com with SMTP id j185-v6so8828786ite.1;
        Thu, 12 Jul 2018 14:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hp3wP5HIeaAb1MyubyDQbhJGZ8EMn/j9IYJKly3yMhM=;
        b=BW/ooRkrcSJ68tbGYBNaUcbRRway2zwDtodrEnY3DyK0G56l0wMvbRMWfoQF/8ac2T
         uo05Bni8pYUcqyiaAd6qd8f6skVBSKRxf4cZYEmQpHUXqb5p1RZ57+VbV1l+0h9rtOB3
         2JyQpJPOKcfQfWOSDPVZA5N7NhW1/C9JUCtgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hp3wP5HIeaAb1MyubyDQbhJGZ8EMn/j9IYJKly3yMhM=;
        b=lnMJrasBpO//KXjaPL9XiEedfkBhLNbPgvsf+JlKH2WsIZAlU/GFNsPNWNWMqElHxb
         E0pZPn5Veda8tTm3JaHu9FhkUBaESft2muzcAmXNfIZ9vgTKRbQUXsEVWXxM/s7i1fuF
         J2sJ/TQf3IpIoy4kIc6NvidHpCEIuEA9dC31P0junUfeS/fWVNR++zI1UisrTo2m5ydj
         mgCP3Gy3CLaptW3Va7j7hYq6PY+XYiDmtJx0WP0EOEZejVyKlAz9nBIMHG9ODFbrHQEA
         /JMlOM+q1ztYd6G3dpinhXUeJ6azxWZOEUybtW51jHwZmpZreo7yaak4q/vsmp87X/ry
         dhhQ==
X-Gm-Message-State: AOUpUlHElbHHlCXknfAGWBaGErR4P2qzI1IG09W/+dZDSyW8Bt6DeTcI
        O8X8MrlHZaCcNwICw+xCUGqJakEv937KrnOjIJU=
X-Google-Smtp-Source: AAOMgpcT8qg5ZITuKT80Ij3JxXL2+0v8/IIRVDyptcPnLYhz+U4iI3v/i90igQ+dhZq0qk26LbgDtidUhoQPx1aPQUs=
X-Received: by 2002:a02:702:: with SMTP id f2-v6mr3151427jaf.70.1531430973467;
 Thu, 12 Jul 2018 14:29:33 -0700 (PDT)
MIME-Version: 1.0
References: <CALCETrU3kbh-ZRHDj7-Asq+OH-35dQ2p_erpHpYUvN5+BdAoVQ@mail.gmail.com>
 <153126248868.14533.9751473662727327569.stgit@warthog.procyon.org.uk>
 <153126264966.14533.3388004240803696769.stgit@warthog.procyon.org.uk>
 <686E805C-81F3-43D0-A096-50C644C57EE3@amacapital.net> <22370.1531293761@warthog.procyon.org.uk>
 <7002.1531407244@warthog.procyon.org.uk> <338BC3C4-F3E7-48F0-A82E-2C7295B6640E@amacapital.net>
 <17749.1531429218@warthog.procyon.org.uk>
In-Reply-To: <17749.1531429218@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Jul 2018 14:29:22 -0700
Message-ID: <CA+55aFzaTQJp6aHG_9+W2ShxeZncq7k9G3FkVFjFm7W=ECUiMw@mail.gmail.com>
Subject: Re: [PATCH 24/32] vfs: syscall: Add fsopen() to prepare for
 superblock creation [ver #9]
To:     David Howells <dhowells@redhat.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Andrew Lutomirski <luto@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 2:00 PM David Howells <dhowells@redhat.com> wrote:
>
>
> for example:
>
>         fd = fsopen("ext4", FSOPEN_CLOEXEC);
>         fsconfig(fd, fsconfig_blockdev, "dev.data", "/dev/sda1", ...);
>         fsconfig(fd, fsconfig_blockdev, "dev.journal", "/dev/sda2", ...);

Ok, that looks good to me. It also avoids the parsing issue with using
an interface like "write()", where the expectation is that you can
append things etc.

              Linus
