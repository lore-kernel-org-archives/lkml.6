Return-Path: <alastair@au1.ibm.com>
X-Google-Smtp-Source: AH8x224mK7imH2r0hVTEiGwjyuqjJ/B6vb+JLpj2QTpPG+m93CBgYyadPKQSVfj6LF/NZClRIb7T
ARC-Seal: i=1; a=rsa-sha256; t=1519268679; cv=none;
        d=google.com; s=arc-20160816;
        b=JRNU5xOTmROuHPNbwH7vwtDCAx78hXbU2zj2C7yq/ybyEg9ZVylMKzgBZgYgfOXLx4
         jnXKqPRuGBHG9ii6zSPkZ1BCzhmkLh3ghnEP5HZ0Qkvyh+xlBS4XOEzXXJz4HDPuuGbN
         vdEgQB26IXfKzAQ3ivtQ2x1EGKoAMA6x7qeTNRET6YSdxi4IkCYQGtayXwy1zTWV7Aog
         zHXvOiRqyswXA/nLwFZhonTPlqdLAFyPsLtE1VctSorNTZP2HoqQLQ6ollb+ZdZvqTCW
         Yas9WBcCGXvYwjD5e2x2g4uDcR9jT1oNKscd963Ru7vwCgUca+XVgaZ1pykQHA498mhK
         wn6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=ukUvthPG/lXfm+Qe1gaTi0KH/H6CUe8sIh4RVoDXhek=;
        b=oF79ZH/2SuiAQd4xU+6E8frf7vig2QQlQAIM1FoHVKBzZ5KIq45vk2jHeajkTL5ejU
         3jy71N8E3y0cwigFYAMFzPWiN8Od4gpNWUS9UBmDtrZaJKc3+mPHSgcXlsjECF2uIPXo
         Z8bnFojDI+SwJsgMhOlnJYvY43wV8eK2NozC/Db+WihIfCKrBBDO0/k1u5BKIoDS5602
         EsldKBYpMx8xaGRkSpIOmUCGZnirGILB22teRi3/oLZjhMvp/icvSCVgCk6sJHtcK9n9
         8Ii8sKFKnrZLPkkH+E7bj5meoYmbj8R1A3/Ajro3TQ1mMi4RPw36h7qxXWuc9ZrLO4pQ
         Oo/g==
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
Subject: [PATCH v2 0/2] Add get_metadata IOCTL to share OCXL information to userspace
Date: Thu, 22 Feb 2018 14:03:32 +1100
X-Mailer: git-send-email 2.14.3
X-TM-AS-GCONF: 00
x-cbid: 18022203-0040-0000-0000-0000041546E0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022203-0041-0000-0000-000026185A34
Message-Id: <20180222030334.14060-1-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-22_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802220038
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593068674761029452?=
X-GMAIL-MSGID: =?utf-8?q?1593068674761029452?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alastair D'Silva <alastair@d-silva.org>

This series adds a new IOCTL for OpenCAPI, which exposes adapter
metadata to userspace.

--- 
v1->v2:
 - Document the new IOCTL

Alastair D'Silva (2):
  ocxl: Add get_metadata IOCTL to share OCXL information to userspace
  ocxl: Document the OCXL_IOCTL_GET_METADATA IOCTL

 Documentation/accelerators/ocxl.rst |  5 +++++
 drivers/misc/ocxl/file.c            | 27 +++++++++++++++++++++++++++
 include/uapi/misc/ocxl.h            | 22 ++++++++++++++++++++++
 3 files changed, 54 insertions(+)

-- 
2.14.3
