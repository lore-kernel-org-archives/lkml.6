Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3236517-1527028299-2-16585132636421483073
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527028298; b=WTTRfDfN7ayHFGH8kTZpsoCz22gQ1KjXMn2MOh8Ydb3oLcbRwK
    /ww4T2/nf/HAlkrKPoUW45Pk1nZpXZdIG7cgLu646k8RkdzLKgMUxtYspqF97bvk
    C65n3XnTG6Cq5MFhfXvq3BqHHo1LdbElpCnwERHdr6XlAxpla/je73gI0RYYMxRw
    OCa/MTbtw9yvJiPjyinTCJ91PuyCXUKQ630fhzrYa2ZkiJM0C/XnYjorIQ1RyNT8
    7IrBQA1IVJAYPYVPDJX8b7iim5pg9oFktRk3cmbZTOAHdYSU1qUF84/m63EPaai1
    tEkqzCx5eLYaNbbTlCLZ1xIjq4KpXCqdr1Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1527028298; bh=X23t/nzPlCLuEONyZpvn2R71itmwowWDAFqBNvS02h4=; b=
    B6L+eLqCnEaa5QDw3vruyqFYQmfGQu1LzP+kgYiCEuChLq+94h8wLI86neQ9uddw
    KZyyoap/fq1gy4ZHE4HL2MYNhs7+7VROJT50V0ofmklvol7Zc4Jb9E0ulIRytz9c
    AsBBU7NkjC++tc2dPdt2UdRRXhxUwfg2tsSHW1tjjw73CyQJsT1apcEV/VmggOoO
    nGVCce+M+MwLLy1YJmxIhAk8oSjfuVX0ksT+Qw0T0ZGXZSPPeBRVpUO9A1vbdh7z
    bxrHK7uxll2ghKLJXl9l7R5wW9sUIbWf4G+gvMOiqKJ9j6NS2dcicmqESLRVlqIU
    GVKXmJaGAG1K15OdLWqSGg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=sharedspace.onmicrosoft.com
    header.i=@sharedspace.onmicrosoft.com header.b=mbeFqet2 x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=selector1-wdc-com;
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=wdc.com header.i=@wdc.com header.b=WKhy9umU x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=dkim.wdc.com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=wdc.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=wdc.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=sharedspace.onmicrosoft.com
      header.i=@sharedspace.onmicrosoft.com header.b=mbeFqet2 x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=selector1-wdc-com;
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=wdc.com header.i=@wdc.com header.b=WKhy9umU x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=dkim.wdc.com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=wdc.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=wdc.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNBAziU0bDvX8+woynMHsq0KblbkzZaHMbjdt+hZIfOViJFL/c7LxULbxp8n1gZ2xhdzuTo88B8Ow6EoLKUdOhM2N6wp3pBfz2t45Jvd+wo8QCyD+eJM
    +znp4sGYg0xjIOwqm6B02Xvik8opFdFyBxU8W7J09uBHkhCQuSXYoCMTTw3jsDMu8u9XmyD/iMpoUmX791gWfbixTSwCwqjX7TB6FEGEYzOQbdKJ5nVMPWlC
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=t-pbPhKa4PAA:10 a=sz2zBa69AhIA:10
    a=krqULl2BBk8A:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10
    a=X0ROFhD97x8A:10 a=JF9118EUAAAA:8 a=D19gQVrFAAAA:8 a=VwQbUJbxAAAA:8
    a=h2jTUW6dV4vWUpJUnBQA:9 a=QEXdDO2ut3YA:10 a=ic4oXV6auKO-Q6VfiSZ6:22
    a=xVlTc564ipvMDusKsbsT:22 a=W4TVW4IDbPiebHqcZpNg:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753235AbeEVWbg (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 18:31:36 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:50619 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753167AbeEVWbe (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 22 May 2018 18:31:34 -0400
X-IronPort-AV: E=Sophos;i="5.49,430,1520870400";
   d="scan'208";a="79592380"
From: Adam Manzanares <Adam.Manzanares@wdc.com>
To: Jens Axboe <axboe@kernel.dk>, Al Viro <viro@ZenIV.linux.org.uk>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "bcrl@kvack.org" <bcrl@kvack.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "rgoldwyn@suse.com" <rgoldwyn@suse.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-aio@kvack.org" <linux-aio@kvack.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "hch@infradread.org" <hch@infradread.org>,
        "jmoyer@redhat.com" <jmoyer@redhat.com>
Subject: Re: [PATCH v7 0/5] AIO add per-command iopriority
Thread-Topic: [PATCH v7 0/5] AIO add per-command iopriority
Thread-Index: AQHT8fWs1wk3L4xy3kWVOZiuss3bzKQ8CBoAgAAJ2oCAAAAogIAAQzSA
Date: Tue, 22 May 2018 22:31:27 +0000
Message-ID: <30e8e33f-8e66-2fb3-977a-ee6fe04f1d3c@wdc.com>
References: <20180522175221.2391-1-adam.manzanares@wdc.com>
 <da84d129-4dcd-c861-bfc4-62cd425e60e3@kernel.dk>
 <20180522183019.GD30522@ZenIV.linux.org.uk>
 <4b8732e8-1c51-3181-56a1-d03f7b229f63@kernel.dk>
In-Reply-To: <4b8732e8-1c51-3181-56a1-d03f7b229f63@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Adam.Manzanares@wdc.com;
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR04MB0267;7:EMj718IPRXuTvwlW/6wOMLOBvzpFL8CIh+q0Zx04UoCGWpLIEk/J57zWfM2h2++VzGvxsqTVMJcy74jXhlOwZo5RIfgukK0kMm2LWVxUjWSw+qtS+OsWTYi9Lb+qyA+mVIu0dbS+d8CjtSoVNElfglzo78pUXjqmLz6oaUYHzAq8vM1wPv4iLAuJu3KAxUrF6ZEHhkbvtF6MM7fpT7M9Z+2UzJrxByoee4lvyx+CdvXqlKjiX6hH1kd/GexaNG0s;20:RYCrUdaiO8l1NlqeJOHTr3yAsh8oceSgnjQHwjwyf7IKlQ54jMSdcdCllSBHF/EPYVStiVYoGu7pJncDTOASMo+QIhjwl0I1/6vgBGvzqRt44YhgdbvqPalTAaraPVDptCBM7VhzRgDDnsKusDFL5IEILHh9BXei+++1WZYDeG8=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR04MB0267;
x-ms-traffictypediagnostic: DM5PR04MB0267:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <DM5PR04MB02674E13F8D7770D5D02FAB2F0940@DM5PR04MB0267.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DM5PR04MB0267;BCL:0;PCL:0;RULEID:;SRVR:DM5PR04MB0267;
x-forefront-prvs: 0680FADD48
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(366004)(376002)(396003)(346002)(189003)(199004)(446003)(31686004)(6512007)(478600001)(6436002)(36756003)(110136005)(229853002)(72206003)(97736004)(7416002)(54906003)(966005)(6486002)(5660300001)(6306002)(6246003)(3846002)(6116002)(8936002)(3660700001)(25786009)(486006)(3280700002)(11346002)(476003)(5250100002)(2616005)(305945005)(53936002)(2906002)(7736002)(8676002)(106356001)(68736007)(31696002)(4326008)(81166006)(2900100001)(93886005)(99286004)(316002)(59450400001)(86362001)(26005)(186003)(102836004)(81156014)(66066001)(53546011)(105586002)(14454004)(76176011)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR04MB0267;H:DM5PR04MB0282.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: EGLktoV36jWEmaSSOOaa365hc12eXPM753YVpAEiuc1p1bDggDClTVZoPOEvbKy35g44yXTrzbi7xYLMYjrGIXgcU4E4dbl1NjcxLshEkaNSRl1UKd6nsnqEvYKsODMohhsfxc7zisCNZSsTA+i3BEttBg4O8LD8dnjRT8BDi193K/mdtDUzxPEDJ/kxUYF0
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <B3D9CD9C2C2F2D47BBAA699DC67CB5F0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 488d2faf-8ee6-4d5f-93d3-08d5c033c286
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 488d2faf-8ee6-4d5f-93d3-08d5c033c286
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2018 22:31:28.0851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0267
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

DQoNCk9uIDUvMjIvMTggMTE6MzAgQU0sIEplbnMgQXhib2Ugd3JvdGU6DQo+IE9uIDUvMjIvMTgg
MTI6MzAgUE0sIEFsIFZpcm8gd3JvdGU6DQo+PiBPbiBUdWUsIE1heSAyMiwgMjAxOCBhdCAxMTo1
NTowNEFNIC0wNjAwLCBKZW5zIEF4Ym9lIHdyb3RlOg0KPj4+IE9uIDUvMjIvMTggMTE6NTIgQU0s
IGFkYW0ubWFuemFuYXJlc0B3ZGMuY29tIHdyb3RlOg0KPj4+PiBGcm9tOiBBZGFtIE1hbnphbmFy
ZXMgPGFkYW0ubWFuemFuYXJlc0B3ZGMuY29tPg0KPj4+Pg0KPj4+PiBUaGlzIGlzIHRoZSBwZXIt
SS9PIGVxdWl2YWxlbnQgb2YgdGhlIGlvcHJpb19zZXQgc3lzdGVtIGNhbGwuDQo+Pj4+IFNlZSB0
aGUgZm9sbG93aW5nIGxpbmsgZm9yIHBlcmZvcm1hbmNlIGltcGxpY2F0aW9ucyBvbiBhIFNBVEEg
SEREOg0KPj4+PiBodHRwczovL2xrbWwub3JnL2xrbWwvMjAxNi8xMi82LzQ5NQ0KPj4+Pg0KPj4+
PiBGaXJzdCBwYXRjaCBmYWN0b3JzIGlvcHJpb19jaGVja19jYXAgZnVuY3Rpb24gb3V0IG9mIGlv
cHJpb19zZXQgc3lzdGVtIGNhbGwgdG8NCj4+Pj4gYWxzbyBiZSB1c2VkIGJ5IHRoZSBhaW8gaW9w
cmlvIGludGVyZmFjZS4NCj4+Pj4NCj4+Pj4gU2Vjb25kIHBhdGNoIGNvbnZlcnRzIGtpb2NiIGtp
X2hpbnQgZmllbGQgdG8gYSB1MTYgdG8gYXZvaWQga2lvY2IgYmxvYXQuDQo+Pj4+DQo+Pj4+IFRo
aXJkIHBhdGNoIHBhc3NlcyBpb3ByaW8gaGludCBmcm9tIGFpbyBpb2NiIHRvIGtpb2NiIGFuZCBp
bml0aWFsaXplcyBraW9jYg0KPj4+PiBpb3ByaW8gdmFsdWUgYXBwcm9wcmlhdGVseSB3aGVuIGl0
IGlzIG5vdCBleHBsaWNpdGx5IHNldC4NCj4+Pj4NCj4+Pj4gRm91cnRoIHBhdGNoIGVuYWJsZXMg
dGhlIGZlYXR1cmUgZm9yIGJsa2Rldi4NCj4+Pj4NCj4+Pj4gRmlmdGggcGF0Y2ggZW5hYmxlcyB0
aGUgZmVhdHVyZSBmb3IgaW9tYXAgZGlyZWN0IElPDQo+Pj4NCj4+PiBMR1RNLCB5b3UgY2FuIGFk
ZDoNCj4+Pg0KPj4+IFJldmlld2VkLWJ5OiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+DQo+
Pj4NCj4+PiBBbCwgYXJlIHlvdSBwaWNraW5nIHRoaXMgc2VyaWVzIHVwLCBvciBzaG91bGQgST8N
Cj4+DQo+PiBQcm9iYWJseSBiZXR0ZXIgaWYgSSBkbywgb25jZSBJIGZpbmlzaCByZXZpZXdpbmcg
Q2hyaXN0b3BoJ3MgcGF0Y2hzZXQgLQ0KPj4gd2UgYWxyZWFkeSBoYXZlIGEgYnVuY2ggb2Ygc3R1
ZmYgYXJvdW5kIGZzL2Fpby5jIGluIHRoaXMgY3ljbGUuLi4NCj4gDQo+IEFscmlnaHQsIHNvdW5k
cyBnb29kLCB0aGFua3MgQWwuDQo+IA0KDQpJIHdhcyB3b3JraW5nIG9uIHRoZSBtYW4gcGFnZSB1
cGRhdGUgZm9yIHRoaXMgZmVhdHVyZSBhbmQgbm90aWNlZCBJIA0KY291bGQgYmUgYml0IG1vcmUg
aW5mb3JtYXRpdmUgb24gZXJyb3IgaWYgSSByZXR1cm4gdGhlIGVycm9yIHZhbHVlIA0KcmV0dXJu
ZWQgYnkgaW9wcmlvX2NoZWNrX2NhcCBpbiBmcy9haW8uYy4NCg0KU2hvdWxkIEkgcmVzZW5kIHRo
ZSB3aG9sZSBzZXJpZXM/
