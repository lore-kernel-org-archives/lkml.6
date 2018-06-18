Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC99EC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 18:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AF5C2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 18:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="KQoxJ07q";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="NVMchMZ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AF5C2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935762AbeFRSIt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 14:08:49 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:45026 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S935546AbeFRSIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 14:08:45 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.22/8.16.0.22) with SMTP id w5IHuFRZ029321;
        Mon, 18 Jun 2018 11:08:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=lKTES4hRF6TPfzKpByYHoYC9YsxfhwJf147wKbxe4sk=;
 b=KQoxJ07qtTU2p0y9dRlZbtbcgWs+zbmfHhZgMF3dc01N2391Fpc9B17yU7Jn/1GClHlU
 QY0TvYXISaP34qkNCpgSXebHhllQlTapfC96jKXKDOmHua+WaKuuDt82CAId5a17VnMT
 a0Bi+zWN0qsAUiZ7wDXygadwVv+3dR1lPc0= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0001303.ppops.net with ESMTP id 2jpdt1gqdc-7
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 18 Jun 2018 11:08:08 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.26) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Mon, 18 Jun 2018 14:05:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lKTES4hRF6TPfzKpByYHoYC9YsxfhwJf147wKbxe4sk=;
 b=NVMchMZ5kaV53cnM/uZSLkx/uhbTNnzzlaoiQXVuqBOVLcEKd/27/6DQFKoSvzOuXVkrMEAeiZCQj5o6YX+8n+QvlpyBSQb3CsAqKqhrqNxwUHDo1C+QhpzdnF5qSzCrDwfWmrhdenC4GVjXc//HmekJH4CJJy4ebgcz34W1J1U=
Received: from [172.30.116.44] (2620:10d:c091:180::1:9551) by
 BN6PR15MB1876.namprd15.prod.outlook.com (2603:10b6:405:4f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.17; Mon, 18 Jun 2018 18:05:36 +0000
From:   Chris Mason <clm@fb.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Josef Bacik <jbacik@fb.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yufen Yu <yuyufen@huawei.com>, Tejun Heo <tj@kernel.org>,
        David Sterba <dsterba@suse.cz>
Subject: Re: [GIT PULL] f2fs update for 4.16-rc1
Date:   Mon, 18 Jun 2018 14:05:32 -0400
X-Mailer: MailMate (1.10r5443)
Message-ID: <0CA8215A-6529-40B1-90FB-A5902EA47549@fb.com>
In-Reply-To: <20180618133817.6faba27e@canb.auug.org.au>
References: <20180130223220.GB65489@jaegeuk-macbookpro.roam.corp.google.com>
 <20180131095446.443670dc@canb.auug.org.au>
 <20180131002535.GD65489@jaegeuk-macbookpro.roam.corp.google.com>
 <20180201092551.759f32be@canb.auug.org.au>
 <20180314101704.51aaae7f@canb.auug.org.au>
 <20180403122919.3c503f74@canb.auug.org.au>
 <20180618133817.6faba27e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Originating-IP: [2620:10d:c091:180::1:9551]
X-ClientProxiedBy: BN6PR06CA0009.namprd06.prod.outlook.com
 (2603:10b6:404:10b::19) To BN6PR15MB1876.namprd15.prod.outlook.com
 (2603:10b6:405:4f::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f78e7800-6fde-4d10-8e8b-08d5d54617da
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR15MB1876;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR15MB1876;3:BHU1dY7aR7XJquyzAqrR8oqpMppg1VWXHTsmDIiPyHd8w+ax/iaiGlNJ6bEawWBBsVQNToNIZDAx0Knn2pQ6u5zMPZQvgFkc6WawFjGZVDfF7VvH18JVnhQs7h6DCjl8Opy6LRXUyM+tnCIBiPoXlbI2uggnJ/6zDI0YeljbWPDzNz+goHygxg1t7vl/hpauoXG1wDXJLGyEbn6CrIduIvguovQr9b3wLyrBHqX77vDoN3F4bOTa90jcoJuvZpiZ;25:fD1u7/oDVY8MhZers7c04oz3//nMjaH208Zuk3P6C5zwYkq5sy6AMjFLluD05EiB20LnLGQa+YNeo/g0yV69jsw6dQs4JLPjLrAUyEtU7+E/QPs3VfHJWb2k/vaZn8H7scqKl7yGCoWvxxYGI9t321pPFH6vEozKJuc/LF5nMA4DvGPIBbY5JyuAmJOG3cflp2za2xUZ+qc8nfWgpuDM0O7F/bkbbIz8YXdjp6Wrh6+adezLrGKw2FQjoJeHn4CdL3SXvWkuhP3d2vjAOZ/e23Vw1SDs/FTEh4OOe6GyTJI7r5+4ouz91Sjn520x+vgamm0hPns62+PNnP5eIIJKEA==;31:TmVP005Bn+CQtd5sDWe1p9tPGFD0Ub3uQmp+bfwbo/xe2k3pHnsPj09cj52niMKxddArGGdaB/jkLscIb9FIiPL+nVQ16LVnb2R0PhVZ7hGw5VpVEWisZunvP5rQs/v1gb8jearoxWAhPHmHjfW1TBQXcLVOvivbSbG8uHBx7yxx3rZFsZXbDQnAaNnaOQziTG5AURo3CahT3z4EBsk3RmfTr2ECiUZlm51ybPtN8e4=
X-MS-TrafficTypeDiagnostic: BN6PR15MB1876:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR15MB1876;20:GGf6fsP31Yk3FYYnuGQ7lDm2qxcsCdJIFWreB9f582kyhUMkjZosIcEY6loTLbMpE5ZPMpo752EgssZQrj200f7YrvE4S7N0f01o1OTORZHFcUJ+LmzYWI+p0YU3j6tISHCwqAOPNVphGsirbVl/GsAKL6F1sFIEeOhbKBOfpfwGF2JpeXhkLpSFS3Uf35CXv7587EO5Eg4PW8NjjDAczOjhVN0pi5YgRl2CMlpGqlsflTbyMS0MR77u6XmuniOSG3FxHbGUwQzi5/DreKeu7niOUvTI5VUm5MvM5YRfI2JtTYinv82PmGBS8gJnhXOomsSdzrHwLGqVChKhyxI0MNhU2REB8DhZRpnPOjmHELOFOTpUugiG+vQJ5L7wttFVofOKDPkzPpVQlvTrivO/HftSb1VrC3CMYlbt8COdXSpbRK+O5rHHCPO5kuf/7PUzcfyDySPwLKoqvmSvZh3aqzsNCl0bXeqxl8ECr/m6VsZX7kO04PSSHYonyA9IM9xf;4:uqDmC+Xc0ModnrqAS9D3wb9krQkjvoevD3ekCx1KebpgafcMvjA2EB0nurBAqfGiGkQ10VobPKL4ddMS+h2q+d92k+YqC0TxzWdHdc+nKzdnhsTy5ZO1Uii+0Cm3SbYcIGBR1H5jUhhfmgpOGV20gD1CBdnhlAwp5IUXPte8afUdjAh2n2+0e33dfZfxoEaFhFa/gd8b9WtdlJ1UI/d19G2hoRZsqr2FtG3hagf2oEpoYceYzVmAjDGMYfXu9v9gEt0eeb2bOy1Mg1jnta8CQQ==
X-Microsoft-Antispam-PRVS: <BN6PR15MB18761C5AEC96E4E72865827BD3710@BN6PR15MB1876.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BN6PR15MB1876;BCL:0;PCL:0;RULEID:;SRVR:BN6PR15MB1876;
X-Forefront-PRVS: 0707248B64
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39860400002)(396003)(376002)(39380400002)(346002)(366004)(199004)(189003)(6666003)(229853002)(478600001)(5660300001)(2906002)(97736004)(8936002)(81166006)(81156014)(50226002)(36756003)(93886005)(316002)(6116002)(86362001)(54906003)(16586007)(83716003)(67846002)(106356001)(11346002)(446003)(386003)(105586002)(77096007)(53546011)(68736007)(52396003)(16526019)(46003)(52116002)(51416003)(2616005)(476003)(47776003)(186003)(82746002)(486006)(6916009)(305945005)(33656002)(7736002)(6246003)(53936002)(25786009)(6486002)(50466002)(4326008)(8676002)(76176011)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR15MB1876;H:[172.30.116.44];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR15MB1876;23:Ic/RJrv0ElSfG20h+BWoiyihPi+ocvjLCijhNFQge?=
 =?us-ascii?Q?+KIA4h0c+yQO2z8RgjgOcaq7dk9OzSFzhYESyT3QF+EzkyEnsoOSbHeGb9uT?=
 =?us-ascii?Q?Y166rvXFdWQLv2rYSQVZvWYoJGVvCglApORqQWWOjCDtXUldwZGqU3YXEjwP?=
 =?us-ascii?Q?e4/mop72hd3hPEQxTKggg0Od6OWpV7/fcknTn7lOMUmoRhELneyQOaoIVTQB?=
 =?us-ascii?Q?ooWGps8qFTRZiH8q4y9PiUZtRRwYx2AofobY/qemGLFo95NFr3rdS2NMcKsm?=
 =?us-ascii?Q?T7uxM6fceI3UaXNfmiRY1pCSc1P3dpe/oPtp43qZX0D6XNwXkWzTfnx/g5Ea?=
 =?us-ascii?Q?wLrgxbSHWnqtoeE1C7UJt23iElUnF+cq7+WD2v0WWExnpzH55CawfEy84hMb?=
 =?us-ascii?Q?O1wEVsEzBwquToLyyaUlidxlbe3veBqMuFe/tnnDrAmXJ99E9ch32DO1kSg1?=
 =?us-ascii?Q?SPLaPGBRVO6KXmvow0E3wdot5L6k+Pd+uabUDixq/O/vtk2nzPbAirqJYD+d?=
 =?us-ascii?Q?NiI5gw01Crlv46C2GDq29x2vBQCRfWM2YlcmCWutNhM+NqRD5q/98Uwk1nwy?=
 =?us-ascii?Q?Y29U0ntvvTln71Oi8ZCCX/Ta1zqAfbCbeZ71tsIp4vsDVcFq4Uo95VuukQ9P?=
 =?us-ascii?Q?NQANownvr6Wrdb7zKiHQX1y2KK5XpTqU0vE+XAA//ugf7CoZGZF3F59hi1yy?=
 =?us-ascii?Q?MHvRhVs9KMu8mNgqVLFYeuhSqt9LS68Ro4qZTZk0v+Pqpppl4UW7oq3RmaPQ?=
 =?us-ascii?Q?QOB7rrvuk+Uqe9i5ZDYxqfDj/dfEZU8lteWqon5rprkMBrhkqEnDhO/WU60i?=
 =?us-ascii?Q?Y19/Wuehhd7+caUCyhG63YHunaXX3u9VwHoxNwOY8a1+l8ywpxNgNBp35LfL?=
 =?us-ascii?Q?kjLenLyO7xClHQ2dF1v40hfPLK7eWcHPku+9nM7z21ObS8XT/k+gexMisrBG?=
 =?us-ascii?Q?VzmtyTz0TQuwKhVuUQBoeA821AXZ8jo5ih1EFv+AKnrlUOf64z4qluuAF+PE?=
 =?us-ascii?Q?z2zoctJALQ6u4v+wCoeczErqNivfj56knhMo+JqXACVOQHxf/EgwfgUAvuGE?=
 =?us-ascii?Q?Y7+k5dLj4ITe7AZ/ok/p2ROTY8R0ccBnWEQDWxgGN46t6q6ntyinQtvI2ADr?=
 =?us-ascii?Q?0kXESMamIfiUpR/7N/+H888Kl6YuZtjY4mg3JnsduZmTDp5skSxAPBYUxlIV?=
 =?us-ascii?Q?jRXgCpuUk8unLV+IWtSgcACFY3lfcUCocQWFCoYSqSpDI3Cix1SZOvshQ+YJ?=
 =?us-ascii?Q?f/6FYb0F9ylHwOw+smcAhpa+6/9fC2h+Tq/CyfpGi53saB8On2H/6pxgoTBR?=
 =?us-ascii?Q?f8U/mN5Oqa2d/pReBTfcr9aAT2FBRVXIwrOFmz5rhvE?=
X-Microsoft-Antispam-Message-Info: LcZtDk3a580OLFRicZRlaykoyubOioGt9m3fNuj+hzAAsxKvjCr6Tc3k+NAXarnpHn8BC6PZNkStCy7opi3exEjoBHplHPzatcyPCdHMgkkuDtBgGK35UlqYY0WHvlthx8diIgLaqL7vdrtncRQd3alOgV2BnqytpVnv1NeUcw3NByk+mVYocIHfgc91HVyAxcb3SRqtAb415hgiEWpcZu/jnT8xG/imMJoLU9yrMT8ap7WRN3IyCYAGFb6fM5qrZxJq/qXSClRJBVo82zipZMWoDyav3tyWJZH4yB/7qY7Ij4G7NHVyWHc6Q6Wt+Ai8tvfsHvStZJujFN0ystj1Bw==
X-Microsoft-Exchange-Diagnostics: 1;BN6PR15MB1876;6:1Tt5R6ugRnCXfAk3pEk6D4tHAO1L8P58tL9zQILbmvZAs62SuMhoCDK2COEqKt88/MrRd9LzwboqjmquWGL4jK/caprdXc0669xRjIugRKZCanSgoz52jcfNx3EdAjHIFJ07MPmatkDR/ZjU6bn1Aytn2oXfffvhfe05Xk1RbGy6PRfJQwQ+ZhsgZ0Vg16dJAztn1abVRSgVIfCvZk2KrYdW92yKpz2IjaMGn0rf9FE5XHNNlVy/i8ktSwVfAVoKz2ERT39p3TDs0yslaMakovAdw1ik3HbC1/5lWwXsrPm23WZabqXjeJxpiqh+ccECasP6S4m49zYjDGAEh8TvmtcfU62dXzhAwmdztgId8UQMkjibR8xx+8tgodD17lttbFhHDfwPJET2nv7VUIcm/x48xYZCGMk1OhcwdDzeHpgzCBdCADh1PQS0nGRtHpCIN5R1ALMvwWQnVdHpRfQrEQ==;5:LhnwYW9uF6hxpd5qCjnBV54RRjOvFJxPCzKRRk4R96aNOV0xXUDFepZ4PTOiE3jL08eRsZg0CoGNnKshPXR+p8ZOST5ce8d5eSYCX4iCbj1xqeOhtm40QqnZ7DA/ReFoYXTs7Dmt3KGGjVICyc9AOQivZzxdnfOuPrDVDIuNY9s=;24:IeJxwvJs2i/Q6iPj+c2z8PSqZiTq3u3w7d+oqboq8GkSmOrcLIXgsiYh4VTTrXOimAlZtY+5eKHUfhuF4AeAHKEvM7P4DNaktBaauSocD58=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR15MB1876;7:Gvhwuq7hpO+y+9ogyntCjZ/A12l0j4z5nZYBTUcXilBkiE7bhy+AQOltc0SeopcoCnrT4zuiLAmM+qDqrjZjB2yHOnbECbR9LO02PZ1ZMzDOiQY97a0Y/mR8gS24+qMs3xbUF3HIghBP2QupWCI/AEBpu3hdlTfMGGlig7Be2bV6NTJSp+Knhos/FBhQYohrgo445IIVBKaa+D6DGowsIuHsoYsccyJLtjdLC931IJC4KClFew5QsD/KOm09sTvL;20:CVFQm7O/GMUkx8qN2Kkf5cmQjXiERs82dYzqWjt97eqdNVA4y2XPTaEdpc+pchA1EPPpcHQWnPpw/qSVy4H3TsnRVJloB5KyAwyobAeHYVlMsNU7byhrQQVnwgPCeTSHUoxJg8H2l9LvNj3kqB41wlVzRMRVM335bZNrNMmc9uo=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2018 18:05:36.0303 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f78e7800-6fde-4d10-8e8b-08d5d54617da
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1876
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-18_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Jun 2018, at 23:38, Stephen Rothwell wrote:

> Hi Chris,
>
>
> Another merge window has passed and I am still holding this tree and 
> its
> merge fixes ...  Tomorrow I will drop the btrfs tree and rename the
> btrfs-kdave tree to btrfs.  OK?


Really sorry for the hassle, the f2fs subject line got this filtered 
into a different inbox. Tejun and Josef are working out these btrfs 
cgroup fixes, so I've pushed v4.17 to my -next tree for now.

Dave has been doing the Btrfs merge window for some time, so focusing 
linux-next on his tree is a better fit.  But either way, I've fixed my 
my email filters so you're back at the top where you belong.

-chris
