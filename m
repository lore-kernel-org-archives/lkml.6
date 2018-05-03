Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1767633-1525317279-2-2271115344507619911
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525317278; b=Q4ejBww4zHtkbguHmZcAUji7Er2T++QhqRIMwd9NRKBK7eLEwE
    EsZAwDcuXwzRgVfq7XCNSku3/11WSCsz46UkJDz6FyPqoKaL2+q4yBkBJh8C3IRu
    b789O2cOFSkODG9qZ7oVnbKq1Mv0CnhkszKdGKBxuog7wZ/kyV1TiFMKBm64SGu7
    E7E6P5CdVf1ZScsMXz9ybSt+b1CWCqNuao3N51i+0EptNjkVHXRaevMFZG43WJAY
    aygyid2QAhR7zOyOdk3m+36Q+l5vPqWeReCFnjG5r+JPtB93UwQFGFYfiEenPcFo
    WnTHgb9trwvkNCXP6bnDydcR1/LA9jMBjTxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=to:cc:subject:from:references:date
    :in-reply-to:message-id:mime-version:content-type:sender
    :list-id; s=fm2; t=1525317278; bh=fxZudmGtRqte4U10+h+GFhf/ghCzLQ
    d2GJIF1NxsBZI=; b=R3Lo81dakYmRh/C7JotZfOlQlXGAt1yotzjUOFTqcDdkkg
    dxJyhcuEgOXcrlfRnj4TMGIakydeCyjylYdlgJXM/NVW/++eZ9tiLHPG+NJuhlaC
    CJq8oLzgzOACv9aISRBiFUMklw1T4Sc+4u+qUScrb6Gy+Ad696hBxvud876bxHbd
    nR7PDYJ/ZEE/qBmWj94psauCwiGVjI7aHsEZCCNi+3H+Xf+6gjG5DKkYRylsda8h
    o4uP3cSRECXlfLxyZCWZEnLW/XZsjYX1ICh23H9VCQ5T5JDvJi9Qu1Mdc0DUfhuv
    9ZzZS+5I9RcFG6gcLPyUra17ajhq3MF8GzUZfgOg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com
    header.i=@oracle.com header.b=dHhJAe6y x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com
      header.i=@oracle.com header.b=dHhJAe6y x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIfSvkQaUM/8DLkxHdVZmGtyeeWcWm2msfp/L8XqMSLR7a1Dq32YnkLGQEyoPk+6Q0CpGx/cEDkdKalXBLycGzYolXFLdRrxFSasBxtfA3hWGoS0vd1J
    DWclxzvsnAqnzz7hjIfOq2iFYayxpgVRXfOdmkJGWaYOFJ/H5uNltfhfmuVeiKyn1z5By2dMglbxze8G3i2ZosrVLGrJUHtFqgpiw5N25f54hbZDXoKwzPqm
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=OLL_FvSJAAAA:8
    a=mNNkpRWBsY0LLLdI38EA:9 a=haRAhhrbeAoA:10 a=F5WLKBdkEQcA:10 a=wbbTpC8Z_7cA:10
    a=oIrB72frpwYPwTMnlWqB:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752033AbeECDOf (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 23:14:35 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57212 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752011AbeECDOd (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 2 May 2018 23:14:33 -0400
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] libata: blacklist Micron SSD
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180429160138.11091-1-sudip.mukherjee@codethink.co.uk>
        <yq1r2mw83cu.fsf@oracle.com> <20180502215950.GA4621@sudip-laptop>
Date: Wed, 02 May 2018 23:14:24 -0400
In-Reply-To: <20180502215950.GA4621@sudip-laptop> (Sudip Mukherjee's message
        of "Wed, 2 May 2018 22:59:50 +0100")
Message-ID: <yq1muxh4ei7.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8881 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=372
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805030027
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Sudip,

>> I think my preference would be to blacklist M500IT with the MU01
>> firmware (which Micron said was affected) and rely on the "Micron*"
>> fallthrough further down for the rest.
>
> This patch was based on your reply at:
> https://www.spinics.net/lists/linux-ide/msg55370.html

Yep, but they have confirmed it's only that model and firmware rev
that's affected. I just haven't gotten the comprehensive matrix of all
current models and firmware revs I was hoping for.

-- 
Martin K. Petersen	Oracle Linux Engineering
