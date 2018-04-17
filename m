Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2152363-1523980865-2-11554495322937942721
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
    1523980865; b=XKSAK5yr3m6U751Vmt82wgQjKaipuGoCrpg/Ri4a1dpdPifyGX
    VOs0znBk7/BC3bjRyRpKunNHTyGy8p4FBb0KdVY/vNdJ7qRIPVTjFkjfwl35Qw99
    jBwJoyec0VD08DnlUVZ6c9qajokZQfO+w4jgql2Hf/3e8o6B3EObAWlndo1bwqVf
    iUOpD4p4aP+QDT+WKQxlS/JgssZ0oY9HH3GOz0uhd/oD+TTUAYc5oD1HzqsxJ+5X
    zrJo1TiSr5Uif6F7jJCZt/SJwe2DjelpEfkEr7IZu9nlZFYIEbwTHkOz7Lp+dFrE
    DU43GkHoEkZGtxcq2F9OercubnBDaHpfTcPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523980865; bh=Ckl9slDY0rbSTvSeuUOKdqZE+Y+5n/
    wMJHWB+4Pxicg=; b=rmOKrOT0FUSXxz/Bmh/+5R9R3nQKyj7nNjnFlCaiyf52j7
    FTkihcdtstcdteFIQOqcNyNbIcHuzu3TWP2blU451uVW2km4IZlY5WuExIDg+HfQ
    u2HPqEkG4/4/jdvLcO/QY5nzYuFMogVA6eGmZOe6c9LAAsvgTsOg9a9VFzjJ3RdJ
    b8RXgL0fakxX7eT17LF6JA6J/UpfjTOxMIXY2/VVBmI+I8WO2/K/aaKyll9yIpWg
    Sl7HLKpIHnrT2K7RwIa0OlSOigu5kZdQCnXGUz9looR8n9svMb1zIraEQ3aWCxxk
    tP0ZXr+ljkQBRn/ErE8I+EqFAjFPgkNjBdXMxxJQ==
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
X-CM-Envelope: MS4wfBQMTp0+xDNgd8lc4shYFunlLJbxiDtjZuDpUj8qXNRpRGhjeljZDW24zqro2rBwqC9rMErQKmuww4j1pVFH5QtjanCVOXBGRvQ6twmlvvDp/TrQqcZD
    zbjvTwqKXH4TqKvRtsXzzie31vWiNbHrsEM68epzpEbWai0syvuq6g/1I8W4IHoY8nyzByPZLVBNCKmHSaugy/KZ03g07omdy6Cf623Uq2RNzMW3jW31Ymet
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=WFZIRff2AAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=s6jaqUFqpbjo0NHz2EsA:9
    a=OWxO4o3BYeYy1wOv:21 a=ZSLHK6p4wIhUSrHV:21 a=QEXdDO2ut3YA:10
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753420AbeDQQBB (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 12:01:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60286 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751836AbeDQQBA (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Apr 2018 12:01:00 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Phil Elwell <phil@raspberrypi.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 09/68] lan78xx: Correctly indicate invalid OTP
Date: Tue, 17 Apr 2018 17:57:22 +0200
Message-Id: <20180417155749.715923658@linuxfoundation.org>
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

From: Phil Elwell <phil@raspberrypi.org>


[ Upstream commit 4bfc33807a9a02764bdd1e42e794b3b401240f27 ]

lan78xx_read_otp tries to return -EINVAL in the event of invalid OTP
content, but the value gets overwritten before it is returned and the
read goes ahead anyway. Make the read conditional as it should be
and preserve the error code.

Fixes: 55d7de9de6c3 ("Microchip's LAN7800 family USB 2/3 to 10/100/1000 Ethernet device driver")
Signed-off-by: Phil Elwell <phil@raspberrypi.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/lan78xx.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -928,7 +928,8 @@ static int lan78xx_read_otp(struct lan78
 			offset += 0x100;
 		else
 			ret = -EINVAL;
-		ret = lan78xx_read_raw_otp(dev, offset, length, data);
+		if (!ret)
+			ret = lan78xx_read_raw_otp(dev, offset, length, data);
 	}
 
 	return ret;
