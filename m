Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23612C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 10:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0EFF240F1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 10:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVuc8MMa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0EFF240F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753548AbeGEKVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 06:21:15 -0400
Received: from mail-lj1-f179.google.com ([209.85.208.179]:43832 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753322AbeGEKVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 06:21:13 -0400
Received: by mail-lj1-f179.google.com with SMTP id r13-v6so6247492ljg.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 03:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=XAIhKiqYRgzl1Ar3CjXHdpYhab1+i8+PpJMTj9ERNkc=;
        b=nVuc8MMaM10qWXLZWDWP9WQy34MZ0qXRwQ64K/NPaWK2IfLgw35NzOZoBqI+QH6m8b
         wwC/8vvynrZIykjAEgK/ADMAKyswtp5ha9/J8PzLR4kPAjtU9iohs60DagwbCsD+8cJJ
         HOp33Y/p82RLExYXVOpjybeuW2/9HkARFxooJVwOnMJdndAymCGqSULjikdRXN7wS2cq
         FFZiPqPMuw0dj9bAxycuSFgZzJHoHM2aahwU0TFVywdtQsRdvKm7IYPSpov8/SZlA+wJ
         YT1vS54jc0xdcy1dJIUAA8poCZWp0V+ayJMywXdB8WWfa5D3+aI6TaU83siHz1qIAGaQ
         rkBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=XAIhKiqYRgzl1Ar3CjXHdpYhab1+i8+PpJMTj9ERNkc=;
        b=hMqSF+TLi4EKskQsiPkE6mzdL0QKE4rILvJZfAL2gqTxc21SXYQ+kRWwbEj92PEMe8
         DrBL7OSPJo8okwJUFmabsBjyYeIJto/gLQpf1xY/2A2ZjlSjXTIVdK2QnAF8bwBHqKhG
         wBr9670FvFbAbik0OuddoTWjnK6mz1ax2TQSusfpv1gWyRFXSe/u+37pmd/yvwxEaz8s
         O9XoxIvFUE9DRHet/iqi7Sd+a/tuMIhPjAVfHWlIP/Nl/dYGvwrzloCI4kOP8svrMVcZ
         ZJK7UgsaFevB8m4XfD18obZ5s8Ml5Wr6b30PcWU644hkHW9PdZt7k1eE7FbnuALB9Z9s
         /uMw==
X-Gm-Message-State: APt69E0OUnoK9sgImE9IaODh1FWqxECwo0auE2KopbEXVqxnKYIHgdMn
        /dCzflpEiSMwmi/s/QmX6U14DP00wK+3f417YaUw8Q==
X-Google-Smtp-Source: AAOMgpemfMJtTAHkX4SaxPg53aypG8TccyBhqkejnZkZhJb/l2/eXKM+tHHrgm+FcztGC3ye1RKXYKkhbCYK89NQ/ho=
X-Received: by 2002:a2e:6d11:: with SMTP id i17-v6mr3629611ljc.116.1530786071216;
 Thu, 05 Jul 2018 03:21:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:8345:0:0:0:0:0 with HTTP; Thu, 5 Jul 2018 03:21:10 -0700 (PDT)
From:   dave frost <l3tdave@gmail.com>
Date:   Thu, 5 Jul 2018 11:21:10 +0100
Message-ID: <CAJL-fBY1_EME-YZGDPd8+V_NRfAP75CHF1yHkznC1Nk2FoyZ-g@mail.gmail.com>
Subject: Arm Linux boot-up
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Morning folks,

As the title suggest im having issues geting my kernel started, and
was hoping for some guidance.

In short i think my problems come from the MMU/Cache configuration
being bad during the transfer from my boot loader to the kernel.

Just as a quick aside i have confirmed my kernel boots using UBoot.
but i wont be able to use uboot long term.

My bootloader executes in RAM at 0x3e000000. It places the kernel at
0x2200000 and the device tree at 0x30000000

I have definitely heeded the warnings about debugging head.S and can
verify this is not easy! I have added the following to head.S just
before the decompression routines are called.

debug_reloc_start
debug_reloc_end

During a bad bootup i get:

26B6CB50:00000000:00C5187D
00000000-268B463C>00000000
00000000
00000000: E59FF018 E59FF018 E59FF018 E59FF018   E59FF018
etc...

on a good boot up i get obviously better values:

22247A60:00000000:00C5187D
00000000:2200019C>20008000

00000000
20008000: 473C5655 473C5655 473C5655 473C5655   473C5655  ...
etc...

There is a bit more kputc statements in head.S but they re before the
pc is assigned to r0 and just after r4 gets its value.

Can someone out there confirm that this looks like im not configuring
(i.e. invalidating / emptying) the cache properly before jumping to
Linux?

Are there any other considerations that would cause this sort of
behaviour on arm platforms ?

Any or help or pointers very much appreciated.

Many thanks.
Dave Frost
