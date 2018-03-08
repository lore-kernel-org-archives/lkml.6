Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3120443-1520553224-2-8170138431595313893
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520553223; b=JJf9uqaNil7/LoD4o1m728nlxy2tPh8DXqYvejbRnyeX4ff
    9oZNv2LF3g+3pG471Wxp2v9gynNTfT8LH128IwwU6CkpQyFeZUPcwK9yTOIUlee+
    CDKNYdCpd/+AJPk30h0wo9TEEVfcqEbWoYnqjF8o6qUhcIuJFhDlr3DvgKlwjacJ
    F60nOp9RRKKqA6FzTh3yjl4Ud5DB5bC+PEGNrxVMbOoi3bE5ykmtMYkVVEbe8dh8
    TGdpUuvYUNdDL3d+Qo+RKkSHI3o6DGUhXSPML6C0oASgQvlxgMRzwbuAvX4+kcuc
    V+fLmJVPMxtw3N4tsJ3Tp4ZlrXHpESgIYFyG6Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520553223; bh=Ln7wsyfqGHHBB/HoMvEmCa1olYgfXsGUjQdnpRQVbRg=; b=N
    F+gCG3ukEE7JDnoOXD45iSCdiHejPas3L9cds7MtVSikzVciceosXyyuGjeazzKm
    xMUvSsJVhq3VhD1BXwVXhBba1ov64HPMdXbcxXtNVhXg5HaYiDiQGh96gf7+Bd5i
    yEjal4h1vb8n4SMDgU71Qrn8emkS3iU+iVPrvhmQxdtloJ0N2AVgC17k+hMhvIHu
    av36rjQvn3XI1qnUXnlcdVwFvVSynLT4kEidckE7RxxBfCiNVY2JQJmYJLamgkWU
    OpRJfdne3rQ/BRknfdZscHaBd+98/o9zuGGdmiHLO9NovE0rR4hWW+GPBOmUSCAV
    Q2I3/aW99TRyKMaAM4ofA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751237AbeCHXxm (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 18:53:42 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:50328 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751235AbeCHXxl (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Mar 2018 18:53:41 -0500
Date: Thu, 8 Mar 2018 15:53:39 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Mike Kravetz <mike.kravetz@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        bugzilla-daemon@bugzilla.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Nic Losby <blurbdust@gmail.com>,
        Yisheng Xie <xieyisheng1@huawei.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] hugetlbfs: check for pgoff value overflow
Message-Id: <20180308155339.de99d2ddde514e3980e3ef96@linux-foundation.org>
In-Reply-To: <a5e3c0c4-d41e-6ffd-935d-63cce2527d0f@oracle.com>
References: <20180306133135.4dc344e478d98f0e29f47698@linux-foundation.org>
        <20180308210502.15952-1-mike.kravetz@oracle.com>
        <20180308141533.d16e43f5f559215089e522ae@linux-foundation.org>
        <a5e3c0c4-d41e-6ffd-935d-63cce2527d0f@oracle.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 8 Mar 2018 15:37:57 -0800 Mike Kravetz <mike.kravetz@oracle.com> wrote:

> Here are a couple options for computing the mask.  I changed the name
> you suggested to make it more obvious that the mask is being used to
> check for loff_t overflow.
> 
> If we want to explicitly comptue the mask as in code above.
> #define PGOFF_LOFFT_MAX \
> 	(((1UL << (PAGE_SHIFT + 1)) - 1) <<  (BITS_PER_LONG - (PAGE_SHIFT + 1)))
> 
> Or, we use PAGE_MASK
> #define PGOFF_LOFFT_MAX (PAGE_MASK << (BITS_PER_LONG - (2 * PAGE_SHIFT) - 1))

Sounds good.

> In either case, we need a big comment explaining the mask and
> how we have that extra bit +/- 1 because the offset will be converted
> to a signed value.

Yup.

> > Also, we later to
> > 
> > 	len = vma_len + ((loff_t)vma->vm_pgoff << PAGE_SHIFT);
> > 	/* check for overflow */
> > 	if (len < vma_len)
> > 		return -EINVAL;
> > 
> > which is ungainly: even if we passed the PGOFF_T_MAX test, there can
> > still be an overflow which we still must check for.  Is that avoidable?
> > Probably not...
> 
> Yes, it is required.  That check takes into account the length argument
> which is added to page offset.  So, yes you can pass the first check and
> fail this one.

Well I was sort of wondering if both checks could be done in a single
operation, but I guess not.
