Return-Path: <alastair@au1.ibm.com>
X-Google-Smtp-Source: AH8x225Afm4TRvan5Sff0lFcacQP4ujpadJgBmoZlvC4jr2f1VG5sKoImXN3uGVoI4Z73r9iDTow
ARC-Seal: i=1; a=rsa-sha256; t=1519273108; cv=none;
        d=google.com; s=arc-20160816;
        b=cpnj+Q/2DT/DfO+gUUUnAfDd3OsHNMJ1PLFS97YoPguNxjNEGPpLIIE9iXgRSFl6PR
         5vQsO4Ayn7yuDQMpuwSY1Bu+2QjEkIF0zCt/bwfvP5iRhYis5lyOxJxondj0CLue4LfJ
         rWwuyTgsUC4Yw5cG6TVlIOOQfA2LNnknJDy/ViQtZ5lNGpy0zlb9EBGjjSzxo5fU4D/M
         0P7kF6XUkGagmwYTcYd5VB/fheGc0LA+8rb3+dsl33f385DIVeQr3HlAkFKYe/VGkGt0
         4e4bQdsx9NcmIqHh2zQSFkJFQzC8/Om/RkGGyiV4MrmXRo70k79jC9fC2GncvNSwNBNf
         Ps3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:references:in-reply-to:date:subject:cc:to:from
         :arc-authentication-results;
        bh=Xm05GBSKsCmZmKNxJ+Y2zr10ntonOj5mFOtEejVNkvI=;
        b=C9by9E6QXBVs3g7vGBZ4Z7UkRMhyfLSTZxdKXTxJhWNPn4+gvIS4QvolmtCPyeO2AA
         0j18TKEg7l9h/i2zuV4Djh/K7itR5YqqSg1QIWRc3f9xbZTmlIK2YHwlPCdGHWIswinS
         FMAOcv9g7p7IDfjU37dueB6NQ7j+uZk2h6uuk5LtPrthY0LeJmVNCwUl3eewGzDuT+iu
         82Wv3+c+OA4lGcv3eszvA2725dbJZAuTdUJNH6zDQ9E0MRhgzA0RBnUjI/G6dTUaTdpY
         Rbtz5E/gKWWXvJggVUjVe6XF5gHCywFslM3zDsb4N24aJ5AMRwUOUE9S1ONCiyRqPVrE
         fYvA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of alastair@au1.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=alastair@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of alastair@au1.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=alastair@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Cc: frederic.barrat@fr.ibm.com, andrew.donnellan@au1.ibm.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, alastair@au1.ibm.com,
        "Alastair D'Silva" <alastair@d-silva.org>
Subject: [PATCH v3 2/2] ocxl: Document the OCXL_IOCTL_GET_METADATA IOCTL
Date: Thu, 22 Feb 2018 15:17:39 +1100
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180222041739.27899-1-alastair@au1.ibm.com>
References: <20180222030334.14060-1-alastair@au1.ibm.com>
 <20180222041739.27899-1-alastair@au1.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18022204-0040-0000-0000-0000043653E2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022204-0041-0000-0000-000020D86AF5
Message-Id: <20180222041739.27899-3-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-22_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802220053
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593068678696230639?=
X-GMAIL-MSGID: =?utf-8?q?1593073319471082591?=
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
