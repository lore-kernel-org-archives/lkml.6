Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4127268-1519815419-2-239266414711164664
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES daen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519815419; b=FBqdNgcAmm0JBZvP1CK+CXS/N1Z0lKrW12NUyrOfHRy2HFw
    FkJjmMg6AUDrKRoV+ZJvool07nydgFes74zgKauOHsC2SoEqCm4x4SvX1fncrini
    JEHuIjqegJylPekUVV/xtiJEF1EojAkJova1MZxJIF+iJQFiELzWUgLiE2gaHSS8
    tn68INeTfZX0yr43H8E8j7/Ugy34eEoiSk9ZKOF1niLP1wEs8cLmn0vgfsDLt4eZ
    CrhYTjqWwJP1QE9YcfOJMeFyDUM2VtWIp9hLt8FSayoPLbKdGXL0/J6BZEllBFqM
    NCfmKdhctDsoJEop2hAMKUN6ORXJLY3GrL2AXCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :content-type:content-transfer-encoding:mime-version:sender
    :list-id; s=arctest; t=1519815419; bh=oN4sHqYIiA0so1XswNcgfCwY4o
    VPSmWGTJrpBLTP7Wg=; b=fb1e3WIq+BHE6+DmPJkXbDnW4pig8dkoeK00AD0N6f
    n5Sb/QDnPLWNccwAEVpfPydWSY8hHEyhNcV4xyb7GwebGmjq0yTGXlpzxhv8Sz7O
    2OpRbKioUsMN3ao0XFwtAwQz39/F9zsL2pxj2HiO8Ep4U3/NdwvVPLxcDyqS+mG4
    j3gtTuZXU3OovktFkwtO4uYVLP7qYGlSR5wtnGZASIq3StZIdaO4Yoje5nVOLYLi
    0n8xz3m2gb9fFs8BdXfS/IxYocydPqv4UYmeyrOYUyDj/yjGjP5lJvoYb3c5SndW
    ePBtNSGEVcjRNq62NqB59z0Xzye2qP6nuNQ2cM9lu5oQ==
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
        id S1752566AbeB1K45 convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Wed, 28 Feb 2018 05:56:57 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:49518 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752542AbeB1K44 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 28 Feb 2018 05:56:56 -0500
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
Subject: [PATCH 0/2] Add support for RS485
Thread-Topic: [PATCH 0/2] Add support for RS485
Thread-Index: AQHTsILC22/91L3qWUOuDMDQVrCkmA==
Date: Wed, 28 Feb 2018 10:56:18 +0000
Message-ID: <1519815373-22940-1-git-send-email-bich.hemon@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.50]
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

This patchset updates existing stm32 usart driver by adding support for RS485.

Bich Hemon (2):
  dt-bindings: serial: stm32: add RS485 optional properties
  serial: stm32: add support for RS485 hardware control mode

 .../devicetree/bindings/serial/st,stm32-usart.txt  |   2 +
 drivers/tty/serial/stm32-usart.c                   | 134 ++++++++++++++++++++-
 drivers/tty/serial/stm32-usart.h                   |   3 +
 3 files changed, 138 insertions(+), 1 deletion(-)

-- 
1.9.1
