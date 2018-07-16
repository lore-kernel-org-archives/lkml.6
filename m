Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41363ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 05:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC8DB208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 05:26:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC8DB208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbeGPFvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 01:51:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34698 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726627AbeGPFvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 01:51:20 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6G5NjaX017759
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 01:25:43 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k8h7tq00u-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 01:25:43 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ego@linux.vnet.ibm.com>;
        Mon, 16 Jul 2018 01:25:42 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 16 Jul 2018 01:25:39 -0400
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6G5PcdJ6750934
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Jul 2018 05:25:38 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 42346AE064;
        Mon, 16 Jul 2018 01:25:05 -0400 (EDT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 01F87AE05C;
        Mon, 16 Jul 2018 01:25:04 -0400 (EDT)
Received: from sofia.ibm.com (unknown [9.124.35.39])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 16 Jul 2018 01:25:04 -0400 (EDT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id 5B5B92E2F51; Mon, 16 Jul 2018 10:55:36 +0530 (IST)
Date:   Mon, 16 Jul 2018 10:55:36 +0530
From:   Gautham R Shenoy <ego@linux.vnet.ibm.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, kbuild-all@01.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Neuling <mikey@neuling.org>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
        Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] powerpc: Enable CPU_FTR_ASYM_SMT for interleaved
 big-cores
Reply-To: ego@linux.vnet.ibm.com
References: <03b97f95b42a9044a4280c318a92ac5e53e79828.1530867876.git.ego@linux.vnet.ibm.com>
 <201807111509.TCWIHpaa%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201807111509.TCWIHpaa%fengguang.wu@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
x-cbid: 18071605-0064-0000-0000-0000032AE98F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009371; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01061556; UDB=6.00545000; IPR=6.00839473;
 MB=3.00022156; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-16 05:25:42
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071605-0065-0000-0000-000039F4909C
Message-Id: <20180716052536.GA13503@in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-16_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807160065
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, Jul 11, 2018 at 04:32:30PM +0800, kbuild test robot wrote:
> Hi Gautham,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on powerpc/next]
> [also build test ERROR on v4.18-rc4 next-20180710]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Gautham-R-Shenoy/powerpc-Detect-the-presence-of-big-cores-via-ibm-thread-groups/20180706-174756
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
> config: powerpc-g5_defconfig (attached as .config)
> compiler: powerpc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.2.0 make.cross ARCH=powerpc 
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from include/linux/static_key.h:1:0,
>                     from include/linux/context_tracking_state.h:6,
>                     from include/linux/vtime.h:5,
>                     from include/linux/hardirq.h:8,
>                     from include/linux/interrupt.h:11,
>                     from include/linux/serial_core.h:25,
>                     from include/linux/serial_8250.h:14,
>                     from arch/powerpc/kernel/setup-common.c:33:
>    arch/powerpc/kernel/setup-common.c: In function 'smp_setup_cpu_maps':
> >> arch/powerpc/kernel/setup-common.c:777:25: error: 'cpu_feature_keys' undeclared (first use in this function); did you mean 'setup_feature_keys'?
>       static_branch_enable(&cpu_feature_keys[key]);

Ok, so this needs to be enabled only on CONFIG_PPC_PSERIES and
CONFIG_PPC_POWERNV. Will fix this.


--
Thanks and Regards
gautham.

