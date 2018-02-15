Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1841884-1518709730-2-15389979860574198913
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES daen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518709729; b=GQk5zX6AeJBmW+XG5mNncVrpha8keYzAoDGED7H40MG803A
    BMMsnpMIFXRzQdcWXgiHaWp2c4ZxzDCokMzSOYYV+A/dvnQyEVLAnR5PzZlavomY
    CMQIiVWOuXGb6FJU/C0qpgsZLw3Nosqb0Ersz/jU/DSF6RPQzT0EpMQtXJij2maa
    hrMVZLE941Esed16f1uHV9YndDyWLEvwO+nf4yH1tC/IEiFNFsWSijQYjHJnsrBQ
    beFPBo0D2hKGgFGvgkarAo+2T+sQQO8tMlOpHUqHLSBLbC4A6SbzyGpmU2LoFmY1
    vtX0QQxphW3ksfUniYjmiSprVmBWT9s07kgAX4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1518709729; bh=7tsFSv
    VPRdbG3LlMrfSeOTYUr2GiOgkBc0WVri27nEs=; b=s+ijvxMCxCkTD1ff1LVFez
    hSkRglhOHVCMRThxM7+uyElmafOlF9xhzUeu7T61ME3J14rsK29mCwVzkrZnNz32
    izCAs4VFnc/Zoa9dNw7bTP7WzS8mc6/d7rwXFoJUjxxMEC9I1SeGbRI+dtarFGIi
    NtJMKp+W02GGMnLhkvbH0FiLQ14sBySm+NsKQE9AX08I7rj+hxiiUIYgPVZOxros
    4ICKfIp4Gy3GIxdDkmSgs0NTwso5NvM3t9WvwHvDOFlohbwwrsu38gCvJ80ZwWOK
    nk6RS98RUlaqVIpS1oJ1fvm2AqwTUtipdgxHnbat1RS/1Bj2AATOWd6sPXpQiTow
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425064AbeBOPsQ convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Thu, 15 Feb 2018 10:48:16 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:34428 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1425051AbeBOPsM (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 15 Feb 2018 10:48:12 -0500
From: Amelie DELAUNAY <amelie.delaunay@st.com>
To: John Youn <johnyoun@synopsys.com>, Felipe Balbi <balbi@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [[INTERNAL] PATCH 0/2] Fix STM32F7 DWC2 OTG HS binding
Thread-Topic: [[INTERNAL] PATCH 0/2] Fix STM32F7 DWC2 OTG HS binding
Thread-Index: AQHTpnQyELJrq6n2OEaYQ+Ke72cmZqOlm64g
Date: Thu, 15 Feb 2018 15:48:04 +0000
Message-ID: <0d93c90528ca408eac19e4648f09156a@SFHDAG3NODE2.st.com>
References: <1518709601-17232-1-git-send-email-amelie.delaunay@st.com>
 <1518709601-17232-2-git-send-email-amelie.delaunay@st.com>
In-Reply-To: <1518709601-17232-2-git-send-email-amelie.delaunay@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.51]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-15_06:,,
 signatures=0
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Forget this one! Sorry for the inconvenience.

> -----Original Message-----
> From: Amelie DELAUNAY
> Sent: jeudi 15 février 2018 16:47
> To: John Youn <johnyoun@synopsys.com>; Felipe Balbi <balbi@kernel.org>;
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Rob Herring
> <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>
> Cc: linux-usb@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; Amelie DELAUNAY <amelie.delaunay@st.com>
> Subject: [[INTERNAL] PATCH 0/2] Fix STM32F7 DWC2 OTG HS binding
> 
> This patchset fixes STM32F7 DWC2 OTG HS binding. It actually re-applies the
> v2 former patches adding STM32F7 DWC2 OTG HS support.
> 
> Amelie Delaunay (2):
>   dt-bindings: usb: fix the STM32F7 DWC2 OTG HS core binding
>   usb: dwc2: fix STM32F7 USB OTG HS compatible
> 
>  Documentation/devicetree/bindings/usb/dwc2.txt | 2 +-
>  drivers/usb/dwc2/params.c                      | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> --
> 2.7.4

