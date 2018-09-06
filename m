Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0FDC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC2352086C
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="a7ZwIH8v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC2352086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbeIFRK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:10:27 -0400
Received: from mail-eopbgr10133.outbound.protection.outlook.com ([40.107.1.133]:54816
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727757AbeIFRK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:10:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awif82iFlgbmB33WrDJ2toOorfuORpss5WFuGh1q1XQ=;
 b=a7ZwIH8vysFw+uYjRWjlVKPulFVAAB+hBJ15jmslJABS1l7zkqfbQ7rYf+7a8AJAgYmibcBkpmVsdCEDV9g46aPf5VUU1h+kPUGTqxuhQO/526GzuZHNHosRuHoCaEEKNJayceyXLf/beNiFoywqtXzio8vQpKj1joylJ2DxmHI=
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com (10.168.137.14) by
 VI1PR0501MB2494.eurprd05.prod.outlook.com (10.168.136.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.15; Thu, 6 Sep 2018 12:35:03 +0000
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::2952:58bf:2bbb:eb4a]) by VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::2952:58bf:2bbb:eb4a%3]) with mapi id 15.20.1122.009; Thu, 6 Sep 2018
 12:35:03 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "pdeschrijver@nvidia.com" <pdeschrijver@nvidia.com>,
        "digetx@gmail.com" <digetx@gmail.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v1 0/5] CPUFREQ OPP's and Tegra30 support by
 tegra20-cpufreq driver
Thread-Topic: [PATCH v1 0/5] CPUFREQ OPP's and Tegra30 support by
 tegra20-cpufreq driver
Thread-Index: AQHURd4IqlT7eKk1o0uiAc+lOYc9Hg==
Date:   Thu, 6 Sep 2018 12:35:03 +0000
Message-ID: <1536237301.25080.22.camel@toradex.com>
References: <20180830194356.14059-1-digetx@gmail.com>
In-Reply-To: <20180830194356.14059-1-digetx@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0501MB2494;6:edZkCHWPEdMIxq98MSJCPIPgzj0hMVvXwp9HpHhEGpmvf2144Mqlifx9Zgb5dFsQBi/IGyUSAWEeK5QAs5Kp4kYH3PPBEIu8jXotoaBdu4j7h/bSY1aw3UqG2XZva6ETBMaj3CA5KDjutOpqo6wVpbS7pYzYadbdMBR54wSoTGSk8KZWXdLmYsTO5be+FsjyPOS+EgGTnx/QpCbZiqXHpEMgi0EJlT+//9ALbcW4LMSwIP9l6IADctT+W3w5ckFd0GfNp00EWAbtRH+Tj0HmueFbrwbgaKO3jZFVAOZwXCt/Wvngy5QRSQ1AytcgiDgtwJLpq/3i6pkmodVKY9AHsSxkF8q/La2mmjsPpnQjURRicV0Xq8JLDhVnfmBhNC/c57KKtmWOkzo1Hj5Zkst+MgzCgMlXuC9a9w69eTVl5gjvsUrSR/MMD34FMyuKr73g6VROfmHBklNdyXJOg2Gxhw==;5:8fX1m3cRepSU2AX0gqdJIVhAXLkhMsxDy7bKOXnGSWMx18uAw7taDDYlEtYm51b6ltsptYYrv3AxLc/alZykgyOt0A2MQEDfWmnqBbD0lrQ9dilQDWhYOzfalfvwAqNhzkd0pDkCAmwZWR9AkzoPnjmWNYFG/4klUICt3Cmu9fM=;7:2OXfQ2+CZnevkHLBchDg35Zwrk1NVz5Oyj1u978iXR9PNttfQypub5W2QuxGagil0ZpU0Pkr4cLDk9fZ5UNaWodfvQDNzLzsMcqNcrsqFxjB9nF2ohBFDcWCzbFgFfC9h+xHZuUq4dcfrbvF+CCia9IvRDaNOGPqtr/rYwKOhpMrO6ysFNpfUZndWKwPjHIIIiWLmhgh4hXJTmqQND46e0KBZ7x/D9tmnOE37NNqmKM7ZpKijpZG/gghbw8Ziyvn
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a693ca04-1bcc-43d2-99b8-08d613f52b8f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2494;
x-ms-traffictypediagnostic: VI1PR0501MB2494:
x-microsoft-antispam-prvs: <VI1PR0501MB24940A913F85589E04441A01FB010@VI1PR0501MB2494.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(190756311086443);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:VI1PR0501MB2494;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB2494;
x-forefront-prvs: 0787459938
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(39840400004)(376002)(346002)(366004)(189003)(199004)(68736007)(14444005)(3846002)(103116003)(53936002)(110136005)(54906003)(6486002)(6246003)(256004)(39060400002)(2906002)(2900100001)(478600001)(81166006)(81156014)(316002)(14454004)(6116002)(6512007)(36756003)(186003)(8936002)(446003)(5660300001)(11346002)(26005)(6506007)(8676002)(105586002)(97736004)(102836004)(305945005)(7416002)(2501003)(106356001)(99286004)(4326008)(25786009)(6436002)(229853002)(476003)(2201001)(44832011)(5250100002)(486006)(7736002)(66066001)(76176011)(2616005)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0501MB2494;H:VI1PR0501MB2590.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: q0RtXekaAilHt/BLzD6IRDMVCDiofypCt1DYDgpidcTNw3wK8JSkAT4r9afda7g94txJwSeNxceb8TrEdt3GAXuN9S2jfk7A1u4YUH22CfROIGGuoBg2rXVKEXKn5Ps6HBcuqsryx9QPaiOWUp5mucsJ0R5uPXQ87djiF1+veLeEX1x9BG1f8JsPAaLzudV9zCp1dPJet/mPTdVkbZxDkwmxK8m/HLSh3DCMLosCc+ZEULW5vodte6Us+dM9SMOvWavg3FoRfNZe5rJWVpsCdskzJRb/QO2S7Gjg+whpq6q2sT0R+kToi4ZM+m5FTbuaCcM93CSheVNp7UpZ7HPlKW7cBeypPuTMuz7/yvKphSI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <B8B9D52C0E091E41A8E1A5A837F1F08F@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a693ca04-1bcc-43d2-99b8-08d613f52b8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2018 12:35:03.6219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2494
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE4LTA4LTMwIGF0IDIyOjQzICswMzAwLCBEbWl0cnkgT3NpcGVua28gd3JvdGU6
DQo+IEhlbGxvLA0KPiANCj4gVGhpcyBzZXJpZXMgYWRkcyBzdXBwb3J0IGZvciBDUFUgZnJlcXVl
bmN5IHNjYWxpbmcgb24gVGVncmEzMCBhbmQNCj4gZGV2aWNlDQo+IHRyZWUgc3VwcG9ydCB0aGF0
IGFsbG93cyB0byBpbXBsZW1lbnQgdGhlcm1hbCB0aHJvdHRsaW5nIGFuZA0KPiBjdXN0b21pemUN
Cj4gYXZhaWxhYmxlIENQVSBmcmVxdWVuY2llcyBwZXItYm9hcmQuIFRoZSB0ZWdyYTIwLWNwdWZy
ZXEgZHJpdmVyIGhhcw0KPiBiZWVuDQo+IHJlLXdvcmtlZCB0byBzdXBwb3J0IHRoYXQgYWxsLg0K
PiANCj4gTm90ZSB0aGF0IFRlZ3JhMzAgc3VwcG9ydCBub3Qgc3RyaWN0bHkgZGVwZW5kcyBvbiB0
aGUgY2xvY2sgcGF0Y2hlcw0KPiB0aGF0DQo+IGFyZSB1bmRlciByZXZpZXcgbm93LCBDUFVGUkVR
IGRyaXZlciB3aWxsIGZhaWwgdG8gcHJvYmUgdW50aWwgQ0NMS0cNCj4gY2xvY2sNCj4gd2lsbCBn
ZXQgZXhwb3NlZCBieSB0aGUgY2xvY2sgZHJpdmVyLiBIZW5jZSB0aGlzIHNlcmllcyBjYW4gYmUN
Cj4gYXBwbGllZA0KPiBpbmRlcGVuZGVudGx5IG9mIHRoZSBjbG9jayBwYXRjaGVzLCBDUFVGUkVR
IHdpbGwgc3RhcnQgdG8gd29yayBvbg0KPiBUZWdyYTMwDQo+IG9uY2UgYm90aCBwYXRjaHNldHMg
d2lsbCBiZSBhcHBsaWVkLg0KDQpJbiBnZW5lcmFsIHRoaXMgc2VlbXMgdG8gd29yayBmaW5lIGJv
dGggb24gQ29saWJyaSBUMjAgYXMgd2VsbCBhcw0KQXBhbGlzL0NvbGlicmkgVDMwLiBIb3dldmVy
IEkgZGlkIG5vdGljZSBhIGZldyB0aGluZ3MgcGx1cyBoYXZlIHNvbWUNCmFkZGl0aW9uYWwgcXVl
c3Rpb25zOg0KDQotIEJvdGggVDIwIGFzIHdlbGwgYXMgVDMwIGN1cnJlbnRseSBsaW1pdCB0aGUg
bWF4IGZyZXF1ZW5jeSB0byAxIEdIeg0Kd2hpbGUgdGhlcmUgYXJlIGNsZWFybHkgVDMwIFNLVXMg
d2hpY2ggbWF5IGFsbG93IGhpZ2hlciBmcmVxdWVuY2llcw0KKGUuZy4gb3VyIHJlZ3VsYXIgVDMw
IGFrYSBFbWJlZGRlZCBTS1UgMS4zIEdIeiBtYXggcmVzcC4gMS40IEdIeiBzaW5nbGUNCmNvcmUg
b25seSwgY29tbWVyY2lhbCBUMzAgYWthIEFQMzMgb3IgVDMzIG9yIHdoYXRldmVyIGl0IGlzIGNh
bGxlZCB1cA0KdG8gMS42IEdIeiBtYXggcmVzcC4gMS43IEdIeiBzaW5nbGUgY29yZSBvbmx5KS4g
V291bGQgSSBoYXZlIHRvIGFsbG93DQp0aGlzIHZpYSBjdXN0b20gT1BQcyBpbiBteSBkZXZpY2Ug
dHJlZT8NCg0KLSBIb3dldmVyLCBjZXJ0YWluIE9QUHMgbWF5IGFsc28gcmVxdWlyZSBhZGp1c3Rp
bmcgY29yZS9jcHUgdm9sdGFnZXMNCndoaWNoIGlzIG5vdCB5ZXQgdGFrZW4gY2FyZSBvZiBhcyBm
YXIgYXMgSSBjYW4gdGVsbCwgY29ycmVjdD8NCg0KLSBJIGJlbGlldmUgaW4gZG93bnN0cmVhbSBj
ZXJ0YWluIE9QUHMgYWxzbyB0YWtlIHNpbGljb24gcGFyYW1ldGVycyBha2ENCnNwZWVkbyB3aGF0
ZXZlciBpbnRvIGFjY291bnQuIEFueSBjb21tZW50cy9wbGFucyBjb25jZXJuaW5nIHRoaXM/DQoN
Ci0gV2l0aCAiY3B1ZnJlcS1pbmZvIC1mIiBJIGNvdWxkIG9ubHkgb2JzZXJ2ZSBsaWtlIHRoZSB0
b3AgMy00IE9QUHMNCndoaWxlIGl0IGRvZXMgbm90IHRvIGdvIGZ1cnRoZXIgZG93biBldmVuIHdo
ZW4gaWRsaW5nLiBXaHkgY291bGQgdGhhdA0KYmUgcmVzcC4gd2hhdCBjb3VsZCBjYXVzZSB0aGlz
Pw0KDQotIFVuZm9ydHVuYXRlbHkgImNwdWZyZXEtaW5mbyAtLXN0YXRzIiBjdXJyZW50bHkgZG9l
cyBub3Qgc2VlbSB0bw0Kb3V0cHV0IGFueXRoaW5nLiBXb3VsZCB0aGF0IHJlcXVpcmUgc29tZXRo
aW5nIHNwZWNpYWwgdG8gYmUNCmltcGxlbWVudGVkPw0KDQpPdGhlciB0aGFuIHRoYXQgeW91IG1h
eSBhZGQgdGhlIGZvbGxvd2luZyB0byB0aGUgd2hvbGUgc2VyaWVzOg0KDQpUZXN0ZWQtYnk6IE1h
cmNlbCBaaXN3aWxlciA8bWFyY2VsLnppc3dpbGVyQHRvcmFkZXguY29tPg0KDQo+IERtaXRyeSBP
c2lwZW5rbyAoNSk6DQo+ICAgZHQtYmluZGluZ3M6IGNwdWZyZXE6IEFkZCBiaW5kaW5nIGZvciBO
VklESUEgVGVncmEyMC8zMA0KPiAgIGNwdWZyZXE6IHRlZ3JhMjA6IFN1cHBvcnQgT1BQLCB0aGVy
bWFsIGNvb2xpbmcgYW5kIFRlZ3JhMzANCj4gICBBUk06IHRlZ3JhOiBDcmVhdGUgdGVncmEyMC1j
cHVmcmVxIGRldmljZSBvbiBUZWdyYTMwDQo+ICAgQVJNOiBkdHM6IHRlZ3JhMjA6IEFkZCBDUFUg
T3BlcmF0aW5nIFBlcmZvcm1hbmNlIFBvaW50cw0KPiAgIEFSTTogZHRzOiB0ZWdyYTMwOiBBZGQg
Q1BVIE9wZXJhdGluZyBQZXJmb3JtYW5jZSBQb2ludHMNCj4gDQo+ICAuLi4vY3B1ZnJlcS9udmlk
aWEsdGVncmEyMC1jcHVmcmVxLnR4dCAgICAgICAgfCAgMzggKysNCj4gIGFyY2gvYXJtL2Jvb3Qv
ZHRzL3RlZ3JhMjAuZHRzaSAgICAgICAgICAgICAgICB8ICA1OCArKysNCj4gIGFyY2gvYXJtL2Jv
b3QvZHRzL3RlZ3JhMzAuZHRzaSAgICAgICAgICAgICAgICB8ICA2NSArKysrDQo+ICBhcmNoL2Fy
bS9tYWNoLXRlZ3JhL3RlZ3JhLmMgICAgICAgICAgICAgICAgICAgfCAgIDQgKw0KPiAgZHJpdmVy
cy9jcHVmcmVxL0tjb25maWcuYXJtICAgICAgICAgICAgICAgICAgIHwgICAyICsNCj4gIGRyaXZl
cnMvY3B1ZnJlcS9jcHVmcmVxLWR0LXBsYXRkZXYuYyAgICAgICAgICB8ICAgMiArDQo+ICBkcml2
ZXJzL2NwdWZyZXEvdGVncmEyMC1jcHVmcmVxLmMgICAgICAgICAgICAgfCAzMzQgKysrKysrKysr
KysrKy0tLQ0KPiAtLQ0KPiAgNyBmaWxlcyBjaGFuZ2VkLCA0MjIgaW5zZXJ0aW9ucygrKSwgODEg
ZGVsZXRpb25zKC0pDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2NwdWZyZXEvbnZpZGlhLHRlZ3JhMjAtY3B1ZnJlcS50eHQ=
