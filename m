Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE99C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DF2A20858
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="aEZ2Xu6Y";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="WlndKxlU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DF2A20858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732061AbeGSRw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 13:52:58 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:41230 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731625AbeGSRw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 13:52:58 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6JH3GTl015297;
        Thu, 19 Jul 2018 10:08:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=C3y+iFNwz7PrpjkVQpJg70wnvpwxnCMyM24OC4iGUi0=;
 b=aEZ2Xu6Y//GXfaVQzFATo8fTcVpGMKYttTKxjcmDVGPfQz7Rp3kTsCEzUZQpEkXskRfW
 vVRM2n5vu3rjSiSCbNuTeRblbDF5nBynLHyq1o/Wwbhbj5KQCmDky48977FMhcmKFSWU
 +FVeDKoHFN0wbeZoY7cDJZ3p6cvj3TbiXCs= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kawbq8ajc-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 19 Jul 2018 10:08:50 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.20) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 19 Jul 2018 10:08:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3y+iFNwz7PrpjkVQpJg70wnvpwxnCMyM24OC4iGUi0=;
 b=WlndKxlUBHuvFEEXj50UEZzcDV5t+k4cZiSLFLhLcN31u93cQmH5hOn/U1jTW1FljQ2sCC7fcDln2dBLx/m3zaTElMemJhiNof5cmvC3h8WKJnO/9waJpAazE5Yrz2WVM1ezvJrRLhodDnql3oRxgPRvmgjMl2Df8cEw5MBo/J8=
Received: from castle.DHCP.thefacebook.com (2620:10d:c090:200::4:b9b1) by
 BLUPR15MB0161.namprd15.prod.outlook.com (2a01:111:e400:5248::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.19; Thu, 19 Jul
 2018 17:08:42 +0000
Date:   Thu, 19 Jul 2018 10:08:30 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Claudio <claudiozumbo@gmail.com>
CC:     <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <cgroups@vger.kernel.org>, Claudio Zumbo <claudioz@fb.com>,
        Shuah Khan <shuah@kernel.org>, Tejun Heo <tj@kernel.org>,
        <kernel-team@fb.com>
Subject: Re: [PATCH kselftest-next] Add cgroup core selftests
Message-ID: <20180719170829.GB21770@castle.DHCP.thefacebook.com>
References: <20180718173358.14007-1-claudiozumbo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180718173358.14007-1-claudiozumbo@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c090:200::4:b9b1]
X-ClientProxiedBy: MWHPR20CA0048.namprd20.prod.outlook.com
 (2603:10b6:300:ed::34) To BLUPR15MB0161.namprd15.prod.outlook.com
 (2a01:111:e400:5248::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7db6c837-539f-4c57-f855-08d5ed9a48b0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BLUPR15MB0161;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0161;3:uLZAcr4xEz7ww2FDkRljf7Z5BgRwUqQjoIhvM4onqWjLBL0lXEEs5YaftjQ/TaiaCDstQbrDKC0i3vJr76brPXjJnyMfOdSOkXLxtWo91N3kfSvE1/eNgVNhEN4KG90Li8XY15AZcRwDMU1pUzN8pBJPmcpuCgk60YPSvZFetYzRCM4npqhf37UufuSRMwE8Ixul8jzjms0bdVTWVEEba87IdIeNVjxYRVTjuRT+ED8XB6E2Q8jdjQOsqmwaabJ5;25:rM21BN9sAhJR2GPXfxpgHXoYLrep9Qg145L5FCX2geys5Fz7do7Po9Y639gObajve154xdacGNwebFrNvX3e8J8uPd+SLry205oZ776vsO9gn1jZ/C/FWMdbdRzd2e5r49VyIT5a4CNmUpdBDLQQ1kHXfz040bwStk/Pp3rgUkkhCSa1atX86oNeAQOHgxBlZ3kb42/kc9M9sqlzuwNyen3XwexNlwOfKk4OfUTmyoC2DlUWtsWVJrHSew1cjvO9iCShxxBqs6mp9TgKsohy2P38QZki6mGrUBDPznj4JTbFqyI8sqvgfRckngmtfjONSnW5WB4DlUWBEsbehSjpvQ==;31:0Io+hd6L0ZkQ/TKH+E7ho6KYswqo89IjQpWTrvCfD3H75gg9QN4WtD5sZLqPIRQJBEfKosgELoc5e1EZzGlCE8EsNqHfYGVXYYYygq1Z95zGKmrQzWNaMl6uW5t5wk+lmoBBTSqFJdki6t0AxHLv+SckKN8jD6EBthhbfkT16qzQ8uW9DW90dAjlRxII5ST/KQoLbOdyxzASvDX5KbSJ+/rbOBD4YUw+I7kRA6FqD5Q=
X-MS-TrafficTypeDiagnostic: BLUPR15MB0161:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0161;20:2Zz+ZOAz9WhX99+SvJi7v5SphhULxwSC22zx7mRZAbrZm/AOyCWcR1SzMFk3g2PxudxGMRwoxbtxEzXrToZbe8Y0Yzs8fIDhsEfaPgIb/ndWT4819XSQ72AKdTIjGfQHdwygbPWRyoqrob8kKknRRxglOEUVXzXzB27xxhW8ielvEv5fVWhZBx2y4THwtOc4f0s3qRWBNjLOutwLq8OHZJkkve8+KjAOpSHTmxSP3BdvNRc9x46neSPJZzsAWMR46G5jh/6BMphmGFaZraNPhnOj2ftGdmI9hHtv+5HwJffV5BjcEE38SskzRIkV0LKaTMF3dUoOz1zsXhVRiFpLNX7WcW9SAGXcsjhfFh3N6j2ubOG9bYYvigtvcUgA9Mpc82qN/nkEKVOd8EadIMIPYubCHyvBF+SajJrLR6r76CvMmF/t+q7LBAxAu5SdpUS+KdezPzOiGjOZpChNUDmpi/h8DAPzquZ54x3cEDrLq5+alnukL8kQsZ9dhs1Uw2V5;4:m1l3jF2PojyjmpK2WtxXwqj+mkCir8c3M2a0yrAqFbTtpHmxAQTVefV1yNZURXUW0s/McYnzC1hTiIPTRWhtuvom81ofOCHDHahlWGl0hDmQuiDQkEjzCavUuAZnzRiq+++sLKqe27Wat1gOFbNgOz8zlyiIlAg0d/az++P6aI/HiWFusDMx74v/ikYF4CgeZQRMe0N1pP6OodJpmwXqimjxl8nMIdjiryT1jd664cS2T9BmGdde20kYKd9P7/+APoF3gMMZ+tIu+Rt9AV+5WulYGNB39ypYndUwD34mSxXZWbBfq1eOJPnbEz6zn6vQ
X-Microsoft-Antispam-PRVS: <BLUPR15MB01614B6EF92FA076F541BBC9BE520@BLUPR15MB0161.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(11241501184)(944501410)(52105095)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BLUPR15MB0161;BCL:0;PCL:0;RULEID:;SRVR:BLUPR15MB0161;
X-Forefront-PRVS: 0738AF4208
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(39860400002)(346002)(136003)(199004)(189003)(316002)(81156014)(81166006)(4326008)(1076002)(97736004)(58126008)(25786009)(46003)(23726003)(6116002)(8676002)(8936002)(106356001)(486006)(105586002)(54906003)(55016002)(7696005)(5660300001)(52396003)(52116002)(16586007)(2906002)(386003)(76176011)(186003)(11346002)(47776003)(476003)(16526019)(446003)(6666003)(6916009)(6506007)(68736007)(305945005)(6246003)(229853002)(478600001)(7736002)(39060400002)(50466002)(33656002)(9686003)(1411001)(53936002)(86362001)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BLUPR15MB0161;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR15MB0161;23:ujR2euTjEWTNdh4QR+oXb+1Xn1ujMnz1nO+M3Zm6N?=
 =?us-ascii?Q?mGSblZsFirrxOcelc67CKPfLmo6twqubkTV4sVUECS4D8jI0ZIP+ev0UDJpj?=
 =?us-ascii?Q?wGOhCd7rprH6zqVNPIEIfrxFr9dob8UsBhPt2DZpXeYz7tA/ntDgI0he1wKW?=
 =?us-ascii?Q?yOiXd30HBDq6NsES47L9j2It0+lFN0AEOlXporq2DUczzWOrPlve+sIpEiC6?=
 =?us-ascii?Q?SwDN1Xw4EGveBDmzbIXxo52jHAwSADicosT7Mov7xUOx/i2rrmKSDjMFuDKw?=
 =?us-ascii?Q?oB7ofqKOg9uzzX0ir4oQJXsf7Yuq08hNDoh37Gxic5aH2SnuK2As1HZMI8HK?=
 =?us-ascii?Q?JxeVRrGNwPku11SFD0TTvYzZGCBUi7aIp7KMge1STKtKeTZ+j9HjN6ejx9rD?=
 =?us-ascii?Q?L1wWYlVTmt9rwGGw6NwoebH51hPUiAA3gjGdgWGW3s4Zpgz8DLRlMDibYOkn?=
 =?us-ascii?Q?bskSDgXFwWDA19gd34X2vc6emCC2UG60VoxAjX/egIUftM6XhYVfwEG+qdJz?=
 =?us-ascii?Q?v0k+lUibh1DdM2Koon/4gpsFL2hYlg+DvJmncFoRckbqz/cz9xpysDxEfq3i?=
 =?us-ascii?Q?cLlNYwZAjHbfTk/QGpfIHZe2TQn3NphgOG8lv8IUTypo9PPhEp2QyIjo9uYD?=
 =?us-ascii?Q?3be9QwJrEFcytjX9LT3QTnQAuTmomzMMN7GTWTILseLVcZzrjEzfKvadTpxU?=
 =?us-ascii?Q?3i2UiIYtkATiuLNiXJTrcpw36Fzvoi0DWnIbXGZsu1chpJ3SGxQ0ikSRPFgc?=
 =?us-ascii?Q?MlXriFeYRJTjn7AQ0P+ux84qok5eHl1NVXeq3DT9w8sRD2HKlpziXcBXPcWS?=
 =?us-ascii?Q?CcUXJxBkhaHPNCOHALltHTsBPj7576WfYgT6R6bgzLLTKh+ss11jSoLrV0qg?=
 =?us-ascii?Q?+CY//WAQ71Z79ouRFWRsg4s9ectvLdrrAzHdJxuD4v5H5mv07hsR6PoA/F8C?=
 =?us-ascii?Q?HQqlEQMrsdsKPr4tr/SWjIpw+Rv6fMV+u66bRUK2D8UAV5DWtObRpO811y5R?=
 =?us-ascii?Q?L2aTrg2JzAGJl44AmuU90/OU0tOjvsld592JA/V2F2AsK8RAkI/STJdiWUx9?=
 =?us-ascii?Q?a3L8VfVNuYfwvX1xaGRpJiVa8Jz8txOmMepbLG9vbR8WBTSYsCOVdHwScSFe?=
 =?us-ascii?Q?ZE5/iF/QXwXTDMGAKNq3dcNQE8LmQzvn5IQUSN6rPnwsSoW4nBB+/ne6ypDe?=
 =?us-ascii?Q?gbxwUutTFSl8vCWWdvjkXoWPZY38w5SEpbIWG0fTPuUkz4CZF28Si0VICON+?=
 =?us-ascii?Q?lKMsxfRoS+JEaoDNexLZVRbs13xNwvDkgRr0jbj4GYFia7RkreWUikGJchEP?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: YSbmbyoPf+Vl2jSQI1J7zuRmAvmgFzbxA4AvxcOnQsDG3wS4kY9a4keHLVKUv5MCqyA3cZ5Ht8cxIgSlJ8ul5xee1dPqDe1+LoTitqpF/J6IvaTy8Dsd+YVQPF3gNNd7s6qAfEA+S+L9QhYVsR3gCWzrSyvR56mo1DTMIEXxz8RBob5kLRLQddJvMnx2iy05fVBeu+cfLFzN+fHcCaD+PFS5v+3VM+bdSC6eXANaX4gJGmAWbItfvUUPjLVMwa/E47ywiDvzzaXYtpoP6z97tATtb02xHHvWMMqwJ3+/5SbZC0nbK01YPWjW4+R4jzSsMln5Ps81bjwrRl4u8xsB2Rav0RGtAKFmtKPoSYDbtKU=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0161;6:iRpzLWccypG6bUvNZQvQB94yUeJTAgi98k8JdWfPXC4Bh7lOLPqMLi9jm2iXRSuoJlKYgJ923I6bd3ch4y/jpinHl6aNCITVcaANjgRjaYdhkwiNfbeZqDBbRhW5dtl3oq2JN2iWmoa4pssuX/pCjscmLvHBIxrn46OCPxpDK4pBCJK58TAdPQSVaCkPt237s/b/idUawtdYDgY4NerbJEejztgN27WwdCi2FKBsDjLwfUKeTxAhmrmspvYhH8lviIseZtXXL13dkH1xeADdNF0eP9U11ny3DnEBgApBCJreOXDb+wmqYaJomSJrBn6tfb9nRA+dbLus0zbT/1i7D3yC6WzV8Bn2j/MWeabg1K7yYat9m0+o046p14tMGXf15AfWDLJrQNtqPAc3LExJn7dxX2oEtgBBVVjE/ihkA40xSYD7RZ7H/ewvcmHJcgyManKZlfl8zzs6M0/mLjneRg==;5:jh7mlvOwshzAxmYGBsBABTGm7LD0CuAIh3gQxO3sbyALWyd4OuX6VLwt2gBwvGuOZRlrOqbCPW/gHH4B8sMwBwoBqWgpL08J5Z1abBJKUrf7iX56xswVpE+P+Yij9MW7iFW5KpKUYSuG4H/2b/J3sXek8ld1ws+cwa26u1Y43yU=;24:2+dRgm4hH0mg6y0aH6rQk1u/qDy3OK/yRxqgDY9q9Rnwa3TXng8wFvgH46vQrnBbnUWqZrSSaT1JR5PXayngctOxNFfqip2NaVe3NRT5wZk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0161;7:YNBo8jdzVBSCscHZsL60J4YpsA+wqBACMzd4Vpy3kSjJfKAMGM4QOTUDHbJy8VafEEWqSaxbrKCmDQqEAPBAeqJsIRpO4r3TcpD+i2tI4efE90EVL3TjyyJtbRwUR6NIXGpRblruznfbXdfXQPacKOCZMINXRoE6kiUdFLGElqhz6dIR50s/fNECEHTyK50fRRnq+XPdzy1a9wDLXrGFeHSON6AxCZj0X1h9xW4EXmfTQZ9fzn9WJtf2we7ptx/z;20:XjEFbtCt5b6fNGaZM0dqneYlGkLmUd228s6ec9txR+vatFrjI/G8oIZQLdr+X1T7PYfERd7lNamEXlybsN/Ln90sJT8m5AKez6a71SqfcZ7OzsybI3iK87xH0MS4rsw0S/aJM9dxNhCyFzr0ZN/SUUw9Njazgs6zAiaYL0AFsj4=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2018 17:08:42.9502 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7db6c837-539f-4c57-f855-08d5ed9a48b0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR15MB0161
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-19_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 07:33:58PM +0200, Claudio wrote:
> This commit adds tests for some of the core functionalities
> of cgroups v2.
> 
> The commit adds tests for some core principles of croup V2 API:
> 
> - test_cgcore_internal_process_constraint
> 
>   Tests internal process constraint.
>   You can't add a pid to a domain parent if a controller is enabled.
> 
> - test_cgcore_top_down_constraint_enable
> 
>    Tests that you can't enable a controller on a child if it's not enabled
>    on the parent.
> 
> - test_cgcore_top_down_constraint_disable
> 
>   Tests that you can't disable a controller on a parent if it's
>   enabled in a child.
> 
> - test_cgcore_no_internal_process_constraint_on_threads
> 
>   Tests that there's no internal process constrain on threaded cgroups.
>   You can add threads/processes on a parent with a controller enabled.
> 
> - test_cgcore_parent_becomes_threaded
> 
>   Tests that when a child becomes threaded the parent type becomes
>   domain threaded.
> 
> - test_cgcore_invalid_domain
> 
>   In a situation like:
> 
>   A (domain threaded) - B (threaded) - C (domain)
> 
>   it tests that C can't be used until it is turned into a threaded cgroup.
>   The "cgroup.type" file will report "domain (invalid)" in these cases.
>   Operations which fail due to invalid topology use EOPNOTSUPP as the errno.
> 
> - test_cgcore_populated
> 
>   In a situation like:
> 
>   A(0) - B(0) - C(1)
>          \ D(0)
> 
>   It tests that A, B and C's "populated" fields would be 1 while D's 0.
>   It tests that after the one process in C is moved to root, A,B and C's
>   "populated" fields would flip to "0" and file modified events will
>   be generated on the "cgroup.events" files of both cgroups.
> 
> Signed-off-by: Claudio Zumbo <claudioz@fb.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: kernel-team@fb.com

Looks good to me!

Reviewed-by: Roman Gushchin <guro@fb.com>

Thank you!
