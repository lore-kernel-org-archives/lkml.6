Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25321C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 09:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE1E22086C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 09:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfALJnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 04:43:23 -0500
Received: from mail-vs1-f48.google.com ([209.85.217.48]:41304 "EHLO
        mail-vs1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfALJnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 04:43:22 -0500
Received: by mail-vs1-f48.google.com with SMTP id t17so10791711vsc.8;
        Sat, 12 Jan 2019 01:43:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=vLhH2uYnDLtA0FjP8/xPMgFwFImRUsClM5UJr1DN3a0=;
        b=I1QcjWNzXz/QOKXUujc82hk6I1UlnGmR/ABDZ/Nh+qL/vRdCMWjSNtPpJXFDiTK9Xf
         aYVuoXU0MKVFKprfA4UTR8WMJG/YISKlbfUM8g4De+zcJx3634Fyw0BiZge6HMaHwAHH
         IBIzBcHxntgkISdfCWgRzbCz0Do+wPUH7obR1v5WdVWoSxfHDEAZ30l/5c1EGPnzX/eZ
         ES9lkVe0qnJBHivQH0rRF6JCC1REEFu5xkrklRm/ffetnX+i1r0guYx1ocYjt25Yp3MU
         2AsMevnHaOBCdTwUf4EWX7vPgRMm0Ew8St5OljngDsxqTY4EuZqDdLZ0YUHEofiZ6MQO
         7QjQ==
X-Gm-Message-State: AJcUukf/UJJB0rrnWXYqBl5ZCk1sFr2rJiSBAU+mnd8adL6USQVOFxzg
        9eajFd/WQgsjZBMJ0RenLE+O1Xbi7c41gEWrzLnyFa8mlK8=
X-Google-Smtp-Source: ALg8bN5k6U+P+5V8sY7t4tBfV0s13qZW5DbbHSFgQ1Him9fzb1nXNoz7FLcAGuzfcTerFi03Rb1m3rDrBbZMYwDY5gk=
X-Received: by 2002:a67:c202:: with SMTP id i2mr6915019vsj.11.1547286201540;
 Sat, 12 Jan 2019 01:43:21 -0800 (PST)
MIME-Version: 1.0
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 12 Jan 2019 10:43:10 +0100
Message-ID: <CAMuHMdULrGHfgF+RRGf5gXAc=V3KaB4549NezxEc3CvfsKWOyA@mail.gmail.com>
Subject: Preserving a rev 0.0 ext2 filesystem
To:     Theodore Tso <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ted,

I'm still regularly using a Linux rev 0.0 ext2 filesystem as a  ramdisk
on m68k, containing mid-90's binaries, from right after the a.out-to-ELF
transition, so I notice if someone breaks old syscall support.

Recently I wanted to change /dev/console on that ramdisk from a symlink
to chardev 5 0.  Unfortunately I cannot mount it, without it being
upgraded automatically to a rev 1.0 ext2 filesystem.  Apparently the
kernel has been doing that upgrade for ages.

Do you have a suggestion how to make that change, while preserving the
ext2 revision?

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
