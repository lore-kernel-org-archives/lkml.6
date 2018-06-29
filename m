Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FAF6C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 05:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2C2E27A7F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 05:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="ghmpYwz4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2C2E27A7F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932799AbeF2FKK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 01:10:10 -0400
Received: from mail-eopbgr60120.outbound.protection.outlook.com ([40.107.6.120]:30144
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932703AbeF2FKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 01:10:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckgsVMukM2iXPYW9ernxhcrxHjQ4bRU/6yhEYpgq2E0=;
 b=ghmpYwz41ABoAYMOax89fG9RC0lvl4G4yVL3KwmGZoIqw36GdFbsUU4WFTJCI+BUPkBpe9nl8BajcB8DNgy6hHBH2VhmzeMPIiI66BaVHdv+Mjeq8TIJyftD9lF4rYpupe7FlVgdyH0WGm+HtWy62PZ+jzJrcDbiGgJBxS7pt9k=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from [192.168.114.68] (91.133.71.105) by
 DB6PR0201MB2454.eurprd02.prod.outlook.com (2603:10a6:4:34::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.20; Fri, 29 Jun 2018 05:10:02 +0000
Date:   Fri, 29 Jun 2018 07:09:59 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <20180629044439.GA29931@Mani-XPS-13-9360>
References: <20180628181042.2239-1-manivannan.sadhasivam@linaro.org> <76F2EEF1-A266-4E05-8C72-74492928A531@axentia.se> <20180629044439.GA29931@Mani-XPS-13-9360>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 0/6] Add Actions Semi S900 I2C support
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     wsa@the-dreams.de, robh+dt@kernel.org, afaerber@suse.de,
        linus.walleij@linaro.org, linux-i2c@vger.kernel.org,
        liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        andy.shevchenko@gmail.com, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        manivannanece23@gmail.com, thomas.liau@actions-semi.com,
        jeff.chen@actions-semi.com
From:   Peter Rosin <peda@axentia.se>
Message-ID: <565B1582-69F8-450E-8A4C-2BD528E9F07D@axentia.se>
X-Originating-IP: [91.133.71.105]
X-ClientProxiedBy: LO2P265CA0119.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::35) To DB6PR0201MB2454.eurprd02.prod.outlook.com
 (2603:10a6:4:34::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa81aa8a-10d8-483f-720d-08d5dd7e91c9
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652037)(7021125)(8989117)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:DB6PR0201MB2454;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0201MB2454;3:7qeHXP+odR0MC3B9q++Y19x1uvusLXbj4PDgvS65RU3MTlUJ8K4F8wXSRnO7EY9HQvmokEqoRFWYrNCwAOzWqjHOTSFUTJO6AJhoZBUGK1bLb7d4iORaWkvIUiyedPVyA50f1nHx66g0eaEimnvX9BtF/M1ViPqoJeODEtyFdCLi39b1/9nNcOpu1+HzIixcw18QVUG9FvKBUjVvHU+OE+y6DWYJn1jbCJHNsZbeiOEmRzAVhu7lHyWXPte/Tahz;25:LzLn2qMBiKzoGq2KF/gITnQKyyukAV40hnKWGZD8v8WMbk3TluDMGHwmuQaSIS0rSPDplN0qhgRO0kkszJAPHu3aJ4OqPwAMAw7ysyxdX83HtXUWOvypo1mOuOgEn5oYsN4Pra1XwZYdDPlalqP3QzB6xTp3/S0k5buANn1USIobyIk0JhOP53dOZPNtrwvV4gO3JFDdSwuVGPemtRI0Tl2Bo17GSVxd++8w6zDXufIbt86JaYYi44a/qBWxsXR6rWzOATDnVEJjSZNSlKkl6YFMyKl+aDPDBLd5fFyYjhh87v+nnJBB1j0ixPw8SpvpEifX8m42zGIx/F9MSEcmyw==;31:WQW7UQGvsE1WbGkUYWytmADk5jzJRz37eeZOJUBLt1seHMMEENR7RT4TzLL83h8NJdhKrUGIhtYNE3iodZjFgrRmmFuOrQuWed4NPiXOuNy6nsyUQJpR0O4lanzLWqoEOJRZMLFuui1dJNp28F6Cxj5JhgW+vOI10UTny0WX5SmzIXfF6CvVR/2GVWfO7aDmUpmbkZSGxN0mCl2rLAd/qw+vRhbYvL1qnjan0YCdx1A=
X-MS-TrafficTypeDiagnostic: DB6PR0201MB2454:
X-Microsoft-Antispam-PRVS: <DB6PR0201MB2454FAE7F15C27A4066AD547BC4E0@DB6PR0201MB2454.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(2016111802025)(20161123562045)(20161123560045)(20161123558120)(6072148)(6043046)(201708071742011)(7699016);SRVR:DB6PR0201MB2454;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0201MB2454;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0201MB2454;4:GV3BcU1VCAY5CuVceM2UM6DKYIRf5Fu2owi7Dg4eq3D1mzyJrCwjThzvk8H7+Bp9hU88suhkW2fit918ezPSGymJj4gmTApSCF3oztk10WWOA8fhmdYzlVqtKLdnkFf9jViIujIiavmuH/RF91I2PnPIp146EbWxUjrpqsYXvU/IHavpzdM2fc9tm0t8bKlb6yX66TQfCbUupEhoTU2Se/8s0EHuL+WcBWJkoLYACGV2+J8N/sq+8BnfD0GTTJUiZjZ3/0SfTKAHAltyMadg9g==
X-Forefront-PRVS: 0718908305
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39830400003)(396003)(136003)(346002)(376002)(366004)(199004)(189003)(6246003)(97736004)(106356001)(6486002)(6306002)(39060400002)(68736007)(105586002)(25786009)(50466002)(305945005)(4326008)(229853002)(117156002)(74482002)(7416002)(8936002)(7736002)(2616005)(316002)(26005)(446003)(11346002)(2906002)(86362001)(186003)(5660300001)(53936002)(8746002)(16526019)(77096007)(478600001)(82746002)(83716003)(47776003)(966005)(6916009)(486006)(476003)(386003)(36756003)(66066001)(33656002)(16576012)(6666003)(2486003)(76176011)(52116002)(52146003)(6116002)(956004)(58126008)(3846002)(8676002)(81166006)(81156014)(23676004)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0201MB2454;H:[192.168.114.68];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjAyMDFNQjI0NTQ7MjM6dlE2MUp6ck5Ja1NmVHo0c1ZERXQ5RVNM?=
 =?utf-8?B?cWh2QVJMVE9XZHZPTFdHQXJFd1V4VWNBcU5JYkhTdDFlZU1RKzVjU0prWkJH?=
 =?utf-8?B?NzBRcFFob2ozQWtCSjl5ajVPWmdPMVNJOUNPU1QyNndURkc0NzlrWUpMRDVn?=
 =?utf-8?B?OGNUSW9jOTk2dk1HaDZWSkI1MVdmdnFqNnhZZVpOTXBSU1pnQWdOVytyTEFY?=
 =?utf-8?B?dkdHVGpESENKS1lwVkNMemNoQWFhTytTN2NsR1ZHNEZZTG9TQWVzVUdveWJk?=
 =?utf-8?B?OWY4RVQrT3ZmQWpDZ0xManIyK1NoMXFBSHIwNWlDK3g3ZzV0amc2S1BMUVJt?=
 =?utf-8?B?TjY4TUUvZDZFZ2szNUhkaUdySHdBdDVwcVAyQk9mbkM0Um1ZMC95a1hIT3ln?=
 =?utf-8?B?TXFacHgwMEhSYTRPNUhaUTYvMTJPdUFIMmo2ekZUZXJsMnErYnYzYWtodVcx?=
 =?utf-8?B?aklvUEx2RG9xSzExZElhUWxJME5uYlpoQlZPUTRUZnBCSWhiQ1NMZ2x5T2ZF?=
 =?utf-8?B?NW1lSkR4K09tV09CaFFCTzRLaU1Fd25qNVpUc1VTQ1R0eVAvbGoxOWtQMWRV?=
 =?utf-8?B?NGR2ajg0QVByV2RLOW1Kem9XSXJqZXltUDJqUFB5RTlORVFiazBkTjBtMXJk?=
 =?utf-8?B?eEk0R1pSdjJEWWN2blNrYVVkUk9qRkVZZkYwQ1JoaG1INnRqZ1U1WUo5bzFR?=
 =?utf-8?B?cWdYQjBSd1UzUkVvVVpvUG1jd0hTTExGSk5ESlZESG1HZWRqcll2MkNFcWZq?=
 =?utf-8?B?QWNKSzd2UFA2dU95K0gzcGZ2cmQ2TGxYeVg2RDgrVkthUStGdTdGbi94akVI?=
 =?utf-8?B?Y2NDRUhLMWdyU3BGOWQrRFJJOE12RHRwY3UxQU45VXUrLy9QSGtGT3YvSGtS?=
 =?utf-8?B?Nm9GcHZFSExrUHFnKzhjZTJIcTVLbFY0cGplNnlldk9aYlhPVFJjdmh3Nmhz?=
 =?utf-8?B?emdTRCtacHhHY3kvU3FieENTUkdNT0p1OVBpbkR6UWNTMktUa01pQkpDZll2?=
 =?utf-8?B?Zm8rUmZYMlNsUHdMcTJWUlU5cjNjV01kVFJhcDgrRTlSaFNGUHRVRnd5VmNm?=
 =?utf-8?B?aUZyVEREUzZ1b2V5Qi9YZjBVNXJ2UzJybE1xWnBZNUV1S2txeXpPWU1tVDBi?=
 =?utf-8?B?NVJhRlNjM3RPM1VKRDVWL012a0NJdVF4MVg5Skl6Y0VBSU5aZnRGcGJJdjVS?=
 =?utf-8?B?VUczUEwyNTlyQlJyLzB0ZExtaUNNVjNsWGRPUGlHVjYwaDNocFZTVXJISVdI?=
 =?utf-8?B?RWt5eGpLZUNKRlgrYXdyeUNFRWpWOU9tQWl0ZTJBbDRNYVY3ai9rVkhLYmhS?=
 =?utf-8?B?UjdPc1ZHaTBoRC9XaHp0YjJ3N2tUWmk2MlFGQVp6SHFjNkRVZmxSdUkzMkRE?=
 =?utf-8?B?M2ZzaHZKZ3dyQkt6cThnOUpjYzNuYlZ5TFRYTWhZWmRxOWl2YU1yUXNCa3kw?=
 =?utf-8?B?M0M1VWhjMEc2a3A3YU5CblB1TmFNdzIwRVR6SlE3ck9JSTRTYmgrUWpOY0pO?=
 =?utf-8?B?c2Qvb2l5VndnMks0RFFKcHNQSlFxb21xNEJBdzZmWTV2MEpUbWlFaVJSeE1O?=
 =?utf-8?B?RTN4RlVuSGFIYU9Kc2o2and1V05kMGNPY2dXZmVIRWNPamgyV2JwS1pvRUZ6?=
 =?utf-8?B?YXh1NjR4bG0yZ0I1bWhOeXQwbC9rQ1Z1a1RYT2NPcHFEcGhrY1ZrNlA4MWRk?=
 =?utf-8?B?cUt5Q2tWQS83dWx5RzNZdE04RVMxWE1YRHVYRGhCd2tkSmpBSGFiUDJEOWE1?=
 =?utf-8?B?WHFIZVNRWFRIbFk4UWRsM1BFM2lFREc2ZkZqSUk1NFFiVEV3ZjZ2bVhnUVpl?=
 =?utf-8?B?M2wwOVU4d1FTU2FpcXhVdWlRR1U0Nm1rRjgyeC9oSHlTOWp1Wk5LekZKUEZV?=
 =?utf-8?B?QW9FdjRoS2VPUEJ6a0ZYN0RKQVo1SkdZMzRBZ2lRZWdoeXgrdGxTRWNMYkdk?=
 =?utf-8?B?Q1VHclJmaTlxN1Bhc0s5UjBRM1ovVXZMdGF1RkpRWDBIaTRUNndDdEc4UjFB?=
 =?utf-8?Q?WLaXTb81?=
X-Microsoft-Antispam-Message-Info: gIjRbLRXiLxH44gHJgWcsL1Q4KOQZR4oTU4HjJfShU5ZSGUs1opxEPbrq0a5efn2vdu8Mvs4BxQ5HRI5ajaWak+RqklU7kKHhnYPkRij/xGu3JnbNWNHv4ihRXIdI22KJt4wm8porhLqJSKZ5sNWh/+PxQIg9eFEJAHVNgqKAojGMYyhFVjJ05LQh3UGsceVwLHC01I/ZPs8O/6TDhay2+8XvdAuJ+gOoMF1ZXdiThUMx+nk9EZGg+oyVOFTbItqE/lREyUdIF2eU1tAry4ALg8vl+V12Hd+AgO2hWen6JD3Xk0v8CUlicSfdojv3Q9Zv8d/NGvxdtLgKKJIoxwYVgNPzf4i/kmP5if1GfT7ZoY=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0201MB2454;6:HKW7rhJXbNXHyFwOsDQpPjt4nctsfDz5Jf18VKHDV6a9KZJwaqRF0WceSmCNm7TffHGOg3boJcLHIfassrvhcs4n5Y4S3MyCasC4Jj9AxCYIMVF1FPSRT5ih3+mMNahrCgW2S/axi17qQ1lHjkcg95H5UU1m09I0GWu0mRjmIf/vt+3/uaRsQaYx7rzh8IBFMr/yMZzDmcpOGEIbQKmHDQTkrR7ejpWuz1QHlixfltR4pA4jX0KB/QSHhojxAGE7JnDqMfajMF1KobscQsp1cSFWKBsCL8B699Fm/zwiJFE6MCKZG5LJWeTcL7YoAXSLyx6b9KuHTMujqIjLQuQCXMM+kMlEXN34ASEai2ZrmycPz/UKJD3Dzu+kmn7ODHiUGnc7b1NuG69yJFMVxb8k1vK/mzLRJaHuN5mh5nfVPqz6U4+Iym1Lt9Ej3YQ6DzAhZVqdMr1rXIeELiJYc+IzXQ==;5:vwU+UuM0FitKmSRKlFLIDdK8Ps2rJg3CotqJ0UBvuIEnNW9UAJLu+ur1QYvazT5EZUPSfh9oCMZ+lC344Wpo1GtoWKrLRTIPLhUq+XzbghMPgKwlwpTpDVws8yPiznYO0uX/4iZYp+aBN1NL2ieQlekWnmIs5YOHB8XiT3QF2aA=;24:K+mAKxLXUbVrd9Nm6LL1s3R5YxzCdRN2opxz13mTxaksjwUS9ZRw6Kz6zxdkXoO2nWzFsUvFzPJ4NFU2DcFmfi4USJzgkGJzSktaEtxojmY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0201MB2454;7:NtH4gBGxVM1/VWnjtM29H/lRaCwi1mKsYN+/Y0gZBJerZ9AW2yMJ/Tbg6/slDgARrqkFZ2gWvk3YztksxELV45evIAJfLTM7i3+WX4OvKUfH1jR+/Eon352I+Izr4d3pLj8n2MYSjkd2686FVvhUIe5LZrPoCz2qNdTUKkpQ3ou8kNatZ7nzyt8tR6CbyQGQCxiiXP26XIGtCKexuAxXPKKiEugZU5gZoybOuo4+GtzOAhj1Nh0CvgMbNnPBY+TY
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2018 05:10:02.2597 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa81aa8a-10d8-483f-720d-08d5dd7e91c9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0201MB2454
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On June 29, 2018 6:44:39 AM GMT+02:00, Manivannan Sadhasivam <manivannan=2E=
sadhasivam@linaro=2Eorg> wrote:
>Hi Peter,
>
>On Fri, Jun 29, 2018 at 06:13:31AM +0200, Peter Rosin wrote:

>> Hi!
>>=20
>> I don't know for sure, but over here the arch/arm64/boot/dts/actions
>folder has no pinctrl nodes at all (v4=2E18-rc2)=2E So, what is this seri=
es
>based on? The reason I started looking was that patch 2 *appears* to
>depend on patch 3, and I just wanted to double check that=2E=2E=2E
>>=20
>
>You are right=2E The pinctrl patch [1] is still not merged by the
>platform
>maintainer Andreas but it has been reviewed by the pinctrl maintainer
>Linus Walleij=2E For your reference, I have queued up all reviewed dts
>patches
>in my tree [2] from which Andreas is picking them for 4=2E19=2E

Would have been helpful if this was mentioned from the start, and as I sus=
pected, patch 3 does indeed depend on patch 2=2E

>For this series, since the dts patches will go through the ARM SoC
>tree,
>Andreas will pick it up once it is reviewed=2E
>
>Hope this clarifies!

Yup=2E

Cheers,
Peter

>Thanks,
>Mani
>
>[1] https://patchwork=2Ekernel=2Eorg/patch/10322937/
>[2]
>https://git=2Elinaro=2Eorg/people/manivannan=2Esadhasivam/linux=2Egit/log=
/?h=3Ds900-for-next
>
>> Cheers,
>> Peter

Hi!
