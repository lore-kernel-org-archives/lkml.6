Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3440611-1521483118-2-8990923767595737865
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521483117; b=kows4DV3e1tv54P61qShZeYGI8U44DBQlE8BOZxDye/m28L
    2t1reiEERFJafOWK0exnSi+g33fQB/7fZvS4KKBu9MsnxJIHXPUKHNYAU+9jwvwC
    o44QUmaYmYHr1jbm07YVnp21AOzf2Ws6TztzmOnmWfKiVDngE/fayzVfmpXW5iU8
    ImNhaRoaC0xX7x6yu8e7iAFxLd+IZXV49e9FmDnuUWUIJEcqp1eqUYtW6fwKPN+K
    IiVeZtTd8UnfqPvuE/oqMKn04KPb4MUuIEnRbxkRlYwq7y5/OdXiYuc6szVYW//M
    P4ZckpUfjMtzqaK63J20/KRmOlo8iN+gWCbRqrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521483117; bh=PldDpC64PWJKBb288diEyj6Xso
    1tZ0zyP41vbVtLHoc=; b=EM4cdW4zvlusO5bIKKgeHb4iL3WyPAy057pfnOdyN/
    GNacWQ6rg3VigRXsJU0yhUTy5QSTjwLXwVDPXw2FI8AG+Iqq88IWbfafXVkvD/UH
    r3cP6GS/Fb9Eq5O9xtyogADWYys//D3iTTEOyRTnRusaGmZSYCptuFT+7y81hjLw
    0WOnw08mK5KCZBFWRA0OwPubqdTomVW1ItKZWIZ5o1JHJLI7jK6OmMFWlWUKD2eO
    YHgEXPStrVLgf+1I6Mc3ipDFxyv2wHtGn1ADHbECy7IjXUs/9la4VdwuVRlYYFt9
    YIICRRLVojbGW4h20B+AH0i1LAIA8nq6n91FqLZGtxoQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeefvdeiieenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeefvdeiieenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967703AbeCSSLm (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:11:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42394 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935527AbeCSSLj (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:11:39 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Thumshirn <jthumshirn@suse.de>,
        Chris Clayton <chris2553@googlemail.com>,
        Douglas Gilbert <dgilbert@interlog.com>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Cristian Crinteanu <crinteanu.cristian@gmail.com>
Subject: [PATCH 3.18 66/68] scsi: sg: fix SG_DXFER_FROM_DEV transfers
Date: Mon, 19 Mar 2018 19:06:44 +0100
Message-Id: <20180319171837.154460408@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171827.899658615@linuxfoundation.org>
References: <20180319171827.899658615@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Thumshirn <jthumshirn@suse.de>

commit 68c59fcea1f2c6a54c62aa896cc623c1b5bc9b47 upstream.

SG_DXFER_FROM_DEV transfers do not necessarily have a dxferp as we set
it to NULL for the old sg_io read/write interface, but must have a
length bigger than 0. This fixes a regression introduced by commit
28676d869bbb ("scsi: sg: check for valid direction before starting the
request")

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Fixes: 28676d869bbb ("scsi: sg: check for valid direction before starting the request")
Reported-by: Chris Clayton <chris2553@googlemail.com>
Tested-by: Chris Clayton <chris2553@googlemail.com>
Cc: Douglas Gilbert <dgilbert@interlog.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Tested-by: Chris Clayton <chris2553@googlemail.com>
Acked-by: Douglas Gilbert <dgilbert@interlog.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Cristian Crinteanu <crinteanu.cristian@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/sg.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -769,8 +769,11 @@ static bool sg_is_valid_dxfer(sg_io_hdr_
 		if (hp->dxferp || hp->dxfer_len > 0)
 			return false;
 		return true;
-	case SG_DXFER_TO_DEV:
 	case SG_DXFER_FROM_DEV:
+		if (hp->dxfer_len < 0)
+			return false;
+		return true;
+	case SG_DXFER_TO_DEV:
 	case SG_DXFER_TO_FROM_DEV:
 		if (!hp->dxferp || hp->dxfer_len == 0)
 			return false;
