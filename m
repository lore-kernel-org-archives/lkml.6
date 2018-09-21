Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FC1C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 23:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7616F21569
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 23:48:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7616F21569
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391681AbeIVFjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 01:39:35 -0400
Received: from g2t1383g.austin.hpe.com ([15.233.16.89]:1389 "EHLO
        g2t1383g.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725748AbeIVFjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 01:39:35 -0400
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by g2t1383g.austin.hpe.com (Postfix) with ESMTPS id 3B533367F
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 23:48:24 +0000 (UTC)
Received: from G9W8456.americas.hpqcorp.net (g9w8456.houston.hp.com [16.216.161.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g4t3426.houston.hpe.com (Postfix) with ESMTPS id 519CC31C;
        Fri, 21 Sep 2018 23:48:23 +0000 (UTC)
Received: from G4W9119.americas.hpqcorp.net (2002:10d2:14d6::10d2:14d6) by
 G9W8456.americas.hpqcorp.net (2002:10d8:a15f::10d8:a15f) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Fri, 21 Sep 2018 23:48:23 +0000
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (15.241.52.12) by
 G4W9119.americas.hpqcorp.net (16.210.20.214) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Fri, 21 Sep 2018 23:48:22 +0000
Received: from AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM (10.169.8.145) by
 AT5PR8401MB0529.NAMPRD84.PROD.OUTLOOK.COM (10.169.4.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.15; Fri, 21 Sep 2018 23:48:18 +0000
Received: from AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::608e:d51f:3e92:6002]) by AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::608e:d51f:3e92:6002%4]) with mapi id 15.20.1143.019; Fri, 21 Sep 2018
 23:48:18 +0000
From:   "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>
To:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Dan Williams <dan.j.williams@intel.com>,
        "Hocko, Michal" <MHocko@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Kani, Toshi" <toshi.kani@hpe.com>
Subject: RE: [PATCH 0/3] mm: Randomize free memory
Thread-Topic: [PATCH 0/3] mm: Randomize free memory
Thread-Index: AQHUTRIJ92J8sT+2bUiLYfH7DiMVm6T1Hb6AgAYGMwCAAEkdcA==
Date:   Fri, 21 Sep 2018 23:48:18 +0000
Message-ID: <AT5PR8401MB1169D656C8B5E121752FC0F8AB120@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
References: <153702858249.1603922.12913911825267831671.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180917161245.c4bb8546d2c6069b0506c5dd@linux-foundation.org>
 <CAGXu5jLRuWOMPTfXAFFiVSb6CUKaa_TD4gncef+MT84pcazW6w@mail.gmail.com>
In-Reply-To: <CAGXu5jLRuWOMPTfXAFFiVSb6CUKaa_TD4gncef+MT84pcazW6w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=elliott@hpe.com; 
x-originating-ip: [2601:2c3:877f:e23c:14fe:6cb9:6264:3809]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB0529;6:Izo8aUDww0Fwf8LRabTIzqwyIZP240bBSbbVMDdamTh6YpEZ90WGHefo8hfM85VBuilIUQRgsfYZKiLj6TTn9O1RbglsYS8BDxAHcugnrAdUd/Rt62xL/3KWvAK16HC1XoX+fA7rA9lqdrV/zMK5qRgH0x9Rws41qngUWzva76qv2rvyv8i47NQ5HtXwSaUtHf9iJNhzkWlyA63yuhMLqv50PJK4aXQDKEZOymQeaI/WBeN2v+tZr3REqldlvZsgCZjgrBHcWIqKhleHvQgXb8Ah6Zx+p6RTFdFJH5Ht4wTcnL0qH0pkiXis0ZeE28/X04ZIqglzj2bnDy8epXzXKJKohX/0ImBEdKO6uaIpYxWKH43dFqz3Pm7YHjOTR6U2uDVYmH52HIddbtIHvQsX7WDt9FaBgklXrJ/G3IS34H2bQx1tLEUp4RhqjksY9qpk8YWQGuVA91NNNELDU7zW/Q==;5:l71LHyWvBURPM72eVnb0rtbkcmbFQN+GLgCEgN4xpd+8WUDKBq+403gDCiXr4SGtuVv5Nw2MmB4YGGT6hBzwoMFkyvjhJLsSWIEzyB3UO/iOCYoE1CFlgeFFU7Na2CD6r59mHgS9iVcaiGyK46GaJcVIioArCgtoqK/vOJnEO2A=;7:5+IvCSe/PyfLIsiCeWQudyA7kypXGBWMRAyp0V8LgDbfNk0ItjVOuGOydCqTXunEZzhpV+gvS65mwrNdj58Q3COdlQHLxkKq2ibiSG89yfuHI0c+syoCEsHQGkhMWKzBGQAlfOOokx3O/LYHZ1kOfRGBrDHfA1c8I776LMwyAtmqL0fQySkXay3SPKETNsXIHD9U5QBE46mF6oOatqsjvszrGK2TxG0p1CY7fRzV1SqMcwa//vmCc2YMPH+RbJjl
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a76ee264-9ee7-45ef-4ea1-08d6201cb4b9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB0529;
x-ms-traffictypediagnostic: AT5PR8401MB0529:
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-microsoft-antispam-prvs: <AT5PR8401MB0529199C690CC334245E2841AB120@AT5PR8401MB0529.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(108984395545644)(192374486261705)(9452136761055)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(201708071742011)(7699051);SRVR:AT5PR8401MB0529;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB0529;
x-forefront-prvs: 0802ADD973
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(376002)(396003)(346002)(39860400002)(189003)(199004)(13464003)(76176011)(110136005)(478600001)(105586002)(86362001)(54906003)(305945005)(486006)(2900100001)(74316002)(7736002)(106356001)(81156014)(55016002)(6116002)(8676002)(2906002)(71200400001)(71190400001)(97736004)(6306002)(8936002)(81166006)(5250100002)(476003)(229853002)(14454004)(53936002)(6506007)(6436002)(53546011)(6246003)(99286004)(5660300001)(46003)(68736007)(256004)(7696005)(9686003)(11346002)(186003)(102836004)(25786009)(14444005)(446003)(316002)(4326008)(966005)(33656002);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB0529;H:AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: cCxQBf6IqBmbhJG/kUZ15McXTyahyAJ8FgRuEKtuBQnh+pIMrw10RNhBRjqReDG48UcnarTIbI6aBIKtQM0nbOZllJBItiXA6F79oUCnltqgdBTwL46nDStyIvj2MjTKylb/rpXxr1TnIfnoYp+EaoogevdFMVrAgAL4h1DbMEOCUv+BRjjqbM7GjVIZ+b+SS8TGxcmFqdrckyVWN114I29+45fvBRggckQJYO7kMCY6bSuwUaIKRNBzkr8XhbC9JvPpUJCIlPlY3sp7tNJMW/1JTsWKUYhdsLjQ1zZcHrZw2P4kczdloby2RFYsiUquhWgJt+2cJEif4+SgjlbqVPDZ9OwVGPpLp3hCywF6WwQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a76ee264-9ee7-45ef-4ea1-08d6201cb4b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2018 23:48:18.1519
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB0529
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGxpbnV4LWtlcm5lbC1vd25l
ckB2Z2VyLmtlcm5lbC5vcmcgPGxpbnV4LWtlcm5lbC0NCj4gb3duZXJAdmdlci5rZXJuZWwub3Jn
PiBPbiBCZWhhbGYgT2YgS2VlcyBDb29rDQo+IFNlbnQ6IEZyaWRheSwgU2VwdGVtYmVyIDIxLCAy
MDE4IDI6MTMgUE0NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAwLzNdIG1tOiBSYW5kb21pemUgZnJl
ZSBtZW1vcnkNCi4uLg0KPiBJJ2QgYmUgY3VyaW91cyB0byBoZWFyIG1vcmUgYWJvdXQgdGhlIG1l
bnRpb25lZCBjYWNoZSBwZXJmb3JtYW5jZQ0KPiBpbXByb3ZlbWVudHMuIEkgbG92ZSBpdCB3aGVu
IGEgc2VjdXJpdHkgZmVhdHVyZSBhY3R1YWxseSBfaW1wcm92ZXNfDQo+IHBlcmZvcm1hbmNlLiA6
KQ0KDQpJdCdzIGJlZW4gYSBwcm9ibGVtIGluIHRoZSBIUEMgc3BhY2U6DQpodHRwOi8vd3d3Lm5l
cnNjLmdvdi9yZXNlYXJjaC1hbmQtZGV2ZWxvcG1lbnQva25sLWNhY2hlLW1vZGUtcGVyZm9ybWFu
Y2UtY29lLw0KDQpBIGtlcm5lbCBtb2R1bGUgY2FsbGVkIHpvbmVzb3J0IGlzIGF2YWlsYWJsZSB0
byB0cnkgdG8gaGVscDoNCmh0dHBzOi8vc29mdHdhcmUuaW50ZWwuY29tL2VuLXVzL2FydGljbGVz
L3hlb24tcGhpLXNvZnR3YXJlDQoNCmFuZCB0aGlzIGFiYW5kb25lZCBwYXRjaCBzZXJpZXMgcHJv
cG9zZWQgdGhhdCBmb3IgdGhlIGtlcm5lbDoNCmh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDE3Lzgv
MjMvMTk1DQoNCkRhbidzIHBhdGNoIHNlcmllcyBkb2Vzbid0IGF0dGVtcHQgdG8gZW5zdXJlIGJ1
ZmZlcnMgd29uJ3QgY29uZmxpY3QsIGJ1dA0KYWxzbyByZWR1Y2VzIHRoZSBjaGFuY2UgdGhhdCB0
aGUgYnVmZmVycyB3aWxsLiBUaGlzIHdpbGwgbWFrZSBwZXJmb3JtYW5jZQ0KbW9yZSBjb25zaXN0
ZW50LCBhbGJlaXQgc2xvd2VyIHRoYW4gIm9wdGltYWwiICh3aGljaCBpcyBuZWFyIGltcG9zc2li
bGUNCnRvIGF0dGFpbiBpbiBhIGdlbmVyYWwtcHVycG9zZSBrZXJuZWwpLiAgVGhhdCdzIGJldHRl
ciB0aGFuIGZvcmNpbmcNCnVzZXJzIHRvIGRlcGxveSByZW1lZGllcyBsaWtlOg0KICAgICJUbyBl
bGltaW5hdGUgdGhpcyBncmFkdWFsIGRlZ3JhZGF0aW9uLCB3ZSBoYXZlIGFkZGVkIGEgU3RyZWFt
DQogICAgIG1lYXN1cmVtZW50IHRvIHRoZSBOb2RlIEhlYWx0aCBDaGVjayB0aGF0IGZvbGxvd3Mg
ZWFjaCBqb2I7DQogICAgIG5vZGVzIGFyZSByZWJvb3RlZCB3aGVuZXZlciB0aGVpciBtZWFzdXJl
ZCBtZW1vcnkgYmFuZHdpZHRoDQogICAgIGZhbGxzIGJlbG93IDMwMCBHQi9zLiINCg0KLS0tDQpS
b2JlcnQgRWxsaW90dCwgSFBFIFBlcnNpc3RlbnQgTWVtb3J5DQoNCg0K
