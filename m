Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCAFCC46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 16:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81DF220843
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 16:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hvQLKFIm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81DF220843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbeJ1AuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 20:50:03 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34241 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728784AbeJ1AuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 20:50:03 -0400
Received: by mail-lf1-f65.google.com with SMTP id n26-v6so3095802lfl.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Oct 2018 09:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=9iUGkkPMzymHyFy8XDEDG24c/EyKWgD9wzcOAiPjkI0=;
        b=hvQLKFImd8VEgGiXL2XbyeMcqXmUqr3qFouEqQxN7dfYU/OOnuBqO0Yo4AiPEVAeAa
         f/IrkpCG48CI1AGQcR7ZqYts8A05M3bRDQ04TaeCdam4sbfoY7UduInoRVed6uOo+jmS
         7qI5VJ22gdg/omsjL4rEyQWppgAhbczpbqHSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=9iUGkkPMzymHyFy8XDEDG24c/EyKWgD9wzcOAiPjkI0=;
        b=U+2fC8D1hFthz8YSPt6YHnCj+/DW5E8iXVeJ8QBdh0jLmZbAycrsqpSSZsQ+ZXUGNP
         k/HCTjoN4sdxeez47fhpOelane5ZeKnwiBUnYUaAST0fiPWCig09DP42KC7vdXE6eps7
         /vLI992M6RPKcjtiaVskslIlG1kJogwvT8yaw+T2QMKHHExnOynsSDcyk9A8FR+tdeeu
         7C2/Br6y4UjOH+jT46jDezrOEdDfiwwP3ATu4ya/trXq4Rh4WczGx2BiOWRKUtkadS9b
         161PyuwJXPHmgzFS/NndcdfmURJs6TLX7D6ZSfH0AfvHoNCT7RWfjV9najL+VcBjY1Kd
         ZA/g==
X-Gm-Message-State: AGRZ1gKg88AKjeDgXrc9LRifstPOFqOoa8VMlY3LfIZsqKrzR8sNTsEo
        dR7z+Q9dl7GGQI8eRWVQ2tcaxoit3I+qrg==
X-Google-Smtp-Source: AJdET5cfngm7jOpWXbFzy9IjxmIHH2faJ6kfKYoXjUZca7fSwo6LSmWHHaS77EAoRKV492/ZHQ/YNg==
X-Received: by 2002:a19:6e0b:: with SMTP id j11-v6mr4455685lfc.118.1540656514361;
        Sat, 27 Oct 2018 09:08:34 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id q5-v6sm2222771lfj.85.2018.10.27.09.08.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 09:08:33 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id h192so3102379lfg.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Oct 2018 09:08:33 -0700 (PDT)
X-Received: by 2002:ac2:41d8:: with SMTP id d24-v6mr4500865lfi.138.1540656512719;
 Sat, 27 Oct 2018 09:08:32 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 27 Oct 2018 09:08:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiVH6SdC2YutcDJ8kiAYUkO-ei3Wdjp2TXcbWas7LJrSg@mail.gmail.com>
Message-ID: <CAHk-=wiVH6SdC2YutcDJ8kiAYUkO-ei3Wdjp2TXcbWas7LJrSg@mail.gmail.com>
Subject: Oops in current tree in i2c
To:     Jiri Kosina <jkosina@suse.cz>, Julian Sax <jsbc@gmx.de>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     linux-input@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Julian, Jiri,
 On my laptop I'm getting a kernel page fault with the current git
tree, and I'm tentatively blaming commit

  9ee3e06610fd ("HID: i2c-hid: override HID descriptors for certain devices")

but that's simply because it's the only thing that seems to touch this
particular area in this merge window.

The oops looks like this:

  BUG: unable to handle kernel paging request at 000000007a25d598
  PGD 0 P4D 0
  Oops: 0000 [#1] SMP PTI
  CPU: 1 PID: 888 Comm: systemd-udevd Not tainted 4.19.0-07715-g345671ea0f92 #4
  Hardware name: Dell Inc. XPS 13 9350/09JHRY, BIOS 1.7.0 01/16/2018
  RIP: 0010:strstr+0x19/0x70

where the code disassembly (and the register contents) shows that the
wild pointer is the first argument to "strstr()", which just has a
bogus value that is not a valid kernel pointer (RDI: 000000007a25d598
- which is obviously also the address of the page fault)

The call trace is:

   dmi_matches+0x55/0xc0
   dmi_first_match+0x26/0x40
   i2c_hid_get_dmi_i2c_hid_desc_override+0x16/0x40 [i2c_hid]
   i2c_hid_probe+0x28c/0x760 [i2c_hid]
   i2c_device_probe+0x1e7/0x260
   really_probe+0xf8/0x3e0
   driver_probe_device+0x10f/0x120
   bus_for_each_drv+0x66/0xb0
   __device_attach+0xd9/0x150
   bus_probe_device+0x8a/0xa0
   device_add+0x48e/0x660
   i2c_new_device+0x162/0x350

which is why I suspect that new i2c_hid_get_dmi_hid_report_desc_override() code.

I *think* the problem is that the i2c_hid_dmi_desc_override_table[]
isn't terminated by a NULL entry, and I will test that next.

What makes me *very* unhappy about this is that if I'm right, I think
it means that code was literally not tested at all by anybody who
didn't have one of the entries in that list.

                  Linus
