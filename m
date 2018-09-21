Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A59ECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 036B721568
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:20:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 036B721568
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390804AbeIUXKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 19:10:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42308 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732114AbeIUXKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 19:10:45 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8LHJExj009339
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 13:20:54 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mn3sstyv8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 13:20:53 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ego@linux.vnet.ibm.com>;
        Fri, 21 Sep 2018 13:20:52 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 21 Sep 2018 13:20:49 -0400
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8LHKmmg28966998
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 21 Sep 2018 17:20:48 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 78334AE068;
        Fri, 21 Sep 2018 13:19:26 -0400 (EDT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D0A5AE05F;
        Fri, 21 Sep 2018 13:19:26 -0400 (EDT)
Received: from sofia.ibm.com (unknown [9.79.178.146])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 21 Sep 2018 13:19:26 -0400 (EDT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id 2FDCA2E2D92; Fri, 21 Sep 2018 22:50:45 +0530 (IST)
Date:   Fri, 21 Sep 2018 22:50:45 +0530
From:   Gautham R Shenoy <ego@linux.vnet.ibm.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, kbuild-all@01.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Neuling <mikey@neuling.org>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
        Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
        Anton Blanchard <anton@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 3/3] powerpc/sysfs: Add
 topology/smallcore_thread_siblings[_list]
Reply-To: ego@linux.vnet.ibm.com
References: <1537464159-25919-4-git-send-email-ego@linux.vnet.ibm.com>
 <201809211407.677jNLUN%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201809211407.677jNLUN%fengguang.wu@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
x-cbid: 18092117-0072-0000-0000-000003A7F82D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009747; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01091620; UDB=6.00564046; IPR=6.00871644;
 MB=3.00023437; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-21 17:20:52
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092117-0073-0000-0000-000049801A46
Message-Id: <20180921172045.GB12919@in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-21_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809210171
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, Sep 21, 2018 at 02:20:15PM +0800, kbuild test robot wrote:
> Hi Gautham,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on powerpc/next]
> [also build test ERROR on v4.19-rc4 next-20180919]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Gautham-R-Shenoy/powerpc-Detection-and-scheduler-optimization-for-POWER9-bigcore/20180921-085812
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
> config: powerpc-mpc837x_mds_defconfig (attached as .config)
> compiler: powerpc-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.2.0 make.cross ARCH=powerpc 
> 
> All errors (new ones prefixed by >>):
> 
>    arch/powerpc/kernel/sysfs.c: In function 'smallcore_thread_siblings_show':
> >> arch/powerpc/kernel/sysfs.c:724:45: error: implicit declaration of function 'cpu_smallcore_mask'; did you mean 'cpu_all_mask'? [-Werror=implicit-function-declaration]
>      return cpumap_print_to_pagebuf(false, buf, cpu_smallcore_mask(cpu));
>                                                 ^~~~~~~~~~~~~~~~~~


No, the smallcore_thread_siblings_show, and the other functions should
only be compiled for CONFIG_SMP.


Will add this. Thanks bot!

>                                                 cpu_all_mask
> >> arch/powerpc/kernel/sysfs.c:724:45: error: passing argument 3 of 'cpumap_print_to_pagebuf' makes pointer from integer without a cast [-Werror=int-conversion]
>    In file included from include/linux/rcupdate.h:44:0,
>                     from include/linux/radix-tree.h:28,
>                     from include/linux/idr.h:15,
>                     from include/linux/kernfs.h:14,
>                     from include/linux/sysfs.h:16,
>                     from include/linux/kobject.h:20,
>                     from include/linux/device.h:16,
>                     from arch/powerpc/kernel/sysfs.c:1:
>    include/linux/cpumask.h:892:1: note: expected 'const struct cpumask *' but argument is of type 'int'
>     cpumap_print_to_pagebuf(bool list, char *buf, const struct cpumask *mask)
>     ^~~~~~~~~~~~~~~~~~~~~~~
>    arch/powerpc/kernel/sysfs.c: In function 'smallcore_thread_siblings_list_show':
>    arch/powerpc/kernel/sysfs.c:734:44: error: passing argument 3 of 'cpumap_print_to_pagebuf' makes pointer from integer without a cast [-Werror=int-conversion]
>      return cpumap_print_to_pagebuf(true, buf, cpu_smallcore_mask(cpu));
>                                                ^~~~~~~~~~~~~~~~~~
>    In file included from include/linux/rcupdate.h:44:0,
>                     from include/linux/radix-tree.h:28,
>                     from include/linux/idr.h:15,
>                     from include/linux/kernfs.h:14,
>                     from include/linux/sysfs.h:16,
>                     from include/linux/kobject.h:20,
>                     from include/linux/device.h:16,
>                     from arch/powerpc/kernel/sysfs.c:1:
>    include/linux/cpumask.h:892:1: note: expected 'const struct cpumask *' but argument is of type 'int'
>     cpumap_print_to_pagebuf(bool list, char *buf, const struct cpumask *mask)
>     ^~~~~~~~~~~~~~~~~~~~~~~
>    cc1: all warnings being treated as errors
> 
> vim +724 arch/powerpc/kernel/sysfs.c
> 
>    717	
>    718	static ssize_t smallcore_thread_siblings_show(struct device *dev,
>    719						struct device_attribute *attr,
>    720						char *buf)
>    721	{
>    722		int cpu = dev->id;
>    723	
>  > 724		return cpumap_print_to_pagebuf(false, buf, cpu_smallcore_mask(cpu));
>    725	}
>    726	static DEVICE_ATTR_RO(smallcore_thread_siblings);
>    727	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation


