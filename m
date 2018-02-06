Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3970300-1517881295-2-12598311624012540372
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517881295; b=FcQ8wFYijplcE8qsIW16SCFl/mZvV6sev6VtEtIhjlZfGL2
    eFc7fHD4xLcXZLc4uTOEZadaQMzkFCeuHYwRJSRyL+67yQoXJn3EY0psiUVRGTX6
    FO1L/dE0oNOW8uHF+j+o1HYG3e3GZyEoHx0nO8ZA+TPbGOlSCoCB6sx9vrCFAfnF
    aVwSvVDsR/T4RX/b1Mtxqr7qwSLcZYLCYpLlz9w2GxDi7oFdunDdZ7Ub3EUonwWx
    KfoV5iyvM18jZY087hpYgjFgJohSaJ96WDy2ANkPPrZj+jBi2ml5UDNxpj7VCSDt
    6vRsreDrgWYhMeviiOBiDpdmgBeUvjoCMJWh0YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1517881295; bh=l8Az+he/vY1lWlUrlllypAI/kivVRUsaZsQrH+
    jqObA=; b=Ap/v6JIb93dRHq3vesBS6t0yvQguZARoUBsAT+5nEUzwnGDF7M0A8e
    Q/UrUy2UD4yiTvJjDNG0JjG1hL8WfD8k5dheT5S7uXIg3P+c/uNZvoGyjcyLv71V
    wZl1DMxTE1ocO0dyN9rtw1yjocncyDZYc5mLq7hvkKGl3yHJAtMS0vjFQ1UKja6e
    jAl/pBiSLs5i9jA6fgI/CAOdtt/U+UTofFw19m2HbPiG4c/Jr2tN8dHgPUUAQluu
    UXpSlYvQrV6SCC6S6rnwCiFE0wsEqgYGEwyAHf/Cn/unwMbwJspFiZBKzQD+Xb5T
    igVG1vVScvM1K6o2zj5Tk8TxdSSa6AYQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=j+9Ae+9B x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=j+9Ae+9B x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752126AbeBFBlc (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Feb 2018 20:41:32 -0500
Received: from mail-by2nam01on0123.outbound.protection.outlook.com ([104.47.34.123]:55298
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751514AbeBFBlb (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 5 Feb 2018 20:41:31 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Mark Brown <broonie@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Abhijeet Kumar <abhijeet.kumar@intel.com>
Subject: Re: [PATCH AUTOSEL for 4.14 029/110] ASoC: nau8825: fix issue that
 pop noise when start capture
Thread-Topic: [PATCH AUTOSEL for 4.14 029/110] ASoC: nau8825: fix issue that
 pop noise when start capture
Thread-Index: AQHTnRjnIdl/Kttc4Uy8OruAwVGxi6OVsnEAgADqiQA=
Date: Tue, 6 Feb 2018 01:41:29 +0000
Message-ID: <20180206014120.pdudjvme5zwofdxp@sasha-lappy>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
 <20180203180015.29073-29-alexander.levin@microsoft.com>
 <20180205114154.GB12384@sirena.org.uk>
In-Reply-To: <20180205114154.GB12384@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1080;6:1e8z9zaXZDCRHuJ8Q9FGRAObQWLt1Z5wQQzE1tfdSqL9HG94gM3w/yyUi5F7018tdKFNxuyvry9KSv0cWydQZXLawnWMAa5j8Ii1UJvIadzZKRhoLosWyHUggpk4jsNIbwWMY1VpXRmCvMd0Ndd6jLbOA0YB7kmL+5CGWPQVZPnDUCt3CSm4Y0EV9Gc05zsiO0SmbP/drDzLuzuHOPCV2AEyBnBdGc+tuz5V7lkfafGQf03/taDH62jQQ8azT96Qo61ZhxBGGLbfFddMvoxUb8mkc7kcQresWU1fToPQVWCD5Ir7dZ2q6oNnixF0dSrDUHeRtK9+VPzhvATkMni+GVpKSMpfnkoYw6ByZHQ+K+3Gp5c/ZN9d7x+wJqJ91y0I;5:+Eyj8d/jaDZHCqrUqjdMt/+VCPIS6mwEgCUzIyQLyzLaIi5Qtpg3mPaLHkRqMbsZdIm1D+FD78L7/ptMJxb+qzVL+OAPjuWTTNDhk1DOIfipIrR9blAAEvsmsW8d7g0kjCUsQPn1Hm2HUiEUsYEzDB5+rZXLKjubXQINllvaYiw=;24:J5gk4rETQzyGU6ODfbBQJf/Sipl1AIwZaw8LaGUOtNUWBVUZLMWU8NT55BACSYQAqEWYs0HMyaq3qaqUeC5WI88gpz87Uox/hrDc3YwFGY4=;7:gE+hkJI+AII8bV5tkHtzmmjyMlLlYUKkuXG32JS+7sPxjLXYHDdHyrqCRAGqHn6IxiELAbQ9tyIi22b/T+M06OjVwF3DHXVh/O673PLncpjKj2NiosBlE95LbwDYU8OCtI+z3yCn5oiAaE2ax5PVrRuhuU/4i/0S54KvKwz9s3v3pIthSYLAMqVmMLX5qCVVNRkM0wLV8w6WCSNijk/IJJQVXl3jmn2f0AgQJBqzV7/tkEQEIeDa1pe55iipzkJt
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 095b42af-1af5-4f0b-b588-08d56d02be88
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:DM5PR2101MB1080;
x-ms-traffictypediagnostic: DM5PR2101MB1080:
x-microsoft-antispam-prvs: <DM5PR2101MB108020FDD97E53B0935564C4FBFD0@DM5PR2101MB1080.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231101)(2400082)(944501161)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1080;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1080;
x-forefront-prvs: 0575F81B58
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(39380400002)(366004)(346002)(396003)(376002)(39860400002)(51444003)(199004)(189003)(76176011)(10290500003)(2906002)(25786009)(86362001)(72206003)(3846002)(6506007)(66066001)(81166006)(81156014)(6116002)(229853002)(8676002)(4326008)(53936002)(5660300001)(3280700002)(6486002)(59450400001)(33896004)(97736004)(3660700001)(68736007)(14454004)(5250100002)(10090500001)(478600001)(6246003)(186003)(22452003)(105586002)(9686003)(316002)(7736002)(54906003)(106356001)(305945005)(6436002)(99286004)(2950100002)(33716001)(6346003)(2900100001)(6916009)(8936002)(26005)(6512007)(86612001)(102836004)(1076002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1080;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: 2CnJlUgwOYLLpnrExVLLuWrVYj/qCmdIaYnAw7n4+vpvjBolCYURgLm7C7rLAeI4lohBQjsPlyvecSoNWhBm7g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <398C8F647A77A34F800C492F45958ED5@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 095b42af-1af5-4f0b-b588-08d56d02be88
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2018 01:41:29.3723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1080
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 05, 2018 at 11:41:54AM +0000, Mark Brown wrote:
>On Sat, Feb 03, 2018 at 06:00:42PM +0000, Sasha Levin wrote:
>> From: Abhijeet Kumar <abhijeet.kumar@intel.com>
>>
>> [ Upstream commit d070f7c703ef26e3db613f24206823f916272fc6 ]
>>
>> In skylake platform, we hear a loud pop noise(0 dB) at start of
>> audio capture power up sequence. This patch removes the pop noise
>> from the recording by adding a delay before enabling ADC.
>
>>  	switch (event) {
>>  	case SND_SOC_DAPM_POST_PMU:
>> +		msleep(125);
>>  		regmap_update_bits(nau8825->regmap, NAU8825_REG_ENA_CTRL,
>
>This is another one of these where I'm not convinced that backporting to
>stable isn't going to introduce regressions - it will fix problems on
>some systems but if someone really cares about a startup pop and has
>arranged to do something like discard the start of the audio where the
>pop occurs then this may cut off even more and cause them to miss
>things.

It might cause regressions for users who worked around the issue, but it
may also fix the issue for users who didn't. I think that in general
we'd rather have mainline and stable trees have the same bugs and
breakage - we don't want surprises when users jump around between
kernels.

--=20

Thanks,
Sasha=
