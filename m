Return-Path: <vitalya@ti.com>
X-Google-Smtp-Source: AG47ELvWA0K153W+lE4fNd+qU6li3lgBcsgAOgdo1oP/B8YawA52JV5jkQEciEBTOHfVDRbhq0Fp
ARC-Seal: i=1; a=rsa-sha256; t=1520962494; cv=none;
        d=google.com; s=arc-20160816;
        b=TWMT2bVYkv0LZYjWIpZfva4ewuqvSIwUjNZuxtrv2Q5v38V7Bb28ZxR9tJNI/JOU/8
         Zki8XLwVdqBEtT2YpUbEVBjb2f+3BckVoJTVPUERUKPm2r5O8cMZUs6qFq4Yh5hHf7oR
         MHL16lz0F+EOdiNsjdU5we96/FGtwoCeyzYxQXGNT3aF+jDIb34CK0esvncQ+y4MPQ7c
         ACHkOrspWroBZJN6mIboxAwq5MWU5ab+rvApN755tvwgJkRYmlnzqzVVcMcvlq9BXV8V
         +baRmbflb/R2iIHxcx5sxHh9ngKGi9UCGe8c/ek2gN3DWjmlZZ8N/tf8kB6wnsixaW0t
         zihg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=51VhcFeOrbG1PkbgE7n4N8EjBC6Yl/hS9PiG5hr0Zus=;
        b=STMWdnYQ5fwE3pHB4sEHzJM+cYXui4jx2wRhFkXrVEyTFvIhOj9fRVDoJnQYvSWcwd
         KWCJhM7ADNnuVd7SNy6FRqRAC5d+3DwpINOfT9fCz+Zr6vR0+3oJjqJpC8fXAACxsLdw
         ke+ZGt4gjrxS4Clv2igalnXYKr9s6X6bIYB2RQHawncDR4DOjf1Tsr2i72k+3EuM0scd
         ph4bJzhWFNArrEMJISmYSp9QE3uqa7duO9nvWHncDwDaT1YvysJi5GFq+9j6NfmbL9Gw
         mPQa5DAOlWL6cb/N4NLz3ApluR7pCUAnBJWj9R0iNZC5FbwgYJQzMtQ1veDpXjqFc3VN
         XQOg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=nufB5yiC;
       spf=pass (google.com: domain of vitalya@ti.com designates 198.47.27.80 as permitted sender) smtp.mailfrom=vitalya@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=nufB5yiC;
       spf=pass (google.com: domain of vitalya@ti.com designates 198.47.27.80 as permitted sender) smtp.mailfrom=vitalya@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
From: Vitaly Andrianov <vitalya@ti.com>
To: <mpm@selenic.com>, <herbert@gondor.apana.org.au>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>
CC: <t-kristo@ti.com>, <vitalya@ti.com>, <m-karicheri2@ti.com>
Subject: [PATCH v2 0/2] Keystone2 HW random generator
Date: Tue, 13 Mar 2018 13:33:29 -0400
Message-ID: <1520962411-18208-1-git-send-email-vitalya@ti.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594844768121976594?=
X-GMAIL-MSGID: =?utf-8?q?1594844768121976594?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Keyston2 Security Accelerator has a hardware random generator sub-module.
This series adds the driver for the sub-module.

Changes in v2:
- Changed subject prefix in 1/2 patch
- renamed dts node 

Vitaly Andrianov (2):
  dt-bindings: rng: add bindings doc for Keystone SA HWRNG driver
  hw_random: keystone2: add hw_random driver

 .../devicetree/bindings/rng/ks-sa-rng.txt          |  21 ++
 drivers/char/hw_random/Kconfig                     |   7 +
 drivers/char/hw_random/Makefile                    |   1 +
 drivers/char/hw_random/ks-sa-rng.c                 | 257 +++++++++++++++++++++
 4 files changed, 286 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rng/ks-sa-rng.txt
 create mode 100644 drivers/char/hw_random/ks-sa-rng.c

-- 
2.7.4
