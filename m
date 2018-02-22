Return-Path: <alastair@au1.ibm.com>
X-Google-Smtp-Source: AH8x224RKwCC4ER+r5KzJG0zCcec9lE8EXWr3X77ukT94LdzMpo0Rt0gutJeU/2HMJa2zg/MDW6Q
ARC-Seal: i=1; a=rsa-sha256; t=1519273108; cv=none;
        d=google.com; s=arc-20160816;
        b=mNCQCDCeW9rKArlyDGKRoXs7imW492pRRUFhS+X76v4Ehxtum3r9vPd5Tr5980m3vL
         EDO71GbOlRmPZvns2Bt3EpKneSvSgAK2wqFDZn/tODIUunC2a6tU/OP055TkEYfNGmKM
         MdFmWjhUQo3eXEimZ2BFkB7re9Iqm9DiGlN+2m10uzj6TNny1j7R9pUbWfdfV6+36hna
         7dbA0bYE+Kj2TjLZuA6npJxFQQQ3vwfzVi2WFSnRsrP/sRnBJT+92HdJqYnoRmyqq5Bn
         PD3Qp1AoXdELplKBKAvFvrrnnFx3RslVbL+VcgR9/YO/FFdf2/O4kU8wkdff19EoMILF
         F7Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:references:in-reply-to:date:subject:cc:to:from
         :arc-authentication-results;
        bh=7g7SoXwaEEnVnANyO1djIoEiPIRDYnZIr/wXGO9qA/Y=;
        b=ZUH3UE7/8bF5KCib35VFDsVmCK3JBpTNfNaIKB5SqhXXPQXaO1ePTOXiPI1IgC9PNg
         iHrJ4Gy7rdlUkB3PSUY7ixaMJzDJsWh+TyBs0dSOUXwQI02xcsS/dohpsJ4DAGo/A1XE
         1BqlKoIV3XdjO8ODlSJeTtUJsVpUu5s2qNDJ88vLm//xY6ckz/RYy81xz3C+DaTiGWOh
         039ZaLPI2DrdkGUxVO6Gb6Ts2wM1EUyi5yk0zPmzHV4fnRYYTRNNClgd4lI2LJwlCtMF
         89vFDvUpaU6uSFibO7JtDKZ1KtXPBvEJN0DKm59nRKELUQa6H8rLeV8gaaaPiP5Av4YJ
         M+8w==
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
Subject: [PATCH v3 0/2] Add get_metadata IOCTL to share OCXL information to userspace
Date: Thu, 22 Feb 2018 15:17:37 +1100
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180222030334.14060-1-alastair@au1.ibm.com>
References: <20180222030334.14060-1-alastair@au1.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18022204-0012-0000-0000-000005B35491
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022204-0013-0000-0000-0000192F6B63
Message-Id: <20180222041739.27899-1-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-22_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802220053
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593068674761029452?=
X-GMAIL-MSGID: =?utf-8?q?1593073319041899328?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alastair D'Silva <alastair@d-silva.org>

This series adds a new IOCTL for OpenCAPI, which exposes adapter
metadata to userspace.

--- 
v1->v2:
 - Document the new IOCTL

v2->v3:
 - Rename metadata struct
 - Document a couple of struct members that are not immediately obvious

Alastair D'Silva (2):
  ocxl: Add get_metadata IOCTL to share OCXL information to userspace
  ocxl: Document the OCXL_IOCTL_GET_METADATA IOCTL

 Documentation/accelerators/ocxl.rst |  5 +++++
 drivers/misc/ocxl/file.c            | 27 +++++++++++++++++++++++++++
 include/uapi/misc/ocxl.h            | 17 +++++++++++++++++
 3 files changed, 49 insertions(+)

-- 
2.14.3
