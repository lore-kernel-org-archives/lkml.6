Return-Path: <alastair@au1.ibm.com>
X-Google-Smtp-Source: AIpwx4/31bU4XFlyHexqInmzo5rkkFCCTuG4C5QRxtyxY6ltuQNcT/eH/7E4418l2xVzesCeAffP
ARC-Seal: i=1; a=rsa-sha256; t=1523931075; cv=none;
        d=google.com; s=arc-20160816;
        b=erWf/7WIZSgNIV/1fXx+mdSjiDgbwb3C+7tmAoTFgvEU3MkxrtUQNA7jiNkuMB1Mjb
         F5I3KlLNzV1+wjiUjB2XIbpSzu9mcg1DOCzs9TZVqm/dMRx0jY7QyTSMpSg0be93/5Dj
         1KMZhy5oVmX4QKofHkLGb0wTOg3MX+WJ1Nb9eCasJHyLNt1r9z+Su+jZwugxY3DiRsov
         4bfB7nT/HaH9+Skk9bOysJ5Qo5FX41tzLIx9vs9x23XkIz3VbBH9Kk82B2nXbRv7yLe8
         E3HQXFeJyBdK56TEshVXnj4ZE4pk/ZAkumUz3IEmKj6i6VxL3l56C5/AbJ+szzVBghFd
         dRow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:references:in-reply-to:date:subject:cc:to:from
         :arc-authentication-results;
        bh=sIeNdRcq+29+phaKxlnIjHF4fAERR6YeDhd9jeIYnzU=;
        b=nbMHx2EzC8mxVNC7qSNMh9UHatGKggcAnJkg4YSXxpAa056Hyolv0Q5vnrUO88Brto
         9ommVvjE7uHtotHUsmC1I0gSA71BjfUKhZtL6z8piFeoLJryZpmBBgfqVH5NC5yMIIyz
         rvsVJthYozfvwyvbpbs8HlGLIAsLmVG7K87y8Cb3O9HPtVdP9xUqPioN0ksbr7GJldK/
         XNYOP3/3R3RAl8okct76f/XAbNBbyu2gj+rP50zSYSPUO1VppiW2rQUysPCNh2SFr1un
         c/jX/fnTvKnqSIka/gHrTjEgqduEZ6i5wnFbt+wLgBGbBybB3O0F4nwce2P2JYu107+t
         AvOw==
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
Subject: [PATCH 7/7] ocxl: Document new OCXL IOCTLs
Date: Tue, 17 Apr 2018 12:09:50 +1000
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180417020950.21446-1-alastair@au1.ibm.com>
References: <20180417020950.21446-1-alastair@au1.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18041702-0020-0000-0000-00000412A93D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041702-0021-0000-0000-000042A6E625
Message-Id: <20180417020950.21446-8-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-17_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804170020
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597957551491860164?=
X-GMAIL-MSGID: =?utf-8?q?1597957551491860164?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alastair D'Silva <alastair@d-silva.org>

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 Documentation/accelerators/ocxl.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/accelerators/ocxl.rst b/Documentation/accelerators/ocxl.rst
index ddcc58d01cfb..144595a80a1c 100644
--- a/Documentation/accelerators/ocxl.rst
+++ b/Documentation/accelerators/ocxl.rst
@@ -157,6 +157,16 @@ OCXL_IOCTL_GET_METADATA:
   Obtains configuration information from the card, such at the size of
   MMIO areas, the AFU version, and the PASID for the current context.
 
+OCXL_IOCTL_ENABLE_P9_WAIT:
+
+  Allows the AFU to wake a userspace thread executing 'wait'. Returns
+  information to userspace to allow it to configure the AFU.
+
+OCXL_IOCTL_GET_PLATFORM:
+
+  Notifies userspace as to the platform the kernel believes we are on,
+  which may differ from what userspace believes. Also reports on which CPU
+  features which are usable from userspace.
 
 mmap
 ----
-- 
2.14.3
