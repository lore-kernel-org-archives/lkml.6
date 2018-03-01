Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4152424-1519946506-2-9782416499211901418
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519946505; b=LawGZc/1BigzxV5Rc0zpBQsOeXvodsYxGf9oZ6V7aoMYTvn
    nr9vHjWDk1WzlMWPS5mBR3F1pggHqvjV9lJqHrzY0K/IItvRJr4nCJ8Kq2A5nJ0z
    luU+TT4VNt9b2xmX3IqZvApChKhQuNiPOUuXWhDBjhwB4LOJ8Xjq7d8A9fxE2gsI
    B3RY01LBRO6Sq6ZvNl1FVl7PEtpJSSoJhJWNIUJsHZFmIGZ9MDuzcCwKBw2auRvW
    mfL1wTKPLYA5Jur4IGMaVxjWCEmq9+BjNdovsrbWIVMOlPEInHRwdFMaf365g2lM
    s0koNFIBiUjh/pvC6iL3oenbSsMqiiE6MkPFLPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519946505; bh=lz9O3fs2ps3QC7iUnNb2iZCayP3yScwafbO8MSymaSo=; b=I
    VTCKuvs6wsUkdSbNaKLIX4FzRaM8c6fT6sKnjoX08eSG5XksfW++oYr71367ynWs
    XTRErIKoTkfm67fr2o857lCMOhA32pRWzzSZCACNdGqM7WlA2yRxgG+NnMDM3TjK
    dJDZb9fxzj+1S6Chw7rFb9Iwo2sAvjkDeKH378umOqRxef01jjkx43E4M/XvWVdB
    5gxUPUwXzy3mGmjg6LmBl2vcsvLoNkQLZWyDDNo4rY7pulJ5tE3Qulq5n2FluTDz
    jFNjlhWtRXkyZhTjBRLjxW+JWxBr/j9nwbLcQjzLp+glHjaSSnvxdm4U74ahCQaR
    3PYfrPsUNUe8zBElr2z9w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162869AbeCAXVo (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 18:21:44 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:55284 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162874AbeCAXVn (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Mar 2018 18:21:43 -0500
Date: Thu, 1 Mar 2018 15:21:41 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Daniel Vacek <neelx@redhat.com>
Cc: Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Paul Burton <paul.burton@imgtec.com>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: fix memmap_init_zone pageblock alignment
Message-Id: <20180301152141.50bb01d7972806f32bbb7e62@linux-foundation.org>
In-Reply-To: <CACjP9X8hFDhkKUHRu2K5WgEp9YFHh2=vMSyM6KkZ5UZtxs7k-w@mail.gmail.com>
References: <1519908465-12328-1-git-send-email-neelx@redhat.com>
        <20180301131033.GH15057@dhcp22.suse.cz>
        <CACjP9X-S=OgmUw-WyyH971_GREn1WzrG3aeGkKLyR1bO4_pWPA@mail.gmail.com>
        <20180301152729.GM15057@dhcp22.suse.cz>
        <CACjP9X8hFDhkKUHRu2K5WgEp9YFHh2=vMSyM6KkZ5UZtxs7k-w@mail.gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 1 Mar 2018 17:20:04 +0100 Daniel Vacek <neelx@redhat.com> wrote:

> Wanna me send a v2?

Yes please ;)
