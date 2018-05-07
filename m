Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752580AbeEGSbV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 14:31:21 -0400
Received: from mout.gmx.net ([212.227.17.21]:39549 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751976AbeEGSbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 14:31:20 -0400
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Joe Perches <joe@perches.com>
Cc: Andy Whitcroft <apw@canonical.com>, linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [BUG] scripts/checkpatch.pl: false positive missing parentheses
Date: Mon,  7 May 2018 20:31:05 +0200
Message-Id: <20180507183105.13499-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.17.0
X-Provags-ID: V03:K1:5Ip+hrICXcd5mXfeVMs6FirfbyGUG6mp+xZGO+dwN/k4HzvC4Uk
 XFZGRuQ0rXGvpnIfbILkZ9FTCcE9mb2kpj+PEMyCNMbIT6Ynjazz4+qySduRd5uJlskRhAL
 FTx+fk9FyuvibAeKeFKe+GVkXlI6SYWuQ6Adspnvjtbzclc0OIGpr4ZykKZEyUNtsG5p47N
 NxcTsxdvcdGM2aDswP0gA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pMK+JVhfL5o=:BM0fkPS6IMg42X5gOFLtg+
 sth0MPr1g2Ccbl68UARenOOudnGsLgxQ5kV5UryzziBxGzDlqyKP9SZai9caxeMEycFyR06Lt
 EIjZ9m/+9rPj7sO1b8J9lF15DEap7hsv29DVt1JgrC4RxC4y13OBAvfdjKld/b0MlXduhRUxL
 lwQyqbrTeokCyZjQ7sM4b9XE6jnNA9y/6AB4yxOnVI8oHuKJFFOe+9B9zIyw8dxSMH77a34sB
 NglECIqOW8h+jlTmdvNZqSzhgVMrnHQFOJwZB7L9oTHOHA47rUhY4ftc+OUzBkkEJP+PMlvpK
 znwUDoolslieqtCpZ+4UCJf7Nrfx9UDE3zqR9DFsyrV7ByJVb+9+nQn5h+/SD5hLmpbC68mn/
 IW2dxg8EUlSV3LM9dsCgIxGjEpNaAazCzrJnGqEqXnZ8OMCnmNyjr2MZ6+f4mL0rqZkwZP3KB
 jZa/nL/D77Xs+Psy2fhy0datEBuyyH+luUQnC8nZ5zLYaWC+SKY/29PBDdHGMB6TqbR0rYghI
 dplSm0OT+Uc756d4G9DhuEDralcUgiCZ6dQpNdBKyCiEf5g7tF6qCEe2tBbFYNjluZV2uANRw
 EcVQ1Uunwmweogvc0Fs3Zr1VTOkTJX66zfW0H1bTAHhcpCZy/74Stktnj332ulVC+YgUgnj7R
 jOr3puMEdDe/+zL5eJdVZlgNPILTxPdFKGdtJUXoNJemuL0jvM7JbYUwsJupd0+7uSYXn9/7O
 eyBPbzL52moqU4V29QBmDmTPv2t8qqyvmQVwE4LUW3MksQKqtPuWtQcgYpY=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch creates a false positive:
ERROR: Macros with complex values should be enclosed in parentheses

Here we define a constant that can be used to initialize a structure.
Adding parentheses would lead to a compile time error:
error: braced-group within expression allowed only inside a function

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 foo.h | 8 ++++++++
 1 file changed, 8 insertions(+)
 create mode 100644 foo.h

diff --git a/foo.h b/foo.h
new file mode 100644
index 000000000000..e2cba533f065
--- /dev/null
+++ b/foo.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: BSD-2 */
+#define EFI_ST_DISK_IMG { 0x00003368, { \
+	{0x00000d40, "\x6f\x63\x00\x2f\x2a\x00\x20\x2a"}, /* oc./*. * */ \
+	{0x00000d48, "\x00\x20\x2a\x2f\x0a\x00\x09\x7b"}, /* . */...{ */ \
+	{0x00000d50, "\x30\x78\x25\x30\x38\x7a\x78\x2c"}, /* 0x%08zx, */ \
+	{0x00000d58, "\x20\x22\x00\x5c\x78\x25\x30\x32"}, /*  ".\x%02 */ \
+	{0x00000d60, "\x78\x00\x20\x2a\x2f\x20\x5c\x00"}, /* x. */ \. */ \
+	{0, NULL} } }
-- 
2.17.0
