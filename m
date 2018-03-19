Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3114250-1521473696-2-17356386948841773431
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521473696; b=TsRDYb2GOsMXg8tVfikLR5oR8WLHYbzqwd71+/dRXcNDXNS
    rZjQJaOrJ70SxQe0jo9TAfP9rI3vn9tkKqQY0GkrTsm0yk5i9v4jdokXSfu+meIS
    rRlz9OaxsxfXd873PmIZZPUgkzQSb0hW0oH8luwU4cSYJEzBfLgmu7Ft2sEAn7Co
    QhmLYGwy1DRY3jLmfzghqUCkeZs7FVdDai7cSN9wmZdtrnoPU017cE+RCttWS/rZ
    0ntO7f0P06XJChT5U4dI8h5r1Og7JWTaqN/yLtCq9mHPu18SChEbdrMwHETPpSQj
    XTzP0hlC9fH5a971v+1tMUbU35n7gMDF1t7McVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1521473696;
    bh=uFPXFCDDz8Eq052aFcOi5r7QO7iS41szzQ9MB4VqmCc=; b=LvFkhe8gF/sh
    sr1BLjg5K0QJrRij9BY60+Uba/ejl6s+eXR4JEJ6KeCw0Z5FIL2BuLfOw3hf5Z/Y
    Qlwm64PNGlH7H5hEVg5YrXoVupErss+WKdqkb15hPrEONTm5MOVoKO/OgJ4lDMok
    rFC4JA6Q/v843QEVamx2+xXm7IueQecMIcj9jxpj79lnY3vGhSemwqY+GwCWGozV
    Z7edxPjr5+PZH2DIiIUQSwVqWrNLnT5WPbEVVOLNG/YwTNIJ5cDdXvrdD+5bZLdD
    q6ympqpQuhyNmhWP1kc92Vd8VuFx+u+LXNOTqOmMP0HEEgk9Ya1tr10EDEEprgjN
    FFbxOzvHQQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdejieculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkjghfshhpjeestddtredttddttdenucfhrhhomhepjfgrnhhsucguvgcuifhovgguvgcuoehhuggvghhovgguvgesrhgvughhrghtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdeiiedrudekjedrvdeffedrjeefnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepfeelieejnecuvehluhhsthgvrhfuihiivgepfe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdejieculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkjghfshhpjeestddtredttddttdenucfhrhhomhepjfgrnhhsucguvgcuifhovgguvgcuoehhuggvghhovgguvgesrhgvughhrghtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdeiiedrudekjedrvdeffedrjeefnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepfeelieejnecuvehluhhsthgvrhfuihiivgepfe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932670AbeCSPeJ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:34:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45256 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933518AbeCSPeG (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:34:06 -0400
From: Hans de Goede <hdegoede@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH 3/3] libata: Modify quirks for MX100 to limit NCQ_TRIM quirk to MU01 version
Date: Mon, 19 Mar 2018 16:34:00 +0100
Message-Id: <20180319153400.25694-3-hdegoede@redhat.com>
In-Reply-To: <20180319153400.25694-1-hdegoede@redhat.com>
References: <20180319153400.25694-1-hdegoede@redhat.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When commit 9c7be59fc519af ("libata: Apply NOLPM quirk to Crucial MX100
512GB SSDs") was added it inherited the ATA_HORKAGE_NO_NCQ_TRIM quirk
from the existing "Crucial_CT*MX100*" entry, but that entry sets model_rev
to "MU01", where as the entry adding the NOLPM quirk sets it to NULL.

This means that after this commit we no apply the NO_NCQ_TRIM quirk to
all "Crucial_CT512MX100*" SSDs even if they have the fixed "MU02"
firmware. This commit splits the "Crucial_CT512MX100*" quirk into 2
quirks, one for the "MU01" firmware and one for all other firmware
versions, so that we once again only apply the NO_NCQ_TRIM quirk to the
"MU01" firmware version.

Fixes: 9c7be59fc519af ("libata: Apply NOLPM quirk to ... MX100 512GB SSDs")
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/ata/libata-core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index bce9840526da..7431ccd03316 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4533,10 +4533,13 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	/* Crucial BX100 SSD 500GB has broken LPM support */
 	{ "CT500BX100SSD1",		NULL,	ATA_HORKAGE_NOLPM },
 
-	/* The 512GB version of the MX100 has both queued TRIM and LPM issues */
-	{ "Crucial_CT512MX100*",	NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
+	/* 512GB MX100 with MU01 firmware has both queued TRIM and LPM issues */
+	{ "Crucial_CT512MX100*",	"MU01",	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM |
 						ATA_HORKAGE_NOLPM, },
+	/* 512GB MX100 with newer firmware has only LPM issues */
+	{ "Crucial_CT512MX100*",	NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM |
+						ATA_HORKAGE_NOLPM, },
 
 	/* 480GB+ M500 SSDs have both queued TRIM and LPM issues */
 	{ "Crucial_CT480M500*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
-- 
2.14.3
