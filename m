Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33726C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF5A520841
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="k6fDcQEB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF5A520841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sony.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbeJHVYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 17:24:09 -0400
Received: from mail-dm3nam03on0094.outbound.protection.outlook.com ([104.47.41.94]:29334
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726476AbeJHVYJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 17:24:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector1-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJapDKbRZjd5+w3szmugamlDLZHnsFUTOdOsEv/Zz4s=;
 b=k6fDcQEBGsUoFBLyXdmNW0DesweB4Ks7dI//CJ103cmkXlcKa6uOTqouWYDiZybCtCkBtcLZBdO9c+z+agaTcKQit2AcYzC/CAPu5iZN/0AMCeaDYYitCAHCOkvEKVSlJB3QHThWVb0y21Jp9yo6/+8SKIxRVW9qK/h8QPgpVqE=
Received: from MWHPR13CA0010.namprd13.prod.outlook.com (2603:10b6:300:16::20)
 by SN1PR13MB0463.namprd13.prod.outlook.com (2a01:111:e400:c41b::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1228.19; Mon, 8 Oct
 2018 14:12:09 +0000
Received: from SN1NAM02FT064.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::201) by MWHPR13CA0010.outlook.office365.com
 (2603:10b6:300:16::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1228.9 via Frontend
 Transport; Mon, 8 Oct 2018 14:12:08 +0000
Received-SPF: PermError (protection.outlook.com: domain of sony.com used an
 invalid SPF mechanism)
Received: from usculsndmail01v.am.sony.com (160.33.194.228) by
 SN1NAM02FT064.mail.protection.outlook.com (10.152.72.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.17 via Frontend Transport; Mon, 8 Oct 2018 14:12:07 +0000
Received: from usculsndmail14v.am.sony.com (usculsndmail14v.am.sony.com [146.215.230.105])
        by usculsndmail01v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id w98EC62W031685;
        Mon, 8 Oct 2018 14:12:06 GMT
Received: from USCULXHUB05V.am.sony.com (hub.bc.in.sel.sony.com [146.215.231.43])
        by usculsndmail14v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id w98EC6or020937;
        Mon, 8 Oct 2018 14:12:06 GMT
Received: from USCULXMSG01.am.sony.com ([fe80::b09d:6cb6:665e:d1b5]) by
 USCULXHUB05V.am.sony.com ([146.215.231.43]) with mapi id 14.03.0408.000; Mon,
 8 Oct 2018 10:12:06 -0400
From:   <Tim.Bird@sony.com>
To:     <josh@joshtriplett.org>, <laurent.pinchart@ideasonboard.com>
CC:     <James.Bottomley@hansenpartnership.com>,
        <linux-kernel@vger.kernel.org>,
        <ksummit-discuss@lists.linuxfoundation.org>
Subject: RE: [Ksummit-discuss] [PATCH] code-of-conduct: Remove explicit list
 of discrimination factors
Thread-Topic: [Ksummit-discuss] [PATCH] code-of-conduct: Remove explicit
 list of discrimination factors
Thread-Index: AQHUXq7j49Cr0LerJkWn43uYfsrVwqUVXrDg
Date:   Mon, 8 Oct 2018 14:12:05 +0000
Message-ID: <ECADFF3FD767C149AD96A924E7EA6EAF80517449@USCULXMSG01.am.sony.com>
References: <20181007085102.17795-1-geert@linux-m68k.org>
        <20181007113514.GA21217@localhost> <1814283.64diKEr4zR@avalon>
 <20181008022931.GB30346@localhost>
In-Reply-To: <20181008022931.GB30346@localhost>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [146.215.231.6]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:160.33.194.228;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(396003)(136003)(376002)(346002)(39860400002)(2980300002)(448002)(199004)(189003)(51444003)(13464003)(8936002)(5660300001)(86362001)(356003)(305945005)(3846002)(246002)(4326008)(8746002)(8676002)(106466001)(7736002)(316002)(93886005)(6246003)(2876002)(966005)(72206003)(23726003)(97756001)(50466002)(2906002)(478600001)(55846006)(11346002)(33656002)(446003)(2920100001)(2900100001)(486006)(126002)(476003)(46406003)(110136005)(54906003)(47776003)(336012)(76176011)(66066001)(7696005)(426003)(229853002)(102836004)(86152003)(55016002)(6346003)(6306002)(186003)(6116002)(85326001)(26005)(5001870100001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR13MB0463;H:usculsndmail01v.am.sony.com;FPR:;SPF:PermError;LANG:en;PTR:mail.sonyusa.com,mail01.sonyusa.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT064;1:HGgC29R5rOUUQqMNOPONbF4UYOzlhTJ9OG5DCoQIZ2WGTwMxB1JiUH9O97wt+URci7AhzJBldYiYoim6fr8eQMzmNULMiI/hxps1CT2HVON6/1xnipfTFxzBP1fUiKAq
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d485cef-80b7-4125-1bc6-08d62d280846
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7193020);SRVR:SN1PR13MB0463;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR13MB0463;3:rEa1pL/STTIW18JppxqeNSEKcigboAWylwqjBWsT7CTqnrDhrSuHm+MkXYSijvJ/+B0CtQeB7Jtsp1r6Er/ReW5agbXHQy1+Lg80hEDDfE8GJeyhneBxPhLWbykgwVePY3WROG6cYvwsRDXxx9aZvOCWq1T75BJVrHIp8Il/qKkNiJTuxYtmbXZjt4sZRcYRK2ILsRRqMdfrbUwb/W8QecpuHGPvVzJ00a+eN269vJlKxl+XesHegxllZkLXAbwZcbYu7Y9AYHhXyi7ChITMGDVe/6h8jtiCZRuJptnUY8FvMXHR5F9bSja8loO6yGyVXVX2E2TjFgpxltfigdcHUv9/W3Jy72OV0XD89f4fl2I=;25:y1RVFhwy3UkqlqmL2wI7h23SVFDMt+lFehPh0cu4/qyNNZcP6KRt/zd1vNyZNnV7/BFBnxtDVWFUr5zUAgV7YbUTxvk1ycv4TPXxJ39IXel7AMRNftf3L4KrSb6MWmlkHYmOI3qe3am6Mt/TvUN7nVoN09tiEL0VxfyTk78Yj5bKgHnjhBsaSTV6oHezjSDGisADdu18qqmV9ctk08JQyYNoQBpLj4Py5fRJtuffRukqHIlsiGQos6UARTcLbPQoKxJJVwhD5V8Go2w6XiFO4iXmPJxFaCPVbW32bAk6yGqpZcwN5SEfOItdDjLyJRzt3kDZWrAmAWEL6sxvZJ2Tfw==
X-MS-TrafficTypeDiagnostic: SN1PR13MB0463:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR13MB0463;31:BGk4+M0UBV7eMCRPsbFx5NomCvub06H/JF7/GVjTWP3QRyuE0x5Gd4m4UJ1AbYFbu4B6qHwK4BCeUZvDUHuRdGa9yYXQiR+afuRDjzYUwAK99MjgArr9hXRc+L7ha3Sf7JXEyOAXPkDr8AhExg1hMWqc11gMGVUiibMvpXlwKqJQd9u1GOySBWn/dc0sNW8k6QAHjHPI9J/mc5tsAeA91wl1mMCcy8OEjzgwOcUKs3A=;20:K4eh9FyV3dgD47CdXLDNRGxl38io4CNFvsRa6cXJg3h/c45xKUNTb4WYLWR6A5uQ00lBFLeE/dfAcjQyqra3WTj+9/UlO9KX2oF5vA44fgl4oNtHmRmeJesUtg7FhjMbqoj2W7yqpTf9y++LIUnlE+K0jnOTlCfqWmSv2BMUwQUKy1pq7hGV9+1uO2+rf2OqidYzfeRlcRJH9JJ0fvVK94+/0wOjWQWa22DnVFd1T5mDtkjCBr3HLFvi9APNAM1pTmNRw3LoD4PYOn3zhrF1LwmeRJfJlm0SQWKwTOfelaD0LzNJtyUH0A/+AfG7Sa0gZ8vjRWa7H7t57CRy5R0hidPWpuWXIVwtiO5cbAS4pAOBGgvu3J7SFTS4b9f1pX9nuCGkdVu1pMFY9ScGddibXLOLbQAGqV0/MCXH4aD5xXSO9U4bOtOUpCEfAX8vPM4wHOxADkodzT4eQvdI7wQ02w8LD0XnR/qWUIeIo7EkYaujPV2N77fz/itAXDc0nRHa
X-Microsoft-Antispam-PRVS: <SN1PR13MB04636DF336B8B0C4D23E66F5FDE60@SN1PR13MB0463.namprd13.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(5213294742642)(209352067349851)(166708455590820);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93003095)(3002001)(3231355)(11241501184)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991055);SRVR:SN1PR13MB0463;BCL:0;PCL:0;RULEID:;SRVR:SN1PR13MB0463;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR13MB0463;4:1GAtOB9XoCD9mnW4s8r4E5Rru4N7XcH6KpRISuvCKhZVhYvPJo8G/sJynEglwDn/7cYWSDrirGCzAWMfrTbc675vc7irp3OVrD0y9z0pCy6ocaJ82+2IDjddDvWi9TSQhyp57YsMu25y/7vNLhPbLb6F77pv07oO4z9m6uGe7USAfTa4L82RZzq9JDIBzxOf3az/fK0gEMfkK1JQihlE+Li5+RA8dwLFqk8sfdPkNhmtc+QQAOMx5gFOtBFQW/y5SUAA+KH/XFb4aSsew1nmBifDMw8Dy/30iwz5Jxzu/M+8wyeoitBJfGashiS5Y2fMTelwbZz+IbzqS3cSTBoX/4Y+YuvzATJFaUc6a0Kl0/pvePNc2vbJCG4orrBI1sHC
X-Forefront-PRVS: 081904387B
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR13MB0463;23:j4udPepVTt0UhAyRFyp2OUc9+wUhX1QaQDN+LAIrU?=
 =?us-ascii?Q?SI5eW4sE+5qHMy4t+p4xikC09e5pAVBnwBNg7jgJJXj/iXZ2SSFFBmbaB02t?=
 =?us-ascii?Q?glpiKHGHM1Ol/GUM9cFYTA3uWakM8ZHjF/ORcR7hat0RkGs3+RcdB89iL6CJ?=
 =?us-ascii?Q?eF3arlaFaC76033glNqVzPcllkoQGGobG92midUuNmJF75Yzv3Jk2Fj0Irkg?=
 =?us-ascii?Q?vaig4jwNgE7gg6Im5yRwAY5AbVLlibZGTrQj0ZIL8q3ttujETcDB4+X+FyBX?=
 =?us-ascii?Q?H3Ms8yQtlpBsty565PirFgje+h/AqMXDa37aXhwcuKNnG01WpklbGeZLj/OW?=
 =?us-ascii?Q?dGmT5Yn3OcB9p3JfjB5UTLLDr0YNPT+Y+2Qt/yGJhf/tW9kc1XjHe2OL6Rmo?=
 =?us-ascii?Q?XynhrTCSqinS8BdPRFiW9K1w5GWecE8vkzyznBhc0PYdPSXpq90ClA8DKDom?=
 =?us-ascii?Q?7Q4FtGoHqKQSBieusLRqQr0b1nmQT9F6lxyiKuzI56tW1SqBL3zhMTl/0tVa?=
 =?us-ascii?Q?5ADNPneJzIfNLjOWHjQ5rpCog1b6U0uJ9oWUkQ9wDHP+2m5wamMZi74GB49x?=
 =?us-ascii?Q?oy+orlzSWloatgY2p4UvOuv6K2tpzmAijJUffaccFMIx80Ze06kPSwioeY23?=
 =?us-ascii?Q?CCUIOhz9NIqadjYYSRMoSwLVN3yWuKkdCDLPOAN2afLI3EE/Uv55aTd+ztb4?=
 =?us-ascii?Q?fLUUshBJmcvuXotueh5n6TMCrJFlnkJAKGhizz0hHFTKpyHQgCmS2kfsoKw7?=
 =?us-ascii?Q?YSzIhHhWE30/biZ3/D94kg4ndztxK96T2n0YN8ogvBorePW3uNnxYtP05v58?=
 =?us-ascii?Q?uvoewV4vs1mry+4nwO7YvRaVFgPABHxuJIOBTe8ylTM0Vmz3u9uaVqlE2b9d?=
 =?us-ascii?Q?NQDrHSVYZz07CvsRsRmJdOWvWEOLOG8aSIGEQZi1jnd3dgf9+QwOp4+etlyl?=
 =?us-ascii?Q?aP5nMS0MuOvZzKUqT8cEySfP/QHOzOdf09BmNpCiQAen+shY07jNQElOONSt?=
 =?us-ascii?Q?EtdcB61BzYQnPheTF9PZjJQ48xUDUt8cNEmKnw9DPzE45cicLqsChA0ep7gd?=
 =?us-ascii?Q?970dyzXXQqQqm9awEGrA4OBVaCaN7+rMSopRTkcQQkWiViaRSSHL9GHF1kq0?=
 =?us-ascii?Q?mg/WcvauI7dM0oOExu+UfCTUWsuKj53E7AiSm3xHlJut0YDqQrmyQ58OHEA8?=
 =?us-ascii?Q?ev5xl+aighyKOaOn/yeIYvh+I38fDoBl0gJl8xI0s8zilIuRbdtY4fiOn+g/?=
 =?us-ascii?Q?Bo9HUwDBMpiBFYmCUZ0a/S5MVFEwVnL8QGxYF0nxuDGCZX0OWMFFVSUGwofT?=
 =?us-ascii?Q?IDdHTNNwg4jXW1jAn9hIZhnD+IFPSm09O101CCVkMRuIUAnc9Lb7fW2ezwOo?=
 =?us-ascii?Q?8WyQQRPIZQiKbcao/GxnmGASDY=3D?=
X-Microsoft-Antispam-Message-Info: wQyGAb/y/FwiP06NBMQ2ONMY6UshuarPGpOXRLm8X+ngXSJoXQ3voFvjGteC+axh8hFgS57DYdGN+pCP/uqFhAdW/mcHdHuOx3Dnf/GswnY+8/U0KWLc9ZcGz9U/CfFDx8nO6PzuCrcOgsUwAr1LFai95eWtwMewNpQbbce7C68LKCYDUTlBAczlZOFd/FQLg1N7NskH+lwCZfJOs1YeC3XogVVMEk6bgvMd2O9uNuCYbdiES4V8pymMZnN73ktOk862IBa9jHJy6SFs7uwmIyD29tSsMMdd19AWkkBYvIiiwPOrW0byS7DYNd68C/POEvFGgiKgX0HTw/vLDSbCjU1kWfEaAdYyNv4zWVqlYf4=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR13MB0463;6:oBtkuyMDIt5XQCr6xSuipG9O0wfY9yjbjMf8Vh5ZCduYyMcoKANudxeXuXAQM91kscAkzxJFZXBTl/5NXho8VY+4vLWEyUY+lfaotjrYIlXM/7BX7t5q1HKAiouVK3jWwG458FgFKNqSSO5C8qaTZUvZ+ySk80W0+pJw4UGjE8u+iPOOaBh47zi101KNXYXA/9BRQH8xxRMHFujFRikiZhcBb79fvTfJQemvpagU/V/IXLKzGSwTlbVEnFU2JOjdxCEMCzKz+rl5P5PPY1cDXKkEFsdsWySHaZDya1fftaEya77BTURuaBJBu5vAQBaXa+5Vevqez0Y64ovAc5FHvZgw7bYPwI/AvbOvetKSxPZoW26hPBnEmwzORyg63GpB6aHqrkD9u0LS7JEcQj6FNdFha4Wc+DvUxdQuueYgCOGpM5APcEyvQB1GIRDg4eqQ5P+EUhPX+Hv2NrYe1CvoUA==;5:WUB6Q44/S5miZc5LuGhEjT3W6NwT6fgNQNi3GvM01fFuJdsH2nTdWDl6QG7URiDJuXFPr6PWkDDJpY9mvx+EiMXwbA6tytkf2/oGM5YMtcMA/ESpvN1a5b/xdfIYZP1+UaiTomIFV774vmqlPh7ct+mCyTQZWqHwZCuwoKaB30M=;7:7lLI73B5K7xBN/+1OYU0C0+wgI0rdYvJ4DkOnbA3wEp64qxxplr7ELJXO/aOlxxMVwPUwnVKYCVfrKzpjR9QTmSWXqXh1mlv8ySHTELYkfGjUCmWBm6INTM2hnkgga4kbV3R4rrDckAiBEq/fd6DwUZel2XEpKQWn7Y+TFcEO4HEA35r5p1MLmOceNFHrjnqDoejum6hBFviJk4bm/Gs1+6whjEplPisEOZfprL6bd8YhmhwY65V6uprVdPuZJKy
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2018 14:12:07.6820
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d485cef-80b7-4125-1bc6-08d62d280846
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[160.33.194.228];Helo=[usculsndmail01v.am.sony.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR13MB0463
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Josh Triplett
>=20
> On Sun, Oct 07, 2018 at 08:18:26PM +0300, Laurent Pinchart wrote:
> > Hi Josh,
> >
> > On Sunday, 7 October 2018 14:35:14 EEST Josh Triplett wrote:
> > > On Sun, Oct 07, 2018 at 10:51:02AM +0200, Geert Uytterhoeven wrote:
> > > > Providing an explicit list of discrimination factors may give the f=
alse
> > > > impression that discrimination based on other unlisted factors woul=
d be
> > > > allowed.
> > > >
> > > > Avoid any ambiguity by removing the list, to ensure "a harassment-f=
ree
> > > > experience for everyone", period.
> > >
> > > I would suggest reading the commit message that added this in the fir=
st
> > > place. "Explicit guidelines have demonstrated success in other projec=
ts
> > > and other areas of the kernel." See also various comparisons of codes=
 of
> > > conduct, which make the same point. The point of this list is precise=
ly
> > > to serve as one such explicit guideline; removing it would rather def=
eat
> > > the purpose.
> > >
> > > In any case, this is not the appropriate place for such patches, any
> > > more than it's the place for patches to the GPL.
> >
> > So what's an appropriate place to discuss the changes that we would lik=
e,
> > *together*, to make to the current document and propose upstream ?
>=20
> I didn't say "not the appropriate place to discuss" (ksummit-discuss is
> not ideal but we don't currently have somewhere better), I said "not the
> appropriate place for such patches".
>=20
> The Linux kernel is by no means the only project using the Contributor
> Covenant. In general, we don't encourage people working on significant
> changes to the Linux kernel to work in private for an extended period
> and only pop up when "done"; rather, we encourage people to start
> conversations early and include others in the design. Along the same
> lines, I'd suggest that patches or ideas for patches belong upstream.
> For instance, the idea of clarifying that email addresses already used
> on a public mailing list don't count as "private information" seems like
> a perfectly reasonable suggestion, and one that other projects would
> benefit from as well.

So I raised this issue with upstream about 2 weeks ago, and here is my
experience:
1) I suggested that the email clarification could be put into the covenant
itself, or in a supporting FAQ.
2) The project maintainer (Coraline Ada Ehmke) was pleasant and supportive
of changes to enhance the document, and said either approach would be fine.
3) I noticed that there was a FAQ in progress of being created.
4) After thinking about it, I decided that I didn't want to alter the langu=
age
of the covenant, because I didn't want to dilute the expression of a need t=
o
get permission when revealing private information.

My own opinion is that putting clarifying language in a FAQ is sufficient.
So I made the following recommendation for the (not yet included upstream)
FAQ:

Q: Does the prohibition on publishing private information include email add=
resses sent to a public list?
A: No. Information that has voluntarily been published to a public location=
 does not fall under the category of private information. Such public infor=
mation may be used within the context of the project according to project n=
orms (such as in commit meta-data in code repositories), without that const=
ituting a breach of the CoC.

You can see the history of discussion in these two issues, online:
https://github.com/ContributorCovenant/contributor_covenant/issues/590
https://github.com/ContributorCovenant/contributor_covenant/issues/575

I hesitated to post these, because a formatting error in one of the posts m=
akes
me look a bit dumb. :-)

I don't know what progress is being made adopting the FAQ, but Coraline see=
ms very
supportive, and I've told here that I will come back and help with it if it=
 stalls.

Honestly, I believe Linux will adopt its own FAQ or some similar document, =
so with the
Contributor Covenant adopting the clarification as a separate document, I d=
on't know
if Linux would inherit it (ie include the Covenant FAQ in our source tree).=
  However, I think
that the existence of this email clarification in the upstream FAQ would st=
ill have a
beneficial effect for all downstream users of the covenant, so I view this =
as a useful
exercise.

 -- Tim
