Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1511654-1518325858-2-14562280350702781919
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518325857; b=rQGcJ4Rb5DM8pTmclFkA9Cj+UhIgc/GZd5yxNTmWwLwJFze
    nxT03FxbReg2w8rwsUMPrTo6hwOtN6mdT35OsA4VjPNc65+qkN8uApIoQuHfm+BM
    zsvTcO4d4jcURGhAwNPIqusc+GDDEEoSwR9XVKIuH4V4vRxVSj3rEkF6MeT6cXME
    hQQ+26unCS44gLhCPBWxjcgdSjuCr7bmlwv2bTCZ7q9zmeHdWQuknH4t4ljMcU4U
    8YfGVY+8abdoNR1VkolbLJppQ4kJPmA10hK0Sbt2+3A9pR2ldAADhzPszux6KxtW
    MIcrkHHA9TA0ba9NssnKugFO/EfZylCsGQ6zJHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518325857; bh=RjuZ2v/1ESR1cHPUsIi
    aG7rpeDFHh4wHDjm9vyaHPhw=; b=S8D65UAambYv7H1cu+W+99UYbcQhT0LZafZ
    TL2AUQRQyHw64nIV44UPI7PtDxTDU0lNWtXPcALgorIjh1e23jf9Pn9Z0C3TlHlM
    mv9ENsBmbS428Scd1gT3hVstqXI5jH8hyxdxzx6AKjvwtQ6q27LpEL69WY96sH4L
    iH/PD9JAFwoKQuMyTfnUEBuFzRGt4pecqtqAWVDXiGrIim7X/CgsaNWw8CPW4wim
    x4L0mAfn0nvOjZYAppBlDKrH8liMKt6ROlOFUrA3k/VUdRBw3+tBBMUIB6rEUnw7
    DU3EUZ7fEwXdfd8TesaserotBuchBiMU6M+150kDfm3QIOf+2xg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753486AbeBKFKY (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 00:10:24 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41438 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752646AbeBKEdm (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:42 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Jarkko Sakkinen" <jarkko.sakkinen@linux.intel.com>,
        "Alexander Steffen" <Alexander.Steffen@infineon.com>
Date: Sun, 11 Feb 2018 04:20:06 +0000
Message-ID: <lsq.1518322806.608762994@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 11/79] tpm-dev-common: Reject too short writes
In-Reply-To: <lsq.1518322802.943358572@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.99-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Steffen <Alexander.Steffen@infineon.com>

commit ee70bc1e7b63ac8023c9ff9475d8741e397316e7 upstream.

tpm_transmit() does not offer an explicit interface to indicate the number
of valid bytes in the communication buffer. Instead, it relies on the
commandSize field in the TPM header that is encoded within the buffer.
Therefore, ensure that a) enough data has been written to the buffer, so
that the commandSize field is present and b) the commandSize field does not
announce more data than has been written to the buffer.

This should have been fixed with CVE-2011-1161 long ago, but apparently
a correct version of that patch never made it into the kernel.

Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
[bwh: Backported to 3.2:
 - s/priv/chip/
 - Adjust filename, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/char/tpm/tpm.c | 6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/char/tpm/tpm.c
+++ b/drivers/char/tpm/tpm.c
@@ -1114,6 +1114,12 @@ ssize_t tpm_write(struct file *file, con
 		return -EFAULT;
 	}
 
+	if (in_size < 6 ||
+	    in_size < be32_to_cpu(*((__be32 *) (chip->data_buffer + 2)))) {
+		mutex_unlock(&chip->buffer_mutex);
+		return -EINVAL;
+	}
+
 	/* atomic tpm command send and result receive */
 	out_size = tpm_transmit(chip, chip->data_buffer, TPM_BUFSIZE);
 	if (out_size < 0) {
