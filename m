Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4022873-1521236991-2-11644681674767904072
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
    t=1521236991; b=YvmUYAGWtXAXAbB1k+/hvD1K0vEEedSzJSWTiPOmQv1sEyB
    OT4cprvCDyURESRUeMFBZXFMGDN0Xy50+/y5uiEw+3XEC2oqSTWrERlBArurxke2
    Twa83PYS9HdBrVz9Y8sin/T06wgGqxiEUmD9WYuIz6NtKgf4yHkyAiHc7GwXcrE5
    Stn+Vfw68A0+nn5TvJ0x8FA3W4L+Ndz38XzhT6Yi71lTFD/arwRGzVkPd+yMEHz1
    18DeY86zAmh2oQ3vj7RZcHd2EkwX372ahsPauEan2mbXPgnD/KU1fdXGsbIF1CDI
    McDQ0KkrbDcrSKXfEVqsSBROwxU8K/1mRpYDdmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=to:cc:subject:from:references:date
    :in-reply-to:message-id:mime-version:content-type:sender
    :list-id; s=arctest; t=1521236991; bh=yuDp4bV+VZ8BuVGGKftPH8I7oZ
    GoiDzuI+Yb0bXOzwE=; b=DRLUuyARCkRytsCjXvAd9ZvcWuoQTVsyuuoFrFfreK
    YfqCY4zAze4be3RMZ2AtKMPC8C9W5rwPz9FTyQdrZskpsd6lSBQapPoTegnqf7W5
    n8pZQnFjWa50fUWjyn7cVQBxuqVqj5TnRnJmZtQzOjgUxQHNW4ELKOig/fURy6Rq
    bEYfYzMCKCe7pwqsfiwOugR59TPBZS+F9vvlob1jh64AiRQIJr6B/rnfVGbKELWY
    WpUzZGzY9n7gWb3K5lCK9XC5I0DKve07X6IdIKFVfN+XmEDq+mbVVjW718UAk2tk
    Mc78yWkK8Y9Drv3ISFat1/wOTMGOCoh6ER17cjfxtMcg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=N5UMdDoT x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=N5UMdDoT x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751724AbeCPVtf (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 17:49:35 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36124 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751753AbeCPVtc (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 17:49:32 -0400
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] libata: blacklist Micron 500IT SSD with MU01 firmware
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1521210819-9225-1-git-send-email-sudipm.mukherjee@gmail.com>
        <yq137106mo9.fsf@oracle.com> <20180316205559.GA29406@sudip-laptop>
Date: Fri, 16 Mar 2018 17:49:25 -0400
In-Reply-To: <20180316205559.GA29406@sudip-laptop> (Sudip Mukherjee's message
        of "Fri, 16 Mar 2018 20:55:59 +0000")
Message-ID: <yq1y3ir668q.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8833 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=606
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803160153
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Sudip,

>> Any reason to believe this deficiency is limited to MU01 firmware?
>
> Not really. But we also use MG02 firmware and afaik, Micron has
> confirmed that MG02 is a fixed one.  I have only mentioned MU01 as I
> know it has the problem.

Let me ask...

-- 
Martin K. Petersen	Oracle Linux Engineering
