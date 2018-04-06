Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2139197-1523046300-2-5197987759667450087
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523046299; b=YqcB3tg2naswswlC/WlGSh8Ng2uHpC0f1zzrY3zQtQcflZV8U9
    Vyn2agtYUsFmx8fZ1rWwnVGo9Wn7liSAJ7TTnb8NnVj+6T16WAJ4hv5hoJxHpavC
    sRBwMJwjuACWGbhpTzwoxSS8ykHW8BQQFUUQNzM9MxyBc69h3FqX9Zd2y6DAwzrO
    DpEcnBa99fl81sg6d0gW/8cXpYR7Q3hGsNzbNNZVDw1GUd+JRWTMU+IIMimmJ8GV
    NPwxZqe2FZUTnVLEAd5fqJSUobCQeDZM6e3DDyYg7WT0lY7LSXVos9brC6/prCfv
    17GsA4hr8qgjXxOPSHBOEp6cR8VzS5CzgeIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523046299; bh=irqSoQ/uEbsJ/VFDS6LB9yIxsjX5HvDYVxYb1Cx3IAc=; b=
    ihRtv9gpwXBYqUdlfb1Eka0vsAugNvl0zVxeWtp/6+VJDg6/qopOEwlYJzMusrqf
    1sdA9Fjy0B5WVl0OnkHbFhnxUWQ0y+V/rHsWtq9p1TVQ9p1tFada0gjcO6GaSIoO
    IG5rGMBxvH+9U1FQw+9PESJmOQTzT6RisnWTIk7/CPfjRddQLdRWqPoTvn9bSa1f
    lk0MFUyDBT+5eu2RuW7C0eJENrcXhikLcC9077N6fHgxoCMjAinQp3DVTyiTxgE3
    DZmks9X/DhgvKspgBCJ1vT0su/iv0oDaUGKx1VSnM4ko7VcnSw5EL4rpSKVlr95h
    7bRNmOnNaj3hCrCOwXxbbw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ctUd9PDr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ctUd9PDr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMv8U58CLLkVXjt1b2dg/uHy9d75FfkXGlM5QuuTS5WcM1jNiNWmXnqV7Lg8B57pH71eXZFTprUkUQKgp+/KTCqYkosx+QVqOQmOkHwSqqrRX79iSBwO
    2QouuURyScPzNmEyLZG0UVjoB2HTZklZlKfFXO2+hG1kmkDu8erNmu6e8Vh3zjHLgY4XxVfGA8FwYKo/AnCiiQL7TA9cG3HZjISdPOYwFm6GYsZE7F2CRaV/
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=LzwyXZqj8egA:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=oi-cQ6pdHt-HgNKC_BoA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751401AbeDFUY6 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 16:24:58 -0400
Received: from mail-cys01nam02on0121.outbound.protection.outlook.com ([104.47.37.121]:38432
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751312AbeDFUY5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 6 Apr 2018 16:24:57 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Ondrej Zary <linux@rainbow-software.org>
CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] i8042: Enable MUX on Sony VAIO VGN-CS series to fix
 touchpad
Thread-Topic: [PATCH] i8042: Enable MUX on Sony VAIO VGN-CS series to fix
 touchpad
Thread-Index: AQHTzeKu0wIJ/ejyWUaRTOhQ0X5lm6P0LHmAgAACZYA=
Date: Fri, 6 Apr 2018 20:24:54 +0000
Message-ID: <20180406202453.GB2341@sasha-vm>
References: <20180403170810.32005-1-linux@rainbow-software.org>
 <MW2PR2101MB10344E66701305F65F39EF24FBBA0@MW2PR2101MB1034.namprd21.prod.outlook.com>
 <201804062216.20107.linux@rainbow-software.org>
In-Reply-To: <201804062216.20107.linux@rainbow-software.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1017;7:zd13cxDsM+UmmyXmWlA85FZhnmUmdJEcTr0m7thyqzKYCWtsUuR6d/ZkSDlhwFX2kCj9SDi6Do2s1v4iK9OrBaKn+yuzlwb9idXWyg1cRiVdt4hzlVqSOIzea9wpm9unPTgq0wG6jys9ZF/5doGsEIGm3g8Mqe122jPd85ctbV9ZsQ02jZ0idJuVBtssEcRgLhrQ2Kt/z7xr66IOYTCymZmxOHX+VK0owlp2WRSaAfgSpch6ByX6TA55GrNcYQz3;20:KmS9cYohxoubE+v/ZBU9Oe5wJbIt3GeIGzd0uQKhO14BA0mv73wIBltvd58LB5sJF2UgNtPMkTwPY7BFQ/66wu30D0WAOOLJCCUjZfaVwjNsTNMCkEFsf7t8CmxFgWn9aOcqnflQy5uwi3z/eY6j7qvMpQZR/AKnVYhlZTSkmrQ=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: bda90867-16f3-4b5e-4c3e-08d59bfc75ac
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:MW2PR2101MB1017;
x-ms-traffictypediagnostic: MW2PR2101MB1017:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1017B5EB5A9FDC6F7BC5A4E6FBBA0@MW2PR2101MB1017.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231221)(944501327)(52105095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:MW2PR2101MB1017;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1017;
x-forefront-prvs: 0634F37BFF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(396003)(366004)(376002)(346002)(39860400002)(39380400002)(189003)(199004)(8936002)(76176011)(33896004)(3846002)(6116002)(2906002)(81156014)(102836004)(3660700001)(81166006)(99286004)(26005)(186003)(11346002)(8676002)(6916009)(6506007)(3280700002)(5660300001)(486006)(66066001)(14454004)(305945005)(7736002)(476003)(4326008)(6512007)(6436002)(105586002)(1076002)(446003)(5250100002)(33656002)(39060400002)(25786009)(10290500003)(9686003)(68736007)(53936002)(10090500001)(6486002)(6246003)(22452003)(33716001)(229853002)(478600001)(86612001)(2900100001)(97736004)(86362001)(72206003)(316002)(54906003)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1017;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: eY1K2fNUgaow/AHDavl+joeXaygdFSlXZrbWQ0OeZ4UhGaT5eCNzs0Xd79jzcac6rErXe0kKUxlSdvJJPQvP4NfmtBQsjZ6kPPOmscfAKW47WlAw4Jhj3OyLFlcW1bfY17xEWoGNr/D3UrEg4zF74ApgOG3mBO0u0aFXwf80rhHW5wIuDx3oa6tum/YAjKdd3EwYpb/Jgr590GZNWjSLaoK5i07yov+g+1ZCLD1jlyONnvPD5qguu1BzfyI/uNH/0+2CRZ9liCsCSm6v6fJsUjIM7fo0vuBT2w0vpCzUISyAg1egaa2yZ5CmWCLhw43A2rvtu8nUVA1W9M5ieROm2EhdDYBmxVu/WODBsXj0We1JAXC3IhCubweY9r5jfj97uN41F3JOIWNLHZii2J/1ptweSQEdzT9QAl3Ywb41qM0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B9E2263E36A32F4CB604968C0C32B717@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bda90867-16f3-4b5e-4c3e-08d59bfc75ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2018 20:24:54.9882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1017
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 06, 2018 at 10:16:19PM +0200, Ondrej Zary wrote:
>On Friday 06 April 2018 22:05:59 Sasha Levin wrote:
>> Hi,
>>
>> [This is an automated email]
>>
>> This commit has been processed by the -stable helper bot and determined
>> to be a high probability candidate for -stable trees. (score: 24.5527)
>>
>> The bot has tested the following trees: v4.16, v4.15.15, v4.14.32, v4.9.=
92,
>> v4.4.126.
>>
>> v4.16: Build OK!
>> v4.15.15: Build OK!
>> v4.14.32: Build OK!
>> v4.9.92: Build OK!
>> v4.4.126: Build OK!
>>
>> Please let us know if you'd like to have this patch included in a stable
>> tree.
>
>AFAIK, it was already included in various stable trees.

Ah yes, indeed I see it proposed for various -stable trees.

I guess Greg is extra speedy these days :)=
