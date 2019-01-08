Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B201C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 381492087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbfAHOcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 09:32:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44258 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728306AbfAHOcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 09:32:10 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x08EUBDg146716
        for <linux-kernel@vger.kernel.org>; Tue, 8 Jan 2019 09:32:09 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pvtpbt8n7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 09:32:09 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 8 Jan 2019 14:32:06 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 8 Jan 2019 14:32:03 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x08EW2ZD57475100
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Jan 2019 14:32:02 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 01B6211C04A;
        Tue,  8 Jan 2019 14:32:02 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B1AC11C052;
        Tue,  8 Jan 2019 14:32:00 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.90.168])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  8 Jan 2019 14:32:00 +0000 (GMT)
Subject: Re: [RFC PATCH 0/1] KEYS, integrity: Link .platform keyring to
 .secondary_trusted_keys
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Kairui Song <kasong@redhat.com>, linux-kernel@vger.kernel.org
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        jwboyer@fedoraproject.org, keyrings@vger.kernel.org,
        jmorris@namei.org, serge@hallyn.com, bauerman@linux.ibm.com,
        ebiggers@google.com, nayna@linux.ibm.com, dyoung@redhat.com
Date:   Tue, 08 Jan 2019 09:31:49 -0500
In-Reply-To: <20190108081247.2266-1-kasong@redhat.com>
References: <20190108081247.2266-1-kasong@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19010814-0028-0000-0000-00000335FC35
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010814-0029-0000-0000-000023F309BA
Message-Id: <1546957909.19931.101.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-08_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901080120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-01-08 at 16:12 +0800, Kairui Song wrote:
> Hi, as the subject, this is a patch that links the new introduced
> .platform keyring into .secondary_trusted_keys keyring. This is
> mainly for the kexec_file_load, make kexec_file_load be able to verify
> the kernel image agains keys provided by platform or firmware.
> kexec_file_load already could verify the image agains secondary_trusted_keys
> if secondary_trusted_keys exits, so this will make kexec_file_load be ware
> of platform keys as well.

The builtin and secondary keyrings have a signature change of trust
rooted in the signed kernel image.  Adding the pre-boot keys to the
secondary keyring breaks that signature chain of trust.

Mimi

> 
> This may also useful for things like module sign verify that are using
> secondary_trusted_keys. I'm not sure if it will be better to move the
> INTEGRITY_PLATFORM_KEYRING to certs/ and let integrity subsystem use
> the keyring there, so just linked the .platform keyring into kernel's
> .secondary_trusted_keys keyring.
> 
> It workd for my case, tested in a VM, I signed the kernel image locally
> with pesign and imported the cert to EFI's MokList variable.
> 
> Kairui Song (1):
>   KEYS, integrity: Link .platform keyring to .secondary_trusted_keys
> 
>  certs/system_keyring.c          | 30 ++++++++++++++++++++++++++++++
>  include/keys/platform_keyring.h | 12 ++++++++++++
>  security/integrity/digsig.c     |  7 +++++++
>  3 files changed, 49 insertions(+)
>  create mode 100644 include/keys/platform_keyring.h
> 

