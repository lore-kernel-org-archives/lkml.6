Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2082923-1520269063-2-5994499541489768977
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520269063; b=EoRe1WGerC27O22UKEl2VDFVxCQ22VeqZLmF0DlHfLvgt5p
    HpLl6fqgJGu04ritg4+uaW0U15YzKXunf8lEQ43eiZkIVM4nCuIaQzZuMNuXWlBe
    1S4wjpvFMJoQmBJPMB5rCifFI4s3bDUgERi25D5PSwYT+bm2UtRaMDpZQhp19PPG
    nAzovT63oBbanr4kSEYfN8+mUPSQXGT9siPcbsnD5OcPSgiOdXuYec1Fk5Ufjnb9
    y4NdbGu9mE/BO7yRLiMylLLWTlryjxgZD+27iJRyhvo0sRwxSmomp68wIv1BrYX7
    z+9HnKpQrCyR1VW+HH5pHGqLSCwdzdR8qrw313w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1520269063;
    bh=3gTLm2ca4m1CcgikeDZsJ330ts2mmYBrOMhCFlNASQA=; b=KyxtZUy3xW2T
    EpCs87nvbIXzL5AVpRFHN/mZoaBNhBjgMSgNhuIWUroSRx9MCmiQWEPnqwKQwlww
    X2g4ONver6uChcMulmdRIdICPxU2OIuZ2JJi337RXe+yCkEkk1uljIHz2Chjfplk
    8rlUHXVofj9q9oAmo5NFOB1J7rr0oLntVw/BWfLiOFHuactv2FZIWn7sbxVhOS19
    ZOTCpJxmXYCYmzGhJcNq84dnB0eyvCiIUkLeD8T8Iyd7LynianeyGpxHdC4ZvUPC
    cyKpswInE9ZlZZxWj59y+tpXbkRyqX1NZaevfRx8oPHJ4qhV4AvIJkm1PCkJkNk4
    ioVc6s6pvw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752319AbeCEQ4a (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 11:56:30 -0500
Received: from mga11.intel.com ([192.55.52.93]:6970 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752081AbeCEQ41 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 5 Mar 2018 11:56:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,427,1515484800";
   d="scan'208";a="35627884"
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        stable@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkine@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 1/5] tpm: fix intermittent failure with self tests
Date: Mon,  5 Mar 2018 18:56:10 +0200
Message-Id: <20180305165614.5469-2-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180305165614.5469-1-jarkko.sakkinen@linux.intel.com>
References: <20180305165614.5469-1-jarkko.sakkinen@linux.intel.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: James Bottomley <James.Bottomley@HansenPartnership.com>

My Nuvoton 6xx in a Dell XPS-13 has been intermittently failing to work
(necessitating a reboot). The problem seems to be that the TPM gets into a
state where the partial self-test doesn't return TPM_RC_SUCCESS (meaning
all tests have run to completion), but instead returns TPM_RC_TESTING
(meaning some tests are still running in the background).  There are
various theories that resending the self-test command actually causes the
tests to restart and thus triggers more TPM_RC_TESTING returns until the
timeout is exceeded.

There are several issues here: firstly being we shouldn't slow down the
boot sequence waiting for the self test to complete once the TPM
backgrounds them.  It will actually make available all functions that have
passed and if it gets a failure return TPM_RC_FAILURE to every subsequent
command.  So the fix is to kick off self tests once and if they return
TPM_RC_TESTING log that as a backgrounded self test and continue on.  In
order to prevent other tpm users from seeing any TPM_RC_TESTING returns
(which it might if they send a command that needs a TPM subsystem which is
still under test), we loop in tpm_transmit_cmd until either a timeout or we
don't get a TPM_RC_TESTING return.

Finally, there have been observations of strange returns from a partial
test. One Nuvoton is occasionally returning TPM_RC_COMMAND_CODE, so treat
any unexpected return from a partial self test as an indication we need to
run a full self test.

[jarkko.sakkinen@linux.intel.com: cleaned up James' original commit and
 added a proper Fixes line]

Fixes: 2482b1bba5122 ("tpm: Trigger only missing TPM 2.0 self tests")
Cc: stable@vger.kernel.org
Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkine@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkine@linux.intel.com>
---
 drivers/char/tpm/tpm-interface.c | 20 ++++++++++++---
 drivers/char/tpm/tpm.h           |  1 +
 drivers/char/tpm/tpm2-cmd.c      | 54 ++++++++++++----------------------------
 3 files changed, 33 insertions(+), 42 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 9e80a953d693..1adb976a2e37 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -537,14 +537,26 @@ ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_space *space,
 			 const char *desc)
 {
 	const struct tpm_output_header *header = buf;
+	unsigned int delay_msec = TPM2_DURATION_SHORT;
 	int err;
 	ssize_t len;
 
-	len = tpm_transmit(chip, space, (u8 *)buf, bufsiz, flags);
-	if (len <  0)
-		return len;
+	for (;;) {
+		len = tpm_transmit(chip, space, (u8 *)buf, bufsiz, flags);
+		if (len <  0)
+			return len;
+		err = be32_to_cpu(header->return_code);
+		if (err != TPM2_RC_TESTING)
+			break;
+
+		delay_msec *= 2;
+		if (delay_msec > TPM2_DURATION_LONG) {
+			dev_err(&chip->dev, "the self test is still running\n");
+			break;
+		}
+		tpm_msleep(delay_msec);
+	}
 
-	err = be32_to_cpu(header->return_code);
 	if (err != 0 && desc)
 		dev_err(&chip->dev, "A TPM error (%d) occurred %s\n", err,
 			desc);
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index f895fba4e20d..cccd5994a0e1 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -104,6 +104,7 @@ enum tpm2_return_codes {
 	TPM2_RC_HASH		= 0x0083, /* RC_FMT1 */
 	TPM2_RC_HANDLE		= 0x008B,
 	TPM2_RC_INITIALIZE	= 0x0100, /* RC_VER1 */
+	TPM2_RC_FAILURE		= 0x0101,
 	TPM2_RC_DISABLED	= 0x0120,
 	TPM2_RC_COMMAND_CODE    = 0x0143,
 	TPM2_RC_TESTING		= 0x090A, /* RC_WARN */
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index a700f8f9ead7..89a5397b18d2 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -31,10 +31,6 @@ struct tpm2_startup_in {
 	__be16	startup_type;
 } __packed;
 
-struct tpm2_self_test_in {
-	u8	full_test;
-} __packed;
-
 struct tpm2_get_tpm_pt_in {
 	__be32	cap_id;
 	__be32	property_id;
@@ -60,7 +56,6 @@ struct tpm2_get_random_out {
 
 union tpm2_cmd_params {
 	struct	tpm2_startup_in		startup_in;
-	struct	tpm2_self_test_in	selftest_in;
 	struct	tpm2_get_tpm_pt_in	get_tpm_pt_in;
 	struct	tpm2_get_tpm_pt_out	get_tpm_pt_out;
 	struct	tpm2_get_random_in	getrandom_in;
@@ -827,16 +822,6 @@ unsigned long tpm2_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
 }
 EXPORT_SYMBOL_GPL(tpm2_calc_ordinal_duration);
 
-#define TPM2_SELF_TEST_IN_SIZE \
-	(sizeof(struct tpm_input_header) + \
-	 sizeof(struct tpm2_self_test_in))
-
-static const struct tpm_input_header tpm2_selftest_header = {
-	.tag = cpu_to_be16(TPM2_ST_NO_SESSIONS),
-	.length = cpu_to_be32(TPM2_SELF_TEST_IN_SIZE),
-	.ordinal = cpu_to_be32(TPM2_CC_SELF_TEST)
-};
-
 /**
  * tpm2_do_selftest() - ensure that all self tests have passed
  *
@@ -852,27 +837,24 @@ static const struct tpm_input_header tpm2_selftest_header = {
  */
 static int tpm2_do_selftest(struct tpm_chip *chip)
 {
+	struct tpm_buf buf;
+	int full;
 	int rc;
-	unsigned int delay_msec = 10;
-	long duration;
-	struct tpm2_cmd cmd;
 
-	duration = jiffies_to_msecs(
-		tpm2_calc_ordinal_duration(chip, TPM2_CC_SELF_TEST));
-
-	while (1) {
-		cmd.header.in = tpm2_selftest_header;
-		cmd.params.selftest_in.full_test = 0;
-
-		rc = tpm_transmit_cmd(chip, NULL, &cmd, TPM2_SELF_TEST_IN_SIZE,
-				      0, 0, "continue selftest");
+	for (full = 0; full < 2; full++) {
+		rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_SELF_TEST);
+		if (rc)
+			return rc;
 
-		if (rc != TPM2_RC_TESTING || delay_msec >= duration)
-			break;
+		tpm_buf_append_u8(&buf, full);
+		rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE, 0, 0,
+				      "attempting the self test");
+		tpm_buf_destroy(&buf);
 
-		/* wait longer than before */
-		delay_msec *= 2;
-		tpm_msleep(delay_msec);
+		if (rc == TPM2_RC_TESTING)
+			rc = TPM2_RC_SUCCESS;
+		if (rc == TPM2_RC_INITIALIZE || rc == TPM2_RC_SUCCESS)
+			return rc;
 	}
 
 	return rc;
@@ -1058,10 +1040,8 @@ int tpm2_auto_startup(struct tpm_chip *chip)
 		goto out;
 
 	rc = tpm2_do_selftest(chip);
-	if (rc != 0 && rc != TPM2_RC_INITIALIZE) {
-		dev_err(&chip->dev, "TPM self test failed\n");
+	if (rc && rc != TPM2_RC_INITIALIZE)
 		goto out;
-	}
 
 	if (rc == TPM2_RC_INITIALIZE) {
 		rc = tpm_startup(chip);
@@ -1069,10 +1049,8 @@ int tpm2_auto_startup(struct tpm_chip *chip)
 			goto out;
 
 		rc = tpm2_do_selftest(chip);
-		if (rc) {
-			dev_err(&chip->dev, "TPM self test failed\n");
+		if (rc)
 			goto out;
-		}
 	}
 
 	rc = tpm2_get_pcr_allocation(chip);
-- 
2.15.1
