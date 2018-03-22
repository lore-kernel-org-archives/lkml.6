Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752328AbeCVFXt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 01:23:49 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:34761 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752042AbeCVFXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 01:23:47 -0400
X-Google-Smtp-Source: AG47ELsUgIPYt/PDcvTDx/od040rVUnL7QVmYEXSsBXdP8jylwjppZpkXfPhYrGedcXKxb9ak1gW1Q==
From: Joel Stanley <joel@jms.id.au>
To: Jonathan Corbet <corbet@lwn.net>, "Tobin C . Harding" <me@tobin.cc>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: Mention why %p prints ptrval
Date: Thu, 22 Mar 2018 15:53:36 +1030
Message-Id: <20180322052336.1001-1-joel@jms.id.au>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When debugging recent kernels, people will see '(ptrval)' but there
isn't much information as to what that means. Briefly describe why it's
there.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 Documentation/core-api/printk-formats.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index 934559b3c130..eb30efdd2e78 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -60,8 +60,8 @@ Plain Pointers
 Pointers printed without a specifier extension (i.e unadorned %p) are
 hashed to prevent leaking information about the kernel memory layout. This
 has the added benefit of providing a unique identifier. On 64-bit machines
-the first 32 bits are zeroed. If you *really* want the address see %px
-below.
+the first 32 bits are zeroed. The kernel will print ``(ptrval)`` until it
+gathers enough entropy. If you *really* want the address see %px below.
 
 Symbols/Function Pointers
 -------------------------
-- 
2.15.1
