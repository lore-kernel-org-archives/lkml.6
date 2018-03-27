Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-133548-1522172429-2-7655898149006244449
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522172429; b=HJ7j4thdlu1HCsMmA6PbfEgnkn+DpV1/bSgqZJLZ8ZhKmvD
    +QQxBUeZLLKQqp5ogsD0AT3IFP4tYQ8e2o3NXY9TsIgxHuR0DhqwhoL4NrI0wXed
    k32vNoIqpmFAgqb/rLjcT+4NhBpygmgIjwQ4uT3ivYCgbaiNoU2zxmT4gWukaDyQ
    Ri+YfW5vf0eEK9vvjvPFAfb/VTp6KOvYJchdEktPGEoIGGFn5iX36B/2kYZUC0Fb
    nyQPbFa13uNPHxoKl1LvKV0s52aRE1EABkJJufs6dqmJEJDxJqNnjAwO/+dKLyiS
    0L3oYjSKRqxeRqLd1wZxT+goVqiqARVi3kzLJHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1522172429; bh=GSlMdcIKzFihNBKRorcgLy7KUZ
    hTF3ZOwKMJwFEmwho=; b=lvOiH5V6uGZUzNWvGEPKnv6oAppvnDu5hBPf9Q52Ec
    6jgVucVmMLn/xbMGQgLdirEyEoAQqlQcI21cU1F2TpWd/PzjGv39nn/RGQ4MrO7n
    taAgF4FV/3D8Nu2nlZO880ROaCavW/EIjgukdAJN2P4Pj5kc8aWaMV8iu+QWG/oP
    Ce5nqezuPmO3O1q+hap/xzTkMduF8h+EY4hMH4d+OtXtzTLRWK4pBh9OdQe40fO0
    U3VHZ1PibX7zl6Jtl5/SfK15Rck/tX4LQG1FSY4mewVtTjE+4mjwq3oBw1hLMN1T
    wL7+ghNzsbBg2tdmxo6C0azTxqIRLCqf2p0BbytDaerg==
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
X-CM-Envelope: MS4wfK1oBrmcb8DKSxxQd7lfwBq2M5EYobkXeHg6rrGhBO4IMDmCVAzXlVgDWfffb3f31QvgvPED1b62HzSJl0MU4mqgcscsKWTaDKvB7rFDjMrckXzAL+7M
    vRyNzReKHcg0PakbIovh4GIe+WEh5GpwpKtp66V7ppp3fRWJJluZpBKOZSL6wk/6gHTrtU4taPXLKrxcy0+RxXO8th31pZzREUfXGqhPAoTEucKtlv5WhVwM
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=ag1SF4gXAAAA:8 a=uRY8H-xS08fNORsUMU4A:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=cvBusfyB2V15izCimMoJ:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752525AbeC0RkR (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 13:40:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44248 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754152AbeC0QeO (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 12:34:14 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bastian Stender <bst@pengutronix.de>,
        Jan Luebbe <jlu@pengutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.14 018/101] mmc: block: fix updating ext_csd caches on ioctl call
Date: Tue, 27 Mar 2018 18:26:50 +0200
Message-Id: <20180327162751.085101518@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bastian Stender <bst@pengutronix.de>

commit e74ef2194b41ba5e511fab29fe5ff00e72d2f42a upstream.

PARTITION_CONFIG is cached in mmc_card->ext_csd.part_config and the
currently active partition in mmc_blk_data->part_curr. These caches do
not always reflect changes if the ioctl call modifies the
PARTITION_CONFIG registers, e.g. by changing BOOT_PARTITION_ENABLE.

Write the PARTITION_CONFIG value extracted from the ioctl call to the
cache and update the currently active partition accordingly. This
ensures that the user space cannot change the values behind the
kernel's back. The next call to mmc_blk_part_switch() will operate on
the data set by the ioctl and reflect the changes appropriately.

Signed-off-by: Bastian Stender <bst@pengutronix.de>
Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/core/block.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -65,6 +65,7 @@ MODULE_ALIAS("mmc:block");
 #define MMC_BLK_TIMEOUT_MS  (10 * 60 * 1000)        /* 10 minute timeout */
 #define MMC_SANITIZE_REQ_TIMEOUT 240000
 #define MMC_EXTRACT_INDEX_FROM_ARG(x) ((x & 0x00FF0000) >> 16)
+#define MMC_EXTRACT_VALUE_FROM_ARG(x) ((x & 0x0000FF00) >> 8)
 
 #define mmc_req_rel_wr(req)	((req->cmd_flags & REQ_FUA) && \
 				  (rq_data_dir(req) == WRITE))
@@ -539,6 +540,24 @@ static int __mmc_blk_ioctl_cmd(struct mm
 	}
 
 	/*
+	 * Make sure the cache of the PARTITION_CONFIG register and
+	 * PARTITION_ACCESS bits is updated in case the ioctl ext_csd write
+	 * changed it successfully.
+	 */
+	if ((MMC_EXTRACT_INDEX_FROM_ARG(cmd.arg) == EXT_CSD_PART_CONFIG) &&
+	    (cmd.opcode == MMC_SWITCH)) {
+		struct mmc_blk_data *main_md = dev_get_drvdata(&card->dev);
+		u8 value = MMC_EXTRACT_VALUE_FROM_ARG(cmd.arg);
+
+		/*
+		 * Update cache so the next mmc_blk_part_switch call operates
+		 * on up-to-date data.
+		 */
+		card->ext_csd.part_config = value;
+		main_md->part_curr = value & EXT_CSD_PART_CONFIG_ACC_MASK;
+	}
+
+	/*
 	 * According to the SD specs, some commands require a delay after
 	 * issuing the command.
 	 */
