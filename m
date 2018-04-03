Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754753AbeDCB1u (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 21:27:50 -0400
Received: from mail-yb0-f173.google.com ([209.85.213.173]:40000 "EHLO
        mail-yb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754675AbeDCB1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 21:27:48 -0400
X-Google-Smtp-Source: AIpwx4+ywL42KCdX2iDvUarMYSGen54j0WLl5ExS1debN++tGSszC+a+av5JV7JI6UKNgKt6VH+2gArekUfPr9qQS64=
MIME-Version: 1.0
From: Simon Que <sque@chromium.org>
Date: Tue, 03 Apr 2018 01:27:36 +0000
Message-ID: <CANV8Hs0XsCnLRwOdC=r4sot+iKkivofMzEg-kA_b5UjRw9Xmng@mail.gmail.com>
Subject: Looking for way to program external MMU from userspace (or viable alternative)
To: linux-kernel@vger.kernel.org
Cc: frankhu@chromium.org, John Joseph <jnjoseph@google.com>,
        Rob Springer <rspringer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi kernel community,

We have an external PCIe board with a custom coprocessor on it. We also
have code for a kernel driver for it. We have thought about upstreaming it,
but we realized that we can instead convert the driver to a userspace
driver using UIO.

However, there's one aspect of the system and driver that doesn't seem to
be covered by UIO. The external board has a MMU and a DMA interface that
allows it to copy data between the host system's RAM and its own internal
memory.

The current kernel driver code looks up the physical address of a page of
user-allocated memory by traversing the page table, and then writing the
physical address to the external MMU. If we were to move the driver to
userspace, this procedure would require exposing the physical address to
user space, which insecure and thus a no-go.

What possibilities are there for programming the MMU from a userspace
driver?

For reference, here is the existing kernel driver code -- start from
apex_driver.c.
https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/981313

Simon
