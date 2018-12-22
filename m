Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 541FBC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 16:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17724219FC
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 16:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389233AbeLVQx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 11:53:28 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50266 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388710AbeLVQx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 11:53:27 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBM6cNsq093881
        for <linux-kernel@vger.kernel.org>; Sat, 22 Dec 2018 01:43:34 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2phf3esvbb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 22 Dec 2018 01:43:34 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <chandan@linux.vnet.ibm.com>;
        Sat, 22 Dec 2018 06:43:32 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 22 Dec 2018 06:43:26 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBM6hPdJ3342788
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 22 Dec 2018 06:43:25 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5F3E711C04C;
        Sat, 22 Dec 2018 06:43:25 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A975511C04A;
        Sat, 22 Dec 2018 06:43:20 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.72.185])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat, 22 Dec 2018 06:43:20 +0000 (GMT)
From:   Chandan Rajendra <chandan@linux.vnet.ibm.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sinan Kaya <okaya@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wen He <wen.he_1@nxp.com>, Peng Ma <peng.ma@nxp.com>,
        Vinod Koul <vkoul@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: linux-next: Tree for Dec 21
Date:   Sat, 22 Dec 2018 12:13:35 +0530
Organization: IBM
In-Reply-To: <20181221162149.GA32500@roeck-us.net>
References: <20181221193244.3a6ed685@canb.auug.org.au> <20181221162149.GA32500@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-TM-AS-GCONF: 00
x-cbid: 18122206-4275-0000-0000-000002F42C71
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18122206-4276-0000-0000-000038023C2B
Message-Id: <2778925.B2WVoZk5xr@localhost.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-22_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812220059
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, December 21, 2018 9:51:49 PM IST Guenter Roeck wrote:
> On Fri, Dec 21, 2018 at 07:32:44PM +1100, Stephen Rothwell wrote:
> > Hi all,
> > 
> > News: there will be no linux-next release until Jan 2.  Have a good break.
> > 
> > Changes since 20181220:
> > 
> > New tree: gpio-brgl
> > 
> > The pm tree gained a conflict against the kbuild tree.
> > 
> > The bpf-next tree gained a conflict against Linus' tree.
> > 
> > The kvm tree gained a conflict against the powerpc tree.
> > 
> > The akpm tree lost a patch that turned up elsewhere.
> > 
> > Non-merge commits (relative to Linus' tree): 10464
> >  10564 files changed, 495226 insertions(+), 271806 deletions(-)
> > 
> > ----------------------------------------------------------------------------
> > 
> 

[..]

> [3]:
> 
> # bad: [340ae71f9dd421227a58c14a909b63033745dca4] Add linux-next specific files for 20181221
> # good: [7566ec393f4161572ba6f11ad5171fd5d59b0fbd] Linux 4.20-rc7
> git bisect start 'HEAD' 'v4.20-rc7'
> # bad: [9f3de88514b2b5666214f0be3bc98d4e7136a7f1] Merge remote-tracking branch 'mtd/mtd/next'
> git bisect bad 9f3de88514b2b5666214f0be3bc98d4e7136a7f1
> # bad: [f915ece8cdbafa705badb5417e8c70ff83a63172] Merge remote-tracking branch 'hid/for-next'
> git bisect bad f915ece8cdbafa705badb5417e8c70ff83a63172
> # good: [bf1c4d50b9fa6e80ad13293b4acace16dfddad0b] Merge remote-tracking branch 'arm-soc/for-next'
> git bisect good bf1c4d50b9fa6e80ad13293b4acace16dfddad0b
> # good: [4419ffc60fb0eb3c5c61ac4d41d2b45f5fa001ed] Merge remote-tracking branch 's390/features'
> git bisect good 4419ffc60fb0eb3c5c61ac4d41d2b45f5fa001ed
> # bad: [26b69eb30a87a11edf53924ea0051f28070f5223] Merge remote-tracking branch 'jfs/jfs-next'
> git bisect bad 26b69eb30a87a11edf53924ea0051f28070f5223
> # good: [0078a3f8bf05002d636a6d4816c2635096803c24] Merge branch 'for-next-current-v4.19-20181219' into for-next-20181219
> git bisect good 0078a3f8bf05002d636a6d4816c2635096803c24
> # good: [fb468109d7cffc217b8cbc73909d2236b308779e] Merge remote-tracking branch 'xtensa/xtensa-for-next'
> git bisect good fb468109d7cffc217b8cbc73909d2236b308779e
> # bad: [46aa53167cf1b522a2144cc3f5543a2b9c6fdf2b] Merge remote-tracking branch 'ext3/for_next'
> git bisect bad 46aa53167cf1b522a2144cc3f5543a2b9c6fdf2b
> # bad: [3a370c761f2bd1cf771e3a2d691c9ee2e71c109f] Merge remote-tracking branch 'befs/for-next'
> git bisect bad 3a370c761f2bd1cf771e3a2d691c9ee2e71c109f
> # good: [bff49d3e9affae6f9e38a9103a4166ade2c310dd] ext4: add basic fs-verity support
> git bisect good bff49d3e9affae6f9e38a9103a4166ade2c310dd
> # bad: [c942d68713c322c27ecb8287af077571b4ab0c08] ext4: use IS_VERITY() to check inode's fsverity status
> git bisect bad c942d68713c322c27ecb8287af077571b4ab0c08
> # good: [dc82005ead5de0e5bb764c0c1c50a19891b6de15] ext4: use IS_ENCRYPTED() to check encryption status
> git bisect good dc82005ead5de0e5bb764c0c1c50a19891b6de15
> # bad: [f3fd6cd74fedf99b6060f75df00943fda13b65f2] fscrypt: remove filesystem specific build config option
> git bisect bad f3fd6cd74fedf99b6060f75df00943fda13b65f2
> # good: [1dcfeb539c09237c98b99685fb9cd156241db13f] f2fs: use IS_ENCRYPTED() to check encryption status
> git bisect good 1dcfeb539c09237c98b99685fb9cd156241db13f
> # first bad commit: [f3fd6cd74fedf99b6060f75df00943fda13b65f2] fscrypt:
> # remove filesystem specific build config option

The patch at https://patchwork.kernel.org/patch/10725883/ fixes this problem
by removing "select BLOCK if FS_ENCRYPTION" from fs/ubifs/Kconfig.

-- 
chandan



