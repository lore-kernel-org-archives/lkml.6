Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3704688-1522286706-2-4990150429918279273
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522286706; b=A5cedkGsSi4rXTc8EnuPBg36m2kDRMU7JDTJ0yjD4gSFpJc
    8yiIddOdllEwnsF0e1oNOymh1vOcqnZgnBOUoVhyG1qW3BYw6jsIcQV/U2FJiWus
    DDZkVKB74tl0WcsoU6Dj9SEEwJE8wc/91BoytldG5CHHBxaWG2YcFI68Kl1AtFMP
    BnKCdOIL/uLEZspLJ/y7tr6pPNPs6iYz7zPKH3O/O9xOXpLMuxDs5zF9kyohBd9j
    UHxuVLPQExOzH9qFHsIpcjwSurozsOSsDb7K5POzv8ab7oGeRUkhfl3mLIsXS/y8
    cNEDSPy/Wn3CrAg5//473gM5AeCb/OVaRzQkIZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1522286706; bh=a+sSptL5rqAE1uAjWOSyPiSzkl
    p8tKDO5LI4MnNxziw=; b=OGyIsIIcbw41uZT4pdo1W/R8v2Vmedse6jrSWLqXWI
    B3YVdXx/in6vPXUb/fZHPVtsl7EO814vNWhzpC9BF4os5s7qUK5oalkpcAIBjOXa
    HmytJDJFBbzsJ2mUK5LttKQAfCEm3gw3h3eopFkdfl21dDChAgB0EQ8UcZeXz4JQ
    UvUUrcE+JWb7k8Unmrj8t3PAHkrZpWUqKSB0hnOgBrqR5+mQVUuTa9/j6KL8fSt5
    jrZwfy67NQ07LgRZXkCASV1BCFAqXRiOxHqGLKm8hm0hBLqxr0ZntYTOITdXVPvr
    N2fLMeXwtVBbofy5O2jz0IElN5Drh6gMIZ4xdFDF5wHw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=stgolabs.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=stgolabs.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=stgolabs.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=stgolabs.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLygKx5s3UKfvWZS+g9nwTxXjN2seiebUizcLdyl6HT6wFCEDLCcLiGIOvL/pDLS5zzDhJHrBk3aMUIc7i2KkYv7DmYp4+onE0zrBXkUdDR03YOOsGjN
    OIQOLH7y7dYT1YYlupt5XIsE+VgUrozapZ+c5DO2PtrB7bbEC5nydZ1E8v9N7X0kAjOXvdIwTnMBB28DHfBKdaQiT46/NiT4mHgF/J97LJjaC0Ps4mlClneL
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=VwQbUJbxAAAA:8 a=fUSZZkATYxXnQMecnGkA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751113AbeC2BZD (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 21:25:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:44757 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750971AbeC2BZD (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 28 Mar 2018 21:25:03 -0400
Date: Wed, 28 Mar 2018 18:12:41 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linux Containers <containers@lists.linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        khlebnikov@yandex-team.ru, prakash.sangappa@oracle.com,
        luto@kernel.org, akpm@linux-foundation.org, oleg@redhat.com,
        serge.hallyn@ubuntu.com, esyr@redhat.com, jannh@google.com,
        linux-security-module@vger.kernel.org,
        Pavel Emelyanov <xemul@openvz.org>,
        Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
Subject: Re: [REVIEW][PATCH 00/11] ipc: Fixing the pid namespace support
Message-ID: <20180329011241.v5kgiwbbayz425hk@linux-n805>
References: <1520875093-18174-1-git-send-email-nagarathnam.muthusamy@oracle.com>
 <87vadzqqq6.fsf@xmission.com>
 <990e88fa-ab50-9645-b031-14e1afbf7ccc@oracle.com>
 <877eqejowd.fsf@xmission.com>
 <3a46a03d-e4dd-59b6-e25f-0020be1b1dc9@oracle.com>
 <87a7v2z2qa.fsf@xmission.com>
 <87vadmobdw.fsf_-_@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87vadmobdw.fsf_-_@xmission.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 23 Mar 2018, Eric W. Biederman wrote:

>Still I would like to see this fixed and I plan on merging this code.

Yes, it needs fixed, but 1) there are pending issues (such as the extra atomics)
and 2) its late in the -rc cycle. Plus this issue has existed for 11 years without
the world ending, so I'm sure we can hold on until at least one more release.

Thanks,
Davidlohr
