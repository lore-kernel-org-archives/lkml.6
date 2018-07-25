Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C695C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 11:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27E3B2088E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 11:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="GfsFqiSZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27E3B2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbeGYMXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 08:23:08 -0400
Received: from mail-ve1eur01on0122.outbound.protection.outlook.com ([104.47.1.122]:40784
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728732AbeGYMXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 08:23:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WzmBkG+9BsgCOZv2LICz6uW9/vSso8eW0MYxIWdTyNI=;
 b=GfsFqiSZbXWAoaCO25RLwLpVD4I+tNiZz9KG6vLRbLNITFYl4mnecMVn7TKp/XOUF2iYyMcloal17fAx/UTgvkbUBGnUgjdnk9M3F93WVxVn321xomZaYS1cche12opJhz2q/zvGBVpjG5x91rG8qXQWzf0Ib51CSR27Wr19+jc=
Received: from DB6PR0501MB2583.eurprd05.prod.outlook.com (10.168.74.23) by
 DB6PR0501MB2551.eurprd05.prod.outlook.com (10.168.74.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Wed, 25 Jul 2018 11:11:53 +0000
Received: from DB6PR0501MB2583.eurprd05.prod.outlook.com
 ([fe80::24a6:f7a1:3235:a6b9]) by DB6PR0501MB2583.eurprd05.prod.outlook.com
 ([fe80::24a6:f7a1:3235:a6b9%9]) with mapi id 15.20.0973.022; Wed, 25 Jul 2018
 11:11:53 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH 22/28] ARM: tegra: apalis_t30: add i2c-thermtrip
Thread-Topic: [PATCH 22/28] ARM: tegra: apalis_t30: add i2c-thermtrip
Thread-Index: AQHUIdweIDkkPN+J7EuolK4SVs0E8aSfzNqA
Date:   Wed, 25 Jul 2018 11:11:52 +0000
Message-ID: <1532517111.6124.38.camel@toradex.com>
References: <20180722164936.20581-1-marcel@ziswiler.com>
         <20180722164936.20581-23-marcel@ziswiler.com>
In-Reply-To: <20180722164936.20581-23-marcel@ziswiler.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0501MB2551;6:7B9Nl035N9Y27UbIvkSZJu4oDHVaVdJ8R5HFvwcPiTzzGJJzU5IjGGFLnZIAjDs5RKYFixnIYgFFbS3de7uylbfx9/xEJLJqUMsjCbs/FjjRiXP1ouME+DVEaYrEDIfq8GkhTI3HaUxZsWknK2f78NXNx3VYRe+N+DGBKEIgYBhJkZlUDOo4aV7yeWCNBbKuzJInaoPjzciRk9DAQcVHuelj+Jc1SthKuGKvlxgZRg6P5OrmdbZ4a25lihwCynciedcZ/W/55UhEbt/zcJEp3FsN4nWe1iRJEEKi6zVifmC5xXZIH+XJ00k0UoNYW2Ggjy8yzjhoVFUIhL11Maesx+VXJpFTQtje/HJOE4G9JdQOc0+ryqD3Jb6ceA3eMZcHCJRMeO/XpdNTNyari57iPWqhGAdIE1kYV6zQn0VYDGSwd95jj7+tykDLa2OomdXbG2g/eHoMGr24SeDcjpioxQ==;5:YzPiYKhjRJU+f4Y+j0DlzJSG6CWqY9MyrWU6TQoJNZo646rD95F2OUrtzbdfLY6dwm8USqrFE6ZM2SNGThLwKrRpXczu5CCAGp8XWbRQxCVUeVfhAcwM8gSa3d4nA9uKz3NOn6Si8jg+e/BovP0bB/PAgwSXHbyxmWbtGRFb6hk=;7:nG+gkI2bucunaPw9n03RhKq3OcnzAhAeOz2QODLJKlhFmlMUbAvXOapUGjZRJKqSZ107yptUODnnla/sBblxeDGwNNT7bYAptZIR636RS2Xa2lzdFtcY1aCTkQtKezF7xnhDyZiGe8Gp3xzpmGmg0naiZkkbyGzUGoD/MUBltUo06viu+zAHSlNh/uZ7IyRbDvjyEr76lAb4fIhor7yn2yZhxaKVZsWAbaTDvP25VIIEUdX8lD4K6XdfxOl0hEo9
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 50272bdb-ed1f-4c38-e0b6-08d5f21f6d33
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DB6PR0501MB2551;
x-ms-traffictypediagnostic: DB6PR0501MB2551:
x-microsoft-antispam-prvs: <DB6PR0501MB255120382930B3ED895CA4A8FB540@DB6PR0501MB2551.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DB6PR0501MB2551;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0501MB2551;
x-forefront-prvs: 0744CFB5E8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(366004)(376002)(396003)(39840400004)(189003)(199004)(36756003)(2616005)(6246003)(54906003)(2900100001)(110136005)(68736007)(6512007)(66066001)(99286004)(103116003)(3846002)(81156014)(8676002)(81166006)(6116002)(14454004)(25786009)(86362001)(8936002)(2501003)(486006)(476003)(97736004)(2906002)(2201001)(53936002)(4326008)(478600001)(39060400002)(7736002)(5660300001)(102836004)(6486002)(229853002)(6436002)(305945005)(6506007)(26005)(106356001)(76176011)(44832011)(446003)(11346002)(316002)(5250100002)(256004)(186003)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0501MB2551;H:DB6PR0501MB2583.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 96Y+WN2MSNj+V1t1RbSw91NGLz74pCgXueU0H1Z71cCIh0F8WSq4kQsdOqPwEM4yikCxdKJ+MZIVTz5UZz6parxZtBn5CxlVlXpkXnCOqGPX8QEDxi8PJniHY+5xd79Lrag+WkR68/+qQuZGu5Y1nhzZFPDjA6+/+9D8TjKKf+CYfHpLtBDmem2ERkMHEPKnXkhZ/zpM5x+dDYYY3UtYpsaQKvQa5qfl5pOvuodSRUACgM2cVTueHsRgylpNZwuDl+Ebm1QqdBTE+WRnRD06lsrft8W8qPzw4YAEoarBzIvm1yR3QiuPIoOE1wc0ADEWIP4bFHbiZGSTh3vfXKOEFd3P2UV0uWWzzmYfAOMi7OM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <EDB412CC915171439E04D55B39F14A77@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50272bdb-ed1f-4c38-e0b6-08d5f21f6d33
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2018 11:11:53.1586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0501MB2551
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCAyMDE4LTA3LTIyIGF0IDE4OjQ5ICswMjAwLCBNYXJjZWwgWmlzd2lsZXIgd3JvdGU6
DQo+IEZyb206IE1hcmNlbCBaaXN3aWxlciA8bWFyY2VsLnppc3dpbGVyQHRvcmFkZXguY29tPg0K
PiANCj4gQWRkIGkyYy10aGVybXRyaXAgd2hpY2ggd291bGQgc2V0IHRoZSBERVZfT0ZGIGJpdCBp
biB0aGUgRENEQyBjb250cm9sDQo+IHJlZ2lzdGVyIG9mIHRoZSBUUFM2NTkxMSBQTUlDLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogTWFyY2VsIFppc3dpbGVyIDxtYXJjZWwuemlzd2lsZXJAdG9yYWRl
eC5jb20+DQo+IA0KPiAtLS0NCj4gDQo+ICBhcmNoL2FybS9ib290L2R0cy90ZWdyYTMwLWFwYWxp
cy5kdHNpIHwgOCArKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL3RlZ3JhMzAtYXBhbGlzLmR0c2kN
Cj4gYi9hcmNoL2FybS9ib290L2R0cy90ZWdyYTMwLWFwYWxpcy5kdHNpDQo+IGluZGV4IDRlOGVh
MWE4ZDllYy4uZjhjYWYzZjA3ZmZmIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy90
ZWdyYTMwLWFwYWxpcy5kdHNpDQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL3RlZ3JhMzAtYXBh
bGlzLmR0c2kNCj4gQEAgLTEwNTUsNiArMTA1NSwxNCBAQA0KPiAgCQludmlkaWEsY29yZS1wd3It
b2ZmLXRpbWUgPSA8MD47DQo+ICAJCW52aWRpYSxjb3JlLXBvd2VyLXJlcS1hY3RpdmUtaGlnaDsN
Cj4gIAkJbnZpZGlhLHN5cy1jbG9jay1yZXEtYWN0aXZlLWhpZ2g7DQo+ICsNCj4gKwkJLyogU2V0
IERFVl9PRkYgYml0IGluIERDREMgY29udHJvbCByZWdpc3RlciBvZg0KPiBUUFM2NTkxMSBQTUlD
ICovDQo+ICsJCWkyYy10aGVybXRyaXAgew0KPiArCQkJbnZpZGlhLGkyYy1jb250cm9sbGVyLWlk
ID0gPDQ+Ow0KPiArCQkJbnZpZGlhLGJ1cy1hZGRyID0gPDB4MmQ+Ow0KPiArCQkJbnZpZGlhLHJl
Zy1hZGRyID0gPDB4M2U+Ow0KDQpXaGVuIHJ1bm5pbmcgc29tZSBtb3JlIHRlc3RzIEkganVzdCBy
ZWFsaXplZCB0aGF0IHRoZSByZWctYWRkciBzaG91bGQNCnJlYWxseSBiZSAweDNmIGluc3RlYWQu
IFdpbGwgY2hhbmdlIHRoaXMgaW4gYSB2Mi4NCg0KPiArCQkJbnZpZGlhLHJlZy1kYXRhID0gPDB4
MT47DQo+ICsJCX07DQo+ICAJfTsNCj4gIA0KPiAgCWFodWJANzAwODAwMDAgew==
