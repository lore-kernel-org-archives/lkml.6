Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9182AC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68B9B206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:22:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbfAITWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 14:22:32 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47308 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728173AbfAITWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 14:22:31 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x09J8SC1053228
        for <linux-kernel@vger.kernel.org>; Wed, 9 Jan 2019 14:22:30 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pwn7pn7f7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 14:22:30 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 9 Jan 2019 19:22:28 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 9 Jan 2019 19:22:24 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x09JMMx49633820
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jan 2019 19:22:22 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ABB85AE045;
        Wed,  9 Jan 2019 19:22:22 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E8F84AE057;
        Wed,  9 Jan 2019 19:21:31 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.105.240])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  9 Jan 2019 19:21:31 +0000 (GMT)
Subject: Re: [RFC PATCH 1/2] integrity, KEYS: add a reference to platform
 keyring
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Kairui Song <kasong@redhat.com>, linux-kernel@vger.kernel.org
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        jwboyer@fedoraproject.org, keyrings@vger.kernel.org,
        jmorris@namei.org, serge@hallyn.com, bauerman@linux.ibm.com,
        ebiggers@google.com, nayna@linux.ibm.com, dyoung@redhat.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Date:   Wed, 09 Jan 2019 14:21:11 -0500
In-Reply-To: <20190109164824.19708-2-kasong@redhat.com>
References: <20190109164824.19708-1-kasong@redhat.com>
         <20190109164824.19708-2-kasong@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19010919-0028-0000-0000-00000336AB22
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010919-0029-0000-0000-000023F3BD09
Message-Id: <1547061671.19931.239.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-09_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901090157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-01-10 at 00:48 +0800, Kairui Song wrote:
> Currently kexec_file_load will verify the kernel image being loaded
> against .builtin_trusted_keys or .secondary_trusted_keys, but the
> image could be signed with third part keys which will be provided by
> platform or firmware and the keys won't be available in keyrings mentioned
> above.
> 
> After commit ea93102f3224 ('integrity: Define a trusted platform keyring')
> a .platform keyring is introduced to store the keys provided by platform
> or firmware. And with a few following commits, now keys required to verify
> the image is being imported to .platform keyring, but currently, only
> IMA-appraisal could use the keyring and verify the image.
> 
> This patch exposes the .platform and makes other components, like
> kexec_file_load, could use this .platform keyring to verify the
> kernel image.

The "platform" keyring was upstreamed in order to verify the kernel
image being loaded by the kexec_file_load syscall.  The intentions of
this patch description needs to be clearer.

> 
> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Kairui Song <kasong@redhat.com>
> ---
>  certs/system_keyring.c        | 3 +++
>  include/keys/system_keyring.h | 5 +++++
>  security/integrity/digsig.c   | 4 ++++
>  3 files changed, 12 insertions(+)
> 
> diff --git a/certs/system_keyring.c b/certs/system_keyring.c
> index 81728717523d..a61b95390b80 100644
> --- a/certs/system_keyring.c
> +++ b/certs/system_keyring.c
> @@ -24,6 +24,9 @@ static struct key *builtin_trusted_keys;
>  #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
>  static struct key *secondary_trusted_keys;
>  #endif
> +#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
> +struct key *platform_trusted_keys;

Please make it static.

Mimi

> +#endif

