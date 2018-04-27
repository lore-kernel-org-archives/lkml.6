Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-284719-1524837575-2-11234632504918577935
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
    1524837575; b=SyVSVzbb5RYRt68sFh/nnV2tqJ7JiKfB+Jus2dor6MDD2gToOw
    /DHrcdCM/b/mzhMQENjyGdE2IsaOGTzhfl5QFoKdEVjFPPVt5lBI7co+5MdO5S0V
    WQJbomSAvyu0b9xhG8Up/E0xKNWd0TLa6ikaYO1O2jLDzOPqqKwhTA/vC0HPnkeo
    7LH+9WAyuwM5f+DTHP6uwcvVFliykfQGnhLxxHp8gYlIzT1EaxgD8YK3Q810rrKO
    dRYogAgqQ3F7OGrS8b9FGZ8F3KRaZZsJeYhAo0iq/wA73RfAAR/8HOJcGri6S/Vz
    3rCk2/nwuQAP3yvk2Jipef86CpSPZV2MrfAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524837575; bh=0DxIiDVNi4FVDATBAPzmxAzj2Mjyqm
    0jm2YwnETC3uM=; b=jXmlU+HUgVCt5J2SGbF9eNipEzonfDc0uYlFq8WSOMmXP9
    qCqt8674GAnNxei8EXLxyLcl0/QSNQeCwqhJFdjLD4QsXBuuDmyHQMOEWyAd3GQ/
    uj0uhdHAk2s/im9yhXXYqemHNE9cj/VzC/m++XgzubIgiuWNuc0brIOGJ+5jyTNE
    Y2bmk2/EuCRMeCvUJWoYKLWIFCudr+cip3UaI3mknMWi+ihbtL335k9TuSQ08+/a
    x33Zdm51KBB2IV7IfroCcMbm1hO9X9MuaE9LcTGi9yvns5RGvKayQUp8RU5D//xy
    LsOxib+/nUCHxNfJASayAHUcZOYBAIIg7VPFCaww==
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
X-CM-Envelope: MS4wfOkYxEGe7ZQxEqJxtY3CZ2n7GASGmhUlEcb9EqmzPUHDhaso/5Qqy3V0dWfhPzr8+syRdqQ8COukC0TBXsFGTuR0wehIhj2qU8cT9InKBmAmKTPdGcn6
    uTBKrr6a/fNRAaZhzEENyps7b4luxvw16vHJqDHHcXLezIs0EBFcOMkudvnTs4slPTUGmjpCRVfsblR92ghIDyvhPM2Wz1uY6FE3oFqKUOzwSLUji4C32qLi
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=hSkVLCK3AAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=9xxziMlU0vL-oThAJ_cA:9
    a=QEXdDO2ut3YA:10 a=cQPPKAXgyycSBL8etih5:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932433AbeD0N6Y (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 09:58:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:46588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932857AbeD0N6W (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 09:58:22 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A385521896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+a70ac890b23b1bf29f5c@syzkaller.appspotmail.com,
        Guillaume Nault <g.nault@alphalink.fr>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 11/24] l2tp: check sockaddr length in pppol2tp_connect()
Date: Fri, 27 Apr 2018 15:57:46 +0200
Message-Id: <20180427135632.041456906@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135631.584839868@linuxfoundation.org>
References: <20180427135631.584839868@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guillaume Nault <g.nault@alphalink.fr>


[ Upstream commit eb1c28c05894a4b1f6b56c5bf072205e64cfa280 ]

Check sockaddr_len before dereferencing sp->sa_protocol, to ensure that
it actually points to valid data.

Fixes: fd558d186df2 ("l2tp: Split pppol2tp patch into separate l2tp and ppp parts")
Reported-by: syzbot+a70ac890b23b1bf29f5c@syzkaller.appspotmail.com
Signed-off-by: Guillaume Nault <g.nault@alphalink.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/l2tp/l2tp_ppp.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -608,6 +608,13 @@ static int pppol2tp_connect(struct socke
 	lock_sock(sk);
 
 	error = -EINVAL;
+
+	if (sockaddr_len != sizeof(struct sockaddr_pppol2tp) &&
+	    sockaddr_len != sizeof(struct sockaddr_pppol2tpv3) &&
+	    sockaddr_len != sizeof(struct sockaddr_pppol2tpin6) &&
+	    sockaddr_len != sizeof(struct sockaddr_pppol2tpv3in6))
+		goto end;
+
 	if (sp->sa_protocol != PX_PROTO_OL2TP)
 		goto end;
 
