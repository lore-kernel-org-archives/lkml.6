Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2139197-1523045205-2-2097188294401352417
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
    1523045205; b=TkGzYhR/TQE/5FFMUsUAE4TNr97lgJvsvlWm5MSnMsfNzIH9+9
    ZWxpl0RI4hguJOMB2VRH+KhX+r7vYYJIsAdV9IQ6OS03zb1yWwUAI+ed/SusWMrL
    MLJe0DV17vtAAv6ImvlQ23csC9c1obnORq5YJGAwMFlpzqe9etdMHzIFlUAurqPf
    DYgnmXnwpCzu8ECUNWEDosDoJxsEB+2hWy7piuD93DnO/JRFuH0Y1RzeVWxgPg/S
    CSI5GJYzxtPpsi8dwdaoMPtxFp3xQCgTqTd97+7dcfNJhfnruJBDFx+4uOFMjoRr
    5TnhT3a9IFLVSyFg9wbHa4HTM4ZFG5eIPtYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523045205; bh=Sq5YoCqfIA
    H+iNV8VxV4haZQOg5Zs/3sCm5+XmGHT4Q=; b=FbHiVMO575RMIHSC9YkBG/HUfs
    Sme0h/KDOZkq9uP00/ofgb/qH9jDWEeeJes0TygJzY4P9aupKoQ2Je1tEi0vPcpC
    d4PPCc0qN4yyG+kAtp3J596xGMZggr0m1gFk9Qqeu3PQHTBlFOaW3d18v60gr8t5
    DYDCLXrp4gNFcbQb19yHj1qvNNKRSG8ShPd3GhuRDsnvg5w/Y/6tNj+h4RrVB021
    Nlt20J92CG0PTT+A1e5k2kpH0HTPcQUTxeVt7ZyiMPZttZvmfGoCwsWNCBTQFX6M
    Wmcgjbs2aZyMA3Tuwk9bN3XZS53GlkicVZpXpIKOjV9x9CE30R0ihbD1VR7w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BoXSZcGh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BoXSZcGh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGJ6Ltl3s0ZInfgRbseZK1VnFnriOKUbKtWKVLLv6HhnW3dYKpGVQoV7+iCekGJ7DRrq71FjtVCkbVrTsp67t+KBAwcP46jr8+RRD58ajvyZ/AUqv2SR
    7j5JhofT0VSHU1ZlSLUzqGyVvLzeFgNN/2k+6rcP0E2TNnxHZOIctFOENZsB3QdExQ5a9mXXEAn0RgDoZAS3H9Fgxsbzw0Sfz/hFJi/47lM2I/hJZC4Leaq/
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=LzwyXZqj8egA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=21XtWswpCqTP4RPFR6QA:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752045AbeDFUGE (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 16:06:04 -0400
Received: from mail-sn1nam02on0116.outbound.protection.outlook.com ([104.47.36.116]:9713
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751934AbeDFUGC (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 6 Apr 2018 16:06:02 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Sasha Levin <Alexander.Levin@microsoft.com>,
        Ondrej Zary <linux@rainbow-software.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] i8042: Enable MUX on Sony VAIO VGN-CS series to fix
 touchpad
Thread-Topic: [PATCH] i8042: Enable MUX on Sony VAIO VGN-CS series to fix
 touchpad
Thread-Index: AQHTzeKu0wIJ/ejyWUaRTOhQ0X5lmw==
Date: Fri, 6 Apr 2018 20:05:59 +0000
Message-ID: <MW2PR2101MB10344E66701305F65F39EF24FBBA0@MW2PR2101MB1034.namprd21.prod.outlook.com>
References: <20180403170810.32005-1-linux@rainbow-software.org>
In-Reply-To: <20180403170810.32005-1-linux@rainbow-software.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1002;7:2PF6uD7h9Pj+fv8Cv0xhmheFotDNMIM92pSLL1/Oq06h1spgVTQuVJSKiG/FxR3S3ItX6iFXXp39vMNgwXqkb1+MYMpJ54faY21YhJmUR2WDUqVhcblyTd+IimupftHpiOYXa9oRrnyGrL+6xNUiBgHB4JgSlsxjERMSjpBa+I0MqocOM3pTrx5nxdqaXJOQD/wf/WgahjVczHLYaVvzEWXYjvAIlAXst0VlQPdp1e40aCntZVNGC7suoKJEfmn5;20:qhy511iFySs9zLY9KgiXwBZYrdFOJb2AQYhr8sT9qidBumckyObcYEf1u/NBmeeXM7v6F7Yn6HfUZ/VEafYzIcWQNOg8eXrn5PHYJ/BBFFXaKN/YR97Qg4f7Un79MhnBhx1AUiIW9xjl8CYBSghC9DDraocJMBFHRFpBcdJ6pAU=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 6390d009-c541-4715-4777-08d59bf9d0bd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:MW2PR2101MB1002;
x-ms-traffictypediagnostic: MW2PR2101MB1002:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1002BB69CB911FD87F260270FBBA0@MW2PR2101MB1002.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1002;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1002;
x-forefront-prvs: 0634F37BFF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39380400002)(39860400002)(346002)(396003)(189003)(199004)(3846002)(22452003)(6116002)(446003)(305945005)(6246003)(86362001)(6506007)(26005)(11346002)(3660700001)(102836004)(3280700002)(476003)(8936002)(55016002)(14454004)(72206003)(53936002)(486006)(76176011)(33656002)(74316002)(8990500004)(10090500001)(81156014)(81166006)(39060400002)(7696005)(8676002)(478600001)(9686003)(5660300001)(6436002)(25786009)(106356001)(105586002)(4326008)(97736004)(110136005)(54906003)(10290500003)(99286004)(68736007)(7736002)(1511001)(316002)(66066001)(86612001)(2906002)(2900100001)(229853002)(5250100002);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1002;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: DZOrtseGFswfPQ8IL5uMOlPZkQ9WnJ/YutcbUdMsY17Lu9mEmKcNHQNSLcP9llgxWBdIvWJt7K0enwFmcid58skfW/F3tSlXvqJzfHLKuREcKfwh8LIdbAhHCoafM2Um8pTa+qkbSsQn174+79XwGYT5XZ/6aEonJlsOAWk0mWMoTwRrqOWdHbXYPu8WeRpVREUc4E7AUo9FGV9n3qdNv1OoUjOG1WkIjAGDyXgXYX92oR2idjoWXlmmRzVd5uEK0tyi02UPxzeCYD5z6xhBeIuFyu+z3e1NNgsR1HE+1oZ3oXimD7FuUUI0gfL/iWMTN/LlqRNRVHl/psN6Ro/FjCfusNJ8t0DgKpBFzcN8DJlgUO97vJdJTY5uR9RdLcS+EhrZdtq2HjXcsYMF62tXf5eXKpkc/iFZdV+tNVRv2DA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6390d009-c541-4715-4777-08d59bf9d0bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2018 20:05:59.2889
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

This commit has been processed by the -stable helper bot and determined
to be a high probability candidate for -stable trees. (score: 24.5527)

The bot has tested the following trees: v4.16, v4.15.15, v4.14.32, v4.9.92,=
 v4.4.126.

v4.16: Build OK!
v4.15.15: Build OK!
v4.14.32: Build OK!
v4.9.92: Build OK!
v4.4.126: Build OK!

Please let us know if you'd like to have this patch included in a stable tr=
ee.

--
Thanks,
Sasha=
