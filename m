Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-195729-1522174153-2-5719982184275924739
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522174153; b=WgwrQ/QNzzwOzlpwbaCV8bX2bg7M51AvpBMdEtQ5yE50V+/
    dTVjXF5Rmr7dBKgE2uEuFzJEVU7t3cdkvNCm7VoVXo/1v4gOqx8YDQfe2QbPFv9x
    zPhccHb2QneU5ouhXd0PpHiN/TwYjwQTmUOHONh9HyN1fp+4aRkB0mwEluF71nnK
    ePNnUB3C7iKpdyDiPhJ77A3vRhtWeSBQ3zVRL7a9xjHAMDNM1rd5z57/gN4gi1gM
    nPEHFdwDF1ikhPCv5Umbr8W4/fF9tisYZsTb+0p+yBhkD2Cz/sYF3Vf0SM9TxWzs
    Z0SsaUy7ohleuRCIkW6UZHN/pbuwNRpytZ9Zrrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1522174153; bh=7xq8yu6tS1IvEqu10eSFyMWSRR
    y3K7CgLbfi++azI6o=; b=siIvSCsrX8nL3Ke8G8Li3LBwkbce+Mq1eW1GJteV2J
    +54HmGGm+cfbdBpBYgWsjWcBdYHHel9Son7AwOGsdgZ2jXxWARdrqYZC62B3+AnT
    VQavXWEIA1wOmetbHPJaBnaBgrceMPY77ox+I9Y9viZc1vCvKVRJxSNgfBE0a9lf
    m6OHBistw/XIjzfqOjaelCyKwJ9+vcEzniOEyS0+tulbZ4qTDsT9Ax0hQNiG0m7k
    8ABAAoU4iftU6jXoIic8pjBawCkTXxmDOR3v/LwIsFtrYC6kAgd39fPwMcKicz7h
    coBS2yiYri/YetJ+U7dPsCsDmztKf0kIJizKfNNSPR9Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGgzpdWTper+bSNQK/uEt1/oaG9XlPYQxUw2/m0V506WJeMt4DmHuYiuqILlrvl+XEHUYLFZXTFh1LzUsxfw2FOCMAISRyFIQQ/KGHgHoymcHmDjRuGw
    fAlMA4ZwehhGjMVRTnqp7njZ9sDLbHwJmuhZy9IZ9OvKn9UARtavjRbSFArvkfASeFZy3mBDLzA008svh8k7bWxUQY7OO+pNxeX4e/BfpKuIYXupNjtJymLt
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=kyyX0RGNLjv1eo1-F4kA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751935AbeC0Q3J (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 12:29:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41092 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752511AbeC0Q3G (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 12:29:06 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 4.4 19/43] libata: Modify quirks for MX100 to limit NCQ_TRIM quirk to MU01 version
Date: Tue, 27 Mar 2018 18:27:23 +0200
Message-Id: <20180327162717.525765344@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162716.407986916@linuxfoundation.org>
References: <20180327162716.407986916@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit d418ff56b8f2d2b296daafa8da151fe27689b757 upstream.

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
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/ata/libata-core.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4227,10 +4227,13 @@ static const struct ata_blacklist_entry
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
