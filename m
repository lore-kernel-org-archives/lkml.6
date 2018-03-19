Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3094471-1521473712-4-6542156225575395347
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
    t=1521473712; b=UupZ7QQ+f/7mt1Egv2L+Nhf7/6Vf9MP5D6546tVLqS0FpZ0
    CiELu6s66/syKRd3ykS49E0EBsNeu/JDoJJgFMSJBDrnoJCRZfvlL3Jj5pKBI0dg
    m0PD3DxX+Ft3Omz2TEVebkZRqKiL9SkKONUPWbrDw4pxETg8t/QEwkxUEkd7XtEe
    PeV+iSuhSpp9LhKhZgcbDhG1WL55ueO3NL641s0RlmdLqMB+ZK0fDnZIDa3dEXho
    G4Kemm2H2I8tJvRcBt5S6jsOr/H6bzxctbtoU1ZExNRPunjL5kGmDbh85LoXg5+n
    zrsOmSh/hcxLA3C1g3IGRoZchKKRSl9En+pGtwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1521473712;
    bh=AfubiBFjVa3TdpmJijwAbVHTztI+BID7FNgYMFTuXHA=; b=MaA0ElEpJ+Pn
    QpTu+KYcYfw2SIYdY4gkrf5p2/VBuZCmWJw94f9F+tjK9jzjmHiYucmKjfcwn0aq
    4rZGymi+eSA4mWtQaPBcqyPJRyBVnEiQBstvdFKLweVTUWaSL2rESia/BPkiA/wQ
    CDN+H7HOkCnjn9m7n0GEkbpn1CmkMwbhT6oSkubJCsPGYuV/zLP2TRbomC+HtFYw
    YvPHY6FaN4p5Li7je3z5eBeWUnPDYl47VCVlmEU5SOFgxs1JdKPTlhTfTwmCP/qr
    bXg0d8SMR71s5oKOIdHvw2O1UgL1S1k6oY5aX5v339AgUSQ7HxoyFDnazMOuUgO7
    7MSbimbVGw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdejjeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhhsphejsedttdertddttddtnecuhfhrohhmpefjrghnshcuuggvucfiohgvuggvuceohhguvghgohgvuggvsehrvgguhhgrthdrtghomheqnecuffhomhgrihhnpegtrhhutghirghlrdgtohhmnecukfhppedvtdelrddufedvrddukedtrdeijedpieeirddukeejrddvfeefrdejfeenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeefhedugeenucevlhhushhtvghrufhiiigvpeei;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdejjeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhhsphejsedttdertddttddtnecuhfhrohhmpefjrghnshcuuggvucfiohgvuggvuceohhguvghgohgvuggvsehrvgguhhgrthdrtghomheqnecuffhomhgrihhnpegtrhhutghirghlrdgtohhmnecukfhppedvtdelrddufedvrddukedtrdeijedpieeirddukeejrddvfeefrdejfeenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeefhedugeenucevlhhushhtvghrufhiiigvpeei;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933565AbeCSPeI (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:34:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49112 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932670AbeCSPeF (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:34:05 -0400
From: Hans de Goede <hdegoede@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH 2/3] libata: Make Crucial BX100 500GB LPM quirk apply to all firmware versions
Date: Mon, 19 Mar 2018 16:33:59 +0100
Message-Id: <20180319153400.25694-2-hdegoede@redhat.com>
In-Reply-To: <20180319153400.25694-1-hdegoede@redhat.com>
References: <20180319153400.25694-1-hdegoede@redhat.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit b17e5729a630 ("libata: disable LPM for Crucial BX100 SSD 500GB
drive"), introduced a ATA_HORKAGE_NOLPM quirk for Crucial BX100 500GB SSDs
but limited this to the MU02 firmware version, according to:
http://www.crucial.com/usa/en/support-ssd-firmware

MU02 is the last version, so there are no newer possibly fixed versions
and if the MU02 version has broken LPM then the MU01 almost certainly
also has broken LPM, so this commit changes the quirk to apply to all
firmware versions.

Fixes: b17e5729a630 ("libata: disable LPM for Crucial BX100 SSD 500GB...")
Cc: stable@vger.kernel.org
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/ata/libata-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 53400ce09818..bce9840526da 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4531,7 +4531,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "PIONEER DVD-RW  DVR-216D",	NULL,	ATA_HORKAGE_NOSETXFER },
 
 	/* Crucial BX100 SSD 500GB has broken LPM support */
-	{ "CT500BX100SSD1",		"MU02",	ATA_HORKAGE_NOLPM },
+	{ "CT500BX100SSD1",		NULL,	ATA_HORKAGE_NOLPM },
 
 	/* The 512GB version of the MX100 has both queued TRIM and LPM issues */
 	{ "Crucial_CT512MX100*",	NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
-- 
2.14.3
