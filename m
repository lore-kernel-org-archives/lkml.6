Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-897776-1525271968-2-12641765690709274679
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525271967; b=Nhr9tRcq2lt6vkRbiowjZn6/5kg6swnHBO7LpS1M00DYaGdE3u
    5V0ZrNa0f3D3Lg/8lQuLVyYr4WOW9AQsXTNyCIMmk4aFtd7G8BnWUuwBEiczHkq8
    rHZSVJd9T7k6wrjdQrgEHyiB1ey588p1KADBCYBmOmWSS+qEQOyvO8Ni/QTAoIqm
    6HSWm0ApTxZOXewGWLgoRA3pFA2cIEJI20zeo/E7GsM3augcwP7nr4Peaa03xty2
    HPNcmnOp9j1THNw+Z81qWni9FQi/7+GPiUK00KYpH83K9QUlyu4hNrzKae0Pl8ig
    ngEp8sxabn8DKxZDI/FHYUxN6UICJlvlAEXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525271967; bh=
    jrMmW0/OpfRv9Wxo2Hi//rLuuYHF91njT5rjPctpiXI=; b=Ho2pg3bT2q9q52Bz
    KbLFW5JL9MgGwEDawybUqyabjZTfwzG9l25WKGMjG4HzlUgTCkHqB+q/+vS3Y0rZ
    +5qehO5qhpwskFAdntrCS7wO1Qfx13lsd4udSVjsC1Ebrao7Be3Yb02fV7DP2uGq
    dYoSXeKLuIb7/Tes6GwfmIk203B8D2XJQQZ0087nImDNNfMbhIgckxqybzGfJ+yD
    ZL/fA3F8BiJIyKtXG5kY8istGJ1YPwyKr1QDy/P+D3SAy53z67r/D7uiYTgLzbUU
    +ga27w/YOGpwitVJy39VummedFMPSTtH6LGMxAPorHZI/WP5nhdbbJ44Wey++V7e
    M7HlRA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.intel.com header.result=pass
    header_org.domain=intel.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.intel.com header.result=pass
      header_org.domain=intel.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHwXkGeMMzHIyAtouXzRqZsm0+b0tdxsGApFFVq4wacT6T2nGlaX6FkrabMWA/9T3oE04ZkRT3ighMIzNctwMlTOG0TwkunjHeqEi9e1XaaX2EQFsiEs
    QB2LT7telJ+f6763EueFdUztmyDR3DD2zcwOkt9Ja1oqd25e8IzM8jYGHkrWASbDnkIcFceyUmQvky9fSbbpbnx0lcoYh2P8ooL5+1dLjDzrDN+96Hr+f6NL
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=QX4gbG5DAAAA:8
    a=cm27Pg_UAAAA:8 a=B-4895p5AAAA:8 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8
    a=GLfBnjawS6cr2_Z4g3YA:9 a=AbAUZ8qAyYyZVLSsDulk:22 a=xmb-EsYY8bH0VWELuYED:22
    a=CvvKU93EpHcLr5xCDv7z:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751701AbeEBOjN (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 10:39:13 -0400
Received: from mga02.intel.com ([134.134.136.20]:52865 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751408AbeEBOiq (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 2 May 2018 10:38:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,354,1520924400";
   d="scan'208";a="52592167"
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: stable@vger.kernel.org
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Sonny Rao <sonnyrao@chromium.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <james.l.morris@oracle.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Marcel Selhorst <tpmdd@selhorst.net>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        tpmdd-devel@lists.sourceforge.net (moderated list:TPM DEVICE DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] tpm: do not suspend/resume if power stays on
Date: Wed,  2 May 2018 17:38:28 +0300
Message-Id: <20180502143830.3534-2-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180502143830.3534-1-jarkko.sakkinen@linux.intel.com>
References: <20180502143830.3534-1-jarkko.sakkinen@linux.intel.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Enric Balletbo i Serra <enric.balletbo@collabora.com>

commit b5d0ebc99bf5d0801a5ecbe958caa3d68b8eaee8 upstream

The suspend/resume behavior of the TPM can be controlled by setting
"powered-while-suspended" in the DTS. This is useful for the cases
when hardware does not power-off the TPM.

Signed-off-by: Sonny Rao <sonnyrao@chromium.org>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: James Morris <james.l.morris@oracle.com>
---
 drivers/char/tpm/tpm-interface.c | 3 +++
 drivers/char/tpm/tpm.h           | 2 ++
 drivers/char/tpm/tpm_of.c        | 3 +++
 3 files changed, 8 insertions(+)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 830d7e30e508..5463b649bdf1 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -969,6 +969,9 @@ int tpm_pm_suspend(struct device *dev)
 	if (chip == NULL)
 		return -ENODEV;
 
+	if (chip->flags & TPM_CHIP_FLAG_ALWAYS_POWERED)
+		return 0;
+
 	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
 		tpm2_shutdown(chip, TPM2_SU_STATE);
 		return 0;
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index aa4299cf7e5a..41756a9e9ad8 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -143,6 +143,8 @@ enum tpm_chip_flags {
 	TPM_CHIP_FLAG_TPM2		= BIT(1),
 	TPM_CHIP_FLAG_IRQ		= BIT(2),
 	TPM_CHIP_FLAG_VIRTUAL		= BIT(3),
+	TPM_CHIP_FLAG_HAVE_TIMEOUTS	= BIT(4),
+	TPM_CHIP_FLAG_ALWAYS_POWERED	= BIT(5),
 };
 
 struct tpm_chip {
diff --git a/drivers/char/tpm/tpm_of.c b/drivers/char/tpm/tpm_of.c
index 570f30c5c5f4..669f4a046398 100644
--- a/drivers/char/tpm/tpm_of.c
+++ b/drivers/char/tpm/tpm_of.c
@@ -37,6 +37,9 @@ int read_log(struct tpm_bios_log *log)
 		return -ENODEV;
 	}
 
+	if (of_property_read_bool(np, "powered-while-suspended"))
+		chip->flags |= TPM_CHIP_FLAG_ALWAYS_POWERED;
+
 	sizep = of_get_property(np, "linux,sml-size", NULL);
 	if (sizep == NULL) {
 		pr_err("%s: ERROR - SML size not found\n", __func__);
-- 
2.17.0
