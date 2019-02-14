Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB20DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6029222C9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393231AbfBNPBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 10:01:15 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:35965 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388581AbfBNPBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 10:01:14 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1EEuAw2016316;
        Thu, 14 Feb 2019 16:00:50 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2qmy1nbkt5-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 14 Feb 2019 16:00:50 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BAA3638;
        Thu, 14 Feb 2019 15:00:49 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag4node1.st.com [10.75.127.10])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7863556BE;
        Thu, 14 Feb 2019 15:00:49 +0000 (GMT)
Received: from SFHDAG5NODE3.st.com (10.75.127.15) by SFHDAG4NODE1.st.com
 (10.75.127.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 14 Feb
 2019 16:00:48 +0100
Received: from SFHDAG5NODE3.st.com ([fe80::7c09:5d6b:d2c7:5f47]) by
 SFHDAG5NODE3.st.com ([fe80::7c09:5d6b:d2c7:5f47%20]) with mapi id
 15.00.1347.000; Thu, 14 Feb 2019 16:00:48 +0100
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
Thread-Index: AQHUxHYStTBKTIMizUiYISVPutO8+w==
Date:   Thu, 14 Feb 2019 15:00:48 +0000
Message-ID: <02cd7773-899f-b28a-ff61-849b17cbe82d@st.com>
References: <1550126763-22669-1-git-send-email-christophe.roullier@st.com>
 <1550126763-22669-3-git-send-email-christophe.roullier@st.com>
 <20190214134040.GA5699@lunn.ch>
In-Reply-To: <20190214134040.GA5699@lunn.ch>
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
Content-ID: <B075AACED2AAD9479761DEBAEF570936@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-14_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMi8xNC8xOSAyOjQwIFBNLCBBbmRyZXcgTHVubiB3cm90ZToNCj4gICBPbiBUaHUsIEZlYiAx
NCwgMjAxOSBhdCAwNzo0NTo1N0FNICswMTAwLCBDaHJpc3RvcGhlIFJvdWxsaWVyIHdyb3RlOg0K
Pj4gQEAgLTEzMSwxOSArMTg1LDE5IEBAIHN0YXRpYyBpbnQgc3RtMzJtcDFfc2V0X21vZGUoc3Ry
dWN0IHBsYXRfc3RtbWFjZW5ldF9kYXRhICpwbGF0X2RhdCkNCj4+ICAgCWNhc2UgUEhZX0lOVEVS
RkFDRV9NT0RFX1JHTUlJOg0KPj4gICAJCXZhbCA9IFNZU0NGR19QTUNSX0VUSF9TRUxfUkdNSUk7
DQo+PiAtCQlpZiAoZHdtYWMtPmludF9waHljbGspDQo+PiArCQlpZiAoZHdtYWMtPmV0aF9jbGtf
c2VsX3JlZykNCj4+ICAgCQkJdmFsIHw9IFNZU0NGR19QTUNSX0VUSF9DTEtfU0VMOw0KPj4gICAJ
CXByX2RlYnVnKCJTWVNDRkcgaW5pdCA6IFBIWV9JTlRFUkZBQ0VfTU9ERV9SR01JSVxuIik7DQo+
PiAgIAkJYnJlYWs7DQo+IA0KPiBIaSBDaHJpc3RvcGhlDQo+IA0KPiBUaGlzIGNvZGUgc2hvdWxk
IGhhbmRsZSBhbGwgNCBQSFlfSU5URVJGQUNFX01PREVfUkdNSUkqIHZhbHVlcy4NCj4gDQo+ICAg
ICAgIEFuZHJldw0KPiANCg0KDQpSZVJlSGkgQW5kcmV3LA0KDQpTb3JyeSwgSSd2ZSBtaXN1bmRl
cnN0b29kIHlvdXIgcXVlc3Rpb24gOy0pDQoNCkFuZCB5b3Ugc3Bva2UgYWJvdXQgOg0KDQpjYXNl
IFBIWV9JTlRFUkZBQ0VfTU9ERV9SR01JSToNCmNhc2UgUEhZX0lOVEVSRkFDRV9NT0RFX1JHTUlJ
X0lEOg0KY2FzZSBQSFlfSU5URVJGQUNFX01PREVfUkdNSUlfUlhJRDoNCmNhc2UgUEhZX0lOVEVS
RkFDRV9NT0RFX1JHTUlJX1RYSUQ6DQoNClNvIGluIG15IHNldHVwIEkndmUgb25seSBSR01JSSBp
bnRlcmZhY2UsIHNvIEkndmUgbmV2ZXIgdGVzdGVkIDMgb3RoZXJzIA0KaW50ZXJmYWNlcyAoX0lE
LCBfUlhJRCwgX1RYSUQpLg0KDQpTbyBkbyBJIG5lZWQgdG8gYWRkIGNhc2VzIGluIG15IGRyaXZl
ciA/DQoNClRoYW5rcw0KDQpDaHJpc3RvcGhlDQoNCg0K
