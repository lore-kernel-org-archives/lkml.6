Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-880504-1522328630-2-3858849661230758425
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
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522328630; b=RoQxLxHQI2C0sCgVSgzmXHdP33FptRNxViszoGC/HbdCfGll7a
    G+NTndxRJlPaBdBS9oxSZL54zVAAHoO2/CWk8GAn2wUt6fckWTKcwNQxc00fYM8p
    X4KBEtJCimNsBagb2H1fcZ1to9GVJbLn2yEX/Du9cog6gUvZkoKxXgCQLEHPGm3r
    dVHe0LHd+GGYdu5S+8fZ484RlCkzaRievxFBZ3kCgmmDNcDgCY79VKiHqbzOi2mi
    0blTWU8W9MIZTImvjqkSuQlveeh6iZjHfD8eqlQ1ZcUtDR4xX6g+hYHYBa1AZo+Z
    BTLRrrMUXWn9eTfVJMoVcWP+kXXFKY5s3i3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522328630;
    bh=p3z1OoP9PpyHrS0Nkgrf6Og8qzzXfv1D4g3oeoAbZWE=; b=NsbWzPylmYtv
    D1F6mzrfbObi9/NAuYwOfegL3n5fNwwJWH0CpHiv+o3vuABDAvnhURgQOzIfTvdP
    R2SYyszbS0vp8KWHh+8+IstncMceXIM5c5CBi9j2TqH1bLi5uQv6q4CYuyr5SNX5
    NNjlUyYwwcvTfJIlFmuIJSKDpXfqzK1rQpRQt1dALpAD02Ic33kx/LIK0ZMDdND1
    X671bMFSFFzHhusCNwT8+TEzS7eAxCDOABxYoWyeOAgHICM9CeayJrXQQlJuiaz7
    mgRdsbd9/NYVN+n/qVrMhxktvBlUU4etzj7crOBH0tyzp9g7fkxkGsmc0jL9uHTM
    HGSDCJVmIg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lwn.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lwn.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfNSJSI8PecLH3a2UUPf4A6lBUkbpFuOZExNR9p/aQe0OzOOzWuvbchIqnf2UVsMzhmMo9A3XNQAgYVbFzn3EqaTP8S4+pWGS+lxr4kvBuWvvgbit5tMS
    ZBKJp+GFdXTGTp8lnxAiWrAotc65egIkWRR5qG6NlKaodHjx+DEIh+umHgbNiwpuNGbeTCHhV+F9cW5o+CDTC/n/VAo5SY+TMR9Nrkcd/92wHsu8AVf5VVDz
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=u0nCOyOA_HANvvom4_IA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752643AbeC2NDa (ORCPT <rfc822;greg@kroah.com>);
        Thu, 29 Mar 2018 09:03:30 -0400
Received: from ms.lwn.net ([45.79.88.28]:50814 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752487AbeC2ND3 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 29 Mar 2018 09:03:29 -0400
Date: Thu, 29 Mar 2018 07:03:27 -0600
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
Message-ID: <20180329070327.7f4c92c8@lwn.net>
In-Reply-To: <20180329090132.r3qfomigkw3hbwbw@madcap2.tricolour.ca>
References: <cover.1521179281.git.rgb@redhat.com>
        <e284617ad667ad8f17958dd8babb87fe1b4d7205.1521179281.git.rgb@redhat.com>
        <20180328123912.49b11c98@lwn.net>
        <20180329090132.r3qfomigkw3hbwbw@madcap2.tricolour.ca>
Organization: LWN.net
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 29 Mar 2018 05:01:32 -0400
Richard Guy Briggs <rgb@redhat.com> wrote:

> > A little detail, but still...  
> 
> I am understanding that you would prefer more context (as opposed to
> operational detail) in the description, laying out the use case for this
> patch(set)?

No, sorry, "a little detail" was referring to my comment.  The use case,
I believe, has been well described.

Thanks,

jon
