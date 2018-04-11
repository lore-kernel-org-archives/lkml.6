Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3339499-1523479902-2-5719385864423146158
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
    1523479902; b=Pk0cwm1QzGcgP5qfB/DEEFeKNAGbi+J/IEbustSlmR31pnoCOb
    Aj7jG1AMFSFfRO7I9VA0bxtc+gxAQEmdS1jrnBUZmPh6cVea54Obunqr2IRiK7G8
    UB2T6RHZuA8PlyY16Eymcs/vuLn5iAEbWfCOFHJmyx1XZqolz5Us+bQOIwKBsPhc
    4hjpwTiMX8RHh1k9hcIdW623BYH1GWtrkVcnp2WgDYzTRQf+9euFrnHiV34y5xji
    NiTKi07YwZDnP3RjeCm8VlwRj21FLrgqUMSBIG9jK6HlJwJaZyJzueFtwdDR9HoI
    XeD5v6/KrxuCXe8osrrPnpnrvXmG/0ZI29rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523479902; bh=lKBDX5qjpTjYZvdgHgSE2ROB9PFNOa
    xvemxDaq84Gac=; b=oXSl2gviwh7iHmkyjAHvmuKzAS6XJ/KLyC5wvmBwJHqB1F
    s1PhPx2PSNVNB0Wat6NnoFnqyvsbglqUV/s7Z5cU1DZWlwSJ0CFC0wdOHXg5kb3s
    B6kcwXCUb/DXApN+IyO/YPgl1fxW2+eIs3nfGdRGlmmGYXJVeZx10m7MAFRrAOGE
    ZoGy4407TzjmtqYjfMkW9l/pwgOjAgRYtIeKqknr2vkpygHmZ6eu0JIpIXKZU18y
    Qh5+mCcIpZF+gCX/PKwSCiL0zRw4OrGCmdZYeSpEK2AM8TE6vScL+ZGnzkOAahge
    W/IXuN9oyBzzP8D01JTjJsOsWfV9CPBVjbTPYECQ==
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
X-CM-Envelope: MS4wfBnCC1pdJxvpUPQAMQBFz/hhR5KCqPfAJko4a4A61C6xSERe5ZpEUwRZsMHr3hE/Jux6p8C+VHVDqwVkaSPbzFEYFxy4geEIgIeO22pRDJnSrP2FuV5S
    zM+6KNojoVr4OxM5H15yQXRbpjfCMUeHZ3TkfPp27ANXV8gnD/DOvrmhNK/NMYAJqVPlUNdWwz37IWLEflYiQYVztughxHMNLMLbqtxQT7Ld6Ga/7vwFpIYi
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=AGRr4plBAAAA:8 a=yPCof4ZbAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=tDyTHM3CoI3J5sN7fPcA:9 a=QEXdDO2ut3YA:10 a=bOnWt3ThIoLzEnqt84vq:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755550AbeDKSpi (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:45:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58646 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755556AbeDKSph (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:45:37 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Varun Prakash <varun@chelsio.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 050/190] scsi: csiostor: fix use after free in csio_hw_use_fwconfig()
Date: Wed, 11 Apr 2018 20:34:56 +0200
Message-Id: <20180411183553.227763268@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
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

From: Varun Prakash <varun@chelsio.com>


[ Upstream commit a351e40b6de550049423a26f7ded7b639e363d89 ]

mbp pointer is passed to csio_hw_validate_caps() so call mempool_free()
after calling csio_hw_validate_caps().

Signed-off-by: Varun Prakash <varun@chelsio.com>
Fixes: 541c571fa2fd ("csiostor:Use firmware version from cxgb4/t4fw_version.h")
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/csiostor/csio_hw.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/scsi/csiostor/csio_hw.c
+++ b/drivers/scsi/csiostor/csio_hw.c
@@ -1769,7 +1769,6 @@ csio_hw_use_fwconfig(struct csio_hw *hw,
 		goto bye;
 	}
 
-	mempool_free(mbp, hw->mb_mempool);
 	if (finicsum != cfcsum) {
 		csio_warn(hw,
 		      "Config File checksum mismatch: csum=%#x, computed=%#x\n",
@@ -1780,6 +1779,10 @@ csio_hw_use_fwconfig(struct csio_hw *hw,
 	rv = csio_hw_validate_caps(hw, mbp);
 	if (rv != 0)
 		goto bye;
+
+	mempool_free(mbp, hw->mb_mempool);
+	mbp = NULL;
+
 	/*
 	 * Note that we're operating with parameters
 	 * not supplied by the driver, rather than from hard-wired
