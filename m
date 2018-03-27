Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-196919-1522174189-2-4559392190189515118
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522174188; b=R5j+eAbxwgvRG8AyVQC9UdV+UxKITa5Rv4cvEN++Y2oNJXg
    yjpj9uWJg6KG/OHlwdE2zp1Sj6s1UhLf91XhFOhQVtppzNd2e06QZu0cmVxsxMss
    M6e+XqORlM38zNp8NJZGbaStUb/Wz7H8mkRAayBSJvOgLDS0jGiYh7AaewCDY+hc
    2Qh7mmYkMjxbaw51mE5Vt42wDXEjwHzS2ByawejfIREcnFoVWBMYrJtDJUjgX6DO
    5Ka9cjEwOYchXPKYOw/PhMx0tcT0r3Y5dk68DheMALhWUvGWyrGuYX1YKHVz21Mr
    wNu9EoZqQ08lRVWYB5/iM3Q/1/r6iph1aDzGW+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1522174188; bh=gytI/izoxunuov4iO8fN4Ee1cA
    37b7NvZyiMwvDZ4iQ=; b=NYb0C3iBBaz6QiqJ3WM34qFPBS5g148ILMdnBu3IsA
    VZ6Ib5QgDq3ecS8UxScyVbeLl25mGrME0nfzPrLkBC7qlQykzH+6v2gztO9I+FJj
    rsalv3Ao4UlyHvl9+B/cqjIFah49X5FcsFvaE03CZoYmkdPGXILGGwZgv/XkVT9j
    lUx71BSKipdn+yoHNo8fAdvawC531633hpBSF4OLIRp07clktYVtnM/VvvPRPU3K
    9T4h7LH2L7pPqhf8B4lhBT7GIbiB3x+W51tnav2izXDrYU2e6nBEZqA1ibsEtLG3
    1piXRHsdETonghmvhitlhEBlceeL0eeq7861rFGKwJlA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfMhjXRaA0qcMGuigPkgJ05Tp3Bk3nmnT93OlCeHnl8VMl5awQjJ2+KT10LmglzLhPiWKtVdvWrzaoV6mBavqTi0id9YHgufUehpAzJQPa0V4huzfiNcT
    mJMwoSz7JT07IJQR4wwdsU1X7GTcZebyuXbICiptauh8XWSk9XAd6M6V/Dc0izj10c5sclcjG17o7smbPoZSHbfc9VPm58DZ09CYLHyZt1TfXfKSoXwLRhtG
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8
    a=fvJeW1HfRhPnDkgCL10A:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751859AbeC0Q27 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 12:28:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41056 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752425AbeC0Q25 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 12:28:57 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Park Ju Hyung <qkrwngud825@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 4.4 16/43] libata: Enable queued TRIM for Samsung SSD 860
Date: Tue, 27 Mar 2018 18:27:20 +0200
Message-Id: <20180327162717.366620634@linuxfoundation.org>
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

From: Ju Hyung Park <qkrwngud825@gmail.com>

commit ca6bfcb2f6d9deab3924bf901e73622a94900473 upstream.

Samsung explicitly states that queued TRIM is supported for Linux with
860 PRO and 860 EVO.

Make the previous blacklist to cover only 840 and 850 series.

Signed-off-by: Park Ju Hyung <qkrwngud825@gmail.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/ata/libata-core.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4243,7 +4243,9 @@ static const struct ata_blacklist_entry
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
 	{ "Crucial_CT*MX100*",		"MU01",	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
-	{ "Samsung SSD 8*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
+	{ "Samsung SSD 840*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
+						ATA_HORKAGE_ZERO_AFTER_TRIM, },
+	{ "Samsung SSD 850*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
 	{ "FCCT*M500*",			NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
