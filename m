Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3094471-1521473695-2-15059948841207664840
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
    t=1521473695; b=NTTRfHEIqBbqbdg94sdoUUCw1qnxKmgSsOS6Z1kVne15NQ0
    7vSM3IGFhCcs0svG8VVk9/zJbDrwMX86bt95jW4EqH61zJBre5H7hIdYmS9DMV8v
    0aAK2rMj53219M0K5e96TatMCDDEq9h7TYhucCu4ycmAC3maoqvPGWwPvrHO59iT
    eebxWCwmqiQtbvCB5EGGQaPEhflj6X18McN9I3ANYP0lUoa99fhTRW641lwFJeqv
    65yHFDfIPTm7hBDwRhAKk2Hezz/zjd+4uw2fCTDRAyfiDTYF1sUQVOSCaQT0ChXd
    f2dIVh2KBO6wVbsvltruB7Z2TQsIo11ZBMGaJOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1521473695; bh=z+mNEBTxCEu2tBMuAbF8IsOMks
    Zv6IZrSq9ZD82nNmY=; b=hZQmyM39z0pP2WjByuU8NC2RbjBovBoyrsywWqoUwT
    CKKDxD5Fd/8Q5mpZaY76iTN8GI4ZkoIsldP1btb82RhfNEbbDtHODim4QN34dGOC
    o8WPZgRPNe0ZjIAzzeUWrU1x5yM7faEjKACkZybf8QHR6IIV3tGIR4IMo/uWAaNd
    7suDTYuQPgXyqiDgXiML122mB6dc07lLqg4lPJ73wp9eteazN8PpzKtkseAoXK7B
    4jSomgve8mhNcAARdRsB4fYVNm2Bo33JkdVsHYcXEhusy3bLhZ32YggYlKDUdM/n
    xGpsBm45o+ICgeHy67cWANwb1IIeA5Ee3IBNWQNU2PJA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdejieculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkshhpjeestddtredttddttdenucfhrhhomhepjfgrnhhsucguvgcuifhovgguvgcuoehhuggvghhovgguvgesrhgvughhrghtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdeiiedrudekjedrvdeffedrjeefnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepfeeijeeinecuvehluhhsthgvrhfuihiivgepfe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdejieculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkshhpjeestddtredttddttdenucfhrhhomhepjfgrnhhsucguvgcuifhovgguvgcuoehhuggvghhovgguvgesrhgvughhrghtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdeiiedrudekjedrvdeffedrjeefnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepfeeijeeinecuvehluhhsthgvrhfuihiivgepfe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933547AbeCSPeL (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:34:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47956 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933132AbeCSPeE (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:34:04 -0400
From: Hans de Goede <hdegoede@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH 1/3] libata: Apply NOLPM quirk to Crucial M500 480 and 960GB SSDs
Date: Mon, 19 Mar 2018 16:33:58 +0100
Message-Id: <20180319153400.25694-1-hdegoede@redhat.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

There have been reports of the Crucial M500 480GB model not working
with LPM set to min_power / med_power_with_dipm level.

It has not been tested with medium_power, but that typically has no
measurable power-savings.

Note the reporters Crucial_CT480M500SSD3 has a firmware version of MU03
and there is a MU05 update available, but that update does not mention any
LPM fixes in its changelog, so the quirk matches all firmware versions.

In my experience the LPM problems with (older) Crucial SSDs seem to be
limited to higher capacity versions of the SSDs (different firmware?),
so this commit adds a NOLPM quirk for the 480 and 960GB versions of the
M500, to avoid LPM causing issues with these SSDs.

Cc: stable@vger.kernel.org
Reported-and-tested-by: Martin Steigerwald <martin@lichtvoll.de>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/ata/libata-core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index aec609f80c4e..53400ce09818 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4538,6 +4538,14 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 						ATA_HORKAGE_ZERO_AFTER_TRIM |
 						ATA_HORKAGE_NOLPM, },
 
+	/* 480GB+ M500 SSDs have both queued TRIM and LPM issues */
+	{ "Crucial_CT480M500*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
+						ATA_HORKAGE_ZERO_AFTER_TRIM |
+						ATA_HORKAGE_NOLPM, },
+	{ "Crucial_CT960M500*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
+						ATA_HORKAGE_ZERO_AFTER_TRIM |
+						ATA_HORKAGE_NOLPM, },
+
 	/* devices that don't properly handle queued TRIM commands */
 	{ "Micron_M500_*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
-- 
2.14.3
