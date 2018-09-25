Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF9DC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 13:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 083882098A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 13:58:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 083882098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbeIYUGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 16:06:00 -0400
Received: from upbd19pa12.eemsg.mail.mil ([214.24.27.87]:42065 "EHLO
        upbd19pa12.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbeIYUGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 16:06:00 -0400
X-EEMSG-check-008: 159776048|UPBD19PA12_EEMSG_MP12.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by upbd19pa12.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 25 Sep 2018 13:58:15 +0000
X-IronPort-AV: E=Sophos;i="5.54,302,1534809600"; 
   d="scan'208";a="18632428"
IronPort-PHdr: =?us-ascii?q?9a23=3AWkpK/xZNKYLnvqglnTo8TY7/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZpsy9Yh7h7PlgxGXEQZ/co6odzbaO7Oa4ASQp2tWoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTahY75+Ngm6oRnMvcQKnIVuLbo8xA?=
 =?us-ascii?q?HUqXVSYeRWwm1oJVOXnxni48q74YBu/SdNtf8/7sBMSar1cbg2QrxeFzQmLn?=
 =?us-ascii?q?s65Nb3uhnZTAuA/WUTX2MLmRdVGQfF7RX6XpDssivms+d2xSeXMdHqQb0yRD?=
 =?us-ascii?q?+v9LlgRgP2hygbNj456GDXhdJ2jKJHuxKquhhzz5fJbI2JKPZye6XQct0ARW?=
 =?us-ascii?q?pFQ81fSSpPDI2hZIcLFuYNI/pUo4z7qlATrxWxGBOsCfvyxDFWiH/43a403e?=
 =?us-ascii?q?ovHg7J3gMvA90AvW/IrNj3LqoeTfy5wafKwDjFcvhY2S396I/Nch05vP+MQa?=
 =?us-ascii?q?x/cdLRyUYxEQPOk0ieqYn/MDOR0uQCrWia5PdnWOK0lmEnsBp8oiSvx8gwio?=
 =?us-ascii?q?nJgZgZylbf9Spj2oo1Ktq4SFBibNOiDZBetDmaOpNrTs4tTGxkoiY3xqActZ?=
 =?us-ascii?q?KlcyUG1o4rywPZZveaaYaH+AjjW/yUITpggXJlf6+wiAiq/Ei7z+38StG00F?=
 =?us-ascii?q?FXripZitXMtm4C1xjU6sWfVvty5F2h2TeS1wDI8O1EPUA1mrbbK54m2LIwkI?=
 =?us-ascii?q?YcsV/fESPsnUX2jauWel0l+uiu9evnfq3rqoKTOoJ7kA3zMrkiltahDek3LA?=
 =?us-ascii?q?QCRXWX9fy51LL5/E35RLtKjucxkqncqJ3aPtkUprWiDg9J0ocs9xa/DzC83N?=
 =?us-ascii?q?QehnkINkhJeB2Aj4j3I13OOuz3De+jg1Swlzdm3+zGMafiApXKKHjMja3hcq?=
 =?us-ascii?q?xm5kFAyQoz1sxQ55VOBr4dJ/LzX1f7tMbEAR8hLwy03+HnBc1l1owERGKPBr?=
 =?us-ascii?q?SUMLvIvl+V4uIjOuyMZIgSuDbnNfcp/eLhjXg8mVUFZ6mmwYMXaGykHvRhO0?=
 =?us-ascii?q?iWf2Lsjc0bEWcLpQozV/Tqh0eYUT5SfHayR6Y86SsnB424F4vDQZqtgLOZ1i?=
 =?us-ascii?q?ehApJWfnxGCkyLEXrwc4WEWvEMaD+dI8N4kTwLS6KhS4k/2hGqrwL61bVnIf?=
 =?us-ascii?q?TO+iECtpLsysJ15+vNmhE27zB0CN6d026VRWFugmwIXyM23Lx4oUFlxVaMz7?=
 =?us-ascii?q?F0g/hZFdxV+vNIXR42OoDTzuxmFd/yQATBcc2NSFu9XtqmACoxQc42w9MUf0?=
 =?us-ascii?q?l9HNCi3Vj/2H+WCqUcjPSoA5o46KvA3mXyb5JhwnXB0qU7hnEtQ9BEMiutga?=
 =?us-ascii?q?sps0DrDpPN22CekLynPfAE1TPJ3H+K0G7LuUZfSgM2WqLACyMxfEzT+O/l61?=
 =?us-ascii?q?vCQrnmMrEuNg9M2IbWMadRQsH4hlVBAvH4MZLRZHznyDT4PgqB2r7ZNNmiQG?=
 =?us-ascii?q?4axiiITRFeyw0=3D?=
X-IPAS-Result: =?us-ascii?q?A2BlAAD7Papb/wHyM5BbGgEBAQEBAgEBAQEHAgEBAQGDN?=
 =?us-ascii?q?SqBZCiDdJRCUgaBCC2IaI9gNgGEQAKDYyE4FAEDAQEBAQEBAgFsKII1JAGCX?=
 =?us-ascii?q?wEFIxVBEAsOCgICJgICVwYBDAYCAQEXgkc/gXUNo0CBLoR3hSOBC4lvF3mBB?=
 =?us-ascii?q?4E5gW1+h3+CVwKIRIU5QY5BCZAjBhePLJZiIYFVKwgCGAghD4MngiAFF440I?=
 =?us-ascii?q?zB7AQGNGwEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 25 Sep 2018 13:58:14 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8PDwESl024660;
        Tue, 25 Sep 2018 09:58:14 -0400
Subject: Re: [RFC PATCH] selinux: add a fallback to defcontext for native
 labeling
To:     Taras Kondratiuk <takondra@cisco.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
        linux-kernel@vger.kernel.org, xe-linux-external@cisco.com
References: <20180919165248.53090-1-takondra@cisco.com>
 <f283c1e7-19eb-2b99-3fef-a19e2bf99a2b@tycho.nsa.gov>
 <153741130781.7326.1773144725860636439@takondra-t460s>
 <9a944aea-f35e-5a49-841d-6bfca8f17b9d@tycho.nsa.gov>
 <153748436388.5590.1406237328277739821@takondra-t460s>
 <66ec16b0-a335-d9ef-deb3-ef391cdd66e0@tycho.nsa.gov>
 <CAHC9VhRorkfqRTsssx_eGMy+fJQtoJew7f5i24UBkZ6tGJ5CUw@mail.gmail.com>
 <153785433233.5039.17960184426345262866@takondra-t460s>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <a23ad753-8fd4-e9c3-cdbf-391ee154794b@tycho.nsa.gov>
Date:   Tue, 25 Sep 2018 10:00:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <153785433233.5039.17960184426345262866@takondra-t460s>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/25/2018 01:45 AM, Taras Kondratiuk wrote:
> Quoting Paul Moore (2018-09-24 20:46:57)
>> On Fri, Sep 21, 2018 at 10:39 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>> On 09/20/2018 06:59 PM, Taras Kondratiuk wrote:
>>>> Quoting Stephen Smalley (2018-09-20 07:49:12)
>>>>> On 09/19/2018 10:41 PM, Taras Kondratiuk wrote:
>>>>>> Quoting Stephen Smalley (2018-09-19 12:00:33)
>>>>>>> On 09/19/2018 12:52 PM, Taras Kondratiuk wrote:
>>
>> ...
>>
>>>> IMO it would be more consistent if defcontext cover all "unlabeled"
>>>> groups. It seems unlikely to me that somebody who currently uses
>>>> defcontext can somehow rely on mapping invalid labels to unlabeled
>>>> instead of default context.
>>>
>>> Yes, and that seems more consistent with the current documentation in
>>> the mount man page for defcontext=.
>>>
>>> I'd be inclined to change selinux_inode_notifysecctx() to call
>>> security_context_to_sid_default() directly instead of using
>>> selinux_inode_setsecurity() and change security_context_to_sid_core()
>>> and sidtab_search_core() as suggested above to save and use the def_sid
>>> instead of SECINITSID_UNLABELED always (initializing the context def_sid
>>> to SECINITSID_UNLABELED as the default).  selinux_inode_setsecurity() we
>>> should leave unchanged, or if we change it at all, it should be more
>>> like the handling in selinux_inode_setxattr().  The notifysecctx hook is
>>> invoked by the filesystem to notify the security module of the file's
>>> existing security context, so in that case we always want the _default
>>> behavior, whereas the setsecurity hook is invoked by the vfs or the
>>> filesystem to set the security context of a file to a new value, so in
>>> that case we would only use the _force interface if the caller had
>>> CAP_MAC_ADMIN.
>>>
>>> Paul, what say you?  NB This would be a user-visible behavior change for
>>> mounts specifying defcontext= on xattr filesystems; files with invalid
>>> contexts will then show up with the defcontext value instead of the
>>> unlabeled context.  If that's too risky, then we'd need a flag or
>>> something to security_context_to_sid_default() to distinguish the
>>> behaviors and only set it when called from selinux_inode_notifysecctx().
>>
>> Visible changes like this are always worrisome, even though I think it
>> is safe to assume that the defcontext option is not widely used.  I'd
>> feel much better if this change was opt-in.
>>
>> Which brings about it's own problems.  We have the policy capability
>> functionality, but that is likely a poor fit for this as the policy
>> capabilities are usually controlled by the Linux distribution while
>> the mount options are set by the system's administrator when the
>> filesystem is mounted.  We could add a toggle somewhere in selinuxfs,
>> but I really dislike that idea, and would prefer to find a different
>> solution if possible.  I'm not sure how much flak we would get for
>> introducing a new mount option, but perhaps that is the best way to
>> handle this: defcontext would continue to behave as it does now, but
>> new option X would behave as mentioned in this thread.
>>
>> Thoughts?
> 
> The new option X will also mean "default context", so it will be pretty
> hard to come up with a different but a sensible name. I'm afraid that
> having two options with hardly distinguishable semantics will be very
> confusing.
> 
> What about a kernel config option that modifies the behavior of
> defcontext?

First, the existing documentation for defcontext= leaves open the door 
to the proposed new behavior.  From mount(8):
"You can set the default security context for  unlabeled  files  using 
defcontext= option.  This overrides the value set for unlabeled files in 
the policy and requires a filesystem that supports xattr labeling."

"Unlabeled files" could just mean files without any xattr, or it could 
mean all files that either lack an xattr or have an invalid one under 
the policy, since both sets of files are currently mapped to the 
unlabeled context.

Second, under what conditions would this situation break existing 
userspace?  The admin would have had to mount an xattr filesystem with 
defcontext= specified, and that filesystem would have to both contain 
files without any xattrs and files with invalid ones (otherwise how they 
are treated by the kernel is irrelevant), and the policy would need to 
distinguish access to files without xattrs vs files with invalid ones. 
Seems unlikely.

Third, the fact that policy maintainers remapped both SECINITSID_FILE 
(the default value for defcontext) and SECINITSID_UNLABELED (used for 
invalid contexts) to the unlabeled context (getting rid of file_t as a 
separate type, aliased to unlabeled_t) long ago suggests that there is 
no meaningful difference there.

I'm inclined to just change the behavior for defcontext= unconditionally 
and have it apply to both native and xattr labeling.  If that's a no-go, 
then the simplest solution is to just leave defcontext= behavior 
unchanged for xattr labeling and only implement the new semantics for 
native labeling.  That's just a matter of adding a flag to 
security_context_to_sid_default() and only setting it when calling from 
selinux_inode_notifysecctx().
