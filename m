Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2092709-1523045180-2-12539903621289869876
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523045179; b=aDbQZ1VapdborlA2U6oyd9pabbTxlm5e1NNOLmcu3RDPiSr3UP
    3/LPCg2Fsy6iz0tj+qlB5cA/jyT29rf/58eHqriaAUgK7AeXZHWtnfuHfGYBbiXR
    SjRdEegy+OxOQI6GIMfS/WuGmyT2vzLfZ0UfDOZSNI9KAiWdLeOvYfBP7r4V8TWE
    9KRiCATdNAim66ttoA0XI0Psig5V5wf77TVwIqw1UEYwN72gp0zw1V3VYz2I7Zvn
    fY28RW9Zp9B5e05yq4nt1euvPeN6PtP2noPr+6LPDiyjURHqiBJYwbjLYHSIcbnd
    dSTCxG8kztYsvAM/wMY7gVGbGvRbvsjRHVeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523045179; bh=rxvMJ4gGvu
    Muvobn/m4TU0tsVZ4ltx8e2Y5Ji6TF/rA=; b=efoAaWgTrcxcBSiutx90dat8en
    LSy75wbVP2BHY8t2VokPrTZz/xzs6xHoHCIgU4dL1Nr4/GMKEgEILtZU/yQ19i7e
    2gDdDmDlscpCUpRWUO/+FGRBb7LyBHJjNsoTKZcW2TKtan6xD3XGD1DHfrRfl+9v
    qxDHXXFF1TVURR8Z/WQ74JmG3+SdYkChKWSGtomi+NTyoF7p60jmKsBATi+xqCv/
    IsMuAd5mX+ai0O9EtLXu8W45t0FXaEbH18ysEGlB6IEDoMZGipe42GoD1IZx4Cdi
    qAvnHrMonWnajIK6S9cJ+y53Jaq4oMZ2EOiaF3zWwVYsSo6dLnDoHBiKwb8g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=X1SF6/zn x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=X1SF6/zn x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLJ4xoHyt6svk8iC9h0fYRbw8WevGJboVUzlrMuEJobey79AujrKPDjuRGItsDjimODL1/Iah9oFCxp2ZOnxpn3yMbjM8zgwsMiVyTBFWJxxAGxat9OD
    ETM70EnX0X3KfsY6WHuMi1RJO8SCVBAwkI2AmfNuNf4yPmrxv+CrTVW3jSwrK6fGAGrgYUrOI4/kLiP4O5nAkcSLJF+V4lWcBjxMJ4nIz681iHnWIR0dlK89
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=0_GsVXFXKHgA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=GebRvfjJWkHuGaxPhSIA:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752219AbeDFUGR (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 16:06:17 -0400
Received: from mail-sn1nam01on0120.outbound.protection.outlook.com ([104.47.32.120]:62865
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752132AbeDFUGI (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 6 Apr 2018 16:06:08 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Sasha Levin <Alexander.Levin@microsoft.com>,
        Tejun Heo <tj@kernel.org>, Sitsofe Wheeler <sitsofe@gmail.com>
CC: Jens Axboe <axboe@kernel.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] blk-mq: Directly schedule q->timeout_work when aborting a
 request
Thread-Topic: [PATCH] blk-mq: Directly schedule q->timeout_work when aborting
 a request
Thread-Index: AQHTzeKyk+HRcIvMxECvj+GyIAZB3g==
Date: Fri, 6 Apr 2018 20:06:05 +0000
Message-ID: <MW2PR2101MB1034DFCFF7B01436E0A15E13FBBA0@MW2PR2101MB1034.namprd21.prod.outlook.com>
References: <20180402220458.GJ388343@devbig577.frc2.facebook.com>
In-Reply-To: <20180402220458.GJ388343@devbig577.frc2.facebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1002;7:1SvK6OYHUC2+B/w9tseZOdU4EYqWB5LzrhthLO+hDM1SmiL2eE1vqMaGnjkchm/PVIQ3iG2ORZsruMZmnwFoRXiqBXI1nBFlzDdArti/Xs+RjRZnXtnnnkS0xzx8Gd6XkhbpI2hPY700BCofnjUeCdxW1Ky5k7ns/APVRjQgu3E8ok/KkbIf7q8LCDsRQ/bPEn7U0QAjGw7ZhoKgA55zjW7ENLP7q1BwuEinucj+UeQNUfeJkUbhq0f+KysWrZp/;20:U/+6odQHSl1Az+/39+0gW/p4Cf5PO5yajkTOVmGEV4s7BZWVklxEus6ThD/mKRP+P6Vz+3NzAe239HZGbGWJT+hdKI86DZa6Oepnpfkx5xt7m9cKf79ELuDpMoOwiu+ZEiMXVgQdM/OzpNvW+2wdx0vKYCKD3DYyVe1+bQJ07bk=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 6f23a27b-152a-4857-3ccf-08d59bf9d4a9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:MW2PR2101MB1002;
x-ms-traffictypediagnostic: MW2PR2101MB1002:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB100223882C98DF833FCF7EFAFBBA0@MW2PR2101MB1002.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1002;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1002;
x-forefront-prvs: 0634F37BFF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39380400002)(39860400002)(346002)(396003)(189003)(199004)(3846002)(22452003)(6116002)(446003)(305945005)(6246003)(86362001)(6506007)(26005)(11346002)(3660700001)(102836004)(3280700002)(476003)(8936002)(55016002)(14454004)(72206003)(53936002)(486006)(76176011)(33656002)(74316002)(8990500004)(10090500001)(81156014)(59450400001)(81166006)(39060400002)(7696005)(8676002)(478600001)(9686003)(5660300001)(6436002)(25786009)(106356001)(105586002)(4326008)(97736004)(110136005)(54906003)(10290500003)(99286004)(68736007)(7736002)(1511001)(316002)(66066001)(86612001)(2906002)(2900100001)(229853002)(5250100002);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1002;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: y8YwJsJwjzlMM7qulmYyhuuVuoZ0+HL2cWiiKyyIUZ2Fouz8oSwGcfF+yyQmPkznW8fXOLujp6haoUoedaYUe9+BGLaDTXQ02WtQd8QOHdUawwArBU9wiGZKpYSrswRhWHif4OG8so3nQ2+JjzL5bDyEPbhKcqxOfqcgnAiYD1UOs2EMnqCVtMcDk2Ab2/c1SeYrKbw+7AlsIfz/A3e31YFuMmTAs9U1F5Z6irLpVvgjN6ID0pnwGkUWduqU4SF6tCQBej+KFco01qsrG/MDzmAlNij7la3OHKhP0Q3aqH6QJ/6b3aGrkUxJ4/x5+vB6VruDi3VjkK4IJkEE/B20qDIqdhEyMsGDjF/aNwkW+fGbBvdRqeErOnvmb5x7wG5bVVt5vsCXH/AEQH5k7sAxy1nD6diesfOPoTnkpQ8LknI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f23a27b-152a-4857-3ccf-08d59bf9d4a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2018 20:06:05.9285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1002
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

[This is an automated email]

This commit has been processed because it contains a "Fixes:" tag,
fixing commit: 358f70da49d7 blk-mq: make blk_abort_request() trigger timeou=
t path.

The bot has also determined it's probably a bug fixing patch. (score: 98.77=
80)

The bot has tested the following trees: v4.16.

v4.16: Build OK!

--
Thanks,
Sasha=
