Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_SBL,URIBL_SBL_A autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE377C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77F5B20989
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:46:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77F5B20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbeK2Cs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 21:48:58 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56086 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728821AbeK2Cs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 21:48:56 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wASFilhf008695
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 10:46:50 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2p1vrg41ue-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 10:46:49 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 28 Nov 2018 15:46:46 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 28 Nov 2018 15:46:41 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wASFkeQK29294720
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 28 Nov 2018 15:46:40 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C7250AE04D;
        Wed, 28 Nov 2018 15:46:40 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 20D1EAE051;
        Wed, 28 Nov 2018 15:46:39 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.103.235])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 28 Nov 2018 15:46:38 +0000 (GMT)
Subject: Re: [PATCH 5/7] efi: Import certificates from UEFI Secure Boot
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Nayna Jain <nayna@linux.ibm.com>,
        Josh Boyer <jwboyer@fedoraproject.org>,
        linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        jforbes@redhat.com, seth.forshee@canonical.com,
        kexec@lists.infradead.org, keyrings@vger.kernel.org,
        vgoyal@redhat.com, ebiederm@xmission.com, mpe@ellerman.id.au
Date:   Wed, 28 Nov 2018 10:46:28 -0500
In-Reply-To: <20181125151500.8298-6-nayna@linux.ibm.com>
References: <20181125151500.8298-1-nayna@linux.ibm.com>
         <20181125151500.8298-6-nayna@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18112815-0020-0000-0000-000002EF1678
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112815-0021-0000-0000-0000213E712A
Message-Id: <1543419988.3902.216.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-28_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811280138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-11-25 at 20:44 +0530, Nayna Jain wrote:
> From: Josh Boyer <jwboyer@fedoraproject.org>
> 
> New Patch Description:
> ======================
> 
> Secure Boot stores a list of allowed certificates in the 'db' variable.
> This patch imports those certificates into the platform keyring. The shim
> UEFI bootloader has a similar certificate list stored in the 'MokListRT'
> variable. We import those as well.
> 
> Secure Boot also maintains a list of disallowed certificates in the 'dbx'
> variable. We load those certificates into the system blacklist keyring
> and forbid any kernel signed with those from loading.
> 
> Original Patch Description:
> ============================
> 
> Secure Boot stores a list of allowed certificates in the 'db' variable.
> This imports those certificates into the system trusted keyring.  This
> allows for a third party signing certificate to be used in conjunction
> with signed modules. By importing the public certificate into the 'db'
> variable, a user can allow a module signed with that certificate to
> load. The shim UEFI bootloader has a similar certificate list stored
> in the 'MokListRT' variable. We import those as well.
> 
> Secure Boot also maintains a list of disallowed certificates in the 'dbx'
> variable. We load those certificates into the newly introduced system
> blacklist keyring and forbid any module signed with those from loading and
> forbid the use within the kernel of any key with a matching hash.
> 
> This facility is enabled by setting CONFIG_LOAD_UEFI_KEYS.

There are quite a few checkpatch.pl warnings that need to be
addressed, including the missing SPDX license.

Mimi

