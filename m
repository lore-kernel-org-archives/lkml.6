Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10147C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CB85219E8
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="H8s+wr2/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CB85219E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ni.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbeHFL0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 07:26:14 -0400
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:47200 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727556AbeHFL0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 07:26:13 -0400
Received: from pps.filterd (m0098780.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w769BDSt013912;
        Mon, 6 Aug 2018 04:17:28 -0500
Authentication-Results: ppops.net;
        dkim=pass header.d=nio365.onmicrosoft.com header.s=selector1-ni-com
Received: from nam05-dm3-obe.outbound.protection.outlook.com (mail-dm3nam05lp0117.outbound.protection.outlook.com [216.32.181.117])
        by mx0a-00010702.pphosted.com with ESMTP id 2kn9nruytc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 06 Aug 2018 04:17:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector1-ni-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PMvwg1VhDKp6prH4eUHAnvwP1cDeFUzmQeZdUeAghpc=;
 b=H8s+wr2/WHvgGMQXnYciiC9DRDIr8Q+0yWYykGCLprARHON/EUENUzPT/347Jf6obmeEWFIWZz+W4mu5F9uGaYALrZm8yrExDXtjWsW+6Mx3eGA/53sl/a0lO9khkYz46CwMSrtJtbL/L4BYn3BrkEX1qm38wYQsrNF5LRNPS8M=
Received: from jcartwri.amer.corp.natinst.com (130.164.62.116) by
 CY4PR04MB0968.namprd04.prod.outlook.com (2603:10b6:910:55::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Mon, 6 Aug 2018 09:17:24 +0000
Received: by jcartwri.amer.corp.natinst.com (Postfix, from userid 1000)
        id AD0CD302144; Mon,  6 Aug 2018 04:17:21 -0500 (CDT)
Date:   Mon, 6 Aug 2018 04:17:21 -0500
From:   Julia Cartwright <julia@ni.com>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Alex Shi <alex.shi@linaro.org>
Subject: [ANNOUNCE] 4.9.115-rt93
Message-ID: <20180806091721.GD1123@jcartwri.amer.corp.natinst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [130.164.62.116]
X-ClientProxiedBy: BN6PR04CA0058.namprd04.prod.outlook.com
 (2603:10b6:405:3b::47) To CY4PR04MB0968.namprd04.prod.outlook.com
 (2603:10b6:910:55::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c33b3e3c-b4b0-40bd-024a-08d5fb7d6c63
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY4PR04MB0968;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR04MB0968;3:BBu9ULV7iN7BvzyEVYV5Oht+LBKvvr9544h9j0Eg4l5I5c5QBYQxyr4h5Dp03pumDzouwLBlMwzQMwnx8W0nglBzr7bRI8xQfCKTCiCRmpAEUedb5CIN+NiRyL/aitBeGBMb5hVjtIiFleGYkCE2GY0fuAD7QRDBS/kvV2Dj2AnO5kT9U+R27nMMFGlSbHDCKnv6m/64hCp6ifHC+PAixEEL9d/2715h284z3WEf5uRlj2Ag/BF+/HpC6wGkkX4U;25:zv1bihtz6BWgZkesOd+KbkWsjIvOkDslMLJ835/zcewxYgysSAyZMb9Hz264O5YVui9td+8c2lJnxuADyjfLPY3eAsllc7LDyKVW4qEn3vwecThT2V9Sd9DU6lWdG7GsjcBq2DgoMNB/ftCOhNSVG7tPeB/vTMCKLX3qrJodzIUTt5vYA//PkWD6b0Mz6xL7MBfhxBVqcZvUxLgv4SGL7Wq0Md434iFN/MduDoiXcKtY1v1+y/8ZW/Sw0LWf5ZDq7UGf6eil4H0+8rjtCBDVg4jRx7resLnRweymIdQS3s30YP+qa1kR8c9h21D0lmj8+TlWhstAKvAyP/kZ3bV+2Q==;31:PEUi+dhxv7xkGDNRyxDU/TcQmwmeNDkPHrhFo1MoPT47i7Wr4iZWvCWts6b5yZOv9NAhSEpH9MMF9f/K09SykPhLrSpJGoxGKF7G+rRro1V5Z7xgajb/XxXcgHvVuJlv/jcUokCp7GeeB+sxDTBIPm/ytR2g0Hzbp6vJvqI1xMix+Y3DFe0EsArRrXKDvne4s0CCjXJVPttwucCQdJjO1nrkDu4Q9+sUj31yITR+tso=
X-MS-TrafficTypeDiagnostic: CY4PR04MB0968:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR04MB0968;20:GJpx6Vc027FN5aIxAwW6vpwWVFSAOUCqnLXc76ap02gVNmW89GCDwazUj6Hy2ki3IsXJcQNWWoNjayhWtHeii76xZ7pv6xHPRnOAodG/WON+lIqJzDOPm/pjEXjaI3YD8mGqDIXchM5F9Hvl3O4b7YCEigYwy/rV1sfqbkUlP+5iq2dgx/WhXj55swciPoUN8JvfwCSBvaAOZT8yKstGpeivtELsTxBk1iPTDqpjHdJ45GSuBaYkxT7t8diiPb5uKrM7vC4AegJSALR5Zoq7MHgILW5l+J3hiiWhaemp69RP93KwJzit6UjYxVuV9qewwswOs8Z0mwAe+teExfZ67HU1w0rACBBX7SEs9fpPw52td6HoK4ekBH5MPkm+qeoaQBMZdZ/t+sTyr3CuwKAOMciz17mvY/PlD6gfkijhPXFfGw4NwjcEReMHHsqfFYh+j838IS2PFKjCbw2b+GGF5TOTmECbIEkPoTudxSTzPQSDxLcUIgZDFBN8B8yIx+JaFMPXPJ5MdAe5JqGBKlvEEbMdKE5Na+3unUp3cDWXeF1dcvEPlZW+lqcDGNJbk9iixjkKfsmc8avor7bRkzXwPMgpkMgFwqVKBV/BYZo5oVQ=
X-Microsoft-Antispam-PRVS: <CY4PR04MB09688476B7FB550F24E4EA86F4200@CY4PR04MB0968.namprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(84791874153150)(5213294742642);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:CY4PR04MB0968;BCL:0;PCL:0;RULEID:;SRVR:CY4PR04MB0968;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR04MB0968;4:TQlfZ/m5Ej2j210Mo0X56eualMoeOc4nqHbNCZwO+BAzSr+Hi69I9wAuJMPwhuwtrpxo/slUAu7sjXJiC2lXjnvs12myctbHcX7dTPiC8AZxVOBGpTgtO8/xTuhOv8U8TeGbpsjXo0pAJUEvY9lauSemM82LjHXtpSF5j1qML9WHdHK5QJo5fHqIklxtV/FxRqvjxWg9g6TRhgwwWmBrUtK8VePH4IZGEtS3bYejs8ZudEgWx4piUZC0AxdxUfuuS6IrkKco5/LGkJwiOza2Ske45eaUuCH9es5z1CJ+Z30nAq08jjv+zjdD2QbnUkCnjyCEcmCJXasX8RCRseceVQe+UH27UnMdHzrTOOhmYrI=
X-Forefront-PRVS: 07562C22DA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39850400004)(136003)(346002)(376002)(199004)(189003)(1076002)(6266002)(47776003)(14444005)(66066001)(966005)(478600001)(1857600001)(476003)(386003)(33656002)(97736004)(26005)(23726003)(16586007)(3846002)(42186006)(6116002)(58126008)(122856001)(9686003)(110136005)(6306002)(316002)(186003)(106356001)(52116002)(5660300001)(68736007)(105586002)(305945005)(50466002)(8936002)(7736002)(81166006)(486006)(81156014)(52956003)(33896004)(8676002)(2906002)(7416002)(90966002)(53936002)(18370500001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR04MB0968;H:jcartwri.amer.corp.natinst.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR04MB0968;23:x/X+FGCW0IsQpNsR8dFs+r88jEJjM6H02bDtiTPn/?=
 =?us-ascii?Q?KvnVvquq70Y7qdi5xREM2E1ExGyhKvB7e8J8NHtXLRXJiGEvqq1XOh2gliF2?=
 =?us-ascii?Q?XYM3nNfN2uMNdSyPIfqzXp4zLTtbnOqgIgU3ikWqeVTJE+dpHtiYwHL3tUaw?=
 =?us-ascii?Q?TfNm/w9DDQ5DDwilp6sj6ftyep8VXYuqfxGRPlNoN1sUByRv2kBIW8xxGOoa?=
 =?us-ascii?Q?oYKcbJf7Uo1ZLyLfAMSgUy8CsBJoWRRhK2Xxs8y7f7Ko0zBSOpYwIesJMTmJ?=
 =?us-ascii?Q?M+QnZMf1yVRyGREbduUH732gD0bEt09dJrQT5VhSVQll8Ws1uChmo3Dx2aI0?=
 =?us-ascii?Q?PyuJnzaZLAmwJph50xAbLwm10W0ZY6DSdTibXq1SuLcA9BxELr59jrg1lzGL?=
 =?us-ascii?Q?VKLTFhDJ65javhrITfI39C/LBWNRl9grrLwQ1E5Y4A0qi0Jr0EiNkfQpzhT6?=
 =?us-ascii?Q?BS5PbReeiC3I7bxXozsg8DdVepzUEzdGgLg2BZThvrGgGLJSBj3g1y5RL4Tt?=
 =?us-ascii?Q?sTDfYSq6cIrT6NIZmaB0rSOpzK2zjnIUjEiwfDZBHMgUNgJB5fIeyLVhD1BW?=
 =?us-ascii?Q?ou6N97aUcntfVlS0SCfI+hCbMldMreej9Hcx8nr5DUDN3bl9KbQ3OXikexht?=
 =?us-ascii?Q?vp1WdR1l1/SMU4r5s3jXMb6pRm3oPKePKob+Os1BML7s1TCCb1E0HpOp5LPq?=
 =?us-ascii?Q?5tdMCHOB1WinCIJ2KnfUAEpJzAbeNqdr1v21s+SWpyUUTqrW0gDuC2PZLPsE?=
 =?us-ascii?Q?l+uqjpFRCWAcZ9dPewiUUueb8Qe+7eNotWcXs4ymE8kyl9BaM1pZQwi2Rluf?=
 =?us-ascii?Q?tf+Nn4I3ZyTMKvnHg4g4XRKo6JG4zzZx2V362Cw3x8lS9pNevJ300ElMFeNx?=
 =?us-ascii?Q?5lL+5mTApAKStlPUU3nWE1Wx7aEuPhignZMJi3qC54yjgUcO2GiFwh5pneYH?=
 =?us-ascii?Q?8MmL9E9QkYbTiOSahBWoEB4yTiv6kuG8A6Rfga4VG2Y7KWyDVVjRmPi4LWI8?=
 =?us-ascii?Q?y9BedMy5fICQNAHdPsfswDcYchyWDwQfy75In6iAww1r9M7ya9/L9Q0UCh3L?=
 =?us-ascii?Q?DRa6JlRHLbFPyzUKpcxL3+QTWQxQihL4K0+yJiTQC+f+oBrXc7pu7B9RUUVO?=
 =?us-ascii?Q?8wpEH/9AAhvcld+CWTpVCFGyax9kh6n0vVRdjQrSrkCr3+HG5OGKOMfG1eLs?=
 =?us-ascii?Q?wD6Zde9xMDFHsZQwXf/HV9G7Vfhl5jn9sx7B77bWHiVuJazqXzo+yATTQ=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: QhEdgjuumrumKqPGWcuSz5mmAAHlJ0QBFn/JP9JtUexApc3xAP2NiujFe3xkIZ+QZ8VWrGnbjLp9t/61t5hJMf0xDxXbuH+4WbgGq3w5ynbcc35RrzxDRRGptGWJpTwz/H7TCGp2TCkvPHBNelBzDLeN+iX4HDS+19NWI8uMZ8NM2kFLGzCREtqaz78qVlSRqnvqv8KkubxpuLJeECW5uHbcO8OjFRYHlIZkSjacx0bBm079KglQ0Hcpl+F6u592Tnq/H+rc3vAGMbSvr4c0m87j72XGtBnfG6d4CukFVtG7UWV4sVp9jcVDh2zmUqKD/FZQHGj63m0iKyBGfwod9k+2Q30XP2idCu3o/wOHUQA=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR04MB0968;6:Ugf2hCQotOrziz09zG/bn3/Z49JvnbHF5N9aYyFf6s/Kp/eiJ7/H6MZ1zEx1fEDF/hW4GvEk98MxHFXReCEAj3et+nyIQbmIOXXvN5ylhwx2A87ULKgZwyH5/wHzPLBuGu7K+Un4eU+jf3nTFcL1G9Gsx6JtcLLgXsfp9tnRCCmN0JHg3qaeKLPsVcQ1t+DrrtilGROrktJUylqRobKwVc5+IHrui8XlwIfML1Jcuz7eJkYtOrwvewKGq9wEGEj2cwWnBWG96+eJM823vi71CC1N1cBM7Q6/kDtTMIyC1ZOUT5nFtdpAAStE6a4TPkfjtO88YxxwjXDNgyyxDkGX/kEDOBdVuLI8CXaROQKLC2tgnpANCOS/Nq3EcUrI1D+psqMQWa+DjrDhUPp6ClMdLolrx2mE1tyg6H1EQ21GrPiJIih7Ra51wmIXlhRxrLpoZ3fuCyzGIH1zczP1NAGrfg==;5:/wQ3Cob99Sh9dE02Fh58bWdRxM205ghvOHWXD5HyWIfY8Y5lqdj5AY52rf3iyJcssR7z/oGCNWvR45oX76j6XWb5IDkm8Q2NN3PfqMgZkCiiXp4RB8/NfCwd0h3QTvC8yyTX8UbqUTG3ZVtZDg660mv3UXmI9XR0oDNgwak/MiQ=;7:2slmf7hCA9Fw/RyeStvmwWsm4aLW+FqTuYfYc/taN5kx/8w0fv9qoZohzQiUGHN1h2w0dTj1aZaCZpKQ8Iy3/2e6KjVomWABD1PABt5cjkSDYCX5gH3ohz/EiuZb9VxtOQ3TfrMDTFkKWmFPTIcwOD1nlOFAxabFp9Y7yBmUlwJps21qXq+lxaUwV64KEGdPNqjO4ZjeTIh+SfBbXViYxKS/vb8S+e05GwvgW8XAb4JAcOGz6JEEXBu6OO6L5Qk1
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2018 09:17:24.9784 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c33b3e3c-b4b0-40bd-024a-08d5fb7d6c63
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0968
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-06_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=611 adultscore=24 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808060100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.9.115-rt93 stable release.

This release is just an update to the new stable 4.9.115 version
and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.9-rt
  Head SHA1: 236d20fd941a444577579ba398ba9907f3b33277

Or to build 4.9.115-rt93 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.9.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.9.115.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.9/patch-4.9.115-rt93.patch.xz

Enjoy!
    Julia

