Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1817771-1527160970-2-18256358335623187475
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527160970; b=KPi/QHNXavXUN+APa3WM8mY654VBMdRkg6sTgikwn+wyQWqIqF
    kLm+GpFrWkEc+uxV0zmGNlyBXLL1BOqc6vRgjp+UNcQw8HPpmy5gS1in/T8eOnNr
    mtg6u5nmIMShfZv7TvpOrsgfUCJQl851suApFdcq+wJ5PsmEkgidi/a/+UpMLJt7
    vQoKL432v6pnRFXb4aQ0htKLONrZ70G8gzLDF+0QYDcfLgxL2YQXMlCEsoNUvePH
    tSVfG+13MzPa821LnaBz4zd+2yRZGEql8ql7dsUCaaRivCg2v6bcv8xrKxI2O4v0
    NSlUAJ/Q8fTwdXyF4VXB/Qo7H31P27UyPJJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527160970; bh=MaOqdoCm4kl8XmopCInnqB9dgVN7/K
    ggPRn8y1gqYc4=; b=lmXRPjeGqMiuuj53pgVuvnEqvVFfB3hmPXnGmLsKYpTC83
    dWAhDEhnILxSEQ2plzxPYVOz3UcpyUfD39SmaoPCRyhSv5+aPlfkAdNLLK11ydXO
    tIBaPrkImZedVZ+/IatYJRMe3VVu/HJ+hv8qA8//6OegcRtBF4ZdRPhV06NxWZ3T
    Ew7XmW/7jy25gTRc5E00487EUZG27h92uJ1rcGrndyhBuFvRsO2UoB37wNv84eg0
    zP8uC20905O/nabUp8JASc+OSUzuBTYWdtgyrk3M8Jf3xPWFJadOMA66NUbCIpn+
    FvIrY+bwK5nwfkbnVrYDDwMVx8tVADGCrk7P4QEA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=TovC5Hp6 x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=TovC5Hp6 x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFvZhZkrV9a2Cp/cMPGurSvqpaGT7R+gtKIjATy6q1Qsx/pIuA4cTUu48TlrfCheLS73v2pXTG6WWDRoI7Gw2lTn2CPG1O4bLsTod9CIpxNc3iZiK9GT
    IHifNflekjkvjBxj40mvwsjWHegidaax+LooInnJLk19/R19xc1ljRPMbpNiZ6EQiLbuzttAjFwRnLZylfTBe6Pkt/02jfQU2WXWqTPRitVJv3XOU2DNTT38
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=jZVsG21pAAAA:8 a=yMhMjlubAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=DRX4gsuvdn39oF5zcG0A:9 a=QEXdDO2ut3YA:10 a=3Sh2lD0sZASs_lUdrUhf:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967845AbeEXLWX (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:22:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:51312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967840AbeEXJwT (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:52:19 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephen Hemminger <sthemmin@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 025/165] hv_netvsc: fix race in napi poll when rescheduling
Date: Thu, 24 May 2018 11:37:11 +0200
Message-Id: <20180524093622.999356098@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stephen Hemminger <stephen@networkplumber.org>

[ Commit d64e38ae690e3337db0d38d9b149a193a1646c4b upstream. ]

There is a race between napi_reschedule and re-enabling interrupts
which could lead to missed host interrrupts.  This occurs when
interrupts are re-enabled (hv_end_read) and vmbus irq callback
(netvsc_channel_cb) has already scheduled NAPI.

Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/hyperv/netvsc.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -1205,9 +1205,10 @@ int netvsc_poll(struct napi_struct *napi
 	if (send_recv_completions(ndev, net_device, nvchan) == 0 &&
 	    work_done < budget &&
 	    napi_complete_done(napi, work_done) &&
-	    hv_end_read(&channel->inbound)) {
+	    hv_end_read(&channel->inbound) &&
+	    napi_schedule_prep(napi)) {
 		hv_begin_read(&channel->inbound);
-		napi_reschedule(napi);
+		__napi_schedule(napi);
 	}
 
 	/* Driver may overshoot since multiple packets per descriptor */
