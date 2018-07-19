Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79632ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 19:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1012F206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 19:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="svw5DND7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1012F206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730058AbeGSUbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 16:31:52 -0400
Received: from mail-db5eur01on0132.outbound.protection.outlook.com ([104.47.2.132]:35808
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727534AbeGSUbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 16:31:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IN6xXo96TSY2QVPeTGDEWagjUglU8kLktRwmNrfXiYY=;
 b=svw5DND7a4hirylTCwXNuLpJ0meNNd2hNZCSOCpkbnwpBAJUclZk9k1banusEtBNIR9gkY3MQ2MkSmJM/h7/R8jo/JG888KtihQytHAPaKA0qT/m7mUupNDM7192AgcP1tbCSIJbKuCwhHBPXm3xFBSeBd8aqst4niiI3Gs/lN8=
Received: from [192.168.13.3] (85.226.244.23) by
 AM5PR0201MB2452.eurprd02.prod.outlook.com (2603:10a6:203:35::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.18; Thu, 19 Jul
 2018 19:47:05 +0000
Subject: Re: [PATCH v5 5/6] i2c: Add Actions Semiconductor Owl family S900 I2C
 driver
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        wsa@the-dreams.de, robh+dt@kernel.org, afaerber@suse.de
Cc:     linus.walleij@linaro.org, linux-i2c@vger.kernel.org,
        liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        andy.shevchenko@gmail.com, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        manivannanece23@gmail.com, thomas.liau@actions-semi.com,
        jeff.chen@actions-semi.com
References: <20180719174405.7210-1-manivannan.sadhasivam@linaro.org>
 <20180719174405.7210-6-manivannan.sadhasivam@linaro.org>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <d945bfe1-5f6c-4949-5098-4861f9664d02@axentia.se>
Date:   Thu, 19 Jul 2018 21:47:01 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180719174405.7210-6-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0172.eurprd05.prod.outlook.com
 (2603:10a6:3:f8::20) To AM5PR0201MB2452.eurprd02.prod.outlook.com
 (2603:10a6:203:35::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91fc865c-851b-4925-bebe-08d5edb0688e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600067)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0201MB2452;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;3:0sxkme58j5QRXG7SFhEblaqg9ZxHIOwpF/Konrg+Qc1vy4LRPDLn2DAQCnuWQdRhcEQ61a01OdSL+gJ/kLWgKrFeJbcvLfIN4brunnTq++FgoUR9VYwBxTNsQ5SJvzvDMp8bI1taXucO4GmQazeNj6acXTkHikzK7xIByzXpusQhCNnm4skNohd+mD4d6Lyp8OQiwB+BfW8CjzUJfTkq9rzJUyfjyoGBK3VmgGlmq4/N0shj3E4c/k4jTysLvp3/;25:nWBPBn857I51AhERETg4JfN6ANcj9Kj9osQ6ilKtbMF7v4q2AD1RWqBHCg2RGL8cj02X9qqRWWubNRUlZC+DLvNFOUEl4O24mhbBn1v1+WLJkAfARxFZfiuBragQwdAYKA3n7Z+EgN6BpHvekOA6xX4+o0zfWaRJn/beeQUrmsHTzx/ee/aPU+pA6w9j7FhYiZ5t2Q7jaCumHwnAKqYRc1FQ85M+0v/wW/zMK39b+m1Ht0H354DIub5ZfcdUyZ99awmviWz+x0Iu2GShp3/kdBie2uK2EA6WtSZimX5GjKyf8fodTmQHdstToSA9t8ZXCBItNjRgGBiZqsLd+1PxUw==;31:bIFrxyuHQMlPQxPmwWwOIcpPvwqauzXnjFVgQQyGJAqUjW2TJFTVRb8ReciMBgGGd7hKmt2ntqP4kju+EyGbXlDSNcNaAAHU5nv7r0a3vNYLXggd5uK5l0CnfpjPPJY6ETZ061bDASk0Z78lQEnGtjDg/jfHakj/5j+WdepOZs6DErWdLGzo64cvx0DRkVFtQFKJiJ7GdQmv/Wwvo0BXcJngOeK/r2SUwzKxGelPl1A=
X-MS-TrafficTypeDiagnostic: AM5PR0201MB2452:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
X-Microsoft-Antispam-PRVS: <AM5PR0201MB2452EF31680A56785967F685BC520@AM5PR0201MB2452.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(31051911155226)(106291317490208);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(2016111802025)(6072148)(6043046)(201708071742011)(7699016);SRVR:AM5PR0201MB2452;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0201MB2452;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;4:cgDBlJuYb0cpbKlb+PhI4kykRR2Kgu3GzcjlqLjn1keO3p+Qqjz3K+uStJcS3Z8pGTfvp28UX2G4m95msnRWnMTBVnOyyacJ9sAK6uF8POXlYvsh/zX8tQESv3bg9sscTV3DCh4TErTfF3PwacllkGz/Yj8sCtccOGwWyU2WLGTaZV+SiEloK794KjUCC8MU9VuPGgs40ZDfRKCrKNLqQ91Z1y5tXwhsdLL6muuoZh+3uiz7ypjLjGUtc/umLCkRQaA02CQHbuAScJzbgiax0WFZvFkfpV1ex30+ccbSaxgNswGX5NMppeLggQJR3CrRaIJ08wV4MJctUxSz/70JrSo7BKjLQF2m/BfHhpP9CJg=
X-Forefront-PRVS: 0738AF4208
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(979002)(6049001)(376002)(346002)(136003)(366004)(39830400003)(396003)(189003)(199004)(966005)(6486002)(26005)(386003)(551934003)(3260700006)(25786009)(65806001)(65956001)(66066001)(117156002)(64126003)(97736004)(229853002)(2616005)(4326008)(956004)(50466002)(16526019)(77096007)(74482002)(53936002)(476003)(486006)(47776003)(68736007)(186003)(53546011)(446003)(6306002)(11346002)(36756003)(105586002)(31686004)(14444005)(52116002)(8936002)(5660300001)(6116002)(58126008)(81166006)(76176011)(230700001)(2906002)(16576012)(81156014)(6246003)(478600001)(3846002)(31696002)(305945005)(65826007)(7736002)(6666003)(39060400002)(575784001)(23676004)(52146003)(316002)(2486003)(86362001)(36916002)(8676002)(7416002)(106356001)(42262002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0201MB2452;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjAyMDFNQjI0NTI7MjM6bjF1aWJkVVJhNWY2djZmSlJ6TEZhSEJM?=
 =?utf-8?B?YWMyT3M2NGNqOTMwOFFUVWw0dGdKSnF1Tnhzd3ZMb0U4b3QrY29rdmpXOGhV?=
 =?utf-8?B?Q01PbzBGVDZlZnFEUTlOcXFraW93Wm1mVGlKVUJNRTlranJmOVJtbWlaU1My?=
 =?utf-8?B?Yjh2eWNTVGw2UDJpT1lIUmdwWGVCbjhtRm5BVEV4aHF4SjcwOCtwQmNwa1Ni?=
 =?utf-8?B?TFBiRHZqRkVYbmZ0TjRyU2RIanpoUnd0TWV0bHpucVNwVnNPUUxvZzFaREd1?=
 =?utf-8?B?ZXhzekd3OVVuQU5KaWt3cXV2bXVBMWV1b20zbzRsNGpaSHZaNWlMd0dVYm5x?=
 =?utf-8?B?bERXeC9pd2VvOU90NDg4SXI2OE11QjNFZ0JmaHhaaHdsYWhHV2VEM0xpUlA4?=
 =?utf-8?B?ZnltVVRUdGhVMktQa1hGaXF3QWJmYnpWS3BkMnZtUWVCV2l3ZEQybG5zbHk0?=
 =?utf-8?B?TEFhdHNMN1REclMrSS9sWmNCaE00UHVIZU8zZlV0dVA5OUZPbERGNnpjcVZa?=
 =?utf-8?B?QWRLVjJjb09neERpTFJKNUtSOTBjNWZubXVtbG9jQTBsZjFmVmRMVUFKaTdx?=
 =?utf-8?B?aVJ4K2lQMndXYkI5N09vTFNSR1RmNXJMZ0dhTGdsSlVVNzZLZGNTL3N0MElL?=
 =?utf-8?B?eERidURzWko2ZXVBS3g0dEphZXZKOEtFNnJYMjhMcHhyRThyU2Y0TUhFeE5P?=
 =?utf-8?B?czBNZDM2bzlyQ0NTTzN2RWMvZUpia1owcyttVHVZOGRlK0RnZGI0K2xKUG90?=
 =?utf-8?B?aXU2R1JHMzRReUhjZUFmb0o0YlJiOTVFTGxBK1NqZm4wRlc3RHFIelltNWNw?=
 =?utf-8?B?d0g0RjBSOEE3TWN4cFdhZTlOcjI3R1hpa2xUcGFGYkU5azZFZ0NDZ2llbHdl?=
 =?utf-8?B?akhDcjJhcVYzQUI2K00vdmtSOFAxc1Y3RjYyaklkN1Bic2Z4enNGS1NMUW4v?=
 =?utf-8?B?bmxHd2xpOWRlQlZwdFp1WXRuWlRlTzlKT3BzT0dOcDJzaDFnNDJqUzc1RmZa?=
 =?utf-8?B?RlI0ejVMK3RZaGhjWHNkWEFOblFhS25kelpOb2VhbTU0bkRERjVDVmZ4N3hj?=
 =?utf-8?B?QnF5SUhPUkdQNDAwdkQ2T1B5dVBJZi94TGZZYzVPd2JGQTZWU3pGK2lBUnF2?=
 =?utf-8?B?MUNsTk00RjlmTWx6b1NhQlZDSHd3RHd5QWYrVTgzM0RjbE8vWjlDTko4NUtH?=
 =?utf-8?B?S3JJR1FNRFUxSWtVOFdkQ0ZwVnNDOXRsUklqZWFzRi8rd3VYYjRseERWZGV1?=
 =?utf-8?B?c3paYnFJY21TNkUxeERMMGpsUkNsL3pscHpvWm9Cc0RKdW5BdlJwalFDQ1A5?=
 =?utf-8?B?S3NEcWp1aVpQRVBGS2E1aGpWaTcrdnd4YnpMS3BXRjdxcXVNN1I1c1lINmhB?=
 =?utf-8?B?T1BTclJtYjJ0dTJ0WXlndDhUMkxzRXFEN0hOcnpOcnd0cmtxVjdoL2pEQlkz?=
 =?utf-8?B?Sm1OT0ZMMXFBdUloM1U1NzRKMXpoVmlvVUhsdEIwamdmMXRwSFVxRGNRbmRo?=
 =?utf-8?B?Mm5EaHVrcmwxM2ZCK1d6d0w4LzRXeHdXZGIrTVl1SWJnb2ZTTWVSUFcrTk5m?=
 =?utf-8?B?UkJjRGphcVU4WnJoMGVJVnpBVmMrS3oxaGdZR0tXQnR2WHJoMkR3bUZONjVy?=
 =?utf-8?B?UHJUWk1sT1A4cG5QN3k0cDdrR1ZsNzdkSHVoQkpZdEIwRURqRVBLQ0hJWGlI?=
 =?utf-8?B?STFvMzk0SExDTmx1OG9QdXQ4RU94djJkazdTVDB6TFZET2lHUHBBQWFoSS9u?=
 =?utf-8?B?aGRSb2VrY3FOcHdWN1NxaGk0bkNKemVoREZhdEpvUVVtcENDQ0dFYVVOdVZR?=
 =?utf-8?B?RzFaWDVuMjJNVlRmNkhGTEpZQWhiTGZMNmhzQXVkbGdDWE5VNHZSMUNJdkRH?=
 =?utf-8?B?MW9MR2xXazVXY25BUnFsQ3hqUkV5NEpseVc3U3hxajRqSllwWUJLSHdvZVNy?=
 =?utf-8?B?dEgwRXJ6UzNDelk0MmhqZTkzSjhpUVYvNjNxeFBuUUs1UkN4SThNa1gwcFBX?=
 =?utf-8?B?bmo3VkJHenFvL1A4OEJsNmZrcDV1anBrNFBmaTRacEVaUVdwaDNsemRQZFFm?=
 =?utf-8?B?RWYrQnQ2YWZ6TGtrSFM0dCtYMGtTTU9pM1J4NzVZRXlXVi95MjJQcnFGdDZ3?=
 =?utf-8?B?Z2k0UTNoeG54RVdacWhWY2hPV1pHd2JlYTlrOGRTRUMxQ2FHRGpjeGNCN1Ux?=
 =?utf-8?B?VkRhb2dPdnBuY01HeFNHTVUySGJ1WHJiQ0dPaktXdExHcVFoWUgvcEZHSCtl?=
 =?utf-8?B?dW8vWnh5UjVuT0oybjIyTUJueDVxRlZhWWpYODNJakRaNkdjbHlQRGtoS0RB?=
 =?utf-8?B?SUFTSllzajBhSi9kQmczTVAzc3JjNmlaVFJBb3NvRzhMVU9DNk9GbmtMRmR4?=
 =?utf-8?B?K2liTnoydUpmcHFYOFJXdz09?=
X-Microsoft-Antispam-Message-Info: p03ukXC9lZO9va4AEOPY8yRS3ldea5uJ9ZAmldJzoTqY+FyXCrCB/dpWJMbaAYGXjO8mhcmNbMtvqMDlHHZCziLIacFJivtZmNIh9SUTzFAjNfmU0WTh7JwbKhVmuEVsY5eG2cjPgUeAAZd0XXjJ2whgOrBllQ6chNtuwpnVPG/uoJRaHm56HIHMlonEtuRPpDD/a3gkwkix96Bt1McMqp9aZemqEtGeqyKdK9ZuHUV5Jhr6IsY3Fh5g2OoTdD0TYM6ERc8TzOm5u8/7yhpJbTzR/jhXYD8PSDeWlDvMDONlw++TzjMcrWCVqaDecctQVAxkpNHk2iC9X1+QIQE+Kz8WUoMmYhz7oxOjjwAcnJQ=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;6:jFqCGqbEj1j1hGuCRFWwVt1XWVpLzJyAMb4foFsfWx4RPVHbLWQvPx4mmJu8icSJUJBxEqO+EjcZEvELjQkvzVJkV0VBQFiU7TCJTJXSDQ/r8DtR28QO4c92I0NAxQhJENDsEmkMEvDPdJEjcB/hopuHE/VCAiCyjpf2bphcp/g/Fs5aOtGSY7XL58ovCrDvGyu2iiJ8WHdA5U3U0dTwzgyGS67P/CUh5JT3D3yyZt1yPRdSmyREeUxn4M6wTD60+0hw2MFi0R3GOzS5DCOE+NNR5wX2Rl35c9DkSV/7Ru4H/u2Ffzw3zcjpeClEjAg7sxGNKUbdDwg8Q0+xZvoqwkWO9oOKhLCOU7AsE67OOmq0dJ501IEycB8LI+0hJmImOoWRm0WS7yOymC8hqOQX79x8B9HfalSr4lzzwV0Rd2R6sNr5PDmB3VLRQdpv/jsUJwmqz8sQdbpMSahfV7dRQw==;5:gKtdInGpY5eJmPmdSZ8n/fAOt9CIlHlzcU3rIoQ5dDkedCAOwpEynYis3wrR13670UTo6tIJY3lc+yRca31Ep//4j1xEgKGqUSB5ci89eLonpiYFiISpO+1QEUpvWQs9m6GW9aglOQR6ZGcnFSCiUTDpWdeAqOMz1z879qyDhL0=;24:SPYaulsKvZzNGUTDER4F82xCfeeM6emnl6JPMFlZN4bOgnbfw/zlRJ2+UIjVcJFu1LNja7OOTRjJV3z8H/DAgqu4L4XmLidfPsO8kpL3+44=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;7:l1TnZv22oa5IFTqBckzfmJDgaOE7BzKDkwXdG3ZObirV1gN2y/niNX4h4AcxHRIrzLhqV4cG7yvN1quhcHSQcTm+SD71M9zEwRZ9NFgZBAlkicRfoxr6MNcGuVOasHPINLG+8rkg8t/tgnvzyIAY8/Wr4/r31SXqwWSqb9bLyaxusqk34i7x6SgYV2u3zx7BxzVrUASGnGo6BuWKrK4acP5jQ/QHeq5mMdobFbnmpqiNpjrh9BjRZxM2sxb/xr3f
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2018 19:47:05.1224 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91fc865c-851b-4925-bebe-08d5edb0688e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0201MB2452
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-19 19:44, Manivannan Sadhasivam wrote:
> Add Actions Semiconductor Owl family S900 I2C driver.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Acked-by: Peter Rosin <peda@axentia.se>

Ooops, now I noticed some missing newlines in your dbg_* prints. That
may produce garbled output, which is unnecessary. While at it, I also
spotted a few more white-space nits...

Have you tried the --strict option to checkpatch?

Cheers,
Peter

> ---
>  drivers/i2c/busses/Kconfig   |   7 +
>  drivers/i2c/busses/Makefile  |   1 +
>  drivers/i2c/busses/i2c-owl.c | 495 +++++++++++++++++++++++++++++++++++
>  3 files changed, 503 insertions(+)
>  create mode 100644 drivers/i2c/busses/i2c-owl.c
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 4f8df2ec87b1..8c8025f87ce4 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -762,6 +762,13 @@ config I2C_OMAP
>  	  Like OMAP1510/1610/1710/5912 and OMAP242x.
>  	  For details see http://www.ti.com/omap.
>  
> +config I2C_OWL
> +	tristate "Actions Semiconductor Owl I2C Controller"
> +	depends on ARCH_ACTIONS || COMPILE_TEST
> +	help
> +	  Say Y here if you want to use the I2C bus controller on
> +	  the Actions Semiconductor Owl SoC's.
> +
>  config I2C_PASEMI
>  	tristate "PA Semi SMBus interface"
>  	depends on PPC_PASEMI && PCI
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> index 5a869144a0c5..b71618f77880 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -76,6 +76,7 @@ obj-$(CONFIG_I2C_MXS)		+= i2c-mxs.o
>  obj-$(CONFIG_I2C_NOMADIK)	+= i2c-nomadik.o
>  obj-$(CONFIG_I2C_OCORES)	+= i2c-ocores.o
>  obj-$(CONFIG_I2C_OMAP)		+= i2c-omap.o
> +obj-$(CONFIG_I2C_OWL)		+= i2c-owl.o
>  obj-$(CONFIG_I2C_PASEMI)	+= i2c-pasemi.o
>  obj-$(CONFIG_I2C_PCA_PLATFORM)	+= i2c-pca-platform.o
>  obj-$(CONFIG_I2C_PMCMSP)	+= i2c-pmcmsp.o
> diff --git a/drivers/i2c/busses/i2c-owl.c b/drivers/i2c/busses/i2c-owl.c
> new file mode 100644
> index 000000000000..4f5836fa5022
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-owl.c
> @@ -0,0 +1,495 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Actions Semiconductor Owl SoC's I2C driver
> + *
> + * Copyright (c) 2014 Actions Semi Inc.
> + * Author: David Liu <liuwei@actions-semi.com>
> + *
> + * Copyright (c) 2018 Linaro Ltd.
> + * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +
> +/* I2C registers */
> +#define OWL_I2C_REG_CTL		0x0000
> +#define OWL_I2C_REG_CLKDIV	0x0004
> +#define OWL_I2C_REG_STAT	0x0008
> +#define OWL_I2C_REG_ADDR	0x000C
> +#define OWL_I2C_REG_TXDAT	0x0010
> +#define OWL_I2C_REG_RXDAT	0x0014
> +#define OWL_I2C_REG_CMD		0x0018
> +#define OWL_I2C_REG_FIFOCTL	0x001C
> +#define OWL_I2C_REG_FIFOSTAT	0x0020
> +#define OWL_I2C_REG_DATCNT	0x0024
> +#define OWL_I2C_REG_RCNT	0x0028
> +
> +/* I2Cx_CTL Bit Mask */
> +#define OWL_I2C_CTL_RB		BIT(1)
> +#define OWL_I2C_CTL_GBCC(x)	(((x) & 0x3) << 2)
> +#define	OWL_I2C_CTL_GBCC_NONE	OWL_I2C_CTL_GBCC(0)
> +#define	OWL_I2C_CTL_GBCC_START	OWL_I2C_CTL_GBCC(1)
> +#define	OWL_I2C_CTL_GBCC_STOP	OWL_I2C_CTL_GBCC(2)
> +#define	OWL_I2C_CTL_GBCC_RSTART	OWL_I2C_CTL_GBCC(3)
> +#define OWL_I2C_CTL_IRQE	BIT(5)
> +#define OWL_I2C_CTL_EN		BIT(7)
> +#define OWL_I2C_CTL_AE		BIT(8)
> +#define OWL_I2C_CTL_SHSM	BIT(10)
> +
> +#define OWL_I2C_DIV_FACTOR(x)	((x) & 0xff)
> +
> +/* I2Cx_STAT Bit Mask */
> +#define OWL_I2C_STAT_RACK	BIT(0)
> +#define OWL_I2C_STAT_BEB	BIT(1)
> +#define OWL_I2C_STAT_IRQP	BIT(2)
> +#define OWL_I2C_STAT_LAB	BIT(3)
> +#define OWL_I2C_STAT_STPD	BIT(4)
> +#define OWL_I2C_STAT_STAD	BIT(5)
> +#define OWL_I2C_STAT_BBB	BIT(6)
> +#define OWL_I2C_STAT_TCB	BIT(7)
> +#define OWL_I2C_STAT_LBST	BIT(8)
> +#define OWL_I2C_STAT_SAMB	BIT(9)
> +#define OWL_I2C_STAT_SRGC	BIT(10)
> +
> +/* I2Cx_CMD Bit Mask */
> +#define OWL_I2C_CMD_SBE		BIT(0)
> +#define OWL_I2C_CMD_RBE		BIT(4)
> +#define OWL_I2C_CMD_DE		BIT(8)
> +#define OWL_I2C_CMD_NS		BIT(9)
> +#define OWL_I2C_CMD_SE		BIT(10)
> +#define OWL_I2C_CMD_MSS		BIT(11)
> +#define OWL_I2C_CMD_WRS		BIT(12)
> +#define OWL_I2C_CMD_SECL	BIT(15)
> +
> +#define OWL_I2C_CMD_AS(x)	(((x) & 0x7) << 1)
> +#define OWL_I2C_CMD_SAS(x)	(((x) & 0x7) << 5)
> +
> +/* I2Cx_FIFOCTL Bit Mask */
> +#define OWL_I2C_FIFOCTL_NIB	BIT(0)
> +#define OWL_I2C_FIFOCTL_RFR	BIT(1)
> +#define OWL_I2C_FIFOCTL_TFR	BIT(2)
> +
> +/* I2Cc_FIFOSTAT Bit Mask */
> +#define OWL_I2C_FIFOSTAT_RNB	BIT(1)
> +#define OWL_I2C_FIFOSTAT_RFE	BIT(2)
> +#define OWL_I2C_FIFOSTAT_TFF	BIT(5)
> +#define OWL_I2C_FIFOSTAT_TFD	GENMASK(23, 16)
> +#define OWL_I2C_FIFOSTAT_RFD	GENMASK(15, 8)
> +
> +/* I2C bus timeout */
> +#define OWL_I2C_TIMEOUT		msecs_to_jiffies(4 * 1000)
> +
> +#define OWL_I2C_MAX_RETRIES	50
> +
> +#define OWL_I2C_DEF_SPEED_HZ	100000
> +#define OWL_I2C_MAX_SPEED_HZ	400000
> +
> +struct owl_i2c_dev {
> +	struct i2c_adapter	adap;
> +	struct i2c_msg		*msg;
> +	struct completion	msg_complete;
> +	struct clk		*clk;
> +	spinlock_t		lock;
> +	void __iomem		*base;
> +	unsigned long		clk_rate;
> +	u32			bus_freq;
> +	u32			msg_ptr;
> +};
> +
> +static void owl_i2c_update_reg(void __iomem *reg, unsigned int val, bool state)
> +{
> +	unsigned int regval;
> +
> +	regval = readl(reg);
> +
> +	if (state)
> +		regval |= val;
> +	else
> +		regval &= ~val;
> +
> +	writel(regval, reg);
> +}
> +
> +static void owl_i2c_reset(struct owl_i2c_dev *i2c_dev)
> +{
> +	owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_CTL,
> +			   OWL_I2C_CTL_EN, false);
> +	mdelay(1);
> +	owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_CTL,
> +			   OWL_I2C_CTL_EN, true);
> +
> +	/* Clear status registers */
> +	writel(0, i2c_dev->base + OWL_I2C_REG_STAT);
> +}
> +
> +static int owl_i2c_reset_fifo(struct owl_i2c_dev *i2c_dev)
> +{
> +	unsigned int val, timeout = 0;
> +
> +	/* Reset FIFO */
> +	owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_FIFOCTL,
> +			   OWL_I2C_FIFOCTL_RFR | OWL_I2C_FIFOCTL_TFR,
> +			   true);
> +
> +	/* Wait 50ms for FIFO reset complete */
> +	do {
> +		val = readl(i2c_dev->base + OWL_I2C_REG_FIFOCTL);
> +		if (!(val & (OWL_I2C_FIFOCTL_RFR | OWL_I2C_FIFOCTL_TFR)))
> +			break;
> +		usleep_range(500, 1000);
> +	} while (timeout++ < OWL_I2C_MAX_RETRIES);
> +
> +	if (timeout > OWL_I2C_MAX_RETRIES) {
> +		dev_err(&i2c_dev->adap.dev, "FIFO reset timeout");

End with a newline.

> +		return -ETIMEDOUT;
> +	}
> +
> +	return 0;
> +}
> +
> +static void owl_i2c_set_freq(struct owl_i2c_dev *i2c_dev)
> +{
> +	unsigned int val;
> +
> +	val = DIV_ROUND_UP(i2c_dev->clk_rate, i2c_dev->bus_freq * 16);
> +
> +	/* Set clock divider factor */
> +	writel(OWL_I2C_DIV_FACTOR(val), i2c_dev->base + OWL_I2C_REG_CLKDIV);
> +}
> +
> +static irqreturn_t owl_i2c_interrupt(int irq, void *_dev)
> +{
> +	struct owl_i2c_dev *i2c_dev = _dev;
> +	struct i2c_msg *msg = i2c_dev->msg;
> +	unsigned long flags;
> +	unsigned int stat, fifostat;
> +
> +	spin_lock_irqsave(&i2c_dev->lock, flags);
> +
> +	fifostat = readl(i2c_dev->base + OWL_I2C_REG_FIFOSTAT);
> +	if (fifostat & OWL_I2C_FIFOSTAT_RNB) {
> +		dev_dbg(&i2c_dev->adap.dev, "received NACK from device");

End with a newline.

> +		goto stop;
> +	}
> +
> +	stat = readl(i2c_dev->base + OWL_I2C_REG_STAT);
> +	if (stat & OWL_I2C_STAT_BEB) {
> +		dev_dbg(&i2c_dev->adap.dev, "bus error");

End with a newline.

> +		goto stop;
> +	}
> +
> +	/* Handle FIFO read */
> +	if (msg->flags & I2C_M_RD) {
> +		while ((readl(i2c_dev->base + OWL_I2C_REG_FIFOSTAT) &
> +			OWL_I2C_FIFOSTAT_RFE) && i2c_dev->msg_ptr < msg->len) {
> +			msg->buf[i2c_dev->msg_ptr++] = readl(i2c_dev->base +
> +							     OWL_I2C_REG_RXDAT);
> +		}
> +	} else {
> +		/* Handle the remaining bytes which were not sent */
> +		while (!(readl(i2c_dev->base + OWL_I2C_REG_FIFOSTAT) &
> +			OWL_I2C_FIFOSTAT_TFF) && i2c_dev->msg_ptr < msg->len) {

Misaligned.

> +			writel(msg->buf[i2c_dev->msg_ptr++],
> +			       i2c_dev->base + OWL_I2C_REG_TXDAT);
> +		}
> +	}
> +
> +stop:
> +	/* Clear pending interrupts */
> +	owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_STAT,
> +			   OWL_I2C_STAT_IRQP, true);
> +
> +	complete_all(&i2c_dev->msg_complete);
> +	spin_unlock_irqrestore(&i2c_dev->lock, flags);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static u32 owl_i2c_func(struct i2c_adapter *adap)
> +{
> +	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
> +}
> +
> +static int owl_i2c_check_bus_busy(struct i2c_adapter *adap)
> +{
> +	struct owl_i2c_dev *i2c_dev = i2c_get_adapdata(adap);
> +	unsigned long timeout;
> +
> +	/* Check for Bus busy */
> +	timeout = jiffies + OWL_I2C_TIMEOUT;
> +	while (readl(i2c_dev->base + OWL_I2C_REG_STAT) & OWL_I2C_STAT_BBB) {
> +		if (time_after(jiffies, timeout)) {
> +			dev_err(&adap->dev, "Bus busy timeout");

End with a newline.

> +			return -ETIMEDOUT;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int owl_i2c_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
> +				int num)
> +{
> +	struct owl_i2c_dev *i2c_dev = i2c_get_adapdata(adap);
> +	struct i2c_msg *msg;
> +	unsigned long time_left, flags;
> +	unsigned int i2c_cmd, val;
> +	unsigned int addr;
> +	int ret, idx;
> +
> +	spin_lock_irqsave(&i2c_dev->lock, flags);
> +
> +	/* Reset I2C controller */
> +	owl_i2c_reset(i2c_dev);
> +
> +	/* Set bus frequency */
> +	owl_i2c_set_freq(i2c_dev);
> +
> +	/*
> +	 * Spinlock should be released before calling reset FIFO and
> +	 * bus busy check since those functions may sleep
> +	 */
> +	spin_unlock_irqrestore(&i2c_dev->lock, flags);
> +
> +	/* Reset FIFO */
> +	ret = owl_i2c_reset_fifo(i2c_dev);
> +	if (ret)
> +		goto unlocked_err_exit;
> +
> +	/* Check for bus busy */
> +	ret = owl_i2c_check_bus_busy(adap);
> +	if (ret)
> +		goto unlocked_err_exit;
> +
> +	spin_lock_irqsave(&i2c_dev->lock, flags);
> +
> +	/* Check for Arbitration lost */
> +	val = readl(i2c_dev->base + OWL_I2C_REG_STAT);
> +	if (val & OWL_I2C_STAT_LAB) {
> +		val &= ~OWL_I2C_STAT_LAB;
> +		writel(val, i2c_dev->base + OWL_I2C_REG_STAT);
> +		ret = -EAGAIN;
> +		goto err_exit;
> +	}
> +
> +	reinit_completion(&i2c_dev->msg_complete);
> +
> +	/* Enable I2C controller interrupt */
> +	owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_CTL,
> +			   OWL_I2C_CTL_IRQE, true);
> +
> +	/*
> +	 * Select: FIFO enable, Master mode, Stop enable, Data count enable,
> +	 * Send start bit
> +	 */
> +	i2c_cmd = OWL_I2C_CMD_SECL | OWL_I2C_CMD_MSS | OWL_I2C_CMD_SE |
> +		  OWL_I2C_CMD_NS | OWL_I2C_CMD_DE | OWL_I2C_CMD_SBE;
> +
> +	/* Handle repeated start condition */
> +	if (num > 1) {
> +		/* Set internal address length and enable repeated start */
> +		i2c_cmd |= OWL_I2C_CMD_AS(msgs[0].len + 1) |
> +			   OWL_I2C_CMD_SAS(1) | OWL_I2C_CMD_RBE;
> +
> +		/* Write slave address */
> +		addr = i2c_8bit_addr_from_msg(&msgs[0]);
> +		writel(addr, i2c_dev->base + OWL_I2C_REG_TXDAT);
> +
> +		/* Write internal register address */
> +		for (idx = 0; idx < msgs[0].len; idx++)
> +			writel(msgs[0].buf[idx], i2c_dev->base +
> +			       OWL_I2C_REG_TXDAT);

It's better to split bwtween arguments than in the middle of one.

> +
> +		msg = &msgs[1];
> +	} else {
> +		/* Set address length */
> +		i2c_cmd |= OWL_I2C_CMD_AS(1);
> +		msg = &msgs[0];
> +	}
> +
> +	i2c_dev->msg = msg;
> +	i2c_dev->msg_ptr = 0;
> +
> +	/* Set data count for the message */
> +	writel(msg->len, i2c_dev->base + OWL_I2C_REG_DATCNT);
> +
> +	addr = i2c_8bit_addr_from_msg(msg);
> +	writel(addr, i2c_dev->base + OWL_I2C_REG_TXDAT);
> +
> +	if (!(msg->flags & I2C_M_RD)) {
> +		/* Write data to FIFO */
> +		for (idx = 0; idx < msg->len; idx++) {
> +			/* Check for FIFO full */
> +			if (readl(i2c_dev->base + OWL_I2C_REG_FIFOSTAT) &
> +				  OWL_I2C_FIFOSTAT_TFF)

Misaligned.

> +				break;
> +
> +			writel(msg->buf[idx], i2c_dev->base +
> +			       OWL_I2C_REG_TXDAT);

Prefer splitting between arguments.

> +		}
> +
> +		i2c_dev->msg_ptr = idx;
> +	}
> +
> +	/* Ignore the NACK if needed */
> +	if (msg->flags & I2C_M_IGNORE_NAK)
> +		owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_FIFOCTL,
> +				   OWL_I2C_FIFOCTL_NIB, true);
> +	else
> +		owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_FIFOCTL,
> +				   OWL_I2C_FIFOCTL_NIB, false);
> +
> +	/* Start the transfer */
> +	writel(i2c_cmd, i2c_dev->base + OWL_I2C_REG_CMD);
> +
> +	spin_unlock_irqrestore(&i2c_dev->lock, flags);
> +
> +	time_left = wait_for_completion_timeout(&i2c_dev->msg_complete,
> +						adap->timeout);
> +
> +	spin_lock_irqsave(&i2c_dev->lock, flags);
> +	if (time_left == 0) {
> +		dev_err(&adap->dev, "Transaction timed out");

End with a newline.

> +		/* Send stop condition and release the bus */
> +		owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_CTL,
> +				   OWL_I2C_CTL_GBCC_STOP |
> +				   OWL_I2C_CTL_RB, true);

Prefer splitting between arguments.

> +		ret = -ETIMEDOUT;
> +		goto err_exit;
> +	}
> +
> +	/*
> +	 * Here, -ENXIO will be returned if interrupt occurred but no
> +	 * read or write happened. Else if msg_ptr equals to message length,
> +	 * message count will be returned.
> +	 */
> +	ret = i2c_dev->msg_ptr == msg->len ? num : -ENXIO;
> +
> +err_exit:
> +	spin_unlock_irqrestore(&i2c_dev->lock, flags);
> +
> +unlocked_err_exit:
> +	/* Disable I2C controller */
> +	owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_CTL,
> +			   OWL_I2C_CTL_EN, false);
> +
> +	return ret;
> +}
> +
> +static const struct i2c_algorithm owl_i2c_algorithm = {
> +	.master_xfer    = owl_i2c_master_xfer,
> +	.functionality  = owl_i2c_func,
> +};
> +
> +static const struct i2c_adapter_quirks owl_i2c_quirks = {
> +	.flags		= I2C_AQ_COMB | I2C_AQ_COMB_WRITE_FIRST,
> +	.max_read_len   = 240,
> +	.max_write_len  = 240,
> +	.max_comb_1st_msg_len = 6,
> +	.max_comb_2nd_msg_len = 240,
> +};
> +
> +static int owl_i2c_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct owl_i2c_dev *i2c_dev;
> +	struct resource *res;
> +	int ret, irq;
> +
> +	i2c_dev = devm_kzalloc(dev, sizeof(*i2c_dev), GFP_KERNEL);
> +	if (!i2c_dev)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	i2c_dev->base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(i2c_dev->base))
> +		return PTR_ERR(i2c_dev->base);
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		dev_err(dev, "failed to get IRQ number\n");
> +		return irq;
> +	}
> +
> +	if (of_property_read_u32(dev->of_node, "clock-frequency",
> +				 &i2c_dev->bus_freq))
> +		i2c_dev->bus_freq = OWL_I2C_DEF_SPEED_HZ;
> +
> +	/* We support only frequencies of 100k and 400k for now */
> +	if (i2c_dev->bus_freq != OWL_I2C_DEF_SPEED_HZ &&
> +			i2c_dev->bus_freq != OWL_I2C_MAX_SPEED_HZ) {

Misaligned.

> +		dev_err(dev, "invalid clock-frequency %d\n", i2c_dev->bus_freq);
> +		return -EINVAL;
> +	}
> +
> +	i2c_dev->clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(i2c_dev->clk)) {
> +		dev_err(dev, "failed to get clock\n");
> +		return PTR_ERR(i2c_dev->clk);
> +	}
> +
> +	ret = clk_prepare_enable(i2c_dev->clk);
> +	if (ret)
> +		return ret;
> +
> +	i2c_dev->clk_rate = clk_get_rate(i2c_dev->clk);
> +	if (!i2c_dev->clk_rate) {
> +		dev_err(dev, "input clock rate should not be zero\n");
> +		ret = -EINVAL;
> +		goto disable_clk;
> +	}
> +
> +	init_completion(&i2c_dev->msg_complete);
> +	spin_lock_init(&i2c_dev->lock);
> +	i2c_dev->adap.owner = THIS_MODULE;
> +	i2c_dev->adap.algo = &owl_i2c_algorithm;
> +	i2c_dev->adap.timeout = OWL_I2C_TIMEOUT;
> +	i2c_dev->adap.quirks = &owl_i2c_quirks;
> +	i2c_dev->adap.dev.parent = dev;
> +	i2c_dev->adap.dev.of_node = dev->of_node;
> +	snprintf(i2c_dev->adap.name, sizeof(i2c_dev->adap.name),
> +			"%s", "OWL I2C adapter");

Misaligned.

> +	i2c_set_adapdata(&i2c_dev->adap, i2c_dev);
> +
> +	platform_set_drvdata(pdev, i2c_dev);
> +
> +	ret = devm_request_irq(dev, irq, owl_i2c_interrupt, 0, pdev->name,
> +			       i2c_dev);
> +	if (ret) {
> +		dev_err(dev, "failed to request irq %d\n", irq);
> +		goto disable_clk;
> +	}
> +
> +	return i2c_add_adapter(&i2c_dev->adap);
> +
> +disable_clk:
> +	clk_disable_unprepare(i2c_dev->clk);
> +
> +	return ret;
> +}
> +
> +static const struct of_device_id owl_i2c_of_match[] = {
> +	{.compatible = "actions,s900-i2c"},
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, owl_i2c_of_match);
> +
> +static struct platform_driver owl_i2c_driver = {
> +	.probe		= owl_i2c_probe,
> +	.driver		= {
> +		.name	= "owl-i2c",
> +		.of_match_table = of_match_ptr(owl_i2c_of_match),
> +	},
> +};
> +module_platform_driver(owl_i2c_driver);
> +
> +MODULE_AUTHOR("David Liu <liuwei@actions-semi.com>");
> +MODULE_AUTHOR("Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>");
> +MODULE_DESCRIPTION("Actions Semiconductor Owl SoC's I2C driver");
> +MODULE_LICENSE("GPL");
> 

