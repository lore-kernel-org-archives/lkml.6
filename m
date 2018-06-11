Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 88A10C5CFF0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2706D208AF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=epam.com header.i=@epam.com header.b="QS6OcK1l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2706D208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=epam.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933388AbeFKRRC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 13:17:02 -0400
Received: from mail-eopbgr40070.outbound.protection.outlook.com ([40.107.4.70]:21599
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753786AbeFKRRA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 13:17:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDWToj57hwHw1G2mF51SvIytoxthDpO2qNG8bmBJRQ0=;
 b=QS6OcK1l/oiHLtvi0b2ZmjfKBI2YLkzszbthanB4zLOZMAtoMr6BK2FRJDeyxHFPcOj78MDrWItPvenDC2fNwWBU/qGZdM8dWHDaANvSRKU9AOMsxKYz+2uz6qjK/CBx5azC1ujcvgX+CFNWWsuw4wr9QwP1FtYkRhwQg+Q/AEI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Oleksandr_Andrushchenko@epam.com; 
Received: from [192.168.1.122] (46.211.157.57) by
 DB3PR0302MB3211.eurprd03.prod.outlook.com (2603:10a6:8:9::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.18; Mon, 11 Jun 2018 17:16:53 +0000
Subject: Re: [Xen-devel] [PATCH v2 5/9] xen/gntdev: Allow mappings for DMA
 buffers
To:     Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Andrushchenko <andr2000@gmail.com>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        jgross@suse.com, konrad.wilk@oracle.com, daniel.vetter@intel.com,
        matthew.d.roper@intel.com, dongwon.kim@intel.com,
        julien.grall@arm.com
References: <20180601114132.22596-1-andr2000@gmail.com>
 <20180601114132.22596-6-andr2000@gmail.com>
 <64facf05-0a51-c3d9-9d3b-780893248628@oracle.com>
 <84217eac-b83b-710f-39ab-c93cad65bf9a@gmail.com>
 <a172746d-7a97-159f-71a7-511b2d239089@oracle.com>
 <30fa03c0-1b75-c0b1-b14f-8b52ea584e20@gmail.com>
 <78dc2fc4-cdac-05b7-2c34-22b69e7e009c@oracle.com>
 <4be24882-185d-01e3-6aa1-751e341433c7@gmail.com>
 <alpine.DEB.2.10.1806081025030.14699@sstabellini-ThinkPad-X260>
 <c6e1820a-fb57-b213-aa2f-05787dae06ad@oracle.com>
 <06eff3fe-3ffc-47f6-6bd6-d8f2f823b382@gmail.com>
 <alpine.DEB.2.10.1806110949050.14695@sstabellini-ThinkPad-X260>
From:   Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Message-ID: <baab493d-bcba-f053-4b48-0f97fb5723b2@epam.com>
Date:   Mon, 11 Jun 2018 20:16:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1806110949050.14695@sstabellini-ThinkPad-X260>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [46.211.157.57]
X-ClientProxiedBy: VI1P189CA0002.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::15) To DB3PR0302MB3211.eurprd03.prod.outlook.com
 (2603:10a6:8:9::15)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0302MB3211;
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0302MB3211;3:/bS4orXL47YSb5jRETd35FU3ya5mHjYZr7ptPqbjLEkR18MIjMDQKNM9cCkCOD0xNoQZATfvcv7Q61d2ePDcol84sJ2VnuaH+XSi6AM3UjdfpBLzynaaf5M1QG/L0lRYjuURUHNrdvZj7DANGuwqATnZOkIO6Lf/DxmJ/nPpXri65L1bpZPqLFhFnQE1FfIrEk3XCCcq5mc7gfaJ738orqXE6MKZfwIcziOYBC/XDaetYbC/wkMeSKkY1KCjPk8l;25:RRfaxgpXBOTNFvAQwO3An7KdgXtQOl32QIXvHDKe/KLk7QSPvs5/kZlUiOQjS4ekjw+W5Lk3uUJoB32yxHtIIksWZzld1w6m4WzNZTbnUq4A5TP0yTyjukNm1Ru5Q1+Y3WcccQ469NU93sodP1+W0cfIp8WLMxIdgxF2k9y2000vSS4ix38bTF5TmlW1POYuzQJ4zv4rJy77Z6srgityO4jwMFZexobXtl2pJsLQRRPp1zb0v3g1+/S6MdOApWemZPIdtCYn55b+qofvgAAKyDYrZMIS4CG517ZToxLZv/UaoPWTF8PQf//xnhIU5SoIkjsyWMZmNUUh5U+1tCIVow==;31:DJa8NqeEZggB9RucL8qqZvDW27YmTH2VZ9I4cVX/CA1dYLSbFaDTFk49PCpkUu3TFL3AYjonGPax5cPtRjQ8yPnDNlfrZWJsKNJD9qW4vIhQE4nKM05y0RZi4jX+DV0B6vI7+8sWQoMDZQv6uxsb7BIQwZTlQlNf98TKE1trtaS0aRQQh1XGCfrASrLXVL9vJxAMxnpGdP+AVOFTpiCgnik15mi9M5oxLdq9vXPi8a8=
X-MS-TrafficTypeDiagnostic: DB3PR0302MB3211:
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0302MB3211;20:LyRbJrXsTKX9nG6iU/O/OxdbeeswjA/eMtSwqsD0iSsaJhO8bO0Yy2WObddYPNzfCMewiktBTIJFp4/sbtqrKG6gK6q4cZD+lTh3z7YwMQPIJmrDcZ8GRuaIcMRGD7evIwnCK1VSTgg6anuHrz6ioIazccC3n5ghLaULkAJTm/LI9jOCF26QmxAtaFRztIWfefewxtJwJpwQ6ZaJEi9B2jynqAy0y4uzqYK3AvYigaHJzJtGGMOsaI934ESxSIV9HCl+JGD4wb5uHV7xwAWMs/iiD7XEifzQD/bUy19YD2hiuUF96VPsRBylIQINrGzZdI4dP+HQPsXryDNZzGlHOI2ZnR/I0sFSvR4Qdnrp4vKkXqGUuT5BRdJyE0q35pxL0qMaTTXzDdHaJ2uoifLxyCXXoRsD7YryhvEbfOK3VykiTtF0bs6fQ+Z1P9s9j5Kxmbd3knzgqVwmKHA7EZXcyo0Rbgr3A5gl1rORSwdYqUCiu3X8M6nOE5hNcBRESLVi;4:uN/2XNZs5sINxKRTIgLTahwDhd0GIf1Xaq5I/HY5M2F4NmfXCCWwj3uZSgiofxWnQCvhPRz2k1p2YZaveBnGnQSjjQgvw2ApM9wmA683DbzfCCEeTFgexuVRlWlnyZSpXQ4vVhfVZdpOujiGwcmQxRQ/XKJ2VgVhyYiAqDcVzTbuCXiLN26SsjHo5tWB96XWoyEnipYJpcM24GwztTCSt1m6Nwk4IP9+lAxt9n+udzH2NKEJviXHpG3VQCN6zrSt2aYqDAa8EFQ4bsZ9Zr9Lkg==
X-Microsoft-Antispam-PRVS: <DB3PR0302MB3211C34A00F99F9472DB6684E7780@DB3PR0302MB3211.eurprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB3PR0302MB3211;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0302MB3211;
X-Forefront-PRVS: 070092A9D3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(366004)(396003)(346002)(39380400002)(39860400002)(189003)(199004)(51914003)(97736004)(77096007)(59450400001)(80792005)(6666003)(76176011)(86362001)(106356001)(66066001)(117156002)(36756003)(65806001)(105586002)(31696002)(26005)(53936002)(386003)(53546011)(31686004)(478600001)(72206003)(4326008)(6246003)(956004)(65956001)(55236004)(966005)(39060400002)(25786009)(47776003)(229853002)(2616005)(2906002)(16576012)(316002)(7736002)(11346002)(305945005)(93886005)(476003)(64126003)(8936002)(2870700001)(186003)(50466002)(58126008)(6116002)(6306002)(3846002)(110136005)(68736007)(7416002)(8676002)(67846002)(2486003)(52146003)(486006)(5660300001)(16526019)(81166006)(81156014)(6486002)(23676004)(52116002)(65826007)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0302MB3211;H:[192.168.1.122];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: epam.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjNQUjAzMDJNQjMyMTE7MjM6amx6eUM0NGhKanBQWEpza1ZWayszMVJE?=
 =?utf-8?B?NmppcFhSaWhvekVVZEhwQm1Dc3Urb1lKVzgrMkRWQ1g3RVBnYzVqaFNXak5I?=
 =?utf-8?B?L1VBc3pXdVYwWjArcG8wY1A4SFI0VHZ2K1lUclpRaWZic09rVUpwdHJnR3pt?=
 =?utf-8?B?MndWbUU1V1Z2ZWpEcFAyVE1GRjVyNFFsekVlM01UbWxia0o0QWVVbHhXYjJJ?=
 =?utf-8?B?UFhmd1JxdUlVdXR4YzQrQ21SK0ZmekcrRjN1WTdEZFJUUThxQmdYcEVRSmFu?=
 =?utf-8?B?VkdwU21DQXVKUVdKL3UxejZVZ3FkVGJGbnc2UE5BbHlEaGZDSEpZVktiTFBa?=
 =?utf-8?B?eWJMOUIrRXZKc2x2cmlORTM5aTJWWkdhM0prdTFya1h5K0tQeUFYSHJySHNC?=
 =?utf-8?B?b203R0w4SHFjM2lPSDFFcW5aVmZJamJsSHVXYk1FVFVkUnJxQTMxbXhpcnZJ?=
 =?utf-8?B?ZDFtSFZLajJrbm9JaDR0aEl5SXZwd2pZbStnZ1dPOXdybytwR1BtZ1V6UFRM?=
 =?utf-8?B?L2QrTTNnaGtYV1JTa2V6ZXlFM0ttK2J2dGtHTlFHQ1VGTkI0aDJMdFNHcFg2?=
 =?utf-8?B?WGVtWU90bHlidHluTDNqdjVLNEdPT3Z2bHptRHdVajF2UWh5Vll3L3ZOcHh5?=
 =?utf-8?B?RGFEYVMza2xvWVB1TnFvNGNPcVVLMjNWbnlwUTBlSzVML203TCsyS29icjRV?=
 =?utf-8?B?THZabUhueTNsSFFUaitBQTNnVXNRME9IdjErZVVHMmtnQmgrUE9FWnU5ZkJL?=
 =?utf-8?B?V0JQVXdibkcwZTRmOTNBcFNqbXRaQnQzcjNqNnZ4YTFuWTRkREFJaUtXK01a?=
 =?utf-8?B?Lzd3ZUVzTXVxeUFMZStPdFRDUEsxYkhaNG1QVERrSXFPOTMrR3BtTGFFQTZW?=
 =?utf-8?B?c0d1QklGK0lGb2lSa2ExbThBbndzS0swNDdpS2VJTDdpbmxETDFoVkNYNUhR?=
 =?utf-8?B?L0doNjRVUkZ4N0NZNmpqaWplc0VUeVplNVlUbm9XU3U2SVJxZkU4b0pSd1Fw?=
 =?utf-8?B?SFZzM0djcGNNMi9KNUtQL0hvN3ptcEpORUl5MzF6ZHUwbG5kUTVWU29EVExq?=
 =?utf-8?B?elh4QTRiUTZUbHZFRU90VVZEajNYcnpaQmg0RUc5R2Z6Y3Q1NnRmamgrYUY0?=
 =?utf-8?B?SFNHS0JDbk1OMFIxbFk5dzV6THZMek9vMTVUTTFUd0Mza1VCMEx5Tm9jbHZ6?=
 =?utf-8?B?TE5JQVNxblNiT1dVS2JrRTFVUGVabGdaUzF0MFZJWnp1cUd2ZUZYMmFYRlpR?=
 =?utf-8?B?UDVDWGxURm5OUkRHMWlkTW9wNzNsaFNuZkNuRzQyVDRCUGJjckxLSThCRVhO?=
 =?utf-8?B?bUFXMVl5NHRlSmZaM0hWWnBFUmxQMVFIS0ZmWm93ZFZ6RUkwNUNZUEc5QUZJ?=
 =?utf-8?B?cTJaQ2YwdGgzRlRRMzRGZXFyUGl6S2RCSUhRaEhwMTd6bXFzZm5rNytsbC9n?=
 =?utf-8?B?NXQ2S2lLRUYyRTA1SlViaGIzWHNnWjlacnlSK1ozcS8yWUNnNzBTenU4MVhx?=
 =?utf-8?B?N0NNTjg4THpHK0oyeit6M0MwelQvWHNEWlFQY0U5NlUwUlgrQ0tDcEV0d05S?=
 =?utf-8?B?LzdEUC9ObzJLV2dhbnk3ajYvZi9pNGY5ZkpsOHIvZ1RVRWxWWjRJNVFOdGdp?=
 =?utf-8?B?eXI3dS8zU2JrZ1pZM2NxVklTK21FVlZyYWkxL3JucTlpZmI0Qkp3V2h3UnVw?=
 =?utf-8?B?TzBjZGZQNS9zOWlaZTlBVTBPNnU4V0lxVzF5QWFRc21KYklRc1J4Z2tTVlJ3?=
 =?utf-8?B?WEJDd2owSmt1SWpiNlQ2Z0Y5VVlMOWZxZmE5MmszRTJmaUhUTnNuRWFJZ2xi?=
 =?utf-8?B?RE05UXJ6WnZzOHVYbXpVUzJhbHA0VmUvd1FFK3Z5WlhuZVQwR0hSb01Db1RQ?=
 =?utf-8?B?cGtrU1U4RnV1dkVCc0NqMWNPdytOOWtBbzJ6VWtrQk9obWdIRHR2Z1R0TmVi?=
 =?utf-8?B?MmYyVjRHQmJ5SUVKYjV0dWlvK3poOFkzVzFVaVNGT0NGa1JQVEEyOXg1dUxG?=
 =?utf-8?B?ZDR3Yk5DbksyS2o5VkhPU1YyTC9FdDJwT0hCK29XN0lSYTRLNFhQVFgyY3A0?=
 =?utf-8?B?OUFLdXhmUTFvNWNtWEpMMHlJY09GWERReGZrTmtTeDlHdTBZNHM1Q1hRWENS?=
 =?utf-8?B?ZWJXT1ZoYVhvSkNFdmp4bFN6T3V1SWtYUllZNEQ5NDNQRjhNT1EvWG16QjdS?=
 =?utf-8?B?Rmxqb29WZDBPeFh1V3U0UTU5Y3Axb1IvTzdkRVplSjJMdG9sZkVCUmRtcGlj?=
 =?utf-8?B?d1dxOEVZdTZLTkhFd2sycC9SZnJycU9rNFQ3aHFkSXpWN3Y0YWVka2tBPT0=?=
X-Microsoft-Antispam-Message-Info: LJolKfQPYbXz3BKmpQZROCb75ufwHGTGddv/MGnKN25NM6tc/Lz4xrR0dFwM6sckxjjpaseOnR7CRQZxyfOkBE02u9FkzIzfV7FmL+Qw6wds6P8uL2zhJMK1VBUr6M4+yZJQjnsLyZNYlVyIaJolUGtu1rxIxzp5qe061w1OLy516Uu5/7WOf83glwrpnR8x
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0302MB3211;6:Ma9ktVD70Tc620dzrPUldIdlckQOIxp2x9F9VFZhcPmpmf3kfdylSm2CdAZBotCqdnj4sL33WKjt1O+j4tbHLox6CD3RhxKhL99X/MCsKubttDICCQW/NEVOkgoqmTO6ZgQg+LZTaZ0lGirZIXSMY1UhOKwR1mzJXnKsXxMrOCqiIqDvL1Hc+rPizzxrFctD3548eX14jjYrAEViXHZcXnpwCKooBU8LKTL0d10nJJC0dPt/n9mRuUAjX9nGVNg/XYbynEttrPSlP5cUdyKxHI4DDM4F+G2AQdEOjBKVhVU7jugKfK43NeNeZppLewoJEai+5an0i4CJFkVfONqvDFwNNU/3NivfFBNEerIeQl3xFWATGl3MdvNH6xu96yyUhMtIDlY5rIIYBk4AvSWALoiw1fGdEnOWQrGUZHWALyKgcOoFiRN+vayAURUJgh9R3WT8H+BIjR4Muu7s/FTSiQ==;5:EiEoXiwEm5CJBnxAhPPskrsCF3VahsDwAFVfb3dKbTnJpFgto80d07hRsPpW7AXJbehH5kcNi99H3jdc/3NgJozIUyz4WTRq0w4RxznTqjo9FlgJWTxjP8zBKwAtc3K52jFzzVXrfFu/9db4k1v2O1FksDcUcVIbizDNKd7vfK4=;24:2bTmzfoSSV5qLZyHVWJGDe0xUa7BWoctu73u5w8tUXJlnaKOC4EzRQ9Xg5ri4I/KgyCkio7AerP+ZGPFKV+OsIwxv5XcrajEU6DxANYD8qM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0302MB3211;7:FHgealm1qo//ZYP78s8aIepdYSwNoeiUlLdOV1ilpPxhfK+KNtdjIgPeGTvH7COw6w5ZK/tjidKpoIVCW9IcbN5m78P9r4eBBcgHV5VvFFrl50dldAEf+UWkgSpcGFj7z44lY1daoebFuaqRgu1dq92WeQnT5bKD6zUqxq/SWthFs23RYfARrs8le/8Lu9UFJ6pAMbIA0EW9QMaTMHPAOqot40J1mZ78BO0WMx55KuGnAThdGbEs6hrIR++DHqBQ
X-MS-Office365-Filtering-Correlation-Id: f2c4ab68-a002-494b-0d98-08d5cfbf22f9
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2018 17:16:53.7386 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2c4ab68-a002-494b-0d98-08d5cfbf22f9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0302MB3211
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/11/2018 07:51 PM, Stefano Stabellini wrote:
> On Mon, 11 Jun 2018, Oleksandr Andrushchenko wrote:
>> On 06/08/2018 10:21 PM, Boris Ostrovsky wrote:
>>> On 06/08/2018 01:59 PM, Stefano Stabellini wrote:
>>>>>>>>>>>       @@ -325,6 +401,14 @@ static int map_grant_pages(struct
>>>>>>>>>>> grant_map
>>>>>>>>>>> *map)
>>>>>>>>>>>               map->unmap_ops[i].handle =
>>>>>>>>>>> map->map_ops[i].handle;
>>>>>>>>>>>               if (use_ptemod)
>>>>>>>>>>>                   map->kunmap_ops[i].handle =
>>>>>>>>>>> map->kmap_ops[i].handle;
>>>>>>>>>>> +#ifdef CONFIG_XEN_GRANT_DMA_ALLOC
>>>>>>>>>>> +        else if (map->dma_vaddr) {
>>>>>>>>>>> +            unsigned long mfn;
>>>>>>>>>>> +
>>>>>>>>>>> +            mfn = __pfn_to_mfn(page_to_pfn(map->pages[i]));
>>>>>>>>>> Not pfn_to_mfn()?
>>>>>>>>> I'd love to, but pfn_to_mfn is only defined for x86, not ARM:
>>>>>>>>> [1]
>>>>>>>>> and [2]
>>>>>>>>> Thus,
>>>>>>>>>
>>>>>>>>> drivers/xen/gntdev.c:408:10: error: implicit declaration of
>>>>>>>>> function
>>>>>>>>> ‘pfn_to_mfn’ [-Werror=implicit-function-declaration]
>>>>>>>>>         mfn = pfn_to_mfn(page_to_pfn(map->pages[i]));
>>>>>>>>>
>>>>>>>>> So, I'll keep __pfn_to_mfn
>>>>>>>> How will this work on non-PV x86?
>>>>>>> So, you mean I need:
>>>>>>> #ifdef CONFIG_X86
>>>>>>> mfn = pfn_to_mfn(page_to_pfn(map->pages[i]));
>>>>>>> #else
>>>>>>> mfn = __pfn_to_mfn(page_to_pfn(map->pages[i]));
>>>>>>> #endif
>>>>>>>
>>>>>> I'd rather fix it in ARM code. Stefano, why does ARM uses the
>>>>>> underscored version?
>>>>> Do you want me to add one more patch for ARM to wrap __pfn_to_mfn
>>>>> with static inline for ARM? e.g.
>>>>> static inline ...pfn_to_mfn(...)
>>>>> {
>>>>>       __pfn_to_mfn();
>>>>> }
>>>> A Xen on ARM guest doesn't actually know the mfns behind its own
>>>> pseudo-physical pages. This is why we stopped using pfn_to_mfn and
>>>> started using pfn_to_bfn instead, which will generally return "pfn",
>>>> unless the page is a foreign grant. See include/xen/arm/page.h.
>>>> pfn_to_bfn was also introduced on x86. For example, see the usage of
>>>> pfn_to_bfn in drivers/xen/swiotlb-xen.c. Otherwise, if you don't care
>>>> about other mapped grants, you can just use pfn_to_gfn, that always
>>>> returns pfn.
>>> I think then this code needs to use pfn_to_bfn().
>> Ok
>>>
>>>> Also, for your information, we support different page granularities in
>>>> Linux as a Xen guest, see the comment at include/xen/arm/page.h:
>>>>
>>>>     /*
>>>>      * The pseudo-physical frame (pfn) used in all the helpers is always
>>>> based
>>>>      * on Xen page granularity (i.e 4KB).
>>>>      *
>>>>      * A Linux page may be split across multiple non-contiguous Xen page so
>>>> we
>>>>      * have to keep track with frame based on 4KB page granularity.
>>>>      *
>>>>      * PV drivers should never make a direct usage of those helpers
>>>> (particularly
>>>>      * pfn_to_gfn and gfn_to_pfn).
>>>>      */
>>>>
>>>> A Linux page could be 64K, but a Xen page is always 4K. A granted page
>>>> is also 4K. We have helpers to take into account the offsets to map
>>>> multiple Xen grants in a single Linux page, see for example
>>>> drivers/xen/grant-table.c:gnttab_foreach_grant. Most PV drivers have
>>>> been converted to be able to work with 64K pages correctly, but if I
>>>> remember correctly gntdev.c is the only remaining driver that doesn't
>>>> support 64K pages yet, so you don't have to deal with it if you don't
>>>> want to.
>>> I believe somewhere in this series there is a test for PAGE_SIZE vs.
>>> XEN_PAGE_SIZE. Right, Oleksandr?
>> Not in gntdev. You might have seen this in xen-drmfront/xen-sndfront,
>> but I didn't touch gntdev for that. Do you want me to add yet another patch
>> in the series to check for that?
> gntdev.c is already not capable of handling PAGE_SIZE != XEN_PAGE_SIZE,
> so you are not going to break anything that is not already broken :-) If
> your new gntdev.c code relies on PAGE_SIZE == XEN_PAGE_SIZE, it might be
> good to add an in-code comment about it, just to make it easier to fix
> the whole of gntdev.c in the future.
>
Yes, I just mean I can add something like [1] as a separate patch to the 
series,
so we are on the safe side here
>
>>> Thanks for the explanation.
[1] 
https://cgit.freedesktop.org/drm/drm-misc/tree/drivers/gpu/drm/xen/xen_drm_front.c#n813
