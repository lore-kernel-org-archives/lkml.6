Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5E4C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E343A20834
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="UzuB1AoO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E343A20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbeLDO3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 09:29:46 -0500
Received: from mail-eopbgr40092.outbound.protection.outlook.com ([40.107.4.92]:52171
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726306AbeLDO3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 09:29:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05ME6FmwXim4PvneaGiYoCZyy+pZDRIinVPmES+rQEE=;
 b=UzuB1AoOhsXgtZCiXUuM+aRkj/MeNOG6hieGba7Alm1Rh3yr3S1AuAElkc51d2RtwTEZGWg/HthYyplb2YcHyLJgJQ+agoqyi0QjfPXo1Om09eGGaAfB1Heg4uH/Fv2GF1eensEh7wwgmm+C1dL8XoaN5Fk2fHj8WnUrVnq3fkA=
Received: from VI1PR02MB5119.eurprd02.prod.outlook.com (20.178.13.204) by
 VI1PR02MB1694.eurprd02.prod.outlook.com (10.166.41.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Tue, 4 Dec 2018 14:29:39 +0000
Received: from VI1PR02MB5119.eurprd02.prod.outlook.com
 ([fe80::b:49a6:411a:6a39]) by VI1PR02MB5119.eurprd02.prod.outlook.com
 ([fe80::b:49a6:411a:6a39%3]) with mapi id 15.20.1361.022; Tue, 4 Dec 2018
 14:29:39 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Nicholas Mc Guire <der.herr@hofr.at>
CC:     Nicholas Mc Guire <hofrat@osadl.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i2c: mux: demux-pinctrl: handle failure case of
 devm_kstrdup()
Thread-Topic: [PATCH] i2c: mux: demux-pinctrl: handle failure case of
 devm_kstrdup()
Thread-Index: AQHUiV04FT84eXxBo0+Q2gJyFszP86VucwAAgAAPwACAABrHAIAACgoAgAABRAA=
Date:   Tue, 4 Dec 2018 14:29:39 +0000
Message-ID: <ddd13632-2d1f-f87c-f0cc-1bd3d1d09452@axentia.se>
References: <1543658470-20887-1-git-send-email-hofrat@osadl.org>
 <549eba3a-28b9-e4b0-f680-8fb51b160879@axentia.se>
 <20181204121318.GB28201@osadl.at>
 <2c43e965-9a12-0367-fb23-bedfaaed4f68@axentia.se>
 <20181204142504.GA16001@osadl.at>
In-Reply-To: <20181204142504.GA16001@osadl.at>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR0701CA0087.eurprd07.prod.outlook.com
 (2603:10a6:3:64::31) To VI1PR02MB5119.eurprd02.prod.outlook.com
 (2603:10a6:803:b7::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR02MB1694;6:gi05al1OxvTncHy9pKMIFJlH2x5YkxdZswp2oRs0oi3JqR3paTRqXURrn05DpvfAi/Gd3lrZglinddA0hFDz3W7mJh0axfUSlbq0rJu70qSjjeDXMX26rZuavww7Ma2BQOqlHuEk1DAcqv6sHXyjUjR+sx115gYx8KylwbEXUwWe53ZnSJ7zuDXAxGpjxBqhO1zguBxeE2sx4woQ1VmaKVEAMZ5MwMyL/GsIuOzK1L8O6ce7UMzVCmisYuFBKlKvf02k+Qs73+oBeipezjnroJY6IMpYgpbE+dgQtEaUsCaBKBLJJOGVU8+O7eEKARg06d6g8YWASjxzJqRvibvOe5WR5nSBidzQHW2p3BE0kvLQszKkVHUnlStGb+6LliJTo9I0J0UfMqRTsdNc9Zsutf5K1yN9MQaCYyeHMvwBeWeI4VrvVGVq/J0uqE1pFVQiUr9q/z/2cGdwM0mvTphX9Q==;5:FqSELbZgYXKUtf79p0IxDXa0uqAUFfZclwERaBWlsKmTTblofeZEg4Fc3NxwF50mqXyZZft5MffNDy/5g0r/nmoniRtl5qPV2P4cPcbzuZEdhQpWeHDqYsq0hXKd1X/y35mNHzdoUc+AAnjJfBW05A9tt14v6Ajr8fwW9r6qU2g=;7:h71r/3ToOHCcg6Aqvx1i9cf12mm50FFFG0z2tfAIZsUcLiAzi3G2sUBcrllZjNVPKS3WfFGK87XZZLjoBQIUyzpbZ9sc7UCxG8Vv4ykWSWw5Z5soNYuNJ8XWV9aupmUAJnaS7rC2oio2L7NEPemyOA==
x-ms-office365-filtering-correlation-id: 918aae9a-3a73-4c20-6b15-08d659f4ec8d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR02MB1694;
x-ms-traffictypediagnostic: VI1PR02MB1694:
x-microsoft-antispam-prvs: <VI1PR02MB16942C26DB33E69EF488FFBDBCAF0@VI1PR02MB1694.eurprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231455)(999002)(944501493)(52105112)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:VI1PR02MB1694;BCL:0;PCL:0;RULEID:;SRVR:VI1PR02MB1694;
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39840400004)(136003)(366004)(199004)(189003)(4326008)(31696002)(53546011)(71200400001)(3846002)(6116002)(74482002)(256004)(86362001)(14444005)(93886005)(25786009)(106356001)(2616005)(26005)(105586002)(11346002)(6916009)(476003)(6506007)(2906002)(102836004)(65826007)(305945005)(486006)(386003)(7736002)(66066001)(65806001)(65956001)(186003)(6512007)(5660300001)(64126003)(36756003)(6486002)(76176011)(53936002)(446003)(52116002)(31686004)(316002)(81166006)(97736004)(508600001)(68736007)(71190400001)(58126008)(8676002)(8936002)(81156014)(14454004)(54906003)(6246003)(6436002)(229853002)(99286004)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB1694;H:VI1PR02MB5119.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: phUdRlJM2RNUiVrNsn64ET8wJK/BeWRUgpLTaH+VM9C54h7PeQjVJf9E1oW1GidlVrF2d8Ba5KAU3nX2RXG4nvGh6owjFJtwumBFw9luaxW9NCxSWZAdJRdG3VGXN9lHL19ZiMD7JxYnAIb8zlLT3nD6iMUc4G1w1R2uhGa+RzuPEiApDy1cLNUjTSs4tRQLbyXDxRLOwt5x9JRcemoNGZJHZs3cHBDNfGBEGEJlEGUcM7XmOOlG3pVmyX43X0ndtIp4AFVdo51TxL4RV/QeeahKCUTc06FbKdVEXcnfxvc1y7uf9KKIIbtAad09IHLqMYuilrqh7AktU9rI6zDQTW04kH/nOWZxlTxpVxHghLY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <A17CCEB2734A9442949F59600B81502C@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 918aae9a-3a73-4c20-6b15-08d659f4ec8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 14:29:39.8349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB1694
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOC0xMi0wNCAxNToyNSwgTmljaG9sYXMgTWMgR3VpcmUgd3JvdGU6DQo+IE9uIFR1ZSwg
RGVjIDA0LCAyMDE4IGF0IDAxOjQ5OjExUE0gKzAwMDAsIFBldGVyIFJvc2luIHdyb3RlOg0KPj4g
T24gMjAxOC0xMi0wNCAxMzoxMywgTmljaG9sYXMgTWMgR3VpcmUgd3JvdGU6DQo+Pj4gT24gVHVl
LCBEZWMgMDQsIDIwMTggYXQgMTE6MTY6NTlBTSArMDAwMCwgUGV0ZXIgUm9zaW4gd3JvdGU6DQo+
Pj4+IEhpIQ0KPj4+Pg0KPj4+PiBUaGlzIHBhdGNoIGxvb2tzIGxpa2UgYSBnb29kIGlkZWEuIEhv
d2V2ZXIsIGEgbml0cGljayBiZWxvdy4NCj4+Pj4NCj4+Pj4gT24gMjAxOC0xMi0wMSAxMTowMSwg
TmljaG9sYXMgTWMgR3VpcmUgd3JvdGU6DQo+Pj4+PiBkZXZtX2tzdHJkdXAoKSBtYXkgcmV0dXJu
IE5VTEwgaWYgaW50ZXJuYWwgYWxsb2NhdGlvbiBmYWlsZWQuDQo+Pj4+PiBUaHVzIHVzaW5nICBu
YW1lLCB2YWx1ZSAgaXMgdW5zYWZlIHdpdGhvdXQgYmVpbmcgY2hlY2tlZC4gQXMNCj4+Pj4+IGky
Y19kZW11eF9waW5jdHJsX3Byb2JlKCkgY2FuIHJldHVybiAtRU5PTUVNIGluIG90aGVyIGNhc2Vz
DQo+Pj4+PiBhIGRldl9lcnIoKSBtZXNzYWdlIGlzIGluY2x1ZGVkIHRvIG1ha2UgdGhlIGZhaWx1
cmUgbG9jYXRpb24NCj4+Pj4+IGNsZWFyLg0KPj4+Pj4NCj4+Pj4+IFNpZ25lZC1vZmYtYnk6IE5p
Y2hvbGFzIE1jIEd1aXJlIDxob2ZyYXRAb3NhZGwub3JnPg0KPj4+Pj4gRml4ZXM6IGUzNTQ3OGVh
YzAzMCAoImkyYzogbXV4OiBkZW11eC1waW5jdHJsOiBydW4gcHJvcGVybHkgd2l0aCBtdWx0aXBs
ZSBpbnN0YW5jZXMiKQ0KPj4+Pj4gLS0tDQo+Pj4+Pg0KPj4+Pj4gUHJvYmxlbSBsb2NhdGVkIHdp
dGggZXhwZXJpbWVudGFsIGNvY2NpbmVsbGUgc2NyaXB0DQo+Pj4+Pg0KPj4+Pj4gUTogVGhlIHVz
ZSBvZiBkZXZtX2tzdHJkdXAoKSBzZWVtcyBhIGJpdCBvZGQgd2hpbGUgdGVjaG5pY2FsbHkgbm90
IHdyb25nLA0KPj4+Pj4gICAgcGVyc29uYWxseSBJIHRoaW5rIGRldm1fa2FzcHJpbnRmKCkgd291
bGQgYmUgbW9yZSBzdWl0YWJsZSBoZXJlLg0KPj4+Pj4NCj4+Pj4+IFBhdGNoIHdhcyBjb21waWxl
IHRlc3RlZCB3aXRoOiBtdWx0aV92N19kZWZjb25maWcgDQo+Pj4+PiAoaW1wbGllcyBJMkNfREVN
VVhfUElOQ1RSTD15KQ0KPj4+Pj4NCj4+Pj4+IFBhdGNoIGlzIGFnYWluc3QgNC4yMC1yYzQgKGxv
Y2FsdmVyc2lvbi1uZXh0IGlzIG5leHQtMjAxODExMzApDQo+Pj4+Pg0KPj4+Pj4gIGRyaXZlcnMv
aTJjL211eGVzL2kyYy1kZW11eC1waW5jdHJsLmMgfCA2ICsrKysrKw0KPj4+Pj4gIDEgZmlsZSBj
aGFuZ2VkLCA2IGluc2VydGlvbnMoKykNCj4+Pj4+DQo+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9pMmMvbXV4ZXMvaTJjLWRlbXV4LXBpbmN0cmwuYyBiL2RyaXZlcnMvaTJjL211eGVzL2kyYy1k
ZW11eC1waW5jdHJsLmMNCj4+Pj4+IGluZGV4IDAzNTAzMmUuLmM0NjY5OTkgMTAwNjQ0DQo+Pj4+
PiAtLS0gYS9kcml2ZXJzL2kyYy9tdXhlcy9pMmMtZGVtdXgtcGluY3RybC5jDQo+Pj4+PiArKysg
Yi9kcml2ZXJzL2kyYy9tdXhlcy9pMmMtZGVtdXgtcGluY3RybC5jDQo+Pj4+PiBAQCAtMjQ0LDYg
KzI0NCwxMiBAQCBzdGF0aWMgaW50IGkyY19kZW11eF9waW5jdHJsX3Byb2JlKHN0cnVjdCBwbGF0
Zm9ybV9kZXZpY2UgKnBkZXYpDQo+Pj4+PiAgDQo+Pj4+PiAgCQlwcm9wc1tpXS5uYW1lID0gZGV2
bV9rc3RyZHVwKCZwZGV2LT5kZXYsICJzdGF0dXMiLCBHRlBfS0VSTkVMKTsNCj4+Pj4+ICAJCXBy
b3BzW2ldLnZhbHVlID0gZGV2bV9rc3RyZHVwKCZwZGV2LT5kZXYsICJvayIsIEdGUF9LRVJORUwp
Ow0KPj4+Pj4gKwkJaWYgKCFwcm9wc1tpXS5uYW1lIHx8ICFwcm9wc1tpXS52YWx1ZSkgew0KPj4+
Pj4gKwkJCWRldl9lcnIoJnBkZXYtPmRldiwNCj4+Pj4+ICsJCQkJImNoYW4gJWQgbmFtZSwgdmFs
dWUgYWxsb2NhdGlvbiBmYWlsZWRcbiIsIGkpOw0KPj4+Pg0KPj4+PiBQbGVhc2UgZHJvcCB0aGlz
IG1lbW9yeSBhbGxvY2F0aW9uIGZhaWx1cmUgbWVzc2FnZS4gWW91IHNob3VsZCBnZXQgc3VjaCBh
DQo+Pj4+IG1lc3NhZ2UgZnJvbSBkZXZtX2tzdHJkdXAuDQo+Pj4+DQo+Pj4NCj4+PiBobS4uLnRy
aWVkIHRvIGZpZ3VyZSBvdXQgd2hlcmUgdGhhdCBtZXNzYWdlIHdvdWxkIGJlIGNvbW1pbmcNCj4+
PiBmcm9tIC0gYnV0IEkgY291bGQgbm90IGZpbmQgYW55IHBvaW50IGluIHRoZSBjYWxsIHRyZWUg
dGhhdA0KPj4+IHdvdWxkIGlzc3VlIHN1Y2ggYSBtZXNzYWdlID8NCj4+Pg0KPj4+ICBkZXZtX2tz
dHJkdXAoKSANCj4+PiAgICAtPiBkZXZtX2ttYWxsb2MoKQ0KPj4+ICAgICAgICAgLT4gYWxsb2Nf
ZHIoKQ0KPj4+ICAgICAgICAgICAgICAtLT4ga21hbGxvY190cmFja19jYWxsZXIoKSAobm9uLU5V
TUEpDQo+Pj4gICAgICAgICAgICAgIHwgICAgIC0+IF9fa21hbGxvY19ub2RlKCkNCj4+PiAgICAg
ICAgICAgICAgfCAgICAgICAgLT4gX19kb19rbWFsbG9jX25vZGUoKQ0KPj4+ICAgICAgICAgICAg
ICBgLT4gX19rbWFsbG9jX25vZGVfdHJhY2tfY2FsbGVyKCkgKE5VTUEpDQo+Pj4gICAgICAgICAg
ICAgICAgICAgIC0+IF9fZG9fa21hbGxvY19ub2RlKCkNCj4+Pg0KPj4+ICBfX2RvX2ttYWxsb2Nf
bm9kZSgpIHNlZW1zIGxpa2UgaXQgc2ltcGx5IHJldHVybnMgTlVMTCBidXQNCj4+PiAgaXNzdWVz
IG5vIGZhaWx1cmUgbWVzc2FnZS4NCj4+PiAgQW0gSSBvdmVybG9va2luZyBzb21ldGhpbmcgPyAN
Cj4+DQo+PiBXZWxsLCBJIGRvbid0IGtub3cgdGhlIGRldGFpbHMsIGJ1dCBjaGVja3BhdGNoIHdp
bGwgd2FybiBhYm91dCBzaW1wbGUNCj4+IGVycm9yIG1lc3NhZ2VzIG9uIGRldm1fa3N0cmR1cCBm
YWlsdXJlIChpZiBJIHJlYWQgdGhlIGNoZWNrcGF0Y2ggc291cmNlDQo+PiBjb3JyZWN0bHkpLiBC
dXQgaW4gdGhpcyBjYXNlIHRoZXJlIGFyZSB0d28gcGFyYWxsZWwgY29uZGl0aW9ucyBpbiB0aGUN
Cj4+IGlmIGFuZCBoZW5jZSBjaGVja3BhdGNoIHN0dW1ibGVzLCBidXQgZ2lzdCBpcyB0aGUgc2Ft
ZSwgeW91IHNob3VsZCBub3QNCj4+IHNwcmlua2xlIG1lc3NhZ2VzIG9uIG1lbW9yeSBhbGxvY2F0
aW9uIGZhaWx1cmUuDQo+Pg0KPiBub3QgaW4gdGhpcyBjYXNlIC0gYXRsZWFzdCBjaGVja3BhdGNo
IC0tc3RyaWN0IG9uIHRoZSBvcmlnaW5hbCBwYXRjaA0KPiBkaWQgbm90IGlzc3VlIGFueSBjb21w
bGFpbnQgdG8gdGhhdCBlbmRzLiBCdXQgeWVzIC0geW91DQo+IGFyZSByaWdodCB0aGF0IHRoZSBp
bnRlbnQgaW4gY2hlY2twYXRjaCBpcyBjbGVhciBhbmQgdGhpcyBzaG91bGQgbm90DQo+IGJlIGNh
cnJ5aW5nIGEgZmFpbHVyZSBtZXNzYWdlLg0KDQpZZXMsIHRoaXMgaXMgZXhhY3RseSB3aGF0IEkg
c2FpZCwgY2hlY2twYXRjaCBzdHVtYmxlcyBzaW5jZSB0aGVyZSBhcmUNCnR3byBjb25mbGF0ZWQg
dGVzdHMgaW4gb25lIGlmIHN0YXRlbWVudCBhbmQgY2hlY2twYXRjaCBpcyBub3Qgc21hcnQNCnNv
IGRvZXMgbm90IHBpY2sgdXAgb24gdGhhdC4NCg0KQ2hlZXJzLA0KUGV0ZXINCg==
