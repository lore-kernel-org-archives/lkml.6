Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932110AbeCIQMm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 11:12:42 -0500
Received: from mout.web.de ([217.72.192.78]:51495 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751143AbeCIQMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 11:12:41 -0500
Subject: [PATCH v2 05/17 1/2] mfd: sm501: Improve a size determination in two
 functions
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: kernel-janitors@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <c5d9751e-3ae8-0b66-821a-0e7f45bb8e1c@users.sourceforge.net>
 <5271ab9f-3be1-035c-90c1-8faba2e119b8@users.sourceforge.net>
Message-ID: <8141262d-a76d-3085-5502-647f9fd3edfc@users.sourceforge.net>
Date: Fri, 9 Mar 2018 17:12:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <5271ab9f-3be1-035c-90c1-8faba2e119b8@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:YPluX00BHXKoNkW4tyXK7Xz/bKtFYjxFvj3F6vd07QfwT/TyZLd
 oiZOgE1U1928GykVmyN5d4L3aILywrC4JrAwGnzZASmMM1dbUiL05y0lErgyAQ0uh96SCqY
 541nzRambCyNcJj/V5exo6LKQ/JiBRd7EfUqX0RaEBEZ5ve22QTFCV3VaeRjLQRX3ngD35C
 FabYnnVvBq5q1L1zYajPA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+6KnNxXXiE4=:QantdofJllkUQNaEyesImb
 0FY63jIFO9lSlBKmd1+sRiFKvRewn3rPN7PuzUn3UZVY4jRHc4KIuZU3xrFnawwJUbWriytPl
 LWUEif7CP6vXAeDhhNrdVi0MPQG3ShZ+qxONgW07YivzyOfAcZd74EIhdOYJZZZj9pdFm2PtU
 xUzpP2HjlB9E1Oe6F5y+Pf5Cukxf3vasExyPk1W3QgIVXU+dpYZYrsLDezHLNQOPlQxLCyyoq
 s6GlJ4S3bfPio3pkh2UE0reEgCabPszt7kOB4RkCvD7FfEuVvTG5va28W79B8/6vBQVJoy81q
 pVoG7a5vjNJ9rpXmMGDkYHDXPLXBEfwSG6RMOHWgknJrARu5i0C+ut8Pa8hFmpZ3lEn1GCfrZ
 cYso/nBG4kmVBYwNfpEdqbe1ruu3uu0sfuAJ90uojcMTh2rdzKCfeGPaD9vfuR/F6HLFaUFLl
 hA5QWixZhgZ7fVlGJlHmVT00ikOcigJPxptcDeNiGzTpfllTx6d30IRTyboFIDYjgc6xGBzDr
 yJ5JIILoUB+dZDeGuFW8Nu3NnU7Q4Ipy38S2qZ9rINTL1hInHsHYaLMENMGTmsPtEjYiQzE+j
 /FRIdgmxXuOBRevgTu4tR6E2tgJE95ajNhIV+6L/ZneypBdGmVGIK5XX2UNxZU0dJVvbGQqOO
 W5r2+lEJS24K7IYG19bxRBlabPOnsz5bKz/XId6vlx9inokltzP9mRA/jqp7GFu7MZWUUztRk
 dVGNF5XQxLpDHFawA/RLlGvqca12Su5hICODaBk+8hHS/GpaWAWj9dM7GKMEnHFXiYs3c86C0
 Sumh5otvnhQm1/+Yhv+OvYD+uhNoRCocgJKUKX5/X3j5arhxx8=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 8 Mar 2018 14:05:41 +0100

Replace the specification of data structures by pointer dereferences
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---

v2:
Lee Jones requested a different source code layout for this transformation.
The change was rebased on source files from Linux next-20180308.

 drivers/mfd/sm501.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
index 7298d6b571a1..4f4957ea8fa3 100644
--- a/drivers/mfd/sm501.c
+++ b/drivers/mfd/sm501.c
@@ -1383,7 +1383,7 @@ static int sm501_plat_probe(struct platform_device *dev)
 	struct sm501_devdata *sm;
 	int ret;
 
-	sm = kzalloc(sizeof(struct sm501_devdata), GFP_KERNEL);
+	sm = kzalloc(sizeof(*sm), GFP_KERNEL);
 	if (sm == NULL) {
 		ret = -ENOMEM;
 		goto err1;
@@ -1572,7 +1572,7 @@ static int sm501_pci_probe(struct pci_dev *dev,
 	struct sm501_devdata *sm;
 	int err;
 
-	sm = kzalloc(sizeof(struct sm501_devdata), GFP_KERNEL);
+	sm = kzalloc(sizeof(*sm), GFP_KERNEL);
 	if (sm == NULL) {
 		err = -ENOMEM;
 		goto err1;
-- 
2.16.2
