Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E82C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 12:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ED17219DB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 12:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="MS8DrpxX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ED17219DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbeHHOxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 10:53:01 -0400
Received: from mail-ve1eur01on0084.outbound.protection.outlook.com ([104.47.1.84]:31527
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726733AbeHHOxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 10:53:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xOR39GBufmpxeG8ggBA6vzpz3YTWgOI6Kve4JoIVoB8=;
 b=MS8DrpxXanG5EWBGkMPbqwIVyA3IIHlQqIeU2cS5KfZtHrmeSoeeGOgSFuoUQTSdwX7F9s149r0EnxqPPVaHD3sSCdtfIj+nfPKQ8j4NhAfxL6xdUsrYGvaDg0rCwACcheQ2hqBZ+HACnGhIBrjCHenPTJoRwdf2W+frAZ7+ejc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
Received: from [10.1.8.111] (89.24.100.190) by
 AM6PR04MB4663.eurprd04.prod.outlook.com (2603:10a6:20b:1b::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.19; Wed, 8 Aug 2018 12:33:24 +0000
Subject: Re: [PATCH] media: dt: adv7604: Fix slave map documentation
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        kieran.bingham@ideasonboard.com
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-renesas-soc@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180807155452.797-1-kieran.bingham@ideasonboard.com>
 <505904fb-7bfc-c455-740e-b72a14731eb9@ysoft.com>
 <b5b25641-f898-577b-7762-d72dd64272cf@ideasonboard.com>
 <5273911.bCJl0SVgzf@avalon>
From:   =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Message-ID: <bc69dca9-89c7-2df7-3dea-d6ee6651677e@ysoft.com>
Date:   Wed, 8 Aug 2018 14:33:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <5273911.bCJl0SVgzf@avalon>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [89.24.100.190]
X-ClientProxiedBy: AM5PR0202CA0016.eurprd02.prod.outlook.com
 (2603:10a6:203:69::26) To AM6PR04MB4663.eurprd04.prod.outlook.com
 (2603:10a6:20b:1b::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d88997ff-1db3-4185-50ab-08d5fd2b228e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4663;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4663;3:DNKFdLXjxG0diTaro/bIME9iq6K4hYlDfnXZp0i/66/b0fqaZpFz7IGxqUUfWsrgB/v0LSAGT6s8dsF3Xyjg3/4TQssHehxToBwkrj7coSGBd6LfAOg6Ur3xlbOuoNnQz2uIrm82L5xNxXU7QMK/AXgZ50s6V78Hpx4VbSajAn7bogMuJ4JL3GUmpXkz4rVQK+a7ynwl96WS6Krz/63M7TmIdVvYqvs/wjlhoXU0hsOXX2DeaA69scrPv+C3IdRt;25:AhEzf5rRv4mXi9wm01h9vXv50VUhki//k5k8dAdyPemvPgJZjgrJKCCctLLMvOEsB8JfB9fIf35Q7nNCmmQ2NKqZzKgsLwECdcYVpe+WCEAbw7w/3hIMcTfQ1iHCEW7F6lwqJ1lnk4xJkcHMOgbOCerevdFPypXzyfYK/xF19NeMoSx6IL7keGicV++YwdKf6HLr75XoNSpZbirw/5AnMQiP4pVT9mJ3tRbz+VhKLFJbYiazpQd30zdsKIkNDVXIEnN94pW9QEBgd+GhBNvmMn/p+rmSBHC453ciKnxrZHllEMF4p9HayEMJpaBYmlcLVgJ0sJUnKH/pbafdlH7UDA==;31:xdWiy06tlxb42bq6vXR9DKEYzoePRWtP5ElKYBban+VcFTaI7Bl+1jGF01Wxeh+CU+Rgt0RpSguBOH82JAA3SJpdfLRp5sWPPDKqRjHo79PnZNX8SCesujDJ5eSo3wRjhkDzcH0TEoV4vH+k9IPIVhDaLkw+FD+y4tho64VjTB7OKWxMUkYcTzZiMafb5gouj9zG2PERAAIw34aboiYrZXHTeaEHHDuJAmBz0iCVX20=
X-MS-TrafficTypeDiagnostic: AM6PR04MB4663:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4663;20:n099iMySpJJy1jQzGnDAfSZTx3gG8uRiqtvdAmeFuNne8z7RRuj3N3nq2DvplCHBZ6nbh5j7N/QfaBsEvZf/+V1uO8Hbp+XYQnoOVYd3DY4fVipXfasW9Kr/tgMNTYGJd7ARYqKFJ8p7Wdku8MzfoT0m3daxN6tV8RtF8LT8Oii4cfrGOa4J5qf196/53xZ4B+2V/+NF9mEW2ksMVKt9YG8qtx0isbnT/NjVRImvFPkN2/lxQ2sVJdYC3khh4stx;4:YidGOB/9VBbixDd2ErwUQ5OwwZkFX0ZGThAFIXNq1Q0KiPlEcs6BLgDHo82HWYM6ZwsDyiibedORcLalpdLJRK7KhWARlxoSTmCy84j6BW8fO9rrB+O5bdCs96ZKF0IdnGcLzoKCTtcxXNY3yl5FedlsqmMEX2P/I82UWvRHEyXwNL3bbyQFnjRvVWGhu6JtYosJWEx85NIZ/nQQ3OXzvy8CgBTkQK0rziMoxZVyqwyeXDoJPqP92tJAKRKk88kSQpO4r2vy26vQsFjgo0By9A==
X-Microsoft-Antispam-PRVS: <AM6PR04MB4663ECEE4657A80686B66BBD9E260@AM6PR04MB4663.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM6PR04MB4663;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4663;
X-Forefront-PRVS: 07584EDBCD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(366004)(376002)(136003)(396003)(39850400004)(52314003)(51744003)(199004)(189003)(486006)(305945005)(64126003)(67846002)(8936002)(81156014)(2486003)(81166006)(68736007)(23676004)(54906003)(31696002)(52146003)(52116002)(93886005)(8676002)(6246003)(476003)(3846002)(76176011)(86362001)(5660300001)(65826007)(6666003)(85182001)(53936002)(7736002)(14444005)(25786009)(50466002)(47776003)(4326008)(229853002)(345774005)(77096007)(6486002)(106356001)(105586002)(186003)(6116002)(7416002)(31686004)(386003)(53546011)(16526019)(16576012)(2870700001)(26005)(316002)(446003)(2616005)(72206003)(11346002)(478600001)(36756003)(66066001)(97736004)(2906002)(956004)(65806001)(65956001)(58126008)(21314002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4663;H:[10.1.8.111];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTZQUjA0TUI0NjYzOzIzOlhMc1huSTJCZmNwOWlhR2J1dHFHdGU0VmZE?=
 =?utf-8?B?OEROeG83UWtKdnl4MUpSbE00ZTAwR3d3Y3l3dlF5c2tTQ3hjSVc5YUtEWldO?=
 =?utf-8?B?OVVUNy9mREJON2NER2MzbXVwS01BS0dodHN4T1NSaVJ5dnVBQkdFd25sYzFS?=
 =?utf-8?B?Y0IvczUwWFFuNWtlcDVYRStIWEZlQm1aeWg2NHB6Q1FUdFBndHJySTY3cmFa?=
 =?utf-8?B?Mk5QTk5IdHE1dEIvcllFTlNVWW9qdDFGNXNpTEVtenh2bWVmckh4bFFIZG1r?=
 =?utf-8?B?TjIzRDdKc3ltNnNzM1lFSnlUUTlOakkwQ2V0QzBWOE12NjhmYVhkNFhXY1U2?=
 =?utf-8?B?NzdjK2ZMN1ZReGxqeHlxM0tMaEthT0FHQ0l1TE95YnI5Mk5sQjhHV0Y1RlF5?=
 =?utf-8?B?SFNjdkpyaUlqL2FzU0U4eTlpUzk5a1dTeTZEOXVicDM2OU1YQmswejlzMXo3?=
 =?utf-8?B?c0t4RzBpbkVFQ3ZCMngyTnd4cnU4RDVxbVcvOWo4MFdmQ0EwcFNETHhOYWFP?=
 =?utf-8?B?MGRQQUZucUJsdUUzeFE2dDFTd3JDRTJMbk1Ga2VvUkpwMVM3SHZLNkVKZnBB?=
 =?utf-8?B?K0hydFhybGRYbkN3ci9YUXVkTGNwRXprOTBQUUR5bHdhYmVsbXZjRWd5Y2pl?=
 =?utf-8?B?cHFkWUVZVE5lVHFFYlF4QXV6NmhjeVVnbjlXOFAwZGtCaGVMR1FvbDBCNXlh?=
 =?utf-8?B?cFhuWWxpN014dHlNWVIxQmdQdGJwNWdYMG9ZZHlpZ1lySTQ4U1pQSUsrVXV3?=
 =?utf-8?B?MzR1M1dwanY1TFNYVEt3OXBDa3UxZityd0lWRWNjNGNQZFhEWXZuY1NOSE12?=
 =?utf-8?B?Skl5WlZMcWx1QzZVeFcybnJ1VWk2T0VKTXc5eWdCUDJXenU1aUdrWC9yKzNw?=
 =?utf-8?B?ekV2ZmUwRW1CU3VCTGRBQVFsbWVJYVNyNGtEZkpTeDlNYWUwcGNwc1I2ZTRL?=
 =?utf-8?B?cTF3dUlCaEJxYU9uV3F5QkNYeE5tcDVaMHlIaXdLcSs4d3pSMklWZFJqdnFC?=
 =?utf-8?B?alUvR0J6TGUvYTlLZk9rRTAzQllYdWRrWkU4ZC9UOGd1a2NtUkp2bnNpVmdP?=
 =?utf-8?B?S3BBVHVhdjk4WXdlMkdhNDBUMTlDb1d1Y2RNS1dMNnpwMVR0bVhGYlBZWklX?=
 =?utf-8?B?U3piQVZtY29YM1FTMm9reW1kck9XM0RSeEJjc2d4Y3AxaEhyZ3BlU3JSeEcy?=
 =?utf-8?B?N0VXc3Y1NnNsMFM0RUpweUF5Z1pWbFozVnV4ZTRPN1N4YjlHNU1DZFBDcStj?=
 =?utf-8?B?VFlIcVI5RWhQdHdRV1U2cEdFUkZPUC9WenpZQnZhem9WSW9nMzFWWW91Z3J2?=
 =?utf-8?B?NlVCT2pDSk5ZbzRCVmN5R2o5RzFmVWJuY0dLVXlCaVMyc1ZCM21GLzkzcFg4?=
 =?utf-8?B?UWhQR2NuR1dobmpUMk9QZjZjbW9aMDhxNFdCajg4SS95Q0xiL1BQejBxNVND?=
 =?utf-8?B?ZWdJNmlMZi9GdUtndFNkakFuVEdyRTkzV25qVUNIMkt0SVpSQkliOXphZ0Fv?=
 =?utf-8?B?aTJ2WE9qZW91KytkUnRITThDZWtKc0kzR092eTNoQjRqZEEzbDJPS1FWdGRW?=
 =?utf-8?B?bmxjcm0vT0lIS1RVRUU5MTRXOE5qeGZKQ3dUMmdId1NUMWlwM1VJNWc0bXg4?=
 =?utf-8?B?eTh1WGJqaGR2VUNOZ3pZMFVuMnRTNGF6Z0VQeUZRT0xibjZvV0pNU2xPcHhI?=
 =?utf-8?B?cFRRbC82a2NTR2RQTk5hbHJnM1Y4UFRIc3E4RStQK3VBZWo4czR0N2dCc0ZR?=
 =?utf-8?B?T1V4UGdSL3JKeUxjeXp3VkMvZW5JaUhHRk5NdEFMcFlaVTJ0a2pKV005aXZZ?=
 =?utf-8?B?RGsyUmwvTGZoTzFDR3E5L0xkdFQ5TzZpWWtSS0ptTUEwTEp6ZXVzbVFPbFpk?=
 =?utf-8?B?aEFiL2orOXBmUmxYTiszT1NObGlVMWovQTZxU1Rqd0FTZ3E3dWlkN2w3Nmg0?=
 =?utf-8?B?cGxRUWgxUm1ueGh5NUl0ZjdlbG9UQ1J1dEFUWlpzem5GOHR5RTdsbzFLRGFZ?=
 =?utf-8?B?SE0yUDlibkZuNDZ3dUkxUUtVelRkanJmSUcyaHJrRFFrK01HbitFTHdORC9K?=
 =?utf-8?B?MWE5Q0s2ZjZWQWVzd2NkQkp2Z05LOU9sNnlZQ3VueXlwSTdIUXFtbU0yeDdM?=
 =?utf-8?B?N3RERUhpb0Ivd0ZIMVZoc0ZldlR3ZVlvckdyUEk3MlVtZXpQeHpDZWd6dE5D?=
 =?utf-8?B?MG5YM21rRTB0aTFKRm1lS1RxakNRPT0=?=
X-Microsoft-Antispam-Message-Info: KCwyxbSp9JhlFZ71wwyElJc3pVVkOvZl+7XW2qg4CpLs+efqjuE+cseciu6uostq2jrxY4S/1wfvId0wNmTktKKhF/nh6zPcKdnxs2OgxGEgdDfR+RaAiErUQlhpfOTx/xCNPr8V/S4KJh79leXqxy+K2lIMUbJqFnUoDkZ0jbgrJwbq6Zcj0t1w9cj1SQpzVA5bub03luIt8WNZckxWdhP6I6crynwryZ25KRmhjboSoX49iiTNXDA/ZAdyHp1PFrnxlmi8fhfZ4ewwjSsiQ9+THf12afMXMmgzsMmi+eWl/YlUCFzRoIr6j6faAcNYqSed9bS22gosoc9ZQduVo/W/ntF6IH7MH0yS8IA+tUk=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4663;6:MxUTEtfYxM0BpV2ZtTk0BqnXeJ3yrU8o6hyvaFLgqeVbbDxBW8lFOGUKedIrXbtLMqYqcqQE8gNYLKZRdWhWX74JlVtsXOyquqnfMxc9Najt/w1orpBBxoNA5ACpTSZl3hQ2FdZkaXt1ORujV51NkViFP38Qi0BulHlXYmBjUn+vdwswFquxYEwd1Dtvzo8w1Yv7EEXCPUQYd6Toa96Sc7G9V9c4acIwQA9+n2YpwEIgLuIOiUHnZrn7EYg0okS6vRH+MLUudjVdBH7PO3MxpDXk+aw5wz7SNnFeeyDh/nnWPCLyAu++U3rNIqXLcFAyjn48WalryRKTao6Ov21JT7W/7Hg7NDYKYA7c/htwOkJb8zUwOzIX9zGAxY4UmibFKlDUy59Ws8ajANwZdrWy81GP64T7XNSFqQsgcfX430B8fWc0ZPsg+C4lo89WWUAZVD1pXH3KpPePOstkGouyRA==;5:FS7qnyRjeRQr+GjaQptDMmL6dcHPGl9eGjdkeVw1WmoGMf/bvQ46gNEJKVIaidP0+eRyL3ebT9T1LVkGVIOA0EyEerhATiJPJTN43jMDcvA4e4fy9EVo4rA0aMGUCUd3EcZ2wpe/H1BFVqhcq7PWC6I6mQk5gHqHzxrHh2wK1o4=;7:vaFP/qF1E0KSSdfbjVgJId0/Nb1KXumrPIBzhWJShovAc5yxDqla7AMa3unCQIq8y+NOmNvkotVWgF+CqbISzXDD+TzGL3l0OWo0E+3hQf1j8vLUO+oZIcTuD8aYbP2Hg1tutuXxVpJKG7aM7qs+g5nPvAC0GBdOuGYwRfZIrl6rLlWyvWZcn3KZbIJ/durG/rJcJ0btdjKD5m0Y+atRBDi5pT+jSr+sGu95uLbW4AKq2Gdz7AcwBwbXewCJU5jG
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2018 12:33:24.3903 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d88997ff-1db3-4185-50ab-08d5fd2b228e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4663
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8.8.2018 12:25, Laurent Pinchart wrote:
> Hi Kieran,
> 
> On Wednesday, 8 August 2018 13:23:32 EEST Kieran Bingham wrote:
>> Hi Michal,
>>
>> Thank you for your review.
>>
>> +Rob, +Mark, +Laurent asking for opinions if anyone has any on prefixes
>> through media tree.
>>
>> On 08/08/18 08:48, Michal Vokáč wrote:
>>> On 7.8.2018 17:54, Kieran Bingham wrote:
>>> Hi Kieran,
>>>
>>>> The reg-names property in the documentation is missing an '='. Add it.
>>>>
>>>> Fixes: 9feb786876c7 ("media: dt-bindings: media: adv7604: Extend
>>>> bindings to allow specifying slave map addresses")
>>>
>>> "dt-bindings: media: " is preferred for the subject.
>>
>> This patch will go through the media-tree as far as I am aware, and
>> Mauro prefixes all commits through the media tree with "media:" if they
>> are not already prefixed.

OK, I did not know about that practice with the prefix.

Anyway, why should this patch go through media-tree when it is a single
patch affecting device tree binding only? I would expect it to be picked
by Rob or Mark.

>> Thus this would then become "media: dt-bindings: media: adv7604: ...."
>> as per my commit: 9feb786876c7 which seems a bit redundant.

Agree that this seems redundant. Absolutely no offense, just a curious
newbee question - why is the "media:" prefix added later on to *all* the
patches at all?

I understand that each subsystem has it own convenience what subject
prefix to use. Given that all patches are propperly formated after
the review process is finished I do not see a reason why the subject
should be changed.

So patches to "drivers/media/xxx" should land as "media: xxx: ..." and
patches to "Documentation/devicetree/bindings/xxx" should land as
"dt-bindings: media: xxx".

This allows easier git log browsing.
>>
>> Is it still desired ? If so I'll send a V2. (perhaps needed anyway, as I
>> seem to have erroneously shortened dt-bindings: to just dt: which wasn't
>> intentional.

I do not know. Some time ago I tripped over a patch from Rob explaining
how to properly format dt-binding related patches. I also read a bunch
of his replies to emails that were kind of "out of bounds" in this regard.
So I got an impression that he is starting to be upset that people still
make the same mistakes and do not read devicetree/bindings/submitting-patches.txt

I deeply memorized that "rules" and once a while I go through the DT list
and reply to some emails that does not fit. Just because I am sure
that all maintainers are overloaded and surely have something more useful
to do than commenting on trivial mistakes.

Next time I will choose more wisely what emails I reply to :)
>>
>>> I think you should also add device tree maintainers to the recipients.
>>
>> Added to this mail to ask opinions on patch prefixes above.
>>
>> Originally, I believed the list was sufficient as this is a trivial
>> patch, and it goes through the media tree.
>>
>> But, it turned out to be more controversial :)
>>
>> Rob, Mark, should I add you to all patches affecting DT? Or is the list
>> sufficient?
> 
> Given the insane amount of patches received by DT maintainers, I personally
> try to use common sense and only disturb them when needed. Such a typo fix
> doesn't qualify for a full CC list in my opinion.

OK, sorry you spent your time discussing such a trivial thing folks.
I am still learning how to efficiently contribute and I still very much
depend on get_maintainers.pl output and other great tools others created ;)

Thank you for your time,
Michal

>>>> Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
>>>> ---
>>>>    Documentation/devicetree/bindings/media/i2c/adv7604.txt | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/media/i2c/adv7604.txt
>>>> b/Documentation/devicetree/bindings/media/i2c/adv7604.txt
>>>> index dcf57e7c60eb..b3e688b77a38 100644
>>>> --- a/Documentation/devicetree/bindings/media/i2c/adv7604.txt
>>>> +++ b/Documentation/devicetree/bindings/media/i2c/adv7604.txt
>>>> @@ -66,7 +66,7 @@ Example:
>>>>             * other maps will retain their default addresses.
>>>>             */
>>>>            reg = <0x4c>, <0x66>;
>>>> -        reg-names "main", "edid";
>>>> +        reg-names = "main", "edid";
>>>>              reset-gpios = <&ioexp 0 GPIO_ACTIVE_LOW>;
>>>>            hpd-gpios = <&ioexp 2 GPIO_ACTIVE_HIGH>;
> 

