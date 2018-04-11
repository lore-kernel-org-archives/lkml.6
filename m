Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3303684-1523479893-2-857427383606258287
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
    1523479893; b=ja2I4YWU7SqvJVXYy7WPkzk7L9jxRAq5ICPeMvgliqFZjDBJA4
    8aRozwXmsKETSdsNS9S/lmHXyb5oPSr47Gp3s9SqFk6i1izBkuYLwdXSX83ZHmyS
    xn/41kJ4PLspnsGkqUrENYiCpU/0lhtm58Yj1BwSmv6Gfhfz/TRK/xlyANn4ORC3
    +iolWvxR3jf1JBrpVvbnHwxBmbMVMRFqwzWL3JkR2CRm5v1x/YuMQbXcSRSXe0cH
    F3/D2Yu9nHxcyIrfvivPL/1VaE5SoNLNq9Nm40DoTcYB7+3EqloSK4LLWKf7Ye4x
    Zj0I+6Py4Y7+rV3rLRYK5z5ovYTM8ShwYgGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523479893; bh=gRJQN7J0gJV5v9fDEwn8R0SY1c9TDT
    NLq69FZEEdTYs=; b=UHVZNvBoZVP8hfPNcy24KcQtlSEu4eZIp0OmC7OxWUpKFc
    MXrKKyLyBHHRplE/OffHFYmnOl6KeppxJAyrYYldQ3+Zulbj93FSrkWUDtNe55fm
    iJUfSpCZlRQEmY0eRTHXbjFjiaUYplwsWGSYB6CbQtAi0cx7Kef+l4W8dI/A/O0M
    EgPhuuScl6qFWe67vpWHSy9aRWr7N5L0aYuDW2wctNph0djIMxbPmLxBqVKSeT1G
    3qg1c7spLnC3hD+EqozHbUlQ2n9lXi5N1EPO5FMzfLfb94b1EirBLGmxphwPp6Nk
    JxAu3Hcoh4zLxOG+3SPtnXy3tgSnJxqbL6cCaHcQ==
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
X-CM-Envelope: MS4wfP+keYFWfzh2KxR2NJ0QtTuF4RGjfTVyo9q08covGAmewsKPIK6WJC4FMH48WUfeZMzhIufHLKRibvmdXC6Az+1mzI/IFlYtjkWGdyEu5G4yC7Dm7Tcq
    hz0w9SDMXyPV7LmF2vwm7VMB4PUcf/SRxJVPCqJU+e8FidkcEgeJJKeDuQiW2o7EK1UIFXwk0qBLZZDlSAjXcsjAVsH1EO4+PajC5FA3vFq2LCx+gWDoqNEY
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=vrZRev11AAAA:8 a=pGLkceISAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=1fmkquyJTycUkjhl2ZkA:9 a=QEXdDO2ut3YA:10 a=vE9JzVuArQVVuPm_qWxV:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755966AbeDKUvP (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 16:51:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58670 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932328AbeDKSpm (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:45:42 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, KT Liao <kt.liao@emc.com.tw>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 025/190] Input: elantech - force relative mode on a certain module
Date: Wed, 11 Apr 2018 20:34:31 +0200
Message-Id: <20180411183551.616035057@linuxfoundation.org>
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

From: KT Liao <kt.liao@emc.com.tw>


[ Upstream commit d899520b0431e70279bfb5066ecb6dc91d0b7072 ]

One of Elan modules with sample version is 0x74 and hw_version is 0x03 has
a bug in absolute mode implementation, so let it run in default PS/2
relative mode.

Signed-off-by: KT Liao <kt.liao@emc.com.tw>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/mouse/elantech.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1715,6 +1715,17 @@ int elantech_init(struct psmouse *psmous
 			     etd->samples[0], etd->samples[1], etd->samples[2]);
 	}
 
+	if (etd->samples[1] == 0x74 && etd->hw_version == 0x03) {
+		/*
+		 * This module has a bug which makes absolute mode
+		 * unusable, so let's abort so we'll be using standard
+		 * PS/2 protocol.
+		 */
+		psmouse_info(psmouse,
+			     "absolute mode broken, forcing standard PS/2 protocol\n");
+		goto init_fail;
+	}
+
 	if (elantech_set_absolute_mode(psmouse)) {
 		psmouse_err(psmouse,
 			    "failed to put touchpad into absolute mode.\n");
