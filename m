Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3992186-1523245036-2-13110137784925536637
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523245035; b=pvZmR//DojJoe1UpT5beh/gzmYEJLZfcY9MamqtS4rv8ch39eW
    JdV8dYaJfngkhueQt7FaXDGJIVTqGCg6Hg/NhDHqAna4kH1ZehpQCajO8Us1/Vkv
    P6wR+c6PyFblcRjDeV//jqCuzqcGsSioxo7ovn6Kpvd9XbRXHqL9ZZjRS8BzV8Dp
    yuQyrzFogJRm5uZf/SkziMUaABJWunzAfEwazwhhJAbqWUzHLCy7FyBlVSbsvgpi
    nLkTq7yzPFyfBBQ4gWPAp0qJRIjNqqE0Ae/om8MsbJi9Gs5+QwRtG1R0350fDBqd
    wYZw3/7PBSpq7iwtNCHtNP2wzBMWxLQEYxWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523245035; bh=6P0PsVD/gw
    yr1jcp8eOpLafEv9N1FQe/XisJnlg4qh4=; b=i+R95wCHcWyylDpYHSG9qVVQyP
    sdivYxy/DUBcmHLzvwmurkj+aHWFeMjMpXEFpwP+PIknJlQj4QlO+STfxC2OqAI7
    sr6V3s+PZqRgpNzlIDYBJp5HhjSfgGgAeABc5EPDpgyeMc7EusVL4wd/B0YL+FqA
    BQAuMXLyPpB6UjMEjKJnacFlVmbF+DAHCnFdM+Rr5ZgiHe6WNw7xXPAOW93/zi9l
    /Xs5ER7kmUlENsYuPH+NVwjmeEkJcKYXRujxuRHREUQ4em0PXxaexxKg++mUdKOR
    gH3KNwF0mmFX9Rtz82Ja21lz3RkpfyJNSt8SKFEfnoepKDZO9+/hUYasITcw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UI+GeZAm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UI+GeZAm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFB3YKdHVqZyIXpQ2P1td5P6TOOHHuI0G+xS+myt4iVjiMkm0nEZcA8J6+oyUUH4Ds1DSq7wzJkA5atDyaTwAW8ioNOBMamM6M5mgn72pXFXRDKfNNyK
    uHS/UtvnxNzuNGTqSSX2q2pAwzaTksYXyp8xnFuOkAT/1lV+X7VEUepAtv00AsYXtxmkmqHREOn6dU5VYmGPhaozUySjUVSGzBPy6EuVJ96tcwQvBdtHFLMY
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=KyDrlq2SdzcA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=bxT30qUR3-jiv2_Z7sEA:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754797AbeDIDgr (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:36:47 -0400
Received: from mail-by2nam01on0139.outbound.protection.outlook.com ([104.47.34.139]:39793
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754386AbeDIDgo (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 23:36:44 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Sasha Levin <Alexander.Levin@microsoft.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "pintu.ping@gmail.com" <pintu.ping@gmail.com>
CC: "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] selftests/android/ion: fix heap_type may be
 uninitialized
Thread-Topic: [PATCH v2] selftests/android/ion: fix heap_type may be
 uninitialized
Thread-Index: AQHTz7P53LIt/QsznkaQxbJGxdNQog==
Date: Mon, 9 Apr 2018 03:36:41 +0000
Message-ID: <DM5PR2101MB1032D911A4D219B49022C307FBBF0@DM5PR2101MB1032.namprd21.prod.outlook.com>
References: <20180405073907.30615-1-anders.roxell@linaro.org>
In-Reply-To: <20180405073907.30615-1-anders.roxell@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1095;7:wS41RjeVWoPMK+BBZJ/Z5dwSkgNkVnLJgnaEo5GmW3TqtMNlC+25+DPg9IYqE1kni5SSVNK2wvH8brn3roP55lVeVFvw7AHB1fRrqTBY/tdO9wcfV2IcUmyyWWdNWwh8ZlZrAmabOIV4avd4OY5Qvh0uRNgmnMx/lj14Rrk01egtK2KNuKQ5iUuq7jjY1CrRwjD+aQOkaj6afah3TPdKIscoL/+Aej1uGrng/E7PTP8Rn3DhpcF4BwYMWnRrInG+;20:Hv161alAlH35aG8v44P8fSKh3YDwSziQ7qLVfStz/i9gCK0UKZc/n1ZFkNC33f+TI0vPcESQwusfAGFGUn9t8HFiBg3cI7iw7fEvuVOUe9KC9tXWqD0CW3I89poVJjIHpolsjUaDzkmxCOv7RPxxTUJz58R+RKTUHkENpv4sNyQ=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7b137cb3-bc22-4e55-116d-08d59dcb1bbe
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603328)(7193020);SRVR:DM5PR2101MB1095;
x-ms-traffictypediagnostic: DM5PR2101MB1095:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1095FC0DEDA5A26B789B55BEFBBF0@DM5PR2101MB1095.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1095;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1095;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(346002)(376002)(39860400002)(396003)(199004)(189003)(476003)(10090500001)(105586002)(39060400002)(86362001)(102836004)(11346002)(446003)(6246003)(55016002)(9686003)(76176011)(97736004)(74316002)(6506007)(8676002)(2201001)(99286004)(4326008)(81156014)(7696005)(81166006)(86612001)(26005)(486006)(2900100001)(106356001)(33656002)(72206003)(305945005)(478600001)(8936002)(25786009)(10290500003)(3660700001)(7736002)(66066001)(68736007)(8990500004)(110136005)(316002)(54906003)(3280700002)(2906002)(3846002)(6116002)(6436002)(53936002)(2501003)(229853002)(1511001)(5250100002)(14454004)(5660300001)(22452003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1095;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: SnQ/NhusHnQCK9oiqPiG8TdwoIO5RwS//8XQ/oFSFWe1K+gOm+PQUdGIHYjznT/eViFFGbrfUiOUcmbct9hN/8Z78bakHpv6F4K5VaZRIYQnZcd3NQwZblvdMgc6aAAkeGCcC4gIiQyTiZAiSU5hRcOX2HkvPiawZ7aPpA6XANILpCMVAdPsN6WJ4KPcuFfIZBw9ABZVvUHq4Z8AjOVwcCiZmhe6PMf9xCIvzGtqtW83DVsvUsM0aVKGsS5eOR92mkHIHuOQEPkNL/T0OTdRlCt5EFwsYUerJM+60OAh9REA6u97esVGHUVO+KMKAlChQOvjGsQzt7kpndclI16+JdR1bYjGh6f3jNQ+iEQnISUYprJOalb+0vLiJChLuxda2WsrASMLwtSp7Mx1O3cXLj54tRt3uASEE5B1DcuFKvc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b137cb3-bc22-4e55-116d-08d59dcb1bbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 03:36:41.0750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1095
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

[This is an automated email]

This commit has been processed because it contains a "Fixes:" tag,
fixing commit: 47a18c42d992 android/ion: userspace test utility for ion buf=
fer sharing.

The bot has also determined it's probably a bug fixing patch. (score: 30.26=
08)

The bot has tested the following trees: v4.16, v4.15.15.

v4.16: Build OK!
v4.15.15: Build OK!

--
Thanks,
Sasha=
