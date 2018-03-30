Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2585680-1522386731-2-7398061716971545466
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522386731; b=i7ubk92PJ10q0bEqepjR4N8cnyDmwPUX8vhUQpBOEAkA5P+Ron
    Zo/88ShPVTXoL5/3eRgTOxkGDeV1/mDWqhP7Lm9UlkqK7T/qGaj35rz8OoiJ0UpV
    0fkJNYL79JeJnbnbAFzx58ENUI0xQAoZ6vais6juaFlx3HplgeThSecCz+4WKJ51
    IP6KE117bR+Q/ATN1KTAUPHa8asvoiDJAc4Zk6Gvc4h6w+D3bjgPqwcdFm3OUZfo
    Z3TRtGqKHpiIcgz2k4GcmOusLVb/qfwTd48VXeOypuI5rMygRgMA6IC1XxsF7fEO
    F36TaKeWJui7ricVTloNJ79ao1odzSyZT2Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1522386731; bh=CFhb+O6nXCxKsqTKrtX/DOrk1xm2xq
    pcYQMJSyzwe98=; b=ocyvZ6c+actPNMFQ5bozyjT5GDfOS8Ggp+8hzOZ0rFy0CY
    tZ66T/sdLOkFVEm0KhU9h2VNe2BKPQhNbo5S2LxsP6zs+605LeWwBPLyipgeiGqT
    ScHUG0VB60ASmmGsHiBJ0G9Q28kNdkZ8QQs2ttFu8Li3rTjGaoZouyVueWyKxVWT
    3JZjGL95QmkqbXPfvWtLdLaFgJxKAzdi4W24rB0nYgdtcNmEiRoXcbN61sbaJbbp
    FkNCv6xNoNkkUm4Onts+SY9ncYzRefSJdA5wh4tAzKEJ1zBXjdZaBKpgQM3a6vi1
    0quuye97o1WRdrmn4rNYBEo/h9f4x2UDwHbmuVtw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfH9nXkcHu5EgQRwkjZhH6Z8MsWKeavxvcxpFnJHAnV+kf2/Yf0qOaL84THqNBCxElakbZBRbaldxgXgQmh43PbneMTffT9KK+n0hz5CVGflYdp8Mb2FQ
    udA3Oj/+TiGscPIf/FZLWzLJW4PSwJ4iawvgFR4A31pZNCWJZiqAI+jdvh+Eo6xigZwRX0bYQoCZG7atSZL3Iu0MHOd8RyVq4mGQ5yd7wHbhoV7lTAy2Kbbt
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=GPxfi-WrwqILHyQGKgsA:9 a=CjuIK1q_8ugA:10
    a=jDz1Lg8WPqQA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751260AbeC3FMH (ORCPT <rfc822;greg@kroah.com>);
        Fri, 30 Mar 2018 01:12:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38754 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750752AbeC3FMG (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 30 Mar 2018 01:12:06 -0400
Date: Fri, 30 Mar 2018 01:06:39 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: ebiederm@xmission.com, simo@redhat.com, jlayton@redhat.com,
        carlos@redhat.com, linux-api@vger.kernel.org,
        containers@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>, eparis@parisplace.org,
        dhowells@redhat.com,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        viro@zeniv.linux.org.uk, luto@kernel.org, netdev@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        serge@hallyn.com
Subject: Re: [RFC PATCH ghak32 V2 01/13] audit: add container id
Message-ID: <20180330050639.tjptq3fz35hcw76s@madcap2.tricolour.ca>
References: <cover.1521179281.git.rgb@redhat.com>
 <e284617ad667ad8f17958dd8babb87fe1b4d7205.1521179281.git.rgb@redhat.com>
 <20180328123912.49b11c98@lwn.net>
 <20180329090132.r3qfomigkw3hbwbw@madcap2.tricolour.ca>
 <20180329070327.7f4c92c8@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180329070327.7f4c92c8@lwn.net>
User-Agent: NeoMutt/20171027
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-03-29 07:03, Jonathan Corbet wrote:
> On Thu, 29 Mar 2018 05:01:32 -0400
> Richard Guy Briggs <rgb@redhat.com> wrote:
> 
> > > A little detail, but still...  
> > 
> > I am understanding that you would prefer more context (as opposed to
> > operational detail) in the description, laying out the use case for this
> > patch(set)?
> 
> No, sorry, "a little detail" was referring to my comment.  The use case,
> I believe, has been well described.

Ah!  "A minor nit".  :-)

> jon

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
