Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCF8C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 12:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4D852083D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 12:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhgJgqnT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4D852083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389165AbeHAOVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 10:21:06 -0400
Received: from mail-ua0-f175.google.com ([209.85.217.175]:43411 "EHLO
        mail-ua0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388896AbeHAOVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 10:21:06 -0400
Received: by mail-ua0-f175.google.com with SMTP id x24-v6so12537814ual.10;
        Wed, 01 Aug 2018 05:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=6g+QHwP/bGJLaC6k2i8V0BDQzPt5c1g/OdF9BBiv4GQ=;
        b=nhgJgqnTMyBhbeyjm3ZHnKoJPKVgl+SVqyVHGgcUmifrTZlb3fIScZL91ci69+iYS3
         EUSGImm0TGCymvC/dr7khir230kXZAr24hR2dz6jOsu81GxOjhl2Hfg//ihnU9iD1K9P
         wvu8QnDjRbiLy20maylGM3CAjZ6fUOxpqyHAdKk40ULPSiLihrIdRJIY38ZL3PpHR60z
         nVBkkEopINak155E6UTuVN+4FusBR3LB4s7YKQkDsurRcoEe2zIzCZBYg8c5nqXwMzn+
         qAb5/YQXoKntzptx6Uf45XYHnypU4YpcZbd4dbC1eYaHoJSFc7JGwVUArWpEDOcVaahI
         a6hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=6g+QHwP/bGJLaC6k2i8V0BDQzPt5c1g/OdF9BBiv4GQ=;
        b=HB8ar2n6kLwnX5lmaxrjUNzrYd9m23pGUbk+SrjFWdZGv7Xwezf5JYlmy91bYqJeDQ
         iY2NslQYh4sp7NraUGCcT5RSNuatJ2Er6PQsr2uweQVWSvCMsQx+4sRb3FHwm3R4GO0l
         uYkP93uscRdxDizKN8A9YtFhEvDq2QndODShfMU5pbU8Z73owRPwyQcezaFxlik7ojKC
         3JusKSziXgt4jFa4TXoU5HpOZOeNXFWRYYin0SOpXFxLfSO9yUg0GRMy4NWQnVqddWFB
         BDkmeZ/Ry15BJzAbC+SfsdAnzJc4DQrpe0NWLi0N5WWhTjnnDpRK1uZM09w5R75N1cyw
         eOIw==
X-Gm-Message-State: AOUpUlHWvyBWZVhDaW2ffk8u6Cs5GOWHC+rKMbgM9E6zsNzk+YY5bEe8
        1KPlOCFY8g2GDds2CFp1ptWzm60HyGmZrj6w50yU8g==
X-Google-Smtp-Source: AAOMgpcrwLgtTuntKdviOp3+cK88hB9Ykv3/i6MzxxwnYiPgs6F4LPCsI2t36Tke0sDUDw1w+8oRFNsV9wgsOOT/HvM=
X-Received: by 2002:ab0:7253:: with SMTP id d19-v6mr16752594uap.99.1533126930235;
 Wed, 01 Aug 2018 05:35:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9f:26e1:0:0:0:0:0 with HTTP; Wed, 1 Aug 2018 05:35:29 -0700 (PDT)
From:   Ivid Suvarna <ivid.suvarna@gmail.com>
Date:   Wed, 1 Aug 2018 18:05:29 +0530
Message-ID: <CABXF_AAVhadw=+rtcD-L06-zBTMb3v7C2QqvN-6vcx5w2T0sYg@mail.gmail.com>
Subject: arm64: pstore: printk causing hang during boot in __memcpy_toio with
 pstore enabled
To:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Baron <jbaron@redhat.com>
Cc:     Kernel development list <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When pstore is enabled and a *pr_info(any printk) in
__memcpy_toio(arch/arm64/kernel/io.c)* is added, kernel wont boot and
just hangs.

The path where __memcpy_toio is called is below:

->persistent_ram_update
  -> memcpy_toio
    -> __memcpy_toio

I tried with trace_printk and kernel boots fine. I understand that
printk has overhead, but is this expected when we use some printk
statement in __memcpy_toio?

Or is it some kind of bug? Tested on db410c.

Please let me know your opinion.

Thanks,
