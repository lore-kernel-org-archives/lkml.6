Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DF5C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 10:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85FF220874
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 10:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfADKzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 05:55:31 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60254 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726459AbfADKza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 05:55:30 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x04AsQ1I034472
        for <linux-kernel@vger.kernel.org>; Fri, 4 Jan 2019 05:55:29 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pt3nw74nt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 05:55:29 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <chandan@linux.ibm.com>;
        Fri, 4 Jan 2019 10:55:26 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 4 Jan 2019 10:55:22 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x04AtKjd4325772
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 4 Jan 2019 10:55:21 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B320DA406B;
        Fri,  4 Jan 2019 10:55:20 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 992A0A405B;
        Fri,  4 Jan 2019 10:55:17 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.74.200])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  4 Jan 2019 10:55:17 +0000 (GMT)
From:   Chandan Rajendra <chandan@linux.ibm.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "moderated list:INTEL ASoC DRIVERS" <alsa-devel@alsa-project.org>,
        Sinan Kaya <Okaya@kernel.org>,
        Jie Yang <yang.jie@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Ted Ts'o" <tytso@google.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>
Subject: Re: [alsa-devel] [PATCH v5 08/11] ASoC: Intel: atom: Make PCI dependency explicit
Date:   Fri, 04 Jan 2019 16:25:37 +0530
Organization: IBM
In-Reply-To: <fd520793-4ec4-2ced-7b00-2cdd3297d74c@linux.intel.com>
References: <20190102181038.4418-1-okaya@kernel.org> <CAJZ5v0j=i_YN7szXLV8cKLp2XmoqUTQR6EJhRJhWFJzenhzM9Q@mail.gmail.com> <fd520793-4ec4-2ced-7b00-2cdd3297d74c@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-TM-AS-GCONF: 00
x-cbid: 19010410-0012-0000-0000-000002E1C976
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010410-0013-0000-0000-00002118CBD7
Message-Id: <17399292.N8n9nqCdrl@localhost.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-04_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901040098
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, January 3, 2019 9:58:28 PM IST Pierre-Louis Bossart wrote:
> 
> >>> arch/ia64/Kconfig:126:error: recursive dependency detected!
> >>> arch/ia64/Kconfig:126:    choice <choice> contains symbol IA64_HP_SIM
> >>> arch/ia64/Kconfig:200:    symbol IA64_HP_SIM is part of choice PM
> >>> kernel/power/Kconfig:144:    symbol PM is selected by PM_SLEEP
> >>> kernel/power/Kconfig:104:    symbol PM_SLEEP depends on HIBERNATE_CALLBACKS
> >>> kernel/power/Kconfig:31:    symbol HIBERNATE_CALLBACKS is selected by
> >>> HIBERNATION
> >>> kernel/power/Kconfig:34:    symbol HIBERNATION depends on SWAP
> >>> init/Kconfig:250:    symbol SWAP depends on BLOCK
> >>> block/Kconfig:5:    symbol BLOCK is selected by UBIFS_FS
> >>> fs/ubifs/Kconfig:1:    symbol UBIFS_FS depends on MISC_FILESYSTEMS
> >>> fs/Kconfig:220:    symbol MISC_FILESYSTEMS is selected by ACPI_APEI
> >>> drivers/acpi/apei/Kconfig:8:    symbol ACPI_APEI depends on ACPI
> >>> drivers/acpi/Kconfig:9:    symbol ACPI depends on ARCH_SUPPORTS_ACPI
> >>> <<<< LOOK HERE
> >>> drivers/acpi/Kconfig:6:    symbol ARCH_SUPPORTS_ACPI is selected by
> >>> IA64_HP_SIM
> >>> arch/ia64/Kconfig:200:    symbol IA64_HP_SIM is part of choice <choice>
> >>>
> >>> At any rate, a 3 mn git bisect tells me the circular dependency is
> >>> exposed by this change:
> >>>
> >>> f3fd6cd74fedf99b6060f75df00943fda13b65f2 is the first bad commit
> >>> commit f3fd6cd74fedf99b6060f75df00943fda13b65f2
> >>> Author: Chandan Rajendra <chandan@linux.vnet.ibm.com>
> >>> Date:   Sat Dec 8 12:21:38 2018 +0530
> >>>
> >>>       fscrypt: remove filesystem specific build config option
> >>>
> >>>       In order to have a common code base for fscrypt "post read" processing
> >>>       for all filesystems which support encryption, this commit removes
> >>>       filesystem specific build config option (e.g.
> >>> CONFIG_EXT4_FS_ENCRYPTION)
> >>>       and replaces it with a build option (i.e. CONFIG_FS_ENCRYPTION) whose
> >>>       value affects all the filesystems making use of fscrypt.
> >>>
> >>>       Signed-off-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>
> >>>       Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> >>>
> >> FWIW, The patch at https://patchwork.kernel.org/patch/10725883/ fixes this
> >> problem by removing "select BLOCK if FS_ENCRYPTION" from fs/ubifs/Kconfig.
> > OK
> >
> > Pierre-Louis, can you check if this patch makes the issue go away for
> > you, please?
> 
> Wondering if Chandan provided the right pointer, I wasn't able to apply 
> this patch, but commenting out "select BLOCK if FS_ENCRYPTION" in 
> fs/ubifs/Kconfig makes the circular dependency go away. All good for me.
> 

V4 version of the patchset (which is part of linux-next) had introduced the
"select BLOCK if FS_ENCRYPTION". The V5 patchset omits that line. Hence the
patch did not apply cleanly. However just commenting out that line was the
right thing to do.

-- 
chandan



