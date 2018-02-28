Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-667456-1519840054-2-1738893955274150956
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519840053; b=hpbC29x/yjPmjN5rVdvjT9ktBp5fxVvs8GM2BDd38ZicTR3
    Oqw7WccOf8XKnfb96q4Kq2/vWxluGMgVZIBj7npgJIGA3aXHLTQNiSbYggWGv8kO
    TsUlbM68hgLHPlK12japwIT7CByCu/0bDDwYiC1v+afRyeSNl+nuaPanYtoAnGgg
    EaoGqHW240sPnJpt0QSb+3BGXIkfIFLU/qPVtBV1+6RjjbIDLxba5JXIJ/4CmxQs
    aEQX0vA+RZEoyUq2+k/1F1KutUvy7+LF2m84GARvNFBz3NsrKYa6iSJwKosZbrRg
    F6Xv2YjB1u6KOv8ZhVVXp8UaXzS3Ic2tGQrrRYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519840053; bh=820CSAU+BcBa5Ra0SqE
    dvP74KsLYyd83Yv6ci1ND3pU=; b=nnC0o//oHlHkHpcIHAncEGeZ6aRNResmhAy
    kC3osV6MmUy+KtF02FpiC1LsitUxsk/NA2UWZG6QLmyY2z9q/eQY2UJxTj/niJV7
    4bw1BLIcHrqjdb3EszEUfsXUmpsYq7TTanEpOlnVN4R2ZQw09TbBNgdeQk66N//8
    uk0LSCbPTEfQBz4Oj5vkoktV6UvYUTT9laRJhYiD/7Dsz9e7H0e/9sXYMJr98DGy
    pQDmuXeDSL4wDYAvg1qLixDiOVwpqB1PDv+lE8NDKDIU8o/yF0M9WguvqaQoOPrB
    rNdLb8tOtnvUY0SC3wUsEIUU4CKgl8dm3TThwrjNd34PGyyB2gw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934314AbeB1Rpq (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 12:45:46 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33088 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932447AbeB1PWM (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:12 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Aaron Ma" <aaron.ma@canonical.com>,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Date: Wed, 28 Feb 2018 15:20:21 +0000
Message-ID: <lsq.1519831221.908195094@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 010/140] Input: elantech - add new icbody type 15
In-Reply-To: <lsq.1519831221.703311959@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.100-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Aaron Ma <aaron.ma@canonical.com>

commit 10d900303f1c3a821eb0bef4e7b7ece16768fba4 upstream.

The touchpad of Lenovo Thinkpad L480 reports it's version as 15.

Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/input/mouse/elantech.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1284,7 +1284,7 @@ static int elantech_set_properties(struc
 		case 5:
 			etd->hw_version = 3;
 			break;
-		case 6 ... 14:
+		case 6 ... 15:
 			etd->hw_version = 4;
 			break;
 		default:
