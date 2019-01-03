Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D265C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 04:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0E80206B6
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 04:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbfACEIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 23:08:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54240 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727650AbfACEIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 23:08:11 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0344F43056757
        for <linux-kernel@vger.kernel.org>; Wed, 2 Jan 2019 23:08:10 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ps6q0qu1j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 23:08:10 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <chandan@linux.ibm.com>;
        Thu, 3 Jan 2019 04:08:08 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 3 Jan 2019 04:08:04 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x03483ac4391284
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Jan 2019 04:08:03 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 442514C04E;
        Thu,  3 Jan 2019 04:08:03 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 90DB34C04A;
        Thu,  3 Jan 2019 04:08:00 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.89.150])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  3 Jan 2019 04:08:00 +0000 (GMT)
From:   Chandan Rajendra <chandan@linux.ibm.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Sinan Kaya <Okaya@kernel.org>,
        "moderated list:INTEL ASoC DRIVERS" <alsa-devel@alsa-project.org>,
        Mark Brown <broonie@kernel.org>,
        Jie Yang <yang.jie@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        "Ted Ts'o" <tytso@google.com>
Subject: Re: [alsa-devel] [PATCH v5 08/11] ASoC: Intel: atom: Make PCI dependency explicit
Date:   Thu, 03 Jan 2019 09:38:20 +0530
Organization: IBM
In-Reply-To: <8c69f8d0-6a95-0011-ff87-8ac9236a992d@linux.intel.com>
References: <20190102181038.4418-1-okaya@kernel.org> <CAK9iUCPWQ=9EgnUFo8BHraEgFwHs3FdbegPLwhT-KHD=r2WBkQ@mail.gmail.com> <8c69f8d0-6a95-0011-ff87-8ac9236a992d@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-TM-AS-GCONF: 00
x-cbid: 19010304-0028-0000-0000-000003322CE2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010304-0029-0000-0000-000023EF783B
Message-Id: <5797826.UxqLOWUXRU@localhost.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-03_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901030034
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, January 3, 2019 5:20:27 AM IST Pierre-Louis Bossart wrote:
> 
> On 1/2/19 4:58 PM, Sinan Kaya wrote:
> > On Wed, Jan 2, 2019 at 10:50 PM Pierre-Louis Bossart
> > <pierre-louis.bossart@linux.intel.com> wrote:
> >>
> >>> This is pointing to a kconfig issue on ia64 arch.
> >>>
> >>> arch/ia64/Kconfig:128:error: recursive dependency detected!
> >>> arch/ia64/Kconfig:128:    choice <choice> contains symbol IA64_HP_SIM
> >>> arch/ia64/Kconfig:202:    symbol IA64_HP_SIM is part of choice PM
> >>>
> >>> IA64_HP_SIM is both a choice and is selected.
> >>>
> >>> I did allyesconfig and disabled PCI afterwards to find all the issues
> >>> on this patchset.
> >> Are you saying there's a newer series that fixes this issue for both
> >> allyesconfig and allmodconfig?
> >>
> >> if yes, then we're good.
> >
> > No, I haven't fixed ia64 kconfig issue. That's somebody else's job. I
> > used allyesconfig to find out all compilation issues on x86 arch to
> > come up with this patchset.
> 
> Nothing makes me cringe more than "somebody else's job" statements. In 
> this case, there is obviously a correlation with your ACPI changes since 
> the circular dependency happens because of the ACPI symbol.
> 
> arch/ia64/Kconfig:126:error: recursive dependency detected!
> arch/ia64/Kconfig:126:    choice <choice> contains symbol IA64_HP_SIM
> arch/ia64/Kconfig:200:    symbol IA64_HP_SIM is part of choice PM
> kernel/power/Kconfig:144:    symbol PM is selected by PM_SLEEP
> kernel/power/Kconfig:104:    symbol PM_SLEEP depends on HIBERNATE_CALLBACKS
> kernel/power/Kconfig:31:    symbol HIBERNATE_CALLBACKS is selected by 
> HIBERNATION
> kernel/power/Kconfig:34:    symbol HIBERNATION depends on SWAP
> init/Kconfig:250:    symbol SWAP depends on BLOCK
> block/Kconfig:5:    symbol BLOCK is selected by UBIFS_FS
> fs/ubifs/Kconfig:1:    symbol UBIFS_FS depends on MISC_FILESYSTEMS
> fs/Kconfig:220:    symbol MISC_FILESYSTEMS is selected by ACPI_APEI
> drivers/acpi/apei/Kconfig:8:    symbol ACPI_APEI depends on ACPI
> drivers/acpi/Kconfig:9:    symbol ACPI depends on ARCH_SUPPORTS_ACPI 
> <<<< LOOK HERE
> drivers/acpi/Kconfig:6:    symbol ARCH_SUPPORTS_ACPI is selected by 
> IA64_HP_SIM
> arch/ia64/Kconfig:200:    symbol IA64_HP_SIM is part of choice <choice>
> 
> At any rate, a 3 mn git bisect tells me the circular dependency is 
> exposed by this change:
> 
> f3fd6cd74fedf99b6060f75df00943fda13b65f2 is the first bad commit
> commit f3fd6cd74fedf99b6060f75df00943fda13b65f2
> Author: Chandan Rajendra <chandan@linux.vnet.ibm.com>
> Date:   Sat Dec 8 12:21:38 2018 +0530
> 
>      fscrypt: remove filesystem specific build config option
> 
>      In order to have a common code base for fscrypt "post read" processing
>      for all filesystems which support encryption, this commit removes
>      filesystem specific build config option (e.g. 
> CONFIG_EXT4_FS_ENCRYPTION)
>      and replaces it with a build option (i.e. CONFIG_FS_ENCRYPTION) whose
>      value affects all the filesystems making use of fscrypt.
> 
>      Signed-off-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>
>      Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> 

FWIW, The patch at https://patchwork.kernel.org/patch/10725883/ fixes this
problem by removing "select BLOCK if FS_ENCRYPTION" from fs/ubifs/Kconfig.

-- 
chandan



