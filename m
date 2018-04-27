Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-298528-1524839653-2-4663901700588527544
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES endasv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524839651; b=JBc1mTE0KMAfYEsNHFZhD7Kgqhq1W4gfvlOsgSagN1dgFJgQxO
    MJQF5o9l3UGi9ypljgToBrL9l7Y6A7Y8MfrVQb6LlIsP2ixw5gfuYd8+98SE+1Qt
    TPKRcunoaOVA1W3JaIH2WZ7nAzeiRhvCaXsY74dWBI0g3MjwGbGazZEYWR/oNJF9
    fSCt0YtiSghaMabcqIUlEA5soI5z6pWt65tW1KSZt474kFoOhl28/QaJH20TOctQ
    QHT004TZQUypkBQrZAAkjr0/w16aJHGyr9dMoK1o+7Rju2zRrha/P6V5vZEkiAdB
    VdZ5CAoZDuAfSRq9r8jcUlGgdZr+s1VjKfOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524839651; bh=SyezYbHQtOCXnKeQNvQXrb3k1L4meu
    /gkyel2dqRTLo=; b=eXduKIjjeGoSUjI4jw8dkZ7FZFMsi3vNxIglg0EXaoN2M2
    q+lCMegn6xpJplgy0HGzBMX2QFQMQmyuMRJTXlD/NFuGNQ39x+bqdt5+xoQA9NZw
    7b+73hPni/lAuNwdzaBxQcDrtB4GHdJD5FZY9OaoXTcf4WfBkqK7zWfL1IGhcMtf
    Zxb6zWDW0JqqwDSA3VEahL1D8nZZ9659xCawbXbvOF6svF64/cOuphShkxB8fcJs
    PvZYeyzsvv22Hej0GCKXNeX5IhtLF6r8jqddl33kebKmV72/gmrAlDEl5XGu+c7V
    ZUNTdJBO75pwURaWp83Ol1VxAFQq4vhF4cHOSLew==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfDwC2ipDJlSlqUSYGV/0w0q0qVyCmA2e7Lc1PCgHoITFt+EeFpGpkve5L1YZnJh3lhxa3eQa5V1vuRm5/0UZko2DgT122EhCm3ImALB9/8mMHAt/Hwou
    CLICBxsEp5Vfpc+ZoATUI/uwtiAn3PRtknXwUp5u36sVZEWM2QMOUf/5jZsC8zr9G1/IeFEs4KXL4N47HqZgWRDNxATeVZ7rVjj5sJFuCpKetf/AN9dg1eci
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=hSkVLCK3AAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=xoXKdaVV62sOJPrrZbUA:9
    a=QEXdDO2ut3YA:10 a=cQPPKAXgyycSBL8etih5:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934811AbeD0Ody (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:33:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:55378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934787AbeD0OKN (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:10:13 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EE4D21864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+4f03bdf92fdf9ef5ddab@syzkaller.appspotmail.com,
        Guillaume Nault <g.nault@alphalink.fr>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 22/81] pppoe: check sockaddr length in pppoe_connect()
Date: Fri, 27 Apr 2018 15:58:24 +0200
Message-Id: <20180427135744.507904367@linuxfoundation.org>
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

From: Guillaume Nault <g.nault@alphalink.fr>


[ Upstream commit a49e2f5d5fb141884452ddb428f551b123d436b5 ]

We must validate sockaddr_len, otherwise userspace can pass fewer data
than we expect and we end up accessing invalid data.

Fixes: 224cf5ad14c0 ("ppp: Move the PPP drivers")
Reported-by: syzbot+4f03bdf92fdf9ef5ddab@syzkaller.appspotmail.com
Signed-off-by: Guillaume Nault <g.nault@alphalink.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ppp/pppoe.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/net/ppp/pppoe.c
+++ b/drivers/net/ppp/pppoe.c
@@ -620,6 +620,10 @@ static int pppoe_connect(struct socket *
 	lock_sock(sk);
 
 	error = -EINVAL;
+
+	if (sockaddr_len != sizeof(struct sockaddr_pppox))
+		goto end;
+
 	if (sp->sa_protocol != PX_PROTO_OE)
 		goto end;
 
