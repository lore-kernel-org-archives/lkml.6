Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3461DECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 22:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5F532064D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 22:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=SierraWirelessInc.onmicrosoft.com header.i=@SierraWirelessInc.onmicrosoft.com header.b="dvLc+zrt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5F532064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sierrawireless.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388219AbeGWXTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 19:19:42 -0400
Received: from mail-eopbgr720052.outbound.protection.outlook.com ([40.107.72.52]:27136
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388077AbeGWXTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 19:19:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SierraWirelessInc.onmicrosoft.com; s=selector1-sierrawireless-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DrW0AL6xiXNj5GSLncnzrLDl/Q1aHNw16R3yEAim5sc=;
 b=dvLc+zrtoEJDig5+Dc9B2tC9Rc5ANztRev8M0vLSgjpPLuuaKZr9b/acIKFLSYRxQg5rWMIN4TvpHU5QpRpvdrJw4/RB5y6KiaUO8YsVqmXRq0m8syxHxEqzC2o2/+Fo/IhN+8TTuF/aoj7xzyyT1n0xVvowaIWDhF8fiFRCeeA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=DFrey@sierrawireless.com; 
Received: from [10.1.70.11] (208.81.120.1) by
 CY1PR0201MB1435.namprd02.prod.outlook.com (2a01:111:e400:5318::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.21; Mon, 23 Jul
 2018 22:16:15 +0000
Subject: Re: [PATCH v4] iio: chemical: Add support for Bosch BME680 sensor
To:     Himanshu Jha <himanshujha199640@gmail.com>,
        Daniel Baluta <daniel.baluta@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
References: <1532122284-19602-1-git-send-email-himanshujha199640@gmail.com>
 <20180721161934.75066d97@archlinux>
 <20180721153607.GA11127@himanshu-Vostro-3559>
 <CAHp75VegzWr8Q2idzAWpc5Nw3T5n=vWkMvspe0YGRwEQ_h0p+A@mail.gmail.com>
 <CAEnQRZC80FWN9EADvE9geu773=vwRmE0JEwSfy_DMjig0d=qqw@mail.gmail.com>
 <20180722222153.GA10066@himanshu-Vostro-3559>
From:   David Frey <dfrey@sierrawireless.com>
Message-ID: <a1c8c770-18b4-1722-2672-ee0e8abab611@sierrawireless.com>
Date:   Mon, 23 Jul 2018 15:16:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180722222153.GA10066@himanshu-Vostro-3559>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [208.81.120.1]
X-ClientProxiedBy: YTXPR0101CA0016.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::29) To CY1PR0201MB1435.namprd02.prod.outlook.com
 (2a01:111:e400:5318::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6dd490a0-889c-46b1-dbf6-08d5f0e9e88e
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:CY1PR0201MB1435;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB1435;3:Pfgfsam+Qgk1hFholwQ5w3AaYi6yV0nFale3YaenEk9rE5TWVvH2Zx0bWKRtqDwS/I7DfgZMQNnGcRk+oJOANdbIp8cCuPHQv0b91J2FrDCMo6i6zOD4jxOamYr73F72PyKmgOdVnaJCejQn62CZI1aJfRRF7dzpw8hSriEv6khPgC9FGWgD/yAeqOnBD6bNIrFcKQRl5KdDqu2D8Dx1LhoCBeVpaY5Zzcf+6Jx2Yc2lpn8hpvFG084WHNddP3cz;25:vdb8PWdS8hp1Zy0jxXjn6zIJ2KJ4IQ3JCpx62+8tZiekYE8BU0joRfaRhdTyQLSBf1JAfL0nusQPksxxHvKtjdsDcoUZ0p6DTQSZweftHW6W/ZjbsS3SFMgBAhuYVUTApoyseDJzHRvz0zrr9xrTBP3aMF2skIACfI7iVdgNONQSklth7C17s+PfpsTTUsVVNavBiPKshnLBeQZTIb7WHHK8DRQkEc/pjHQZ4SuUgn2/Y9NO327ILsgHx94IkIg9Dz67+oRscyHCfnNRkwphLyhIBv3o2jq3pweqHFmbHTngAdUBkAO3pcxvnAr1mIs3OHnrI563ycWVi6RR2mFM6Q==;31:iq7GKuiy3/muVhklBlhzZkhEnh/z2ovuNFL1ZSUlxcA3RWjC9MBrSIJWy4DnStiM4+ulkS/FLNAcmbxwpsrPh4SUFNEIIbgo8tooqyEhiWpLzKoZasozDW5tYHu3YXnIvCgOUgeH0ZUUl4wvdqe6QN7UAnuQ3BJtfi9PJ1p1NXUBXTDDtLLNGW4XLLO4fcvdCGmjgREXZzXIeIyVygIRkkT6X/VrXe5iZA6ZXUpnlvI=
X-MS-TrafficTypeDiagnostic: CY1PR0201MB1435:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB1435;20:Bv3b4O8WzKnPF9nHAqZLVuKJq/tTCqUH2EXlL8a5QHmEQiQ4eiAHxorv8nC8WXPrgLOZoR3AwnnjNd680nUQ+Q7cEQVDfa/8nzCWZawovc12kTIL653CmcuaSBkYW60hBR1/RW+7/ZRD9CeSnA9V3UYFf7v88PKQKtoc8CMDzNpUrqLajckkY/f6LaLblEGBQ6gpaPKE6o0kFkiDC6DHzRAjBKdjekN4mx1qXGaOFp1djCMkZz8IifkFscBXIwGCpEfiGsFM3QcGsnZwqdoLxxK2tZ+oz03VKSpD+WfbwxDjSZuoDmEEFICR60vsO1yXF0Vm4K5UdlOf4vd9bbhHmTXa3GkEtygkZmQQUYvNSU7zH7qCx3Y0kdy3CFUPHCjoCCgoSKLvvytTpHmtyp53DYvQs8nlP4BTUv4tc5/XWIWrQF+rLIYPG5iuXkgY+X2304BF3BYdjVuo4UdCrbpZc1ZjOAXdSsamwmVWQiltgccLlAHqb3LR2uCE+B0aZDiy;4:3Va+5PzhS0R1DE1EjZ9ZMYUxvGCZh+Q15ZYOXk9UiqbYdfX/aGlYkqTkkoQ+QLD1ncxycbxletNIqxt06yBAy2nVHzOSY0L9Pz36A2tFDacE4EiTjJps+NaEJOzMeYTvzC5B5JBePjeYsQ9w4TzEmgiFXM1YvKfH2V/dUgx0cB09KSq8tM9WwBeJJPph5/dJ8yz2M/CKEgreX6t4oDqrEx2dPxnKJ28OYgF8SCwqglP4Mt9SmbIJb5cHs75fnQIcwhqaXKM8Gf3r7Hz8klbwmbfd+8L5aPfEQjsfCPRAMeqs8Ru/3PEK7V2jhH/R9bcxC1CPLKD+4k4+4WRYm98Qfw==
X-Microsoft-Antispam-PRVS: <CY1PR0201MB143544CBCE640B3F5FEC8246C7560@CY1PR0201MB1435.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(788757137089);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:CY1PR0201MB1435;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0201MB1435;
X-Forefront-PRVS: 0742443479
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(376002)(136003)(346002)(396003)(39860400002)(199004)(189003)(230700001)(6116002)(3846002)(966005)(72206003)(80792005)(36756003)(53936002)(39060400002)(4326008)(478600001)(97736004)(25786009)(6246003)(31686004)(66066001)(65956001)(65806001)(47776003)(105586002)(106356001)(3260700006)(486006)(476003)(5660300001)(229853002)(6666003)(316002)(2906002)(86362001)(305945005)(68736007)(6486002)(956004)(2616005)(446003)(186003)(11346002)(16526019)(6306002)(77096007)(58126008)(53546011)(386003)(26005)(76176011)(50466002)(67846002)(54906003)(16576012)(52146003)(2486003)(52116002)(81156014)(8936002)(110136005)(8676002)(31696002)(65826007)(64126003)(81166006)(7736002)(93886005)(23676004);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0201MB1435;H:[10.1.70.11];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: sierrawireless.com does not
 designate permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTFQUjAyMDFNQjE0MzU7MjM6bXJlSFlQS2VVS0RhanlJV2JtRm5WdVoz?=
 =?utf-8?B?dm1WVktGYXJCNDdqMkV6cEdEdDM0Z3dOd0N0NzQ1Skx4eUEwWWk4VzdFNzRt?=
 =?utf-8?B?cHRMalpRVzV5NktSRGZDVEVveGFpSEV6NXdHWTA3cjF2M2d0Z3BvRG80aXNk?=
 =?utf-8?B?QlA1MEttSGZNandhM1Z1MjdaSHYwT2FqWjl4aGJkc0l0U3JIVEkxSGYxNnc2?=
 =?utf-8?B?Y0gxRDlORjlKZlVGNnFEbHh1YTlSSDA4Z0NPTWR1N1FyWHF2TDU2YVg0M1Zz?=
 =?utf-8?B?OHZLMER6NnRlcVkrMHdqNXRzVEtBOG9HUUdKcW9vK2locE9JVVRPdGk4Sk15?=
 =?utf-8?B?WFlwaTRYM1VGbERrdkpPcUZacGJhaHIwVGxjQkVPWk8yaUtBaFZKS09GYk01?=
 =?utf-8?B?SUwvMWhFWUR5RHNDN0Flc0lTSnUxbmw1M09LU3RIT3U4c2s1UERQcnZhVnpX?=
 =?utf-8?B?ZEpJVFNEMHNSbVNWRVZsUzA4Vi9GL3FFNE1CSWNUVThQUlF3OTBHQTJ4bVZp?=
 =?utf-8?B?SGdBTlZyVjNQQkxQTW1OWWlDaVRvVTNyaFRTR1haSmlTODRMOTNCajQ1c1BZ?=
 =?utf-8?B?MzhMTlZTUE9GakRIanp0UzM1YjFqVHVCaGRoUUJGeW1iVDF0SXpvZkJ0dkl5?=
 =?utf-8?B?VUVkNm1pdzVXN2VERHpJNkVmTkpxYmVlMS80ak5WcWUycmEzUWIwQ1RSNW5N?=
 =?utf-8?B?am1EcnBBRlowTUw2Y212aXpReE1sK2dlNXhPRWlNK3dYMmxQYnlSb1d4bGpU?=
 =?utf-8?B?VFRrM2dWckRJVlZOOHVCWmtGaW4yNVRQU25JM2RqcjBWNUpNRGo4OS9HUzlO?=
 =?utf-8?B?RkxEQUI1aEpscUpjNUs3VUtuSzRIWGhZSFI0U213cHJENS8yLzBKWFlWM1JW?=
 =?utf-8?B?Rm5NNDJmSjVSVHRVTm9DbWIyYkVod1RhL2FJRkJuL0ltR0R2VU5pbW9ET1NB?=
 =?utf-8?B?dXM2ampaSlRGbjBxVS9sQTB4TzRJVHo4ZTJwTTdwak9kSXBET3pCbUVJVE1H?=
 =?utf-8?B?MEVHTmtpT2ZTL0ZTZ1UwL0NOV0gzbGtZaC91ZTBKQUxrMFgxdkxqaFpBN3Zy?=
 =?utf-8?B?U3ZKRDZqVGRCSExlZmllQ0pIYS9Ea3JlNVl3U2tEM1Mwbmd5a3JLSGxoVnZ5?=
 =?utf-8?B?RTlhZTN4ck1DR3lZRStaRHpyWXA3V2g0L2JoYWlZNmRQMXJVSVZuSlY4L0ht?=
 =?utf-8?B?SVpaaklkYXdiMXA0ajdscExvVzBmWmpyYW5BU21TejhZSEkzVFA5N1IyWWJj?=
 =?utf-8?B?eW90ZzRjb3lvK0FCWlhhUVU3aXl4YU11RHhZM2tCQ3hhU050WmxTeFZxYTNs?=
 =?utf-8?B?b251MHpMa1RmajlkK0pyemQwUjl5TG9EenZTQmtHOXFNUzY0QVZXRE1wYkM2?=
 =?utf-8?B?cjBKSGxDMmxQc3pDTjVvVmZHTUI3cjlsSUlzOGZqK1B5ancrL0czMTkranNB?=
 =?utf-8?B?UzF4RDJxUkhyUnZMcndQb3VadDlLK2Q1bFFzSFZkQzlXeE5SSTBVaHpwQmtR?=
 =?utf-8?B?NWp2aEtiOEtTYmZGM3AxdFZldlZzYVducGpHTVB2azYxZ0hpVDlpcnp6dy9O?=
 =?utf-8?B?Ky9GRkpLYzFQUE85VkJQVE5KY1FOV2hGUjJ5dTNRYjZQcFA0UUNjaU12SXdW?=
 =?utf-8?B?bHZOTitidWxyYm5qR2t0ZkcwRjRpZDVhR1FFT3VVSzVWYkpsei9Hb2c2M3Bw?=
 =?utf-8?B?aVgxaVhaS1gyd1hoVW9Zdm1GZU5MWDIzVFErWlNkZ1ZwNmxXSlRRcHFDSTNE?=
 =?utf-8?B?RkdHYW10NnZ1dGxDbEZSN2dORW5TU1g4aVAxT0RMWk9tQ01nRkcvQmtoTnpV?=
 =?utf-8?B?dGJ2Y2h6TXlrRXNrZHMyVWlsOWxqWVlNTnA4azZ4b0txa0JNN3RVdFloRklP?=
 =?utf-8?B?Z08zeitGN1hqNXVVck9WbUdadVllWEs2d0JZTS9PU0FjS1EyL0RReUVUSTUx?=
 =?utf-8?B?UC9TclVpbERkdU9CNjJaelFRTW91bTdjUkF0R2Nra29QSzVQd0cwZEVZYUNa?=
 =?utf-8?B?U0VwaDJaQktDZEc3dzhGbklFalRraUpkWUpTNVhDa1VjMWJrNHBzcGt4aGhU?=
 =?utf-8?B?QVdhQXYybTBFUGowK0JhWnk5bXpnbmQ1dSszVG9FZFlqRCt5TE1MNDlCaGxX?=
 =?utf-8?Q?ObouiQI6dN2yrLNJwAmsz/jUNYxQeK3IlFkPS82OdwMWCv?=
X-Microsoft-Antispam-Message-Info: zqwwF5HmU5M9eRpWLxVTW8LVmtbcTakofcQ3YVgbxYp1R8hio7Jf8/zmEUMg632j6cwHFF3bkrhXbKeHx48QlnMlOURCQbVSVCXDpK6e9ORhB6/+yDoWo9i2Wp1WrVJx6QlEzGpI8cPYjbjaRbXxrL7aV2KuhwcQnV9+yOqMdfmjLv674uPV5iLLJzzvB9e1CR93PtCFnYF7OH8psw/wJvF2xJjWTR4LsWes6azomSyVqMmCVZ9lEs4xJXnPrS7wgGPcKWJzwH7EaRHXL0fRsS8gRIgtwDxHST1bixKy9C6pRRTHsDrifwwMd2tTh3JMsLsPBWuRfkZD1S0tM+TzRJx/iYvuVOoltXPhzSMYjmw=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB1435;6:mn6HcIWsHz9I3c+54Jq7rYs0hWRkjDdEkojhs/vDIEEvZKA2J00SLk8OlfuSH3ZNHeqW7UOE0y0cs9ERkCOizbvbXdGCCmZK4Uzjnta91WrWwfC2VUIfakzaiajRJioOmAgGeJliqF+Bf+j89uFyTbWGWvRW2YODZkE5rtp0rMVK0g2gg95s7s4wwlTEwjIG0O4tbck08lxYXM/uyRZH5evOQq21nD8leVD8raHGUhumYkhxNj5QNN0sxF/Ujor7HcxjEm4g1rwwD5VbKOo3DfgGqeMtFexE3FVMBwh6Iwkgd9dW3GGh9sYu6gXupX9FTcmTXcegQRaBwDz2Z1KG9HMGBqAd/268zG8GP7LJKRFZE+6zNfgFePL44TKlPxKz69rbTjCteQEyoSGl7fQe4v9X9NM22Za5pV3qSRULW5clYejLvwJtva0xD19q6AUVJD7qMSuv2tZ0BhUrGcFvAA==;5:VW86SCExXVFIqgtFih+CdTVWPQQfxBd5fG9NaKOeRrYqWwFqZ6L8Vt4hHcLWcn+PAxShg80HfZKclCuaXZbG2+A9HBhjyXAqUFDMPx3R5Wq9+wTJisMgoIYjs21p6aQ1cG53shkkYdlT0QhtTS/fWsbhRCR2PRRUd1zN6wI69eo=;7:qjlQVEzL1xFvyWt9fjsG5tKuuWv/qnunXrxh3btqpx4PKxyb1uJuatiAxgwxEPCXdMm8ZrCy5QCVwgHMcpSL4USKfzdczQJxBCU7ZlbedPoRfRNlSnKNmV27SKshZc9EUtmkq2xz1ZnbwCUIFjDaQNsoRdOGoyVLTaOzRMnSfZZmMy8W3noj0M1ROP1dmebde+ZxGMRuJdjxbtLArCEnxXXsLJuGUlcYydrOgEj5PeJEpdokaBoWagIuvWfBHFvR
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: sierrawireless.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2018 22:16:15.5953 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dd490a0-889c-46b1-dbf6-08d5f0e9e88e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 08059a4c-2486-43dd-89e3-3a747e0dcbe8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0201MB1435
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/22/2018 3:21 PM, Himanshu Jha wrote:
> On Sat, Jul 21, 2018 at 08:45:34PM +0300, Daniel Baluta wrote:
>> On Sat, Jul 21, 2018 at 6:43 PM, Andy Shevchenko
>> <andy.shevchenko@gmail.com> wrote:
>>> On Sat, Jul 21, 2018 at 6:36 PM, Himanshu Jha
>>> <himanshujha199640@gmail.com> wrote:
>>>
>>>>>> +   /* Look up table 1 for the possible gas range values */
>>>>>> +   u32 lookupTable1[16] = {2147483647u, 2147483647u, 2147483647u,
>>>>>> +                           2147483647u, 2147483647u, 2126008810u,
>>>>>> +                           2147483647u, 2130303777u, 2147483647u,
>>>>>> +                           2147483647u, 2143188679u, 2136746228u,
>>>>>> +                           2147483647u, 2126008810u, 2147483647u,
>>>>>> +                           2147483647u};
>>>
>>> This one needs perhaps a bit of though, but...
>>>
>>>>>> +   /* Look up table 2 for the possible gas range values */
>>>>>> +   u32 lookupTable2[16] = {4096000000u, 2048000000u, 1024000000u,
>>>>>> +                           512000000u, 255744255u, 127110228u, 64000000u,
>>>>>> +                           32258064u, 16016016u, 8000000u, 4000000u,
>>>>>> +                           2000000u, 1000000u, 500000u, 250000u, 125000u};
>>>
>>> ...this one obviously just a not needed one. You may replace it with a
>>> one constant and simple calculation to get either value (index from
>>> value, or value from index).
>>
>> Indeed this can be reduce to:
>>
>> 125.000 << (15 - idx).
>>
>> The real question here is if we approximate 255.744.255u to 256.00.00u how
>> much different is the result. Being a gas sensor I think it is very
>> hard to appreciate.
>>
>> We can go with this formula + adding a comment with the table with the
>> exact coefficients.
> 
> So, I have planned to use this 125000 << (15 - idx) equation with
> approximating the array members.
> 
> About the difference in results we would get after approximating isn't
> much of a problem IMHO because gas sensor is primarily used for IAQ, and
> IAQ is relative to the resistance reading.
> 
> For eg:
> 
> Resistance(ohm)			IAQ
> value < 30K			Very bad
> 30k < value < 50k		worse
> 50k < value < 70k		bad
> ...
> ..			
> so on..
> 
> So, what I simply imply is the scale will be adjusted and nothing else
> changes, unlike if it had been pressure, temperature, humidity.
> 
> The IAQ implementation is userspace application suggesting
> good/bad/ugly air quality.
> 
> And since we know David Frey is planning to use this sensor in his
> product mangOH board.
> 
> So, David, how are you planning to use the gas sensing part in your
> product ? RGB leds, buzzer, alarm ?
> 
> Thanks Andy for the suggestion :)
> 

My understanding is that the Bosch BSEC (Bosch Sensortec Environmental
Cluster - https://www.bosch-sensortec.com/bst/products/all_products/bsec)
software calculates the indoor air quality (IAQ) which is presented in
the range of 0 to 500.  BSEC is proprietary, pre-compiled static
library.  I don't know how they derive the IAQ, but it seems that it
could be based on smoothing outlying gas resistance values and 
integrating other values such as temperature, humidity and pressure.
Unless this driver can somehow produce IAQ values of equal or greater
reliability to the BSEC library, then I would prefer that it just
present the raw gas resistance value so that a user can write a program
to feed the sensor data into BSEC.

mangOH isn't really a traditional product.  It's an open hardware board
designed around Sierra Wireless cellular modules that run Linux.  So I
don't have any specific use case in mind, but I want to enable our users
(and thus future products) to make use of air quality measurements.
