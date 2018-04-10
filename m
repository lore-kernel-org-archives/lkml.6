Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-843308-1523402362-2-17868895954454998845
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523402362; b=IbIIbuSVOoNk+MF+AcMRzMpfGD7kP17DbPkii6S9pl7wEZviyC
    MtTp+6QaFB7FPChbPUG8NkeTmmRIa+8K+CEBTbE4eldx1ZBvzdc6o792pG4gJFxb
    AGcCoxZTpzOPOAOjDAUS/JgUnWVQsiAreaAXuugyAYpALpKhD7X8DXNWlR2U0zBH
    iAQJdFkVu8zJKjef74aWA4w59BE7azBDlP42UBfowrBOlyyC0N/Ml4V1wJCBZROU
    zcOso6IjhTM9QaK3XoNvQXsOzr6gxUIHxVJTQ66a/+FnoxQkPTi0iWaTpmTfbASG
    uH2LJpkSoovOiphdU46FJVlowdYgDqHyM/+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523402362; bh=y/RCjyM7bYxHBrm0S0jhko2VLkcPgn
    SzJkkuq5kEDAw=; b=UAXlnf1pC4sQgsoq1YZjupgITpU+II7OyQgwg/9nQCAXTW
    cnMvppbq7mBbUXwkLbN8MAI6+h7yhTv4LTi5V2+pdfMvcm3t6ZSSDiazre6P95OM
    XXQLjfBc5/2jRYoWXYqBWuAsMi7xne7gFfGEd8OL75ljYb4HRXdzR2/E8vBk25sy
    51vEHCebksdnpIH54uk113zGRbVhSK9iocR/NqmnjdnPLP18y5/M19K5V03IMEE5
    tRGs2WuLtAYfBSsImdsep9clH9uM7gN6TFZEmwScE40f350T7GOQ2xkKmgLkOiw9
    HNANIE9ux911QM/mS8fIRAqmCDYJ1dbED4Rc1Xwg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHg0i8ZpiiayhRATD245NkuVWg6wbqEQZBWNuWmM8pjd5rlWhOw/LMgDWTtkQgqY+9fmsNObc5VJUAhhhIxh4h/OM77SS/1havAMtAybiYyP+1216MbP
    GkTcxG0KZ7u1gd19/KJe4LDKIefWelNnn173aQa/sN+OVgPH+53iwfbqEOtrc+tEuMdZgKP5N55k6yl8vmI+tE5iKc/FBQarMUlMDjmr4+IVPEh+XHRP3NRi
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=uP1ucDPQAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=e-Ulp4OoBGIv1RnMydUA:9
    a=QEXdDO2ut3YA:10 a=9a9ggB8z3XFZH39hjkD6:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752989AbeDJWbN (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 18:31:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40292 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752785AbeDJWbM (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Apr 2018 18:31:12 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Miquel Raynal <miquel.raynal@free-electrons.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 102/168] mtd: mtd_oobtest: Handle bitflips during reads
Date: Wed, 11 Apr 2018 00:24:04 +0200
Message-Id: <20180410212804.588492445@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miquel Raynal <miquel.raynal@free-electrons.com>


[ Upstream commit 12663b442e5ac5aa3d6097cd3f287c71ba46d26e ]

Reads from NAND devices usually trigger bitflips, this is an expected
behavior. While bitflips are under a given threshold, the MTD core
returns 0. However, when the number of corrected bitflips is above this
same threshold, -EUCLEAN is returned to inform the upper layer that this
block is slightly dying and soon the ECC engine will be overtaken so
actions should be taken to move the data out of it.

This particular condition should not be treated like an error and the
test should continue.

Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mtd/tests/oobtest.c |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

--- a/drivers/mtd/tests/oobtest.c
+++ b/drivers/mtd/tests/oobtest.c
@@ -193,6 +193,9 @@ static int verify_eraseblock(int ebnum)
 		ops.datbuf    = NULL;
 		ops.oobbuf    = readbuf;
 		err = mtd_read_oob(mtd, addr, &ops);
+		if (mtd_is_bitflip(err))
+			err = 0;
+
 		if (err || ops.oobretlen != use_len) {
 			pr_err("error: readoob failed at %#llx\n",
 			       (long long)addr);
@@ -227,6 +230,9 @@ static int verify_eraseblock(int ebnum)
 			ops.datbuf    = NULL;
 			ops.oobbuf    = readbuf;
 			err = mtd_read_oob(mtd, addr, &ops);
+			if (mtd_is_bitflip(err))
+				err = 0;
+
 			if (err || ops.oobretlen != mtd->oobavail) {
 				pr_err("error: readoob failed at %#llx\n",
 						(long long)addr);
@@ -286,6 +292,9 @@ static int verify_eraseblock_in_one_go(i
 
 	/* read entire block's OOB at one go */
 	err = mtd_read_oob(mtd, addr, &ops);
+	if (mtd_is_bitflip(err))
+		err = 0;
+
 	if (err || ops.oobretlen != len) {
 		pr_err("error: readoob failed at %#llx\n",
 		       (long long)addr);
@@ -527,6 +536,9 @@ static int __init mtd_oobtest_init(void)
 	pr_info("attempting to start read past end of OOB\n");
 	pr_info("an error is expected...\n");
 	err = mtd_read_oob(mtd, addr0, &ops);
+	if (mtd_is_bitflip(err))
+		err = 0;
+
 	if (err) {
 		pr_info("error occurred as expected\n");
 		err = 0;
@@ -571,6 +583,9 @@ static int __init mtd_oobtest_init(void)
 		pr_info("attempting to read past end of device\n");
 		pr_info("an error is expected...\n");
 		err = mtd_read_oob(mtd, mtd->size - mtd->writesize, &ops);
+		if (mtd_is_bitflip(err))
+			err = 0;
+
 		if (err) {
 			pr_info("error occurred as expected\n");
 			err = 0;
@@ -615,6 +630,9 @@ static int __init mtd_oobtest_init(void)
 		pr_info("attempting to read past end of device\n");
 		pr_info("an error is expected...\n");
 		err = mtd_read_oob(mtd, mtd->size - mtd->writesize, &ops);
+		if (mtd_is_bitflip(err))
+			err = 0;
+
 		if (err) {
 			pr_info("error occurred as expected\n");
 			err = 0;
@@ -684,6 +702,9 @@ static int __init mtd_oobtest_init(void)
 		ops.datbuf    = NULL;
 		ops.oobbuf    = readbuf;
 		err = mtd_read_oob(mtd, addr, &ops);
+		if (mtd_is_bitflip(err))
+			err = 0;
+
 		if (err)
 			goto out;
 		if (memcmpshow(addr, readbuf, writebuf,
