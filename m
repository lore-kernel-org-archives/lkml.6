Return-Path: <alastair@au1.ibm.com>
X-Google-Smtp-Source: AB8JxZpE16Y86hbHynsEmiV0YAVAlLpgjdzwt9vOCJ/1jrmdaQV0mjnDkOsOFZzxDmCm0QzoqR1o
ARC-Seal: i=1; a=rsa-sha256; t=1525826594; cv=none;
        d=google.com; s=arc-20160816;
        b=A2JN/Hoa/hHab2lQ+Vldyt59uQSorRKKIwCsbLlur8U1H7LDVFBWZxgvUBIAvVxxJn
         uODLxuFN4LlSinHAFOTTobbvAJ+BX6Li5xXirEXMM+hszTenvULZfSIvssQ+845A2ODs
         q/o0NOgj5tqMl+0nB97Cul3TQJMcI2VXnWoRN6tp6QSURsk370gAjNCjIQ5JPPH+5J0r
         qvW2YfFEk6x1YyiJFWxbsO7ezV4NTWbs4oP0srk8EtQC09Lu2N1/joDG14LFJmulsjAY
         LLdUDoruZN8JIzZvEJaNesmjKl1b7gtRPUAV3DarIP1q4JURaMEJrDU/OyHbhS/U2Bst
         6PPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:message-id:references
         :in-reply-to:date:subject:cc:to:from:arc-authentication-results;
        bh=QBWk05edE5mejVmSDUGvY2zYn3auSKeG01rIduiuSRs=;
        b=kNVyWHAH3GWm/UYce0VAH9Io6qbg+5UPutRDFdZW5SUbTIz+lTBGhvr0y4ySBBCdx6
         yqWiAY7V3TVPC37kJfHKthYqFanuHbgwU4ys0kwyCr9tNNbNunjR3aOehJbxdGsu/Kha
         SJWUNLopKU6bLukbXG7pDqdsBi93oDNUF1xCBD3deacJqwYyMi59tbuuvKTFFMcMQDv9
         DA/wuwIgN4OII9fzBGYhevnWyq0dvshUw5SphqGCOe545P92kUkZyl4AlFPwRrugPOUi
         gvMQS1pmOU2axToVPF8uXa/5WERICLAcD2BXryVs5lYErKeXUk0bbJQLzoTTWIrTxVLD
         opLA==
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
Subject: [PATCH v3 7/7] ocxl: Document new OCXL IOCTLs
Date: Wed,  9 May 2018 10:42:12 +1000
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180509004212.4506-1-alastair@au1.ibm.com>
References: <20180417020950.21446-1-alastair@au1.ibm.com>
 <20180509004212.4506-1-alastair@au1.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18050900-0012-0000-0000-000005D42CD2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050900-0013-0000-0000-000019513FE1
Message-Id: <20180509004212.4506-8-alastair@au1.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-08_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805090005
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597957551491860164?=
X-GMAIL-MSGID: =?utf-8?q?1599945147655737628?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alastair D'Silva <alastair@d-silva.org>

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 Documentation/accelerators/ocxl.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/accelerators/ocxl.rst b/Documentation/accelerators/ocxl.rst
index ddcc58d01cfb..14cefc020e2d 100644
--- a/Documentation/accelerators/ocxl.rst
+++ b/Documentation/accelerators/ocxl.rst
@@ -157,6 +157,17 @@ OCXL_IOCTL_GET_METADATA:
   Obtains configuration information from the card, such at the size of
   MMIO areas, the AFU version, and the PASID for the current context.
 
+OCXL_IOCTL_ENABLE_P9_WAIT:
+
+  Allows the AFU to wake a userspace thread executing 'wait'. Returns
+  information to userspace to allow it to configure the AFU. Note that
+  this is only available on POWER9.
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
