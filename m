Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B9DC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 07:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F12AF208E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 07:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=infinera.com header.i=@infinera.com header.b="FWxHBmiQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F12AF208E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=infinera.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbeH1Ld7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 07:33:59 -0400
Received: from mail-by2nam01on0047.outbound.protection.outlook.com ([104.47.34.47]:63145
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727110AbeH1Ld7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 07:33:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2k50QS+dJY3x+cTY4YT6OOtKgYtDoS3RtaMaRFu6Lcs=;
 b=FWxHBmiQHR4ZbFxil3vJpkSaK+Op0282+5pnA1wLNqQpf17Cwc2cdD8lPWOPFeM6i8IWZE1CdBofJoPbwPa7SxeIzzwzrKGkR3UhphL1RDG3oe3hIE9ZugcYjeEJSJ3b+JFCukv49fWzePyzh0CoWs0JotD1AwTg385KqjMShDg=
Received: from SN1PR10MB0736.namprd10.prod.outlook.com (10.163.206.15) by
 SN1PR10MB0477.namprd10.prod.outlook.com (10.162.103.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Tue, 28 Aug 2018 07:43:34 +0000
Received: from SN1PR10MB0736.namprd10.prod.outlook.com
 ([fe80::488b:a298:2f2c:9855]) by SN1PR10MB0736.namprd10.prod.outlook.com
 ([fe80::488b:a298:2f2c:9855%4]) with mapi id 15.20.1080.015; Tue, 28 Aug 2018
 07:43:34 +0000
From:   Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [Fwd: 11 minute NTP hw clock update racy?]
Thread-Topic: [Fwd: 11 minute NTP hw clock update racy?]
Thread-Index: AQHUPqLSDhIQXqq54UaXeZ3NUXzKhQ==
Date:   Tue, 28 Aug 2018 07:43:34 +0000
Message-ID: <6e9971f10c75537582abd5c77d798944080b716a.camel@infinera.com>
References: <472091f06a11d4525dc655c78bfeb6e82b71ed2a.camel@infinera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Joakim.Tjernlund@infinera.com; 
x-originating-ip: [88.131.87.201]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR10MB0477;6:/qE41tjHsA+8sntz8MOK1M+6vWKVmkmqHKp1s/b55XXHr/TrAinbJl4QPd3zij7u0NP4E7DZdZlGEpGqwJxzdAXhq9oYro8LYzUnFpZeEgA2jFnmwAiWNsMmfw713mczMguy+j1TgG8N11iuf70SB8azEoJ8Rgk+XpHZjWvp3dBVB6Lvo4sdIxGEf8EwVnnbuJ/m0BIZJplhSCb8cMUXlCtA+vAXt8V/ZjCWhAA6Wcz0t2QnXJe7pG/DUj8B6BVq69Otn9eu7W46HD6p08gBJW+IBxwSbL1+vByjdj/TIR/CnRLFZGkh8UsXBnUGOuanfgjmwKpEyKxirGDouZaH/G3XL7OBYG8wnWrw03KJSEuwirIFyMqdZiljxtov5GcE/0bPLHPlzzA2tjfyCQZR750U57PorMuT8Qyl56I9u/k7uu/8ixM5g1+9TOTNxKm4mxufbAkfHqfL3VHf7Rw7Rw==;5:BdWxxu0SbdpKCvRgPVVTgsS24njxeOJgdBd7aWrOTp/7cZe9nWGHH7/G9FGsyP++oWVrmw3RqGDA5zemZPPDYkPaeYdEldnOAaYJiGeiC48XzKbPMOTl6t/cb3GXjXAwsUuM4FjCFcCWXezo/8Gx0bHu4G9rR5AcPpFMws+ZUsA=;7:ivEK6qtQG9yUJ6Vm+R3lg8OjLjbdKKXvlbPozOkz7nbmspZB4IScGEn80OCPMPPejuhERGcT5WlF2iOc9ml0rN2uISreKi2DAQ71fvrz5RSi0cmWc610OKqx6c5FTurfRneZo54OCtMz+SaiVgB4+YWerALNPysEw/ix4/TrOA4HOQ0nLw1s0VRCRFjndpmFCEoERXL/dGqUxgJpOpbDPJ8aPNlO/FIQVGlxjjNEfq5IXBv7zkypYITGF26Azt/5
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 434b2a1b-c3e8-4785-66c6-08d60cb9f54c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN1PR10MB0477;
x-ms-traffictypediagnostic: SN1PR10MB0477:
x-microsoft-antispam-prvs: <SN1PR10MB0477F1625A9580802DCB841BF40A0@SN1PR10MB0477.namprd10.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(65623756079841);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699016);SRVR:SN1PR10MB0477;BCL:0;PCL:0;RULEID:;SRVR:SN1PR10MB0477;
x-forefront-prvs: 077884B8B5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(396003)(136003)(39850400004)(199004)(189003)(22974007)(54094003)(8676002)(26005)(2616005)(76176011)(476003)(102836004)(2906002)(97736004)(3846002)(6506007)(36756003)(81166006)(81156014)(6116002)(6486002)(6916009)(53546011)(6512007)(53936002)(5660300001)(6436002)(5640700003)(15650500001)(118296001)(478600001)(72206003)(66066001)(68736007)(486006)(2900100001)(99286004)(14444005)(256004)(25786009)(14454004)(7736002)(105586002)(305945005)(106356001)(186003)(2501003)(316002)(86362001)(2351001)(8936002)(5250100002)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR10MB0477;H:SN1PR10MB0736.namprd10.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: infinera.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Y8DjimM+TdNiPggtB6gZnuAzs3dTupaeX7yh+6ePiOBXJz6GXIhNDjfZdrjBirqBGVJDo/4hwtD8Q1LVryQ8E7OtW2j0P5cQHfFimu7z1gfTibHy/yYzyUs3moT4dIL1FIFDHtb3Eva1mlYpxmn5uMG6PAjDohxzxNOFdK3RN3ZsFwUakmfy+wdp7AMRn7c0PZU79Ye9FlTc0QI0iLbqINyQwAAsVG9ZM70x2ZWqoOkOvKSp5aZwcKRxmy5/kIVPD3hCt3C3KcI/0j+CToZ/IF+shOuQzlPcX1zvJO1ZOZA4zZZ8O99rMkeJJe/k+OQUXaxy855sMlY6fsj/HF6gtGgUC4PRo3mPeIdeYHk17+c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <C486D5C6B521BC4F98C25D8EA6725C3B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 434b2a1b-c3e8-4785-66c6-08d60cb9f54c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2018 07:43:34.2320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR10MB0477
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tm8gbHVjayBvbiBsaW51eHBwYy1kZXYsIHRyeWluZyBMS01MIC4uLg0KDQotLS0tLS0tLSBGb3J3
YXJkZWQgTWVzc2FnZSAtLS0tLS0tLQ0KRnJvbTogSm9ha2ltIFRqZXJubHVuZCA8am9ha2ltLnRq
ZXJubHVuZEBpbmZpbmVyYS5jb20+DQpUbzogbGludXhwcGMtZGV2IGxpbnV4cHBjLWRldiA8bGlu
dXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmc+DQpTdWJqZWN0OiAxMSBtaW51dGUgTlRQIGh3IGNs
b2NrIHVwZGF0ZSByYWN5Pw0KRGF0ZTogTW9uLCAyNyBBdWcgMjAxOCAxMDowMToxMiArMDIwMA0K
DQpXZSBzZWUgY29ycnVwdCBIVyBjbG9jayB0aW1lIGV2ZXJ5IG5vdyBhbmQgdGhlbihyZWFsbHkg
aGFyZCB0byByZXByb2R1Y2UpDQpPdXIgUlRDIGlzIGEgRFMxMzg4IG9uIGFuIEkyQyBidXMuDQoN
Ckxvb2tpbmcgYXQgbnRwX25vdGlmeV9jbW9zX3RpbWVyKCkgYW5kIGl0J3MgZGVsYXllZCB3b3Jr
IHF1ZXVlIGltcGwuIEkgd29uZGVyDQppZiB0aGVyZSBjb3VsZCBiZSBhIHJhY2UgaGVyZSB3LnIu
dCByZWJvb3QgPw0KDQpDb3VsZCB0aGUgMTEgbWludXRlIHVwZGF0ZSBraWNrIGluIGp1c3QgYXMg
dGhlIHN5c3RlbSBpcyBhYm91dCB0byByZXNldA0KdGhlIENQVT8NCg0KSSBhbSBvbiA0LjE0LjUx
LCBwcGMzMiBhbmQgdXNpbmcgdGhlIHBwY19tZC5yZXN0YXJ0KCkgaG9vayB3aGljaCB3aWxsDQpy
ZXNldCB0aGUgQ1BVIGltbWVkaWF0ZWx5Lg0KDQpRdWVzdGlvbiwgaXMgc2FmZSB0byBjYWxsIG50
cF9ub3RpZnlfY21vc190aW1lcigpIHdoZW4gdGhlIHdvcmsgcXVldWUgaXMgYWxyZWFkeQ0KYXJt
ZWQobGlrZSBkb19hZGp0aW1leCgpIGRvZXMpID8gDQoNCiBKb2NrZQ0KDQo=
