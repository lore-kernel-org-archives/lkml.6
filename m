Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 658A1C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 20:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF4F320652
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 20:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="JFTu3n7u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF4F320652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ni.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbeIHB1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 21:27:23 -0400
Received: from mx0b-00010702.pphosted.com ([148.163.158.57]:47398 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725986AbeIHB1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 21:27:23 -0400
Received: from pps.filterd (m0098778.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w87Kf3aR016201;
        Fri, 7 Sep 2018 15:44:08 -0500
Authentication-Results: ppops.net;
        dkim=pass header.d=nio365.onmicrosoft.com header.s=selector1-ni-com
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp0054.outbound.protection.outlook.com [207.46.163.54])
        by mx0b-00010702.pphosted.com with ESMTP id 2mb9wck9de-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 07 Sep 2018 15:44:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector1-ni-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=deLlnkUEKCMBdJyEhPW0oZluIuqBIjaKBywkG7VwjPk=;
 b=JFTu3n7u9pp0HWUYAYJqwyTr9vCj6rRC5dQC9dzEcrUvAA8bvUPcYAynUV5+DJ8UJExv5h9XhhGdLc/UYzvC+rtApmhlkzAtI/UbnmAGN6dFF7x6Wgfum+yYSULtuG/NgHcBzhkLGp/VEPsIOm+CKph8fFomYtF4Yhs/0jzcNeU=
Received: from jcartwri.amer.corp.natinst.com (130.164.62.116) by
 CY4PR04MB0967.namprd04.prod.outlook.com (2603:10b6:910:54::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.16; Fri, 7 Sep 2018 20:44:04 +0000
Received: by jcartwri.amer.corp.natinst.com (Postfix, from userid 1000)
        id 0B45C301F72; Fri,  7 Sep 2018 15:44:01 -0500 (CDT)
Date:   Fri, 7 Sep 2018 15:44:00 -0500
From:   Julia Cartwright <julia@ni.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        contact@linuxplumbersconf.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        Daniel Wagner <wagi@monom.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Mark Brown <mark.brown@linaro.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Juri Lelli <juri.lelli@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Darren Hart <darren@dvhart.com>
Subject: Re: [ANNOUNCE] Submit a topic for the RT Microconference at Linux
 Plumbers
Message-ID: <20180907204400.GN8562@jcartwri.amer.corp.natinst.com>
References: <20180904132529.6ae7166e@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180904132529.6ae7166e@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [130.164.62.116]
X-ClientProxiedBy: BN6PR17CA0024.namprd17.prod.outlook.com
 (2603:10b6:404:65::34) To CY4PR04MB0967.namprd04.prod.outlook.com
 (2603:10b6:910:54::25)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 093787aa-acce-4f5d-e94c-08d61502a65d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY4PR04MB0967;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR04MB0967;3:dBVYhWwj3k3KrR7whU23Ox4cLKomrt5KrQq3xiSia0kFy/+hSGvTxoNnnUKTRYuVVWTxxQys/fRNn7IbtjipJylYjXRMtNzEaC2u0LLE8qF6BJdif2doxLQYWJjfRHzO+/wqk+uKI6/Z2ywMIKhIHMtQ1DFRPIts2elrBW2n+ktzPpkcHC9YZ/8Nuw2RiEN4htRxXgQ9dImmUlW31Ftjet6EIF2eTl2YoC/knem1CAjNtqtRZ4G5Kgj44XSAsKfX;25:XIyb65z7kMFpKbcwCqnH0KU2oBDGbpZSUQSL+Ze4vVh9HVTvsRfp3IyLxVglI8IzIHlyiH6xD6IJUEdmV+eSxZABh8RZN/6K7LhlLcEoTuxN8QDxvmfeLUOyIL1XwDmeXLSvCAHt1Lzh0ccnkZXwA9Rq6QEI7Q3nNyraSrkAI4bsEq8sIrHEbH7h8+VwIuzBUCQh1jr5a1uU/Qese6mRukfQT4xGNVoOMRh9V8aGDInwM2K73V8xXdHqTInGlFcv1qR6YT4QziPKzJpIjO8/FiAYCgEYFMelZWxDiA+LbujisOlLS9aQrgkgquHWqX9djFCkQncMN/TLHAO7SQZ2Yw==;31:TDjiwxM3grGg+/b4iNphb0ftb1/axZDW+BoxJ/fti6hpN2fYCFQyGrfKsWEKty8e66cYqur5jFDF7jyL9xdSbNKslTcD1Anp8/94JXzBExuVdhWLi3Bt9SI/u69eyXNc/UC+WpyzAajg06Z93pTYI6Ud4Te/1b1GGsW7Eep8wm1tdkiKozx5WeTCUcZwk58FLZjHm8TorW6LscX6uXgs86hVaXnZ3ADHD21iHCQGEKY=
X-MS-TrafficTypeDiagnostic: CY4PR04MB0967:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR04MB0967;20:arwVhbSNQFbPq2NQsPtMUIMStzlMqtN0jPLhBc1a5STBO3sUFwSeMsE4Gk6zhcI0TU+1eIGrzbYUlFjLGHCtBKT0jFM68JvVRTaGdXkcemXBAAKt8ZZazG6p9UcbD/QQsdNf+rZr3GphdSg6B7yuTY3f0qMKMqcM5lepmExddPI5lyLbzJvLrh2BCtLtA6td+8BkA9n+zZ7Rjw0MD1W17j6kAHMsrmB981v0Rmd/4apnsVqb2uYybILDWwRlJRFjPGETwukpP6kh1+7qI6nXap9JVMVDDCDXleqmFejzxMBtw19y+UWf+DSCAXjvqSnoRSlA8UMrbHP7RZml9YUpEgXSrGJjLIpV6zHKelC1Q92y9QJ6w6AV5GjllO78ifXWZ4duoXFTRNmoflgQAp8f3b6Ju8YugIw5I037R1WdxE8eO1IwcR3KE7OjDUVLjYRxPmJqHBCDIpr1w8KZ541EdartwewHn/GjQRvcE3UKAIZE++zue29PZMmfXyaRUXBYVFUy4wjg7fVbQXH6ZMmjJpB++AE8JC1pzLO/6NKHH7JgVpdZqWYioG58BrUTo0HZBqpPkNOGnjNSLjtCuGMLOI/rUK8SEN6nLAtfybQSJGY=;4:J0DS//grkOJ8MsBrCXFz+CceEyZINKVJDD1qJY8eVNKAqDRer4NXi9mbK++8ajoZ2m5fgm5WKx0r5rCgJ4rushZk+KaBizQWKlZN4vAKBo6V7lRQ4qx9jkvhYOlK4D/UA/IRt6Y/sq0LJhCHLFHIVYSeQRSsSezNcGCs5YPC2gLlTzFyOCSdnU+pJzA0XfrNcXE0Nj/Th0+qn59lo/ee6gG9AZfqpF8F67/F2RCgYJrggl3Bwxr81bxzeBy5p2cos8bIFRwk+1swUxnbLhDYSacfh1/zbq9XTcQhsGgqrbWbvWQ4BbbQa/uxfJ7exK//
X-Microsoft-Antispam-PRVS: <CY4PR04MB0967D550ACF73165865B1F8FF4000@CY4PR04MB0967.namprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(275809806118684);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699050);SRVR:CY4PR04MB0967;BCL:0;PCL:0;RULEID:;SRVR:CY4PR04MB0967;
X-Forefront-PRVS: 07880C4932
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(366004)(396003)(39860400002)(53754006)(199004)(189003)(39060400002)(229853002)(305945005)(6246003)(42186006)(316002)(6266002)(6916009)(58126008)(54906003)(7416002)(16586007)(52116002)(33896004)(122856001)(33656002)(561944003)(76176011)(1076002)(23726003)(97736004)(6116002)(105586002)(106356001)(81156014)(3846002)(8676002)(7736002)(50466002)(2906002)(5660300001)(47776003)(66066001)(90966002)(53936002)(81166006)(6306002)(476003)(186003)(14444005)(68736007)(446003)(8936002)(478600001)(966005)(9686003)(52956003)(4326008)(486006)(386003)(26005)(11346002)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR04MB0967;H:jcartwri.amer.corp.natinst.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR04MB0967;23:+/bnSGCR8lX43S1wLFAUkCvizQf2kK97oL0vwfYov?=
 =?us-ascii?Q?I9ICBLv4+Bl+DwrIoJvYzzvJV7CTnLghwzcc8nBFlCXdNGxe2w0NThqeHAQC?=
 =?us-ascii?Q?g3QOT1arpsRq3L176sH3T9N5RjobZfMJKHEdR7WuT76Ze+OXSVEiwAYo0ZY/?=
 =?us-ascii?Q?Ug5IZwyMoObtIGLSXRRWZmLOs66QVOeBZm3swUCaBYmOdhXyBGl5IDTlzSSN?=
 =?us-ascii?Q?fNt/BpIzGfXoSc8DLX68pinv7zElcnKs4ZiDAOKd2SJdZG6E7ZKd4GLOnh3h?=
 =?us-ascii?Q?FC/96qtiLM44agz/TiLNhDQCOyJE+Z1RAVS5L5mhuMcl3MmcxRS0YGG3LGv0?=
 =?us-ascii?Q?0wjzNN/KFGX9iepXZFmCj+hIUSP2Lr88tpZiGlU61xCnMPTm3SpFNNxa+tkF?=
 =?us-ascii?Q?AzkWXyBNFsg/SILqbSHdiJ9jAmuwK+PPyKhK5g+jT+zEhQWXHu/qhd7CqSnU?=
 =?us-ascii?Q?VvI4sfJX1C0MWhXpiFOefjRSwYn2K2yVb2x1gnMqbeERN2p/YK0p+4m0QOOi?=
 =?us-ascii?Q?AV9wzwVc6A8ilfDo+k9VyPw9nzJrgo6mvlEk99SDvOTydBG6dshHHdebquWE?=
 =?us-ascii?Q?Rie1MDHHkRx74cFpa/sknCVyGzGO6sK6wKo8FvagyDjAh0sWtKKoZHiWo1GC?=
 =?us-ascii?Q?n0SODeqZi/sPrF58wbYCwKSeAuqJkYZBrtz+Y9Rn2MQ8W8ERUBNE3t9LVY+M?=
 =?us-ascii?Q?Fo1iDy+XbnO5EBQvgVnbvzG5+FkFxNqH+cC/YJNBSXWyfSDoRUV7zgpNjygb?=
 =?us-ascii?Q?5G05cbApTy0znLRsDk5xmMXDkTOokMu2rPoCr8jOIdVs5Xul4Yj4Y2f+JqU8?=
 =?us-ascii?Q?ObA4QxhFuIk4j3rkTsTTe9kuvd0sbhft6zfa4ZLduFGKCnUCskx4V7t0Bres?=
 =?us-ascii?Q?zcMh4wuTsXORDrtNGhiF3eTpq6UyLknHGwjWVnOkO/oUBbP06SGZy8tEho2W?=
 =?us-ascii?Q?s426VeAGQ1Ksa3zzNRvepMJbsejN5y0Om33piRM99hkbxskfmVkyq53ZcQVt?=
 =?us-ascii?Q?cr9DZJmJHn8XPf1xr2CBbuPvgKfe0fzdAzRB0CNatFtTfdF6VFQD8Fl8TLYh?=
 =?us-ascii?Q?v4zRh3+IaaDM8utBTtyXA5NPjRgLeq3eOcceAFjFzKuHJ1ZXd7y/cVmWKa/q?=
 =?us-ascii?Q?oNEXDwJgJdHkUc10otwa4Q4r1cXeSGvBOOvsx5ZJ7bQrSCjXWywQjp1hMovY?=
 =?us-ascii?Q?VpCquhk4LOmuRYf1298pkYCWgT27Fm6Q1EjLzfbtuKJUd2jtyyNDjT8D0PAB?=
 =?us-ascii?Q?q6/Cnm4CaaULJS9eE0dRkMWiSTgnN5mtxmJzxPEN4DeR6Jut73bMSftLjlUF?=
 =?us-ascii?Q?44fJxdJxTSN1jKUW84/Hw53oBABdYnFpQarMHCrq0eVFabNOjdt5sTKYma4w?=
 =?us-ascii?Q?bK+YEzGJA6sDslEYGWmXmi3SK8=3D?=
X-Microsoft-Antispam-Message-Info: 4SLJX0weon+QV1/jBLU8vm6RewP3f00LlhisFaQUg1y0PjLqQ5rTVib68zzQEV/p06PruUBjyY7PwGXv5tGYkVM1gS19j3nX80VaSCx+7c7lMA9c5evRG3fVikCYBKq2bed4wJ5s/ycdhntBCaRIx/xcTmwbTliUf1pVL4qKHbCZ7nDxIGYrfk7TerHsim5u9yAswvMGgojJ1xJsWwmKoOKT212PHRn0+RBnNxSazSUoBwMTa7d2oHuxJTSgpm1S+7ZZW7Na2J+Qy7ed50ozumXLuklsdbZ8qESCyrX5UqlVHxHJr3+ZKW4hVVAPOhZwplXFde+qZCtkG65wp4YbVWU17MLkPT/q3SfTrRch9z4=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR04MB0967;6:XdzuRxSqTjqfVc1U8ZjXSuN4lJ4KqURSzBgR8tWY3aiZyA5+a60bo1CGz4H2A7BnB5Jhd94MOu2j83OiV2GX7GAvQqR9UmkNFmZPDTfz3pZEPSpGELWIKxp7bZSVLRLukh22BiknitKvcZteT3AtEh+dZFQN86kyujlegvtnOacN3bG6zvvJwfSbs2njjCOKsBb5xdAoSwjcoSOxwwhu4SFH6dEaT1YU22s7yh8oSngopDnQpwo5MszatmDAJXZCEHgWhOFeMccelhYmpWn6zQy6CuWeI/1kIysDVPChj9WaqcfiN46T7mdXT7VVovxhTv3x9hY73KQujXoXt6fiHO0SBTwUTKxzCsYn2ZCq1myusvqN+VwckZpRw/bERXHdK6UgDAS+UHqLURSArcAMLQLuxC1UC04k24nhbFlaNJlGsnJMUuDudYGkJW5w4MGoRgZWyDTXxtEGFwxAJIo+RA==;5:Ku4o7y7KUmlU7ppF+uL4X1Nmcri+CdwE9/kIdpLscbUcPaxZC756FmHCGc9d+8aZ9bud4WeVVdSt1oRRP4Ax6hyjzq7gmsdiLhHqWPdDGvRol/yYq8p0bHgjlfSexaw4omEbNRQTmwPSh0gO4r32bdrMvPEBurXiZ+wKtyQ8FUo=;7:qalLHT2gHHE5qXwRsnYJT/EtBNImq9+axuMxou4/et6Awveg9Erzi4SS9ekklvxA6SqfBw8nKxKfFEXw4B2+qqkrMp/3WjveRmHY1LcQbtB7VIl+lSwRHouyBLRd25wu42U51BUp8CcRprvseKfLl12f9jTO7o6haVn9m+pJH9tYbtOymF9mlQUse89C6SJyp/Z1wQNBsIR/aKcWr0x1998VLQjxRsN5SYeaDKe6Hcet8SWXcBUKQo5ulV0u5JWg
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2018 20:44:04.4012 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 093787aa-acce-4f5d-e94c-08d61502a65d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0967
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-07_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809070204
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all-

On Tue, Sep 04, 2018 at 01:25:29PM -0400, Steven Rostedt wrote:
> Hi RT folks!
>
> The call for proposals (CfP) is now open for the RT Microconference at
> Linux Plumbers in Vancouver, Canada. The topics we are looking at this
> year are:
>
>  - How will PREEMPT_RT be maintained (is it a subsystem?)
>
>  - Who will maintain it?
>
>  - How do we teach the rest of the kernel developers how not to break PREEMPT_RT?
>
>  - How do we catch when it breaks?
>
>  - What tools can we add into tools/ that other kernel developers can use to test and learn about PREEMPT_RT?
>
>  - What tests can we add into tools/testing/selftests?
>
>  - What kernel boot selftests can be added?
>
>  - How can we modify lockdep to catch problems that can break PREEMPT_RT?
>
>  - Discuss various types of failures that can happen with PREEMPT_RT that normally would not happen in the vanilla kernel.
>
>  - How do we handle stable backports?
>
>  - Interaction with Safety Critical domains?
>
>  - Interrupt threads are RT and are not protected by the RT Throttling.
>    How can we prevent interrupt thread starvation from a rogue RT task?
>
>  - How to determine if a kernel is booted with PREEMPT_RT enabled?
>
>  - librtpi: "solving" long-standing glibc pthread condvar internal lock inversion with a new implementation; motivations, technical details, etc.
>
>  - SCHED_DEADLINE - Lots of research has been made to various issues like CPU affinity, Bandwidth inheritance, cgroup support; but nothing has been done to the kernel. Let's make a commitment and push these ideas forward into mainline.
>
>  - How can we modify lockdep to catch problems that can break PREEMPT_RT?
>
>  - Discuss various types of failures that can happen with PREEMPT_RT that normally would not happen in the vanilla kernel.

There was some confusion as to whether or not a topic being listed above
automatically meant that it was to be included in the RT Microconference
agenda.

The answer is: NO.  If you would like to see a specific topic discussed,
either from this list or otherwise, you must submit it via the portal
listed below.  Only topics submitted to the portal will be considered
for the RT Microconference agenda.

Note also that submitting a topic will also mean that you will be
responsible for introducing the necessary context to the group to
facilitate further discussion.

> If you want to lead one of the above sessions, or if you have a new
> session you want to submit, please do so here:
>
>   https://linuxplumbersconf.org/event/2/abstracts/
>
> Set up an account, and then click "Submit new proposal".
>
> Fill out the "Title", "Content", select the "Authors" as the one leading
> the session (yourself), and then for "Track" select "RT MC Topics CfP".
> Select "Yes" to agree with the anti-harassment policy, and then hit
> Submit.

Thanks, and see you there!

   Julia
