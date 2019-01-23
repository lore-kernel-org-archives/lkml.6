Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4624CC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F051821019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="P1VtJviq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfAWMgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 07:36:51 -0500
Received: from mail-eopbgr150087.outbound.protection.outlook.com ([40.107.15.87]:2075
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726057AbfAWMgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 07:36:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fIRfRq65V/OETTo3xrqQe9ugAuQqNzHxQW2Z/sfdDvg=;
 b=P1VtJviqmnd26a6ODIOjvq8pHIKeUTy8CJ5NeAX9DFyIDsSHCufEj5Od6PpFgiiHeAtNVGhqrDWbVMr1x8wOjYcIlvIA62maCLZl69i9BuTWB/e6BJttLYDXJFe9vdrL1cxpkrSb9argRuYUovrZ5RhxVsz/hoUA3XYuimfoLfk=
Received: from VI1PR06CA0155.eurprd06.prod.outlook.com (2603:10a6:803:a0::48)
 by HE1PR06MB4012.eurprd06.prod.outlook.com (2603:10a6:7:9c::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1537.31; Wed, 23 Jan
 2019 12:36:45 +0000
Received: from HE1EUR02FT054.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e05::209) by VI1PR06CA0155.outlook.office365.com
 (2603:10a6:803:a0::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1558.17 via Frontend
 Transport; Wed, 23 Jan 2019 12:36:45 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.48)
 smtp.mailfrom=cern.ch; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.48 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.48; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.48) by
 HE1EUR02FT054.mail.protection.outlook.com (10.152.11.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1558.11 via Frontend Transport; Wed, 23 Jan 2019 12:36:44 +0000
Received: from cernfe03.cern.ch (188.184.36.39) by cernmxgwlb4.cern.ch
 (188.184.36.48) with Microsoft SMTP Server (TLS) id 14.3.408.0; Wed, 23 Jan
 2019 13:36:40 +0100
Received: from pcbe13614.localnet (2001:1458:202:121::100:40) by smtp.cern.ch
 (2001:1458:201:66::100:14) with Microsoft SMTP Server (TLS) id 14.3.408.0;
 Wed, 23 Jan 2019 13:36:39 +0100
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Vinod Koul <vkoul@kernel.org>
Reply-To: <federico.vaga@cern.ch>
CC:     <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>
Subject: Re: dmaengine: usage of dmaengine_get() and dma_find_channel()
Date:   Wed, 23 Jan 2019 13:36:40 +0100
Message-ID: <2574032.sm3A0MmqI8@pcbe13614>
In-Reply-To: <20190123121521.GM4635@vkoul-mobl>
References: <23108003.0nNWatJzJB@pcbe13614> <20190123121521.GM4635@vkoul-mobl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [2001:1458:202:121::100:40]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.48;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(136003)(39860400002)(346002)(396003)(2980300002)(199004)(189003)(7736002)(786003)(7636002)(44832011)(316002)(74482002)(106466001)(8936002)(14444005)(2906002)(230700001)(229853002)(305945005)(486006)(97756001)(47776003)(23726003)(43066004)(86362001)(9576002)(106002)(50466002)(6246003)(46406003)(76176011)(356004)(6666004)(6116002)(426003)(6916009)(4326008)(16526019)(9686003)(336012)(11346002)(186003)(3450700001)(33716001)(126002)(446003)(476003)(8676002)(478600001)(26005)(246002)(53546011)(33896004)(54906003)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR06MB4012;H:cernmxgwlb4.cern.ch;FPR:;SPF:Pass;LANG:en;PTR:cernmx12.cern.ch;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7baef89e-b54c-4190-e11c-08d6812f6f2c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4608076)(4709027)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:HE1PR06MB4012;
X-MS-TrafficTypeDiagnostic: HE1PR06MB4012:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR06MB4012;20:o5oVB/Eg/B7aiWXr7Mf+u2gORz+UJZcrkXH5M8DI5/QQ+h9/GhCMhAwzQtc6hKt/KtNbNBjoMqHe1R8xF2MrOoi7ukciluabE1iXi8WATuwKB1lDqC3HjzSlvV7Xl6Xo9YYwCyqR+dHIMq95tOyEzb5vtC/NBfZDBgzf+9jf+R/dtsKQ0rcihiNK6/i+mhxJkNqbIy68Wx7bzF1kqEV8moZUC5m8yxD8sJxDtzFhDX4LkO0IEu9xAtpzLQgIll0X2bN+DsGbtZ+fucEpbC6p1DFYkzjZpc95iJpilajpeEXUyseUdcqAEuvTBMxpZN/uKHf6+n3/uLwSMGdQxOt86xypLUNyMpaBQZBi0VBGbl+jH6wwpdn+oLb882js5EVYsIYUiNeJdNrxgQETGd1Ge5Mi1j4/gIt6NUml2EFItM1CcvhZADu2T2YjNqYBS0dgDiIumByCuv9zYbK3lzu1j0Qc6Sh3UaedTf689tXWeDYtn/K2ewFljHPiQ/ss53HQ;4:e+YZ4S+IISQHAolbcrbPrwtKkkkAm3wRuzu52ZCG3chrIqiTJgp+0E7ooQcXmfsDThMoqDfKqtXuxHiuf0URfCsh/m2lxe7+i6al+y4mvzwR4uWgQmB0A6PORi4RVP1Khm7SxZR/YggbaXau6k8U98sAJnDsUG5NI3HD8AnWmkves6Z4HXPqF5ovLbWnjrP6bWvnMRTMUxJeKy+3z7p+vER7ts/8WByMz+z3z3Gaadz6a3O1U0C6h/6ZbvUJX5/t9fiTZj8+TGpM9+gOE7m69WYqk9Tp3slCwSzAUqhAP0TBUjaJ9WFrXApiMlN0CIYp
X-Microsoft-Antispam-PRVS: <HE1PR06MB4012B5A782784320159E7732EF990@HE1PR06MB4012.eurprd06.prod.outlook.com>
X-Forefront-PRVS: 0926B0E013
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR06MB4012;23:1JkesBK9To/vHsYJ2gVr3IE3pdg9mIpLFYwnsRZc5?=
 =?us-ascii?Q?YI80fKoIfzV91uzIzVMmLAo8BSvKxSQ8sJyUhwkqkrK2pLN8nORryHW9sGoS?=
 =?us-ascii?Q?ofk2pV35KVtT2Ij/doN0WPX8VzyQDuh2MmIfBtQeWilU5sLs30y1XYV2HyAr?=
 =?us-ascii?Q?J71uxta9DpI6H/NkeY8aNTkn7qfN5K/hzVwFdh8s+IzYvVVmLXAzliw8LRel?=
 =?us-ascii?Q?wkwO4lzaSKnoD9Sbo72BZufVc6eZkEEKuaC70Qf1XxPyMbecRZIeex8OcDVl?=
 =?us-ascii?Q?adTqnrx8Z3U+q5nkqiSvgf5cAsv0OsWqE7zowluXqiBrTbVTrLsm5GTLFL8f?=
 =?us-ascii?Q?cT/m+bmoyrenqJfAveUnbQAEV++ksm0abs0bo3a3Q9fImh7aBxwIJJ8jK9cu?=
 =?us-ascii?Q?r5GVpwW/YJtskYretEb9k90eq/jr9aLeCz4oPVkIeTKYW8QnuURU/torFZhS?=
 =?us-ascii?Q?4cw656XddY0b9v1CR/NByinQH8g7cvuz4EPaSm2PLutGgIPuGnSJbpw6LBPx?=
 =?us-ascii?Q?tOjXyXgagA+1/ojS27MfM3dNgQLuLHoNs7xX670zppuC6K2jyvK9rnVvsRqI?=
 =?us-ascii?Q?tE7a24nMHQ/NSB/7mqSXhP6bE9fJQaitNYDSqjkZLg/bvy5O82IWNotB98xL?=
 =?us-ascii?Q?WIGW0+HVmB9Paq2kxR0MU3Ml64B5HsjwVJsNx4azniYCJcFFSyf0pXybpKOW?=
 =?us-ascii?Q?HNeRY57gA1I5C897omM9wtWk1JzjRSIFcSSl/UWz+SoJfur0FSq3TuFR+1td?=
 =?us-ascii?Q?FWooAiXcLMpDB50aHRSUTr4H+vCt5x73fA5M+rSmAM2kGpnbq3LWuh2uFQF/?=
 =?us-ascii?Q?zjy8Ovlb9HddX+lTpIgomxsxXUFkZ+VIMseGK8vgmAW42AoxML/qRAVGhIUh?=
 =?us-ascii?Q?KvPCV4BIwZz4/nRETOozWkZPETPbOLMP6jB4N2rD6O7ss3eRz7K10YmigCRG?=
 =?us-ascii?Q?BjxCnjbzhX/ZOYxl62TZ9bJe+MYM3anG5Xm2REDjNgfU1sidWeWW7Z3dUkGw?=
 =?us-ascii?Q?TU064HD89LWa1l9zGEaaDBG1mdzAfL6EvsWvStwnHNAFocz+BX1p/fwuqUG9?=
 =?us-ascii?Q?PoRYUbhyVYSiJgYmmLkxQR0yUYsfAhYNijfgdANZA5HKYG34SW6LnpALLz48?=
 =?us-ascii?Q?zcO7EwRySUR0OrhoT00b0FYLOux+a7kVy5RE9pXM78FnWBPZcf7qHaSMBNwK?=
 =?us-ascii?Q?mDwdOzDpyG0BRbwKkuJ+0K3Vc5u7a0PklUWkZt97zKkwGmAIJusS/p1+A=3D?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: tbh0CT4W2Nb+yU0zpogd13mqmhD1sh9sWcWe4AogloqdLNi62WYZxVC0/ssghWOickkcYieOz+UFQbCwCrLMb/11T1fCjw4aVo69oZP53NnVy7iRqqhLwo1+d+ufgrHnx+oLDUOt07GUDuMHSHlsOBDRRnIWYt7RkFrdPnjcWhmcfCxjVO7aDLjz4gDgXm0hmdf+tGSd6u0a7DRIs4Jhpjxfh8TZqq+h0yeO+2OD7vk+coCeTyiVeI5ibMYQfMZLpInw5krzgf/qS8rzkvrNJncHXIzd6BPn3kc4j17aTWgkey4N8KawjhOA/UQm0NZsv1yPRraLZ9xscDee2elIT74sa/+NqS8dZj7wc8dw+vx3PtVEaE6APnySfMgOtKa9zMFQE2v/ymmkvuIYINmCozj5YAPxA7p8e3lI/scp1Qs=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR06MB4012;6:bFMliJxEKlJ6f4SeaycCFs55GI0QqCzRDIb/7qNvOljV7BjVf6YfiTfBNjwDCQWG6mXcczdyfTT/POv4NRcaEEulp6rvRMrv6SgUUOLl9CHGAtp1ekxMwdfTspBT6HOtencn54aK/K6DPtsk4Tw6NM15dTE3J4zQKsy0Nh/URfVbMFJbrTnh/3Pmuc8x6TkM8lltLdC+q/r/QIt2jUaWLA2rOI/H4LYDWKB0QAsGUSfDgWpALaLiLJbuJ6rlSNykKglHFREd3+0tf9EuGyGDG35XnL/Yn7HlIJ+cx8cguBe/pelj5TtZsJYr1nVqe2tjZ8uJ3rZ4BdnneX9UWIz1AFJevC+IM6GZRgtd+bPHqwAbdi+YaZ6oAgkKwLp/VIypJdBe+6jySUGrcGLWqXmm4gKJNqj+ingWL/40KchcOEQfAgC/DU8YAo5/4ajWzKeuZePq/DQLJyn4DfrbikWtGw==;5:1f57EQEXu+weWagWM2i3kZ8H9J1r+CkSMSJfB9DGqw5QTR2bgIXND3qwUVbx1Kgc3XMyD9bzPnA5w7NmW7ILZGW0RO3Iyrat9vzbBO9UvYoObopJbT+X0GolOUI/7uTYSC4jdcNW2o+ZDmxrJ+v9hSGS6OlRIRhzQ+H0f78M12rziAzGHpXs47VbhXtP7R9O1j+oHG4JLaLD7EY0JET6bA==;7:ginHLAobruKGpEZdwBD/qVC/DE4KrHApUWy0el9oAYkT92xEGSztoNZFz6m8O0lxoW7ur18WMHrgljUg1B2ppLU66EiyqPol7tfOxYofnkduimcPZyUOzUuEK2ZWxpCvf/yg/at/7egEvkLWOLv2bQ==
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2019 12:36:44.5193
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7baef89e-b54c-4190-e11c-08d6812f6f2c
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.48];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR06MB4012
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your suggestion

On Wednesday, January 23, 2019 1:15:21 PM CET Vinod Koul wrote:
> On 21-01-19, 17:41, Federico Vaga wrote:
> > Hello,
> > 
> > I am a bit puzzle about the proper usage these two functions:
> > 
> > void dmaengine_get(void)
> > struct dma_chan *dma_find_channel(enum dma_transaction_type tx_type)
> > 
> > Looking into the kernel sources dma_find_channel is not used, despite the
> > fact that it looks as one of the suggested mechanism to access a DMA
> > engine. So, I cannot find a valid example of its usage.
> > 
> > The same for dmaengine_get(). On the other hand, at least this function is
> > used in: drivers/video/fbdev/mx3fb.c. But I believe that its usage is
> > wrong
> > because it uses: dmaengine_get() + dma_request_channel(), instead of
> > dmaengine_get() + dma_find_channel().
> > 
> > Reading the code my understanding is that dmaengine_get() +
> > dma_find_channel() should be used for "public" (not private) DMA engine
> > channels.
> > 
> > It's here where things are getting obscure to me. My understanding is that
> > DMA channels which are not private can be used by several drivers at the
> > same time. In principle they submit all their transfers and the DMA
> > engine will process them and then the DMA engine will notify the drivers
> > about their completion.
> 
> The concept of public channel is a channel capable of doing any dma
> transfer for example a system dmaengine capable of flipping bits from
> system memory to memory/devices.
> 
> For peripherals, we cannot do a generic transfer and the transfer is
> specific given a set of parameters for it to work, thus the channel is
> private... These channels can be used by many users as long as that is
> supported by engine. In an idle world, the dmaengine should have N
> channels and provide M software channels and lets users use them and
> schedule these for best throughput, we are not there yet :(
> 
> > My understanding is also that the dmaengine subsystem assumes that
> > "public"
> > channels of the same type are interchangeable.
> > 
> > In my use case I wrote a DMA engine which is specific for a subset of
> > driver, and it cannot be used by others (so is sharable among a group of
> > drivers). All these drivers, potentially, they can submit their transfers
> > to the DMA engine in parallel; but I cannot do it because I'm forced to
> > use
> > dma_request_channel() in order to be able to filter the DMA channels, and
> > this will make automatically the channel PRIVATE which prevents other
> > drivers to use the same channel.
> 
> Please use virtual channels for that, clients can use virtual channels
> and they can be submitted to a hardware channel.
> 
> > With the current API I do not see alternative for me. I have to use
> > dma_request_channel() in order to filter DMA channels. But I am wondering
> > if it make sense for you, and if it does, is there a solution today? Or,
> > is it possibile to design one?
> > 
> > Thanks (I do not know if this message is clear enough)




