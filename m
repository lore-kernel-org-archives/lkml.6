Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-472497-1522182497-2-1639570099515538777
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522182496; b=S6iLiZAl07sB+5By3uOS/BrcHukRsVUwhAb537q7YlOAdZn
    yCkhywsffF69pCLffJr2FX68Lv4tgMfRjgyV/fSUo85wtZG2ON/RMOMwaf+hWlad
    oOWn2mvdj9QxztEwNhNjHyuE2eBwuAojhjIGBYykdaHvWFUUxar+LxV4VQ804ELn
    gMNp6en/xQCra8s/KHHq5CXOEmTp14n8j7XoEDvBIotxdmJhwLcj90RpiaMLVxee
    EzmFblfoqhImEBiwBIqY4VS8mbPdBRQVUuSFHYYoKmnX1ZhYWgrrdLBohVPn+PcY
    SHj1XGQRqFTWvr4nsMR+qv+oyico7yGGuVfXS3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1522182496; bh=YWAjGwtsbyvpPaNlmWZLOROuH8QraRMKeWFJib
    GfjnQ=; b=QO4cBqY2Rg5AIcWwngbxggMjjpVfsjH2VB6p4Veh3wqPaZJJPvLMHW
    CT7PviOFLVV8JGaHnJJmHgceRcQh1MerVjEIpalzr8y+NreFDb5t0YO/+pgXPbBq
    kTvYd5mn2qgjXVR6nGpKgCz819+4TrPJdYo27GQjS2y5zZhRd4MCxfutrSv/T/6P
    yHQRfywZAdXdLdVcn46+0n/JnsMZdb3JhzT7Oal/r7//ewI6GvNzbzPtPp+mnKxj
    hv4ggzdyURYyD9XVfU+MG/veSIh6sILDw+ztc4Z1qFU8oQvEwc/DMh0v+mqlUR5a
    vdQLhq5oClPQpfDRyIxZorODDCbdOJYQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=hpe.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=hpe.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=hpe.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=hpe.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCuZnK6kHUJthmyW7qhimRdahRqM9sGgdSLvbEtM+1HmIs4FITAlV1+LJJ7H3tHXjq0n2g9hWIthISXKXVlskmsaGxQOFkHxUinhGJjvqaKpxLZusX6D
    xu4abCtPkFXlJyC/FAOcwia6lvfyCbZOX39AAsthEjwLaASTAwCG2CMs4KtcX/slyjIS1WnHPSBvWp8BL42K3QByWwtU9dXf3gp1LHE0AUf8DLI4PYWZlPwG
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=-QivDyp7SNMA:10 a=F3kEEn-mzN4A:10
    a=4ryF5tWLDgoA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=v2DPQv5-lfwA:10
    a=QDZ4HvhdkI4A:10 a=MvuuwTCpAAAA:8 a=Z4Rwk6OoAAAA:8 a=VwQbUJbxAAAA:8
    a=BTeA3XvPAAAA:8 a=7CQSdrXTAAAA:8 a=i0EeH86SAAAA:8 a=iox4zFpeAAAA:8
    a=20KFwNOVAAAA:8 a=oGMlB6cnAAAA:8 a=JfrnYn6hAAAA:8 a=LpQP-O61AAAA:8
    a=ag1SF4gXAAAA:8 a=cat7hbm38FGNYthO63oA:9 a=JvQiT_VBVfVCvIjZ:21
    a=tw24z1r-2w6H_ZV9:21 a=QEXdDO2ut3YA:10 a=dVHiktpip_riXrfdqayU:22
    a=HkZW87K1Qel5hWWM3VKY:22 a=AjGcO6oz07-iQ99wixmX:22 a=tafbbOV3vt1XuEhzTjGK:22
    a=a-qgeE7W1pNrGK8U0ZQC:22 a=WzC6qhA0u3u7Ye7llzcV:22 a=NdAtdrkLVvyUPsUoGJp4:22
    a=1CNFftbPRP8L7MoqJWF3:22 a=pioyyrs4ZptJ924tMmac:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751103AbeC0U2N (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 16:28:13 -0400
Received: from g4t3425.houston.hpe.com ([15.241.140.78]:45835 "EHLO
        g4t3425.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751020AbeC0U2M (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 16:28:12 -0400
From: "Kani, Toshi" <toshi.kani@hpe.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "dan.rue@linaro.org" <dan.rue@linaro.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "bp@suse.de" <bp@suse.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "lious.lilei@hisilicon.com" <lious.lilei@hisilicon.com>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>,
        "wxf.wang@hisilicon.com" <wxf.wang@hisilicon.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Hocko, Michal" <MHocko@suse.com>,
        "cpandya@codeaurora.org" <cpandya@codeaurora.org>,
        "willy@infradead.org" <willy@infradead.org>
Subject: Re: [PATCH 4.4 20/43] mm/vmalloc: add interfaces to free unmapped
 page table
Thread-Topic: [PATCH 4.4 20/43] mm/vmalloc: add interfaces to free unmapped
 page table
Thread-Index: AQHTxejJnWYIqchHYkKAUWneqflDN6PkhU4AgAAC3gA=
Date: Tue, 27 Mar 2018 20:27:33 +0000
Message-ID: <1522182436.2693.238.camel@hpe.com>
References: <20180327162716.407986916@linuxfoundation.org>
         <20180327162717.580646019@linuxfoundation.org>
         <20180327201700.xmgzgqox3sz3z32r@xps>
In-Reply-To: <20180327201700.xmgzgqox3sz3z32r@xps>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com;
x-originating-ip: [15.203.227.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DF4PR8401MB1115;7:nV3vq1MKR8Znofi0+CzLJnaUAQZFW7Od/9bmjFy8KKc9D5QHj1xDJ0b96l3XWZvHOoLoeTmyafdgHcJ/Y2hI4rl6Y9MC6ajMxz7In+qzryRsi7B8x96PxoLv5vSvAmuWkHMMryCFG0QxbWn7TKxeiEc7tTqKBpUZxiJJ8l7cbuZYMaX7j3LioQLX3Px8erYV6mH03WD3eetoWNWuOCsHNkfGErFFQ409xKprqNpMkLf/4wwkkPFEY/O8O5DuZ1XK
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ee255428-135e-4142-9c06-08d594212c4c
x-microsoft-antispam: UriScan:(222181515654134);BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989060)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(2017052603328)(7153060)(7193020);SRVR:DF4PR8401MB1115;
x-ms-traffictypediagnostic: DF4PR8401MB1115:
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-microsoft-antispam-prvs: <DF4PR8401MB1115E9204EC3F58C7E104ACE82AC0@DF4PR8401MB1115.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(227479698468861)(180628864354917)(9452136761055)(50582790962513)(42068640409301)(222181515654134);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(10201501046)(3002001)(6055026)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:DF4PR8401MB1115;BCL:0;PCL:0;RULEID:;SRVR:DF4PR8401MB1115;
x-forefront-prvs: 0624A2429E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(366004)(39380400002)(39860400002)(376002)(377424004)(199004)(189003)(103116003)(316002)(446003)(66066001)(53936002)(6486002)(2616005)(36756003)(6436002)(11346002)(8936002)(6506007)(5660300001)(86362001)(305945005)(478600001)(76176011)(5250100002)(2501003)(186003)(97736004)(8676002)(2900100001)(4326008)(6246003)(6512007)(26005)(7416002)(3280700002)(81156014)(68736007)(81166006)(229853002)(105586002)(3846002)(6116002)(102836004)(106356001)(7736002)(54906003)(3660700001)(25786009)(14454004)(6306002)(110136005)(486005)(2906002)(966005)(476003)(99286004)(486005);DIR:OUT;SFP:1102;SCL:1;SRVR:DF4PR8401MB1115;H:DF4PR8401MB0396.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: KND1qLwH8rgz7yDBeScCR5/QQc61TW3Yllo9J33HfSVybNrgGLjrkZxY4m/qdRKhN6mpKR32hOne87PgAZ4c+A1JrpYwgRAhtmkmmzJdln6hAJ+C//GWsX3PiVvd6TlMu22nQf87MhIU8gtXK02ZXp8p6jYGVR5P7gK1ccLesN7skvj1QWjhAvTAQ+wBmAShAE+ngc0r7dwW3amrhCENknEl4n3NeGNjYmuaglb212Z13pU3zRRbu3S2uLyqU+tXQQalEJvTFFSEm+y22DO/fEUvA37lxBZroHNWpQxcfba9R2d89n1n0ngW2y3NDoj2/d8NEfTZCSILugFLDClTaA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <1ACCCC721A0C964D8EF39C4E60B16341@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ee255428-135e-4142-9c06-08d594212c4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2018 20:27:34.0061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DF4PR8401MB1115
X-OriginatorOrg: hpe.com
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gVHVlLCAyMDE4LTAzLTI3IGF0IDE1OjE3IC0wNTAwLCBEYW4gUnVlIHdyb3RlOg0KPiBPbiBU
dWUsIE1hciAyNywgMjAxOCBhdCAwNjoyNzoyNFBNICswMjAwLCBHcmVnIEtyb2FoLUhhcnRtYW4g
d3JvdGU6DQo+ID4gNC40LXN0YWJsZSByZXZpZXcgcGF0Y2guICBJZiBhbnlvbmUgaGFzIGFueSBv
YmplY3Rpb25zLCBwbGVhc2UgbGV0IG1lIGtub3cuDQo+ID4gDQo+ID4gLS0tLS0tLS0tLS0tLS0t
LS0tDQo+ID4gDQo+ID4gRnJvbTogVG9zaGkgS2FuaSA8dG9zaGkua2FuaUBocGUuY29tPg0KPiA+
IA0KPiA+IGNvbW1pdCBiNmJkYjc1MTdjM2QzZjQxZjIwZTVjMjk0OGQ2YmMzZjg4OTczOTRlIHVw
c3RyZWFtLg0KPiA+IA0KPiA+IE9uIGFyY2hpdGVjdHVyZXMgd2l0aCBDT05GSUdfSEFWRV9BUkNI
X0hVR0VfVk1BUCBzZXQsIGlvcmVtYXAoKSBtYXkNCj4gPiBjcmVhdGUgcHVkL3BtZCBtYXBwaW5n
cy4gIEEga2VybmVsIHBhbmljIHdhcyBvYnNlcnZlZCBvbiBhcm02NCBzeXN0ZW1zDQo+ID4gd2l0
aCBDb3J0ZXgtQTc1IGluIHRoZSBmb2xsb3dpbmcgc3RlcHMgYXMgZGVzY3JpYmVkIGJ5IEhhbmp1
biBHdW8uDQo+ID4gDQo+ID4gIDEuIGlvcmVtYXAgYSA0SyBzaXplLCB2YWxpZCBwYWdlIHRhYmxl
IHdpbGwgYnVpbGQsDQo+ID4gIDIuIGlvdW5tYXAgaXQsIHB0ZTAgd2lsbCBzZXQgdG8gMDsNCj4g
PiAgMy4gaW9yZW1hcCB0aGUgc2FtZSBhZGRyZXNzIHdpdGggMk0gc2l6ZSwgcGdkL3BtZCBpcyB1
bmNoYW5nZWQsDQo+ID4gICAgIHRoZW4gc2V0IHRoZSBhIG5ldyB2YWx1ZSBmb3IgcG1kOw0KPiA+
ICA0LiBwdGUwIGlzIGxlYWtlZDsNCj4gPiAgNS4gQ1BVIG1heSBtZWV0IGV4Y2VwdGlvbiBiZWNh
dXNlIHRoZSBvbGQgcG1kIGlzIHN0aWxsIGluIFRMQiwNCj4gPiAgICAgd2hpY2ggd2lsbCBsZWFk
IHRvIGtlcm5lbCBwYW5pYy4NCj4gPiANCj4gPiBUaGlzIHBhbmljIGlzIG5vdCByZXByb2R1Y2li
bGUgb24geDg2LiAgSU5WTFBHLCBjYWxsZWQgZnJvbSBpb3VubWFwLA0KPiA+IHB1cmdlcyBhbGwg
bGV2ZWxzIG9mIGVudHJpZXMgYXNzb2NpYXRlZCB3aXRoIHB1cmdlZCBhZGRyZXNzIG9uIHg4Ni4g
IHg4Ng0KPiA+IHN0aWxsIGhhcyBtZW1vcnkgbGVhay4NCj4gPiANCj4gPiBUaGUgcGF0Y2ggY2hh
bmdlcyB0aGUgaW9yZW1hcCBwYXRoIHRvIGZyZWUgdW5tYXBwZWQgcGFnZSB0YWJsZShzKSBzaW5j
ZQ0KPiA+IGRvaW5nIHNvIGluIHRoZSB1bm1hcCBwYXRoIGhhcyB0aGUgZm9sbG93aW5nIGlzc3Vl
czoNCj4gPiANCj4gPiAgLSBUaGUgaW91bm1hcCgpIHBhdGggaXMgc2hhcmVkIHdpdGggdnVubWFw
KCkuIFNpbmNlIHZtYXAoKSBvbmx5DQo+ID4gICAgc3VwcG9ydHMgcHRlIG1hcHBpbmdzLCBtYWtp
bmcgdnVubWFwKCkgdG8gZnJlZSBhIHB0ZSBwYWdlIGlzIGFuDQo+ID4gICAgb3ZlcmhlYWQgZm9y
IHJlZ3VsYXIgdm1hcCB1c2VycyBhcyB0aGV5IGRvIG5vdCBuZWVkIGEgcHRlIHBhZ2UgZnJlZWQN
Cj4gPiAgICB1cC4NCj4gPiANCj4gPiAgLSBDaGVja2luZyBpZiBhbGwgZW50cmllcyBpbiBhIHB0
ZSBwYWdlIGFyZSBjbGVhcmVkIGluIHRoZSB1bm1hcCBwYXRoDQo+ID4gICAgaXMgcmFjeSwgYW5k
IHNlcmlhbGl6aW5nIHRoaXMgY2hlY2sgaXMgZXhwZW5zaXZlLg0KPiA+IA0KPiA+ICAtIFRoZSB1
bm1hcCBwYXRoIGNhbGxzIGZyZWVfdm1hcF9hcmVhX25vZmx1c2goKSB0byBkbyBsYXp5IFRMQiBw
dXJnZXMuDQo+ID4gICAgQ2xlYXJpbmcgYSBwdWQvcG1kIGVudHJ5IGJlZm9yZSB0aGUgbGF6eSBU
TEIgcHVyZ2VzIG5lZWRzIGV4dHJhIFRMQg0KPiA+ICAgIHB1cmdlLg0KPiA+IA0KPiA+IEFkZCB0
d28gaW50ZXJmYWNlcywgcHVkX2ZyZWVfcG1kX3BhZ2UoKSBhbmQgcG1kX2ZyZWVfcHRlX3BhZ2Uo
KSwgd2hpY2gNCj4gPiBjbGVhciBhIGdpdmVuIHB1ZC9wbWQgZW50cnkgYW5kIGZyZWUgdXAgYSBw
YWdlIGZvciB0aGUgbG93ZXIgbGV2ZWwNCj4gPiBlbnRyaWVzLg0KPiA+IA0KPiA+IFRoaXMgcGF0
Y2ggaW1wbGVtZW50cyB0aGVpciBzdHViIGZ1bmN0aW9ucyBvbiB4ODYgYW5kIGFybTY0LCB3aGlj
aCB3b3JrDQo+ID4gYXMgd29ya2Fyb3VuZC4NCj4gPiANCj4gPiBbYWtwbUBsaW51eC1mb3VuZGF0
aW9uLm9yZzogZml4IHR5cG8gaW4gcG1kX2ZyZWVfcHRlX3BhZ2UoKSBzdHViXQ0KPiA+IExpbms6
IGh0dHA6Ly9sa21sLmtlcm5lbC5vcmcvci8yMDE4MDMxNDE4MDE1NS4xOTQ5Mi0yLXRvc2hpLmth
bmlAaHBlLmNvbQ0KPiA+IEZpeGVzOiBlNjFjZTZhZGU0MDRlICgibW06IGNoYW5nZSBpb3JlbWFw
IHRvIHNldCB1cCBodWdlIEkvTyBtYXBwaW5ncyIpDQo+ID4gUmVwb3J0ZWQtYnk6IExlaSBMaSA8
bGlvdXMubGlsZWlAaGlzaWxpY29uLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBUb3NoaSBLYW5p
IDx0b3NoaS5rYW5pQGhwZS5jb20+DQo+ID4gQ2M6IENhdGFsaW4gTWFyaW5hcyA8Y2F0YWxpbi5t
YXJpbmFzQGFybS5jb20+DQo+ID4gQ2M6IFdhbmcgWHVlZmVuZyA8d3hmLndhbmdAaGlzaWxpY29u
LmNvbT4NCj4gPiBDYzogV2lsbCBEZWFjb24gPHdpbGwuZGVhY29uQGFybS5jb20+DQo+ID4gQ2M6
IEhhbmp1biBHdW8gPGd1b2hhbmp1bkBodWF3ZWkuY29tPg0KPiA+IENjOiBNaWNoYWwgSG9ja28g
PG1ob2Nrb0BzdXNlLmNvbT4NCj4gPiBDYzogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9u
aXguZGU+DQo+ID4gQ2M6IEluZ28gTW9sbmFyIDxtaW5nb0ByZWRoYXQuY29tPg0KPiA+IENjOiAi
SC4gUGV0ZXIgQW52aW4iIDxocGFAenl0b3IuY29tPg0KPiA+IENjOiBCb3Jpc2xhdiBQZXRrb3Yg
PGJwQHN1c2UuZGU+DQo+ID4gQ2M6IE1hdHRoZXcgV2lsY294IDx3aWxseUBpbmZyYWRlYWQub3Jn
Pg0KPiA+IENjOiBDaGludGFuIFBhbmR5YSA8Y3BhbmR5YUBjb2RlYXVyb3JhLm9yZz4NCj4gPiBD
YzogPHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+DQo+ID4gU2lnbmVkLW9mZi1ieTogQW5kcmV3IE1v
cnRvbiA8YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZz4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBMaW51
cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRhdGlvbi5vcmc+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4NCj4g
DQo+IFRoaXMgcGF0Y2ggY2F1c2VzIHRoZSBmb2xsb3dpbmcgYnVpbGQgZXJyb3Igb24gNC40IGFy
bTY0Og0KPiANCj4gJCBtYWtlIEFSQ0g9YXJtNjQgQ1JPU1NfQ09NUElMRT1hYXJjaDY0LWxpbnV4
LWdudS0gTz1idWlsZC1hcm02NCBkZWZjb25maWcNCj4gJCBtYWtlIEFSQ0g9YXJtNjQgQ1JPU1Nf
Q09NUElMRT1hYXJjaDY0LWxpbnV4LWdudS0gTz1idWlsZC1hcm02NA0KPiANCj4gICBDQyAgICAg
IGFyY2gvYXJtNjQvbW0vbW11Lm8NCj4gLi4vYXJjaC9hcm02NC9tbS9tbXUuYzo3MDE6NTogZXJy
b3I6IHJlZGVmaW5pdGlvbiBvZiDigJhwdWRfZnJlZV9wbWRfcGFnZeKAmQ0KPiAgaW50IHB1ZF9m
cmVlX3BtZF9wYWdlKHB1ZF90ICpwdWQpDQo+ICAgICAgXn5+fn5+fn5+fn5+fn5+fn4NCj4gSW4g
ZmlsZSBpbmNsdWRlZCBmcm9tIC4uL2FyY2gvYXJtNjQvaW5jbHVkZS9hc20vcGd0YWJsZS5oOjY4
MjowLA0KPiAgICAgICAgICAgICAgICAgIGZyb20gLi4vaW5jbHVkZS9saW51eC9tbS5oOjU1LA0K
PiAgICAgICAgICAgICAgICAgIGZyb20gLi4vaW5jbHVkZS9saW51eC9tbWFuLmg6NCwNCj4gICAg
ICAgICAgICAgICAgICBmcm9tIC4uL2FyY2gvYXJtNjQvbW0vbW11LmM6MjU6DQo+IC4uL2luY2x1
ZGUvYXNtLWdlbmVyaWMvcGd0YWJsZS5oOjc3NzoxOTogbm90ZTogcHJldmlvdXMgZGVmaW5pdGlv
biBvZiDigJhwdWRfZnJlZV9wbWRfcGFnZeKAmSB3YXMgaGVyZQ0KPiAgc3RhdGljIGlubGluZSBp
bnQgcHVkX2ZyZWVfcG1kX3BhZ2UocHVkX3QgKnB1ZCkNCj4gICAgICAgICAgICAgICAgICAgIF5+
fn5+fn5+fn5+fn5+fn5+DQo+IC4uL2FyY2gvYXJtNjQvbW0vbW11LmM6NzA2OjU6IGVycm9yOiBy
ZWRlZmluaXRpb24gb2Yg4oCYcG1kX2ZyZWVfcHRlX3BhZ2XigJkNCj4gIGludCBwbWRfZnJlZV9w
dGVfcGFnZShwbWRfdCAqcG1kKQ0KPiAgICAgIF5+fn5+fn5+fn5+fn5+fn5+DQo+IEluIGZpbGUg
aW5jbHVkZWQgZnJvbSAuLi9hcmNoL2FybTY0L2luY2x1ZGUvYXNtL3BndGFibGUuaDo2ODI6MCwN
Cj4gICAgICAgICAgICAgICAgICBmcm9tIC4uL2luY2x1ZGUvbGludXgvbW0uaDo1NSwNCj4gICAg
ICAgICAgICAgICAgICBmcm9tIC4uL2luY2x1ZGUvbGludXgvbW1hbi5oOjQsDQo+ICAgICAgICAg
ICAgICAgICAgZnJvbSAuLi9hcmNoL2FybTY0L21tL21tdS5jOjI1Og0KPiAuLi9pbmNsdWRlL2Fz
bS1nZW5lcmljL3BndGFibGUuaDo3ODE6MTk6IG5vdGU6IHByZXZpb3VzIGRlZmluaXRpb24gb2Yg
4oCYcG1kX2ZyZWVfcHRlX3BhZ2XigJkgd2FzIGhlcmUNCj4gIHN0YXRpYyBpbmxpbmUgaW50IHBt
ZF9mcmVlX3B0ZV9wYWdlKHBtZF90ICpwbWQpDQo+ICAgICAgICAgICAgICAgICAgICBefn5+fn5+
fn5+fn5+fn5+fg0KPiBtYWtlWzJdOiAqKiogWy4uL3NjcmlwdHMvTWFrZWZpbGUuYnVpbGQ6Mjcw
OiBhcmNoL2FybTY0L21tL21tdS5vXSBFcnJvciAxDQo+IG1ha2VbMV06ICoqKiBbL2hvbWUvZHJ1
ZS9zcmMvbGludXgvNC40LXJjL01ha2VmaWxlOjk2OTogYXJjaC9hcm02NC9tbV0gRXJyb3IgMg0K
PiBtYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSAnL2hvbWUvZHJ1ZS9zcmMvbGludXgvNC40LXJj
L2J1aWxkLWFybTY0Jw0KPiBtYWtlOiAqKiogW01ha2VmaWxlOjE1Mjogc3ViLW1ha2VdIEVycm9y
IDINCj4gDQo+IA0KPiA+IA0KPiA+IC0tLQ0KPiA+ICBhcmNoL2FybTY0L21tL21tdS5jICAgICAg
ICAgICB8ICAgMTAgKysrKysrKysrKw0KPiA+ICBhcmNoL3g4Ni9tbS9wZ3RhYmxlLmMgICAgICAg
ICB8ICAgMjQgKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIGluY2x1ZGUvYXNtLWdlbmVy
aWMvcGd0YWJsZS5oIHwgICAxMCArKysrKysrKysrDQo+ID4gIGxpYi9pb3JlbWFwLmMgICAgICAg
ICAgICAgICAgIHwgICAgNiArKysrLS0NCj4gPiAgNCBmaWxlcyBjaGFuZ2VkLCA0OCBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IC0tLSBhL2FyY2gvYXJtNjQvbW0vbW11
LmMNCj4gPiArKysgYi9hcmNoL2FybTY0L21tL21tdS5jDQo+ID4gQEAgLTY5NywzICs2OTcsMTMg
QEAgdm9pZCAqX19pbml0IGZpeG1hcF9yZW1hcF9mZHQocGh5c19hZGRyXw0KPiA+ICANCj4gPiAg
CXJldHVybiBkdF92aXJ0Ow0KPiA+ICB9DQo+ID4gKw0KPiA+ICtpbnQgcHVkX2ZyZWVfcG1kX3Bh
Z2UocHVkX3QgKnB1ZCkNCj4gPiArew0KPiA+ICsJcmV0dXJuIHB1ZF9ub25lKCpwdWQpOw0KPiA+
ICt9DQo+ID4gKw0KPiA+ICtpbnQgcG1kX2ZyZWVfcHRlX3BhZ2UocG1kX3QgKnBtZCkNCj4gPiAr
ew0KPiA+ICsJcmV0dXJuIHBtZF9ub25lKCpwbWQpOw0KPiA+ICt9DQoNClNvcnJ5IGZvciB0aGUg
dHJvdWJsZS4gIEZvciA0LjQsIHdlIG5lZWQgdG8gc2ltcGx5IGRyb3AgdGhlIGNoYW5nZSBpbg0K
dGhlIGFyY2gvYXJtNjQvbW0vbW11LmMgZmlsZSBzaW5jZSBhcm02NCBnZXRzIHRoZSBmdW5jcyBm
cm9tDQppbmNsdWRlL2FzbS1nZW5lcmljL3BndGFibGUuaC4NCg0KVGhhbmtzLA0KLVRvc2hp
