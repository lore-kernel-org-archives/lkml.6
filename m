Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2505978-1525351468-2-18355834899388933823
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
    1525351467; b=VvZioBIGfXHXcno3CxT3KTeZ7PAmE8AK4dcg63hPdgdlOZI0VW
    UIyxCZPgU1aT+qWfiPiQI+2nlheeKJB6rFdFC1wvCaDbCpntc4XgPKQG1jujo4h3
    xN7XnlQFw4GOWlk/DU00xwYmTatlyI9BDeLHI0wPd9nBXaI4cU40PL8enNn+OcJY
    Qz3lMOmAd55aqDXIYy+Xk4EI6dMo0B6eW4IHVja6x1CSCvG2keJ8dqm/jqa8K3Fq
    uu7eV5KCPagY+HUQXEPBOzRcbdg24EjaAX0a7nDwKaaBkIq/e0m1n7NZ+4q+GVK8
    WmQVCmr4ERLp42cWoC5B51REY97Q3wJnKknQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525351467; bh=
    HkKf1XhmG2eTTfCvXPxs40kVnswO3jtDrGDn+JT9YVE=; b=M3WFFnlpTfbVjWoc
    HveDzaeT/h8y2eyS2ZFhsU1re3Jq0mA2BGt1hY4OHj5ewQxwBrUlcAAYtFICwFax
    GcwR9f/AqPvv6KmuRzazFPWTtuNxdv2ss71U3QA6y9CrJclf9WNXjf2PjpTUdk7q
    wqnwWqd3r/sI39XGb9qej+tGoCiHVbtfZwXteUxdmzzXJAtp8hhYq6CMGia7N4Dg
    IKwryqfBZNLUiwQQjK7MhNlDNtee04hiY35fYFlXif1EBOTAapLKqLkw6q6arI2b
    5QXR1FLu+SURnii7EAn+hcOgfvjLvMHFxDRjhi9iNJnc/+3bIRCEvA8eEJz867oQ
    lppkTQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfJIVX0guiCR39olmEtoEWvl86utGWkTnFD6Yp9MbeqT+17VTv+oQtoC+ZOo1IkmImzlF3nGDNe9LLnoVo0pk63glVfG0UteFSb7TV8RuHu7YcGm8Hd1d
    7Xq8KSe0MiBydepbomVIxVgPl68qrvLnL49LZ/FAkBuQaoVjUGNqdDvYDNfaZIwqyvJvAP3DDzM5rNWXvfOhL8Vsf5lbqNp9l483Atd+g3HWorVdZ36wqcYl
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=EqdPLkY1AAAA:8
    a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=D19gQVrFAAAA:8 a=xNf9USuDAAAA:8
    a=QyXUC8HyAAAA:8 a=G8M7vhz_oh36SSMXCAgA:9 a=dfeKg4RqpEhWThG6bP4-:22
    a=AjGcO6oz07-iQ99wixmX:22 a=W4TVW4IDbPiebHqcZpNg:22 a=SEwjQc04WA-l_NiBhQ7s:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751751AbeECMoB (ORCPT <rfc822;greg@kroah.com>);
        Thu, 3 May 2018 08:44:01 -0400
Received: from mga17.intel.com ([192.55.52.151]:64796 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750999AbeECMn4 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 3 May 2018 08:43:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,358,1520924400";
   d="scan'208";a="52087207"
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
Date: Thu,  3 May 2018 15:43:34 +0300
Message-Id: <20180503124334.8468-3-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180503124334.8468-1-jarkko.sakkinen@linux.intel.com>
References: <20180503124334.8468-1-jarkko.sakkinen@linux.intel.com>
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
index 247dd2b6504a..be0547115d34 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -787,6 +787,10 @@ int tpm_do_selftest(struct tpm_chip *chip)
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
