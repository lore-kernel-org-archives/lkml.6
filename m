Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1B4C64EBD
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 00:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E72662082A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 00:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="UcVv6ZKz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E72662082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbeJCHpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 03:45:02 -0400
Received: from alln-iport-2.cisco.com ([173.37.142.89]:29188 "EHLO
        alln-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbeJCHpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 03:45:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2842; q=dns/txt; s=iport;
  t=1538528337; x=1539737937;
  h=mime-version:content-transfer-encoding:to:from:
   in-reply-to:cc:references:message-id:subject:date;
  bh=EMjo9w6XVO9F3pc5CMJc+klTHx3E3QavcGlHhi1k2p4=;
  b=UcVv6ZKzyBjgipIrWVINt6VNTzPBC33EdUghzBP+w1ddL00q18r31o5+
   RbmyzUVjjwntSKMcG31smXVHly1rVrjNYhx4JwgPMlzNRfhbxlHRjevFq
   9vM+pKAfORFcfnNwxuIKmI2RAe8hmvLCmxcsd0NtgsbH1MoGFVZ8DHtY9
   o=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0ATAADoE7Rb/5hdJa1aGQEBAQEBAQE?=
 =?us-ascii?q?BAQEBAQcBAQEBAQGBUoINgWWEHIh0jSYliG2Nb4F6C4RsAoQOITUXAQMBAQI?=
 =?us-ascii?q?BAQJtKIU5AQUjBFIQCxgCAiYCAkcQBgGFKA2mK3szihQUd4l4F4FBP4FFgWF?=
 =?us-ascii?q?+hH6DAYJXAo8DjjsJkE8JAoE+jhKIe4xFgUQDM4FVcBV4BQZWgU+CJBeOOB+?=
 =?us-ascii?q?OUAEB?=
X-IronPort-AV: E=Sophos;i="5.54,334,1534809600"; 
   d="scan'208";a="180107152"
Received: from rcdn-core-1.cisco.com ([173.37.93.152])
  by alln-iport-2.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2018 00:58:56 +0000
Received: from localhost (sjc-vpn2-521.cisco.com [10.21.114.9])
        by rcdn-core-1.cisco.com (8.15.2/8.15.2) with ESMTP id w930wuK0011886;
        Wed, 3 Oct 2018 00:58:56 GMT
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
From:   Taras Kondratiuk <takondra@cisco.com>
In-Reply-To: <91112a5a-2e67-28cf-b8a5-b80dc9385bb7@tycho.nsa.gov>
Cc:     linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        xe-linux-external@cisco.com
References: <20180919165248.53090-1-takondra@cisco.com>
 <66ec16b0-a335-d9ef-deb3-ef391cdd66e0@tycho.nsa.gov>
 <CAHC9VhRorkfqRTsssx_eGMy+fJQtoJew7f5i24UBkZ6tGJ5CUw@mail.gmail.com>
 <153785433233.5039.17960184426345262866@takondra-t460s>
 <a23ad753-8fd4-e9c3-cdbf-391ee154794b@tycho.nsa.gov>
 <CAHC9VhRRArA7_ON5P2JfrKxExwzm5Wznj150pfgijBoR+JxYBA@mail.gmail.com>
 <a185b384-5ef1-5e53-2cc1-066391424dcb@tycho.nsa.gov>
 <153790265614.6091.7582646556934797699@takondra-t460s>
 <153850609939.4490.12129272851093190248@takondra-t460s>
 <91112a5a-2e67-28cf-b8a5-b80dc9385bb7@tycho.nsa.gov>
Message-ID: <153852833597.8135.14322052015672451164@takondra-t460s>
User-Agent: alot/0.6
Subject: Re: [RFC PATCH] selinux: add a fallback to defcontext for native labeling
Date:   Tue, 02 Oct 2018 17:58:55 -0700
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.21.114.9, sjc-vpn2-521.cisco.com
X-Outbound-Node: rcdn-core-1.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Smalley (2018-10-02 12:41:54)
> On 10/02/2018 02:48 PM, Taras Kondratiuk wrote:
> > Quoting Stephen Smalley (2018-09-21 07:40:58)
> >> If we set the inode sid to the superblock def_sid on an invalid
> >> context, then we lose the association to the original context value.
> >> The support for deferred mapping of contexts requires allocating a new
> >> SID for the invalid context and storing that SID in the inode, so that
> >> if the context later becomes valid upon a policy update/reload, the
> >> inode SID will refer to the now valid context.
> >> To combine the two, we would need security_context_to_sid_core() to
> >> save the def_sid in the context structure for invalid contexts, and
> >> change sidtab_search_core() to use that value instead of
> >> SECINITSID_UNLABELED for invalid SIDs.  Then the inode would be
> >> treated as having the defcontext for access control and getxattr() w/o
> >> CAP_MAC_ADMIN purposes, but a subsequent policy update/reload that
> >> makes the context valid would automatically cause subsequent accesses
> >> to the inode to start using the original context value for access
> >> control and getxattr() purposes.  I think that's the behavior you
> >> want.
> >>
> > =

> > While implementing the change I've realized that storing default context
> > for sidtab_search_core() in the context structure is not enough to
> > achieve the desired behavior. The same invalid context may exist in two
> > mounts with different 'defcontext', so default context can't be a
> > property of a context structure.
> > =

> > One way to address it is to propagate default context to sidtab_search(=
) all
> > the way from inode hooks. But that will be a bit intrusive. Something l=
ike
> > avc_has_perm_default() will need to be added.
> > =

> > Other way is to check for context validity in inode hooks and provide a=
 default
> > context to avc_has_perm() if the inode's sid is invalid. But this may h=
ave
> > performance implication since validity check will be done each time in =
fast
> > path.
> > =

> > Do you see any other options?
> =

> I think the original approach is still best.  The def_sid can be part of =

> the context structure; you just need to update context_cmp() to compare =

> it (as part of the first return statement) so that the same invalid =

> context in two mounts with different defcontext=3D values will allocate =

> different SIDs.  Likewise context_cpy() needs to copy the def_sid.
> =

> As a separate matter, you should also modify =

> security_context_to_sid_force() to pass down the sbsec->def_sid so that =

> when userspace with CAP_MAC_ADMIN sets an invalid context on an inode, =

> the default context will be used in the same manner.

Thanks. That's really a better approach.
