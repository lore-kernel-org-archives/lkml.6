Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2899137-1525993557-2-6737727053488474761
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525993556; b=mnWmRRQjnLOFqRM1Qxaxx9Vp25lpFoUqqCJJtbn1fbF5TURWut
    stI4JkWTtKmuTP+HPRl5MQv4+oe1TvUIC/QoUgdroM7nun0NXmDopSEkBZ10ihhK
    aySs684GbDQTREOpKaEk44Qp8qUpA1uE4n+fisiOT+7PoC6GnF165QyszwFOXvVY
    0IwaAZYIaL17gSOfDuM+jXrTYV6a675Oomft5jZbOOGA92Ltre3n1psV6A1bWiDT
    OFobhcj8OaV8JoS2eW/z9j+0NDsQzskBdLBEe8tadPnIDZZ+W3N+gKtxh4R2y/WN
    CZH7VjXzUSblBsG9L21heQEz9J8hi2u54ZFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525993556; bh=QCijSx9SNR+0bkbYVYSd15nW2vt5wz
    3RqFQog01OQX8=; b=O8DEhl9uiG04FGnR1bAS33G8FdVTJujjmaSVmZSa3J61kP
    hP8LthWQqeaSPvh0QDDgwi0HwkNvu1zWGNpZyOLkkXpXjkQbd0+atC9wYNpFOyzm
    QbAQqKlfy5N/4l5z3YXW5tn+Qbpf8HANUoarKsovRPGs7eTQSo1Ijlx7lZfBXX/U
    JpgpYfDCEJM3zouwFTwhdiIjYAYoVgPMz99Nd0PjCy4jBEIlmnT94qHz63Gd5ivO
    e5qgPEfkmJqhMbaP1NkLeUaaiUl+GgBZV4V3kvO1wuv33IxrFV2zYG+8aJa21qRK
    fic0kbP/txkNIlP/pcdD+M576N8xgQ7aIKzdf/1g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDZG4csv+msuptlgTKtn0zCI7NKwg8byFGWKbGIEH8mM4o+eM3W3D09asYCfsBStely+qmWiwD7kGHptEOlFOrcjMceEUzc0jKbE5/iKocApADi+FSOR
    hr/sLICkYp1cFIdzt4AqXCEMZCLMGxMHdSFqrcgHhzeSHc6KrMVNjztr1yA5tUcGyQpXM4bv4PCj92a2XaoqkHKj7Ap1jR2IJato19tfbZJ9wnQbhYWNx9dM
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=yrjdNslMj3HvDjvt__IA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750805AbeEJXFy (ORCPT <rfc822;greg@kroah.com>);
        Thu, 10 May 2018 19:05:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:52605 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750714AbeEJXFx (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 10 May 2018 19:05:53 -0400
Date: Thu, 10 May 2018 23:05:51 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        sandeen@sandeen.net, darrick.wong@oracle.com, dhowells@redhat.com,
        tytso@mit.edu, fliu@suse.com, jack@suse.cz, jeffm@suse.com,
        nborisov@suse.com, jake.norris@suse.com, mtk.manpages@gmail.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] vfs: skip extra attributes check on removal for symlinks
Message-ID: <20180510230551.GE27853@wotan.suse.de>
References: <20180426234639.12480-1-mcgrof@kernel.org>
 <20180510204807.GV30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510204807.GV30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 10, 2018 at 09:48:07PM +0100, Al Viro wrote:
> On Thu, Apr 26, 2018 at 04:46:39PM -0700, Luis R. Rodriguez wrote:
> 
> > Since we cannot set these attributes we should special-case the
> > immutable/append on delete for symlinks, this would be consistent with
> > what we *do* allow on Linux for all filesystems.
> 
> Er...  So why not simply sanity-check it in places that set it on
> inodes? 

The patch is not about sanity-checks on setters though as *that* is in place
already. Its about the case where the filesystem gets corrupted and the VFS
*still* does process these attributes for symlinks and still prevents
deletion because of these attributes.

So we already do not allow for settings these attributes.

> If anything, I would suggest
> 	* converting all places that set those in ->i_flags to
> inode_set_flags()
> 	* making inode_set_flags() check and return an error on
> that...

But if I misunderstood your suggestion please let me know. I'll send out
a v2 RFC next which illustrates what filesystems can do for now.

  Luis
