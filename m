Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4364C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E629208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ZooKl4PZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E629208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933352AbeGIScz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 14:32:55 -0400
Received: from mail-ve1eur01hn0231.outbound.protection.outlook.com ([104.47.1.231]:45228
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932844AbeGIScx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 14:32:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6yhdxn3B0XkTZlla2p8ijYbqlUyCnH+JWOWosvdnUKQ=;
 b=ZooKl4PZEpbtZ2XHO4ROaN8029Iv/mN8nDW0szdU3fjCnha0ViBx9ePk3PmkKjkzGDNhNPuZ6HFIYqlThaec9oDBz4kbfWKza8kR3qJu3qfNfcLqowSQejtpmhzA/e7P145b1j5D5RtY5heMyWhsJ9x7zbXk0I+HY69CJczjz0A=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
Received: from rkaganb.sw.ru (185.231.240.5) by
 VI1PR0801MB1984.eurprd08.prod.outlook.com (2603:10a6:800:8a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.19; Mon, 9 Jul
 2018 18:32:39 +0000
Date:   Mon, 9 Jul 2018 21:32:35 +0300
From:   Roman Kagan <rkagan@virtuozzo.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>,
        Cathy Avery <cavery@redhat.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/5] x86/hyper-v: rename ipi_arg_{ex,non_ex} structures
Message-ID: <20180709183234.GD3017@rkaganb.sw.ru>
Mail-Followup-To: Roman Kagan <rkagan@virtuozzo.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>, linux-kernel@vger.kernel.org
References: <20180703134206.27240-1-vkuznets@redhat.com>
 <20180703134206.27240-5-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703134206.27240-5-vkuznets@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: HE1PR05CA0144.eurprd05.prod.outlook.com
 (2603:10a6:7:28::31) To VI1PR0801MB1984.eurprd08.prod.outlook.com
 (2603:10a6:800:8a::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02c004f1-33db-4707-cbbe-08d5e5ca5abb
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1984;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1984;3:K8jKT16M495NvGYqbihRiRPDfls3Bf4In7FuIrntBilpy+uoWHSqPNUgsKqG0MpI7I9IA2Lh6fr+0NzhApptf2zNC12VmQS6KnncL6+7yCA+aNURLtNpHqiy6H0VIyJtSBFv6YYjkh6HhsmYj8OUffC+7SFtUVh9i2rvEEj5oV9lFkgrRubDOiZeL2YqyfGXNtZzLUtlnrTGU0r1ID1MjKfwXpl+OUqi26XiLIMQfIaAQ+a6AT2jK16kux4sjZuZ;25:5oDCShL1MhWnhXWs3khc9vVxSEG1iLPNEfQluG3s0iBBXUvAQVS2quNfwJw//bxsQm3al5cTMmUEXliFdDakYiIWl29+pblgdBlfqAqCWHH9olLprtUnyFbqxum6mGgnc2tWavYQE6W3yJyt6N1IVwrXg9GHfCzl81Tv4THgo1HIu5rT47KpfiEhGjXjEQwo3QGHQuUgdg1LaROrzwclZfU3fuOHQZ+r0ZdN+GC/zYt2J3Zcfy1K8AfzUtQCz7H16fJRgM0GJVI95iQ2LqBcdVPC6NGXLcfZA42d9SqBmZ/e2aV4R6/5okO2xau+pTbvMObqq+LHg34LBLfeZKISMQ==;31:ggzEJTBtAd3yt8ARvjzRQaSLKe3MtxNN+Zop5a0QvFsH17RP5JJveFRlSj9RyjCCvDnWuLENAYicjWXlHz5TbwU3ctPcBJW1mraSIwwbpsUCezDxPQ6qHGHNM/TyhlU5GtXwf36h2rXMLBex5YCbLEQ5xXuZVKnB2LKa2ZklfLWZAUJrcIxREDl2MnFQUmUAXMFh4QnU3ZW0IqmpYcXNua227oMjeA0rU8SBwQD5xzw=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1984:|VI1PR0801MB1984:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1984;20:jgrwbDmmZDFImZQDHQXvJ5zxh1IuaC7l+DsijrFBpTAWybdqmPrP7WlNrB1bMJIisHCC/RlxufL4HuZGL42Ql47rMh3IadEMbmNG8ooLgr17XxuzPEtXHMsyuT9OlViFC4vQeBd4eI2dJym6TTCTuruvpCQDTZlAgw7qvSeIWEOTZMNDgRrXt8WYSjnw+Hy8E2nBgFxyzYmDdE4T+E6Jngh5An9huAQ5I221GuAyZLmBEy7sUQySUaTbpBsJ5QYnukFElYMlGX8VzKkIk+XnuWOaubDcvxD9ZQMXrT2y9SXfvSwkl9PssR/7dR+l12e0q1/AIQ44S4sO7pNEVUVOLzuzuOJpnWMwS73Ye8cQa/5bPV2dpzn+ElKePD/1lddfuk84xxJRfE730XuYDxz673kmEqFLAsxMsZzuS/iA+mulLuwZtl+G11OJFksuCRXXRCeZvvll7nVEMgWNJ47spxFmaI6mkDAHQzLdm5hMY73PYkrQQe8Q4lqJrsFk5BI/;4:FvxGOLtU7DBzam64Qy1OVxyYerwwPFk2mPa+o9bLxwiSMTe4KHO77kQtXEoDdmqhNg5mRslIqgTa3BE7RbmaGNRjNKxfI2NjGf7B9GsrMJN1FXqwdNOS8PZrYPLe5W659t0bxy+qfb2dIL6z9aWhpGcgJkZ97CN6dAEO/I2ZRDdHD2pZGk3j0C78lXYC9ETcTjK1Sc6SjtEfnI9Ac6l71AXpycQPAUe1r5ZKv04jTE1Tv+/9VPYOneueq80hU/ZHo8iQ2lWScley0paunrbPjg==
X-Microsoft-Antispam-PRVS: <VI1PR0801MB198451A4E3DB917B02385E2FC9440@VI1PR0801MB1984.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:VI1PR0801MB1984;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1984;
X-Forefront-PRVS: 07283408BE
X-Forefront-Antispam-Report: SFV:SPM;SFS:(10019020)(376002)(136003)(396003)(366004)(346002)(39850400004)(189003)(199004)(69596002)(11346002)(7416002)(1076002)(86362001)(68736007)(5660300001)(446003)(23726003)(7696005)(53936002)(16526019)(3846002)(386003)(6506007)(76176011)(186003)(26005)(486006)(6116002)(6666003)(6916009)(476003)(52116002)(956004)(229853002)(305945005)(9686003)(25786009)(55016002)(6246003)(39060400002)(81156014)(8676002)(58126008)(16586007)(316002)(66066001)(53416004)(36756003)(478600001)(47776003)(33656002)(50466002)(81166006)(54906003)(2906002)(8936002)(7736002)(4326008)(97736004)(105586002)(106356001)(30126002);DIR:OUT;SFP:1501;SCL:5;SRVR:VI1PR0801MB1984;H:rkaganb.sw.ru;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0801MB1984;23:cfOkh/u8sMr1FpEKPGCkX2S2jUz3JEADbBMsGWk?=
 =?us-ascii?Q?/SH01ZuJf6prVTHB3/vt9gTOGCCz6PrZbc518E3uEuJ34v43OQa976TGceHX?=
 =?us-ascii?Q?otYow50rPDFo52O6EJGI60pIUm3THBLyj9OIDHeC2Q3mkuNuZYlYeDQVYXbo?=
 =?us-ascii?Q?nMtoOIUaEN0XKbIoQvPgR6pT3pgzHG11otkPxOJcU+0DCi+c6ZOjmF3bXyVv?=
 =?us-ascii?Q?8x4x9Hj7EaeWC9VqSvnEoHx09okTfAjtDUJwRzDX7kKlBmFmozO6XEBCi587?=
 =?us-ascii?Q?OL7bdMA3irABeESHWKHrs+IGRFtEjYnloBejlqjfyBJY/eVPEaySziUCsx2I?=
 =?us-ascii?Q?ayj7AMoQaVLloLpBtpvUwsecWH5burNL94UYtx5oCzJGeY/9rXSW8Gy2u0pa?=
 =?us-ascii?Q?AoPZY6ZXNd94njaVM0oCcnJ3MIrPNz6FxDUFFc/sz5pkfAaXH+japOmhD/ur?=
 =?us-ascii?Q?BprIGw5G5H/kb2vc+E5Fe1N7GskwBmF7HDFSyUtvbaJ75OJedAeHog/w773n?=
 =?us-ascii?Q?h+Nh09AKCoLtXSu2OAQ0uNMivFGoGWsfOjIgnnnDlo16EJUFWn7L1q2bynRO?=
 =?us-ascii?Q?lfuhN6q2XQd00QgyNH43UmQ1NxaJsOQR76TkgkpLaxgXchRjJ6Qh77vVUnsY?=
 =?us-ascii?Q?nRs4lNvPSsZ2RJlB/2v01sJ0fdhfhxhEf3ZueAyPfwhv5wCc9zS6v1aZrZvM?=
 =?us-ascii?Q?SgiKglnl1eZS58s+Z0tAngyak1t9yr/4X7v44EzZV2hGUzTjc3Q23oJGiAyh?=
 =?us-ascii?Q?aaW8+MfSaIMP1latMZvdKkEVd2azWTf6MABtBQKc5/6yXXzV0fAHFDPVB5wG?=
 =?us-ascii?Q?4puZKuQsfpWrB/SfqgE0BQX+Hab5wNOVM0vEeImGSNBb9gRepTNd+uuWwLXW?=
 =?us-ascii?Q?sCPpOoNkpk5n+eB8HPP9Tv/iMFtw9KxD8DMp2SYwWo50JDEf8YQwCg7LnsQn?=
 =?us-ascii?Q?TuY5UAu8Cxg34Fv/0M2bacMnSjDi/XnDPDrFS1n8Ru0SXll7r8+yOkXRJ/eg?=
 =?us-ascii?Q?X5TVU0lrng5uXfm65hXW99dYP7jSenHMECCr8Hq7JidFVP5+AcJGP5wQ3VgQ?=
 =?us-ascii?Q?d6cuT0UJr8sI9D9Ua5GouzDcyV7hha2EQLIT7osDFk3qluzW3wlYDNpWmQj6?=
 =?us-ascii?Q?aMNWuCQvbznAZTELNfTjOHo0yZmXCjdJJcPsWfAakDUzCZcBxGh9IvFboGX7?=
 =?us-ascii?Q?hIFNE6VoLLDZ3IH3MyNU/6s8pyaQUq3JbLs5UtDxvQVGHzSUGqXESdKGEQ93?=
 =?us-ascii?Q?TZt8xDJRkx104piXcawhIKrDwdJwoZ/d9lvmnKcPHkmTULx9/968KpUR7ZN5?=
 =?us-ascii?Q?xsRGDBlpYxZxOcDkQhgDUp808QBKxMh2GMiJXRsUVLMX9doyT4HPwV4qLjBf?=
 =?us-ascii?Q?6gpm6SSU0XH4qFLJnnz4fRviEx9s45TCnYazYPM8tAJ1Npuz6?=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1984;23:jnGFntpc/L0FEs93ufwlzl1A/IWZM+RIErENZFquJMNm8JWsPoz9I/OBkJ2cY2HMDHYzcNp7F7FKfvkaslCeC0PJLCwN3Y/1VIZ6phnP7DaUYhrkZrCJCnhjBUzhWS703qOl6nQtbgnvLbbulcPEnw==;6:gFwkih9ppEf/Q2k/7ccyNou2D9jkZrnUE9fV2MBVikAFJV9gd59RKlUBnDica9FTDQWHIjDAX8ohWzUoYhKG3cuO093RO3x3xNIYoGDp5mbg49ARja1ulU1Cyl9I136Y9ORNPUrpBm4bIMo/3xNpkjmLDeS+QvgEiZW/GNSs9BJaby7JpfoE3+R+5ojfO6T5ZoMeFlAkX+k2nq8nhA3gxLjgDdSB2Jd6Jpl+tpH/cegE50eocRbAiUxfGzpN3pDcK1BreLWlLJe7CI8yVxKCK1Mn1ScCdywn4YTZpa1uxcacxSdfEaBH5T8jOB7hwX7250Zwcn4C8Elznya1zOoeY7UU7xygu2IRg/mvNvAc9nicDs9kZrQqqVSGtPFyGVSblJ19702T+Au0OVcfl48UyRKqExjOdacmq22Z1Ic5P9drp5IAxidP9MQgYoDxqQFzE7Jfvm9octHbWuQOV8VHC/TfQoo8s2XRK/ml3XVkF0plDb0dTL+eurRtrWBtgxFH;5:gfDBnPgYRg38ba0Cz39//rQhkgpd21tsywIl4pN6NUWM2lDXBuWRRgn6Q2gI62g6Xh9Vm6V0s5mNBflYwQPjeHTowP0knsr5+nLT8626E/W83WSBm/onf6isDkm6Lpcgqg1RtyrCkOtOHDKbzGqLFlVCWzgMS3Z1nKyLauhQenU=
X-Microsoft-Antispam-Message-Info: /K+I/IQqC+u0wZiHgJtrl5MHEqYmqgDatcQD0JBqTyJ/J+Fqdw11m/M21FM4olfFzzRnWZ8MXFquzf05Z/eUMQcv7tHuAL16AdF+/LvPtPgxrFGNNMmcP6osXMOX0gDPzFGNZr/p6G+9D6wDfuFOMqFm0WqMSgwzwu4wfdOjL5wciAbOwnexymDFKK8sou4fyzyZEOR9aOr9MQuyETVs7fnD+ah7x5X7XAnVjKRDJIQnKtgk1VS2krkEjkM0qiwbVKM/MxMamF0E5XRNaScXMe3F33hr/NJG6t9wB9ySW6h9x7tUfeHP2sREqfta7STjZqMLD9e1PoRuqjKf5YnvlOv/lgBpmhouVcpaLSh+Zxe7WEqNNbCHtO0pmr5qsGivgUsw0MLvflHXwPkuzP3ivNrIC4I/AsIbcWk50WdATiGNHEpDxcDFI7ZXRJtdxxXffidS9vhYpYYV2Sxtq6BqZXREEzliTQ666T4x2JSfi9l/KYzoyDNw7thaadU+0BVmn4rxaJrobhxdELlaPYzdsBhC4kNRttGyzvx1EVOiB2noM/ejzbvOMw34qPZVHpwnvy4+bK6gOhRhPsO7/VMDrw==
SpamDiagnosticOutput: 1:22
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1984;7:jC1I0lSpefVzdMSREY3XvDOZoHTOcapUY2mCU0YLi0mk2eI7hqBr8LjfRBX/AUs7opeduwfABy+chppHBYReUNSTOdnWrKdBE11QIqdJ0r7rR+Z33vIK0uzDoqj5+iTJNC+jbo1ipqsEAuw4TkObfEVBaLumUSZJIFksmMea0kJEh8otpxdWGhz15gxkwYU0U4x2h/m/iz2vt57Xkc/CZR8kegIEZ/m2jjzfBwP40hc11uDa/XJtrqBHZ4WUqhmW;20:1hsOVoQ2YDDnWw1rvOAjy9a1w3fHPn1sfnIS0tPngZQuIEK5cGJdSyKhdmnNSdyvBlahrilqvz7tDEm8L3tGS1NSfvQ8PPeIi53pBaEUcEYSAkWva5SUI4zPhjb8JOUq/HQPOZA89MToj673wZwYol9ZBWcBZ3+YVvdeYNU+jrk=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2018 18:32:39.8236
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02c004f1-33db-4707-cbbe-08d5e5ca5abb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1984
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 03:42:05PM +0200, Vitaly Kuznetsov wrote:
> These structures are going to be used from KVM code so let's make
> their names reflect their Hyper-V origin.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/hyperv/hv_apic.c          | 12 ++++++------
>  arch/x86/include/asm/hyperv-tlfs.h | 16 +++++++++-------
>  2 files changed, 15 insertions(+), 13 deletions(-)

Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
