Return-Path: <alastair@au1.ibm.com>
X-Google-Smtp-Source: AB8JxZqDbM+Wq0U8UMRbwmkt9pMa1/gjDEUw56z0u2I41nmyRlmlvwJ6ZIMfOR5v24LAeYinWo26
ARC-Seal: i=1; a=rsa-sha256; t=1524013870; cv=none;
        d=google.com; s=arc-20160816;
        b=R2tP50yfFxzHAPWUq7Bcq8H1cvcrZV52txNuPUhmMieD5Xq9ubPe8M6vTQlbL+T1ZL
         6RDY6ColkChK96ovG3Zo/iSYmm7cOro3mLiDtdMK2M8UUS8Z1l0gdYyd/1rJ+ZbckNjD
         mXklmrByVF9/03j1VWrarflH3+NbVu81MM1Cz2cE0NJEWyZ7VN43xJc1f1tewfeHb37n
         TJPPuD9shVPjFj7WlTpsWxNumyO4VrYiT/N6Lh5KDzgocPXyDtYGSDzHDTpisEysb4tM
         jukLhTsBnPBVTC3AHd99IWP2rhTPRFS9BqzudRB8gMUQF+R2ZiLjbxn/pTty35S7RPp6
         KoLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:references:in-reply-to:date:subject:cc:to:from
         :arc-authentication-results;
        bh=Kj2GMDwC03rO5VLAOeX1gCOS/AWy1bU6GhUAM5GKC5Y=;
        b=Yl8l/cwPsnw/pNwfau5LUpi/h0NYhpjKJySlFhtZHiX9gaE7VJolnuMb+Mb0cJm18A
         gEbTSz7aXpoqKMU/AABj2bOaC8sH2OgW+6S+lDsbSTZx3xrKts5VhvbKbJRph5aQiEqC
         Ktdetm7Mz2/Dnj1B8DsYiQLcUSOA1S1vUm2dwwZQkg2TfaTBy2uiNm/KNB1kh5S23u2p
         2CDTI4oN9YvdxQIMnQbxdqtdx/xtv3nbX2z5b9/zxaJR/oqDLbLZO4XCzywEZL8uG2c8
         jWZqBIwDK0fXJF25b9eghDZYlxBdLySBo2Fvz3todOYHcyBuUhHTZDySFe6C6Kx6NmMK
         /l+w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of alastair@au1.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=alastair@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of alastair@au1.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=alastair@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, mikey@neuling.org,
        vaibhav@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        malat@debian.org, felix@linux.vnet.ibm.com, pombredanne@nexb.com,
        sukadev@linux.vnet.ibm.com, npiggin@gmail.com,
        gregkh@linuxfoundation.org, arnd@arndb.de,
        andrew.donnellan@au1.ibm.com, fbarrat@linux.vnet.ibm.com,
        corbet@lwn.net, "Alastair D'Silva" <alastair@d-silva.org>
Subject: [PATCH v2 1/7] powerpc: Add TIDR CPU feature for Power9
Date: Wed, 18 Apr 2018 11:08:04 +1000
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180418010810.30937-1-alastair@au1.ibm.com>
References: <20180417020950.21446-1-alastair@au1.ibm.com>
 <20180418010810.30937-1-alastair@au1.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18041801-0040-0000-0000-00000430257F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041801-0041-0000-0000-0000263432EB
Message-Id: <20180418010810.30937-2-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-17_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804180008
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597957549327672109?=
X-GMAIL-MSGID: =?utf-8?q?1598044367812222789?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alastair D'Silva <alastair@d-silva.org>

This patch adds a CPU feature bit to show whether the CPU has
the TIDR register available, enabling as_notify/wait in userspace.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 arch/powerpc/include/asm/cputable.h | 3 ++-
 arch/powerpc/kernel/dt_cpu_ftrs.c   | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 4e332f3531c5..54c4cbbe57b4 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -215,6 +215,7 @@ static inline void cpu_feature_keys_init(void) { }
 #define CPU_FTR_P9_TM_HV_ASSIST		LONG_ASM_CONST(0x0000100000000000)
 #define CPU_FTR_P9_TM_XER_SO_BUG	LONG_ASM_CONST(0x0000200000000000)
 #define CPU_FTR_P9_TLBIE_BUG		LONG_ASM_CONST(0x0000400000000000)
+#define CPU_FTR_P9_TIDR			LONG_ASM_CONST(0x0000800000000000)
 
 #ifndef __ASSEMBLY__
 
@@ -462,7 +463,7 @@ static inline void cpu_feature_keys_init(void) { }
 	    CPU_FTR_CFAR | CPU_FTR_HVMODE | CPU_FTR_VMX_COPY | \
 	    CPU_FTR_DBELL | CPU_FTR_HAS_PPR | CPU_FTR_ARCH_207S | \
 	    CPU_FTR_TM_COMP | CPU_FTR_ARCH_300 | CPU_FTR_PKEY | \
-	    CPU_FTR_P9_TLBIE_BUG)
+	    CPU_FTR_P9_TLBIE_BUG | CPU_FTR_P9_TIDR)
 #define CPU_FTRS_POWER9_DD1 ((CPU_FTRS_POWER9 | CPU_FTR_POWER9_DD1) & \
 			     (~CPU_FTR_SAO))
 #define CPU_FTRS_POWER9_DD2_0 CPU_FTRS_POWER9
diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
index 11a3a4fed3fb..10f8b7f55637 100644
--- a/arch/powerpc/kernel/dt_cpu_ftrs.c
+++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
@@ -722,6 +722,7 @@ static __init void cpufeatures_cpu_quirks(void)
 	if ((version & 0xffff0000) == 0x004e0000) {
 		cur_cpu_spec->cpu_features &= ~(CPU_FTR_DAWR);
 		cur_cpu_spec->cpu_features |= CPU_FTR_P9_TLBIE_BUG;
+		cur_cpu_spec->cpu_features |= CPU_FTR_P9_TIDR;
 	}
 }
 
-- 
2.14.3
