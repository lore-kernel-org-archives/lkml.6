Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-557887-1524653250-2-16378903967447733703
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524653249; b=W+cPqF8RWxs7WX3sE8i9PfKpK0a+WNMlmK5c514MofK6Xr5DdY
    kCigI2Q6sDZ2Ln6j3Zb1w8glhv3zUWlK1JBLLZxqRNPb9HDT6SPXylrTWVlgq1OT
    3oBN+GUyuBxyJlOngIUZe/2zpDP0nqiKs+uzfTdABzlSqgmm30H+ytt9toT6cKHv
    33CMptwvly5MPuq8ZUyBIzMvF4dQbQ+psWD08rwzb6V1kkqWG+f8HMtDkKzJqja6
    uAFeOP+sEf/pD22dv85r/zW5XErk7x4SWBWpQ+yPeMxRv8WidSDeIHd6EWmX8Eeu
    jxLho9CDy9uR76OHDD7DCuwP6ly69WiaDk3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524653249;
    bh=1GA+SPwk2WarCjW658xEDfngLHiEfrdrmofXSGePca0=; b=dX7U7VEGIltG
    bufoNvErdwpiOMpvsrpNgSwH4dDgBJgbgOVmCETeRLAzGK/tQjHFSqgQvlQX55cT
    B8jXIxfcDEP6B4Ec80D80/a/SL1vuwjHX9PfReiiguImhwTXsbDAGrySE6WkTYqS
    E4RK04kGDA7tIYecVnbJV4Cpg4jNhrgQsTvDNwo++PI/IPhClcf0zNiylGKTJE3E
    vvGy4eDxPJ9Is4b7k0YDKOWYVI6lfxQAs7//8TvNeqBjc48FsTvT88vNddP6227B
    Mvjblt+YKpSK61X37GiuuxIZGtBsQ9wWQx9ZAOwJ9oH5W88U7FCgFHn4yGuDBPOa
    H0IOkFN7mQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJp3odg9LQm0+T+/vxcnEJDc0iyRIpHcdcL9fdHENfo/iLBJlOEpMEo01U90C3AObGpxVeqGk5Nnee6AMnbmSzXyzFVIf59anlUqd/i/3r2c+1L8pCHY
    +YljSRFUuDok52mZDQhPcQDobfvplo83QFln6ypqibQLGIQ4hU3pDwUydJyNfKd/cZZdFrpX9rXbktqHcV5Vp4lIjRvrjZ5v79lVxqAg2Y3be8gTYMAlq0by
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=bLk-5xynAAAA:8 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=ZYL9rdB5uO8jsUQEEOIA:9
    a=GSrag2lr8gqMsfKb:21 a=P1TDJ5RHhcO7dryQ:21 a=QEXdDO2ut3YA:10
    a=zSyb8xVVt2t83sZkrLMb:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754294AbeDYKrB (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:47:01 -0400
Received: from mga11.intel.com ([192.55.52.93]:41831 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754452AbeDYKo5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 25 Apr 2018 06:44:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,326,1520924400";
   d="scan'208";a="223203204"
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: stable@vger.kernel.org
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org (open list:TPM DEVICE DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/3] tpm: add retry logic
Date: Wed, 25 Apr 2018 13:44:23 +0300
Message-Id: <20180425104425.5803-4-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425104425.5803-1-jarkko.sakkinen@linux.intel.com>
References: <20180425104425.5803-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: James Bottomley <James.Bottomley@HansenPartnership.com>

commit e2fb992d82c626c43ed0566e07c410e56a087af3 upstream

TPM2 can return TPM2_RC_RETRY to any command and when it does we get
unexpected failures inside the kernel that surprise users (this is
mostly observed in the trusted key handling code).  The UEFI 2.6 spec
has advice on how to handle this:

    The firmware SHALL not return TPM2_RC_RETRY prior to the completion
    of the call to ExitBootServices().

    Implementer’s Note: the implementation of this function should check
    the return value in the TPM response and, if it is TPM2_RC_RETRY,
    resend the command. The implementation may abort if a sufficient
    number of retries has been done.

So we follow that advice in our tpm_transmit() code using
TPM2_DURATION_SHORT as the initial wait duration and
TPM2_DURATION_LONG as the maximum wait time.  This should fix all the
in-kernel use cases and also means that user space TSS implementations
don't have to have their own retry handling.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: stable@vger.kernel.org
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 drivers/char/tpm/tpm-interface.c | 75 +++++++++++++++++++++++++-------
 drivers/char/tpm/tpm.h           |  1 +
 2 files changed, 61 insertions(+), 15 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index f71352cf7552..255db6fe15c8 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -399,21 +399,10 @@ static void tpm_relinquish_locality(struct tpm_chip *chip)
 	chip->locality = -1;
 }
 
-/**
- * tpm_transmit - Internal kernel interface to transmit TPM commands.
- *
- * @chip: TPM chip to use
- * @space: tpm space
- * @buf: TPM command buffer
- * @bufsiz: length of the TPM command buffer
- * @flags: tpm transmit flags - bitmap
- *
- * Return:
- *     0 when the operation is successful.
- *     A negative number for system errors (errno).
- */
-ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
-		     u8 *buf, size_t bufsiz, unsigned int flags)
+static ssize_t tpm_try_transmit(struct tpm_chip *chip,
+				struct tpm_space *space,
+				u8 *buf, size_t bufsiz,
+				unsigned int flags)
 {
 	struct tpm_output_header *header = (void *)buf;
 	int rc;
@@ -544,6 +533,62 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
 	return rc ? rc : len;
 }
 
+/**
+ * tpm_transmit - Internal kernel interface to transmit TPM commands.
+ *
+ * @chip: TPM chip to use
+ * @space: tpm space
+ * @buf: TPM command buffer
+ * @bufsiz: length of the TPM command buffer
+ * @flags: tpm transmit flags - bitmap
+ *
+ * A wrapper around tpm_try_transmit that handles TPM2_RC_RETRY
+ * returns from the TPM and retransmits the command after a delay up
+ * to a maximum wait of TPM2_DURATION_LONG.
+ *
+ * Note: TPM1 never returns TPM2_RC_RETRY so the retry logic is TPM2
+ * only
+ *
+ * Return:
+ *     the length of the return when the operation is successful.
+ *     A negative number for system errors (errno).
+ */
+ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
+		     u8 *buf, size_t bufsiz, unsigned int flags)
+{
+	struct tpm_output_header *header = (struct tpm_output_header *)buf;
+	/* space for header and handles */
+	u8 save[TPM_HEADER_SIZE + 3*sizeof(u32)];
+	unsigned int delay_msec = TPM2_DURATION_SHORT;
+	u32 rc = 0;
+	ssize_t ret;
+	const size_t save_size = min(space ? sizeof(save) : TPM_HEADER_SIZE,
+				     bufsiz);
+
+	/*
+	 * Subtlety here: if we have a space, the handles will be
+	 * transformed, so when we restore the header we also have to
+	 * restore the handles.
+	 */
+	memcpy(save, buf, save_size);
+
+	for (;;) {
+		ret = tpm_try_transmit(chip, space, buf, bufsiz, flags);
+		if (ret < 0)
+			break;
+		rc = be32_to_cpu(header->return_code);
+		if (rc != TPM2_RC_RETRY)
+			break;
+		delay_msec *= 2;
+		if (delay_msec > TPM2_DURATION_LONG) {
+			dev_err(&chip->dev, "TPM is in retry loop\n");
+			break;
+		}
+		tpm_msleep(delay_msec);
+		memcpy(buf, save, save_size);
+	}
+	return ret;
+}
 /**
  * tpm_transmit_cmd - send a tpm command to the device
  *    The function extracts tpm out header return code
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index f895fba4e20d..d73f3fb81b42 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -108,6 +108,7 @@ enum tpm2_return_codes {
 	TPM2_RC_COMMAND_CODE    = 0x0143,
 	TPM2_RC_TESTING		= 0x090A, /* RC_WARN */
 	TPM2_RC_REFERENCE_H0	= 0x0910,
+	TPM2_RC_RETRY		= 0x0922,
 };
 
 enum tpm2_algorithms {
-- 
2.17.0
