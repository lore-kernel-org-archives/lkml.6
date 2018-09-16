Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A3EECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 15:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A3BE20883
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 15:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="YjYdrnsP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A3BE20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbeIPVJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 17:09:15 -0400
Received: from mail-ve1eur01on0104.outbound.protection.outlook.com ([104.47.1.104]:58244
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726840AbeIPVJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 17:09:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bL9xXOt+thtTdyTXXpwlczSf7OBR84IOV3LcCP+VI90=;
 b=YjYdrnsPN5b3DZJ2xp8j1zMYX3CadGlbV64kAj4G9XmXBnWjE9CjJs3ZbmDYa8DxJoWKB0nmHNx1lSmdr01eLlFTjJuNdoLQZq/iXRgkGGVUZB3ECbQ1jUgEw6oD6+Cw126VVfuhISklCVn/ONBTQ2WnT4tfvUgEaCBR5fORjLY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from pedafon.pedanet (85.226.244.23) by
 VI1PR0201MB2463.eurprd02.prod.outlook.com (2603:10a6:800:54::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.17; Sun, 16 Sep
 2018 15:45:49 +0000
Date:   Sun, 16 Sep 2018 17:45:40 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <20180916103657.10cfb5ed@archlinux>
References: <20180915105241.22584-1-yuehaibing@huawei.com> <9f3c9f9a-6bb4-19ba-65ad-53f7edd2af20@axentia.se> <20180916103657.10cfb5ed@archlinux>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH -next] iio: potentiometer: mcp4018: merge calls to of_match_device and of_device_get_match_data
To:     Jonathan Cameron <jic23@kernel.org>
CC:     YueHaibing <yuehaibing@huawei.com>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
From:   Peter Rosin <peda@axentia.se>
Message-ID: <36FE1E29-F807-44F8-B172-5EBB2C4A3455@axentia.se>
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR07CA0011.eurprd07.prod.outlook.com
 (2603:10a6:7:67::21) To VI1PR0201MB2463.eurprd02.prod.outlook.com
 (2603:10a6:800:54::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef041f08-b675-432e-63d1-08d61beb79b0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989137)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0201MB2463;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2463;3:TcKntAwVVLPNx1b5WJghNrATvuivUUz2oZu8jgEHxbWX1/2hrF4gLgAilpQA6cus4l4nOiJILlOqqgoTe4r7IRrBpIhd5Pf5cCrpqKi96KUIlRISPcGKu/bFsJu6LxVsR96Miv6WacQ2NqlfvmBrxMPOCRGagG9weTCo+4VbGBKC3xhvJEintTrPDcB8aDdw+TMcyBt9r2GEC8x7QqSt+eomHmH6l0Ua7zTQpIFneH7rY6x4xPSBvaRLZoRlm1hu;25:Fq6Hflhng8ltUx6KpmVfpQtS3NBOa2WpPqccP3qjbk94C4CKlwTLedETuKJYPhcTrXriFxZPiPlmFfMJp4XX+j9h3go3po5PDq349kHoGbuWfIivSyXDYN65ZwXviZGEzGistN9XTCVE9KpeZ2XJTiMT7Y3Tt1Wnpw1iwAw6dO650eRlJYa896cbz+PtQMbxg3ridBDLMgw+kdWYaRGqHrpPMWUxS5l6q6SrK2upgVyGIL3LaBI+cxKkUWLd9rm1O5DVJR6J4sb1XDU6clhPnyhumAuupnz+xomvRm/N3XKc6g+Sua7P3LA005lZWqkjP8GRF97cSwkBhaATnzzEfA==;31:bCC1KX9xYWf2/3/F9F9EWOxdYcTkdnCEcXJzou1khp86kOAt2ccgfIYB72biznA+1FX+7oyZWzeHpHJdJuomm/37p/QtngWg4hJbCeWEvHtg2Pjw2l/VCyde9Q5pY14QZWJjGfQIRF3x0NJSq3IhOe/VpGK6bnZBWjJDEe2TUIrv3IgeZSEVuqlC6b8EXsnJ6rjp2Riw4eER/QASPQOGVK9ADlxQtTncPZQgSWYoEuA=
X-MS-TrafficTypeDiagnostic: VI1PR0201MB2463:
X-Microsoft-Antispam-PRVS: <VI1PR0201MB2463FF42BC6098632272E3C4BC1F0@VI1PR0201MB2463.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(50582790962513);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(2016111802025)(20161123560045)(20161123562045)(6043046)(201708071742011)(7699050);SRVR:VI1PR0201MB2463;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0201MB2463;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2463;4:flWAcqf735E/Q5fahwlMJPg5Gd0+hkZSCIZjIltwpZkeZ6onTefD36FiT1676GkXGhYYBrzltxbF6XCBBj/67/xwFWjHkEdItMsgjccHp0YYW5Ti0JDQo/Z8XUXeQn27UCEB2gmQhQKeNWNeP61NWJzNQVtuqvx/qg1/Qw5KgBaM29iCdX8bB090vhwCZy7c2fklbaP7qbO3MyTFmPtLV6B9mqWYGedlQZb7R6m2/rNn64ZhoMYh88FSIPEom8u9C5sOA++urkeSKGlBK/WNFWLF4GFMdcXcCBIETr6ivET99VH4BvLXd1MwUIsABlnf
X-Forefront-PRVS: 079756C6B9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(396003)(366004)(136003)(376002)(39830400003)(199004)(189003)(3846002)(97736004)(52116002)(23676004)(52146003)(2486003)(508600001)(8676002)(6116002)(50466002)(229853002)(33656002)(8936002)(6916009)(47776003)(6666003)(5660300001)(83716003)(82746002)(2906002)(68736007)(58126008)(66066001)(76176011)(476003)(486006)(2616005)(11346002)(36756003)(956004)(446003)(186003)(16526019)(53936002)(106356001)(86362001)(6486002)(14444005)(6512007)(81166006)(26005)(81156014)(4326008)(25786009)(8746002)(74482002)(7736002)(305945005)(6506007)(316002)(386003)(53546011)(6246003)(105586002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0201MB2463;H:pedafon.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjAyMDFNQjI0NjM7MjM6bEUvNTB3eEZTYTdzSm9VUWxkYTFlaVRO?=
 =?utf-8?B?K2RCdTA1cldZODM5amJwaUhoMVp6MGZrVk12QmE2Ny9aUmVDMGJNL2J6SGtx?=
 =?utf-8?B?OEVuM1J3TU92bXNRRE5RVW1RTGJOV0psS3dBcFdkYjRqMzUyalV2QXFnQkhj?=
 =?utf-8?B?V3RSRzNlNWtWaXh3VlBoazlhblJNNG1iZ1JMa1lLckNyTmJTTHNjcFVzUTFI?=
 =?utf-8?B?NWtZSG1vbkpBVXRjeGxEai9ZRUQwSDZHeW9vQTlicGI5MVQvUmtiSjFzZmhx?=
 =?utf-8?B?cnZoblJNKzFkWEJyemxoZTVjQXI4MW91b0IvS2t5NzVUYzlDbEZtdm1LTzl3?=
 =?utf-8?B?YncyRGJFbE81QWM2OU5FVUdmd0FraWtNMkpiaFRtOUhqV3Q4S24xNkZGYVFq?=
 =?utf-8?B?ME9TOXEvOUFwdWszQ1BidWg1SkoyMmNjZ2NvTnZKc2RmRUlCVC93T0hYQ0FV?=
 =?utf-8?B?Y2NjSFNVY2tLWlp0MUppODl3bEhwZUpuTzZ6ZGFUOFB6ek9aMkpzTmlGcnpa?=
 =?utf-8?B?UURZa2lzcytIR2p1enFlNGVlMXNzdzd3MTU3amtTYmI5QnhtWHltejRuZWxY?=
 =?utf-8?B?MENhMS8vTi8wNFk0Y0xLc0JFNjk0REo5ZFBGV3FEd0NOQnNvN3VzRHNjU0pm?=
 =?utf-8?B?VVhQZDJ2VDhnNTVvTW13dEJkc3hUUEwxT0V2R1F2R0g3eUdZMm41eGdPNGsz?=
 =?utf-8?B?T2c2aUErOTJxQ1ovM0pSSEltTHNjam52Tk8zV1A4RWpMRGVpcDM1T1pPVEY4?=
 =?utf-8?B?bmVwcnRDcEptdHNCdEsya05qQWlSTTg4bS9tcWZQRVlqemxTMUxDcnRVeHpn?=
 =?utf-8?B?bE5CU1VuMkN4VGxVRjdUaVViem1ZdFl3NDQxVVRrb1B6NlRCYWI5MnJHWUNW?=
 =?utf-8?B?MkFXS1J2RnhnQ29SSnBSNG1HaDZKbWlvRFF1QmtUcFZPbkUvd2t4MTZXeU0v?=
 =?utf-8?B?K05mYTF2bm1TQzdOZHZ0WStINy85cVUweHpvcE5MOStBYytXQ1NkSS9acTUr?=
 =?utf-8?B?OU80bU5LUDdBRkhrdG1pcmkvYUExLzAvWG0wT1N4ZzRaQm1vcHRlZnFSanNC?=
 =?utf-8?B?WUNXTUU2dW1kTkpMYkg0MjBCdzVYS2dFQzh6cStBczQvUVgxbkxCeGdMcTVi?=
 =?utf-8?B?UlB0dzVKUTVZWU5xUTZwSE9wZk5tbHJPY281N1V0YUhyR2FvN3FmVGRITi9I?=
 =?utf-8?B?OWxiVWpNZEwxdEFPWm9DbFppSW91VVRUOSs3T1p0Zi9MYWsrWnZZalRqbGNp?=
 =?utf-8?B?M1dDREdQTkpld1Frc1BFZUlyWjVqcjZSTVRtK0UxaE5tQWZidG0rRjZqN0JK?=
 =?utf-8?B?NHRiV3VDWUJUSXFSTXV5SWNUR1ZnazBjMExoMDAzekVFNGtBS1c0eEYrYnpU?=
 =?utf-8?B?UW9Sa0xuZmt0TjVrdk1GcGRJeXhablNNNWNGRHJldnVGVlI2amxqNGMzV21t?=
 =?utf-8?B?aCtybitDMFUrMjFoc2RaNit3eWJ5WGkxbzNSZFdtTGE5akdCYXFTb2NOeDl3?=
 =?utf-8?B?L29rZHdlMUZidGJGVDVycmIyZC92VEt0TERVa2RtS1FFM3o4aDdBSnpTWVNu?=
 =?utf-8?B?YVE3L0QraHNPTnJhWWwrMFlOdjdHdWZ5T2xkRHB3UUQ5cElKTHE4T2kyYlJp?=
 =?utf-8?B?eFdZQ0d2YW5NYlNkczEvUlFGS1BtbDM1ZTJjUmxKVHlHMEJPUm5mdU0yajBP?=
 =?utf-8?B?cU9sWExVOU5hUXJFYUlEaG1rUDdpaXZDOGkydlE4elRjZFJ5aG5HR3Y1MzVo?=
 =?utf-8?B?cU5qSGN4ZlAwYktCS1VnSkhETCt2Zm9uT2VPVTdSaU1xVElWWnM0WC95Uld2?=
 =?utf-8?B?ZHRWOVNYYmdONHZjMnVyOVgybURWR3VuN0pMOVVkQk82ZEsrMEpsV1ZGNEIw?=
 =?utf-8?Q?ervEYNGrJwdY0=3D?=
X-Microsoft-Antispam-Message-Info: HW6tum/+LqRtWrxU3Vrs/MhWylVLNBmQNjmjhRVy/LxcPxsXtxsMibh+Sao0wxzZy6AG/rC11J7AVtKKLWO1BEdBIa2m+ryPoM4D6E2yh+CUMiWsQT+xcXwfts/dOhc/4jm+7BphIc2lCFprLcSuMIaxBURfQGPwl6qjGURMtJUKIy/nv507j8WMFTCxGoFTVr1/+hIKjgTokv74FBRlGF9DqNI9kk7H475MHJv857wA+tDycCyfIkMNZZhXjOrDSTcitK7eNsf3XS/cofsptmbYMPyNhL9bmA90rFYhDRbqETsj/ASSTgEC9gKXSzJx71dMRFKHK5Nacs/sCvvNqrhbxRFiHMQ1eEYK+4A+kLk=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2463;6:S6+itBUUZseVvRKFyz8YzD+VFBF9ZZsxiGuBY48okAv2NhNUIHVaft+EmMGVjSTlv+JHjB8UKHEu7ScVvHttSQRTwkVH2Y51aX6XGoo3S3AT9nHIEnKKGwOW49ZcIwb3eLtI9DR2cXHonYdJ91HVVQSMTd6T+wjHffKsZhUI7Ppo1UUBF35U8v1acd/0vfhHc99K3VpZK/1ns9CXrDtIOAICggtiJQJKEHHvE6a8nFJxQUbQGl1i9YW4NFHJTBsKmURpFn3BL0oNl1hkZVU1lOv3vSsuJAxKZh0CqFV98Jr7AmooQEkm3Mbamf3rNYKqPHQx4S7oQ72CjDw5KRIU/g0FaFtX0QsD4scahD2rEQ4ujuhM2bTEvqANUQO8KXHX/3FHKajpssOsda/gTsey+Ovcd7ZA21ab63nf2z3PHLWUQ44wft5spx+qaIUlODPrkRmz7xZBCndtJco9WwDLWA==;5:bgGu6WgUvQwF3pCsj9i2YkScCDl1YDDfeLtLJSXg0xHhiobdv61uksleObDvJ2bUuZcE4ZpBNb2tHggO36v9sTCnFmlVZsJ25Q//8sSusePyxHdvMZoyUgLcsafN69XOPNOfk1c5lm3I+X1XUPe/noi880+/n66YBxqcMkRSh8k=;7:MN2fUzuJxj+1ndAvV4P7s1NShdYnHjzMEKJH3s165twlQGFeOwDf1h1O8HCVZMd7FnwePB4zdEv+S7JBqVScWrVHzcQwdELDbmH16SNnBmNu2jZpM+Nou6QiQovUB/1gq3HxFXe1fcYwTLDuKXMQ/E3Kiq7ql3go70x8hpBhOU7mX8DxNtoLwWnh4YSC3x4nY1EnnjoBPJf3gZYtRRocTJwOIEB0Y/UODKeoqYT/FR5+bZbFvwNdZeGNSrpilgLQ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2018 15:45:49.0139 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef041f08-b675-432e-63d1-08d61beb79b0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0201MB2463
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On September 16, 2018 11:36:57 AM GMT+02:00, Jonathan Cameron <jic23@kernel=
=2Eorg> wrote:
>On Sat, 15 Sep 2018 13:35:06 +0200
>Peter Rosin <peda@axentia=2Ese> wrote:
>
>> On 2018-09-15 12:52, YueHaibing wrote:
>> > Drop call to of_match_device, which is subsumed by the subsequent
>> > call to of_device_get_match_data=2E  The code becomes simpler, and a
>> > temporary variable can be dropped=2E
>> >=20
>> > Found by coccinelle=2E
>> >=20
>> > Signed-off-by: YueHaibing <yuehaibing@huawei=2Ecom> =20
>>=20
>> Acked-by: Peter Rosin <peda@axentia=2Ese>
>Similar change already in place from Julia Lawall back in May but
>looks like that just missed the last set for the merge window
>after I managed to loose it and only picked up again when Peter
>pointed it out in August=2E
>
>However, something odd is going on as these are not currently in
>next=2E
>
>Ah, looks line staging-next was updated 2 days ago and last linux-next
>is just before that=2E=20

Heh=2E I sure thought it looked familiar but assumed the old thing had hit=
 next a long time ago and that this was something else=2E=2E=2E

Cheers,
Peter
