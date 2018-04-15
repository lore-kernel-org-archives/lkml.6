Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-539844-1523802932-2-17332514270424214041
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523802932; b=n/mBIwvaYdScndcslk71JTYYeHwj1WcDzN5VcDOYrkzI9BNBHL
    94wwrQSrs6dk6wPUvqYAA98up1stGYrTgap7qQ63WKqIQaQJzhQc1d11gMsNt/14
    MtrNqGAQwcnoZ+ZW86DOgzRpSbUHGcwmSeXFq9mmdZwcKMZLRLsHLCYjFO/9j6ll
    +7RnzWUyxkkxHz/vrs9Wd51yiXlpM8ZfmG+W9cK7NQUwzsHpaEkerxoyFDrLApaf
    ibpHiFyPJluzaW2N6E1SbGNA+XAnQPsnzOLE1opUjnTeo2F26lhn+zfqqVGDDrUU
    exf97sUV/n9t6SO0xCVTX8bnjkiFpaZbhS9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523802932; bh=C5ouaj96crVoiHxR/GZ44Ej3bLasMhP/yTdBmhdDgNw=; b=
    l5/jcL2YXP3h3QRgwx6bVYQSHAseIE3QH31j9XhNirfcg8bgNnGzQegeQWvyYeh3
    GqUBjgPFcAVrUomTFXtYRC6JU6A29iyCTosFt8W0u0jxQs7nB07y00k0L9qVep2v
    M8aO5w42S+FYhG6nShVr5R7c0EJJyf+FkIob1Gcl8bjEwb+aIJLF3g+vQ8LcQFlu
    jPSNe6lPoUkPGjslpElfr6Ww5auSLPKEK9hNrLE0pe3Lt76zIyi8Ent+6KG2TGRX
    7aBJMn35arwrYVUMTC4bY6WxSlVSPndogywndE5CuIiegQHyUD8yS1nRPwsBzAuI
    MO4FIyS31glEqEvzBh1D4A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FYSuag82 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FYSuag82 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLiFUVoeWelmi8BwImolKEicLiqVLQVGdg2K6TtkuBcK9/SA7bKHNMzwVzyZ/Luej+R2azZRer6UlORMa1MX5MQrB4REvlGuQjVrha/UVePZk/n6EgtN
    SYdbT+ZtFRCbF9XiNhf6uVvAKdPOleJHmhnnvBt/mTxGH/WoH3y4sTQX0KEavhlS8x6+uyH5QVamSeferECOlFxNUFsXfTU0XUsFfTWWCGDBTQZMEFcAiBI7
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=F7qjIGpQ-GgA:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=R67Vas8GdH-foX9elSoA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752527AbeDOOf3 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 15 Apr 2018 10:35:29 -0400
Received: from mail-co1nam03on0131.outbound.protection.outlook.com ([104.47.40.131]:62528
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751890AbeDOOf2 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 15 Apr 2018 10:35:28 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Mark Brown <broonie@kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Matthias Reichl <hias@horus.com>
Subject: Re: [PATCH AUTOSEL for 4.15 044/189] ASoC: bcm2835: fix hw_params
 error when device is in prepared state
Thread-Topic: [PATCH AUTOSEL for 4.15 044/189] ASoC: bcm2835: fix hw_params
 error when device is in prepared state
Thread-Index: AQHTz5gg98iVAtp40EeyV2UGyYPEU6P4Kr8AgAnEDIA=
Date: Sun, 15 Apr 2018 14:35:26 +0000
Message-ID: <20180415143525.GM2341@sasha-vm>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
 <20180409001637.162453-44-alexander.levin@microsoft.com>
 <20180409092724.GA11532@sirena.org.uk>
In-Reply-To: <20180409092724.GA11532@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1047;7:fkd2MQOtuAsmndFOvQBEy8ztR0396I8e0ZiA18Htn7vZvxbF2bIAr1M5lg57WKeiWHVhf3vZq6SwDjowAReCCL8G5D19JGlqH2z80At9Dv4UFq9lCgXyax7APDo299pKtq5y96CT4W4D+idMO/yyuSOHgOTvsWcikPAKvTf3dEWrAWQpgIjNIRQY8M5oKHfsD5TIdOp8j3yQ8UgrbmlPR7dj0PjT1eAIo4xs9cW5eRXseNbWl+V2/mgI7z9xhMCd;20:LmSOADXkltOZRHQl6SJBwqlnDZTFFHkSqzZcvf/+Hg/g8xuIIXYDCNCF/UU9wYud5liqrBtU7FrOWc7fcBetHqnw2yZr9Hp92FKAFkI3dlKIFwCq46MixWIodnyqCeBOrF5gNuBmpbu+r6G1QMEzuy0+++n3ONoEVVP61ndrtcs=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1047;
x-ms-traffictypediagnostic: DM5PR2101MB1047:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1047FB375C0FDF9C5A3472FCFBB10@DM5PR2101MB1047.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231232)(944501347)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1047;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1047;
x-forefront-prvs: 0643BDA83C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(39860400002)(346002)(39380400002)(396003)(366004)(199004)(189003)(68736007)(5660300001)(97736004)(25786009)(26005)(2906002)(10090500001)(3846002)(86362001)(6116002)(478600001)(2900100001)(10290500003)(229853002)(14454004)(72206003)(6486002)(105586002)(66066001)(3660700001)(33656002)(3280700002)(8936002)(81166006)(81156014)(53936002)(1076002)(54906003)(9686003)(6512007)(8676002)(99286004)(76176011)(102836004)(86612001)(476003)(33896004)(11346002)(446003)(6506007)(6246003)(305945005)(33716001)(7736002)(4326008)(22452003)(486006)(6436002)(186003)(5250100002)(106356001)(316002)(6916009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1047;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: lsmyspcz06rVpNN53JFhdMwQVi+sOCeVyjn6oIQ18yUfSp1Kv5YqaQzIjoVUNEdK3mjXCRRSvOHfZEcq4VgAim9cUy01Nc7Y0SmgUZ7S4iOoFrIjwBTwnSJHrvKIdUNtejZ+VabHCiUD6TSngIqVEgDGLRhimo7az+EMX9zVOm8/96CUnGjuBSP2Mk+9qwgb
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <68A8333D2D313F45B4D0491AAD956A6A@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 523f419a-8ac7-4e47-7ce8-08d5a2de215f
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 523f419a-8ac7-4e47-7ce8-08d5a2de215f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2018 14:35:26.7487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1047
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 09, 2018 at 10:27:24AM +0100, Mark Brown wrote:
>On Mon, Apr 09, 2018 at 12:17:20AM +0000, Sasha Levin wrote:
>
>> ---
>>  sound/soc/bcm/bcm2835-i2s.c | 20 ++++++++++++++------
>>  1 file changed, 14 insertions(+), 6 deletions(-)
>
>This is a relatively big refactoring, including moving things from one
>userspace operation to another.  I'd not be 100% sure it doesn't have
>any extra implicit or explicit dependencies.

I'll remove it, thanks Mark!=
