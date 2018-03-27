Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-196919-1522174178-2-3702142480460250489
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
    t=1522174178; b=PtpET1SWpus3qbQIOQChzxSUCRQxQe2XIVc2c80wHJ5VEib
    4J294hXi4lclCGMaiMCgZTgFQ5LcGCZTujHL4hMvUBat37QcCN7Kp2RYI2Lsruk9
    QJkno7qUt4/1UJAJvkWtUyQ+VH6nXWplP1+bBofa47uFMFae4hNX06h65hIAlnMc
    C6/Tu3CNeTX8hUZa6hquC27pPW9RWpnBanUtLiacNdEHDEakpDzBlLj/afs+9ZQ2
    yYl437YcaZXWcrFDMxhLonDcMhQG/TvsBilKyjVVgGboKK+DRSuMSMXrbWPO0LxF
    udytWrHrjzC4yMoubTUYAf41B7y9ZmAEOf9nUbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1522174178; bh=wocZPKC7WLggQmDIfn7fTcs5yv
    xmjaw+rULcD4sHkac=; b=dXzzrWR6TRiiSCYsPyMIWxBEEVXftRCBB228YO6ZUb
    o7Zpu0toPHIRFfO86TgmVUhBMgnB1Qjvg6zGtruiki7tPry6JUhLrF5BtGufAfOH
    BDc6w0jrhbgpFjUy9WKRXreSpk2KU00h42J9C7UYKTO+7Su5LC+ojuBoKOAB/m+J
    gO9x2Au9CvfuoFK+XxZuIdWQ/lAI9W9/8cw2IOvyZbuYBnsfC8UF4p1Vnop//nSm
    6gJxAQ/xf77EBnxltV1lrPYc15YYmsr1xYIxUxaWXOfddCrjKTQdLsUjVCa+FNhe
    vo2mOUc+LPZhZjvTByhgkmVaUoeM/A4ZaZz7C4lH6FuQ==
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
X-CM-Envelope: MS4wfHEeDwijjAWl40agaVRDPL16Fs+HaV7pgeAcZEz0B7LLf9y6PhPKzN3Hafq2UgAHPuXEJ4bwnM1Zy4Evwtkk1NTXTgf3QHpIUGdU+9Zm0nuRAuSMQR9a
    TCZ4fio0oZjQz3Qx1usRTZbSLHjUmI3A+f8sW4DgSAbEtuZJO/lZ8MPtsbYvd7SynTfJIzc0mAFqN4GcU4LxUYpd7BIAh75bhcfSyPZ5B4iyL5UnoapawmVp
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=20KFwNOVAAAA:8 a=OHwCr35KAAAA:8 a=VwQbUJbxAAAA:8 a=DfNHnWVPAAAA:8
    a=ag1SF4gXAAAA:8 a=DZKwX_AWMQs56bNcbHgA:9 a=QEXdDO2ut3YA:10
    a=zJNl-DrzyqET9lv2NlCM:22 a=AjGcO6oz07-iQ99wixmX:22 a=rjTVMONInIDnV1a_A2c_:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752492AbeC0Q3F (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 12:29:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41074 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752425AbeC0Q3D (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 12:29:03 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 4.4 18/43] libata: Make Crucial BX100 500GB LPM quirk apply to all firmware versions
Date: Tue, 27 Mar 2018 18:27:22 +0200
Message-Id: <20180327162717.476952012@linuxfoundation.org>
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

commit 3bf7b5d6d017c27e0d3b160aafb35a8e7cfeda1f upstream.

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
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/ata/libata-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4225,7 +4225,7 @@ static const struct ata_blacklist_entry
 	{ "PIONEER DVD-RW  DVR-216D",	NULL,	ATA_HORKAGE_NOSETXFER },
 
 	/* Crucial BX100 SSD 500GB has broken LPM support */
-	{ "CT500BX100SSD1",		"MU02",	ATA_HORKAGE_NOLPM },
+	{ "CT500BX100SSD1",		NULL,	ATA_HORKAGE_NOLPM },
 
 	/* The 512GB version of the MX100 has both queued TRIM and LPM issues */
 	{ "Crucial_CT512MX100*",	NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
