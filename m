Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358F1C43382
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 21:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD624214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 21:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="YqdwiIAL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD624214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbeIYDdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 23:33:06 -0400
Received: from rcdn-iport-1.cisco.com ([173.37.86.72]:44281 "EHLO
        rcdn-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728490AbeIYDdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 23:33:05 -0400
X-Greylist: delayed 691 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Sep 2018 23:33:05 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=12024; q=dns/txt;
  s=iport; t=1537824534; x=1539034134;
  h=mime-version:content-transfer-encoding:to:from:
   in-reply-to:cc:references:message-id:subject:date;
  bh=ucRIwdU4ulUKCOjRZd8DzC5JOgeX9VN2puVAX6xIj7o=;
  b=YqdwiIALy6AnfRdRwueEZJi9/xFrMjWw5yxgFES6YNwXKDHLEuzcWWcV
   j34Ev2p66LOl58LSi3w4JWDg6Un1QcRAfKIweAoBBP/lxZmSJyaLn3d6P
   qNn+zST2vlNZnPwE3JK/5ACvXTkjepnNJMsvIoYA2ODB+8t109sXciWDz
   Y=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0ALAAAtVKlb/51dJa1bGQEBAQEBAQE?=
 =?us-ascii?q?BAQEBAQcBAQEBAQGBUoINZU0yKIN0lECBaCWIaYRiiQSBegsjhEkCg1khNRc?=
 =?us-ascii?q?BAwEBAgEBAm0cDIU5AQUjVhALDgoCAiYCAkcQBgEtgweBdA0Po26BLooKBRR?=
 =?us-ascii?q?3iW0XgUE/gRIzgl+DGwQYgTEWgwGCVwKIJCABEBGGCY4QCYZDiX0JAoE6jWe?=
 =?us-ascii?q?Ib4MLiQ+BRAE1gVVwFXgFBlaBT4IkF4NGinIfMAGNMwEB?=
X-IronPort-AV: E=Sophos;i="5.54,299,1534809600"; 
   d="scan'208";a="456696794"
Received: from rcdn-core-6.cisco.com ([173.37.93.157])
  by rcdn-iport-1.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2018 21:17:09 +0000
Received: from localhost ([10.156.154.24])
        by rcdn-core-6.cisco.com (8.15.2/8.15.2) with ESMTP id w8OLH97d024865;
        Mon, 24 Sep 2018 21:17:09 GMT
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Eric Paris <eparis@parisplace.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
From:   Taras Kondratiuk <takondra@cisco.com>
In-Reply-To: <66ec16b0-a335-d9ef-deb3-ef391cdd66e0@tycho.nsa.gov>
Cc:     selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        xe-linux-external@cisco.com
References: <20180919165248.53090-1-takondra@cisco.com>
 <f283c1e7-19eb-2b99-3fef-a19e2bf99a2b@tycho.nsa.gov>
 <153741130781.7326.1773144725860636439@takondra-t460s>
 <9a944aea-f35e-5a49-841d-6bfca8f17b9d@tycho.nsa.gov>
 <153748436388.5590.1406237328277739821@takondra-t460s>
 <66ec16b0-a335-d9ef-deb3-ef391cdd66e0@tycho.nsa.gov>
Message-ID: <153782382932.4009.11167059420902765851@takondra-t460s>
User-Agent: alot/0.6
Subject: Re: [RFC PATCH] selinux: add a fallback to defcontext for native labeling
Date:   Mon, 24 Sep 2018 14:17:09 -0700
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.156.154.24, [10.156.154.24]
X-Outbound-Node: rcdn-core-6.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Smalley (2018-09-21 07:40:58)
> On 09/20/2018 06:59 PM, Taras Kondratiuk wrote:
> > Quoting Stephen Smalley (2018-09-20 07:49:12)
> >> On 09/19/2018 10:41 PM, Taras Kondratiuk wrote:
> >>> Quoting Stephen Smalley (2018-09-19 12:00:33)
> >>>> On 09/19/2018 12:52 PM, Taras Kondratiuk wrote:
> >>>>> When files on NFSv4 server are not properly labeled (label doesn't =
match
> >>>>> a policy on a client) they will end up with unlabeled_t type which =
is
> >>>>> too generic. We would like to be able to set a default context per
> >>>>> mount. 'defcontext' mount option looks like a nice solution, but it
> >>>>> doesn't seem to be fully implemented for native labeling. Default
> >>>>> context is stored, but is never used.
> >>>>>
> >>>>> The patch adds a fallback to a default context if a received contex=
t is
> >>>>> invalid. If the inode context is already initialized, then it is le=
ft
> >>>>> untouched to preserve a context set locally on a client.
> >>>>
> >>>> Can you explain the use case further?  Why are you exporting a
> >>>> filesystem with security labeling enabled to a client that doesn't
> >>>> understand all of the labels used within it?  Why wouldn't you just
> >>>> disable NFSv4 security labeling and/or use a regular context=3D moun=
t to
> >>>> assign a single context to all files in the mount?
> >>>
> >>> Client and server are two embedded devices. They are part of a bigger
> >>> modular system and normally run the same SW version, so they understa=
nd
> >>> each others NFSv4 SELinux labels. But during migration from one SW
> >>> version to another a client and a server may run different versions f=
or
> >>> some time.
> >>>
> >>> The immediate issue I'm trying to address is a migration between
> >>> releases with and without SELinux policy. A client (with policy) gets
> >>> initial SID labels from a server (without policy). Those labels are
> >>> considered invalid, so files remain unlabeled. This also causes lots =
of
> >>> errors from nfs_setsecurity() in dmesg.
> >>
> >> Why are you enabling SELinux on the server without loading a policy?
> >> Are you concerned about denials on the server? For that, you could
> >> always run it permissive until you are confident you have a working po=
licy.
> >>
> >> Why are you enabling security_label in exports before you have a policy
> >> loaded?  It doesn't appear that will ever work, since nfsd asks the
> >> security module for the labels, not the local filesystem directly.
> >>
> >> I understand that this doesn't fully address your use case, but it see=
ms
> >> like you could avoid this particular situation altogether just by
> >> loading a policy (at which point your server can return actual context=
s)
> >> or by removing security_label from your exports (at which point your
> >> server won't try returning contexts and the client will just apply the
> >> default for nfs) until you get to the point of loading a policy.
> > =

> > It wasn't intentional configuration. Server is running v4.4.x kernel
> > that had security labels enabled by default for NFS 4.2. This was a bug:
> > https://bugzilla.redhat.com/show_bug.cgi?id=3D1406885
> > Commit that introduced security_label 32ddd944a056 ("nfsd: opt in to
> > labeled nfs per export") appeared in v4.11 only.
> > =

> > We hit this bug during migration to newer releases with SELinux, but the
> > older release is already in the field and we need to handle it.
> =

> Ok, I understand the kernel bug, but not why your servers are in a state =

> where SELinux is enabled but no policy is loaded.  That is not a =

> well-tested code path aside from early system initialization prior to =

> first policy load by systemd/init.  You would be better off either =

> disabling SELinux on the servers entirely (thereby automatically =

> disabling NFSv4.2 security labeling) or installing/loading a policy on =

> the servers (thereby enabling them to produce valid security labels for =

> the client at least to the extent that they agree on policy).  If you =

> are concerned about denials on the server, then you could always leave =

> the servers permissive initially and collect audit logs until you are =

> confident your policy is adequate.

It wasn't intentional either. The same kernel configuration is used
accross several products. We roll out SELinux for products one by one,
so some products don't have SELinux policy and /etc/selinux/config yet
while SELinux kernel config is enabled. In hindsight we should have
explicitly disabled SELinux in /etc/selinux/config for those products.

Since it is not a well-tested code I'm wondering shouldn't systemd/init
be disabling SELinux if config file or policy is missing?

> =

> >>
> >>>
> >>>>
> >>>> To be clear, defcontext=3D doesn't work that way for local/FS_USE_XA=
TTR
> >>>> filesystems. The context specified by it is only used for:
> >>>> 1) files that don't implement the xattr inode operations at all,
> >>>> 2) files that lack a security.selinux xattr,
> >>>> 3) the MLS portion of the context if it was missing (strictly as a
> >>>> legacy compatibility mechanism for RHEL4 which predated the enabling=
 of
> >>>> the MLS field/logic).
> >>>>
> >>>> A file with a security.selinux xattr that is invalid under policy for
> >>>> any reason other than a missing MLS field will be handled as having =
the
> >>>> unlabeled context.
> >>>
> >>> inode_doinit_with_dentry() invokes security_context_to_sid_default()
> >>> that invokes security_context_to_sid_core() with 'force' flag. Won't
> >>> sidtab_context_to_sid() in this case allocate a new SID for the inval=
id
> >>> xattr context instead of leaving it unlabeled?
> >>
> >> It will be treated as having the unlabeled context for access control
> >> purposes and that is what getxattr will return to userspace processes
> >> unless they have CAP_MAC_ADMIN and SELinux mac_admin permission, but
> >> internally SELinux will keep track of the original xattr context value
> >> and will later retry to map it upon a policy reload, switching over to
> >> using it for access control and getxattr if it becomes valid under a n=
ew
> >> policy.  That support was added to support scenarios where a package
> >> manager sets a file context before it has loaded the policy module that
> >> defines it, or scenarios where one is generating a filesystem image for
> >> another OS/release with different policy. That is likely something you
> >> need/want for NFS as well if you want the client to start using the
> >> context as soon as it becomes valid upon a policy update/reload and not
> >> have to wait for the inode to be evicted.
> > =

> > So now handling of invalid labels is different for xattrs (labels are
> > preserved) and native (labels are discarded). Maybe it is worth to align
> > this behavior. It should make introduction of defcontext for native
> > easier.
> =

> Perhaps.  However, this handling of invalid labels is in conflict with =

> your suggested behavior for defcontext=3D.  If we set the inode sid to th=
e =

> superblock def_sid on an invalid context, then we lose the association =

> to the original context value. The support for deferred mapping of =

> contexts requires allocating a new SID for the invalid context and =

> storing that SID in the inode, so that if the context later becomes =

> valid upon a policy update/reload, the inode SID will refer to the now =

> valid context.  To combine the two, we would need =

> security_context_to_sid_core() to save the def_sid in the context =

> structure for invalid contexts, and change sidtab_search_core() to use =

> that value instead of SECINITSID_UNLABELED for invalid SIDs.  Then the =

> inode would be treated as having the defcontext for access control and =

> getxattr() w/o CAP_MAC_ADMIN purposes, but a subsequent policy =

> update/reload that makes the context valid would automatically cause =

> subsequent accesses to the inode to start using the original context =

> value for access control and getxattr() purposes.  I think that's the =

> behavior you want.

Right, that's exactly it.

> =

> >>>> So this would be a divergence in semantics for defcontext=3D between
> >>>> local/FS_USE_XATTR and NFS/FS_USE_NATIVE filesystems.
> >>>
> >>> Yeah, I also didn't like this semantics mismatch. But from another po=
int
> >>> defcontext allows to assign a context to files that would otherwise be
> >>> unlabeled. Something similar I'd like to achive for NFS.
> >>
> >> Yes, I can see the appeal of it.  I guess the question is whether we
> >> can/should do it via defcontext=3D or via some new option, and if we d=
o it
> >> via defcontext=3D, can/should we change the semantics for local/xattr
> >> filesystems to match?  Wondering how widely defcontext=3D is actually =
used.
> > =

> > Is the current behavior of defcontext for xattrs intentional or it is a
> > side effect? Honestly it is a bit confusing. Without defcontext really
> > unlabeled files and files with invalid labels are treated as unlabeled.
> > Can a user without MAC_ADMIN even distinguish them? With defcontext only
> > really unlabeled files get default context, but invalid labels still
> > remain unlabeled.
> =

> It was intentional at the time, but the history is somewhat convoluted. =

> The two cases are actually distinguished by different initial SIDs =

> (SECINITSID_FILE vs SECINITSID_UNLABELED) and used to have different =

> types in policy (file_t vs unlabeled_t), but this distinction has been =

> coalesced in modern policies (where file_t is an alias of unlabeled_t).
> IIRC, the original distinction was to support migration from non-SELinux =

> to SELinux since filesystems were initially unlabeled. defcontext=3D was =

> originally just a way of specifying per-mount alternatives to the global =

> policy definition of the context for SECINITSID_FILE.
> =

> > =

> > IMO it would be more consistent if defcontext cover all "unlabeled"
> > groups. It seems unlikely to me that somebody who currently uses
> > defcontext can somehow rely on mapping invalid labels to unlabeled
> > instead of default context.
> =

> Yes, and that seems more consistent with the current documentation in =

> the mount man page for defcontext=3D.
> =

> I'd be inclined to change selinux_inode_notifysecctx() to call =

> security_context_to_sid_default() directly instead of using =

> selinux_inode_setsecurity() and change security_context_to_sid_core() =

> and sidtab_search_core() as suggested above to save and use the def_sid =

> instead of SECINITSID_UNLABELED always (initializing the context def_sid =

> to SECINITSID_UNLABELED as the default).  selinux_inode_setsecurity() we =

> should leave unchanged, or if we change it at all, it should be more =

> like the handling in selinux_inode_setxattr().  The notifysecctx hook is =

> invoked by the filesystem to notify the security module of the file's =

> existing security context, so in that case we always want the _default =

> behavior, whereas the setsecurity hook is invoked by the vfs or the =

> filesystem to set the security context of a file to a new value, so in =

> that case we would only use the _force interface if the caller had =

> CAP_MAC_ADMIN.
> =

> Paul, what say you?  NB This would be a user-visible behavior change for =

> mounts specifying defcontext=3D on xattr filesystems; files with invalid =

> contexts will then show up with the defcontext value instead of the =

> unlabeled context.  If that's too risky, then we'd need a flag or =

> something to security_context_to_sid_default() to distinguish the =

> behaviors and only set it when called from selinux_inode_notifysecctx().

Paul, if you are OK with this approach, then I'll prepare a patch.
