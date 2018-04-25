Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-431479-1524647943-2-8795303742111327804
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAD_ENC_HEADER 0.001, BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001,
  LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524647942; b=htV6ZQO3a9doGFQFbnWTsNT/9PROPa+4ekrww5FXCOixI1c/N4
    psI+QZeJgL+yU5HHdMC9+I6orK9eldBgebQcwxnQCUDbvGFvDHacUre8fMMLa0Fv
    8PBo9VMfiEkBOu3kY13HPML45xyk/VbDVaYCKVMBaGcWZYMu5xa918LTPY2K5jRL
    Y0pW2yIO5v9KmIPRjXEZubMs/OvOVJhZbm8f6axWIUZcp17e0P0hHDdOHlApXk9J
    mC+MtY4BqG05sJ91zjrXOb+l2hNLK1AYdROVBZVUJnwi5yZfapPc44Ylp+FrPSyf
    epbdOEwWibHFFSmDqyIYj8wRKeB3jlUvM+hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524647942; bh=6eiw9
    l/GEiy18hlCBcss/H+HDxVtFWzspfKORAWV0XE=; b=FdxAwpKPFv9IBP/L31dpX
    LbluHRFebIL/p1Bgt/jp4WXBU0nQseXPvkgAFuxWbD7MgbUHc8+AyCJSHUINqcWn
    D6mZ9vyFKKH8EgDyXhbZMNmsU1cbNtZzysnYj4n4JqqZ42uFevUrZIZwc/z6xYF7
    kBHmFQeVSV0aGZaBDuAAuYGQwqUnglAp1wwRxpvr4La8D2Qo02Z7FM+VHZCp1JKN
    Q/KM/jHrKPIfNs7yUzvmuHcWH73jTgRvqnZf7oHuSPnVt8UeVH4OLJwqQYCYYtFb
    ssPERBwA3N+6109r5AV//DJpW9lXqU7AW7tcK7EsqB8PkbbSLXmbU2cQ/Dz+4fFo
    Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=freescale.onmicrosoft.com header.i=@freescale.onmicrosoft.com header.b=HYWd6+DN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-freescale-onmicrosoft-com;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=freescale.onmicrosoft.com header.i=@freescale.onmicrosoft.com header.b=HYWd6+DN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-freescale-onmicrosoft-com;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfP4WSwofM/CfXgdtadatbMlAaND1lPSyCM0fxT+ywSLQV5sWkX/x0sBZmimBenGd3zwBOjKgFCGsJqRG4YzOCvXFjgU3Yb4HWzZDCXB+kMKAKrafM0Ff
    3gb1UvOIuG+PXbxOiSOBZ9/6VqUE6qY2u0njARrKW15cAgb1ihwW7FQ4JPlcORoiH2Ij6VrBVX5pnNKvyFuwHZ9PBjQUDKE2LDv4Q+DnWlQptyntdnVidAxr
    W6PdrxoB9MDvGiT/lNISVg==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=uwV2Oh5bJUoA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=8AirrxEcAAAA:8
    a=DDOyTI_5AAAA:8 a=k626kwcCBttF7g_-ne0A:9 a=CjuIK1q_8ugA:10
    a=ST-jHhOKWsTCqRlWije3:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Authentication-Results: spf=fail (sender IP is 64.157.242.222)
 smtp.mailfrom=nxp.com; driverdev.osuosl.org; dkim=none (message not signed)
 header.d=none;driverdev.osuosl.org; dmarc=fail action=none
 header.from=nxp.com;
From: Yangbo Lu <yangbo.lu@nxp.com>
To: <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Richard Cochran
 <richardcochran@gmail.com>, <dan.carpenter@oracle.com>, Ioana Radulescu
 <ruxandra.radulescu@nxp.com>
Subject: [PATCH] staging: fsl-dpaa2/eth: Add support for hardware timestamping
Date: Wed, 25 Apr 2018 17:17:49 +0800
Message-ID: <20180425091749.46841-1-yangbo.lu@nxp.com>
X-Mailer: git-send-email 2.14.1
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:64.157.242.222; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10019020)(39380400002)(376002)(346002)(39860400002)(396003)(2980300002)(1110001)(1109001)(339900001)(189003)(199004)(316002)(106466001)(59450400001)(50226002)(47776003)(2616005)(26005)(305945005)(126002)(105606002)(8676002)(110136005)(81166006)(81156014)(16586007)(6636002)(5660300001)(44832011)(486006)(77096007)(476003)(86362001)(39060400002)(4326008)(48376002)(8656006)(2906002)(356003)(50466002)(97736004)(1076002)(498600001)(53936002)(51416003)(8936002)(36756003)(85426001)(1857600001)(336012);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BL2PR03MB388; H:tx30smr01.am.freescale.net;
 FPR:; SPF:Fail; LANG:en; PTR:ErrorRetry; MX:1; A:1;
X-Microsoft-Exchange-Diagnostics: 1; BL2FFO11OLC007;
 1:sjA8oSiOfzUroWb4Tbag23s025MmqeMHS6N9SRC63/ktyj8HP1JWvpd50G1I2+0zvceU4kgAxaxA/S8WYDgs6n4MObgE0PrSHnN8L/N4Oc+mFLcORkkOTIlrjH0e1apa
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(8559017)(2017052603328);
 SRVR:BL2PR03MB388;
X-Microsoft-Exchange-Diagnostics: 1; BL2PR03MB388;
 3:84YnVDInWFypXyHseWfl06F9w8B0lHly6DBJ8wfme+voaWX3M+cVDJx0lN2jiGoxZ2q0/WgQvJu9DBszd7UY2FPT1/IwsXBjgjtn6/Z4AEJ0qTftaQSjkISzw2+e9DCj9S52ZXaPPBlBBkLyCjhIBH8InaqVPhBGdPMR4PpewRhmd9NDmXcFjfUNi7POCCS3hQlS7NPFlxFDBp+tFRWiB9JX4lfDk65HlAZoga7gUGugeg9cKknziloy+hjBqxyqQ08hWmK8mvRr3KWPjenVNgjq39S52BSFv2p931Q5ArxAIqk2KQumwkTtLIo2RSMyyhgJz4xtzICLliy2JJsGMJzkkSXYusfgZL24KHPMzWQ=;
 25:yg+3nV0OEtTgBOVeFOYGhdyBA7s+ST3R+eebGVaB4XtuBze5F6z3nn4M6SdlZnXleWOZnasNFEKvZIMSUpfHgyXTfvntTV0QTCTP+hLK8XyLIQ5jrI2z32c/zIgBeI4rMl599V4aZbNbfK+JlFNYzqxyCYlgGZzHQOsL50crraRwM+/a3fBcnk1RVV5cM1aLGqTUfdKEsFfox2XLXIGg3E1Ou3H1p2afZX9p6HJZuIbmdbCm4wAd2WgXiqDtZ9wbAcuapYFbfjTWk5oBQzuEHJ1EU0GtgMVtlz6Y/jy/wtxJTU+NTktFDhl323BUqtxuruNXZRpeK24IP8JW3r4UBQ==
X-MS-TrafficTypeDiagnostic: BL2PR03MB388:
X-Microsoft-Exchange-Diagnostics: 1; BL2PR03MB388;
 31:XwfWj5JDAlklWqMk4gLnjz+V/cpCMu8DHNP9+b9JqXUa0L827Q0rFpZaor8wuc4ZqCFPtucfc/NXA9NnC0DnA6rhBjmitdSyvDyq3sSP1JD9MSZKHB12NYuQFhj6dpIiWTcTxQAPzQD59ZyyARTKLg/iC35/ZkrdxPbTUFx05QkmaKGGr3xiOn6Wmt35NDSNQC1yJ2U5Vo09NGPKJXe2b9qwsfChTdBXHYD5c+wBMOw=;
 20:3mQo4V6bjBOiR6jopDbp/oEJMjsHEWTWR3rCAdwolZw1vguWnfnvp3RvNrL8kx7WqIvjxKgdpK3n8IoJc4N+wQi4CYNRQzOQ2s0a7Wp4Pq9G6kJcH6i8YsgAYQnM2zYQumbsPznwivmFNfe7LtrD5pC/yK1BwUPppOl9o42iY4l1kZqqX8mszngeLyk/I0ECtPpuwcjzZYP2FHQWLAaq9J3ktiaWW0SnRurz+JGc6mCsE6vQ74MSUks6nI9iDZ5j5JOmt6HSLpek9ZZUv6cY/B9HRFU0uySFurf+FKsUjiWQK2m5T6I/3/h/pu5whIJuMTcXZKYHx9lMoSPmfWA0j28E1orcHqc/EoYNEdjYQ9ZFlV0z0tb0tURYS6N/8tZGtmslCQopbKGAjU1WZrhkwFvlRFWOWOdKGObzJWqAnLnT1p4AOJZTQ0hiPIteLLRiuZDAFlepLZPLR9zaaMHjumbOXZbHIuKOX5zcP87AaAjFpWDS4hXkA1HM/MAea8WC67L3IzSI2WW7E5th6ZDtnux/NSjB86JNDp62dn8a2qKkxfvPyZooxGTMZL5NyOGbRImhquNcGfVZc78WOzU1fIe7HUtjnjtHtoWQSIa6J8I=
X-Microsoft-Antispam-PRVS: <BL2PR03MB3880E8F028E9CEF6B2F0777F88F0@BL2PR03MB388.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231232)(944501410)(52105095)(93006095)(93003095)(6055026)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061750153)(6072148)(201708071742011);
 SRVR:BL2PR03MB388; BCL:0; PCL:0; RULEID:; SRVR:BL2PR03MB388;
X-Microsoft-Exchange-Diagnostics: 1; BL2PR03MB388;
 4:ITcpwdYMVFrr/qLATkj13nlfLGDy8gwVDv5kovele2Jrw7Ie//c1WOP123UWiWpP54zeFyFcF4JTM9Gwlk5QsqPVnZ3f2Mivd0zL1ZvVWFczNNbhZZJPoLpqCEy02ZkjtR5khQq3N+CNLO9PyVeO1AejapnMYNX5sBtW8nJg7MouNs9G/LzfM+87yNE3KEx90tK1HHtOGYgfoNc1jl1s6aBOYx+/ATR157oNBfe4MD5j+IPcrFXbr1D2c/KEzknrjI/fGP+Td1BqTNjr7Sm01etkQhwoJp+oW3srl5h73uVpzCIdsiGidam8GOSoWcxq
X-Forefront-PRVS: 06530126A4
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; BL2PR03MB388;
 23:YBPOteug/UElGzOliNRfNQl44c996r7Olv2aG88iew?=
 =?us-ascii?Q?ZBBEGzRVCvcxdRIEisILyZM5Wj8rxNYYs/3IqBAoA7NlbYYin0mLJNswFP+8?=
 =?us-ascii?Q?4yzUxsKP+xbMJqQ2XPFarjvEwnkljf6sBedm52zTjEIzYToLJQic5PdNhmV4?=
 =?us-ascii?Q?ChQ6FysTSrGU549xMaqZfDTf5U0O7Gf8TkIo1u6OGEbPTr4Cx4wDEoqsjaKi?=
 =?us-ascii?Q?U0eon53hnHxoUq6zrCOnG01jQ6ZKiRon+GGZOHnryJ0osgyWy6mgBPAis7iv?=
 =?us-ascii?Q?ldEbYwX2tocro9ML/fsl8yC/lG6jCkEhO1BB0QGrdMaU+faym1pud/DPG9Ly?=
 =?us-ascii?Q?bTdj7BAPjMhMAF0ikkwA8LLRmQOmEN3eeq/9USMQEpi1SaLFQ6qKurix07EH?=
 =?us-ascii?Q?Phq6PJAYbSn5MqJVBKYgienpU4fwdRq94dRPnwi1CAWmjlscE9edGjSQmTty?=
 =?us-ascii?Q?hF7dOV9u2ENWVINReoJCQ1JfO3IrhJvRSEokLS9PfE3WpizTknDtR23IlhW3?=
 =?us-ascii?Q?BghCdM+ShU4ylVE8e48Wg5cXSX9iADuBcgdnZx6CD+m1ClehMqteZ/cuSPbq?=
 =?us-ascii?Q?gscvtNfBm/hBNuo/mlPFjRp+se+UA5/JH022InlnEN7M1cywcHvphbHZmJQ2?=
 =?us-ascii?Q?cgv4cJSWCSvHfOUKc52ohzW/3D5OtuFNdkey8lFMG7bw/T82RgjrvDCg4GIW?=
 =?us-ascii?Q?zrnxlQAItchsOw7H0l6RdPwqPji0EfKBQ0OccyCZ47uGfwvD4NVSVF7/cCzy?=
 =?us-ascii?Q?UzqFckBblwlDLxxiT0UvNwcWZjGvk/LTTWX+R2xml9yLsyr+yF817PcPuVPl?=
 =?us-ascii?Q?UuWKtplBAlQis9c3oigCUpyfpL2uD3H++rO1FY1y5RJVr34VJ6j5DgS7PXyD?=
 =?us-ascii?Q?58XH+iAwoR2W3MfLlLYHSKsdcLut1j/dxXZsZXM72VFS+FPXylNves9VGYAC?=
 =?us-ascii?Q?ZllhxW+a4Dn0f4fl4U37jiO/yx+aGOOjbPIF2OPiD1Nn6TnPTvwu3p9J2Elp?=
 =?us-ascii?Q?6IDiUTZZ8qa4J7enUntA+LwwOCpNcFvkeJA1t+8/Xr0IrLMhUM1SRJuudq0R?=
 =?us-ascii?Q?3X5BI9Os+05J0AY7MBEB9m916EWc37c8HMkBf0wGfAfu2Sy/wXqfCypfCENa?=
 =?us-ascii?Q?klJSb6q7nvgIwiXYpuWjkvmR8iK52hUYUqsaqAO9FCpo2jGWJTWQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: HeuFtosgMo4Or/OZJasGHu6cnFUB+voWG9LXFjSAMRLOvQ8F5cXq05DAdUaIBgOOu+k4mTK6zv30r1xbUC/GxR1BeGIgKYAyqH8Adll/i9neqfUdxqUBAORzQZ2Lhb2M/mfs60DgmJ3JOTqtxGzAr31bqeKWjDZC1m/L8P6FmHdFkKU9tA11gtnaHTfx/amr
X-Microsoft-Exchange-Diagnostics: 1; BL2PR03MB388;
 6:AyuY47IK85QW0q6PrmYLWdxpmLq37Q4OKXhtpgIMFYYvo8atcdKS6E037NVu7hwi/i/dca+lkgUIRDy4Xi5ZnrPeqnnoVR6H9O2Q0Pr6LaBWxyN7LkQ1mUkNdhWHcYJY6GCawdzvd2Bu8mOUrt2o9hBf8230VmKIDnQxUvxLz9Xsdn5MHT18RpgG8jZuF6ik5jQJxgx1hdzle5uKDfDwxsfkWNTHNltdePD6ws6sVUFI+UgIX4uN2UciE/cKpndrbk1oQEdkhrtog/1ZcbtNE8D+XMD6W/knSVOODQJqG6dzd6fpjKvxSnhUXfAn/GyweEbUtrzaMbGd8/Gx/oQJASHZDvIyZzLFu7jzND+OR4x7gYarEiqNtnz3834v/0sVI2PhfLjAM1kpnsqQwPWzSOhP+ct+4EfjJunDz2w0uL2srnBzw232lP9imddCZJy8leyKcZOLNSYPetESn3Lijg==;
 5:B0gipBQyKxR1gkQl6DkYRTrm5wElz9M7eH9rYdIB3pzQlXlad7FyXV3jEvIwG2sz8g9eDg5+uFnMqBb05szk1Td8x5WOxrXJ0zXt1L6p1/m867ohhbkwGKHyySlXrFbPUmHzpXD9ocEQwXrebdENFjtDg3VKy0JMb0zFb8Ko9J0=;
 24:nIerbjmPSKVCTe70cZZUoESoEnUV5MS0giLcFOl4ikbHob2EFmMp6kfGdYOVUsLA/+KZKxMYPNF4gtj/k6XKLJU/kr+Spc03RpslxgSrmcs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1; BL2PR03MB388;
 7:CA2XcUDbcq9p9C8kXog1RHtrIG3mUJGqqWLA6AdkErJhAx3ymu7M5KFb/4PpEGAAAf9Mxc3egXvKFM8KFyhrwheliN62z5HamRuKwksdQ+JZonAElqNzm8t1tMcO7mzQw2DFRtaBT5c22kmZUQIKYnmDH1bPiy7j1DafCXQZ0IWGDE6MILG5f99EfT3naHS8PN3a3E9hOGp6RkoMB3W7HLNkRWoWaKxl61itFoYCGeT7SN2Zz9ZpXZUNje+NwzaZ
X-MS-Office365-Filtering-Correlation-Id: c75e5a58-6979-4413-a868-08d5aa8d8c79
X-OriginatorOrg: freescale.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2018 09:18:46.5127 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c75e5a58-6979-4413-a868-08d5aa8d8c79
X-MS-Exchange-CrossTenant-Id: 710a03f5-10f6-4d38-9ff4-a80b81da590d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=710a03f5-10f6-4d38-9ff4-a80b81da590d; Ip=[64.157.242.222];
 Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR03MB388
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: Yangbo Lu <yangbo.lu@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Ioana Radulescu <ruxandra.radulescu@nxp.com>

Hardware timestamping is supported both on Rx and Tx paths.
On Rx, timestamping is enabled for all frames. On Tx, we
only instruct the hardware to timestamp the frames marked
accordingly by the stack.

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c |  109 +++++++++++++++++++++++-
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h |   48 ++++++++++-
 2 files changed, 151 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
index 553678d..d9febba 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
@@ -38,8 +38,11 @@
 #include <linux/msi.h>
 #include <linux/kthread.h>
 #include <linux/iommu.h>
-
+#include <linux/net_tstamp.h>
 #include <linux/fsl/mc.h>
+
+#include <net/sock.h>
+
 #include "dpaa2-eth.h"
 
 /* CREATE_TRACE_POINTS only needs to be defined once. Other dpa files
@@ -275,6 +278,16 @@ static void dpaa2_eth_rx(struct dpaa2_eth_priv *priv,
 
 	prefetch(skb->data);
 
+	/* Get the timestamp value */
+	if (priv->ts_rx_en) {
+		struct skb_shared_hwtstamps *shhwtstamps = skb_hwtstamps(skb);
+		u64 *ns = dpaa2_get_ts(vaddr, false);
+
+		*ns = DPAA2_PTP_NOMINAL_FREQ_PERIOD_NS * le64_to_cpup(ns);
+		memset(shhwtstamps, 0, sizeof(*shhwtstamps));
+		shhwtstamps->hwtstamp = ns_to_ktime(*ns);
+	}
+
 	/* Check if we need to validate the L4 csum */
 	if (likely(dpaa2_fd_get_frc(fd) & DPAA2_FD_FRC_FASV)) {
 		status = le32_to_cpu(fas->status);
@@ -334,6 +347,28 @@ static int consume_frames(struct dpaa2_eth_channel *ch)
 	return cleaned;
 }
 
+/* Configure the egress frame annotation for timestamp update */
+static void enable_tx_tstamp(struct dpaa2_fd *fd, void *buf_start)
+{
+	struct dpaa2_faead *faead;
+	u32 ctrl, frc;
+
+	/* Mark the egress frame annotation area as valid */
+	frc = dpaa2_fd_get_frc(fd);
+	dpaa2_fd_set_frc(fd, frc | DPAA2_FD_FRC_FAEADV);
+
+	/* Set hardware annotation size */
+	ctrl = dpaa2_fd_get_ctrl(fd);
+	dpaa2_fd_set_ctrl(fd, ctrl | DPAA2_FD_CTRL_ASAL);
+
+	/* enable UPD (update prepanded data) bit in FAEAD field of
+	 * hardware frame annotation area
+	 */
+	ctrl = DPAA2_FAEAD_A2V | DPAA2_FAEAD_UPDV | DPAA2_FAEAD_UPD;
+	faead = dpaa2_get_faead(buf_start, true);
+	faead->ctrl = cpu_to_le32(ctrl);
+}
+
 /* Create a frame descriptor based on a fragmented skb */
 static int build_sg_fd(struct dpaa2_eth_priv *priv,
 		       struct sk_buff *skb,
@@ -420,6 +455,9 @@ static int build_sg_fd(struct dpaa2_eth_priv *priv,
 	dpaa2_fd_set_len(fd, skb->len);
 	dpaa2_fd_set_ctrl(fd, DPAA2_FD_CTRL_PTA | DPAA2_FD_CTRL_PTV1);
 
+	if (priv->ts_tx_en && skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)
+		enable_tx_tstamp(fd, sgt_buf);
+
 	return 0;
 
 dma_map_single_failed:
@@ -470,6 +508,9 @@ static int build_single_fd(struct dpaa2_eth_priv *priv,
 	dpaa2_fd_set_format(fd, dpaa2_fd_single);
 	dpaa2_fd_set_ctrl(fd, DPAA2_FD_CTRL_PTA | DPAA2_FD_CTRL_PTV1);
 
+	if (priv->ts_tx_en && skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)
+		enable_tx_tstamp(fd, buffer_start);
+
 	return 0;
 }
 
@@ -520,6 +561,19 @@ static void free_tx_fd(const struct dpaa2_eth_priv *priv,
 		return;
 	}
 
+	/* Get the timestamp value */
+	if (priv->ts_tx_en && skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) {
+		struct skb_shared_hwtstamps shhwtstamps;
+		u64 *ns;
+
+		memset(&shhwtstamps, 0, sizeof(shhwtstamps));
+
+		ns = dpaa2_get_ts(skbh, true);
+		*ns = DPAA2_PTP_NOMINAL_FREQ_PERIOD_NS * le64_to_cpup(ns);
+		shhwtstamps.hwtstamp = ns_to_ktime(*ns);
+		skb_tstamp_tx(skb, &shhwtstamps);
+	}
+
 	/* Free SGT buffer allocated on tx */
 	if (fd_format != dpaa2_fd_single)
 		skb_free_frag(skbh);
@@ -552,6 +606,10 @@ static netdev_tx_t dpaa2_eth_tx(struct sk_buff *skb, struct net_device *net_dev)
 			goto err_alloc_headroom;
 		}
 		percpu_extras->tx_reallocs++;
+
+		if (skb->sk)
+			skb_set_owner_w(ns, skb->sk);
+
 		dev_kfree_skb(skb);
 		skb = ns;
 	}
@@ -1365,6 +1423,45 @@ static int dpaa2_eth_set_features(struct net_device *net_dev,
 	return 0;
 }
 
+static int dpaa2_eth_ts_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
+{
+	struct dpaa2_eth_priv *priv = netdev_priv(dev);
+	struct hwtstamp_config config;
+
+	if (copy_from_user(&config, rq->ifr_data, sizeof(config)))
+		return -EFAULT;
+
+	switch (config.tx_type) {
+	case HWTSTAMP_TX_OFF:
+		priv->ts_tx_en = false;
+		break;
+	case HWTSTAMP_TX_ON:
+		priv->ts_tx_en = true;
+		break;
+	default:
+		return -ERANGE;
+	}
+
+	if (config.rx_filter == HWTSTAMP_FILTER_NONE) {
+		priv->ts_rx_en = false;
+	} else {
+		priv->ts_rx_en = true;
+		/* TS is set for all frame types, not only those requested */
+		config.rx_filter = HWTSTAMP_FILTER_ALL;
+	}
+
+	return copy_to_user(rq->ifr_data, &config, sizeof(config)) ?
+			-EFAULT : 0;
+}
+
+static int dpaa2_eth_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
+{
+	if (cmd == SIOCSHWTSTAMP)
+		return dpaa2_eth_ts_ioctl(dev, rq, cmd);
+
+	return -EINVAL;
+}
+
 static const struct net_device_ops dpaa2_eth_ops = {
 	.ndo_open = dpaa2_eth_open,
 	.ndo_start_xmit = dpaa2_eth_tx,
@@ -1375,6 +1472,7 @@ static int dpaa2_eth_set_features(struct net_device *net_dev,
 	.ndo_change_mtu = dpaa2_eth_change_mtu,
 	.ndo_set_rx_mode = dpaa2_eth_set_rx_mode,
 	.ndo_set_features = dpaa2_eth_set_features,
+	.ndo_do_ioctl = dpaa2_eth_ioctl,
 };
 
 static void cdan_cb(struct dpaa2_io_notification_ctx *ctx)
@@ -1770,7 +1868,9 @@ static int set_buffer_layout(struct dpaa2_eth_priv *priv)
 
 	/* tx buffer */
 	buf_layout.private_data_size = DPAA2_ETH_SWA_SIZE;
-	buf_layout.options = DPNI_BUF_LAYOUT_OPT_PRIVATE_DATA_SIZE;
+	buf_layout.pass_timestamp = true;
+	buf_layout.options = DPNI_BUF_LAYOUT_OPT_PRIVATE_DATA_SIZE |
+			     DPNI_BUF_LAYOUT_OPT_TIMESTAMP;
 	err = dpni_set_buffer_layout(priv->mc_io, 0, priv->mc_token,
 				     DPNI_QUEUE_TX, &buf_layout);
 	if (err) {
@@ -1779,7 +1879,7 @@ static int set_buffer_layout(struct dpaa2_eth_priv *priv)
 	}
 
 	/* tx-confirm buffer */
-	buf_layout.options = 0;
+	buf_layout.options = DPNI_BUF_LAYOUT_OPT_TIMESTAMP;
 	err = dpni_set_buffer_layout(priv->mc_io, 0, priv->mc_token,
 				     DPNI_QUEUE_TX_CONFIRM, &buf_layout);
 	if (err) {
@@ -1810,7 +1910,8 @@ static int set_buffer_layout(struct dpaa2_eth_priv *priv)
 	buf_layout.options = DPNI_BUF_LAYOUT_OPT_PARSER_RESULT |
 			     DPNI_BUF_LAYOUT_OPT_FRAME_STATUS |
 			     DPNI_BUF_LAYOUT_OPT_DATA_ALIGN |
-			     DPNI_BUF_LAYOUT_OPT_DATA_HEAD_ROOM;
+			     DPNI_BUF_LAYOUT_OPT_DATA_HEAD_ROOM |
+			     DPNI_BUF_LAYOUT_OPT_TIMESTAMP;
 	err = dpni_set_buffer_layout(priv->mc_io, 0, priv->mc_token,
 				     DPNI_QUEUE_RX, &buf_layout);
 	if (err) {
diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
index 54cea2f..1300f28 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
@@ -88,8 +88,12 @@
 #define DPAA2_ETH_SKB_SIZE \
 	(DPAA2_ETH_RX_BUF_SIZE + SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
 
-/* Hardware annotation area in RX  buffers */
+/* Hardware annotation area in RX/TX buffers */
 #define DPAA2_ETH_RX_HWA_SIZE		64
+#define DPAA2_ETH_TX_HWA_SIZE		128
+
+/* PTP nominal frequency 1GHz */
+#define DPAA2_PTP_NOMINAL_FREQ_PERIOD_NS 1
 
 /* Due to a limitation in WRIOP 1.0.0, the RX buffer data must be aligned
  * to 256B. For newer revisions, the requirement is only for 64B alignment
@@ -135,6 +139,7 @@ struct dpaa2_eth_swa {
 /* Annotation bits in FD CTRL */
 #define DPAA2_FD_CTRL_PTA		0x00800000
 #define DPAA2_FD_CTRL_PTV1		0x00400000
+#define DPAA2_FD_CTRL_ASAL		0x00020000	/* ASAL = 128B */
 
 /* Frame annotation status */
 struct dpaa2_fas {
@@ -150,6 +155,23 @@ struct dpaa2_fas {
 #define DPAA2_FAS_OFFSET		0
 #define DPAA2_FAS_SIZE			(sizeof(struct dpaa2_fas))
 
+/* Timestamp is located in the next 8 bytes of the buffer's
+ * hardware annotation area
+ */
+#define DPAA2_TS_OFFSET			0x8
+
+/* Frame annotation egress action descriptor */
+#define DPAA2_FAEAD_OFFSET		0x58
+
+struct dpaa2_faead {
+	__le32 conf_fqid;
+	__le32 ctrl;
+};
+
+#define DPAA2_FAEAD_A2V			0x20000000
+#define DPAA2_FAEAD_UPDV		0x00001000
+#define DPAA2_FAEAD_UPD			0x00000010
+
 /* Accessors for the hardware annotation fields that we use */
 static inline void *dpaa2_get_hwa(void *buf_addr, bool swa)
 {
@@ -161,6 +183,16 @@ struct dpaa2_fas {
 	return dpaa2_get_hwa(buf_addr, swa) + DPAA2_FAS_OFFSET;
 }
 
+static inline u64 *dpaa2_get_ts(void *buf_addr, bool swa)
+{
+	return dpaa2_get_hwa(buf_addr, swa) + DPAA2_TS_OFFSET;
+}
+
+static inline struct dpaa2_faead *dpaa2_get_faead(void *buf_addr, bool swa)
+{
+	return dpaa2_get_hwa(buf_addr, swa) + DPAA2_FAEAD_OFFSET;
+}
+
 /* Error and status bits in the frame annotation status word */
 /* Debug frame, otherwise supposed to be discarded */
 #define DPAA2_FAS_DISC			0x80000000
@@ -319,6 +351,9 @@ struct dpaa2_eth_priv {
 	u16 bpid;
 	struct iommu_domain *iommu_domain;
 
+	bool ts_tx_en; /* Tx timestamping enabled */
+	bool ts_rx_en; /* Rx timestamping enabled */
+
 	u16 tx_qdid;
 	u16 rx_buf_align;
 	struct fsl_mc_io *mc_io;
@@ -377,10 +412,19 @@ static inline unsigned int dpaa2_eth_buf_raw_size(struct dpaa2_eth_priv *priv)
 unsigned int dpaa2_eth_needed_headroom(struct dpaa2_eth_priv *priv,
 				       struct sk_buff *skb)
 {
+	unsigned int headroom = DPAA2_ETH_SWA_SIZE;
+
+	/* For non-linear skbs we have no headroom requirement, as we build a
+	 * SG frame with a newly allocated SGT buffer
+	 */
 	if (skb_is_nonlinear(skb))
 		return 0;
 
-	return DPAA2_ETH_SWA_SIZE;
+	/* If we have Tx timestamping, need 128B hardware annotation */
+	if (priv->ts_tx_en && skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)
+		headroom += DPAA2_ETH_TX_HWA_SIZE;
+
+	return headroom;
 }
 
 /* Extra headroom space requested to hardware, in order to make sure there's
-- 
1.7.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
