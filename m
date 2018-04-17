Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2312362-1523985219-2-2964260483099600646
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523985219; b=sThMK+MY0XArXs2pqN+XsEGz0aUjrC+x9JE0ANyeXSwDdkh9pm
    URiG+9idvFysfZUe+eK9jqpWo/x4lt1aeT96niU8wvXNjOwbgTtwKGVAbBxzJMWV
    iaLw0nJsPXkIwxSGnJiaHXs5JP9Rckkx2azGv7tnlcR2Ipy28X5V/hmMYXVrwlke
    aVyJgcIPc8CrSk2ORbe37iScsltNxRPxD78VdR/ilaZT7FHjuF4LOSEMN6U+DHKg
    VIN+ywBAL8aCj5EJjaBfT8fXzm4BoHkTgfdKM9ExZ+6pBbOOhy01QR8RqnS5FvDN
    TN1q586gHycspvnKmcZCUgwZz0wLYjzDj9CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523985219; bh=G2rVsmtcVrcQnswDHo8S8x+RI9IUr5
    xlhRtmPbHIX5w=; b=KMIIwsHC+C31yVE1lRLelSiwIOnbI0PBx0BhnbHi9BW0jr
    OGSG+9kGwKIWHewYANxyqyWKM/HqXZq+rHYReRymfp4SYJSHGeXKrOBsvNRpELkH
    VJ/CWop9pzQzbITX/ZSYqrZE5lXTX65q9g9Erh2H/UoHr1CC6VyPvQ2O4+BSexat
    BgrvSiusCO7bftVOUi1CVgmUK2ERKDLVtWhYxfr4eybqg8M/XMgxzUth746LcIdE
    ePdK6O+c4CLT7fN0qR5GgyNb5eEWwUsjFZFkLJqXXm8nSbnVV8EBzXpdL+kKcM5W
    qiw5DFQBQWcueNQ7170naLDerKnYOWmURpeEqF6w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfFV+VZt5ZqrYnnplVTFQil1I9qu9GIJU+8RFu0Pc5zw8qW++2oPZyQfEwn0DBBFPD51WhXUDvIcQR34bd6/oraIvbqu/veOOt/hA2atuttlLvYMSeffI
    27aBpnsUrEvM1BIpb7LIDybco6Epma/z1iics5JXtOMFng8zHo/6OtfI/9xIkrIq59oEtRcaupzQHEahpHf/OEfsHyjSmnv4E1Ag0D98vER+I/Q0oXsiFOU1
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=P1BnusSwAAAA:8 a=VwQbUJbxAAAA:8 a=vQBBkBfzAAAA:8 a=ag1SF4gXAAAA:8
    a=1X84iZHUU3uXrpedBrwA:9 a=QEXdDO2ut3YA:10 a=D0XLA9XvdZm18NrgonBM:22
    a=AjGcO6oz07-iQ99wixmX:22 a=NGXS0kB0m_rannUenejW:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753347AbeDQRN1 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 13:13:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60022 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752696AbeDQQAK (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Apr 2018 12:00:10 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 4.16 13/68] media: v4l: vsp1: Fix header display list status check in continuous mode
Date: Tue, 17 Apr 2018 17:57:26 +0200
Message-Id: <20180417155749.871501229@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155749.341779147@linuxfoundation.org>
References: <20180417155749.341779147@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

commit 613928e85317b945c863bb893f5737d2f22f5425 upstream.

To allow dual pipelines utilising two WPF entities when available, the
VSP was updated to support header-mode display list in continuous
pipelines.

A small bug in the status check of the command register causes the
second pipeline to be directly afflicted by the running of the first;
appearing as a perceived performance issue with stuttering display.

Fix the vsp1_dl_list_hw_update_pending() call to ensure that the read
comparison corresponds to the correct pipeline.

Fixes: eaf4bfad6ad8 ("v4l: vsp1: Add support for header display lists in continuous mode")

Cc: "Stable v4.14+" <stable@vger.kernel.org>
Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/platform/vsp1/vsp1_dl.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/media/platform/vsp1/vsp1_dl.c
+++ b/drivers/media/platform/vsp1/vsp1_dl.c
@@ -509,7 +509,8 @@ static bool vsp1_dl_list_hw_update_pendi
 		return !!(vsp1_read(vsp1, VI6_DL_BODY_SIZE)
 			  & VI6_DL_BODY_SIZE_UPD);
 	else
-		return !!(vsp1_read(vsp1, VI6_CMD(dlm->index) & VI6_CMD_UPDHDR));
+		return !!(vsp1_read(vsp1, VI6_CMD(dlm->index))
+			  & VI6_CMD_UPDHDR);
 }
 
 static void vsp1_dl_list_hw_enqueue(struct vsp1_dl_list *dl)
