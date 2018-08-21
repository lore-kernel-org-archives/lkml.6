Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87452C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 273F7217B9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="EyZKamCW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="FYIQRvjl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 273F7217B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbeHUSOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 14:14:14 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:33062 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726590AbeHUSON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 14:14:13 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7LEqoBb016656;
        Tue, 21 Aug 2018 07:53:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=AbLM+E9uBjBmkmY7LluPRzefXtFH0UwLaYf0oD/4swA=;
 b=EyZKamCWPvgfv8meMSm2nkuuOEybfenai87b2oYc+mBHSdtTuhS3+BnFXgGDQMb+fHYK
 CrcHjmBDVc2fPrTseHLafl2YbFlFGUuI0LHTiuS469WVC+j5qZn7nAAEgMDh26DP0LG1
 jdIBrxuwImY2PzKsspsM1v24gTqMiSD3P+E= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2m0jqqgbds-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 21 Aug 2018 07:53:38 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.28) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 21 Aug 2018 10:53:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AbLM+E9uBjBmkmY7LluPRzefXtFH0UwLaYf0oD/4swA=;
 b=FYIQRvjlpTtDBNZ4oKRkOT1n4bPyP55+AlW5p2IwOrUWgPizBoye+FwpczC0aOBjjDMLpYUHxa0Kw7YSb1FPbZU20ylBiQWRSQModz7UxB1LZKCqPKIfd9mu6rX6mwhaahkuqJMcFce99+Ynf7PUE9ir1mMIHuJHoy+bb6xYTS0=
Received: from doronrk-mbp (2620:10d:c090:180::1:f84e) by
 BY2PR15MB0471.namprd15.prod.outlook.com (2a01:111:e400:52da::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1059.19; Tue, 21 Aug
 2018 14:53:32 +0000
Date:   Tue, 21 Aug 2018 07:53:21 -0700
From:   Doron Roberts-Kedes <doronrk@fb.com>
To:     Dominique Martinet <asmadeus@codewreck.org>
CC:     Tom Herbert <tom@quantonium.net>, Dave Watson <davejwatson@fb.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] strparser: remove any offset before parsing messages
Message-ID: <20180821145321.GA44710@doronrk-mbp>
References: <1533854411-28184-1-git-send-email-asmadeus@codewreck.org>
 <1534855906-22870-1-git-send-email-asmadeus@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1534855906-22870-1-git-send-email-asmadeus@codewreck.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [2620:10d:c090:180::1:f84e]
X-ClientProxiedBy: MWHPR20CA0012.namprd20.prod.outlook.com
 (2603:10b6:300:13d::22) To BY2PR15MB0471.namprd15.prod.outlook.com
 (2a01:111:e400:52da::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f22e07a1-0ad6-4e65-457d-08d60775de4d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0471;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0471;3:M+rdx1ohdJ3n8jjGHeo5zCFmrBe3inLf56L2gSySt+AqfHMwQQWQ//EmELofVNadxglyBz/vmtlnPXxcEI07Pqc/CfItKKWJzrw/Dr1NCD68gOnnlthrfd4OM1EF4grrzMDOq7GVJVAlnceubT0MZT+8O5Uy3FcMR517VVIOeX6gDz0fN+kLmSMRGQ281Yf5WukrgDZCFZJFy8lDlDSoQU1j5vbkNl1JIhS1qJgm3nnvryPdYRI83uaK/RVbloLU;25:dBXAp8Fg3kv2XYSakwY0F0LRlbYpgHi4JSFvgyxFM/7S4aAQS8z5mTz2S7o4Q3iwF3Fm6QDn+fMfV+8qs4dezY8SfbauFhmzKAxA2niTDVEaEFev/k70CgBcMdQJSLIhslYoZukkhnQC+C/i00QVZh/eB2ij7S0ecuecrSs2NhoyHqP9jm7gRLTvSqgpxVonkn3fkpzTx6elmy8Fus1v/j6ZRqV4CVzq4zjTTmVQA/f/XK6iDROqXqjuH/g8KS/bAa51Qlwiu9y3OEqEcs+hqGEklRRNi3nf0WR9Tl6RnkFZc14jO1QrRNV54/sGoWKCpy14z3J0mxCrspf0YEw4OA==;31:1E6iqz/bEpPOnY+/LJspkiCIP9LmVBldfP3coL+429OSNWBZyUI7eHGX49+9AVCdCpGi4NvW2ICflwaEOFeX5/VrPsaI/uevew5ORHf/lW5jOeXSZdP2XV22BnyzEW00sBc3r5QieeGSdY179ME6y+IkAmQJU4lV6N+bspo9QvGSpOdOC7heasPEdhbEgjBh/sm8l5uMbXxf7gpTynu4FczzbvL/7C+xT9xZz2xpbo8=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0471:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0471;20:F4Sy6CaOojpTNuV4xKW1ABvemh9HwUr8fG+TeV42ee29CRQsxgL3iBkBhaFKhn6dqp8kfjozVfRoWWY40A18unOo1fg7h7Luc18EWZF9w3FXnkxQKCDT6XFoD5DTOvtbfHPrDlzJ1AYhAagtXYHTos0EszKnuuCPpFIOB25bwPqQzkbm9F5lEfe6Gv3t2FLs3hZsT+A/fggYGQtSoYLP1S3ue7L+gfh/zvaEEZU0iOsDOy864CNuMo4jW7B6u9+G+WyKWq09Lg4kE6By/oTOqWZJzt0QkVW2dy6dNx9STnhpsQX2+koypUGv0GflesIm8VWRKpXhV7RHDPUtdwjrO6BP81MeanSRXwcqeqBatDDkML+dz/22bfxFjQLbHQTwwM0atcQAzqbKFTdHrTRWxjVW+RrFd7EeGGoEGwsVdxWqM3a9QRysCIrRsPFpMTefytGB2kHK88I/5Zaw8kJ2sV+ZM4s8H4LrXS8TSD6HpmjFvfTyK1P8Z/vC6kBMf/5d;4:icepqyqP232EUqCkcvk+HNT+5YwLSkfzJe9JMeMB/cDana9JYXvt0u1SjpT07RuhZaM8p1gXKE+Z/3rOqQ8nQydOErHZETu25x7CR9PXtknde8I5kBt8mNkmpVNYEw4P3ral/IxbpNrxncfDmLdHk2yVepJpb7Z9xOYtonbGOrcqskjs6eEPwD8SiGptMBbMIaHrGid9f9wqga7iNcUei8cHqog5Wxa+OFYmK9A2ZuE64N7GXe92kWdTMfKio8yA1Fs9MAlJc0tAgWp1tBvC+g==
X-Microsoft-Antispam-PRVS: <BY2PR15MB0471C4A6D69F622E6A271282D0310@BY2PR15MB0471.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231311)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699016);SRVR:BY2PR15MB0471;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0471;
X-Forefront-PRVS: 0771670921
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(136003)(366004)(376002)(396003)(189003)(199004)(6916009)(386003)(81156014)(97736004)(6116002)(8676002)(68736007)(53936002)(23726003)(33656002)(8936002)(46003)(2906002)(86362001)(5660300001)(106356001)(6666003)(105586002)(478600001)(1076002)(81166006)(54906003)(50466002)(316002)(58126008)(16586007)(25786009)(305945005)(486006)(52116002)(6246003)(446003)(476003)(76176011)(52396003)(55016002)(6496006)(47776003)(16526019)(11346002)(33716001)(9686003)(4326008)(33896004)(7736002)(229853002)(186003)(15650500001)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0471;H:doronrk-mbp;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0471;23:Vgnl+Uj9M5cDSryDKGH8dsSYOCYoui+3gUEwMdS7d?=
 =?us-ascii?Q?tzux96moPpQRTUxi7qHewHKz5z2G9ix5ogwkXL51yoXdTojhr5hy+9NtJGWB?=
 =?us-ascii?Q?hw9MBMXKnXCmSHOkt6xetk48MRMpYXzYPodkfXhO7pdNfsv1y382/NMijzix?=
 =?us-ascii?Q?VLa8k8KbzZdDxOThRWd6zmkqSs8a6BwW7CkEnSaW+CQUcY5q0BD05falwECS?=
 =?us-ascii?Q?mHTez5+ER7N3Ljlj2Y16A33nUrAJrQJwDU585xlbW4Ey0ZX5ZQL0DORsWTGk?=
 =?us-ascii?Q?ar4j6LstSVf/mf76ycuJRjECEizlFuGpXZjfc2kuPPq9pU+pU0uZVxife9Vw?=
 =?us-ascii?Q?gM7atshKqTp4kDPIbEi7b1uJeX+IkarhtvKzkRXFymn4xGCA78xvZDIHIQ4v?=
 =?us-ascii?Q?q7yH/WCvgEzsPm8IBS0lR0NOZJv+iyQRitK1h/c/gFByA5l2wC49jXhgB9k9?=
 =?us-ascii?Q?bqrmsDq+j6o9rCH0ediNDWp1QZaQKWzbxgCNFf7P12REcbLpCGE/4q5euIeP?=
 =?us-ascii?Q?2WvP558zYa9SNcuXW1XKcNP6SX8F8Ot7dZpvSFg1ktczv7EPdA4635CiG1FJ?=
 =?us-ascii?Q?FRhYpDxO48yknUS0nAyUjkwS3INkFA3Ffdei6ENnEO6fxYerxGCRDd38UUWe?=
 =?us-ascii?Q?5EEj3nVDQB1Ti+WM999v4KpTYhQy0aY3ItK/wcgJikmq0pCqcL3NRks0+jsQ?=
 =?us-ascii?Q?kiqnPSo/+Ac6/d6AFxYiGOk5HLt7aktaIvYijvwnIZkRjKsQfNMXvcyZq/rV?=
 =?us-ascii?Q?pfS7n66axydFsBNIzdPRIxiUX3VHtmozaBdYoNUymj37vb7KfTievcjqVTvb?=
 =?us-ascii?Q?4lB6vi04pNbXHXvFXs0yhzyGfCgqzBvLf97g2+DdiC39ipoSuQrQ+Vq5UDSQ?=
 =?us-ascii?Q?twRi1+41F0QPkbh191Kr0FRsGKuxceZwfAQ61jgYCucvfr2JKCRUTdOkKP3x?=
 =?us-ascii?Q?vyEBobj4nhH7mkqXwIcLNCoH6wMXPtqXfS1bM8vw3JxEAnTazXQRygcRl+jI?=
 =?us-ascii?Q?hxB5zVUf/fnN67bYZ+XDLMFPrNMkg8fg8UQHBqXezpPdOU2uqSkAkcBmZzEp?=
 =?us-ascii?Q?piJA1iCx4oTMPuGV6KWv7a0vfazN11EliOuikst6X9+jSCc92c8FWJeDu6pd?=
 =?us-ascii?Q?fjL95MSjuIiFiriVsdIu0u6pp//MywE7CUV3J7GMSLoBWC3yf6l8y2cYlCnB?=
 =?us-ascii?Q?lDZY7VO8fhsNU52PMxV0BqJ2O+0yn3VvdI1UsCjfNGz00ymvKOGkEaBgenfy?=
 =?us-ascii?Q?ZoQr3AhmK6Tl+o8XgqPQ94ooRNLiMhrRxfDUCKZ?=
X-Microsoft-Antispam-Message-Info: zwgS3rUrMAUbMKk7drNu1PKtfPNtGE+f0ibtxaT7n8m7BkqjHPu9m+2LbmyggxIXUi5eZ3CllV2oCF03TAXqPL97dMEg9HztjYrMZzd+B+l7BoeUQQG8RUr5CJOwSV18VKvLl9n35sUJdArM7uguZC6jiWdH0vv9HyJXB/a+i8H0PANxbKaIz3KNn+wEpLnYbkiUeJYrIJnNkeP5xyYndSgBsfG+YXbsCdY08X87vbeS4RYmLPno8EWtrk44vT+vFnzKFZCnskmwtbDmhxLHPEWAZF1b405qB9Ye1GDuTL89xqEMGpSdpFpSBqwGrVF+UuDlkk9M4y4lyIviQnN5xA2NS8om6JZwnd2dLrw+l9I=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0471;6:nJabsHr/2jy8CnhnveGJUMkornDzdEUV++ZRO7p8SPDp6VtuaHNBjvwXmDwDvuSQ4/xWuO+rkQWHJyw3r42zSm33u5VOqKt90hcUAKMFxP6wyt3DQT6B6vc0Va6iOJozoHqFmIk35rls2l3xLnenWp3TQep3zdZATg0SrqnN1UAlKUqjiT7fJ+/r7mBgn/jBGo/uG1crarh2eKkxkIyUpAC+ozmlPu/tRuV3J2AYqJbDASGEFZ6YxBt5OazCwff0u6yfcDGtns7t5BYs70hAi7tt/OlRCzcIaBHyz7XeVNJ/DFooRzsDBjejg1MYdV7A63xCFdeXR1QPRe0SQJg9gFbt6ZNtWuY89/6IW2vjCu8JAuRXCZNQH3gygvgWba7WoktiCaggxRP7nnlZ/2l04emxo5Wj18cqEVWGz7v2D3lKHsJJJvaou3ayRb5D8l5HXAJxeOhShvWVmH3iKm9prg==;5:LLjQAlx9AbamG/KyvcFf3sOIDjjg0439G3N5B70G7j+9pvD6SiRJT9q6KZnX6Zk1tjv6SzGrINstTONn7vOw+95kQHbz55UjpKtNP+Yu2rg3tQ0RNEg5Megiieg4A2rXExARVQT1rGg7f1vzlkfjogclParFCDSXme4Mym7JGdk=;7:dsoZP31HNE4/rUlOy2Uidvl1Koct/88MsJupWIC45BQOCjuYL7+MrkrrLaeTrbgnrDtdCSwJ/rA8zRPEvFi2X2rQ7owQ6LYL7SiWeHsQxsrIuP5JZx0P2oGA59lK++KBsZcqMblfqAvMo6kqPMJcZL9hH4SvujXi9ih60YoiB8sH8cf4PPgS8sHCbdeEAZyOJ+xxb5jouj/dv34JAdPlGt66R4Qp41vMYKviXITNUlam40cnCGbWDPGoGBTA2z5l
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0471;20:IJb2umAaGYQbRfNnZuV+3FfipKt/PoOwx5f/lI41oTTDWW/2g1qQMDX2+JSOlrG0ll8NcIB91B6S9z+GLzbhyoAXynaUugT9vBsY5iYQeL15tp8eH5p8jW/WEY60la33WL2MNsoh7VHPYGcvmZiJndEoR9inZsJ7ybxanYTPwM0=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2018 14:53:32.4293 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f22e07a1-0ad6-4e65-457d-08d60775de4d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0471
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-21_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 02:51:46PM +0200, Dominique Martinet wrote:
> Offset is not well handled by strparser users right now.
> 
> Out of the current strparser users, we have:
>  - tls, that handles offset properly in parse and rcv callbacks
>  - kcm, that handles offset in rcv but not in parse
>  - bpf sockmap, that does not seem to handle offset anywhere
> 
> Calling pskb_pull() on new skb ensures that the offset will be 0
> everywhere in practice, and in particular for the parse function,
> unless the user modifies it themselves like tls does.
> 
> This fixes a bug which can be exhibited by implementing a simple kcm
> parser that looks for the packet size in the first word of the packet,
> and sending two such packets in a single write() call on the other side:
> the second message will be cut at the length of the first message.
> Since this is a stream protocol, all the following messages will also
> be corrupt since it will start looking for the next offset at a wrong
> position.
> 
> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
> ---

There are a few issues with this patch. First, it seems like you're
trying to fix bugs in users of strparser by changing an implementation
detail of strparser. Second, this implementation change can add malloc's
and copies where there were none before. 

If strparser users do not handle non-zero offset properly, then that
doesn't motivate changing the implementation of strparser to copy
around data to accomodate those buggy users. 

Why not submit a patch that handles offset properly in the code you
pointed out? 
