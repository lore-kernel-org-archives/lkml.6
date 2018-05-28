Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034151AbeE1PQG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 11:16:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:42216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033093AbeE1KWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:22:50 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiandi An <anjiandi@codeaurora.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 196/268] ima: Fix Kconfig to select TPM 2.0 CRB interface
Date: Mon, 28 May 2018 12:02:50 +0200
Message-Id: <20180528100224.504546870@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100202.045206534@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiandi An <anjiandi@codeaurora.org>

[ Upstream commit fac37c628fd5d68fd7298d9b57ae8601ee1b4723 ]

TPM_CRB driver provides TPM CRB 2.0 support.  If it is built as a
module, the TPM chip is registered after IMA init.  tpm_pcr_read() in
IMA fails and displays the following message even though eventually
there is a TPM chip on the system.

ima: No TPM chip found, activating TPM-bypass! (rc=-19)

Fix IMA Kconfig to select TPM_CRB so TPM_CRB driver is built in the kernel
and initializes before IMA.

Signed-off-by: Jiandi An <anjiandi@codeaurora.org>
Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 security/integrity/ima/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -10,6 +10,7 @@ config IMA
 	select CRYPTO_HASH_INFO
 	select TCG_TPM if HAS_IOMEM && !UML
 	select TCG_TIS if TCG_TPM && X86
+	select TCG_CRB if TCG_TPM && ACPI
 	select TCG_IBMVTPM if TCG_TPM && PPC_PSERIES
 	help
 	  The Trusted Computing Group(TCG) runtime Integrity
