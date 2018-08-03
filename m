Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81785C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 14:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4737821736
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 14:56:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4737821736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732411AbeHCQwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 12:52:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39808 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726115AbeHCQwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 12:52:47 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w73EtoAE005065
        for <linux-kernel@vger.kernel.org>; Fri, 3 Aug 2018 10:56:05 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kmrwmgsm9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 10:55:59 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 3 Aug 2018 15:55:15 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 3 Aug 2018 15:55:11 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w73EtB4E34472056
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 3 Aug 2018 14:55:11 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 51D2AAE051;
        Fri,  3 Aug 2018 17:55:09 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45C4BAE04D;
        Fri,  3 Aug 2018 17:55:08 +0100 (BST)
Received: from localhost.localdomain (unknown [9.80.98.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  3 Aug 2018 17:55:08 +0100 (BST)
Subject: Re: [PATCH 3/4] ima: add support for KEXEC_ORIG_KERNEL_CHECK
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Seth Forshee <seth.forshee@canonical.com>,
        Eric Richter <erichte@linux.vnet.ibm.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Justin Forbes <jforbes@redhat.com>
Date:   Fri, 03 Aug 2018 10:54:59 -0400
In-Reply-To: <20180803131129.GS3001@ubuntu-xps13>
References: <20180725233200.761-1-erichte@linux.vnet.ibm.com>
         <20180725233200.761-4-erichte@linux.vnet.ibm.com>
         <20180803131129.GS3001@ubuntu-xps13>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18080314-4275-0000-0000-000002A33DB0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080314-4276-0000-0000-000037AB5C4F
Message-Id: <1533308099.4337.424.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-03_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808030165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-08-03 at 08:11 -0500, Seth Forshee wrote:
> On Wed, Jul 25, 2018 at 06:31:59PM -0500, Eric Richter wrote:
> > IMA can verify the signature of kernel images loaded with kexec_file_load,
> > but can not verify images loaded with the regular kexec_load syscall.
> > Therefore, the appraisal will automatically fail during kexec_load when an
> > appraise policy rule is set for func=KEXEC_KERNEL_CHECK. This can be used
> > to effectively disable the kexec_load syscall, while still allowing the
> > kexec_file_load to operate so long as the target kernel image is signed.
> > 
> > However, this conflicts with CONFIG_KEXEC_VERIFY_SIG. If that option is
> > enabled and there is an appraise rule set, then the target kernel would
> > have to be verifiable by both IMA and the architecture specific kernel
> > verification procedure.
> > 
> > This patch adds a new func= for IMA appraisal specifically for the original
> > kexec_load syscall. Therefore, the kexec_load syscall can be effectively
> > disabled via IMA policy, leaving the kexec_file_load syscall able to do its
> > own signature verification, and not require it to be signed via IMA. To
> > retain compatibility, the existing func=KEXEC_KERNEL_CHECK flag is
> > unchanged, and thus enables appraisal for both kexec syscalls.
> 
> This seems like a roundabout way to disallow the kexec_load syscall.
> Wouldn't it make more sense to simply disallow kexec_load any time
> CONFIG_KEXEC_VERIFY_SIG is enabled, since it effectively renders that
> option impotent? Or has that idea already been rejected?

Agreed!  We can modify the "case LOADING_KEXEC_IMAGE" in
ima_load_data() to prevent the kexec_load based on
CONFIG_KEXEC_VERIFY_SIG.

The architecture specific policy would only include the IMA appraise
rule if CONFIG_KEXEC_VERIFY_SIG was not defined.

Mimi

