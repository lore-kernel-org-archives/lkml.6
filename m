Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B32ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F282C21526
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:47:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F282C21526
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732857AbeITUb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 16:31:27 -0400
Received: from ucol19pa10.eemsg.mail.mil ([214.24.24.83]:23218 "EHLO
        UCOL19PA10.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727633AbeITUb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 16:31:26 -0400
X-EEMSG-check-008: 591759856|UCOL19PA10_EEMSG_MP8.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.53,398,1531785600"; 
   d="scan'208";a="591759856"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA10.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 20 Sep 2018 14:47:30 +0000
X-IronPort-AV: E=Sophos;i="5.53,398,1531785600"; 
   d="scan'208";a="16056625"
IronPort-PHdr: =?us-ascii?q?9a23=3A2cJhuBMbbSHMgGjVu9gl6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0K/36pcbcNUDSrc9gkEXOFd2Cra4c1KyO6+jJYi8p2d65qncMcZhBBV?=
 =?us-ascii?q?cuqP49uEgeOvODElDxN/XwbiY3T4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx?=
 =?us-ascii?q?7xKRR6JvjvGo7Vks+7y/2+94fcbglUhjexe69+IAmrpgjNq8cahpdvJLwswR?=
 =?us-ascii?q?XTuHtIfOpWxWJsJV2Nmhv3+9m98p1+/SlOovwt78FPX7n0cKQ+VrxYES8pM3?=
 =?us-ascii?q?sp683xtBnMVhWA630BWWgLiBVIAgzF7BbnXpfttybxq+Rw1DWGMcDwULs5Qi?=
 =?us-ascii?q?qp4bt1RxD0iScHLz85/3/Risxsl6JQvRatqwViz4LIfI2ZMfxzca3HfdMeWG?=
 =?us-ascii?q?FPQMBfWSJcCY+4docDEfYNMeNeooLgpVUBsAG+CBGxCu3xxD9Ghnz406M03O?=
 =?us-ascii?q?suEw7JwAMuEskSsHnWttj5KLseXO63waTO0D7Nb+lW2TD46IXQbx4hve+DXa?=
 =?us-ascii?q?pwccXPz0kkCh7LjlCKpozhOzOayOQMuHWc4up7SO2vkHUqqx1xozezxscsjZ?=
 =?us-ascii?q?PFhoQOyl/e7yl5z4E1JcOhRUN9fNWqE4NQujmHO4Z5Tc4uWWFltDsgxrEYtp?=
 =?us-ascii?q?O3YjIGxIkhyhXCcfKIaZKI7QjmVOuJJDd4g29qd6ynihap9Eig1vX8Vs6p0F?=
 =?us-ascii?q?ZWtiZFksfDtnQK1xHL9siIUOF9/ka82TaUzQzT9uFFLlw0larcMZIhxKI/lo?=
 =?us-ascii?q?EPvkjZGy/2mUH2gLeXdkUi5Oeo9/zqbqjpq5KTLYN5ihzyPr4wlsGwH+g0KB?=
 =?us-ascii?q?UCU3Ce+eum1b3j+UP5QK9Njv0ziqTZq43VJd8Aq66lAw5azoYj6xGlAzegy9?=
 =?us-ascii?q?QXh2MLLF1CeBKZl4TpIU3BIOjkDfejhFShiCtryOrFPr3mBJXCM2LDn636cL?=
 =?us-ascii?q?lh6k5c0xY8zddF651IDbEBJer5WlXtu9zAEh85Lwu0zv75B9VlzIweQ2OPAr?=
 =?us-ascii?q?SCPaPKq1CI/OMvI/KUZI8RojnyN+Yq6+TpjX8jll8XZbOp0ocPaHCkAvRmJF?=
 =?us-ascii?q?2UYWL2jdccFWcHpRI+Q/b3iF2GSDJTYnGyX6Um5j4lEo6pEYDDRoW1irybwC?=
 =?us-ascii?q?i7BoFWZnxBCl2UFXfodoOEW+oDaS6LIc9ujCYEVb6/RI8lzhyuqgD6xKR9Lu?=
 =?us-ascii?q?bO+S0Xq4jj1N5r6O3Xjx0y8iZ0D8uF2WGXU250hn8IRyMx3K1nrk1y1E6P0a?=
 =?us-ascii?q?x5g/xeCNxS6OpFXRk1NJ7A0eN6EdbyVRjFftqSVFmmQ86mDi02Tt4r39AOZE?=
 =?us-ascii?q?N9SJ2eiUX/1jCjGPc2kLqHHpUo87/flyztLsV6zXrc3YEqjkItRY1EMmjwwu?=
 =?us-ascii?q?ZS7QnYT7bAiUSC3/Knba0G3TXl7G6ZzHGWuEhTXUh3S6qTGTgnb1bS5fH+4V?=
 =?us-ascii?q?nPB+u2AKkjGhNI1MrHL6xNcNCvhlJDEqTNItPbNlmtln+wCBDA/baFaI7nai?=
 =?us-ascii?q?1JxynGIFQVmAAUu3CdPE4xATn38DGWNyBnCV+6OxCkyuJ5sn7uCxZulww=3D?=
X-IPAS-Result: =?us-ascii?q?A2AWAABssqNb/wHyM5BbGgEBAQEBAgEBAQEIAQEBAYFQg?=
 =?us-ascii?q?VkFKoFkKINziBWMMFABAQaBNYhpjWWBejYBhEACg0EhNBgBAwEBAQEBAQIBb?=
 =?us-ascii?q?CiCNSQBgl4BAQEBAgEjBBE0CgMFCwsOCgICJgICVwYBDAYCAQEXgkc/gXUFC?=
 =?us-ascii?q?KQIezOEd4UggQuJZBd5gQeBOYJrhEchgxeCVwKIIiEQhWOOOAmQHgYXgUSNX?=
 =?us-ascii?q?ohojU84gVUrCAIYCCEPgyeCJReONCMwewEBiiuCTAEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 20 Sep 2018 14:47:29 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8KElQWc011541;
        Thu, 20 Sep 2018 10:47:27 -0400
Subject: Re: [RFC PATCH] selinux: add a fallback to defcontext for native
 labeling
To:     Taras Kondratiuk <takondra@cisco.com>,
        Eric Paris <eparis@parisplace.org>,
        Paul Moore <paul@paul-moore.com>
Cc:     selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        xe-linux-external@cisco.com
References: <20180919165248.53090-1-takondra@cisco.com>
 <f283c1e7-19eb-2b99-3fef-a19e2bf99a2b@tycho.nsa.gov>
 <153741130781.7326.1773144725860636439@takondra-t460s>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <9a944aea-f35e-5a49-841d-6bfca8f17b9d@tycho.nsa.gov>
Date:   Thu, 20 Sep 2018 10:49:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <153741130781.7326.1773144725860636439@takondra-t460s>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/19/2018 10:41 PM, Taras Kondratiuk wrote:
> Quoting Stephen Smalley (2018-09-19 12:00:33)
>> On 09/19/2018 12:52 PM, Taras Kondratiuk wrote:
>>> When files on NFSv4 server are not properly labeled (label doesn't match
>>> a policy on a client) they will end up with unlabeled_t type which is
>>> too generic. We would like to be able to set a default context per
>>> mount. 'defcontext' mount option looks like a nice solution, but it
>>> doesn't seem to be fully implemented for native labeling. Default
>>> context is stored, but is never used.
>>>
>>> The patch adds a fallback to a default context if a received context is
>>> invalid. If the inode context is already initialized, then it is left
>>> untouched to preserve a context set locally on a client.
>>
>> Can you explain the use case further?  Why are you exporting a
>> filesystem with security labeling enabled to a client that doesn't
>> understand all of the labels used within it?  Why wouldn't you just
>> disable NFSv4 security labeling and/or use a regular context= mount to
>> assign a single context to all files in the mount?
> 
> Client and server are two embedded devices. They are part of a bigger
> modular system and normally run the same SW version, so they understand
> each others NFSv4 SELinux labels. But during migration from one SW
> version to another a client and a server may run different versions for
> some time.
> 
> The immediate issue I'm trying to address is a migration between
> releases with and without SELinux policy. A client (with policy) gets
> initial SID labels from a server (without policy). Those labels are
> considered invalid, so files remain unlabeled. This also causes lots of
> errors from nfs_setsecurity() in dmesg.

Why are you enabling SELinux on the server without loading a policy? 
Are you concerned about denials on the server? For that, you could 
always run it permissive until you are confident you have a working policy.

Why are you enabling security_label in exports before you have a policy 
loaded?  It doesn't appear that will ever work, since nfsd asks the 
security module for the labels, not the local filesystem directly.

I understand that this doesn't fully address your use case, but it seems 
like you could avoid this particular situation altogether just by 
loading a policy (at which point your server can return actual contexts) 
or by removing security_label from your exports (at which point your 
server won't try returning contexts and the client will just apply the 
default for nfs) until you get to the point of loading a policy.

> Using 'context=' at mount point level is an option, but in a normal case
> when both sides have a policy we need more granular labels. It is
> possible to detect a case when a server doesn't have a policy and
> remount with 'context=', but this special case handling looks a bit
> ugly. Having something like 'defcontext' whould allow to avoid this
> special case and unconditionally assign default context to the
> mountpoint.
> 
> 'defcontext' may also help during migration between SELinux-enabled
> releases if a new release introduces labels that are not recognized by
> older release. In this case they can also fallback to defcontext.

This is the more interesting case.  And what would these defcontext 
values be?  A context that is generally accessible to all domains on the 
client?  Or one that is restricted to only unconfined domains?  Would it 
be fundamentally different from unlabeled?  Will it really differ 
per-mount, and if so, why?

> 
>>
>> To be clear, defcontext= doesn't work that way for local/FS_USE_XATTR
>> filesystems. The context specified by it is only used for:
>> 1) files that don't implement the xattr inode operations at all,
>> 2) files that lack a security.selinux xattr,
>> 3) the MLS portion of the context if it was missing (strictly as a
>> legacy compatibility mechanism for RHEL4 which predated the enabling of
>> the MLS field/logic).
>>
>> A file with a security.selinux xattr that is invalid under policy for
>> any reason other than a missing MLS field will be handled as having the
>> unlabeled context.
> 
> inode_doinit_with_dentry() invokes security_context_to_sid_default()
> that invokes security_context_to_sid_core() with 'force' flag. Won't
> sidtab_context_to_sid() in this case allocate a new SID for the invalid
> xattr context instead of leaving it unlabeled?

It will be treated as having the unlabeled context for access control 
purposes and that is what getxattr will return to userspace processes 
unless they have CAP_MAC_ADMIN and SELinux mac_admin permission, but 
internally SELinux will keep track of the original xattr context value 
and will later retry to map it upon a policy reload, switching over to 
using it for access control and getxattr if it becomes valid under a new 
policy.  That support was added to support scenarios where a package 
manager sets a file context before it has loaded the policy module that 
defines it, or scenarios where one is generating a filesystem image for 
another OS/release with different policy. That is likely something you 
need/want for NFS as well if you want the client to start using the 
context as soon as it becomes valid upon a policy update/reload and not 
have to wait for the inode to be evicted.

> 
>>
>> So this would be a divergence in semantics for defcontext= between
>> local/FS_USE_XATTR and NFS/FS_USE_NATIVE filesystems.
> 
> Yeah, I also didn't like this semantics mismatch. But from another point
> defcontext allows to assign a context to files that would otherwise be
> unlabeled. Something similar I'd like to achive for NFS.

Yes, I can see the appeal of it.  I guess the question is whether we 
can/should do it via defcontext= or via some new option, and if we do it 
via defcontext=, can/should we change the semantics for local/xattr 
filesystems to match?  Wondering how widely defcontext= is actually used.

> 
>>
>>>
>>> Signed-off-by: Taras Kondratiuk <takondra@cisco.com>
>>> ---
>>>    security/selinux/hooks.c | 25 ++++++++++++++++++++++++-
>>>    1 file changed, 24 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>>> index ad9a9b8e9979..f7debe798bf5 100644
>>> --- a/security/selinux/hooks.c
>>> +++ b/security/selinux/hooks.c
>>> @@ -6598,7 +6598,30 @@ static void selinux_inode_invalidate_secctx(struct inode *inode)
>>>     */
>>>    static int selinux_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
>>>    {
>>> -     return selinux_inode_setsecurity(inode, XATTR_SELINUX_SUFFIX, ctx, ctxlen, 0);
>>> +     struct superblock_security_struct *sbsec;
>>> +     struct inode_security_struct *isec;
>>> +     int rc;
>>> +
>>> +     rc = selinux_inode_setsecurity(inode, XATTR_SELINUX_SUFFIX, ctx, ctxlen, 0);
>>
>> In this case, we likely don't gain much by reusing
>> selinux_inode_setsecurity() here and could just inline the relevant
>> portion of it if we were to make this change.  Logically they mean
>> different things.
>>
>>> +
>>> +     /*
>>> +      * In case of Native labeling with defcontext mount option fall back
>>> +      * to a default SID if received context is invalid.
>>> +      */
>>> +     if (rc == -EINVAL) {
>>> +             sbsec = inode->i_sb->s_security;
>>> +             if (sbsec->behavior == SECURITY_FS_USE_NATIVE &&
>>> +                 sbsec->flags & DEFCONTEXT_MNT) {
>>> +                     isec = inode->i_security;
>>> +                     if (!isec->initialized) {
>>> +                             isec->sclass = inode_mode_to_security_class(inode->i_mode);
>>> +                             isec->sid = sbsec->def_sid;
>>> +                             isec->initialized = 1;
>>> +                     }
>>> +                     rc = 0;
>>> +             }
>>> +     }
>>> +     return rc;
>>>    }
>>>    
>>>    /*
>>>
>>

