Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-897776-1525271939-2-15040294134504142643
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
    1525271938; b=Vj9ywTHh8JjGWDFIbsn2S1rBdBflFRpnMKOkj7Xs24ApGRvL1h
    CFgr1MQgH9nHxgZjmRkhIY9qjGQFAvb1Cerw/IpCxjql3nnvQACG2YT6bC54LEcx
    C4QKdgvdOdKUggIPB0T4qmkXzRcbnoFGEY/JLPZsDmGqO5A3iomnPHXmbZqJ2eCf
    m7JVtJn9dbIGkQEQN5K4dvJ5U2nTUVl19N8iKIEuOdXliDedU0WqJ4Gf6T+sUwKG
    q7C+60RdAq6HbQp7+IDpGRTPKCdb59y5KBJ2cacmzEZtB/C91HzoAyRhuVq+2Xx5
    o2/aMtBICRRRLUFyJuiMYeL5Acy3GO9iLUPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525271938; bh=
    Yz98tE2lPS8+Vb+v0YzmQhZ8lnuuyYJzX2iJqQFUsoo=; b=jbFAM/gGTxjmm3nk
    h0crWnVPxoDFDKYrOeVINg4Dztr0COTvayclai8QjJx5up2a5hpIW8LQ4naeJfL3
    J6E05yvFPv2gOdRf1dodR6vuiy9sOFylM4bVIKsqgarltyR5SjLJ0hnd7Uq1HyCS
    bQzVpSkP64H1oAHT/RHyxDGhEwzmjwUiJDXghDuambR3zq4yqoXmF3NNjT8K+acq
    XKjGq4RTqHOMl5wFpBGV7H4WxKZNa76Q2mq6eExl9k6nXkdajWj4bx8a3sfAWR60
    4GVqgVGFSKbPF6OpBbWpetsx8tO979M3mncj6r+ATmJLaNBJaU5d7qxK0F3TVU4H
    rB08qw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfE79M8Yv4+F26AuqY1oi/HzL680rkdOZz2KxB/hOFV1rT5LJ9RvPU57PHFhj4MqnJH0kiCOGDoWDNHduc/5P3q3fVMiI3bvDlCAl38wvTSl/5J0X3NN7
    ljxnTZIapocXH3nnJGH85OBMyRQZIQKXlTelIXPAicHtmRpIQYo+IgoyfOwh5ybq3T8imJ42LJmPwvBOcqj2FClo067iaMUBfeGJZ19Dm8WWL9NB8edNleGb
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=EqdPLkY1AAAA:8
    a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=D19gQVrFAAAA:8 a=xNf9USuDAAAA:8
    a=QyXUC8HyAAAA:8 a=G8M7vhz_oh36SSMXCAgA:9 a=dfeKg4RqpEhWThG6bP4-:22
    a=AjGcO6oz07-iQ99wixmX:22 a=W4TVW4IDbPiebHqcZpNg:22 a=SEwjQc04WA-l_NiBhQ7s:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751463AbeEBOiz (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 10:38:55 -0400
Received: from mga17.intel.com ([192.55.52.151]:18995 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751574AbeEBOiw (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 2 May 2018 10:38:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,354,1520924400";
   d="scan'208";a="52592208"
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: stable@vger.kernel.org
Cc: Chris Chiu <chiu@endlessm.com>, Daniel Drake <drake@endlessm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Marcel Selhorst <tpmdd@selhorst.net>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        tpmdd-devel@lists.sourceforge.net (moderated list:TPM DEVICE DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] tpm: self test failure should not cause suspend to fail
Date: Wed,  2 May 2018 17:38:29 +0300
Message-Id: <20180502143830.3534-3-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180502143830.3534-1-jarkko.sakkinen@linux.intel.com>
References: <20180502143830.3534-1-jarkko.sakkinen@linux.intel.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Chris Chiu <chiu@endlessm.com>

commit 0803d7befa15cab5717d667a97a66214d2a4c083 upstream

The Acer Acer Veriton X4110G has a TPM device detected as:
  tpm_tis 00:0b: 1.2 TPM (device-id 0xFE, rev-id 71)

After the first S3 suspend, the following error appears during resume:
  tpm tpm0: A TPM error(38) occurred continue selftest

Any following S3 suspend attempts will now fail with this error:
  tpm tpm0: Error (38) sending savestate before suspend
  PM: Device 00:0b failed to suspend: error 38

Error 38 is TPM_ERR_INVALID_POSTINIT which means the TPM is
not in the correct state. This indicates that the platform BIOS
is not sending the usual TPM_Startup command during S3 resume.
>From this point onwards, all TPM commands will fail.

The same issue was previously reported on Foxconn 6150BK8MC and
Sony Vaio TX3.

The platform behaviour seems broken here, but we should not break
suspend/resume because of this.

When the unexpected TPM state is encountered, set a flag to skip the
affected TPM_SaveState command on later suspends.

Cc: stable@vger.kernel.org
Signed-off-by: Chris Chiu <chiu@endlessm.com>
Signed-off-by: Daniel Drake <drake@endlessm.com>
Link: http://lkml.kernel.org/r/CAB4CAwfSCvj1cudi+MWaB5g2Z67d9DwY1o475YOZD64ma23UiQ@mail.gmail.com
Link: https://lkml.org/lkml/2011/3/28/192
Link: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=591031
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 drivers/char/tpm/tpm-interface.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 5463b649bdf1..faf2db122ab9 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -803,6 +803,10 @@ int tpm_do_selftest(struct tpm_chip *chip)
 	loops = jiffies_to_msecs(duration) / delay_msec;
 
 	rc = tpm_continue_selftest(chip);
+	if (rc == TPM_ERR_INVALID_POSTINIT) {
+		chip->flags |= TPM_CHIP_FLAG_ALWAYS_POWERED;
+		dev_info(&chip->dev, "TPM not ready (%d)\n", rc);
+	}
 	/* This may fail if there was no TPM driver during a suspend/resume
 	 * cycle; some may return 10 (BAD_ORDINAL), others 28 (FAILEDSELFTEST)
 	 */
-- 
2.17.0
