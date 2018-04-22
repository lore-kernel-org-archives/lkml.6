Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2630128-1524406585-2-15335946302928302372
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
    1524406584; b=IyKUV/sn8FdGp4KjBtOOh+TEF/RY5JS60RWCIvTozpEoOkqWGC
    BNq0AFQoTAEHP3h8k0TukvdDG74h79lNzSCh47F27HmfcL928V7+oiJO2B1GoQTM
    sMNDslBZG6aeg7hFuZq8Pu1+ccCxSW2ZuUNxqXns2LGoJH8HyMIY3oJ0w+fyw0/1
    BTpt5988+mj5qO5FXa1+Ih6mKMlQLNAnXySFNrBOsCM7+ZjUOnDCHQdA3HBFa+w8
    jRGqb+j+BdZtCmPmdgOF+SjbqfuZJtL+Ei5nOkkCPwyfDwtJIez+cLKENPxwFh9L
    DhXPNIGHa1KHKn0nZXmRP88E/V3Bt4WEbW8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524406584; bh=Fseu/ebQ7Tok2feFjRNapdWABtR8ly
    hTIclm5UTyllo=; b=bhJARqfwoz83hXeMTVcUWHVBMx4USZ7x4I+XrL+D5yqc9y
    zcR+ZVTsUMzJsna19usBE/pqzILaxL/M53VtLwVbBX9PUs2fx4BBiM2KNNqCPk9B
    rt7C3csX5iWckJhFam+nS/L777F7q1okxcqcFE/xySJVnh0TxYqUvlgiqH5F3IJt
    7Jn+7A/Rjx/ZVHxqiSCXef37x0Plltk9oLaBg6tVHJ9a/8XZdXGT7LljgZ6QbNar
    InynCCAZRnE7w6V0/A0hyEd/FSL3/KORUtHgbQzidCey4FGpy2kjpr5FSG5FFcch
    v9qey7MAoNK9WovsBi4vWTpWTkc7iIRhXdo9dyuQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfF1OKG08d1ALMRdgPnPITaWSZ0DDNGsYd+matDP3stUi/Hy1jOdVhcCisB16K2Ywi/r9AvX+rLT5GFh1Ay9ztU7z2WM/BuCEjsbm9mPc/Who+p7Alk6J
    UJquzgVVBNiouRbcGB8Fh9EsA/BCX7j+NbpMdKG7GLtZg59AmEb4R1ES+b+GQE+59CWacv5ElpQUL2ZvzfOSLTJInGrTF0pefTqTyB2ggmmZVXbnG8vYfLqE
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=P-IC7800AAAA:8 a=pGLkceISAAAA:8 a=ag1SF4gXAAAA:8
    a=dt7MVP1FYSxYmmJaYfUA:9 a=PZxxQsycSmwCV1kr:21 a=gpNlxYgn0wZoR4ZA:21
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=d3PnA9EDa4IxuAV0gXij:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932209AbeDVOQQ (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:16:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57324 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932105AbeDVOQO (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:16:14 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Artem Bityutskiy <dedekind1@gmail.com>
Subject: [PATCH 4.4 25/97] ubi: Reject MLC NAND
Date: Sun, 22 Apr 2018 15:53:03 +0200
Message-Id: <20180422135306.451761209@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Richard Weinberger <richard@nod.at>

commit b5094b7f135be34630e3ea8a98fa215715d0f29d upstream.

While UBI and UBIFS seem to work at first sight with MLC NAND, you will
most likely lose all your data upon a power-cut or due to read/write
disturb.
In order to protect users from bad surprises, refuse to attach to MLC
NAND.

Cc: stable@vger.kernel.org
Signed-off-by: Richard Weinberger <richard@nod.at>
Acked-by: Boris Brezillon <boris.brezillon@bootlin.com>
Acked-by: Artem Bityutskiy <dedekind1@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/ubi/build.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/drivers/mtd/ubi/build.c
+++ b/drivers/mtd/ubi/build.c
@@ -889,6 +889,17 @@ int ubi_attach_mtd_dev(struct mtd_info *
 		return -EINVAL;
 	}
 
+	/*
+	 * Both UBI and UBIFS have been designed for SLC NAND and NOR flashes.
+	 * MLC NAND is different and needs special care, otherwise UBI or UBIFS
+	 * will die soon and you will lose all your data.
+	 */
+	if (mtd->type == MTD_MLCNANDFLASH) {
+		pr_err("ubi: refuse attaching mtd%d - MLC NAND is not supported\n",
+			mtd->index);
+		return -EINVAL;
+	}
+
 	if (ubi_num == UBI_DEV_NUM_AUTO) {
 		/* Search for an empty slot in the @ubi_devices array */
 		for (ubi_num = 0; ubi_num < UBI_MAX_DEVICES; ubi_num++)
