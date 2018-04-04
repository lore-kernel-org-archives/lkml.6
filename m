Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752049AbeDDUNM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 16:13:12 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34980 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751579AbeDDUNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 16:13:11 -0400
X-Google-Smtp-Source: AIpwx49A6fB5gK5QGkM7xkBH6DilHshIl7En9Yr3v6qzAkZZiST0XkAHvil/VYIxHNWVZnHVcJ6dNw==
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>,
        Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 12/19] powerpc/powermac: Add missing prototype for note_bootable_part()
Date: Wed,  4 Apr 2018 22:13:05 +0200
Message-Id: <20180404201306.27818-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180322202007.23088-13-malat@debian.org>
References: <20180322202007.23088-13-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a missing prototype for function `note_bootable_part` to silence a
warning treated as error with W=1:

  arch/powerpc/platforms/powermac/setup.c:361:12: error: no previous prototype for ‘note_bootable_part’ [-Werror=missing-prototypes]

Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
v3: remove extern keyword
v2: no change
 arch/powerpc/platforms/powermac/setup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
index ab668cb72263..8b2eab1340f4 100644
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -352,6 +352,7 @@ static int pmac_late_init(void)
 }
 machine_late_initcall(powermac, pmac_late_init);
 
+void note_bootable_part(dev_t dev, int part, int goodness);
 /*
  * This is __ref because we check for "initializing" before
  * touching any of the __init sensitive things and "initializing"
-- 
2.11.0
