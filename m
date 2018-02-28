Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4104350-1519815217-2-14257936550259696224
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519815217; b=seS+72gxq3YRyL9GfbOeJBMPCN5DgRZYppYRbXGaADx+af3
    U2e/xSYXJxuLniU6isJqGSVPA9qSzjDvx8uIMkOQAUkyWVmjF4SuBJdtrurwuHic
    jpXrbjHZwUJk+Zwj6wmEXh6z8xCsXyZfr6SMp+lA398ycU6QDfr62kkdAyLLbecx
    pXDiHtZnbXo6CEp1y/VGw8Zq2R1bNqfLm7W4QKxRlfxRNZE+AM7iUmTg8SHhoOa0
    XhBZ19v4hDa8bfOm59y9o+1ttzssD/iNS7mmi7q6vDFJr4ddY65Gd6jOMA+21ZRe
    XfEzySrkOvNXQWm0dbz1vv2b1hjIwwDc3BuoFcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :content-type:content-transfer-encoding:mime-version:sender
    :list-id; s=arctest; t=1519815217; bh=e1nkTm/TvJpptATu2Kuu6h8SlH
    xr2Pwz9XJ9+FYXjjs=; b=e2TpSM6O08tJnuVos2zVB/LvisuTZZ3IFLBsAt0QBB
    a1MtzHGUxgg5QVafCPvF/aPvR1pxvuGTAbhToNihKrmgwsBybgcA9uvuRCJwBayV
    6UsjpDXGJfMKHIND2+LoXidvWEF/vEd9PbHLyHpLVjXHiCJ0OxEBtgkQ8hrxGqqE
    wo5ZB6GpaOzzAnNae0Xm5u7NMaxRTSgzS2lZ2ZRCsIDyadelmQshyBMv1p0hNrXl
    TpRwCO+u5DMiwX6nIsZNnSe249YU/ZfMN6MFKT+LV1a4wjiy1WN3o0ik/06teQ1d
    1p/G5G9iSA/3xK4s+ANw3IOPE8o8mRQ+hZ5FbFWqUpXQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752656AbeB1Kwn convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Wed, 28 Feb 2018 05:52:43 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:4290 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752283AbeB1Kwi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 28 Feb 2018 05:52:38 -0500
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
CC: Bich HEMON <bich.hemon@st.com>
Subject: [PATCH 0/2] Update interrupt names
Thread-Topic: [PATCH 0/2] Update interrupt names
Thread-Index: AQHTsIIPpjIbAcUZf0OKeLK3O9cgzA==
Date: Wed, 28 Feb 2018 10:51:16 +0000
Message-ID: <1519815044-22669-1-git-send-email-bich.hemon@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.47]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-28_06:,,
 signatures=0
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patchset updates existing stm32 usart driver by updating interrupt
initialization by name.

Bich Hemon (2):
  dt-bindings: serial: stm32: add wakeup option using note
  serial: stm32: update interrupt initialization

 Documentation/devicetree/bindings/serial/st,stm32-usart.txt | 4 ++++
 drivers/tty/serial/stm32-usart.c                            | 4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

-- 
1.9.1
