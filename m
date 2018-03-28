Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3460534-1522279978-5-11529175962701592380
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
    t=1522279978; b=Wcu+QjALQYslFmipMt1CBk4yo3RmL5NN8IlhZiLyd4yYhuQ
    mE9BL3U7KcGrPzf0u/dak74UTfhj841mYLXjLQzqF6IRpopM8TQnBxs8kfJbbIHZ
    A7nxiG0Y41iq8y8P1mf0OOMTilweseolQgC1nzFF/jhfv8STK3O5NATs4iv3XJzJ
    CS/rXx4vYkwS7+WLqDYL3NKXbwnZi76sJ7TEjAFu5w1cJLOiF6ap79rf87thwluE
    cIt8ocJv6bhgZqLnJeio3fgs6E18zSk5ONoTzIrUlDN61KiOH+tQ2rFQd4AnQ5CL
    ko/BbHZJleEWitefXsu7JheWeyaaVK1oEOENhbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1522279978; bh=+f1/+ougfqDGzNXo1h9DbYsKLA
    S6t961rjyAONZcx1g=; b=lQ4TAM4X9+Apn1bBVF6eHeZpibHtBeqditGQUCzv1b
    trtnxmbT3OgdDq9zurF9be8KdKuZemUBtigJfWukA//ly0H8CK07Fa9h/ivx6uwK
    r6S3ppKQ3B8PD4uqwl1xxbuVJbP01JjGiXHB2nN19XEcB3qnpNdjNJT7Jm956NS9
    RNU1NOAH2yYd0TTccw3vLY05AFrft7nItPSCat5G2GAUg6XpCgze8HxjMGIe6yNn
    Goma1L03dV6OPE0wiQSW/TFy8CKh/3e69U4VBmc8cu8rcBJCNur9PVu6KEIxffIG
    N+931/oJ1j6zrMuEI9GPVshsgN8CXlB7UYmWqj5tC5fA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=stgolabs.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=stgolabs.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfEHiQRDEwY06BBDSFI6FkoaJEJfIlyoWfPO4g8D0dLLxwxH+RMccERg6kNXGBdPM8EcrDUTtwbtSyfu9zACWvWOXMFHPRhjLr/Kdc9RMfaZJa1uw4q/2
    zpCh4uM23xd5U+jvYb92YHPHESTBxx+3iNIjHLNi9aj3VBvKAIjo0UH8WovXD74pDLT8Q/2NtNBNRxhwVBajhFUGBgSx5+F763sNODnTB6QG0rcqD17g7G16
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=VwQbUJbxAAAA:8 a=09SsB8v5pBiD9ELyA88A:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751113AbeC1Xcz (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 19:32:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:34688 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750971AbeC1Xcy (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 28 Mar 2018 19:32:54 -0400
Date: Wed, 28 Mar 2018 16:20:29 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        khlebnikov@yandex-team.ru, prakash.sangappa@oracle.com,
        luto@kernel.org, akpm@linux-foundation.org, oleg@redhat.com,
        serge.hallyn@ubuntu.com, esyr@redhat.com, jannh@google.com,
        linux-security-module@vger.kernel.org,
        Pavel Emelyanov <xemul@openvz.org>,
        Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
Subject: Re: [REVIEW][PATCH 01/11] sem/security: Pass kern_ipc_perm not
 sem_array into the sem security hooks
Message-ID: <20180328232029.k47nocmmahtxqmg2@linux-n805>
References: <87vadmobdw.fsf_-_@xmission.com>
 <20180323191614.32489-1-ebiederm@xmission.com>
 <bdf6ed62-b75c-1920-d5ce-ea08428d03d0@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <bdf6ed62-b75c-1920-d5ce-ea08428d03d0@schaufler-ca.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 23 Mar 2018, Casey Schaufler wrote:

>A kern_ipc_perm pointer is conventionally named isp in this code.

So the ideal name would be ipcp, used in core ipc, but I have no strong
preference over isp, ipp or whatever other name is used in LSMs. The
important thing is that kern_ipc_perm should not be called sma or any
ipc specific name.

>How about instead:

Agreed.

>
>-static int smack_sem_alloc_security(struct sem_array *sma)
>+static int smack_sem_alloc_security(struct kern_ipc_perm *isp)
> {
>-	struct kern_ipc_perm *isp = &sma->sem_perm;
>

Thanks,
Davidlohr
