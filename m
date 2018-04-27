Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-298528-1524839576-2-2467347804022596695
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
    1524839575; b=B6d6SC0Hd0hmHXn1kLM2CznP9NP8FwYCGFcNVol8LvqnZ8PMEg
    l+c2E2un3sMTJD/Ece3jxJnpu6DJa3U/I5bu7o4DG1xJfY5MQHmXd6UsT1URen8Y
    HEFDzvyEUCmiKDZcE7zUuovtNNCXGWlivI5eKqXJavqsk21Kb7pm5Z7wvcgG518l
    a7BZexBKRRaC4EEfFqeR8xvtL80GJncU7AdS9GncFmkp2vaEv/bnd5oM57R5zmjC
    5J/EpT7mCcN48mg6AYhJGwxAjRAgfkVv3ysD/fZArQIDVh9hOBr7bCfZcT4a82kG
    SN0ynvDGvwFWxLnQKEmBm2LL9JKeUF1f731g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524839575; bh=M4N+2g/TXezdpdcv4/bn4OggYvT6p5
    UtnjK72TxzRsA=; b=A6hzeE48G3KISLkEbw3XyR8dSA8nXSmtB1RGIEy+sHNby3
    ydCkl9/yrNn/n/atqygMLFPpF8m68j5SkmemmErYkn35LesOjZ5zXuG8hq8Ukgoe
    q5SUB7OMFX1o4xJFjEqZqonIse9Y4H17XRk45xxK64TIjEty9QcVUC2Xt2m3qiHG
    lCqNvQpQRRl8gZEgFjj5y+aCRwDIcL1eALPVSF43r82M20jvkIF/q8Y0nTpWJL0B
    B/3IZXhMJCEja6ykfXhPDBLnxKAd3keEcPkmz2JFdZEcSNOkAtZ/AqJe0bTttxJu
    8psN3tjH/d3Malta1cPetjGerDxauz2Qo52p9Yog==
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
X-CM-Envelope: MS4wfHwoSHSwLvDjK9/Fn2s86DId9u6XD9qDOQsRLmopg3wFrWdfBebVK0XV3Q2eNl937V+AC8wGZcWJlM0BaILpC+F5bcexhCW8Hczdc1pReZOJa+DHG/Kl
    UT8O+chV0TjwaGMH5xu9fDhu76bNgXHSjPNxaxbdq1cyZ3ZPCroRvoS0UI4dIaD6uYm2xhgVY0T2ecGotlGc4gMAzHa5wo/ggvILLf5aFnUkfyYCUjBNOuZ2
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=FOH2dFAWAAAA:8 a=VwQbUJbxAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=MJgOeA_HzhOYzjRToYoA:9 a=QEXdDO2ut3YA:10 a=i3VuKzQdj-NEYjvDI-p3:22
    a=AjGcO6oz07-iQ99wixmX:22 a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934874AbeD0Ocv (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:32:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:55488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934823AbeD0OKV (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:10:21 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3483721895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Doron Roberts-Kedes <doronrk@fb.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 25/81] strparser: Do not call mod_delayed_work with a timeout of LONG_MAX
Date: Fri, 27 Apr 2018 15:58:27 +0200
Message-Id: <20180427135744.623761258@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135743.216853156@linuxfoundation.org>
References: <20180427135743.216853156@linuxfoundation.org>
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

From: Doron Roberts-Kedes <doronrk@fb.com>


[ Upstream commit 7c5aba211dd61f41d737a2c51729eb9fdcd3edf4 ]

struct sock's sk_rcvtimeo is initialized to
LONG_MAX/MAX_SCHEDULE_TIMEOUT in sock_init_data. Calling
mod_delayed_work with a timeout of LONG_MAX causes spurious execution of
the work function. timer->expires is set equal to jiffies + LONG_MAX.
When timer_base->clk falls behind the current value of jiffies,
the delta between timer_base->clk and jiffies + LONG_MAX causes the
expiration to be in the past. Returning early from strp_start_timer if
timeo == LONG_MAX solves this problem.

Found while testing net/tls_sw recv path.

Fixes: 43a0c6751a322847 ("strparser: Stream parser for messages")
Reviewed-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Doron Roberts-Kedes <doronrk@fb.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/strparser/strparser.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/strparser/strparser.c
+++ b/net/strparser/strparser.c
@@ -67,7 +67,7 @@ static void strp_abort_strp(struct strpa
 
 static void strp_start_timer(struct strparser *strp, long timeo)
 {
-	if (timeo)
+	if (timeo && timeo != LONG_MAX)
 		mod_delayed_work(strp_wq, &strp->msg_timer_work, timeo);
 }
 
