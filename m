Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D711AC67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 17:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F0D52157C
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 17:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Dir9RRBj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F0D52157C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hammerspace.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbeJUB6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 21:58:08 -0400
Received: from mail-sn1nam02on0105.outbound.protection.outlook.com ([104.47.36.105]:26656
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727343AbeJUB6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 21:58:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMQufVo8m50HuK6vaXctnodDqPJKSQXht6cODxcFVNY=;
 b=Dir9RRBj44u+pdvo47Bqgu0O50ZnTtYQGo1iuMA04WlqngNuaJEkqyWb0I1o05KxUjzE9RHBncsyWk/xdalffmk8QRH7EZhNgW41H8y5tufBdPW/6WaHP5O2F8iuDSC+0RvZiEkvWlu/kL11bwDSYoUDFRLE6DGdVvmRe29PZF0=
Received: from SN6PR13MB2494.namprd13.prod.outlook.com (52.135.95.148) by
 SN6PR13MB2414.namprd13.prod.outlook.com (52.135.94.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.13; Sat, 20 Oct 2018 17:46:51 +0000
Received: from SN6PR13MB2494.namprd13.prod.outlook.com
 ([fe80::205a:69c2:1cf5:b475]) by SN6PR13MB2494.namprd13.prod.outlook.com
 ([fe80::205a:69c2:1cf5:b475%3]) with mapi id 15.20.1273.012; Sat, 20 Oct 2018
 17:46:51 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "miklos@szeredi.hu" <miklos@szeredi.hu>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amir73il@gmail.com" <amir73il@gmail.com>,
        "mszeredi@redhat.com" <mszeredi@redhat.com>,
        "adilger@dilger.ca" <adilger@dilger.ca>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "fw@deneb.enyo.de" <fw@deneb.enyo.de>,
        "mtk.manpages@gmail.com" <mtk.manpages@gmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 5/5] nfs: don't clear STATX_ATIME from result_mask
Thread-Topic: [PATCH v2 5/5] nfs: don't clear STATX_ATIME from result_mask
Thread-Index: AQHUZ6Y0R00wjCb1DkumOvVKjG/0GKUmuDWAgAAfwwCAAAf8gIAAKvSAgAFfjIA=
Date:   Sat, 20 Oct 2018 17:46:51 +0000
Message-ID: <fbc3501c07fd48e65c0ffc8634870bf57a6f7fe1.camel@hammerspace.com>
References: <20181019122049.27121-1-mszeredi@redhat.com>
         <20181019122049.27121-5-mszeredi@redhat.com>
         <2ca365ec330cf918188e8c47b26e741073382d9d.camel@primarydata.com>
         <CAJfpegtq1+vZ+uXwzFs20GeSPCR9UbtqD5-fOn8ynoJUJYx25g@mail.gmail.com>
         <05184f29b5778563519174769c675c5f6c5b2dd3.camel@hammerspace.com>
         <CAJfpeguFe=KcahJmZire52TPppMk8amiTJFiBZuv=97bRbCj8g@mail.gmail.com>
In-Reply-To: <CAJfpeguFe=KcahJmZire52TPppMk8amiTJFiBZuv=97bRbCj8g@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.195.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR13MB2414;6:Xuz9svachvHNeUgOUJRjrAmJI7DdSAJ++MD1A4g4If8q06OOz6HN6J1G4nPrUK6sCBnSRjhQ6CPegneLDsbdkoiWFDcF0aB9c6diJeMkCnF17SDTZ3pCsG+KH8pAAyalyfCE3olOSK+Sd41uUU+K8NNGq59CS87Wvf1IviU0+aDYIAMZnraADQsmUycHWu3FKr1yWikkQ55UmyRyBjzTVxs3wz9xInJ4r/VXDWmvxwpn7IDZNy5S+gihPG/QUxpnkcc9FcjMf9nU2yOiFERsG761mBY7VkErq8oPpSugO70pdkg3L6m57jII3J/l/fy7a0ZTG6qHXMj7jFUQJDNjfySkZez8a4596zQfuk/cXnz1oZ+YWwtj/XP+mAKHBDmQAM+0jEmm8HqTew5BfLNnZiFyJpItYES8LYTsGPTa6bPY55mOuHUXcYOOp3HcGnpUspwHNLiwGGOABk71tdAikg==;5:9joYcnS/I7dUlRGeMWr8Oxto39ziIA2RihhMSeB7hNqVX+nSWYDlATdD2LZmx79PiDMSZluoRwKdnbqDDEbjQNSN0n4WE0jB0UqWvLWcLnOKKOHHZ4lFFkPRgiGcTY0L0nHbh7PbWNMSrNZwjCr3MJiteHU8TzxHIMEZKpAFr1A=;7:jmUHqRnCmikAioAYN1YEnVdlWMZSIgqDAGMS10afEWn3l79x6XV72AmG3r+ucIcv1Zz9FjtQefDjGKIH+/CC2elxuA8RNBiyZWL4S4O4sBiPuetb9y4arzhC6xN/sbm6iCBYH8lJCKklQNvt/xL64Q==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 09340679-ba2c-430f-a12f-08d636b4046a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN6PR13MB2414;
x-ms-traffictypediagnostic: SN6PR13MB2414:
x-microsoft-antispam-prvs: <SN6PR13MB2414FFF0FCA1A6BA3D410983B8FA0@SN6PR13MB2414.namprd13.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:SN6PR13MB2414;BCL:0;PCL:0;RULEID:;SRVR:SN6PR13MB2414;
x-forefront-prvs: 0831C25939
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39830400003)(136003)(376002)(366004)(346002)(189003)(199004)(71190400001)(71200400001)(36756003)(97736004)(66066001)(478600001)(8936002)(3846002)(93886005)(6116002)(99286004)(86362001)(256004)(14454004)(8676002)(2501003)(1730700003)(7416002)(118296001)(14444005)(68736007)(81156014)(81166006)(4001150100001)(6512007)(6916009)(106356001)(6436002)(105586002)(4326008)(5250100002)(305945005)(39060400002)(5640700003)(25786009)(229853002)(2900100001)(6486002)(7736002)(53936002)(2616005)(186003)(53546011)(6506007)(26005)(476003)(11346002)(54906003)(2351001)(316002)(446003)(76176011)(2906002)(486006)(6246003)(5660300001)(102836004);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR13MB2414;H:SN6PR13MB2494.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: UZul+lHOpIZtTdqIBtOq2m51us6MrU66Fdw/yIR1RHHeO5lPuhVzV9euazMxz8Mz+r2NtcE2eaMr+5ZFZ+Ed7IGtTLUo4dd3ONij064THl1OPCbMj4UiBO1tuFXRpKe+7C9ReYSdry10qOTL+5hWfNNyNU2wUC/8qGMtVLZ50taefvDgn7oYLb/OKb3JUYLh1oBhR8inp0Dshbhx2joOP5wPITFBZHzfH0HfyyyCHUYceR8IUCCnaM5qRZhOBCSJr8k8DEU38qzu1wfp22+buPmFxs5VmUxDDfi43CcheOd5jTDGiibzp4z/7lp+VaH7K3OtHPuqqgYxenN8dHEIYz3878Wji3cSFa5e4a2rWsY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <5061AEB311782948A8C8DA144731B4D3@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09340679-ba2c-430f-a12f-08d636b4046a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2018 17:46:51.3582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR13MB2414
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE4LTEwLTE5IGF0IDIyOjQ4ICswMjAwLCBNaWtsb3MgU3plcmVkaSB3cm90ZToN
Cj4gT24gRnJpLCBPY3QgMTksIDIwMTggYXQgODoxNCBQTSwgVHJvbmQgTXlrbGVidXN0DQo+IDx0
cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+ID4gT24gRnJpLCAyMDE4LTEwLTE5IGF0
IDE5OjQ2ICswMjAwLCBNaWtsb3MgU3plcmVkaSB3cm90ZToNCj4gPiA+IEhvdyBpcyBpdCB0aGVu
IHRoYXQgb25seSBTVEFUWF9BVElNRSBpcyBjbGVhcmVkIGFuZCBub3QgdGhlIG90aGVyDQo+ID4g
PiBmaWVsZHM/DQo+ID4gDQo+ID4gSXQgaXNuJ3QganVzdCB0aGUgYXRpbWUuIFdlIGNhbiBhbHNv
IGZhaWwgdG8gcmV2YWxpZGF0ZSB0aGUgY3RpbWUNCj4gPiBhbmQNCj4gPiBtdGltZSBpZiB0aGV5
IGFyZSBub3QgYmVpbmcgcmVxdWVzdGVkIGJ5IHRoZSB1c2VyLg0KPiA+IA0KPiA+ID4gDQo+ID4g
PiBOb3RlOiBqdW5rICE9IHN0YWxlLiAgVGhlIHN0YXR4IGRlZmluaXRpb24gZG9lc24ndCB0YWxr
IGFib3V0IHRoZQ0KPiA+ID4gZmllbGRzIGJlaW5nIHVwLXRvLWRhdGUsIGV4Y2VwdCBmb3IgQVRf
U1RBVFhfRk9SQ0VfU1lOQywgc28gc3RhbGUNCj4gPiA+IGF0dHJpYnV0ZXMgYXJlIG9rYXksIGFu
ZCBkbyBub3Qgd2FycmFudCBjbGVhcmluZyB0aGUgcmVzdWx0X21hc2suDQo+ID4gPiANCj4gPiAN
Cj4gPiBJIGRpc2FncmVlLiBzdGFsZSA9PSBqdW5rIGhlcmUsIGJlY2F1c2UgdGhlIGRlZmF1bHQg
b2YNCj4gPiBBVF9TVEFUWF9TWU5DX0FTX1NUQVQgaXMgZGVzY3JpYmVkIGJ5IHRoZSBtYW5wYWdl
IGFzICJEbyAgd2hhdGV2ZXINCj4gPiBzdGF0KDIpIGRvZXMuIiB3aGljaCB0aGlzIGlzIG5vdC4N
Cj4gDQo+IEFoLCB5b3UgYXJlIHRhbGtpbmcgYWJvdXQgdGhpczoNCj4gDQo+ICAgICAvKiBJcyB0
aGUgdXNlciByZXF1ZXN0aW5nIGF0dHJpYnV0ZXMgdGhhdCBtaWdodCBuZWVkDQo+IHJldmFsaWRh
dGlvbj8gKi8NCj4gICAgIGlmICghKHJlcXVlc3RfbWFzayAmDQo+IChTVEFUWF9NT0RFfFNUQVRY
X05MSU5LfFNUQVRYX0FUSU1FfFNUQVRYX0NUSU1FfA0KPiAgICAgICAgICAgICAgICAgICAgIFNU
QVRYX01USU1FfFNUQVRYX1VJRHxTVEFUWF9HSUR8DQo+ICAgICAgICAgICAgICAgICAgICAgU1RB
VFhfU0laRXxTVEFUWF9CTE9DS1MpKSkNCj4gICAgICAgICBnb3RvIG91dF9ub191cGRhdGU7DQo+
IA0KPiBXZWxsLCBpZiB0aGlzIGlzIHRyaWdnZXJlZCBmb3Igc3RhdHgoLi4uLCAgU1RBVFhfQVRJ
TUUsDQo+IEFUX1NUQVRYX1NZTkNfQVNfU1RBVCkgYW5kIE1OVF9OT0FUSU1FLCB0aGVuIHllcywg
cmVzdWx0IHdpbGwgYmUNCj4ganVuay4NCj4gV2hpY2ggbWVhbnMgdGhhdCB0aGUgY29kZSBpcyB3
cm9uZywgaXQgc2hvdWxkbid0IGRvIHRoYXQuDQoNClRoZSBwcm9ibGVtIGlzIHRoYXQgdmZzX2dl
dGF0dHJfbm9zZWMoKSBwb3B1bGF0ZXMgc3RhdC0+cmVzdWx0X21hc2sNCndpdGggYSBkZWZhdWx0
IG9mIFNUQVRYX0JBU0lDX1NUQVRTLCB3aGljaCBtYWtlcyBubyBzZW5zZSB1bmxlc3MgeW91DQph
c3N1bWUgdGhhdCB0aGUgdXNlciB3aWxsIGFsd2F5cyBhc2sgZm9yIGEgc3VwZXJzZXQgb2YNClNU
QVRYX0JBU0lDX1NUQVRTIChvciB5b3UgYXNzdW1lIHRoYXQgdGhvc2UgYXR0cmlidXRlcyBuZXZl
ciBuZWVkDQpyZXZhbGlkYXRpb24sIHdoaWNoIGlzIG9idmlvdXNseSBicmFpbmRlYWQpLg0KDQo+
IE90aGVyd2lzZSAoaWYgc29tZXRoaW5nIG90aGVyIHRoYW4gU1RBVFhfQVRJTUUgb3IgU1RBVFhf
SU5PIG9yDQo+IFNUQVRYX1RZUEUgaXMgZ2l2ZW4gYXMgd2VsbCkgaXQgKndpbGwqIGRvIHRoZSBz
YW1lIHRoaW5nIGFzIHdoYXQNCj4gc3RhdCgyKSBkb2VzLCBzbyBpbiB0aGF0IGNhc2UgU1RBVFhf
QVRJTUUgc2hvdWxkIG5vdCAgYmUgY2xlYXJlZCAoeWV0DQo+IGl0IGlzIGNsZWFyZWQpLg0KDQpB
cyBmYXIgYXMgSSdtIGNvbmNlcm5lZCwgd2UgY2FuIGRlZmluaXRlbHkgZ2V0IHJpZCBvZiB0aGUN
Cg0KICAgICAgICAvKg0KICAgICAgICAgKiBXZSBtYXkgZm9yY2UgYSBnZXRhdHRyIGlmIHRoZSB1
c2VyIGNhcmVzIGFib3V0IGF0aW1lLg0KICAgICAgICAgKg0KICAgICAgICAgKiBOb3RlIHRoYXQg
d2Ugb25seSBoYXZlIHRvIGNoZWNrIHRoZSB2ZnNtb3VudCBmbGFncyBoZXJlOg0KICAgICAgICAg
KiAgLSBORlMgYWx3YXlzIHNldHMgU19OT0FUSU1FIGJ5IHNvIGNoZWNraW5nIGl0IHdvdWxkIGdp
dmUgYQ0KICAgICAgICAgKiAgICBib2d1cyByZXN1bHQNCiAgICAgICAgICogIC0gTkZTIG5ldmVy
IHNldHMgU0JfTk9BVElNRSBvciBTQl9OT0RJUkFUSU1FIHNvIHRoZXJlIGlzDQogICAgICAgICAq
ICAgIG5vIHBvaW50IGluIGNoZWNraW5nIHRob3NlLg0KICAgICAgICAgKi8NCiAgICAgICAgaWYg
KChwYXRoLT5tbnQtPm1udF9mbGFncyAmIE1OVF9OT0FUSU1FKSB8fA0KICAgICAgICAgICAgKChw
YXRoLT5tbnQtPm1udF9mbGFncyAmIE1OVF9OT0RJUkFUSU1FKSAmJiBTX0lTRElSKGlub2RlLT5p
X21vZGUpKSkNCiAgICAgICAgICAgICAgICByZXF1ZXN0X21hc2sgJj0gflNUQVRYX0FUSU1FOw0K
DQoNCmhvd2V2ZXIgdGhlIHJlc3QgbmVlZHMgdG8gc3RheSwgb3IgdGhlcmUgaXMgbm8gd2F5IHdl
IGNhbiB1c2Ugc3RhdHgoKQ0KdG8gYWxsb3cgb3B0aW1pc2VkIHJldHJpZXZhbCBvZiBvbmx5IHRo
b3NlIGF0dHJpYnV0ZXMgdGhhdCB5b3VyDQphcHBsaWNhdGlvbiBjYXJlcyBhYm91dC4NCi0tIA0K
VHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNl
DQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
