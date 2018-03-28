Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2970238-1522262377-2-13281216311959435243
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522262376; b=gm+SkcCoJOZJLPfV19bfO6I2+tT0zaarzn//g8smihdHtjq
    OBDIlKwYMfXJCWTPsVdW3VgHI315pG6I5nqKo1LeDdvv8IsfYpgxKqcemZBC3m8K
    53BcCnES2/dXV/+/hJ6nhnSnqVW0nX7sO3Kfpfeo3pl0UQLCQxEtbSnFL9cehFWf
    BtGyPnXe+stkfHEm515rNXI27m8hqvKj43wFQam9Hc/oEAFBUXAr8pB/ZDPaWeW5
    KUKfVBrUWXOuzXRuEqZl7LdMB3sKFYlh5FirsqgbOJnZCMfg6B0y9zO5EnL0FiXP
    LPBKkcDQbMXyrVciaTWwhyZbyHjrcYfA5U3KZgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1522262376; bh=8D5TNGVLRfj4d9Xl5ODcvS8A+3CdF2LLk15P/p88lCc=; b=h
    u3MZIMYI8uz1c1Vqv4zob4Ez8K1/4Pdp+v/sOJgtiuYFmDZPGby6FIGbdvbmwm7U
    nms4bX2BJ6gGOqaN4wQ71yoOovc+uNzIdwAdmjf+pLleJRN+NeknOLZqLiDta2m5
    c7ZmKvxKoHOSUisWnSRSb3VGbHQPmzzaSnzOhEHEL4spdhuQGLbK1Lw4i0JxDYgI
    MDUTmdzN/e6ofXabPEcW59k3M8zSCmkl9iH+U5JYTMhPoyHvrviDFBUVv0lObYbw
    /5fDAVvU6/qwbgZ5oJHB0y/yyTr1ev2tOmAht4otfBqUI2sHpqFzpThz5omZQCYA
    TUPKK6T9OQQ51fDf9D5mQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lwn.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lwn.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lwn.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lwn.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLZBKXno4+AORvh/pRB/ahVz45gT0t2bfWO8ofGPXiYD1I0hQ4jWTI4NDpWzoLdJfF6AcuTjolciEoSrSzfyywNGT04tkRPZgO4OmeU0rWbplOvI44fk
    EMdOkv7mKFirPVpRCAWbZ8/1jSBrWnVd7xbd3EKTM6Ny8pDrdeOHXv50v31RN16HwcLmQdXn92ZCUaECvMrGQf/1vwQFNBll/X76YjFxhijwZaOHxcvZZ2cu
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=WFPa_J52YZO_DTh6f7kA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752670AbeC1SjQ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 14:39:16 -0400
Received: from ms.lwn.net ([45.79.88.28]:38324 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752349AbeC1SjP (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 28 Mar 2018 14:39:15 -0400
Date: Wed, 28 Mar 2018 12:39:12 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Richard Guy Briggs <rgb@redhat.com>
Cc: cgroups@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, luto@kernel.org, jlayton@redhat.com,
        carlos@redhat.com, viro@zeniv.linux.org.uk, dhowells@redhat.com,
        simo@redhat.com, eparis@parisplace.org, serge@hallyn.com,
        ebiederm@xmission.com, madzcar@gmail.com
Subject: Re: [RFC PATCH ghak32 V2 01/13] audit: add container id
Message-ID: <20180328123912.49b11c98@lwn.net>
In-Reply-To: <e284617ad667ad8f17958dd8babb87fe1b4d7205.1521179281.git.rgb@redhat.com>
References: <cover.1521179281.git.rgb@redhat.com>
        <e284617ad667ad8f17958dd8babb87fe1b4d7205.1521179281.git.rgb@redhat.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 16 Mar 2018 05:00:28 -0400
Richard Guy Briggs <rgb@redhat.com> wrote:

> Implement the proc fs write to set the audit container ID of a process,
> emitting an AUDIT_CONTAINER record to document the event.

A little detail, but still...

> +static int audit_set_containerid_perm(struct task_struct *task, u64 containerid)
> +{
> +	struct task_struct *parent;
> +	u64 pcontainerid, ccontainerid;
> +
> +	/* Don't allow to set our own containerid */
> +	if (current == task)
> +		return -EPERM;
> +	/* Don't allow the containerid to be unset */
> +	if (!cid_valid(containerid))
> +		return -EINVAL;

I went looking for cid_valid(), but it turns out you don't add it until
patch 5.  That, I expect, will not be good for bisectability (or patch
review).

Thanks,

jon
