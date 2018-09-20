Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759B5C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1337921526
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="PG85QAQR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1337921526
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733226AbeITVKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 17:10:03 -0400
Received: from mail-eopbgr50071.outbound.protection.outlook.com ([40.107.5.71]:39101
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727162AbeITVKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 17:10:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mt2E08or4llhBJnCY8jBqJe8wZwa+xqTRoKvY+QCVT8=;
 b=PG85QAQRcxrqSN/+2ucM80kjWUrmkkXO+l6WSzP9t1fOFtoXnMwWd/L+RUL0zWCDRkXasjCZM+dIj23k1i0R8+lPseEpvmfqWgGQZQRXlNzIx0NEcPbmb/r3Velpb82MfG0wz1ta4E+6v8cZQuN/gZ8SIPuUtYXpgqXSKC2Bc7w=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Suzuki.Poulose@arm.com; 
Received: from [10.4.13.23] (217.140.106.49) by
 VI1PR08MB3102.eurprd08.prod.outlook.com (2603:10a6:803:46::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Thu, 20 Sep 2018 15:25:56 +0000
Subject: Re: [PATCH v5 12/18] kvm: arm64: Configure VTCR_EL2.SL0 per VM
To:     Auger Eric <eric.auger@redhat.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
        marc.zyngier@arm.com, cdall@kernel.org, pbonzini@redhat.com,
        rkrcmar@redhat.com, will.deacon@arm.com, catalin.marinas@arm.com,
        james.morse@arm.com, dave.martin@arm.com, julien.grall@arm.com,
        linux-kernel@vger.kernel.org
References: <20180917104144.19188-1-suzuki.poulose@arm.com>
 <20180917104144.19188-13-suzuki.poulose@arm.com>
 <dcc855e4-eb78-ea1b-9456-8efa36deda4e@redhat.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <d6314798-d81c-e65a-3e56-f8bc4d6f977b@arm.com>
Date:   Thu, 20 Sep 2018 16:25:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <dcc855e4-eb78-ea1b-9456-8efa36deda4e@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [217.140.106.49]
X-ClientProxiedBy: HE1PR05CA0264.eurprd05.prod.outlook.com
 (2603:10a6:3:fc::16) To VI1PR08MB3102.eurprd08.prod.outlook.com
 (2603:10a6:803:46::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa1f0cde-7e4f-4dbe-ad7e-08d61f0d5dae
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3102;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3102;3:3JKwz9UDvgMdKQVEFdK5drXPmx0kmNXgpRb4+UcXdHl0TGaStlefcLNNsWTCbfszfbs/S3gYVITLiq/jBnNSoYvgOxpGQ0ruepvBL84WeRONB7MydZboAsPxVbRzNSxcYLYR5oQKPmA99LDcsE0RCoErUPDsbSOUb3VWEuCvpjtYB/IoscE9BwXy/Pv7xNUt0pj6C1FZ8cF5Ni3symgZP/ONw0QsSIgZ8f5Ei7BJoKt+C7LO7vFng0JkM61cXYwm;25:KWx/yZCTDwBdRFhDhQfB2JJOwIF/yUiG6n6owetBAlKjelYKDJ7y6J/AWcABjBFZxPAPuN2J9pnjBevvdyOjthc44GRpVffCK/SvPB95QcxbyNAkMAsoKRnedXeXQdAUSA40SduCaGC/+yX8hy+sa6M+2Yetx6UnOxThDXVO48UrjQ6KPwg3ylHC+P3/UUcYIrDYRHy1+6GW86uNxJtAXlOjgROxPRCaLlD2cJAj4XCDtxKfGbegqWc7c0vnwEJ7TLnFtYXrZ+oPXCC9+gVNVrPBhsL55tJORImLHdLUoGwSEDRQTcFGhlPXQwu1tWXZ/oQv6DSIJSNFTmzbgGbuEQ==;31:MF6Mc8HCwrYwyOAUEtJxxm6hQ5aqvGmP4KKPSAN4AkGBT41jwxv5A995rJRc8WIBZKdzT4Bgzp5yqntiXWeUfJI6puGCAoeL4fhbGvHq8GKni2M46C53+SmJG86RYJCFWA4Ls1FYSMGWmgy1a4Eqn3nv9Bf4bBDlQ3DrBpeKtmhAzjxuc3643N7ZMBW/GxhzHlhb/0546PY8+BCWu7zGEqjYuG8wTRxwoamxJQQ/Jpo=
X-MS-TrafficTypeDiagnostic: VI1PR08MB3102:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3102;20:hcnq+CJVK0tVRH0Z0wg7CnS/GnDAn8JhpcnV1W+QJFtn7wDSb0q7R8NwvR4bKO3h/qEi7gLq4Dt75HXHA/tRndOnkHG6i9pQXKwhs2jiZClMqtmhzuxixfgfJg8x0MGGFm9NQFZ89dy7Dj9p4EDs+JM3obIAZldFxkoy3sFHqsPcDXezMAFSN/Sz/UFep5hKK/j+2PFFj5XmHZpr25aRx1tTaiI/aVeqz6+IoTotpzfCzpjYEL9DZjOO/xKo7RpfwexE0Frmj+BxHOmj3ZeVoUnO4BsqzTMoGAexzBCGSRMOsAiqN8ALgrwmnKbGe7RcSrofnUYgr1i0eTjki5EYGsf/s/ThtcDtg7pFo30OyHGBC3Q2/YkaJW/kUst0/8VEjmtnFlAj1RXlEZl2qGxiEFTzo6JwsE/7TBSFRUftAhuYIJQCHZU/PJbTf+A+pTe2QPq/ajHRPmPmI9eqBj8HuORWmIS9lCvPzFJwk5OWVBcJzjbfFwyK+9T1W5n0zzFZ;4:pr6FrUa1Caa/7jQGO1ggX2jjbpjGuJjKLOdjakF295fvbhqyUwdddw30WSp7U3f2UsSDXyPk0y5CTDsZ+fD+KlLpM/f70uxnpBzLZjQyn6iEg71378EBhH04eVYSC1HFizu2d22uiM2EqvIEY8EhtbKkns1wVAEBf5aMuIWPtAUL24cJHI1W7ujKR72B6Ym8bHDROePwTT7jv4VIURuqJ1PqToxk+PYZ2xfniQAjgYZG8OPElhmYg6CR7TqWS5pQ8UBJilAmnRaneezZ/EI0zz6fKG4vMlYMG3x9in/i/WmG2pJcPL7t1snJC+6QU0SY
X-Microsoft-Antispam-PRVS: <VI1PR08MB3102AC41F7FFCDEBBA5721FA91130@VI1PR08MB3102.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051);SRVR:VI1PR08MB3102;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3102;
X-Forefront-PRVS: 0801F2E62B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(346002)(39860400002)(366004)(376002)(136003)(199004)(189003)(40434004)(67846002)(486006)(14444005)(305945005)(7736002)(50466002)(66066001)(64126003)(106356001)(105586002)(77096007)(65956001)(47776003)(3846002)(86362001)(575784001)(2616005)(97736004)(8676002)(81156014)(31696002)(2906002)(8936002)(58126008)(386003)(31686004)(8746002)(16576012)(53546011)(6116002)(65806001)(186003)(316002)(16526019)(26005)(476003)(229853002)(25786009)(23676004)(11346002)(52116002)(81166006)(53936002)(446003)(4326008)(76176011)(2486003)(72206003)(52146003)(956004)(6486002)(65826007)(5024004)(5660300001)(6246003)(478600001)(68736007)(6666003)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3102;H:[10.4.13.23];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4TUIzMTAyOzIzOklEWFhZR3hieERkZWJRRXZDdVM2cUJxRkdX?=
 =?utf-8?B?ZHU2dmZwL3NwUUdWckt6VHJBb1l1WFIrWms3RlB3aFdmSnYvRTR5Nk9NTGQr?=
 =?utf-8?B?WWV4Z0VnMjVBeDlVcHVlL2tmdTRTME5pYWkwajJPdXJJMmRSaERqaWkzQ0ow?=
 =?utf-8?B?Q3p5ZjlJbTA0VmRWRTBLVjdWakNpM2h0aThtbzJPWXd4cVlGMlQyc3pvQkZQ?=
 =?utf-8?B?ZXZaaytSTUxUUUcydFlsUjI5Znd0NEN2N3UzMExnOE9hN0FhQjNGTFBSTXNW?=
 =?utf-8?B?M1NZOHZiMHZYY2tKVUdKNGZSMmRYdFZaVHdya3NYUEM0OWhVUHJ6c3djNWl1?=
 =?utf-8?B?c3gvanVXUXJPaWdxVERhZnd6d1diejdacXUybEpZWDFDMDJCN0RuYk9lNElG?=
 =?utf-8?B?R2xsZFovSVFseEJnTmNVRzBVQUdDcGphRnB6UGE0TFUxSmQvTFFhSFhEZ0tl?=
 =?utf-8?B?TWI5d1oyOTBDRXRSZ1V6VC9oWm9adTZ5TXNVeERETlAwNU1jb0pCK0pQejRD?=
 =?utf-8?B?RG1wUHgwbm85cTh6UmJRaTZwWDJFQzE4TGJFZEUrMVc3UExJekduTDBReVo3?=
 =?utf-8?B?eGZQaS9kWjQweWZqSHdWYUtPc1htWTRBSldDZmpseFk1cDNKUXA1MXVkNG0x?=
 =?utf-8?B?d0ttWVNzaEoxWGYrUTBtRnMyNVl4ZXJWRjdWdWkzQm9FdWptZm40NUZtYVBx?=
 =?utf-8?B?Y1JBSzhPeHdMNERYQ2UybmRScHRSdEJ3MDFkcjVsMlhpakE5dWZla2x1UXZ5?=
 =?utf-8?B?bVlkZGNhandsbXczdnFzUkhWV3lzeWdJMm5QSHlDU2ZXNGdvQzhjV3F4UGxz?=
 =?utf-8?B?RWN2N1BYd2o0S0pSQXBickxJd0NaM0owbVJPVUdzT0JOSHUxcmRSdGxPYnM5?=
 =?utf-8?B?dDBEa3dFakxYWUhNTVNzU3BBVFZaYzJZZ01sRGFZSVVwQ3V5aW8vNzhKVHJ1?=
 =?utf-8?B?NDdtNWVnQXNGcUJiVm5CRTdQYi9RUUdDYXNxMG85aW1nSElNUGNXOVN4ZXlH?=
 =?utf-8?B?Z0Y5a0hSbnJMYm15S3N5Rm0vRU4xNVFlUE5BdDhFdlBkM0t4U1R1MWw3RDhM?=
 =?utf-8?B?NTVSb202WVJGZnFoYmJxN3E2Q015UHdMaUZXY3hOcjJnaFJ3bUF0cmxoVDJI?=
 =?utf-8?B?QncyRTBkT3pOYnVCQ3BreTMraUNOV2NITktrNFRkRmV6blhyMElXdHAwNG1s?=
 =?utf-8?B?TEIzbUROb2VWcTQ0cStzdjY3NmdrMk1xcXdmWDl3UUJtWTdtK0pMUVBqWEFj?=
 =?utf-8?B?NlBmTUsyUWl5c3dmaE0zcUp0bzhFbFVQSUJWb3RDN3hXNVhVVDdrL09HeUVX?=
 =?utf-8?B?cm4zUmlMa0QyZzZVUDZEQWZid0xGUnlxYXhaam5vVEFwSklYSmd6S2wzTUs3?=
 =?utf-8?B?YzNMSEs4NXVPMGpqYTA0UGxnRDZtNUkyTWZUSXJwMEV2QnUxcXFaR0NhMU54?=
 =?utf-8?B?ZU5wVHlxRnk1dTBWMWRPaCtOMUMzVUpwUWFMWkk3ZEZaekpseXdVRHVJNzc1?=
 =?utf-8?B?aVowekZHa3dqUlo4cUg1U2UwYlVNd0ZjdlRSeDJyR0hJWmlJSGlobGdKcHBB?=
 =?utf-8?B?MUkxbGcwbStjTFdjNWFaVFBYQllENUtkTTBsMUd5bFNPc1Y4VXhsR05UYU81?=
 =?utf-8?B?VGtlLytVWVVBZnorNGg5eE1lTCtFQTNRS0xYUHhMSHR6Q2xoL3NJSnZOc0FY?=
 =?utf-8?B?a05pTHJ2enpTUVlJRXBvZFhOa0NuWUNKOTVFRTJUYmVFeldndWkzU0wyNE54?=
 =?utf-8?B?MERkL1ZPdmRJT0MxUHhlUnlleXBFYm14T3NYL2tEbVRWT2dLSzQxWnBrTkZr?=
 =?utf-8?B?ang4czh3MTJhQmw2alJRUDRXMFlBN3ZmYUpCTWkxc0pxa1Z0UHZ4UkkzaTUz?=
 =?utf-8?B?elIrK2wrMHFjNGJycWVxQjNKaUkyNmxpVFJNOEF4aWxiT1BjdjFqb3U5VUFL?=
 =?utf-8?B?MXRLcUt6blo2RkpOeGR0MUpZZ01tRWJTRWtQR2lsa0xjUmZaQnFYV3pXUE9u?=
 =?utf-8?B?TlgwUVdaY1V1QWVGUkFpWTR3bm9lcm9QSUJQSkQzMEorVzJCOUtuMWdjZWFp?=
 =?utf-8?Q?JXBs=3D?=
X-Microsoft-Antispam-Message-Info: bF7lSjKrGMMVeHfU2DHhgpklSU97PM485AZtBGmlaJ0fI5yDpwdiFNt1ZBKJ3nfQSILldm2TMqh2WNsPf7he5wGS6K4KwlKhg7IfhlQ8BMorXiShmRXEZdpTtU4mULAK78kDpwBgwRxnsF61siyeHlRf1td8YC1XY9yC+6kZrpwEhNBILisS9a53Vg7L6Yr1mG4L0WNK1fU70IYpXiZPcKytVcp1g7aYCeN8HpBkqEPewZs9ygj1JkLnvpLMuCaWmmTdrmD/WJlsXNtgY7RCfwQX7Qs/Dj/CAxY+n5Zb0z+01lebvc3Vk5H6Yweq2ZY/YAcTmqqLxFUgMD3dwqSjY1RzGuUm6z0/xctzYbcoeEA=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3102;6:yXBCl8HJ+v5pJSJQHd7MJY3IQFVY7ycB+OTbZ6O4/qDVFNbOoWHjMjISlg//0bEG8EhiuDJXQOPFmh2zz6THNps/Ewa6QY541DhNMzYAKvlYmgCF4zNGndjseOnN+VR9kXAp9IeLmDveW/96vCXV/AUrmt+r7U9Ru72AdVD+ZxtsfPGNr903qT0t35uZFh1Z6X1VEa0KvHd/pfBkgBCSPSGgytqstxkCok6LRN+V5w2ULJxHti7iHoBozUh0poSVP/Ej9t/X7edF4/0OKEnZKAdiCUqpzj01LDx9dDt7i8liTzJK5BYaVGI15Cswj7Oy3nPXmo2XkCr1HICGNxIdl4VH9XXunpM9j3EVNOio58wbh7uGuu2XPMFs/yNrhdisWoE5nQ8JFoF6+MZBeU/2Hp2ql8Ofk8/Oj6K1yar8UeDZ25dg/uC5JWA9XL3UyOlrdoomUPRB9/yVmfkdb2w0Cw==;5:0Is1BlWbjLYXmJp7vb5uOYtHGVomxHFA7vWblJ0hdSoM6InLX589Ft4S60cMyxFcBmcPa06u4mUzbmNOc3IbtAkkmkv+KdBrqG54ciTuqedTzt3o8LUaxU2ZLoOS8hqUA5i2fm9DIpr7+Nd60MrU6BB+8Tr880d+cw7GARor5Pw=;7:qs3OGXB4aMgYzhWH0HKhpF2LkzuPvza6hPpJF6mbuIsTVoFn8eygY+vX104w6oc4teBrERfjGY+4qo/zovWHuD4xtM7CEdG9D9ekriSYYZXAC3mwAwjCOv2YULLImJSHpcNpxuqevZ93zconPnGhZiq6YtOHY4myPvpUCot/RAQc0cEAVLbWdFcpx2GjVKPgIW4dctPIvWXgIucVGs0X2XqmaT3kvnZGQmbYUWFpEeoZBWKLYOFSalI/0ANFPP3/
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2018 15:25:56.9216
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa1f0cde-7e4f-4dbe-ad7e-08d61f0d5dae
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On 20/09/18 15:25, Auger Eric wrote:
> Hi Suzuki,
> On 9/17/18 12:41 PM, Suzuki K Poulose wrote:
>> VTCR_EL2 holds the following key stage2 translation table
>> parameters:
>>    SL0  - Entry level in the page table lookup.
>>    T0SZ - Denotes the size of the memory addressed by the table.
>>
>> We have been using fixed values for the SL0 depending on the
>> page size as we have a fixed IPA size. But since we are about
>> to make it dynamic, we need to calculate the SL0 at runtime
>> per VM. This patch adds a helper to compute the value of SL0
>> for a VM based on the IPA size.
>>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Cc: Christoffer Dall <cdall@kernel.org>
>> Cc: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>> Changes since v3:
>>   - Update reference to latest ARM ARM.
>>   - Update per-vm VTCR value of SL0.
>>   - Add helpers to decode levels from SL0.
>>   - Didn't pick up Reviewed-by tag from Eric, as there
>>     are some new changes in this version


(-)
>>
>> diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/k=
vm_arm.h
>> index 3fb1d440be6e..5c1487dc5dca 100644
>> --- a/arch/arm64/include/asm/kvm_arm.h
>> +++ b/arch/arm64/include/asm/kvm_arm.h
>> @@ -121,7 +121,6 @@
>>   #define VTCR_EL2_IRGN0_WBWA        TCR_IRGN0_WBWA
>>   #define VTCR_EL2_SL0_SHIFT 6
>>   #define VTCR_EL2_SL0_MASK  (3 << VTCR_EL2_SL0_SHIFT)
>> -#define VTCR_EL2_SL0_LVL1   (1 << VTCR_EL2_SL0_SHIFT)
>>   #define VTCR_EL2_T0SZ_MASK 0x3f
>>   #define VTCR_EL2_VS_SHIFT  19
>>   #define VTCR_EL2_VS_8BIT   (0 << VTCR_EL2_VS_SHIFT)
>> @@ -148,29 +147,59 @@
>>   /*
>>    * Stage2 translation configuration:
>>    * 64kB pages (TG0 =3D 1)
>> - * 2 level page tables (SL =3D 1)
>>    */
>> -#define VTCR_EL2_TGRAN_FLAGS                (VTCR_EL2_TG0_64K | VTCR_EL=
2_SL0_LVL1)
>> -#define VTTBR_X_TGRAN_MAGIC         38
>> +#define VTCR_EL2_TGRAN                      VTCR_EL2_TG0_64K
>> +#define VTCR_EL2_TGRAN_SL0_BASE             3UL
> the name if not obvious. I understand this is yet another magic number
> used in the formulae below:
> SL0(PAGE_SIZE, Entry_level) =3D SL0_BASE(PAGE_SIZE) - Entry_Level
> I first tried to map this onto some spec fields. May be worth a comment?

Sure, I will make that clear.


>
> Besides
> Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks
Suzuki
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
