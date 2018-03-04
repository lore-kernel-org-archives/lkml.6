Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2826322-1520173056-2-17534599831564956768
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520173056; b=m5dhOQKqrtDyELVrIC/78b5NlHrIoIjE/MCAeWREBHNQe8J
    9DA5P3+/eg+FBOfL4H3H/EsxP6ig0UKicvTAMsA1aHMBPWw3Xi7Oe/9MJTCgmhrl
    JqV9TgJ6f6AMovslNPKys/2bYqO3Fcy1J8PWUy9VeU4hV16aVVo3wZB0q4T6C1AM
    l5G0/iZ4aa5iCA2F+yeyqYlE5NLmrgtvPWjSxzPTl/B98n/kU0rUYPDVn+JvG9L0
    z4jk3HHtDmnafb+yHMvW2thnVm1RfhMW4bvuA9lqnhaOoEVzhqyn1JHWf+r3pvQM
    dcW2YND2UaT5o56tEp1X15F3PcbpSz65u8fZmhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520173056; bh=O
    xcQOalFcIq2EnGeeTlSZSdO0GBWck7WektENStFG0I=; b=ol8y3ci/Wc1QQ/bLJ
    ryXAxF80gFKX6sYLLYtWh4wuDuKLNWbPAd7SLQ6VktwoZi8Gu6FWe53q/DoQu7QS
    c5gB6KWzb7yDthSi92YqO1/twim82L89mzbSeMG8Qzp0iIFgf6tYu4qKpOK4PhP8
    AiokgDEP0jQFKoAN1YepnUeXNyzNI/JHbbsjHVJymdQhAjOrHkq7hB9RmVPcfPjj
    Gbd+0qAQTIVQgdwLTb42V080yq9E2nJX81fjJG11s76tOh7bcTsTd1N9hFmlfNGu
    562A0OFOLYtOEw/u3hGy9Wga5/CwBzTuvz9ZweGxyUKKiE9Y54xiLjwp5KI4cp/g
    bf6kg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=F9qxjDVO x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=qzXZ4RSJ;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=F9qxjDVO x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=qzXZ4RSJ;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELs0JxezID7xVnu4qRZABi2/3qeclMUmYri9caB13JceMnVxrww+0dIKDfiZ+mH0YyaRhI2pXA==
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: oleg.drokin@intel.com
Subject: [PATCH 2/3] staging: lustre: Replace "to to" with "to"
Date: Sun,  4 Mar 2018 19:46:07 +0530
Message-Id: <1520172968-17448-3-git-send-email-arushisinghal19971997@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520172968-17448-1-git-send-email-arushisinghal19971997@gmail.com>
References: <1520172968-17448-1-git-send-email-arushisinghal19971997@gmail.com>
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org,
 Arushi Singhal <arushisinghal19971997@gmail.com>, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com,
 andreas.dilger@intel.com, lustre-devel@lists.lustre.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch replace "to to" with "to".

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
---
 drivers/staging/lustre/lustre/include/cl_object.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/lustre/lustre/include/cl_object.h b/drivers/staging/lustre/lustre/include/cl_object.h
index 90419dc..341a145 100644
--- a/drivers/staging/lustre/lustre/include/cl_object.h
+++ b/drivers/staging/lustre/lustre/include/cl_object.h
@@ -1833,7 +1833,7 @@ struct cl_io {
 	 */
 			     ci_verify_layout:1,
 	/**
-	 * file is released, restore has to to be triggered by vvp layer
+	 * file is released, restore has to be triggered by vvp layer
 	 */
 			     ci_restore_needed:1,
 	/**
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
