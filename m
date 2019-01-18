Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46299C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 11:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 192F42087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 11:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbfARLyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 06:54:17 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47550 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726782AbfARLyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 06:54:16 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0IBdMfd071418
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 06:54:15 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q3aj80xrb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 06:54:14 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 18 Jan 2019 11:54:10 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 18 Jan 2019 11:54:07 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0IBs56a59048022
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Jan 2019 11:54:05 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6921642042;
        Fri, 18 Jan 2019 11:54:05 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B9F8242045;
        Fri, 18 Jan 2019 11:54:03 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.91.65])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 18 Jan 2019 11:54:03 +0000 (GMT)
Subject: Re: [PATCH v4 0/2] let kexec_file_load use platform keyring to
 verify the kernel image
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Kairui Song <kasong@redhat.com>, linux-kernel@vger.kernel.org
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        jwboyer@fedoraproject.org, keyrings@vger.kernel.org,
        jmorris@namei.org, serge@hallyn.com, bauerman@linux.ibm.com,
        ebiggers@google.com, nayna@linux.ibm.com, dyoung@redhat.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Date:   Fri, 18 Jan 2019 06:53:52 -0500
In-Reply-To: <20190118091733.29940-1-kasong@redhat.com>
References: <20190118091733.29940-1-kasong@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19011811-0008-0000-0000-000002B2C5B1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011811-0009-0000-0000-0000221EE67C
Message-Id: <1547812432.3982.55.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-18_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901180088
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-01-18 at 17:17 +0800, Kairui Song wrote:
> This patch series adds a .platform_trusted_keys in system_keyring as the
> reference to .platform keyring in integrity subsystem, when platform
> keyring is being initialized it will be updated. So other component could
> use this keyring as well.

Kairui, when people review patches, the comments could be specific,
but are normally generic.  My review included a couple of generic
suggestions - not to use "#ifdef" in C code (eg. is_enabled), use the
term "preboot" keys, and remove any references to "other components".

After all the wording suggestions I've made, you are still saying, "So
other components could use this keyring as well".  Really?!  How the
platform keyring will be used in the future, is up to you and others
to convince Linus.  At least for now, please limit its usage to
verifying the PE signed kernel image.  If this patch set needs to be
reposted, please remove all references to "other components".

Dave/David, are you ok with Kairui's usage of "#ifdef's"?  Dave, you
Acked the original post.  Can I include it?  Can we get some
additional Ack's on these patches?

thanks!

Mimi


> 
> This patch series also let kexec_file_load use platform keyring as fall
> back if it failed to verify the image against secondary keyring, make it
> possible to load kernel signed by keys provides by firmware.
> 
> After this patch kexec_file_load will be able to verify a signed PE
> bzImage using keys in platform keyring.
> 
> Tested in a VM with locally signed kernel with pesign and imported the
> cert to EFI's MokList variable.
> 
> To test this patch series on latest kernel, you need to ensure this commit
> is applied as there is an regression bug in sanity_check_segment_list():
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=993a110319a4a60aadbd02f6defdebe048f7773b
> 
> Update from V3:
>   - Tweak and simplify commit message as suggested by Mimi Zohar
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

