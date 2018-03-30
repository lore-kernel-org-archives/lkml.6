Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-278094-1522450747-2-2442207428226975792
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522450746; b=FHpKJK0BDa5cKuA87HyRqEBiQmWDyUgNfKimPPtXHfVDvNOuFB
    9NdUKQWZ3ThWsviK+aa2e0Fiozg/yBURt8xTCo6BsFDzwcPENPTNgybCmFRicqL7
    Mz+igQhXmxmPgEjfVlO5tDBQAfRydB3UsF0EMjBxZ9i8uP3PAK4CxigFyDxddrw4
    enbArA+fI+0koyZ85lASXD+6LIjU5nZaewEMkIMaeNrkFLStDH7p9lLW2sp0Ylj0
    YRS99JLoMPn2IRvfTpxsv/6TKcjQjiwvJ4UXXClsf5rkTmvxWojE4v6mSIdef39s
    8TuGNxMQ+cr/n7ZWt+9NxSuxnS7JWiUGYtLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1522450746; bh=AkCMDZ6qnKxA3H4a7WbyUOkv8FrtIV6SLCtSKl5qSq4=; b=
    h+8SXCL9hilIWo4Ji2slH+K4fPqfGQ+kF94RKI/1HxLVv0piOnh2NG3pkKK4YfkX
    88b/NyRXHa1jIW7ghGQ6V9gqCl8kg87/SnagGX36Rk+4USq1/cUPX0wP7dhJoNGj
    pbSxbPIUQo3+obNeP60DquV8eoAXKrVvfnd/1x4DfgF003pDHZy5z5VoIxAzInFI
    ULY1uok2lwsLzvGHEZkOGqI+UEUnGYu/h5lZpMGw2AKYVvNu2fJ08Zeq8E36A5SJ
    3ykuYY201RaJPsuzIPwdnYlXZ+czabgCf4fRfbGrvjB3de9G6fh+UeQv2JLl/w7+
    VGxAmuSDWOH0dqZ5WjiVQg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=impinj.onmicrosoft.com header.i=@impinj.onmicrosoft.com header.b=jS7a78Fd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-impinj-com;
    dkim=permerror (syntax or domain error);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=impinj.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=impinj.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=impinj.onmicrosoft.com header.i=@impinj.onmicrosoft.com header.b=jS7a78Fd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-impinj-com;
    dkim=permerror (syntax or domain error);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=impinj.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=impinj.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDP+LZoWz+9X3B5gow7Gzp/wLs3B2wTwNTxf/xD0n4RU4UaafMLnpGSPIqXvbMYAc7Y8UMZ+gv0Ok68nVPnvli8npB+jzIHd4T1J81TMYig+ynctgvyP
    ISnpdeIJhc/cvUFPur/2w7ThTEbcmLO8Eg+01ciAyu+SAiUSsfZOKPUg9klQlW1+i2At7nkJRTfcc7dIntLZY6tx0g9kpXLDQk2jTMsTIn8PuXsRo/3ZroZm
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=3__JM4gSSC0A:10 a=IATMpVkM7q4A:10
    a=mnh4nG2Pd10A:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=v2DPQv5-lfwA:10
    a=T61J-ygrL8wA:10 a=UqCG9HQmAAAA:8 a=voM4FWlXAAAA:8 a=Fx18wfuGAAAA:8
    a=Mst4_T5HOfM4pvpAw_IA:9 a=QEXdDO2ut3YA:10 a=IC2XNlieTeVoXbcui8wp:22
    a=d_yYD_Ij998iWz0U_B8y:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752678AbeC3W7D (ORCPT <rfc822;greg@kroah.com>);
        Fri, 30 Mar 2018 18:59:03 -0400
Received: from mail-cys01nam02on0093.outbound.protection.outlook.com ([104.47.37.93]:11168
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752357AbeC3W7C (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 30 Mar 2018 18:59:02 -0400
From: Trent Piepho <tpiepho@impinj.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alexandre.belloni@free-electrons.com"
        <alexandre.belloni@free-electrons.com>,
        "pure.logic@nexus-software.ie" <pure.logic@nexus-software.ie>
CC: "shawn.guo@linaro.org" <shawn.guo@linaro.org>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "bianpan2016@163.com" <bianpan2016@163.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "guy.shapiro@mobi-wize.com" <guy.shapiro@mobi-wize.com>,
        "Frank.Li@freescale.com" <Frank.Li@freescale.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
Subject: Re: [RESEND] rtc: snvs: Fix usage of snvs_rtc_enable
Thread-Topic: [RESEND] rtc: snvs: Fix usage of snvs_rtc_enable
Thread-Index: AQHTxvKZmv6BIX/0UUiB/ib/Q5SvIqPmc6QAgALz14A=
Date: Fri, 30 Mar 2018 22:59:00 +0000
Message-ID: <1522450739.10662.278.camel@impinj.com>
References: <1522264445-2398-1-git-send-email-pure.logic@nexus-software.ie>
         <1522282337.10662.268.camel@impinj.com>
         <f380bc29-c8dd-5c20-efc4-ffc0ad69b8d6@nexus-software.ie>
In-Reply-To: <f380bc29-c8dd-5c20-efc4-ffc0ad69b8d6@nexus-software.ie>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com;
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3658;7:2gp7CE6dkF9mOA6W5ewbLCH/37F/90HdZgnSq2qkNTml/0pmZNmPS/4RF+iWgoYDTqsVdvReIpE9MyKYd3IMyPnZLvN425ojLZrbiz5zrRUmDFiAx3QFv8gqb8HAUnMBwvGOk6wUoUdkQHw7Qk8cz1hJzQBrVMjID26cjMAaxac41IOHJtuJAa8jYzh6rKiJnyPmaUqE8bAyVnQmsPKHSH8RMUvWZ07mN7WNLK+FUW+fGXnyPIXJqx7snwgL8sw8
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 10c5ccd9-11b5-4704-75dd-08d59691d362
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3658;
x-ms-traffictypediagnostic: MWHPR0601MB3658:
x-microsoft-antispam-prvs: <MWHPR0601MB3658F0C4EE5BF519E0CD34EDD3A10@MWHPR0601MB3658.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(189930954265078)(219752817060721);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHPR0601MB3658;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0601MB3658;
x-forefront-prvs: 06274D1C43
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39850400004)(376002)(39380400002)(366004)(346002)(396003)(51444003)(377424004)(189003)(199004)(478600001)(14454004)(3280700002)(103116003)(3660700001)(2906002)(966005)(2501003)(186003)(106356001)(105586002)(5250100002)(110136005)(316002)(54906003)(7736002)(102836004)(45080400002)(305945005)(36756003)(7416002)(8936002)(66066001)(53936002)(59450400001)(53546011)(486005)(6246003)(6506007)(6436002)(8676002)(8666007)(26005)(486005)(6486002)(2616005)(68736007)(476003)(5660300001)(6306002)(6512007)(81156014)(11346002)(81166006)(575784001)(99286004)(3846002)(6116002)(4326008)(446003)(86362001)(229853002)(2201001)(2900100001)(25786009)(97736004)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3658;H:MWHPR0601MB3753.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: wAI1pYSifSdMyD6f5xU1QiTEL0ikSOqob+Kr00w3NALmRpiuuUEotelgzFHuVNNF1Rl4udzpRt+/ev1S5hFuJTRJLNc3jAtnFDEaQIKCCGuZmnHMnZvCFCw5g7P9pLJCv0Htu+ZnA92cM0SPg/xiSG1S+oWQndVzxrqzaNezBIMLSXl/cbnUMkvPGtQKOgDKOQM/9bEekXG9ia6t2WzrODFxKHPHT9Kc5LQ8HwIo9GtxFNjfwj2yUfyfz9iFrdd5loIYuEU3YfDs1n8+QZDSOaTODlRqVbwTK5dyskveTbTiVZpFeDCZy6b92AfLPROvbksJmjU1GjH4ALZ4sDlwetx1z2eKP4L9K7qP7NFPt3ZgasCeCe21UfioWInS0RnVKgPizgrM3bHek0OtvOXOy14tbgT1VoKcC+QPhzOQ4VI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4DC1D6F93DC0B448862C762FFECBF649@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10c5ccd9-11b5-4704-75dd-08d59691d362
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2018 22:59:00.2881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3658
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gVGh1LCAyMDE4LTAzLTI5IGF0IDAyOjUzICswMTAwLCBCcnlhbiBPJ0Rvbm9naHVlIHdyb3Rl
Og0KPiBPbiAyOS8wMy8xOCAwMToxMiwgVHJlbnQgUGllcGhvIHdyb3RlOg0KPiANCj4gPiBJIHNl
bnQgYSBwYXRjaCBhIGNvdXBsZSB3ZWVrcyBhZ28gdGhhdCBhZGRyZXNzZWQgYSBzaW1pbGFyIGlz
c3VlLCBzZWUNCj4gPiBodHRwczovL25hMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5j
b20vP3VybD1odHRwcyUzQSUyRiUyRnBhdGNod29yay5vemxhYnMub3JnJTJGcGF0Y2glMkY4ODcw
OTAlMkYmZGF0YT0wMiU3QzAxJTdDdHBpZXBobyU0MGltcGluai5jb20lN0NiNjIyOTQwODAyZGY0
OWRlYWM0YzA4ZDU5NTE3ZThkOCU3QzZkZTcwZjBmNzM1NzQ1MjlhNDE1ZDhjYmI3ZTkzZTVlJTdD
MCU3QzElN0M2MzY1Nzg4NTIyODMzOTA3NDUmc2RhdGE9ZHMwb2ZwYlRxckhCakdBMThOMzQzY0pK
OXN5MlNUUTlaelN4SDJUVXl6RSUzRCZyZXNlcnZlZD0wDQo+ID4gDQo+ID4gRG9lcyB0aGlzIGFs
c28gZml4IHRoZSBwcm9ibGVtIHlvdSBzZWU/DQo+IA0KPiBJdCBicmVha3MgdGhlIGVuZGxlc3Mg
bG9vcCB0aGF0IGhhcHBlbnMgbGF0ZXIgb24gaW4gdGhlIFJUQyByZWFkIHBhdGguDQo+IA0KPiBU
aGlzIHBhdGNoIHRob3VnaCBpcyBhYm91dCBmaXhpbmcgdGhlIGJ1ZyB3aXRoIG5vdCBoYW5kbGlu
ZyB0aGUgZW5hYmxlIA0KPiBvZiB0aGUgc252c19ydGNfZW5hYmxlKCkgY29ycmVjdGx5LCB3aGlj
aCBpcyB3aHkgaXQgc2hvdWxkIGJlIGFwcGxpZWQuDQo+IA0KPiBUaGUgcmlnaHQgZmxvdyBpcyB0
byBoYW5kbGUgdGhlIGVycm9yIG9uIHNudnNfcnRjX2VuYWJsZSgpIGFzIHNvb24gYXMgaXQgDQo+
IGhhcHBlbnMgYXMgb3Bwb3NlZCB3YWl0IGZvciByZWFkKCkgdG8gLUVUSU1FRE9VVC4NCg0KVW5s
ZXNzIHRoZXJlIGFyZSBib2FyZHMgdGhhdCBkb24ndCBlbmFibGUgdGhlIDMya0h6IG9zY2lsbGF0
b3IgdW50aWwNCmFmdGVyIHRoZSBrZXJuZWwgZHJpdmVyIGxvYWRzLiAgSSB3YXMgY29uY2VybmVk
IGFib3V0IHRoYXQgc28gZGlkbid0DQphZGQgdGhlIGNoZWNrIGluIHByb2JlIHRvIHByZXZlbnQg
dGhlIGRyaXZlciBmcm9tIGxvYWRpbmcuICBJZiB0aGUNCnBvc3NpYmxlIGRpc3J1cHRpb24gb2Yg
dGhhdCBpcyBhY2NlcHRhYmxlLCB0aGVuIGl0IGRvZXMgc2VlbSBiZXR0ZXIgdG8NCmZhaWwgdG8g
bG9hZC4NCg0KSG93ZXZlciwgSSB0aGluayB0aGF0IGV2ZW4gaWYgdGhlIGRyaXZlciBmYWlscyB0
byBwcm9iZSBpZiB0aGVyZSBpcyBhDQp0aW1lb3V0IGF0IHByb2JlIHRpbWUsIGl0J3Mgc3RpbGwg
cG9zc2libGUgdG8gaGFuZyBsYXRlciBpZiB0aGVyZSBhcmUNCm5vdCBsaW1pdHMgdG8gdGhlIGhh
cmR3YXJlIHBvbGxpbmcgbG9vcHMsIHN1Y2ggYXMgdGhlIG9uZXMgSSBhZGRlZC4NCg0KPiA+IEkg
dGhpbmsgd2hhdCB5b3UndmUgZG9uZSB3aWxsIHByZXZlbnQgdGhlIGRyaXZlciBmcm9tIGxvYWRp
bmcgaWYgdGhlDQo+ID4gY2xvY2sgaXMgbm90IHdvcmtpbmcsIGJ1dCBpZiB0aGUgY2xvY2sgZG9l
cyBub3QgdGljayBwcm9wZXJseSBhZnRlcg0KPiA+IGxvYWRpbmcsIHRoZXJlIGFyZSBzdGlsbCBw
b2ludHMgKHNudnNfcnRjX3JlYWRfdGltZSBmb3Igb25lKSB0aGF0IHdpbGwNCj4gPiBsb2NrIHVw
IGluIHRoZSBrZXJuZWwuDQo+IA0KPiBJJ2xsIGRpZyBvdXQgeW91ciBwYXRjaCBhbmQgZ2l2ZSBp
dCBhIHJldmlldy4NCj4g
