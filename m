Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753750AbeEWA02 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 20:26:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48984 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753708AbeEWA0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 20:26:24 -0400
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>, Jessica Yu <jeyu@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "AKASHI, Takahiro" <takahiro.akashi@linaro.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [PATCH v7 07/14] integrity: Select CONFIG_KEYS instead of depending on it
Date: Tue, 22 May 2018 21:12:46 -0300
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180523001253.15247-1-bauerman@linux.ibm.com>
References: <20180523001253.15247-1-bauerman@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18052300-8235-0000-0000-00000D8D5A26
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009068; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000261; SDB=6.01036241; UDB=6.00530093; IPR=6.00815369;
 MB=3.00021248; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-23 00:26:22
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052300-8236-0000-0000-000041176F6E
Message-Id: <20180523001253.15247-8-bauerman@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-22_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805230002
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This avoids a dependency cycle in soon-to-be-introduced
CONFIG_IMA_APPRAISE_MODSIG: it will select CONFIG_MODULE_SIG_FORMAT
which in turn selects CONFIG_KEYS. Kconfig then complains that
CONFIG_INTEGRITY_SIGNATURE depends on CONFIG_KEYS.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 security/integrity/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/Kconfig b/security/integrity/Kconfig
index da9565891738..0d642e0317c7 100644
--- a/security/integrity/Kconfig
+++ b/security/integrity/Kconfig
@@ -17,8 +17,8 @@ if INTEGRITY
 
 config INTEGRITY_SIGNATURE
 	bool "Digital signature verification using multiple keyrings"
-	depends on KEYS
 	default n
+	select KEYS
 	select SIGNATURE
 	help
 	  This option enables digital signature verification support
