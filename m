Return-Path: <vitalya@ti.com>
X-Google-Smtp-Source: AG47ELuOrrWUwRyMQu4swMkfbiuAPb2dvXwi5E8rFpPPsj2Lbpcj07tEZOnkBWbKIelQrxJlQQxE
ARC-Seal: i=1; a=rsa-sha256; t=1519909028; cv=none;
        d=google.com; s=arc-20160816;
        b=FSYjabkwLOoNXNAmqNcWC3yF6Fv3zwP39a1yUxDV2eockoeYxekzMpQXZ/7mac7PmU
         ZEQ9x+T7C0KrUAN3fYdRg24O57cC3EqIocfsIFW3uQ4eDcnrRV2WyHR7/SBddgZ4TAhJ
         L6aHReJJEclYfAQxRxqKnrJuVZefq+cNk/kQXipRSWyfVub2cfUq5IMEZ/tKltikMIO5
         Pi6DB6D2X9RXNFhUAYqqLWFS4Rrux8nwu+LHb78icgHKesZ5GvZk9bESBdmAynoTKvHz
         dQOBZNd4HoFT1r1zIkfD2wdYoh9dPREHvDf7xnLSZ6hEoJDu4Xhu9X1ynWwXoG2h7vWp
         fAqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=xeTXXa1fVhE80zxc2xLTBGD1HKO5EvJlVxj2ClwWRNE=;
        b=QQjP1RlRlGcMPeALQoNuX1Im77vdTLBNIkaWZ1Uwjcm788vKmK+vjMp5LCAjyJW75o
         xJLrZrtG1aXBJfgSwQk9R340SG38NMTuxHsaQA2OsObrmVZPZu+G1hp24X2rWiiL9ZP9
         8pwwd1priMAN8J+iPyB82xtPODYOlJVLBOC0CvEVJ7rH3BxBN0eI5ROpM/jMYvmU/khy
         Io+IYzHC7sFNhfbbnzf6/RimTJpm5cOqXFuFZloMgAOTblV0y8woIfA2nbq4MGGSkUC2
         fCDa3kyUgOu++K2907f4oCGgKllL0T+AQoniXDjJnqzYqFJ1LaG0e6OpIWvz6yiU1Tbx
         hqvw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=SNrZRydZ;
       spf=pass (google.com: domain of vitalya@ti.com designates 198.47.19.16 as permitted sender) smtp.mailfrom=vitalya@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=SNrZRydZ;
       spf=pass (google.com: domain of vitalya@ti.com designates 198.47.19.16 as permitted sender) smtp.mailfrom=vitalya@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
From: Vitaly Andrianov <vitalya@ti.com>
To: <mpm@selenic.com>, <herbert@gondor.apana.org.au>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>
CC: <t-kristo@ti.com>, <vitalya@ti.com>, <m-karicheri2@ti.com>
Subject: [PATCH 0/2] Keystone2 HW random generator
Date: Thu, 1 Mar 2018 07:54:58 -0500
Message-ID: <1519908900-10388-1-git-send-email-vitalya@ti.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593740129743565231?=
X-GMAIL-MSGID: =?utf-8?q?1593740129743565231?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Keyston2 Security Accelerator has a hardware random generator sub-module.
This series adds the driver for the sub-module.

Vitaly Andrianov (2):
  Documentation: dt: rng: add bindings doc for Keystone SA HWRNG driver
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
