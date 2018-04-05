Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3756588-1522960593-3-9467889621222036958
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522960593; b=oZe5HuB/n3IwoKe8f/Vxq3F3HLpVpdBnF5H46OqJsmq3KcpCE1
    02+7kC0N0DuBRCs7fJYy2V4lcKb97IHWUe5rz8v3MhZj/fLguP7jPKns70IBgAYO
    iriQHCuscZwqenzocLL6azuILmGXyFYJds3py0Xe7DtBLj6jKYFmoJfopno5anZk
    swn5NECBilfgYjH0lELzN2FZByppM3NqrL6bnar+VGmU5OXf44WMWVI1bWpnCNNP
    FMZee4VTX8prmGwoJ+UDFXS9FNsLUZmENY+2wnCmrRgcD658aEajA9V8ezKEdrGz
    RVwnZzZhuHR+ouJHBf0TYUfPD0DsOtVevIPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=to:cc:subject:from:references:date
    :in-reply-to:message-id:mime-version:content-type:sender
    :list-id; s=fm2; t=1522960593; bh=R40dH2aoHQXot7g0ATlkdUbW+SJxYE
    t0a4y2BLTQY1w=; b=SXHJXXczdi9YM6ImTCUlgYVvIhfxTHs7ykazsHxhrrtMNI
    KUlXSlGsqGV4tcHHpJ+6R0O0z29vFT0osRw8vOPCQS9TmhEHBtK1p9lpmVQcHs6G
    e2+JzUKJeOpu5gHswkLyMm/H9jBc3i4fIm09HQgohYy1m0YJGnIfRSYLRrizS+Xw
    ZC08JzBSuj5dti/1VxcKldPBztbt38kM00Xlp/yKxaqJ//f4heq1z0r4NrRfTf0b
    SU6bz2oPXR0PAnw5yd6kx/GKezhKb8WaPrefwJrq66B0qdZrtXEkPRYHk8b9b6Ig
    bSLDqBp8EdumbChkIiRBa1yUejsjhM2W4k/7oLlA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=OLtGi62+ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=OLtGi62+ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOx45Fp10qkh5kqDwr/nYwbxzfDvq/slvF4vQw5c3r0/EjygjUzYTF1GnZ8rhm0rycPtODieRNhM29WabMj1IMUmM8HH4M1sYLFFOc0UJOhsB+EvSnrF
    5JZ7CPvVda8wssFxE7U8tH304GF44QMBJTtAKg2a6qnKc5eiMr00TNn7DbuYVXtUFVSmZqW44oBf3fSDEuql9TDmJtmhz2oPnlkPi+jbjSpGsX9Q6U3AzHD1
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=nzVRBA7Fi7FiwyCkLqUA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753645AbeDEUgW (ORCPT <rfc822;greg@kroah.com>);
        Thu, 5 Apr 2018 16:36:22 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:35702 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751558AbeDEUgT (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 5 Apr 2018 16:36:19 -0400
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] libata: blacklist Micron 500IT SSD with MU01 firmware
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1521210819-9225-1-git-send-email-sudipm.mukherjee@gmail.com>
        <yq137106mo9.fsf@oracle.com> <20180316205559.GA29406@sudip-laptop>
        <yq1y3ir668q.fsf@oracle.com> <20180405203239.GA20090@sudip-laptop>
Date: Thu, 05 Apr 2018 16:36:13 -0400
In-Reply-To: <20180405203239.GA20090@sudip-laptop> (Sudip Mukherjee's message
        of "Thu, 5 Apr 2018 21:32:39 +0100")
Message-ID: <yq1po3d8k76.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8854 signatures=668697
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=525
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804050203
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Sudip,

> Any reply from Micron yet?

No, let me poke them again.

> It might be better and safe to blacklist all Micron SSDs except M500DC
> and M500IT (with MG02 firmware) until Micron replies.

Yeah, let's do that if I don't hear back within a day or two.

-- 
Martin K. Petersen	Oracle Linux Engineering
