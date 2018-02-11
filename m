Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1524142-1518326556-2-3994787495305860327
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
    t=1518326555; b=ds0gELtpgtG1BP1ImbfSf0Y/iXDSz5EkjAQ461LggykM4cI
    hal7n/I3JZt2THQse2shG+Zk1Da8ngQ3buY60HH5zJXr6Z0L1yLVVBhbolTIFLPD
    TCEjSifPTYkdTq0g9meaHbUN6wxy+09GkCHpohDcbEmJ/rLzQQELQ29RyqUFeBMU
    B/ADqZN1IrvigxwWGoOIho7VIlRl/U3OLm7jDuyzpCR2C5McOvL6LiKFgbcJ/IVV
    k8A+tn8dMn7hE8X5X+FC8dCEAmbj77hCMvxGElpHt3hwy/DwAK5x7RCSmcDP/EPd
    QExGuvc32dssRVZhsnik3LfB86dW9xvHZwc5/Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518326555; bh=vwG+TJm8w9WfJkau3MF
    K2iAlgi5BL5z9TTaoUaDclzw=; b=TOmPYxznps+pFCZN5QcTAimeqS/CNpUhsPw
    lyqIOqOlQJxMmrNxyzEgXugh1XkaHnpTpWIgZsajtdzwGScWyi6o8bF51kb84In7
    Y0n41LhlUUdzXP+FieCsx9eAMyz5dDDbpa56FI3w0SVCjfQEJv3zlfYmjdqEu2XE
    i3TMlQmEm+7QdbOcum1qBMzlB5hSuMQMHmvvBQdd6TeDgEbFie8pYBXPowqQZIV9
    UW9VTLhH+c3Fby4pI8QspUojBWEi3SSHW+qB+05tlyspHqF8ULCPurfO2ddJKDti
    3ydUQSk7plbzfCQFESBukIg1InFPdXopZVrCYSeEEfSic7B9Low==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753508AbeBKFWT (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 00:22:19 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:42726 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752619AbeBKFSB (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Feb 2018 00:18:01 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Mimi Zohar" <zohar@linux.vnet.ibm.com>,
        "Boshi Wang" <wangboshi@huawei.com>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.653661116@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 067/136] ima: fix hash algorithm initialization
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

From: Boshi Wang <wangboshi@huawei.com>

commit ebe7c0a7be92bbd34c6ff5b55810546a0ee05bee upstream.

The hash_setup function always sets the hash_setup_done flag, even
when the hash algorithm is invalid.  This prevents the default hash
algorithm defined as CONFIG_IMA_DEFAULT_HASH from being used.

This patch sets hash_setup_done flag only for valid hash algorithms.

Fixes: e7a2ad7eb6f4 "ima: enable support for larger default filedata hash
	algorithms"
Signed-off-by: Boshi Wang <wangboshi@huawei.com>
Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 security/integrity/ima/ima_main.c | 4 ++++
 1 file changed, 4 insertions(+)

--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -52,6 +52,8 @@ static int __init hash_setup(char *str)
 			ima_hash_algo = HASH_ALGO_SHA1;
 		else if (strncmp(str, "md5", 3) == 0)
 			ima_hash_algo = HASH_ALGO_MD5;
+		else
+			return 1;
 		goto out;
 	}
 
@@ -61,6 +63,8 @@ static int __init hash_setup(char *str)
 			break;
 		}
 	}
+	if (i == HASH_ALGO__LAST)
+		return 1;
 out:
 	hash_setup_done = 1;
 	return 1;
