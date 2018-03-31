Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-670115-1522462434-2-18017077094590097260
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522462434; b=D+DJC8w96TRduz/GdARxSk5uUz2nOcs1HDXAmyCkRUhaLUos5d
    INHm8upcYNYcil16KHSw9rAk7rMWCd0hEiynu1rXUc9YgfCM2kdhKNMvHjpuL0BS
    LYWoUrAbIqkw0wCrbkI86/niYvIXl9r/hU6bKHgNozKRSlDV7P0Nw/MLcT8ToEQX
    DknWi9ADKDBwhPMZbTRaysQbza4IXy/aW5xfpDOTyOsbcPdn7lSJwxA8J+tJmkIV
    5UwrrjjSKVq7z35ogrxP0Ww/m+MZgIOVmiA2/41Yy1166iN9KCunuTKNB3d6wCYz
    DkKnR1NWfdG5c1Sqqml4Gvet25ae9UcgXSnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:references:mime-version:content-type:sender:list-id;
    s=fm2; t=1522462434; bh=9OpKujlpUxh8ygsEn7CxVRd6ePb5m8npFF7mPw8
    px4A=; b=XapeX4l77M4BOoF0Z8yfLgLZcmctZffVDdku5DIxHdus+UgMnCk61QI
    AWlQPgiHyrstsS68H+jOUKgMMcpqP4Y/0ZO4oAyuFy7kXIyZ7npv6EBNTsGPyzU8
    loGBEY8Zb3Lek3xkPWosRNgYUmt+gQzv5VIZtiY03IdAAfTO00auttsltI9ZINcf
    p/8LaCvayRYuHTv0RDfnIbQPmaUOzfoG/FdfjFHvSMUhRQ5QDgyKzICEBAFT0Fy6
    kB+n3v32CWn/69VjEkwQL/HgiQc8omujBwmzioo8wb+2XXAUHbglGCKjU1akZluB
    jBWpjDKT1xqls2UxxuuZRwCgVoSOLuw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=namei.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=namei.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=namei.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=namei.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKQ7rpbU5f9eV1i8lPyVdhnZXDsKb9bDeRIWnd5P+jOHrkUnGF/LEL5Yp8ORmGNL9/DGpCDdWWVONb4yyjX/GOZxyRbDzT+ncZh2CM+EXSHAV3/ZtEUh
    L8O0CynZQzEt4iSCDfG2xvOCtyDF6yI9yUbjXRcB67PWaxDDpa2UIQlwY9flPwZkNi6de6J4YLj0W8KIdcw2DXw9WM5C1PnsAA6ayQ9iipqvl+0hz4T85O0m
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=PtDNVHqPAAAA:8 a=yMhMjlubAAAA:8 a=K6HrmWtEAAAA:8 a=VwQbUJbxAAAA:8
    a=89-5fGd9LYeIqbNbZbMA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=BpimnaHY1jUKGyF_4-AF:22 a=yV38gEssg_2GhkhKF82i:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752820AbeCaCNl (ORCPT <rfc822;greg@kroah.com>);
        Fri, 30 Mar 2018 22:13:41 -0400
Received: from namei.org ([65.99.196.166]:54632 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752784AbeCaCNk (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 30 Mar 2018 22:13:40 -0400
Date: Sat, 31 Mar 2018 13:13:22 +1100 (AEDT)
From: James Morris <jmorris@namei.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Linux Containers <containers@lists.linux-foundation.org>,
        esyr@redhat.com, jannh@google.com, khlebnikov@yandex-team.ru,
        linux-api@vger.kernel.org, serge.hallyn@ubuntu.com,
        linux-kernel@vger.kernel.org, prakash.sangappa@oracle.com,
        linux-security-module@vger.kernel.org, luto@kernel.org,
        oleg@redhat.com, akpm@linux-foundation.org,
        Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
        Pavel Emelyanov <xemul@openvz.org>
Subject: Re: [REVIEW][PATCH 12/11] ipc: Directly call the security hook in
 ipc_ops.associate
In-Reply-To: <877eq2m3or.fsf_-_@xmission.com>
Message-ID: <alpine.LRH.2.21.1803311313010.7769@namei.org>
References: <1520875093-18174-1-git-send-email-nagarathnam.muthusamy@oracle.com>        <87vadzqqq6.fsf@xmission.com>        <990e88fa-ab50-9645-b031-14e1afbf7ccc@oracle.com>        <877eqejowd.fsf@xmission.com>        <3a46a03d-e4dd-59b6-e25f-0020be1b1dc9@oracle.com>
        <87a7v2z2qa.fsf@xmission.com> <87vadmobdw.fsf_-_@xmission.com> <877eq2m3or.fsf_-_@xmission.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, 24 Mar 2018, Eric W. Biederman wrote:

> 
> After the last round of cleanups the shm, sem, and msg associate
> operations just became trivial wrappers around the appropriate security
> method.  Simplify things further by just calling the security method
> directly.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>


Reviewed-by: James Morris <james.morris@microsoft.com>


-- 
James Morris
<jmorris@namei.org>

