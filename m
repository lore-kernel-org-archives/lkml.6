Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-284719-1524838359-2-10368316946844008700
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
    1524838358; b=nOcsa1v/orD25NivHdrNv/nEDY79WMqFXInQeV45OhUOPsfB68
    pm4QqPHzE4dxPWJEle7VL1eOfGWPzq0NOjytHKp2izUyW3KGs21frqdbBkt3iNjz
    01vedqJUpj0TNg6iNBRiUUEBeMxyz9YoYwISgiCBXaerXLg9uI3o2z4hRJTAkS7x
    0xluCbYseFCYUSDeISCkex+dLUoK6PP1YwUqNVJoKBZY3ntp8J5Z0wMJqKsgrJyQ
    hVsk5BpicszaqMtMAi0OaYIOH1nmkR2Newsx0Rx8ueV868nGaxZHFwNQTAy3zIQi
    tpiMyMKg3dZMYHoCPLVHY4M44bmBeWVfxfvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524838358; bh=v9fUlXJzyHqbiz7ZlWk0uw7gAZVDiY
    MFUlfF2tJkoPY=; b=ZmaM5NIP0H0Ed0C0s2IRvWL02MORyBG1FwlQ9b7dejQmwj
    e3nzNbJB/PCqhetQIAJFh2QliW8JBDrSOGD5kbSmOZO+LtJEdloNlxzCp5tS/9yY
    RgOxV0CZNiTXYlPyWt1yoYvaKliuYOshcjvFSYoS9SoUgDnKcSMvdxyM8eRtZMOn
    SIdn0bpcNUayRbsf2THEhBsdgWnGQ2olFCNthXeFRAswCpo2XohvJZ93JYq3R1KK
    vtbO23RP1+ZYQ0tbDAbgruJFfv+y1in94FBWB08egj5YUDOtabHZmVNmbfG+DNRc
    fAflrkUo/zc4PlYkTK5Gdjq5in4SiR/pBbPkN71Q==
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
X-CM-Envelope: MS4wfCx1H976rU1FK0CINoZ7ApTOr38rt8l0xsqYGsBbqxmwp30WthSn+fCnv7n09sR7geeLNMQEExaS+xI4dLqb4LPTVHTkqnpUYM1yZ959FYnZFGAGW8gE
    jgbHKlv9HoXU6pM1cPPFrxUrSovrAAbNRrI/PYO9N6aCuNyDyi5N2s3sc6DQv8nVqyfF5L8dlOn3Y0IRpM7OZNFpzl8QYgN8lHWCnODqBJxCyKbgDqQo9GoR
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=A7XncKjpAAAA:8 a=pGLkceISAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=_JJVY9lb1vR7N1RJ9kQA:9 a=QEXdDO2ut3YA:10 a=R9rPLQDAdC6-Ub70kJmZ:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934776AbeD0OM2 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:12:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:56978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935130AbeD0OM1 (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:12:27 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69F9E21895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexander Aring <aring@mojatatu.com>,
        Yotam Gigi <yotam.gi@gmail.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 38/81] net: sched: ife: signal not finding metaid
Date: Fri, 27 Apr 2018 15:58:40 +0200
Message-Id: <20180427135745.321130132@linuxfoundation.org>
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

From: Alexander Aring <aring@mojatatu.com>


[ Upstream commit f6cd14537ff9919081be19b9c53b9b19c0d3ea97 ]

We need to record stats for received metadata that we dont know how
to process. Have find_decode_metaid() return -ENOENT to capture this.

Signed-off-by: Alexander Aring <aring@mojatatu.com>
Reviewed-by: Yotam Gigi <yotam.gi@gmail.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/act_ife.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/sched/act_ife.c
+++ b/net/sched/act_ife.c
@@ -652,7 +652,7 @@ static int find_decode_metaid(struct sk_
 		}
 	}
 
-	return 0;
+	return -ENOENT;
 }
 
 static int tcf_ife_decode(struct sk_buff *skb, const struct tc_action *a,
