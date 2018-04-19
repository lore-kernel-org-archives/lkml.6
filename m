Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4107594-1524173879-2-12188294788787640881
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524173878; b=ZHYzlTsb8TmPpOhKEej+eaGTYUjfLBRhzN6GStOW/9E6cfGvQb
    l8kkusKpBFtY7fBm4hWqRvwFlyJq5AXhp0uA8VYRGqkxsjYdEEA0elbj4Kgc9Boc
    lT8yetAeQUz3KJ5BumWKSHwwgFge1bKwu2tlqmt22B4GvQGuXHxexcz81gP69w+l
    fnKHWpCiLDcCwySEKrnxy/nOuozf3b65IlFUiasUFfALNUDXpANDD+lIAsQcwAEm
    9j9xbWDp6+r6awQea/vGZTozRdsn5YNKjDam5C3j2t2t4BBfT/ygZTG2Z9lO/5XQ
    BYFmYFwXsZibIKS0pNuN6ba8gTc3vLFIsRyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1524173878; bh=OPwH1fnOUh
    43YoFgul5hJwgW+s82U8dJQEQ7mgdYn3A=; b=rzDaHGacuZ5cGKxHeJnA0z56YS
    OwwvF9QHIiUtNbyT/EtZNqYaJTb850maeaLYlxSWNT/3OaeA1dvOFPRmjwwDY753
    1fOfR2t7ZolSSX7yajNB7SK8bTN7u05pAtI2CYCccLYN7LYLqsIGDwnoZ7spPlVY
    A4ox8EVZjI/pKqu1ZuKPhJ9xzsksAbfU77yj7HSjgxJ3Ott53uCBqBFkhGK+l7m4
    A5yNuQDJl8eSAxKno0vfWB5RDgWmJWsVky8HhFUrNSUIPVJuJ/Y8fuNJgkm1C8eN
    /Y6XDqEaKzLAG4+GmY9ryN30C7Vz0cdzzboCaDPXyY19aMuiD9g1HS1GcFZQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kVrWtoad x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kVrWtoad x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOWPVT4+TxT4OlyfC1AMdKTOQDro+VojchI0b9vY2JyUaiBR2LobmytVgDffNrVnG45H4mQZLlf+S7vCy+LSIqLmMcLPPBx42vpLoz8TI+i0pkk2KYo1
    04km8Xuyl9nDBEdU0fDDKntMyZeuk3oTwTwNS5ULb8NRPSsOWtcoh9PvFqv2isq579FR1Cb1c/m4U37asWcEL1JWe3IZAjt7G+Dk21zp9oW1s/sUYLLtIsFm
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=R4fxTKrshSIA:10 a=F-eafH2JolcA:10
    a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10 a=Lf-vpJhqX20A:10 a=yyPPlNN4ldwpBWcy77sA:9
    a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753447AbeDSVhz (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 17:37:55 -0400
Received: from mail-pu1apc01on0112.outbound.protection.outlook.com ([104.47.126.112]:53913
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752725AbeDSVhy (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 19 Apr 2018 17:37:54 -0400
From: Dexuan Cui <decui@microsoft.com>
To: Jan Kara <jack@suse.cz>,
        Pavlos Parissis <pavlos.parissis@gmail.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Robert Kolchmeyer <rkolchmeyer@google.com>
CC: Guillaume Morin <guillaume@morinfr.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "jack@suse.com" <jack@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mszeredi@redhat.com" <mszeredi@redhat.com>,
        Robert Kolchmeyer <rkolchmeyer@google.com>
Subject: RE: kernel panics with 4.14.X versions
Thread-Topic: kernel panics with 4.14.X versions
Thread-Index: AQHT2Bw3Fl4TtFRnH0qUyqkfz/cZJ6QImzMg
Date: Thu, 19 Apr 2018 21:37:25 +0000
Message-ID: <KL1P15301MB000619E372AA3A2FD505ADA5BFB50@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
References: <20180416132550.d25jtdntdvpy55l3@bender.morinfr.org>
 <20180416144041.t2mt7ugzwqr56ka3@quack2.suse.cz>
 <9b11cfba-4bdc-8a3e-cd33-2f7e8d513bdf@gmail.com>
 <20180417121207.cs7eijrndovbplgz@quack2.suse.cz>
 <9cb08428-66ed-2306-d2f2-ae734863c68d@gmail.com>
 <20180419202302.vj2eu43hy77g5mv7@quack2.suse.cz>
In-Reply-To: <20180419202302.vj2eu43hy77g5mv7@quack2.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-04-19T21:37:22.8078412Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com;
x-originating-ip: [2001:4898:80e8:d::762]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;KL1P15301MB0021;7:RdcwL3pHlrJAqxaEpr2Hw6Yni9YqqFR/VHNJeFkHcTiAGEEftfUXwji0Cb3lzfLy0RQlTGUXqf/4kzzdNb1r5FNj1GlvxR1gthTSMbwPSXsPm4V32/1adEXBihTxvTzUiDbIhEduuUGI6cSeewvMEiGiGr4KyxCmNnP499bMyXuCKK9Io/GLWGrqFnU36T9TBfI++aUDBLjSjew5Vg6A+RVnS2r9mutzCLM5sRliCvfTTwzccfPCo7T/Kf6cpcZK;20:2SbA0s82S/gQ89GZIod1v6gN1N24F+pjfQNep5VKojK2D/3DeR9igBLDRH+Pm3lA/yAfVjesQQ/8s/heUVur4llnZeFjjMQwxG5MTnBHoYsfUbUoubf6zbLhT2a51IUlCqgC/rmDubU2wIGngbEEaEWiEXW51WlrgZvEIwH6o3Y=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7193020);SRVR:KL1P15301MB0021;
x-ms-traffictypediagnostic: KL1P15301MB0021:
x-microsoft-antispam-prvs: <KL1P15301MB00219817952A9CE47D72B707BFB50@KL1P15301MB0021.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231232)(944501327)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:KL1P15301MB0021;BCL:0;PCL:0;RULEID:;SRVR:KL1P15301MB0021;
x-forefront-prvs: 0647963F84
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(366004)(396003)(346002)(376002)(54534003)(10290500003)(446003)(11346002)(99286004)(5890100001)(46003)(6506007)(110136005)(81166006)(86612001)(54906003)(4326008)(478600001)(74316002)(8990500004)(8936002)(76176011)(186003)(7696005)(77096007)(86362001)(102836004)(316002)(8676002)(93886005)(2900100001)(476003)(22452003)(229853002)(6116002)(5660300001)(6246003)(1511001)(55016002)(6436002)(53936002)(14454004)(9686003)(39060400002)(25786009)(2906002)(33656002)(3280700002)(3660700001)(7736002)(10090500001)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:KL1P15301MB0021;H:KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
x-microsoft-antispam-message-info: 6vzCLpmnpsUzcVwVYKUBFmZ5RKnyO8+maFKp1OC4ZX2eXwEHLMswcrxk2+3oUnpicupmcY6ahRkkoKuYqIO8cHMTKVQW/MPQEOUjeWr4GDdnq5yKe2WoH+5IAz84lQBbV1RaVZlmR1SVCOz0b9kHvniteEMHm+HMGodvsu+NRzEwTJwW+TjUdd6jhL8NKnH3
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: e58381f7-159c-4dcd-9ae4-08d5a63dbe93
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e58381f7-159c-4dcd-9ae4-08d5a63dbe93
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2018 21:37:25.8779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0021
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

PiBGcm9tOiBKYW4gS2FyYQ0KPiBTZW50OiBUaHVyc2RheSwgQXByaWwgMTksIDIwMTggMTM6MjMN
Cj4gR29vZCBuZXdzIGd1eXMsIFJvYmVydCBoYXMganVzdCBzcG90dGVkIGEgYnVnIHdoaWNoIGxv
b2tzIGxpa2Ugd2hhdCBJJ2QNCj4gZXhwZWN0IGNhbiBjYXVzZSB5b3VyIGxvY2t1cHMgLyBjcmFz
aGVzLiBJJ3ZlIG1lcmdlZCBoaXMgcGF0Y2ggdG8gbXkgdHJlZQ0KPiBhbmQgd2lsbCBwdXNoIGl0
IHRvIExpbnVzIGZvciAtcmMzIHNvIGV2ZW50dWFsbHkgaXQgc2hvdWxkIGxhbmQgaW4NCj4gYXBw
cm9wcmlhdGUgc3RhYmxlIHRyZWVzIGFzIHdlbGwuIElmIHlvdSBhcmUgdG9vIGVhZ2VyIHRvIHRl
c3QgaXQgb3V0LCBpdA0KPiBpcyBhdHRhY2hlZCBmb3IgeW91IHRvIHRyeS4NCj4gDQo+IEphbiBL
YXJhDQoNClRoZSBwYXRjaCdzIGNoYW5nZWxvZyBzYXlzICIuLi4gdGhpcyBiZWhhdmlvciByZXN1
bHRzIGluIGEga2VybmVsIHBhbmljLiIgDQpUaGlzIHNvdW5kcyBsaWtlIGEgcmVmZXJlbmNlIHRv
IGNvcnJ1cHQgbWVtb3J5IGNhdXNlcyBhIHBhZ2UgZmF1bHQgb3INCmdlbmVyYWwgcHJvdGVjdGlv
biBmYXVsdC4NCg0KQnV0IHdoYXQgSSBzYXcgaXMgb25seSBhIGxvY2t1cCByYXRoZXIgdGhhbiBh
IGtlcm5lbCBwYW5pYzoNCndhdGNoZG9nOiBCVUc6IHNvZnQgbG9ja3VwIC0gQ1BVIzEwIHN0dWNr
IGZvciAyMnMhIFtqYXZhOjg3MjYwXSINCg0KU28gSSBndWVzcyB3aGF0IEkgc2F3IGNhbiBiZSBh
IGRpZmZlcmVudCB1bnJlc29sdmVkIGlzc3VlPw0KDQotLSBEZXh1YW4NCg==
