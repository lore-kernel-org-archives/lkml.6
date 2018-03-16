Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3366930-1521215702-2-7333215960164981580
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521215701; b=lq666odebUiwdIEJkGSNaDc7Ep5xU9uMtEq8vvSW/PKk7vt
    TOOtcGhPt24K+sFA2M1+YAeWNyUE32vNxw4btRQJJMhvwSOJL08e7qO0IzOZYg25
    1hQk4DB5jZm9d3xnj1VmD1msY5iXwfL0dlPfAhxqf3xXst6edEQ7MZbQpIL3y699
    ySPb15RknGhQf5nmV6w67rRKgYrhnHwvhi2YQtsmHxp/Mdb+AsTMNueYJRyysZpS
    Pd1zVWWme/bia0vgGnaUaAJYTq7Xfzta4nDqwklKqkPRWOBPTicVOAJJwxVuoBib
    /xYOwPva04f9P05CE4U5GVf22WWjwRzgxAhW4fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=to:cc:subject:from:references:date
    :in-reply-to:message-id:mime-version:content-type:sender
    :list-id; s=arctest; t=1521215701; bh=mW8iCI9s8HYMmb3OE5jEC7e8kI
    O4bkEza18PxOnIoPY=; b=mmPFwZjRt7NE+k4fzLkun3GECKGSJi3ypkDEBuC1Gt
    XGpnb4s/3WUUlxguz0zOnUDDoHmyVgiAdzTm06nRi+igZzVxuV4Q3b6cjVCqwnPz
    R8aQxZjsdg8NsqyI6+9kDi20DCPubKjW1p9fPKcKwdaokAJoAP8YZ4lgOn16roKj
    yIKzbNavwGVu3L+eyeQW1FYjep6Uwgm8+z74U5M02jNE0BzNeuyyEMIB57jly6qZ
    ffugVmf0LyPLOA/x4PIJTZ8ocdmeFsoq/hFCRs2AtdzL2kwURnDvvN+MKxrfqclr
    MrOEc5uDFMVPA9EtNnafAX1IQs0hX9k2mcYZfcJ1P3RA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=ZQjVxGNV x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=ZQjVxGNV x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965392AbeCPPyq (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:54:46 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:50280 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753521AbeCPPyh (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:54:37 -0400
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] libata: blacklist Micron 500IT SSD with MU01 firmware
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1521210819-9225-1-git-send-email-sudipm.mukherjee@gmail.com>
Date: Fri, 16 Mar 2018 11:54:30 -0400
In-Reply-To: <1521210819-9225-1-git-send-email-sudipm.mukherjee@gmail.com>
        (Sudip Mukherjee's message of "Fri, 16 Mar 2018 14:33:39 +0000")
Message-ID: <yq137106mo9.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8833 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=643
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803160153
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Sudip,

> While whitelisting Micron M500DC drives, the tweaked blacklist entry
> enabled queued TRIM from M500IT variants also. But these do not support
> queued TRIM. And while using those SSDs with the latest kernel we have
> seen errors and even the partition table getting corrupted.

> +	{ "Micron_M500IT_*",		"MU01",	ATA_HORKAGE_NO_NCQ_TRIM |
> +						ATA_HORKAGE_ZERO_AFTER_TRIM, },

Any reason to believe this deficiency is limited to MU01 firmware?

-- 
Martin K. Petersen	Oracle Linux Engineering
