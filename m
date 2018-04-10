Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4038955-1523370573-2-3984320646554163048
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523370573; b=IbW7AQTS3/A9I3BoKrdUUvMUYP4RnJtZCAb7JvGxuBfGC41vqa
    /iQyNJ+Wi5ATju1qhOtolT9QmFw1r5QJy2m63bNJiNz1f2czjqA0DrFWyWBeQNys
    twdtkPhcKqZajm6N57JrfSJe9fj+ukzGw0mXJL7RCLLkKC4CmmmTvO9KGI73FZNY
    H3lG85nzQudmg7xMtWAv40XYm+Kr5q8MjE83g5VPIBJSMqvrsafoEW9FC4ezCNs8
    9yHPbtnSNBiSbvhyxCSoDyzaRM0bctxmwguopYosOcULH/+t2HO6KZs24ZGZpR+z
    tD909s5wB4aWhsXqOqkBHOGafWwpeOQGo0FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:references:mime-version:content-type:sender:list-id;
    s=fm2; t=1523370573; bh=kV+72ihtaYDJO2J5e9LRtp3hBiPu3Ipbe+XKztJ
    GgtA=; b=AwRQSWbpDV6j8Uirf87PvJMwcsLSm5rMO1Qo0EMM+REa/D6PPi/DFuW
    VLfpKI2HvqBjEHug74c9/qqjnDfXxQtJG02wHfZPFZP9j3Liuvr/cZG0CrcONMG4
    i8urjDTZ1lOCspsdgZksLpGFeDiwLkMMxmA3KMwZ/4gJGJbcoKXaOtZufVhkihYL
    fKIiU76ISVW3T93HtiprHNQNh8+2xIjj1JdeSARsD3YD4LOGeSouKYc5Ys0ni2i9
    J39r8SNb9maxIKX0amavEBl0+zX66gM9Rvd2qUas+tCtj4NqunlBDZOeKrz6SOSL
    n5XbhawU0lJobf8Nv2S3dONAxOcePKg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOsMPjw2H202gmr/QuTb7ONBXTE+I69ZEg/ybJwTfHBIGCdYq2br3qoN/SmF5O9+hjhNn6aoifBPVwUC3wMX6ociEJjzyINJuOvYFG1W/rG4VXbml9Bw
    +mlMdnVQG0iREL50G7RHzKLZ00fng8oHmeoKuWdbBDJChYv0P6yg5PqRRwQWRVUKUbXNxH6LJ0cEABiKP+tJzu5x3b2M6BfPabpMTUlVw8OyqZRslyBd0+Mg
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=khwyK8DuSVkA:10
    a=Kd1tUaAdevIA:10 a=_luCulpIytyPR5DK9ZkA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753478AbeDJO3a (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 10:29:30 -0400
Received: from resqmta-po-12v.sys.comcast.net ([96.114.154.171]:51750 "EHLO
        resqmta-po-12v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753090AbeDJO3a (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Apr 2018 10:29:30 -0400
Date: Tue, 10 Apr 2018 09:21:20 -0500 (CDT)
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: Matthew Wilcox <willy@infradead.org>
cc: linux-mm@kvack.org, Matthew Wilcox <mawilcox@microsoft.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/2] slab: __GFP_ZERO is incompatible with a
 constructor
In-Reply-To: <20180410125351.15837-1-willy@infradead.org>
Message-ID: <alpine.DEB.2.20.1804100920110.27333@nuc-kabylake>
References: <20180410125351.15837-1-willy@infradead.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfBkChvRlASOl+lo9K+AwiU6LxkT8MbEcaHqvHcSIW4dO/VptPDF7J9sHRIyTUWWHUETTjtDuFNkXwwvAMK1QDOqYpzVk14uB37kYHnMz2p3jPzJcqkWg
 PqSMokymvRECmGJdXFVP0nTFDpDQPugXonVf/3wYct1hC/1Olyq/0fFhLZJs6we8gC4S+l4JcJETSr1LhWgQsgu3XDJ/HOBdslJRU9kfYcvXQdHN9+7nf089
 cWhIf9a2163BPdA1BX3/UBqgTEuoF8AbgCepkUs5UQQs0fnJV4EZKc9d1l3BZiYdn2abjeJQkSJagKZM1x5j63LZkdoQe684gUI7M0Z4/67z5lRD/OxD9E3J
 bgQ+LxOVmB/UwkGERNMsSFvfcWinUXaht+o3F8Syb5jPscbCw3lWlYaVwlNI0twXiwbyHBvkRJmwXOK5AJ+RpQGXp7DKpCMdkzqg6g6mHzLVQpQLSXO27eCD
 AYDTRmlWZyYwwj1guyKRmqqMGrd1EBdTIB1aid830uCVSnjgTsoK8zoOcvs=
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 10 Apr 2018, Matthew Wilcox wrote:

> __GFP_ZERO requests that the object be initialised to all-zeroes,
> while the purpose of a constructor is to initialise an object to a
> particular pattern.  We cannot do both.  Add a warning to catch any
> users who mistakenly pass a __GFP_ZERO flag when allocating a slab with
> a constructor.

Can we move this check out of the critical paths and check for
a ctor and GFP_ZERO when calling the page allocator? F.e. in
allocate_slab()?
