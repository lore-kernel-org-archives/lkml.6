Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C06C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 12:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5C1F218A6
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 12:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfCPmFDs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729383AbfAZMGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 07:06:01 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:33343 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfAZMGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 07:06:01 -0500
Received: by mail-it1-f195.google.com with SMTP id m8so7028692itk.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jan 2019 04:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=U9jQiYwR3FRsJtNwD+Z0f3EV/KdZtUx4eXxemqoLUUk=;
        b=lfCPmFDsHlSCb+hxVaW9XjzDhjT7Wajl7+cMIJvPNEoZAXGJRIRJnfsB2fzww37MoG
         fyHV1ZLctVYl/uuh8V4ylHa064VViXgbtjxaB41YGH1Ne8eRqLwGEAjkaVvroCzddvCX
         LHg3o5YG3ZI8Jv7n37WJioTJujOpa6eF+Y2r4b0KDpJRX5JtpgluRt0MMAkVVv4N/4Mh
         lYwrlil0w8wo4cDCmHvD0EwQPTagn63lxtUH7Hsrpy1k3UCcGVH9aeDTvQKaNB0BK8/K
         zMAUH9eTvC5rl3SxnCKv3ahdhXLP5tSiZsDR/qOIgG2mB2P2+Oz+gS+repJVIbNkysSc
         Uv5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=U9jQiYwR3FRsJtNwD+Z0f3EV/KdZtUx4eXxemqoLUUk=;
        b=oWS6grYgHhbojJWs0nycfl3K5NmlvwI5baoJg16D2tYSpUpuU/2sClGuuK/f3d0sML
         +BrlxBA58kbpocmy2BEG+ZdZpz5e7MYb4W+UwZlNV4/Oty8zr7l/fQgYX4rU9McoUv2s
         K3tCKKNZ7gMGhCJLSi35TUDlFWHJ5l/xU1nd2WVUytKEN0hfRt13ho+shzdC1qdLwhaY
         qFJBez6kMMPzmRHPdyWA1bpWqh6Lno3DWr5HyLHAvpqZ1nXDxlAC0aU8hQ9596Abbii/
         kFJO+mYUKqzykhdQBBHSYoc3yLqdQvYTuLFGQ4bZ1Y8qDPjsDLEtDmeZMl2OtvcTWcMe
         S0rg==
X-Gm-Message-State: AJcUukdtTxXH0gr3pmfqeLuCZdimYsRtXnPeMnrkhoodQWmF7SEf9/87
        WwEff59bWiTTs9DklFOOVeJqWc0T8vUXlh0j50AdQXVR
X-Google-Smtp-Source: ALg8bN4O/mQkA6B8/jkUDqMfKWA9ZYUf+B7rKMsG7huTvbWjd8w6FbbBkQsuixjUG91hl3syCUvAvxDOsapr4JphpnU=
X-Received: by 2002:a24:cb02:: with SMTP id u2mr5371562itg.87.1548504360275;
 Sat, 26 Jan 2019 04:06:00 -0800 (PST)
MIME-Version: 1.0
From:   Norbert Lange <nolange79@gmail.com>
Date:   Sat, 26 Jan 2019 13:05:49 +0100
Message-ID: <CADYdroOHk2NrxXcCdYdnpV52Rt_bMsK3A-qWHkxw-hJZNDe6FA@mail.gmail.com>
Subject: Re: [RFC] Provide in-kernel headers for making it easy to extend the kernel
To:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have a similar problem, which is caused by an attempt to separate
the kernel installation
from the rootfs. updates of the kernel should not affect the
(read-only) rootfs or initramfs.
For technical reasons I am unable to built all modules static.

-   have multiple kernels #K and rootfs installations #R without needing
    #R times #N module subdirectories. (think of fallback kernels/installations)
-   be able to use readonly rootfs, and need to regenerate it for new kernels.
-   ideally be as space efficient as possible

I ended up embedding an initramfs in the kernel, but this has the
annoying drawback of disabling the builtin init of the kernel so I
needed to further add busybox and shellscripts just to get it to parse
the cmdline and boot.
I used a compressed squashfs for the kernel modules, further requiring
a loop device.

So the point I am trying to make, that there could be a better
approach for my problem,
like having the kernel expose a blockdevice in /proc/bundle.img (no
need for a loopdevice).
Maybe some more generic approach would cover both this issue as well
as the problem with kernel headers on android. The /proc/kheaders.tgz
file is very specific.

(Well, I would be happy if there is a way to keep the kernels builtin
init enabled, even if a custon initramfs is builtin)
