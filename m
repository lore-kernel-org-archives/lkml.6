Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70F4C6786F
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 09:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC112081F
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 09:10:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DC112081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbeKCSUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 14:20:51 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:53002 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbeKCSUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 14:20:51 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id E22A960A04B3;
        Sat,  3 Nov 2018 10:10:09 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id WBwD1CdxLQlt; Sat,  3 Nov 2018 10:10:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id A56FD609F82F;
        Sat,  3 Nov 2018 10:10:09 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id tx5Gpe2Aac2O; Sat,  3 Nov 2018 10:10:09 +0100 (CET)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 2B103606C48C;
        Sat,  3 Nov 2018 10:10:09 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Helen Koike <helen.koike@collabora.com>, keescook@chromium.org
Cc:     dm-devel@redhat.com, agk@redhat.com, snitzer@redhat.com,
        linux-kernel@vger.kernel.org, enric.balletbo@collabora.com,
        wad@chromium.org, linux-doc@vger.kernel.org, linux-lvm@redhat.com,
        kernel@collabora.com
Subject: Re: [PATCH v10 0/2] dm: boot a mapped device without an initramfs
Date:   Sat, 03 Nov 2018 10:10:08 +0100
Message-ID: <3624012.MiIzIq7dko@blindfold>
In-Reply-To: <20181103035341.16893-1-helen.koike@collabora.com>
References: <20181103035341.16893-1-helen.koike@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Helen,

Am Samstag, 3. November 2018, 04:53:39 CET schrieb Helen Koike:
> As mentioned in the discussion from the previous version of this patch, Android
> and Chrome OS do not use initramfs mostly due to boot time and size liability.

Do you have numbers on that?

I understand that using something like dracut with systemd inside is not what you
want from a boot time point of view.
But having an initramfs embedded into the kernel image which contains only a single
static linked binary can be *very* small and fast.
If you invest a little more time, you don't even need a libc, just fire up some
syscalls to setup your dm. I use this technique regularly on deeply embedded systems
to setup non-trivial UBIFS/crypto stuff.

Want I'm trying to say, before adding ad-hoc a feature to the kernel, we should be
very sure that there is no other way to solve this in a sane manner.
We have initramfs support for reasons.

Thanks,
//richard


