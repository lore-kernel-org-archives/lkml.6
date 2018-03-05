Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1088053-1520238147-2-7927542060710201744
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
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520238146; b=CRG+m4bToXpWqgfudcXOTvBvm1L0sdMTQuibv04rxJfbj6h
    FFoCivTZHQ4xM0QWyYE0PpYfM2qibXqbSYsqE7MclHt5UiU43FpoPEDyRq1XfT04
    caNun3KscW/6Qo+YgCriXA1SksrHIBduKGGkHyZUeZcd6K3uODdH6R7+TxeHvcZK
    GFyuPyGa+AHm3HQrtlelvnasBt1VE49vKv31yZo5K71yPLNuhTyADjBiZ9hScimE
    6SLfhDlF75DSqWTj/7yAqJ2TftbCttoI6VB+Jh7TeLMmISbSjrDU6Slhm76Ja0Qu
    IX/RMhKUUraoejhyMM5hM8iw1zKjxnxze0qnExA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520238146; bh=d5Q9/y3ZtVYZcD2FS6p6vQbYf1
    44Kj9z+efvzXuBnw0=; b=WMjKFH3Pg5zpqdNPlKWMhe+6z6+C8/57GVb6SHM5GW
    n/zo/zkOhT7wiszfedRzYyWvR/cbEGyK2s9Xg8sRsgkZg6urfS75YR5VdhwNMrmy
    k1LkZ1C1risBtC5lev60pGg8VCqGote6OnbVrbD9LLE2a548/rrPhSHlceTg6dgm
    mzhpYGxQqAZLcdHmzPo30IwC7F3cHzCR11YQeYtMVdFUM/2sVVNaDl5Vn/lOvZAq
    uh+E6VGS9A6YzD5I0TKgi09xsmaLCg8IDOceLCs8OcN5WD89iadSHlTK59TTO2N5
    2j/KmcE1SB/rvy+65j5gv75JrOLsg78U+0GRKXA0QhfQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933386AbeCEIWX (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 03:22:23 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47718 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933141AbeCEIVS (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 5 Mar 2018 03:21:18 -0500
Date: Mon, 5 Mar 2018 03:16:49 -0500
From: Richard Guy Briggs <rgb@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, ebiederm@xmission.com,
        simo@redhat.com, jlayton@redhat.com, carlos@redhat.com,
        linux-api@vger.kernel.org, containers@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Paris <eparis@parisplace.org>, dhowells@redhat.com,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        viro@zeniv.linux.org.uk, luto@kernel.org, netdev@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [RFC PATCH V1 01/12] audit: add container id
Message-ID: <20180305081649.yidzlnlu3pg3hjf2@madcap2.tricolour.ca>
References: <cover.1519930146.git.rgb@redhat.com>
 <2e5d93ee46feca915a101c2fc3062da674a98223.1519930146.git.rgb@redhat.com>
 <20180303091913.GA13118@mail.hallyn.com>
 <CAHC9VhQA23w39aaho1wkPawX7zxiGyTVQroZzpACKk8DK8-F8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhQA23w39aaho1wkPawX7zxiGyTVQroZzpACKk8DK8-F8w@mail.gmail.com>
User-Agent: NeoMutt/20171027
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-03-04 10:01, Paul Moore wrote:
> On Sat, Mar 3, 2018 at 4:19 AM, Serge E. Hallyn <serge@hallyn.com> wrote:
> > On Thu, Mar 01, 2018 at 02:41:04PM -0500, Richard Guy Briggs wrote:
> > ...
> >> +static inline bool audit_containerid_set(struct task_struct *tsk)
> >
> > Hi Richard,
> >
> > the calls to audit_containerid_set() confused me.  Could you make it
> > is_audit_containerid_set() or audit_containerid_isset()?
> 
> I haven't gone through the entire patchset yet, but I wanted to
> quickly comment on this ... I really dislike the
> function-names-as-sentences approach and would would greatly prefer
> audit_containerid_isset().

I'd be ok with this latter if necessary, but the naming mimics the
existing loginuid naming convention.

> >> +{
> >> +     return audit_get_containerid(tsk) != INVALID_CID;
> >> +}
> 
> paul moore

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
