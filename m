Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1511654-1518326316-2-356346734053594438
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
    t=1518326315; b=bgE9xXBP+Tl6MTKkgHG76el79oI8PhzZWWiZp82JmVvLOGX
    RySiqr193xU1wZtmhSgpa64KGoTJrXKdSy1oUqqQpXuwzbqWNF/87fdumtvVFbrl
    c9ebvvGac0pBA0GJyeGtLNBanGQAzsFZ9ZMICDG3uPSjXcxlbZBNsJn2bdtUY8o0
    c6ykQ7lViToInFmrZ525qbXSw1q9avVIj/6Lz9sZKZEdgGcyM8pkXcE4YP36C0G0
    KDVZqPtwJESop2LJA0KJmBlg/vMWw1K1famrqwrpSf6ieFeMEw06mDJEvc5lcbw6
    B/lOzhOjWsYdPlT6DIjUfiWsVkYZMb/fMUiZ2Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518326315; bh=M639dDe2cO5lcPJFe91
    IWXi8viaBd7LH5w/R0eW9fm8=; b=hvAlK1ocx7Y4i8gw6Ejf4WDnOvKNorpEC/x
    IRmKxIun9wuaxP3F5R954oo5VUu7Kj9K2FpErhVA4huCAMV2bhVDTvz9CXBZ1Udx
    HwcVRAbl5JV7No8P1ewpIbeUZrHKMKFv/Ii17GBcTsc8fwDTcnV/920dPwVID9oZ
    aJXT56dHEWU/tBGoXGqL3pWzCgaHZSLjWg60CtOYtEKKVBhnw9GeMmkqEmYzVlvH
    /RQvM/JK/AXLxOG/je9LfDeCF9pThVcqId0wPn1fIL9fNalHb+yKAz3tPIgcUvPr
    6VmBAC/HrPVUN+pGn2yIcIWUNa3qGZ5noPpjBxF3Kcmr+UOgX7Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754070AbeBKFSd (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 00:18:33 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:42726 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932213AbeBKFSb (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Feb 2018 00:18:31 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Alexander Steffen" <Alexander.Steffen@infineon.com>,
        "Jarkko Sakkinen" <jarkko.sakkinen@linux.intel.com>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.937935490@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 026/136] tpm-dev-common: Reject too short writes
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

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
[bwh: Backported to 3.16: adjust filename, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/char/tpm/tpm-dev.c | 6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/char/tpm/tpm-dev.c
+++ b/drivers/char/tpm/tpm-dev.c
@@ -139,6 +139,12 @@ static ssize_t tpm_write(struct file *fi
 		return -EFAULT;
 	}
 
+	if (in_size < 6 ||
+	    in_size < be32_to_cpu(*((__be32 *) (priv->data_buffer + 2)))) {
+		mutex_unlock(&priv->buffer_mutex);
+		return -EINVAL;
+	}
+
 	/* atomic tpm command send and result receive */
 	out_size = tpm_transmit(priv->chip, priv->data_buffer,
 				sizeof(priv->data_buffer));
