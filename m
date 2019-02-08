Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB65C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 08:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53F0D2147C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 08:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=infinera.com header.i=@infinera.com header.b="PFgjf4rZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfBHIp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 03:45:56 -0500
Received: from mail-eopbgr760085.outbound.protection.outlook.com ([40.107.76.85]:52490
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726115AbfBHIp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 03:45:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m4DXjJ72H1jZBBg+2c1JXGEa2h0Ywog+ZFrR2J5vF/U=;
 b=PFgjf4rZNXFd9n67FX8BwPl/DzXn1kJd4bR0HpALJo/h7wD79TQU7FlQGGQ5iKoNxSa2L1zwIkB6DPxw29yuyY/yt7jpRGmK7tpX8dGg4krnf6lj38YML2bYDwsYV1xgf1fLCJuiiWj1UC84EIt3lxDx8Dy86JI2bx9G5LWZMHo=
Received: from BN8PR10MB3540.namprd10.prod.outlook.com (20.179.78.205) by
 BN8PR10MB3281.namprd10.prod.outlook.com (20.179.138.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Fri, 8 Feb 2019 08:45:53 +0000
Received: from BN8PR10MB3540.namprd10.prod.outlook.com
 ([fe80::4854:26a0:6934:7aa8]) by BN8PR10MB3540.namprd10.prod.outlook.com
 ([fe80::4854:26a0:6934:7aa8%6]) with mapi id 15.20.1601.016; Fri, 8 Feb 2019
 08:45:52 +0000
From:   Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To:     "ikegami_to@yahoo.co.jp" <ikegami_to@yahoo.co.jp>,
        "psobon@amazon.com" <psobon@amazon.com>,
        "boris.brezillon@collabora.com" <boris.brezillon@collabora.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ikegami@allied-telesis.co.jp" <ikegami@allied-telesis.co.jp>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "liujian56@huawei.com" <liujian56@huawei.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>
Subject: Re: Re: [PATCH] cfi: fix deadloop in cfi_cmdset_0002.c
 do_write_buffer
Thread-Topic: Re: [PATCH] cfi: fix deadloop in cfi_cmdset_0002.c
 do_write_buffer
Thread-Index: AQHUuWkwP8NVeFUWtUOIZe5+oZupBqXNwZKAgAACWYCABA2QAIACQc+AgADriICAAA4wAIAAlY4A
Date:   Fri, 8 Feb 2019 08:45:52 +0000
Message-ID: <fd352fb2cdfd8f483c419217c7e3153b3265e8d9.camel@infinera.com>
References: <1548977439-318904-1-git-send-email-liujian56@huawei.com>
         <20190203092645.18d1495b@bbrezillon> <20190203093509.269bf1e1@bbrezillon>
         <acd16b85676e4d1d89f3acfbeda30107@EX13D07UWA001.ant.amazon.com>
         <20190207095635.0fc3b411@kernel.org>
         <193621849.44066.1549580387922.JavaMail.yahoo@mail.yahoo.co.jp>
         <632ed76bd3844ceab75066d1f30a7115@EX13D07UWA001.ant.amazon.com>
In-Reply-To: <632ed76bd3844ceab75066d1f30a7115@EX13D07UWA001.ant.amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Joakim.Tjernlund@infinera.com; 
x-originating-ip: [88.131.87.201]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN8PR10MB3281;6:qNHD8TaTUWPmAP2++/u+O9HvIAFhtmYnjeuZrRJr8ZDmQ1GvY0uNZDbATPXo9t+sc1k0lrSYHoYcJgBtnPzJskbfyEpHZJxe0S8CRQjzXmE8Dfb4Ry61iNKNq4i9DaN9Rg+q1Jo1z7ccqvto0vjEmNIrVCCoWHaOXl5sYf5KcaJhg75IfBVW5mnfkV/xu3GA72ycAVdeG8QrwJM5zA5Du+43FFp1Mtu1GEdpa0L7N0+21tySR+ujZxU6IzV1PNwdQVyyCmM/s/LHkiYpvRDYky+GseTuGr4Kcc0iuDfNs2py2EC5dZS7dc2uA/ZiPT2oQ4PsBewldfRKNvIbyWG4NQY3ZxqMvuJclpbN23s9O38+vlD0xFqsVFlu+S7ZF7UBBDSHbncC4OZijR4Bx5S4tl2/fZqLx1Yd9efwl+OO4U6Sl6fPk3HD2aAKaHREq9O/g0zHCwMjYia+iYsgAI6sEg==;5:JjtGvJDSgOi17B/4cMz+H6+7U8NEOb6cAhp8mIYGeCMGy0fUWVT1Q2xmlK82vsiMHu5asEc00PZS6NrW6x8Hyd7PUqcTMyPYo2sUZa6gFCj1x5G7w8i2NRcrs58Tsa0HQsIYbxL42TfnTsuHuDSiLbc9DPyRxp6fk1Gbwec2oBW6GHgO0Kn9hCavsZQe37E3SJoqg6C6r3Rzm6bDR6ElKA==;7:Frw7ChizpzQEC7ToOJTcbUOicq/xpNrg6loC3BIdvN8Aoa+orD4sE93KBoEod3hY+GxE3H3mNuZO99GADyWAj/W3DU2/O+llZ/YG9N0A7476gRB3I/8xGI3eYB1FmbO9y+ZzaZfr2BSKof8t40uVVw==
x-ms-office365-filtering-correlation-id: 0278d111-0b8d-4d1a-4363-08d68da1d566
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN8PR10MB3281;
x-ms-traffictypediagnostic: BN8PR10MB3281:
x-microsoft-antispam-prvs: <BN8PR10MB32813D6100114AAA9C2EBE53F4690@BN8PR10MB3281.namprd10.prod.outlook.com>
x-forefront-prvs: 094213BFEA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(136003)(366004)(376002)(189003)(199004)(305945005)(72206003)(86362001)(8936002)(486006)(25786009)(478600001)(76176011)(229853002)(118296001)(6486002)(54906003)(66066001)(446003)(256004)(4326008)(11346002)(5024004)(2201001)(476003)(2501003)(8676002)(7416002)(7736002)(36756003)(93886005)(81166006)(81156014)(2616005)(68736007)(99286004)(53936002)(97736004)(71200400001)(71190400001)(105586002)(106356001)(26005)(14454004)(2906002)(186003)(3846002)(6512007)(6116002)(102836004)(6246003)(6436002)(316002)(110136005)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR10MB3281;H:BN8PR10MB3540.namprd10.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: infinera.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3hU+vJ6fBinXxKRCVj5Nw6+17J2SECL1KyRxHMuSYybViW2jj5PTdkYakqVKhHJfc3gxAUTLRn2EtWDVtNvciixchxemomIEoAOvem5mdQ8IVR+bPLD6TWjHvLxcbWAjhrKkwgFWsOeRWlK50eo2CwdVFxYlseVl1AEv9tz6ChicvAk4r4HIeu351zx78JZC7U6tVSrjMKeF5xZHtfo9HhaoHha2jS8WEM7vU2XluSgeRmNLUR+KI2frY+7H8MtN0l8Zen9Swa9scuMLdneSSL/zuWsKzOJuJeuNKYmtcn2TSNlzEWPAJqT2KjHfYSQlvsTEZ0fi17ZWGtHHssHROnJQZo9ZnTEVviWBOlRD91TlEtpYT1mUmi59U9tXMtHpouEaq6Eaq2PopN3p40+m0UkztlfkEr2W2WgIe4Msu6w=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7DF8162C97A4614D83A51EE2DE206239@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0278d111-0b8d-4d1a-4363-08d68da1d566
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2019 08:45:52.6171
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3281
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE5LTAyLTA3IGF0IDIzOjUwICswMDAwLCBTb2JvbiwgUHJ6ZW15c2xhdyB3cm90
ZToNCj4gQ0FVVElPTjogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiB0aGUg
b3JnYW5pemF0aW9uLiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxl
c3MgeW91IHJlY29nbml6ZSB0aGUgc2VuZGVyIGFuZCBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUu
DQo+IA0KPiANCj4gSGkgSWtlZ2FtaSwNCj4gDQo+IEkgaGF2ZSBzZWVuIGEgY2FzZSBteXNlbGYg
d2hlcmUgYSB2YWx1ZSB3YXMgd3JpdHRlbiwgY2hpcCBjaGFuZ2VkDQo+IHN0YXRlIHRvICJyZWFk
eSIgYnV0IHdoZW4gSSB3YXMgcmVhZGluZyB0aGUgdmFsdWUgd2FzIGluY29ycmVjdC4NCj4gVGhp
cyBjYW4gaGFwcGVuIGFzIHJlc3VsdCBvZiBpbnRlcm1pdHRlbnQgaXNzdWUgd2l0aCBmbGFzaC4g
SXQgaXMNCj4gaGFyZCB0byBmYWxsIGludG8gc2NlbmFyaW8gd2hlbiB0ZXN0aW5nIG9uIGxpbWl0
ZWQgbnVtYmVyIG9mIGRldmljZXMNCj4gYnV0IHdpdGggbGFyZ2UgZW5vdWdoIHBvcHVsYXRpb24g
eW91IGNhbiBzZWUgdGhhdC4gQW5vdGhlciBzaXR1YXRpb24NCj4gaXMgd2hlbiBhIGZsYXNoIGNo
aXAgcmVhY2hlcyBpdHMgbWF4aW11bSBudW1iZXIgb2Ygd3JpdGVzLiBTbyBmb3INCj4gZXhhbXBs
ZSBhIGNoaXAgaXMgZGVzaWduZWQgZm9yIDEwMGsgd3JpdGVzIHRvIGEgcGFnZS4gT25jZSB5b3UN
Cj4gcmVhY2ggdGhhdCBudW1iZXIgb2Ygd3JpdGVzIHlvdSBjYW4gaGF2ZSBpbnZhbGlkIGRhdGEg
d3JpdHRlbiB0bw0KPiBmbGFzaCBidXQgY2hpcCBpdHNlbGYgcmVwb3J0cyBldmVyeXRoaW5nIHdh
cyBnb29kIGFuZCBzd2l0Y2hlcyB0bw0KPiAicmVhZHkiIHN0YXRlLg0KDQpUaGlzIG1ha2VzIHBl
cmZla3Qgc2Vuc2UgYnV0IHRoZSBBTUQgZmxhc2ggY29udHJvbCBJL0YgZG9lcyBub3QuIFlvdSB3
aWxsDQpmaW5kIHRoYXQgdHJ5aW5nIHRvIGRvIGFkdmFuY2VkIHRoaW5ncyB3aXRoICJ0b2dnbGUi
IGJpdHMgaXMgdmVyeSBoYXJkLg0KRXNwZWNpYWxseSB3aGVuIHlvdSBhbHNvIG5lZWQgdG8gc2Nh
bGUgaXQgdG8gaW50ZXJsZWF2ZWQgZmxhc2hlcy4NCg0KSSB0aGluayB0aGUgb2RkIGRlbGF5IHdo
ZW4gZmxhc2ggZmFpbHMgaXMgcXVpdGUgT0suIElmIHlvdSB3YW50IHRvDQpmaXggdGhpcyB5b3Ug
bmVlZCB0byBtb3ZlIHRoZSBvdGhlciBjb250cm9sIEkvRih3aGljaCBtaW1pY3Mgd2hhdCBJbnRl
bCBoYXMpDQoNCiBKb2NrZQ0K
