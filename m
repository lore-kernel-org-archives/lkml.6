Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752821AbeDLKOU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 06:14:20 -0400
Received: from mail-ua0-f202.google.com ([209.85.217.202]:36984 "EHLO
        mail-ua0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752602AbeDLKOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 06:14:14 -0400
X-Google-Smtp-Source: AIpwx4+YebI2DgHw/imgDzddOfsNN3MaXHtjY48IlSsMC+Q5Ga4X//WOhrvUkz7RXzWdw0/NAp7X6fNwMQ==
MIME-Version: 1.0
Date: Thu, 12 Apr 2018 12:13:47 +0200
In-Reply-To: <20180412101350.210547-1-tweek@google.com>
Message-Id: <20180412101350.210547-2-tweek@google.com>
References: <20180412101350.210547-1-tweek@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
Subject: [PATCH v2 1/4] tpm: Add explicit endianness cast
From: Thiebaud Weksteen <tweek@google.com>
To: jarkko.sakkinen@linux.intel.com, nayna@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        tweek@google.com
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thiebaud Weksteen <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Thiebaud Weksteen <tweek@google.com>
---
 drivers/char/tpm/tpm_eventlog_of.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_eventlog_of.c b/drivers/char/tpm/tpm_eventlog_of.c
index 96fd5646f866..d74568d58a66 100644
--- a/drivers/char/tpm/tpm_eventlog_of.c
+++ b/drivers/char/tpm/tpm_eventlog_of.c
@@ -56,8 +56,8 @@ int tpm_read_log_of(struct tpm_chip *chip)
 	 * but physical tpm needs the conversion.
 	 */
 	if (of_property_match_string(np, "compatible", "IBM,vtpm") < 0) {
-		size = be32_to_cpup(sizep);
-		base = be64_to_cpup(basep);
+		size = be32_to_cpup((__be32 *)sizep);
+		base = be64_to_cpup((__be64 *)basep);
 	} else {
 		size = *sizep;
 		base = *basep;
-- 
2.17.0.484.g0c8726318c-goog
