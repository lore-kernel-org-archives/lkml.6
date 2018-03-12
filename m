Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-35897-1520848266-2-1424543463943662906
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520848266; b=Gxtb+z8DVOPswaKdq2RZ7waBdoo+OU5KbQ0mAX0vI8M1iml
    5e+8vHBEl1zihrWeVeYRkOiJU2dRSdHu3F/J2NdpJJzmbWORC7mlxZZEmutc6a6u
    GJJyVfEzUPWhUgzHs4mInL1nTxC8T5WwoJPWyhjTQJ4W8nPGHQQf7+QB7qQeQWBH
    voBWXMdixJBAUw+0vD4nR9jSeAXUtPE2bK5BKWq9QUgNBkksYJI9aZYclhHf1Uz5
    /rrp8fYB7t37LXbjI7YFHQGnuRf0dH2RsokTQgKhEoEBlfsWi9f5h9939Ip+kxOj
    8EH8ZoSxWhpM8l3H8S0FRFl63eSqki2MTyFg1eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :content-type:content-transfer-encoding:mime-version:sender
    :list-id; s=arctest; t=1520848266; bh=6mAujQKC45MaWfM9GXRvlnbpLS
    gV9IMMU/eeRsDfS8I=; b=qQWCVdXCiwVqMaxvzURVfZBkQrCkkjeNIG7oH9eqhg
    qh2trANTW5w3MhTlRT+t/XtU6ecNgsUyGVD6as3+h6StUWjToVY0TDZdcX20MLeL
    9t/Cs4E9GmUYatO+7kPA3g+CSfH5f4ZdXsIQxLZ23giPBn6IP0d+SfoZt7N18dAY
    9ZngdrtGQZsLxrp17SCg6OBHqi6TdDRDbqXBf6B0XA5KUmvepUbkTU5XPXsE0ds/
    H1jSpN/GZQkFqK//tPw/DnNuLcwqsCm7yb11I/p6ld8bjbTd70+yvd9x+7UYlk7A
    u+uBpbAiqILN2lwYXMvk4aIq13Cdh0eaTUO73+Xxh5IA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751229AbeCLJue convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Mon, 12 Mar 2018 05:50:34 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:22439 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751277AbeCLJub (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 12 Mar 2018 05:50:31 -0400
From: Bich HEMON <bich.hemon@st.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "Jiri Slaby" <jslaby@suse.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Bich HEMON <bich.hemon@st.com>,
        Yves COPPEAUX <Yves.COPPEAUX@st.com>
Subject: [PATCH v2 0/2] Add support for RS485
Thread-Topic: [PATCH v2 0/2] Add support for RS485
Thread-Index: AQHTued/rHjDdxSKEU+UEyrIwSUf9Q==
Date: Mon, 12 Mar 2018 09:50:04 +0000
Message-ID: <1520848188-7343-1-git-send-email-bich.hemon@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.48]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-12_05:,,
 signatures=0
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

v2:
- Patch series rebased on gregkh/tty/tty-next

This patchset updates existing stm32 usart driver by adding support for RS485.

Bich Hemon (2):
  dt-bindings: serial: stm32: add RS485 optional properties
  serial: stm32: add support for RS485 hardware control mode

 .../devicetree/bindings/serial/st,stm32-usart.txt  |   2 +
 drivers/tty/serial/stm32-usart.c                   | 130 ++++++++++++++++++++-
 drivers/tty/serial/stm32-usart.h                   |   3 +
 3 files changed, 134 insertions(+), 1 deletion(-)

-- 
1.9.1
