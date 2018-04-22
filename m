Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2591571-1524405397-2-18160785267394915541
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
    1524405397; b=rnhi80vMfgBU6VtILw/wpZUb9Vj2+Pe/aoh3u/XpsrwukLjV9u
    /VQNSHIa34mZPUKPEKJ3bdsBmuJVz1DxzVA46MR80hFmG64UQV1DIht+VbIPVjwE
    YCoKBi0ONpv+m551Hp8vSkyuaZ5tfXDgVrV970f761jERVyJx6K7Yjgx8432//Nm
    eMMkcalUF1tK6ZSiJcsQnczyqbBCckRmWmGILW8cGxXN0nRT/wot7ASstcnu9DuG
    HTdyfp4gwsxcehnyJTy9VFmzfzXgcWHsis6Za6UaubhfYQdDns96OBztssTe0B++
    CaB2gSOhz3ArlqMgT42aKCCEjnb63nsvh+4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524405397; bh=g2P7h1fbhq9iE5Exg8DAx3tntHnkiu
    r14yEIWi2J2ek=; b=J7o12R4dbWN9p8ZWxJ0wYzPKMoEUrcSkV/FDaaj2o5UCdw
    EfqSoT3ImE7FCGWO3By1f+h+ixYrUOc8s8yqcUYt3P0s+wFHq5Saq98bqiyrJ8+9
    YotOF3Nc10wSw36GXcwFsrOACsJmUtRtdoZUK8qYwmVAw9EeVYy0zQlWa//8P0sW
    Mcaa1x03lNhI0cwYmMIiT/83scsMjfl6Wtx7MGUfsBxD8araP36BC4Az/7dzCKDN
    jhgFVbsKCdP1SK9lS9woic90W4EnTxgypsuBnFdA+BC62jAE8as2bkZrf+FkIsUc
    spFUdqy3bufyT7IYNNKMnkAB+Vgba6Ti1I+h+4Ew==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfOmFjsBDEX5ySkulCy+P0kAo8NHZ1nDEDCpND997Z9dojl3RYKgOqzUpiT0lOBFNzeklFgJ3k/eufwJ/30DzOQ4HOqwJCz22gQY7qvKIAFO26M9eM5dC
    RBC/WHbdI557P3YjL2UmSR11CzOeebWOgboZVtCqttJWevwaLFMfbIp8xrXrg48AWM3fRQbLHg/2z0zApmLt3lNQgqfVjw/8m4l0FQye1NcciXdlSv1fXc/r
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=09mQ8c4dSRLCMc1kKzkA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753435AbeDVN4f (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 09:56:35 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45218 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753802AbeDVN4c (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 09:56:32 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martin Townsend <mtownsend1973@gmail.com>,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 4.16 005/196] ubi: fastmap: Dont flush fastmap work on detach
Date: Sun, 22 Apr 2018 15:50:25 +0200
Message-Id: <20180422135104.511311996@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
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

From: Richard Weinberger <richard@nod.at>

commit 29b7a6fa1ec07e8480b0d9caf635a4498a438bf4 upstream.

At this point UBI volumes have already been free()'ed and fastmap can no
longer access these data structures.

Reported-by: Martin Townsend <mtownsend1973@gmail.com>
Fixes: 74cdaf24004a ("UBI: Fastmap: Fix memory leaks while closing the WL sub-system")
Cc: stable@vger.kernel.org
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/ubi/fastmap-wl.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/mtd/ubi/fastmap-wl.c
+++ b/drivers/mtd/ubi/fastmap-wl.c
@@ -362,7 +362,6 @@ static void ubi_fastmap_close(struct ubi
 {
 	int i;
 
-	flush_work(&ubi->fm_work);
 	return_unused_pool_pebs(ubi, &ubi->fm_pool);
 	return_unused_pool_pebs(ubi, &ubi->fm_wl_pool);
 
