Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9393CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 13:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60F762075C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 13:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/o4V6dO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfBVNrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 08:47:13 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:35592 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfBVNrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 08:47:13 -0500
Received: by mail-ua1-f65.google.com with SMTP id f88so1994665uaf.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 05:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=aPDUL23UbS//3iJMmULFAIatEpA4+JfxwfASuQY5x2M=;
        b=R/o4V6dOWF7U9/SRWhJCfyUMQD5INNHT07TY/7jtJNMUJp7Yamg4QT+zsuNPiw+wRf
         icVyH1l18lum87NFuWR+NTwHmQWvLHrjW/oI8K7lKlbBJ0OaFZIBqrOrbd/Depq6LFJm
         bi0RgJyRL3ZlbiDGu3ZPmvxUvozZWyJD4g84AMWOQGaV1MwGuPEcqSiBVPmX/z/IK+/v
         s9SRjCI/7CQaP6m2mINzLN1cCj0qI8NVBFuS7J1/1C1URUqCMKVZdythMzCYZ1+oM3GD
         VybPLISdL02v2/r5tGo2fKYF2gP7jtzFvoMLKAanrruVFdUTUJEmyVUSG3jdGpRqV1ZU
         57vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=aPDUL23UbS//3iJMmULFAIatEpA4+JfxwfASuQY5x2M=;
        b=COQPehcXxHcnHPzSDdw1aAMi0zIyZdXV1ZrKWMbYFCTCObNUQg/x9gQQOmy+V1I5sr
         ymtZnsG5MhbbWcyRapgy6bZx38P3eVHiBxoWj5XSOdW73d7kY54LVhGIJ67Ns836Vr85
         G/PyYAt990RSerZ8c5PckCurta3Mw6sKQshLM/xKOZljFfTaddhHnp4m5xvvLbZaUHdB
         ABI2l8dMoEt4Kv8Ajw2pUDtwrFWc7Ji9YD4bQHBqXJ+rXIBw9hDmHrfaAxGqSJyZpDOW
         zCAaMHvFhYxl/kIJf74FqleHTPkHodhokbTUxp0X3Fa69s7DVtO5hVcOjU0FDxN1pmQ2
         yfrg==
X-Gm-Message-State: AHQUAuadJ3wUvvaUbQdmDG9hCSMfNW3ifpl35UzLIpOsQIml1+l9FzPc
        cXglVyHBz3AmjTOw57tIn8VYgW26j3VeSSVTRC+OLA==
X-Google-Smtp-Source: AHgI3IaClSMENoIJy7f7CljnlX/Pq5hck0APCEuxnytYmqKU2FrD/O7lBl+jSgx68wZNZiVCVY2mq4mcM0oxvKbbBC4=
X-Received: by 2002:a67:6887:: with SMTP id d129mr2231318vsc.144.1550843232002;
 Fri, 22 Feb 2019 05:47:12 -0800 (PST)
MIME-Version: 1.0
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Fri, 22 Feb 2019 19:17:00 +0530
Message-ID: <CAOuPNLhDtRJDBnwuV1kQ47Zd9B00qh2bXDNQvh9tXfTyYqAWDQ@mail.gmail.com>
Subject: arm64 Kernel build for qemu-system-aarch64 ?
To:     open list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kernelnewbies@kernelnewbies.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I want to build Linux Kernel 4.20 for arm64 and use it on qemu-arm64.
I see that there is a defconfig available in arch/arm64/configs/defconfig
But I am not sure whether it will work for qemu-arm64, and by default
which machine type is supported.

I already have working setup for qemu-arm for both versatile and
vexpress machine. There is already a defconfig available for these
under arch/arm.
So I can build the kernel for it.

But, whether these defconfig are supported for arm64 ?
If anybody have setup for qemu-arm64 kernel, please share the steps.
About rootfs, I am planning to use the arm32 version of busybox itself.


Thanks,
Pintu
