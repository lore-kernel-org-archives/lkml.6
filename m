Return-Path: <alastair@au1.ibm.com>
X-Google-Smtp-Source: AIpwx4+L3iyzS3WRX/CgBPHjl6OHk3VlDdZmcL/xCRKNwgx8/nVakWzcyjZTlW8EAfnWwaGQquhX
ARC-Seal: i=1; a=rsa-sha256; t=1524013870; cv=none;
        d=google.com; s=arc-20160816;
        b=V/ilOdhJmtx23BUvPLfRuz5aw69NROrxzmpfdTsbRwgK3A8ZBUdXJ2niehNNYFS7AH
         XldQ0Ibepc/uwjyBjjGKNaFBf+NWPsa6ekBR5ho/mrjEr2btLDyuxhwyBbTkJZrgL2nA
         7SiConhD7XXhpOATD9XbBwmdtPRnCV+5yZwSrBlfdGDfC/9v84pQmCAYc/k34QzKonXs
         4YWVAy1ET173gnvPx2yulWwXIPPGMJNmWfZ6v4N5SMs+0pLChQFBd4Rg6+1sGQJHliXP
         tm+ljHxMIPQFGDEyQIaJ/UDLVCwL5peLUA5R6Qd8mEzhTLppmGPq6OxW2RZMHvr6Ml3G
         7Z5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:references:in-reply-to:date:subject:cc:to:from
         :arc-authentication-results;
        bh=XRGTnWIbj6n7f1xRbLWljtrn3ycqyeapIpbgdtFNOwc=;
        b=OX/F5eB1WmSpmWQDc/x+FpmQx+J5aZLb46avQdfZamCIEPwZHtgLtudr0G9N1kqJJx
         j+/01o9+U06uo6vIMX8FVbChFnDYIEMXjY9pPMPR8PEjihLDy8Vf1zOz4F/aNoZJSIF6
         pItAd6tldekgYWcR2/Ar76f7Jtgcelbt2QghzwbKP+e2IeiNe8wdHkJem2r+QX7LpTKJ
         0yEHxKLRWg5WTFnWgsUTrUCmZkHlUpdhbsRfqHMrl71prwiwUEytZnTrGOryDf6vC758
         PZhoa/UTgbC9yqWq3gciafv7ihGXS2p+ZwlfhLTm9CtbPOoTQbtlqKz3+BcDfCTpvSnl
         UMiA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of alastair@au1.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=alastair@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of alastair@au1.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=alastair@au1.ibm.com;
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
Subject: [PATCH v2 7/7] ocxl: Document new OCXL IOCTLs
Date: Wed, 18 Apr 2018 11:08:10 +1000
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180418010810.30937-1-alastair@au1.ibm.com>
References: <20180417020950.21446-1-alastair@au1.ibm.com>
 <20180418010810.30937-1-alastair@au1.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18041801-0008-0000-0000-000004EC75A8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041801-0009-0000-0000-00001E807C83
Message-Id: <20180418010810.30937-8-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-17_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804180008
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597957551491860164?=
X-GMAIL-MSGID: =?utf-8?q?1598044368574554545?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alastair D'Silva <alastair@d-silva.org>

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 Documentation/accelerators/ocxl.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/accelerators/ocxl.rst b/Documentation/accelerators/ocxl.rst
index 7904adcc07fd..3b8d3b99795c 100644
--- a/Documentation/accelerators/ocxl.rst
+++ b/Documentation/accelerators/ocxl.rst
@@ -157,6 +157,17 @@ OCXL_IOCTL_GET_METADATA:
   Obtains configuration information from the card, such at the size of
   MMIO areas, the AFU version, and the PASID for the current context.
 
+OCXL_IOCTL_ENABLE_P9_WAIT:
+
+  Allows the AFU to wake a userspace thread executing 'wait'. Returns
+  information to userspace to allow it to configure the AFU. Note that
+  this is only available on Power 9.
+
+OCXL_IOCTL_GET_FEATURES:
+
+  Reports on which CPU features that affect OpenCAPI are usable from
+  userspace.
+
 mmap
 ----
 
-- 
2.14.3
