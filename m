Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C635C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 01:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1534B2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 01:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfARBI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 20:08:28 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41150 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726124AbfARBI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 20:08:28 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0I17RKs107593
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 20:08:26 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q33yr9vh5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 20:08:26 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 18 Jan 2019 01:08:23 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 18 Jan 2019 01:08:18 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0I18HQb2621796
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Jan 2019 01:08:17 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 22D23A405E;
        Fri, 18 Jan 2019 01:08:17 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C8FAA4040;
        Fri, 18 Jan 2019 01:08:15 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.91.118])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 18 Jan 2019 01:08:15 +0000 (GMT)
Subject: Re: [PATCH v3 0/2] let kexec_file_load use platform keyring to
 verify the kernel image
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Kairui Song <kasong@redhat.com>, linux-kernel@vger.kernel.org,
        Dave Young <dyoung@redhat.com>
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        jwboyer@fedoraproject.org, keyrings@vger.kernel.org,
        jmorris@namei.org, serge@hallyn.com, bauerman@linux.ibm.com,
        ebiggers@google.com, nayna@linux.ibm.com, dyoung@redhat.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Date:   Thu, 17 Jan 2019 20:08:04 -0500
In-Reply-To: <20190116101654.7288-1-kasong@redhat.com>
References: <20190116101654.7288-1-kasong@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19011801-4275-0000-0000-00000300B4F5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011801-4276-0000-0000-0000380EDB78
Message-Id: <1547773684.4026.10.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-17_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901180006
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-01-16 at 18:16 +0800, Kairui Song wrote:
> This patch series adds a .platform_trusted_keys in system_keyring as the
> reference to .platform keyring in integrity subsystem, when platform
> keyring is being initialized it will be updated. So other component could
> use this keyring as well.

Remove "other component could use ...".
> 
> This patch series also let kexec_file_load use platform keyring as fall
> back if it failed to verify the image against secondary keyring, make it
> possible to load kernel signed by third part key if third party key is
> imported in the firmware.

This is the only reason for these patches.  Please remove "also".

> 
> After this patch kexec_file_load will be able to verify a signed PE
> bzImage using keys in platform keyring.
> 
> Tested in a VM with locally signed kernel with pesign and imported the
> cert to EFI's MokList variable.

It's taken so long for me to review/test this patch set due to a
regression in sanity_check_segment_list(), introduced somewhere
between 4.20 and 5.0.0-rc1.  The sgement overlap test - "if ((mend >
pstart) && (mstart < pend))" - fails, returning a -EINVAL.

Is anyone else seeing this?

Mimi


> 
> Kairui Song (2):
>   integrity, KEYS: add a reference to platform keyring
>   kexec, KEYS: Make use of platform keyring for signature verify
> 
> Update from V2:
>   - Use IS_ENABLED in kexec_file_load to judge if platform_trusted_keys
>     should be used for verifying image as suggested by Mimi Zohar
> 
> Update from V1:
>   - Make platform_trusted_keys static, and update commit message as suggested
>     by Mimi Zohar
>   - Always check if platform keyring is initialized before use it
> 
> Kairui Song (2):
>   integrity, KEYS: add a reference to platform keyring
>   kexec, KEYS: Make use of platform keyring for signature verify
> 
>  arch/x86/kernel/kexec-bzimage64.c | 13 ++++++++++---
>  certs/system_keyring.c            | 22 +++++++++++++++++++++-
>  include/keys/system_keyring.h     |  5 +++++
>  include/linux/verification.h      |  1 +
>  security/integrity/digsig.c       |  6 ++++++
>  5 files changed, 43 insertions(+), 4 deletions(-)
> 

