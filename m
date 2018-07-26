Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A09FC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 09:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6D1D2088E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 09:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qDo9HlGm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6D1D2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729254AbeGZLHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 07:07:22 -0400
Received: from mail-eopbgr60079.outbound.protection.outlook.com ([40.107.6.79]:55837
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728792AbeGZLHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 07:07:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+uMtg0abO33TtEpfeBbTWDcIHo0GKEWzY5uvj5pbhoI=;
 b=qDo9HlGm3GiBk0MO+u1+0NC+vmVTX/jD2MVP5qvCdGCwgKvGB2X6i1AUVBviLQI0zSO7dUNU9o3nt+xe1gr7UN6wYsgBNsvCWWJdgqxwiTPNsJ2xw2KEdOLz1vIoHAnQL1N7swpuPqvIdYRCz9lZVZPp+7FVtMximmIodtCzhlk=
Received: from DB6PR04MB3223.eurprd04.prod.outlook.com (10.170.211.19) by
 DB6PR04MB3287.eurprd04.prod.outlook.com (10.170.216.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.16; Thu, 26 Jul 2018 09:51:14 +0000
Received: from DB6PR04MB3223.eurprd04.prod.outlook.com
 ([fe80::b52c:4b0a:5bf4:cbfd]) by DB6PR04MB3223.eurprd04.prod.outlook.com
 ([fe80::b52c:4b0a:5bf4:cbfd%4]) with mapi id 15.20.0973.022; Thu, 26 Jul 2018
 09:51:14 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Russell King <linux@armlinux.org.uk>,
        dl-linux-imx <linux-imx@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>
Subject: RE: [PATCH v8 1/6] ARM: imx6q: provide documentation for new
 fsl,pmic-stby-poweroff property
Thread-Topic: [PATCH v8 1/6] ARM: imx6q: provide documentation for new
 fsl,pmic-stby-poweroff property
Thread-Index: AQHUJMI388q4zA1ybU+fByMY2n4yEKShPSxQ
Date:   Thu, 26 Jul 2018 09:51:13 +0000
Message-ID: <DB6PR04MB3223605CB1F5E06D4A278B3C892B0@DB6PR04MB3223.eurprd04.prod.outlook.com>
References: <20180726092220.17250-1-o.rempel@pengutronix.de>
 <20180726092220.17250-2-o.rempel@pengutronix.de>
In-Reply-To: <20180726092220.17250-2-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR04MB3287;6:x0rNFChd6aNfn0/Fnf0WBdOIb8di77VSl8aNbnoVeRDLT1/u6j4SasvcT+Fz5K6+1Yfo2RcCJyp8OMQ3PYPhQmkJz1ytFCSwJhkYbwPKnGqzK0mLi6FkDHRCI1OpO/9ce2CRRkpL2DrlXDkpsHFRgZB03tfLQtA6lZ0VHaALrXvYqvgFe+oHsVoIZ40m1cA6A+Wx/Eh8tp8yhMmLYun6HPK9ONnLW9We1iGoTJf8aFtbpD0tNDbeeeGlsqGtAxP/z7BLHeUFZDsVcvyA6EOk2H0v9fjV37VtGaslhjIS2/qQOM+F6tuxvTzmIs+/kE6BFWDNqzDLiYruy3UQNgZt2Nctc3gEfxjsYp3Vi8rqE/Yk0uMKpIHfauZKnVpAfOplhU+a8UcyFKmd/LcW65UGp2O74wdsjKWi+cwR0fpsuiuoWUI+89h9EIEDHjNBWhugVk9JTRMmkj/jT1LQEy0fHw==;5:A8IUv2bOnEjuJ3lydNCRPB9yTxIr8YmpZQzufJbIvJ0WkPlBVJXEadMIKVw0uW4AIm/uHEHMr6SBE1FkjrM1yz9Yyo3D3ur3YrXTxMpkUZ66qYpG9SmFKXNbDaQizT207I02N0LF7IbG5hWmi/e4Xu2LrKjtICHX4ZVrnOXI+Ys=;7:pg26AgVgYwK48CyOhuFHO1j4/K9SB2hhsBxFOyNjsE5qR2CBmWAPIvJNCPkbD+sPy0Cu/rn3aAdVIfEZlWYVYcLh86LzAVhzIQv82p5g0n1BvpRoHv61HNpoQHXQH/UslnpCocqwtP7doNlXr1MskTR8BPteVQNrXZK1AkzRvJbmycHDZJs5eZ7y//aOZUxLzaUDRodzG0kqkuJkAqCYgVhP+Xce4MgaiAGx/dVHR6aIQ/mQkz4GYny+Roa90Wbj
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 0bf6b7be-15dc-4e42-1671-08d5f2dd5343
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DB6PR04MB3287;
x-ms-traffictypediagnostic: DB6PR04MB3287:
x-microsoft-antispam-prvs: <DB6PR04MB3287BD84175B39DC940039F3892B0@DB6PR04MB3287.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(85827821059158)(258649278758335)(21532816269658)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB6PR04MB3287;BCL:0;PCL:0;RULEID:;SRVR:DB6PR04MB3287;
x-forefront-prvs: 07459438AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(366004)(396003)(39860400002)(376002)(199004)(189003)(13464003)(97736004)(8936002)(256004)(68736007)(66066001)(105586002)(106356001)(5250100002)(7416002)(2906002)(39060400002)(5660300001)(81166006)(81156014)(8676002)(74316002)(305945005)(7736002)(4326008)(6246003)(25786009)(86362001)(316002)(110136005)(446003)(54906003)(11346002)(55016002)(33656002)(102836004)(26005)(186003)(76176011)(229853002)(99286004)(53546011)(6506007)(7696005)(2900100001)(6116002)(3846002)(9686003)(486006)(478600001)(6436002)(14454004)(476003)(53936002)(32563001)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR04MB3287;H:DB6PR04MB3223.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 2v+bSWjMITHDPrIULx3pROyqXpXjcI7Y26DplwqzuU/Cqv35+/v/iYZs6MZElcohGZwyMqNyP4p8jyh0t4HXiDw32K/Zg5mRyoZf6lGqQlwY4m8JOuEnl3IhRJBKC0c/0eiWxcciVIqzpw5kl2jW29NJ9/vwKHo94OFZR+fAUOwORc00CwO9PpPXMhk00Mk4qZfYAjIdZKtWOOvB09C08iRrbZEPx7R5IC64CzEUroH9imP7qbqLputEPtRuNUp+bsE2l4DuEM64RAi8C8b5eA+b/5X93F4a8/5+2q7ubEpHaI5RSrHK6Yqh9JOtyDw1FBUuglmVePh0TkLpjBQMT8nGahlOR/FL97Es8QvMA2s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bf6b7be-15dc-4e42-1671-08d5f2dd5343
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2018 09:51:14.0292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3287
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogT2xla3NpaiBSZW1wZWwg
W21haWx0bzpvLnJlbXBlbEBwZW5ndXRyb25peC5kZV0NCj4gU2VudDogMjAxOMTqN9TCMjbI1SAx
NzoyMg0KPiBUbzogU2hhd24gR3VvIDxzaGF3bmd1b0BrZXJuZWwub3JnPjsgTWFyayBCcm93biA8
YnJvb25pZUBrZXJuZWwub3JnPjsNCj4gUmFmYWVsIEouIFd5c29ja2kgPHJhZmFlbC5qLnd5c29j
a2lAaW50ZWwuY29tPg0KPiBDYzogT2xla3NpaiBSZW1wZWwgPG8ucmVtcGVsQHBlbmd1dHJvbml4
LmRlPjsga2VybmVsQHBlbmd1dHJvbml4LmRlOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9y
ZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBsaW51eC1jbGtAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBBbmRyZXcgTW9ydG9u
DQo+IDxha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPjsgTGlhbSBHaXJkd29vZCA8bGdpcmR3b29k
QGdtYWlsLmNvbT47DQo+IExlb25hcmQgQ3Jlc3RleiA8bGVvbmFyZC5jcmVzdGV6QG54cC5jb20+
OyBSb2IgSGVycmluZw0KPiA8cm9iaCtkdEBrZXJuZWwub3JnPjsgTWFyayBSdXRsYW5kIDxtYXJr
LnJ1dGxhbmRAYXJtLmNvbT47IE1pY2hhZWwNCj4gVHVycXVldHRlIDxtdHVycXVldHRlQGJheWxp
YnJlLmNvbT47IFN0ZXBoZW4gQm95ZA0KPiA8c2JveWRAY29kZWF1cm9yYS5vcmc+OyBGYWJpbyBF
c3RldmFtIDxmYWJpby5lc3RldmFtQG54cC5jb20+OyBSdXNzZWxsDQo+IEtpbmcgPGxpbnV4QGFy
bWxpbnV4Lm9yZy51az47IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+OyBSb2JpbiBH
b25nDQo+IDx5aWJpbi5nb25nQG54cC5jb20+OyBBLnMuIERvbmcgPGFpc2hlbmcuZG9uZ0BueHAu
Y29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggdjggMS82XSBBUk06IGlteDZxOiBwcm92aWRlIGRvY3Vt
ZW50YXRpb24gZm9yIG5ldw0KPiBmc2wscG1pYy1zdGJ5LXBvd2Vyb2ZmIHByb3BlcnR5DQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBPbGVrc2lqIFJlbXBlbCA8by5yZW1wZWxAcGVuZ3V0cm9uaXguZGU+
DQo+IEFja2VkLWJ5OiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPg0KPiAtLS0NCj4gIERv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay9pbXg2cS1jbG9jay50eHQgfCA4
ICsrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Nsb2NrL2lteDZxLWNs
b2NrLnR4dA0KPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay9pbXg2
cS1jbG9jay50eHQNCj4gaW5kZXggYTQ1Y2E2N2E5ZDVmLi5lMTMwODM0NmUwMGQgMTAwNjQ0DQo+
IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay9pbXg2cS1jbG9j
ay50eHQNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Nsb2NrL2lt
eDZxLWNsb2NrLnR4dA0KPiBAQCAtNiw2ICs2LDE0IEBAIFJlcXVpcmVkIHByb3BlcnRpZXM6DQo+
ICAtIGludGVycnVwdHM6IFNob3VsZCBjb250YWluIENDTSBpbnRlcnJ1cHQNCj4gIC0gI2Nsb2Nr
LWNlbGxzOiBTaG91bGQgYmUgPDE+DQo+IA0KPiArT3B0aW9uYWwgcHJvcGVydGllczoNCj4gKy0g
ZnNsLHBtaWMtc3RieS1wb3dlcm9mZjogQ29uZmlndXJlIENDTSB0byBhc3NlcnQgUE1JQ19TVEJZ
X1JFUSBzaWduYWwNCj4gKyAgb24gcG93ZXIgb2ZmLg0KPiArICBVc2UgdGhpcyBwcm9wZXJ0eSBp
ZiB0aGUgU29DIHNob3VsZCBiZSBwb3dlcmVkIG9mZiBieSBleHRlcm5hbCBwb3dlcg0KPiArICBt
YW5hZ2VtZW50IElDIChQTUlDKSB0cmlnZ2VyZWQgdmlhIFBNSUNfU1RCWV9SRVEgc2lnbmFsLg0K
UE1JQ19PTl9SRVEgZGlkbid0IGNvbm5lY3QgdG8gYW55IHBpbiBvZiBQTUlDIGluIHlvdXIgY2Fz
ZT8gRG9uJ3QgdW5kZXJzdGFuZA0Kd2h5IG5vdCBmb2xsb3cgbm9ybWFsIGJvYXJkIGRlc2lnbiBn
dWlkZSB0byBwb3dlciBvZmYgcG1pYyBieSBQTUlDX09OX1JFUS4NCkhvdyB0byBwb3dlciBvbiBi
b2FyZCBhZ2FpbiB0aGVuPw0KPiArICBCb2FyZHMgdGhhdCBhcmUgZGVzaWduZWQgdG8gaW5pdGlh
dGUgcG93ZXJvZmYgb24gUE1JQ19PTl9SRVEgc2lnbmFsDQo+ICtzaG91bGQNCj4gKyAgYmUgdXNp
bmcgInN5c2Nvbi1wb3dlcm9mZiIgZHJpdmVyIGluc3RlYWQuDQo+ICsNCj4gIFRoZSBjbG9jayBj
b25zdW1lciBzaG91bGQgc3BlY2lmeSB0aGUgZGVzaXJlZCBjbG9jayBieSBoYXZpbmcgdGhlIGNs
b2NrICBJRCBpbg0KPiBpdHMgImNsb2NrcyIgcGhhbmRsZSBjZWxsLiAgU2VlIGluY2x1ZGUvZHQt
YmluZGluZ3MvY2xvY2svaW14NnFkbC1jbG9jay5oDQo+ICBmb3IgdGhlIGZ1bGwgbGlzdCBvZiBp
Lk1YNiBRdWFkIGFuZCBEdWFsTGl0ZSBjbG9jayBJRHMuDQo+IC0tDQo+IDIuMTguMA0KDQo=
