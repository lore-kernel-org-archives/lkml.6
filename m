Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E217C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EA20222DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502339AbfBNPwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 10:52:12 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:46498 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387547AbfBNPwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 10:52:12 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1EFUdm8018329;
        Thu, 14 Feb 2019 16:51:51 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2qmwsum8ty-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 14 Feb 2019 16:51:51 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 386E738;
        Thu, 14 Feb 2019 15:51:50 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag4node3.st.com [10.75.127.12])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 041AF587B;
        Thu, 14 Feb 2019 15:51:50 +0000 (GMT)
Received: from SFHDAG5NODE3.st.com (10.75.127.15) by SFHDAG4NODE3.st.com
 (10.75.127.12) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 14 Feb
 2019 16:51:49 +0100
Received: from SFHDAG5NODE3.st.com ([fe80::7c09:5d6b:d2c7:5f47]) by
 SFHDAG5NODE3.st.com ([fe80::7c09:5d6b:d2c7:5f47%20]) with mapi id
 15.00.1347.000; Thu, 14 Feb 2019 16:51:49 +0100
From:   Christophe ROULLIER <christophe.roullier@st.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     "robh@kernel.org" <robh@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "joabreu@synopsys.com" <joabreu@synopsys.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Peppe CAVALLARO <peppe.cavallaro@st.com>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH 2/8] net: ethernet: stmmac: update to support all PHY
 config for stm32mp157c.
Thread-Topic: [PATCH 2/8] net: ethernet: stmmac: update to support all PHY
 config for stm32mp157c.
Thread-Index: AQHUxHYStTBKTIMizUiYISVPutO8+6XfVpoAgAAKGoA=
Date:   Thu, 14 Feb 2019 15:51:49 +0000
Message-ID: <66e5d183-6952-44a2-926a-91f4ff363024@st.com>
References: <1550126763-22669-1-git-send-email-christophe.roullier@st.com>
 <1550126763-22669-3-git-send-email-christophe.roullier@st.com>
 <20190214134040.GA5699@lunn.ch> <02cd7773-899f-b28a-ff61-849b17cbe82d@st.com>
 <20190214151540.GG708@lunn.ch>
In-Reply-To: <20190214151540.GG708@lunn.ch>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.51]
Content-Type: text/plain; charset="utf-8"
Content-ID: <9E112A135F78B34A8FB7B9DA49282314@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-14_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMi8xNC8xOSA0OjE1IFBNLCBBbmRyZXcgTHVubiB3cm90ZToNCj4+IFNvcnJ5LCBJJ3ZlIG1p
c3VuZGVyc3Rvb2QgeW91ciBxdWVzdGlvbiA7LSkNCj4+DQo+PiBBbmQgeW91IHNwb2tlIGFib3V0
IDoNCj4+DQo+PiBjYXNlIFBIWV9JTlRFUkZBQ0VfTU9ERV9SR01JSToNCj4+IGNhc2UgUEhZX0lO
VEVSRkFDRV9NT0RFX1JHTUlJX0lEOg0KPj4gY2FzZSBQSFlfSU5URVJGQUNFX01PREVfUkdNSUlf
UlhJRDoNCj4+IGNhc2UgUEhZX0lOVEVSRkFDRV9NT0RFX1JHTUlJX1RYSUQ6DQo+Pg0KPj4gU28g
aW4gbXkgc2V0dXAgSSd2ZSBvbmx5IFJHTUlJIGludGVyZmFjZSwgc28gSSd2ZSBuZXZlciB0ZXN0
ZWQgMyBvdGhlcnMNCj4+IGludGVyZmFjZXMgKF9JRCwgX1JYSUQsIF9UWElEKS4NCj4+DQo+PiBT
byBkbyBJIG5lZWQgdG8gYWRkIGNhc2VzIGluIG15IGRyaXZlciA/DQo+IA0KPiBZZXMuIFRoZXkg
YWxsIGluZGljYXRlIHRoZSBNQUMgc2hvdWxkIGJlIHVzaW5nIFJHTUlJLg0KPiANCj4gVGhpcyBh
cHBlYXJzIHRvIGJlIGFuIG9sZCBpc3N1ZSwgYnV0IG5vdyB3b3VsZCBiZSBhIGdvb2QgdGltZSB0
byBmaXgNCj4gaXQuDQo+IA0KPiAgICAgICBBbmRyZXcNCj4gDQpPayBBbmRyZXcsIEkgd2lsbCB1
cGRhdGUgd2l0aCB0aGVzZQ0KDQpUaGFua3MNCg0KQ2hyaXN0b3BoZQ==
