Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2487537-1520280251-2-5173534836254642125
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520280250; b=ZmKCg4XD5fIXtrYSR5q4SqX9b0jUUYQUnrNnxE8oOOl3Gqn
    6ft/pPdc8iz0gkGuf7J5kYlQxKv3wdRPY30ls2jJLU5PXmyUOYpPnyks026lVW0K
    Y6eFEOluWY0iximHG8S+ZRy4SEmge6ftBao2PYy8NAGcDW0m/OrY1jcT0FSB2vRV
    dUg0NA9O3evzmDVDeG0nZahnOz47X5EpTLJUbaRtGTfNa+rKaRsQMxVipbg3lXBt
    zG86yjoLnzyEfbjq1cPr/ETqF3mQvdJCNQ1zP8NirifLIg6P9FUHPcvddu9kw4hw
    V8OxtQTnDG/ymmMv9L4JsY67yVm4E3bs3VNVlQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1520280250; bh=OfYYsGnAswfN2RklKbBXV3IJW0hXqTzT7K/u8i
    3bSTs=; b=S4uqvl6AB4bVkhMlcM4sIH/bdFNnqM77CptDopn/KsOHTu1ne4nzKq
    eE9TQuTceDhx9kqpVD+QfhtuDz6dI52KiplB1k8asfVvHatU9WNd8MnJS5qLi+yx
    UDRGkGRiRv6tdjI8NOSqkFLKuq0xzEwU5BsAXOEaAVcEGSBcBAa4n/XSDFsu0KhE
    2Vnu+N+0J5i5tV/tBgCf2Hn35M+e+XK8vveyheYt4lynh5i4TPh0M7roK7MycIPD
    yOIX4I4T4sKQprs/MI5RTOPLRNgp95Pael70tg5miy1MTUiVEVqUv6puUGv3Pn/G
    ld9xnlJYrTYcVun3ILaGKX5aqRm0Rs2Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZfOAuMD4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZfOAuMD4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751462AbeCEUEJ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 15:04:09 -0500
Received: from mail-co1nam03on0112.outbound.protection.outlook.com ([104.47.40.112]:45285
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751275AbeCEUEH (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 5 Mar 2018 15:04:07 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Alexander Kochetkov <al.kochet@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH AUTOSEL for 4.9 124/219] ARM: dts: rockchip: disable
 arm-global-timer for rk3188
Thread-Topic: [PATCH AUTOSEL for 4.9 124/219] ARM: dts: rockchip: disable
 arm-global-timer for rk3188
Thread-Index: AQHTsz8L1flxeEzS70aMpxWbN8EqTaPAuA4AgAFbrAA=
Date: Mon, 5 Mar 2018 20:04:05 +0000
Message-ID: <20180305200404.q6cnkl5updv5qljj@sasha-lappy>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
 <20180303222716.26640-124-alexander.levin@microsoft.com>
 <D6AE445D-6A73-4AFE-8642-6F5ADF14D084@gmail.com>
In-Reply-To: <D6AE445D-6A73-4AFE-8642-6F5ADF14D084@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1080;20:rH605CgoH5VRler9e9Hnt8EXWvS3XurjkITzguGJ+f8+JicIA3sX7FVIcWgYpdPhd8KegIARHTQ7/JH0301GyrsIT6qFYVdxK8nflSN8IRwjYl2/bvbVoRUcmntKGoeIl1fYqO/Arp4dn0fH5W9hiRpTuNNIn+JTPaJmSTrm1yM=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7499c981-9865-432e-2b04-08d582d44021
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603322)(7193020);SRVR:DM5PR2101MB1080;
x-ms-traffictypediagnostic: DM5PR2101MB1080:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1080D51EA6ED5B2AC4EBF79FFBDA0@DM5PR2101MB1080.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR2101MB1080;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1080;
x-forefront-prvs: 06022AA85F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(346002)(396003)(366004)(39380400002)(39860400002)(199004)(189003)(6512007)(9686003)(97736004)(14454004)(6436002)(6246003)(22452003)(305945005)(72206003)(7736002)(5660300001)(54906003)(76176011)(106356001)(6916009)(2950100002)(6486002)(99286004)(53936002)(229853002)(66066001)(81156014)(81166006)(1076002)(25786009)(39060400002)(10090500001)(105586002)(316002)(33716001)(86362001)(575784001)(10290500003)(26005)(4326008)(186003)(68736007)(3846002)(6116002)(8676002)(478600001)(2900100001)(33896004)(3660700001)(3280700002)(86612001)(8936002)(2906002)(6506007)(102836004)(5250100002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1080;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: r4uXXMaluNQVA0cCqEpur568PpkHWToeiqkv6DBWlvSEFzEFxgEQoYYq6XaHpfJcCSP9VDfG4Gj1Qdk3LveDx4InZJXuQjqR8YQTaHEJ+EETKsgf4M7i/iZasT9sDsyLW4B2pHYUxveAp8ocfSJ6CPUDirSUmmrvDIU4DdpYoXHxo8UWOREeTwLqilIL6XBBusJNVsZ5HGoRDXuYKcpZwETCYj5gUiU7Tk/N96fqL2s5jjs41TwVc5R2xzTCZ7Uqns6ZUq98e6v+tjHLPQpuS0+WgJfD88Bdhkt4ZJM6Sh7dPG+J0Rb3swz75b0rw6dHpaw058SQkl5QK44S9SgCnw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <11BF2216015E014A8609B1E741DF88EF@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7499c981-9865-432e-2b04-08d582d44021
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2018 20:04:06.0704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1080
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 05, 2018 at 02:19:42AM +0300, Alexander Kochetkov wrote:
>Hello, Sasha!
>
>Following 2 patches must be applied together with the patch:
>5e0a39d0f727b35c8b7ef56ba0724c8ceb006297 clocksource/drivers/rockchip_time=
r: Implement clocksource timer
>627988a66aee3c845aa2f1f874a3ddba8adb89d9 ARM: dts: rockchip: Add timer ent=
ries to rk3188 SoC

Hey Alexander,

A bit too much for stable, I'll just drop the patch. Thanks!

--=20

Thanks,
Sasha=
