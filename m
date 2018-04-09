Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3913452-1523242438-2-2467606929138112278
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523242437; b=dDB/tMEpnCNhdhFulDbQdMDYtPSrYnjNwBDRIwB18ddi4Jpkij
    8eBeD+gI+/CHfT0s0HSl6tIsWpT3YAb5RIEEkdNfpfLAqvTTG19+/vPeFW4SvWvG
    3mvnuP3WYerbdZrgv2qspgcW+yLmui+KgDroTavfZRWdl5phZf5w9fsaYMhb9AM3
    cVXz4ASLTk9d8C70Y88jDZHkCRjbykRNdHQpgthzZsrOaG14s/Dn2cOyiSfDSkkZ
    Y+MUsMy6nUhV9W4ayg2R0NyOOw//+abNQvbCdxamtX7Iu4W1oCwQWibX+TZh0VYF
    7+yQYvYK050NeLpEcmj3qPjE+TrREehmEvgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523242437; bh=JQPJMflQ2mKU5ZctEov3v5ePPJa6+extkG+ONsNnK9o=; b=
    cOqKsT6zqkr8FTaXQUSFosqbuHBJt1eQVqm07jN+tHFVcmkMk8WimNSMx8ejj2pk
    jwqtYvBkg43NagupYaL1EyqHIvSZ7pYSa8lRGmDAjSRq6M7gNipTf6MOIN4AVBrn
    YDDiOrtI/MeotXuOHFomsmKrdOD/NvOK8BXQ2BieEpp+CuGZ7IOZ9qD3zrbH4KVQ
    OGpe+X/duABaHJj7KnBgS5k3pNP+l0fSlSBySmlzcrMKb5qKf0M4mDaAT7TVcLH0
    qtXFnevzrFrl24GX/nlMIq4Vf/9iz9h/G1H70aSdBTvzKvsmzBEBpgOtOTSSeRfy
    Byp6HEdwhTh5CsAqdpEIgQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iTEX2rJT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iTEX2rJT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGmJ8GdarDqxbrMV4zFo32jHzr6zjbdNI5lRErZRhSDvoaoG1M2iyF86Sh6IFGRriCE/ewOdi34uMg5G7nR0mCnddRzrFjFj8NmA5UUraR2X3q2jCcrw
    oe0daPtTNOegjxhl4N9hcNmDMSB2UI+7rHp7LYfejS6PadC72LMWYF7HQ/Ymo6PZouZyDz50/9lbJTIPmW4v6HRRjLIbnQIvAoGDg6HZfyivCtdiHAPa4tX2
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=xNf9USuDAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=sxJ8H8CxQL1NTQ068MsA:9 a=30ZkFZvo4na4A1Mk:21 a=DFrggTE8_v1Xu4bR:21
    a=QEXdDO2ut3YA:10 a=SEwjQc04WA-l_NiBhQ7s:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758124AbeDICxQ (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:53:16 -0400
Received: from mail-sn1nam02on0138.outbound.protection.outlook.com ([104.47.36.138]:42256
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755333AbeDIA03 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:26:29 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Mathieu Malaterre <malat@debian.org>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 145/161] net: Extra '_get' in declaration of
 arch_get_platform_mac_address
Thread-Topic: [PATCH AUTOSEL for 4.14 145/161] net: Extra '_get' in
 declaration of arch_get_platform_mac_address
Thread-Index: AQHTz5jBJb/ZdsIVgUmOWBPR70fslQ==
Date: Mon, 9 Apr 2018 00:21:51 +0000
Message-ID: <20180409001936.162706-145-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0725;7:Nu/Hqdf0Bgf0yOIXYub03kjkpJ11RNl5Maldt37WcH14G19Dguq1RV03tPR+y/k/1pBPEiI1vdAn45YTD7i4NNZF0mqCQCV6/vZaj6MDVtuKdGybJ234fBe5bSZ2cjOm1akg7c7paKjhsCu204UjAEmHJTb1ZZnPsjKV4u8MgseLAT57+yniyhZk1H4zPHWLr52UW8rD5L25nCAClljwBEnd/jI4nVqlw09Z39Cj9Zz4BtxvwxyeumCgYeKL9cjg;20:6hGkXfqiMwioqJ36LWwSNwQBeGvysN+SND6xwXgXPyKgnLUGdAotaoHxvqCKTQeFO/AbjPyops75OL+DKXco4FBur/bdvNiZIJrW2wtr+IZt+doRLwZeAkph7qCXp9zUbdVrYiFGGFlB2dQoLO3giVquoAXYiCyn1rVPnJK6Xrc=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 288c1d0c-688f-4574-ad1c-08d59db082be
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0725;
x-ms-traffictypediagnostic: DM5PR2101MB0725:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0725EFBCC80253E76D5F2E85FBBF0@DM5PR2101MB0725.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0725;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0725;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(366004)(376002)(396003)(39860400002)(199004)(189003)(6486002)(81166006)(26005)(6512007)(4326008)(6666003)(6436002)(81156014)(8676002)(97736004)(186003)(36756003)(72206003)(53936002)(107886003)(2906002)(86362001)(76176011)(110136005)(305945005)(10090500001)(486006)(3660700001)(102836004)(5660300001)(14454004)(476003)(86612001)(446003)(99286004)(68736007)(66066001)(11346002)(54906003)(2616005)(1076002)(7736002)(5250100002)(25786009)(8936002)(478600001)(2900100001)(2501003)(3280700002)(105586002)(59450400001)(316002)(106356001)(22452003)(6506007)(3846002)(10290500003)(6116002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0725;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: rM84bS7J+pCITvxClKh/uAUP0UnN4N4VWePlWKayTlMqXJz1VXTv1ZtTsgNtaX/PsQD2FG26eZSnMrPQtoMRbaIV+dKo2pvsblQr8D3qlvwQ4B7eLNkvbU20AWHtG62aH3dMA/8sFZf/8YE2SZs2FgEEkAodioYrIIx5SPbVM85qQn/yW818liReOUb2w0bZoxWtmixIxRYn5mTUjyDy+nuOHX20+uTGE8JGiQg7r8VpgDvldCkzdzG125L0erIpv6AkrzWBqXQLvo+oZJFrL8VphdZ34JpKH5z9MnAlfJjEbPHUUew+yzRiQ4aJvtYkIEV1nBcwbI+gzjD0sKZUpHn0e2rIbtNkAxXuVkDXI9KVivlC+9RZMiGzktJdYeVS8OU1lKCWYdUolSi4rrvhWD/Ycw78+nq/5UbW1aD8wRM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <123DE2659D658445B01A9984A8AD79AC@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 288c1d0c-688f-4574-ad1c-08d59db082be
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:21:51.8623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0725
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogTWF0aGlldSBNYWxhdGVycmUgPG1hbGF0QGRlYmlhbi5vcmc+DQoNClsgVXBzdHJlYW0g
Y29tbWl0IGU3Mjg3ODljNTJhZmNjYzEyNzVjYmExZGQ4MTJmMDNhYmUxNmVhM2MgXQ0KDQpJbiBj
b21taXQgYzdmNWQxMDU0OTVhICgibmV0OiBBZGQgZXRoX3BsYXRmb3JtX2dldF9tYWNfYWRkcmVz
cygpIGhlbHBlci4iKSwNCnR3byBkZWNsYXJhdGlvbnMgd2VyZSBhZGRlZDoNCg0KICBpbnQgZXRo
X3BsYXRmb3JtX2dldF9tYWNfYWRkcmVzcyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHU4ICptYWNfYWRk
cik7DQogIHVuc2lnbmVkIGNoYXIgKmFyY2hfZ2V0X3BsYXRmb3JtX2dldF9tYWNfYWRkcmVzcyh2
b2lkKTsNCg0KQW4gZXh0cmEgJ19nZXQnIHdhcyBpbnRyb2R1Y2VkIGluIGFyY2hfZ2V0X3BsYXRm
b3JtX2dldF9tYWNfYWRkcmVzcywgcmVtb3ZlDQppdC4gRml4IGNvbXBpbGUgd2FybmluZyB1c2lu
ZyBXPTE6DQoNCiAgQ0MgICAgICBuZXQvZXRoZXJuZXQvZXRoLm8NCm5ldC9ldGhlcm5ldC9ldGgu
Yzo1MjM6MjQ6IHdhcm5pbmc6IG5vIHByZXZpb3VzIHByb3RvdHlwZSBmb3Ig4oCYYXJjaF9nZXRf
cGxhdGZvcm1fbWFjX2FkZHJlc3PigJkgWy1XbWlzc2luZy1wcm90b3R5cGVzXQ0KIHVuc2lnbmVk
IGNoYXIgKiBfX3dlYWsgYXJjaF9nZXRfcGxhdGZvcm1fbWFjX2FkZHJlc3Modm9pZCkNCiAgICAg
ICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+DQogIEFSICAg
ICAgbmV0L2V0aGVybmV0L2J1aWx0LWluLm8NCg0KU2lnbmVkLW9mZi1ieTogTWF0aGlldSBNYWxh
dGVycmUgPG1hbGF0QGRlYmlhbi5vcmc+DQpTaWduZWQtb2ZmLWJ5OiBEYXZpZCBTLiBNaWxsZXIg
PGRhdmVtQGRhdmVtbG9mdC5uZXQ+DQpTaWduZWQtb2ZmLWJ5OiBTYXNoYSBMZXZpbiA8YWxleGFu
ZGVyLmxldmluQG1pY3Jvc29mdC5jb20+DQotLS0NCiBpbmNsdWRlL2xpbnV4L2V0aGVyZGV2aWNl
LmggfCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
DQoNCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2V0aGVyZGV2aWNlLmggYi9pbmNsdWRlL2xp
bnV4L2V0aGVyZGV2aWNlLmgNCmluZGV4IDJkOWY4MDg0OGQ0Yi4uYzY0M2NjN2ZlZmI1IDEwMDY0
NA0KLS0tIGEvaW5jbHVkZS9saW51eC9ldGhlcmRldmljZS5oDQorKysgYi9pbmNsdWRlL2xpbnV4
L2V0aGVyZGV2aWNlLmgNCkBAIC0zMSw3ICszMSw3IEBADQogI2lmZGVmIF9fS0VSTkVMX18NCiBz
dHJ1Y3QgZGV2aWNlOw0KIGludCBldGhfcGxhdGZvcm1fZ2V0X21hY19hZGRyZXNzKHN0cnVjdCBk
ZXZpY2UgKmRldiwgdTggKm1hY19hZGRyKTsNCi11bnNpZ25lZCBjaGFyICphcmNoX2dldF9wbGF0
Zm9ybV9nZXRfbWFjX2FkZHJlc3Modm9pZCk7DQordW5zaWduZWQgY2hhciAqYXJjaF9nZXRfcGxh
dGZvcm1fbWFjX2FkZHJlc3Modm9pZCk7DQogdTMyIGV0aF9nZXRfaGVhZGxlbih2b2lkICpkYXRh
LCB1bnNpZ25lZCBpbnQgbWF4X2xlbik7DQogX19iZTE2IGV0aF90eXBlX3RyYW5zKHN0cnVjdCBz
a19idWZmICpza2IsIHN0cnVjdCBuZXRfZGV2aWNlICpkZXYpOw0KIGV4dGVybiBjb25zdCBzdHJ1
Y3QgaGVhZGVyX29wcyBldGhfaGVhZGVyX29wczsNCi0tIA0KMi4xNS4xDQo=
