Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA76FC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 05:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 551D62087A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 05:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="i4lpew4h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 551D62087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbeIYLvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 07:51:25 -0400
Received: from alln-iport-3.cisco.com ([173.37.142.90]:33159 "EHLO
        alln-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbeIYLvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 07:51:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=3478; q=dns/txt; s=iport;
  t=1537854333; x=1539063933;
  h=mime-version:content-transfer-encoding:to:from:
   in-reply-to:cc:references:message-id:subject:date;
  bh=axVJ8/mrtEr3I366y6a+468g5PY+5WMasIOSgsvkeYU=;
  b=i4lpew4h7aFSs6L8Mk7nu22hjyVuNjz7P/50IA6MJ033iQlGYo9iLYPf
   kxY69+J0DUtebisoK0ME8RVGXb66UJwBXD7DLuNtk74vJ5Phbrs4FrACl
   AsbfJqoalRwYUD5F1QFAZTRHleLSvwGxFow1TGq2j4AuSVWMg2zYA1921
   g=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0APAACvyqlb/5NdJa1bGQEBAQEBAQE?=
 =?us-ascii?q?BAQEBAQcBAQEBAQGBU4IMgWQog3SIdI03JYhojWaBeguEbAKDWiE2FgEDAQE?=
 =?us-ascii?q?CAQECbSiFOQEFI1YQCxgCAiYCAkcQBgESG4R7DaM7gS6KHBR3iW4XgUE/gUW?=
 =?us-ascii?q?BYX6EfoMBglcCiESFOXKOEAmQQAkCjyGVCYFIATGBVXAVeAUGVoFOgiCOVB8?=
 =?us-ascii?q?wjTABAQ?=
X-IronPort-AV: E=Sophos;i="5.54,300,1534809600"; 
   d="scan'208";a="176505111"
Received: from rcdn-core-11.cisco.com ([173.37.93.147])
  by alln-iport-3.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2018 05:45:33 +0000
Received: from localhost (sjc-vpn5-271.cisco.com [10.21.89.15])
        by rcdn-core-11.cisco.com (8.15.2/8.15.2) with ESMTP id w8P5jW3B009115;
        Tue, 25 Sep 2018 05:45:32 GMT
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
From:   Taras Kondratiuk <takondra@cisco.com>
In-Reply-To: <CAHC9VhRorkfqRTsssx_eGMy+fJQtoJew7f5i24UBkZ6tGJ5CUw@mail.gmail.com>
Cc:     Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
        linux-kernel@vger.kernel.org, xe-linux-external@cisco.com
References: <20180919165248.53090-1-takondra@cisco.com>
 <f283c1e7-19eb-2b99-3fef-a19e2bf99a2b@tycho.nsa.gov>
 <153741130781.7326.1773144725860636439@takondra-t460s>
 <9a944aea-f35e-5a49-841d-6bfca8f17b9d@tycho.nsa.gov>
 <153748436388.5590.1406237328277739821@takondra-t460s>
 <66ec16b0-a335-d9ef-deb3-ef391cdd66e0@tycho.nsa.gov>
 <CAHC9VhRorkfqRTsssx_eGMy+fJQtoJew7f5i24UBkZ6tGJ5CUw@mail.gmail.com>
Message-ID: <153785433233.5039.17960184426345262866@takondra-t460s>
User-Agent: alot/0.6
Subject: Re: [RFC PATCH] selinux: add a fallback to defcontext for native labeling
Date:   Mon, 24 Sep 2018 22:45:32 -0700
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.21.89.15, sjc-vpn5-271.cisco.com
X-Outbound-Node: rcdn-core-11.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Moore (2018-09-24 20:46:57)
> On Fri, Sep 21, 2018 at 10:39 AM Stephen Smalley <sds@tycho.nsa.gov> wrot=
e:
> > On 09/20/2018 06:59 PM, Taras Kondratiuk wrote:
> > > Quoting Stephen Smalley (2018-09-20 07:49:12)
> > >> On 09/19/2018 10:41 PM, Taras Kondratiuk wrote:
> > >>> Quoting Stephen Smalley (2018-09-19 12:00:33)
> > >>>> On 09/19/2018 12:52 PM, Taras Kondratiuk wrote:
> =

> ...
> =

> > > IMO it would be more consistent if defcontext cover all "unlabeled"
> > > groups. It seems unlikely to me that somebody who currently uses
> > > defcontext can somehow rely on mapping invalid labels to unlabeled
> > > instead of default context.
> >
> > Yes, and that seems more consistent with the current documentation in
> > the mount man page for defcontext=3D.
> >
> > I'd be inclined to change selinux_inode_notifysecctx() to call
> > security_context_to_sid_default() directly instead of using
> > selinux_inode_setsecurity() and change security_context_to_sid_core()
> > and sidtab_search_core() as suggested above to save and use the def_sid
> > instead of SECINITSID_UNLABELED always (initializing the context def_sid
> > to SECINITSID_UNLABELED as the default).  selinux_inode_setsecurity() we
> > should leave unchanged, or if we change it at all, it should be more
> > like the handling in selinux_inode_setxattr().  The notifysecctx hook is
> > invoked by the filesystem to notify the security module of the file's
> > existing security context, so in that case we always want the _default
> > behavior, whereas the setsecurity hook is invoked by the vfs or the
> > filesystem to set the security context of a file to a new value, so in
> > that case we would only use the _force interface if the caller had
> > CAP_MAC_ADMIN.
> >
> > Paul, what say you?  NB This would be a user-visible behavior change for
> > mounts specifying defcontext=3D on xattr filesystems; files with invalid
> > contexts will then show up with the defcontext value instead of the
> > unlabeled context.  If that's too risky, then we'd need a flag or
> > something to security_context_to_sid_default() to distinguish the
> > behaviors and only set it when called from selinux_inode_notifysecctx().
> =

> Visible changes like this are always worrisome, even though I think it
> is safe to assume that the defcontext option is not widely used.  I'd
> feel much better if this change was opt-in.
> =

> Which brings about it's own problems.  We have the policy capability
> functionality, but that is likely a poor fit for this as the policy
> capabilities are usually controlled by the Linux distribution while
> the mount options are set by the system's administrator when the
> filesystem is mounted.  We could add a toggle somewhere in selinuxfs,
> but I really dislike that idea, and would prefer to find a different
> solution if possible.  I'm not sure how much flak we would get for
> introducing a new mount option, but perhaps that is the best way to
> handle this: defcontext would continue to behave as it does now, but
> new option X would behave as mentioned in this thread.
> =

> Thoughts?

The new option X will also mean "default context", so it will be pretty
hard to come up with a different but a sensible name. I'm afraid that
having two options with hardly distinguishable semantics will be very
confusing.

What about a kernel config option that modifies the behavior of
defcontext?
