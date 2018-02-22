Return-Path: <alastair@au1.ibm.com>
X-Google-Smtp-Source: AG47ELuoC32PI4JkWVRKUG19DqWX2/40aHX3Zd8+o+x/iS7TP2q/0iw0UdJ/ECT0kWrPDkKOr1Ii
ARC-Seal: i=1; a=rsa-sha256; t=1519268682; cv=none;
        d=google.com; s=arc-20160816;
        b=vAslBq8Yvjo3c6/2z4TWe69IkTHHrS0B+POqfrmJvmH+2AaRNizhrqb3LIYf62yfVh
         ODolLOvFg589IOXox7JQbrXRtdG0xj3Jb2wReb7SmysrUZm0yAb7d1NnkeHhpKb6QZO0
         m9QP16i6iyxmY7txR1jssyz4M7J3EUuWjpHLGWymPBiDieMNl2TFk+Nk2fOnvOqaYDYo
         /TE+F36PdE4rxRwnUz78TenlmHeMHd5zoEXux6sinE+/gYejZ1Ss8xNpafI0YSlrkBAU
         N/2j26ZxIBTBDQhI2R//SSgk5MyCkxr9VR6RQ56XHqBtZz7BR9iQUeZ6me6jG4kRqbE7
         9L+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:references:in-reply-to:date:subject:cc:to:from
         :arc-authentication-results;
        bh=Xm05GBSKsCmZmKNxJ+Y2zr10ntonOj5mFOtEejVNkvI=;
        b=oYogakCoa+9ddNR2fVNQHCP5OpbrKW/OhDXr/JwGGcKHXDvLOwKd5WrPYfKP84k/fQ
         Uw/oFFdl5rEqIJ+ZtUirHfN5TuNh4TE7jEWSTNlFRtpK4HHEgrdEE0SpVwIgOQIPO6YY
         LnjkL1AIwd+I8W56jwSquXo7s1XeFMPA/aFYXlG1j6Cs5WmcDoRSpJoW9Tbc/E45cBh7
         HyQBzAQrkB/ergF7mXoaKCPgQqKV3Sc54gIZOwhhAdpjsGCdwdExIllNzNAUQUUUrwN7
         Pcm7zRzyzPEDPVt3w672cbk+G+Aq++b382BSXDezUHFZwp8owGeb01/h6eCFN39DqnuV
         1B3Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of alastair@au1.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=alastair@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of alastair@au1.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=alastair@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Cc: frederic.barrat@fr.ibm.com, andrew.donnellan@au1.ibm.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, alastair@au1.ibm.com,
        "Alastair D'Silva" <alastair@d-silva.org>
Subject: [PATCH v2 2/2] ocxl: Document the OCXL_IOCTL_GET_METADATA IOCTL
Date: Thu, 22 Feb 2018 14:03:34 +1100
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180222030334.14060-1-alastair@au1.ibm.com>
References: <20180222030334.14060-1-alastair@au1.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18022203-0016-0000-0000-000005284E2C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022203-0017-0000-0000-0000286464E2
Message-Id: <20180222030334.14060-3-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-22_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802220038
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593068678696230639?=
X-GMAIL-MSGID: =?utf-8?q?1593068678696230639?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alastair D'Silva <alastair@d-silva.org>

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 Documentation/accelerators/ocxl.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/accelerators/ocxl.rst b/Documentation/accelerators/ocxl.rst
index 4f7af841d935..ddcc58d01cfb 100644
--- a/Documentation/accelerators/ocxl.rst
+++ b/Documentation/accelerators/ocxl.rst
@@ -152,6 +152,11 @@ OCXL_IOCTL_IRQ_SET_FD:
   Associate an event fd to an AFU interrupt so that the user process
   can be notified when the AFU sends an interrupt.
 
+OCXL_IOCTL_GET_METADATA:
+
+  Obtains configuration information from the card, such at the size of
+  MMIO areas, the AFU version, and the PASID for the current context.
+
 
 mmap
 ----
-- 
2.14.3
