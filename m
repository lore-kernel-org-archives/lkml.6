Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38097C43612
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1025D205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbfAQNgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 08:36:33 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53870 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725904AbfAQNgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 08:36:32 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0HDTlRR126174
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 08:36:31 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2q2qtf7puw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 08:36:30 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Thu, 17 Jan 2019 13:36:25 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 17 Jan 2019 13:36:22 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0HDaLZB9765128
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Jan 2019 13:36:21 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 444554204C;
        Thu, 17 Jan 2019 13:36:21 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 07F0742047;
        Thu, 17 Jan 2019 13:36:21 +0000 (GMT)
Received: from osiris (unknown [9.152.212.95])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 17 Jan 2019 13:36:20 +0000 (GMT)
Date:   Thu, 17 Jan 2019 14:36:19 +0100
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-s390@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 0/5] s390: rework compat wrapper generation
References: <20190116131527.2071570-1-arnd@arndb.de>
MIME-Version: 1.0
In-Reply-To: <20190116131527.2071570-1-arnd@arndb.de>
X-TM-AS-GCONF: 00
x-cbid: 19011713-0028-0000-0000-0000033A7550
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011713-0029-0000-0000-000023F7A081
Message-Id: <20190117133619.GD18351@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-17_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=875 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901170099
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 02:15:18PM +0100, Arnd Bergmann wrote:
> Hi Heiko and Martin,
> 
> As promised, I gave this a go and changed the SYSCALL_DEFINEx()
> infrastructure to always include the wrappers for doing the
> 31-bit argument conversion on s390 compat mode.
> 
> This does three main things:
> 
> - The UID16 rework saved a lot of duplicated code, and would
>   probably make sense by itself, but is also required as
>   we can no longer call sys_*() functions directly after the
>   last step.
> 
> - Removing the compat_wrapper.c file is of course the main
>   goal here, in order to remove the need to maintain the
>   compat_wrapper.c file when new system calls get added.
>   Unfortunately, this requires adding some complexity in
>   syscall_wrapper.h, and trades a small reduction in source
>   code lines for a small increase in binary size for
>   unused wrappers.
> 
> - As an added benefit, the use of syscall_wrapper.h now makes
>   it easy to change the syscall wrappers so they no longer
>   see all user space register contents, similar to changes
>   done in commits fa697140f9a2 ("syscalls/x86: Use 'struct pt_regs'
>   based syscall calling convention for 64-bit syscalls") and
>   4378a7d4be30 ("arm64: implement syscall wrappers").
>   I leave the actual implementation of this for you, if you
>   want to do it later.
> 
> I did not test the changes at runtime, but I looked at the
> generated object code, which seems fine here and includes
> the same conversions as before.

All looks good and seems to work fine. This is a very nice
simplification of our compat code, even if it adds some dead code to
the kernel image.

I did some tests and it all looks good. Also the generated code looks
fine. So, if nothing breaks, this will go upstream with next merge
window via the s390 tree.

Thanks again for your work!

