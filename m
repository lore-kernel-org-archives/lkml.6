Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487F6C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04FFC2085B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:20:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04FFC2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbeJHSb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 14:31:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42312 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726712AbeJHSb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 14:31:59 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w98BJPow058528
        for <linux-kernel@vger.kernel.org>; Mon, 8 Oct 2018 07:20:43 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n05up98vm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 07:20:43 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 8 Oct 2018 12:20:41 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 8 Oct 2018 12:20:38 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w98BKbqn197054
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 8 Oct 2018 11:20:37 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AEBF8A4057;
        Mon,  8 Oct 2018 14:20:11 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 80064A4053;
        Mon,  8 Oct 2018 14:20:10 +0100 (BST)
Received: from localhost.localdomain (unknown [9.80.101.74])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  8 Oct 2018 14:20:10 +0100 (BST)
Subject: Re: [PATCH v5 0/6] Add support for architecture specific IMA
 policies
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Nayna Jain <nayna@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        jforbes@redhat.com, seth.forshee@canonical.com,
        kexec@lists.infradead.org, Nayna Jain <nayna@linux.ibm.com>
Date:   Mon, 08 Oct 2018 07:20:25 -0400
In-Reply-To: <20181005174015.21939-1-nayna@linux.vnet.ibm.com>
References: <20181005174015.21939-1-nayna@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18100811-0028-0000-0000-0000030402DC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100811-0029-0000-0000-000023BE4EAD
Message-Id: <1538997625.15382.87.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-08_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=938 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810080113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-10-05 at 23:10 +0530, Nayna Jain wrote:
> From: Nayna Jain <nayna@linux.ibm.com>
> 
> The architecture specific policy, introduced in this patch set, permits
> different architectures to define IMA policy rules based on kernel
> configuration and system runtime information.
> 
> For example, on x86, there are two methods of verifying the kexec'ed kernel
> image signature - CONFIG_KEXEC_VERIFY_SIG and IMA appraisal policy
> KEXEC_KERNEL_CHECK. CONFIG_KEXEC_VERIFY_SIG enforces the kexec_file_load
> syscall to verify file signatures, but does not prevent the kexec_load
> syscall. The IMA KEXEC_KERNEL_CHECK policy rule verifies the kexec'ed
> kernel image, loaded via the kexec_file_load syscall, is validly signed and
> prevents loading a kernel image via the kexec_load syscall. When secure
> boot is enabled, the kexec'ed kernel image needs to be signed and the
> signature verified. In this environment, either method of verifying the
> kexec'ed kernel image is acceptable, as long as the kexec_load syscall is
> disabled.
> 
> The previous version of this patchset introduced a new IMA policy rule to
> disable the kexec_load syscall, when CONFIG_KEXEC_VERIFY_SIG was enabled,
> however that is removed from this version by introducing a different
> mechanism, as described below.
> 
> The patchset defines an arch_ima_get_secureboot() function to retrieve the
> secureboot state of the system. If secureboot is enabled and
> CONFIG_KEXEC_VERIFY_SIG is configured, it denies permission to kexec_load
> syscall.
> 
> To support architecture specific policies, a new function
> arch_get_ima_policy() is defined. This patch set defines IMA
> KERNEL_KEXEC_POLICY rules for x86 *only* if CONFIG_KEXEC_VERIFY_SIG is
> disabled and secure boot is enabled.
> 
> This patch set includes a patch, which refactors ima_init_policy() to
> remove code duplication.

Other than a couple of #ifdef's in .c files, which should be converted
to use IS_ENABLED(<config-option>), the patch set is looking really
good.

thanks!

Mimi

