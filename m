Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3303684-1523479158-2-4119675561893077950
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
    1523479158; b=RdO0tZxxSg7TAW6D472856yu/gi2JBgInzu4nv/uIoDWKyExDV
    nBC58+90T3jY1Q2Sqn4C+07TDbmX0npbxmRPHRiJKGDME8348kzJ90KweOmr3fuV
    zp4WgRJB+sailVxScofuqtTiidRJVqmIzDiO1Cx84Z6fseY30S8qd0M1pbDtAz1q
    6+S3HXFxtv785O754sXSkysGjKm+gRnjiba7/2LdzS7HEpexWcIb6mtspCfB8rbJ
    RdJtttgESqQ4SQWCOUU6PVi3BZKKxHZFC73spHLB44vP7Uw5S0ElDZF3lRuio49Y
    EUldYbUNZAR+dYJO93Z/aACDoLVwgePlBLlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523479158; bh=CAomIvU5PPRtewCdY8E8ieDVQ94ljr
    YITWoXorMWJUc=; b=wsBjE94joPWM4SOD/qPqPJ+1S1AdNGhAsoRsjMjPjeBMQ2
    os1AiAG+NIoJnk1UQVuxJv34NI4Fmh4c/GFyIN/uXWSI8YjI4Ps+rmFwq/dp09G5
    BJ4CuhfJfhJ5mITF3mKxJVIHRkstcTBve9EYOIzDt3D9UJ+HPQLhzIVEMdSvEWHN
    WYTOq/y311QXHCPxhYjb8oaxQ8QFTSTDWFCsOhg3zMdRO0rxFHK1jPvFA6+cra7A
    wOB0v4pMmejN8p2Ts8htvjUr9bRXb3sBZImAQkRrEPDlZtJAbiS2ecpGmROY2EDd
    o1otywB+ghoeac+CMk0+U/0iDnwH5gZrgTRipXOg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfOJOb5BTRsJ4EkKJZ6TmYfd2D0lxUPI1gMpyceG2ab0/YiMWtMtmAfIHk1zc+BhaFG44kkDN7lkCmjpYCAC8DEKhiIT2016xWIYa9ck8g0QTd4uDf+tU
    ZBDNBYMOS1rSttAUtOiRvpFkLLwdn3X5gI1W55P5bUYegTrY8tKaYEZfrk5Zb2aGtHZC58cYdtAVkEyp1S5DXxzZzVm+feNL1vqq+hXHbRS9VHo3C0e67IX6
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=7CQSdrXTAAAA:8 a=IpJZQVW2AAAA:8 a=LpQP-O61AAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=xJcnGJnVB4EYvS3OOrEA:9 a=QEXdDO2ut3YA:10
    a=a-qgeE7W1pNrGK8U0ZQC:22 a=IawgGOuG5U0WyFbmm1f5:22 a=pioyyrs4ZptJ924tMmac:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932382AbeDKSsL (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:48:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59578 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932379AbeDKSsJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:48:09 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 107/190] clk: scpi: fix return type of __scpi_dvfs_round_rate
Date: Wed, 11 Apr 2018 20:35:53 +0200
Message-Id: <20180411183556.905327422@linuxfoundation.org>
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

From: Sudeep Holla <sudeep.holla@arm.com>


[ Upstream commit 7374aec95636ca39409545eba4ef5ff3125c2346 ]

The frequencies above the maximum value of signed integer(i.e. 2^31 -1)
will overflow with the current code.

This patch fixes the return type of __scpi_dvfs_round_rate from 'int'
to 'unsigned long'.

Fixes: cd52c2a4b5c4 ("clk: add support for clocks provided by SCP(System Control Processor)")
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/clk-scpi.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/clk/clk-scpi.c
+++ b/drivers/clk/clk-scpi.c
@@ -71,15 +71,15 @@ static const struct clk_ops scpi_clk_ops
 };
 
 /* find closest match to given frequency in OPP table */
-static int __scpi_dvfs_round_rate(struct scpi_clk *clk, unsigned long rate)
+static long __scpi_dvfs_round_rate(struct scpi_clk *clk, unsigned long rate)
 {
 	int idx;
-	u32 fmin = 0, fmax = ~0, ftmp;
+	unsigned long fmin = 0, fmax = ~0, ftmp;
 	const struct scpi_opp *opp = clk->info->opps;
 
 	for (idx = 0; idx < clk->info->count; idx++, opp++) {
 		ftmp = opp->freq;
-		if (ftmp >= (u32)rate) {
+		if (ftmp >= rate) {
 			if (ftmp <= fmax)
 				fmax = ftmp;
 			break;
