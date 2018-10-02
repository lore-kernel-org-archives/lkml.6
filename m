Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F28C64EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC34620666
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:40:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC34620666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbeJCCZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 22:25:01 -0400
Received: from uhil19pa09.eemsg.mail.mil ([214.24.21.82]:54149 "EHLO
        uhil19pa09.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbeJCCZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 22:25:01 -0400
X-EEMSG-check-008: 321726336|UHIL19PA09_EEMSG_MP7.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by uhil19pa09.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 02 Oct 2018 19:39:59 +0000
X-IronPort-AV: E=Sophos;i="5.54,333,1534809600"; 
   d="scan'208";a="16452779"
IronPort-PHdr: =?us-ascii?q?9a23=3AnNySHxWerOCh3uVEHAMhzOGgejPV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYZRSGtadThVPEFb/W9+hDw7KP9fy4BipYud6oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9uLhi6txndutULioZ+N6g9zQ?=
 =?us-ascii?q?fErGFVcOpM32NoIlyTnxf45siu+ZNo7jpdtfE8+cNeSKv2Z6s3Q6BWAzQgKG?=
 =?us-ascii?q?A1+dbktQLfQguV53sTSXsZnxxVCAXY9h76X5Pxsizntuph3SSRIMP7QawoVT?=
 =?us-ascii?q?mk8qxmUwHjhjsZODEl8WHXks1wg7xdoBK9vBx03orYbJiIOPZiYq/ReNUXSm?=
 =?us-ascii?q?RbXsZVSidPHIWyYYUSBOYFJOpUsZXxq14IoBCjBwejGfnvxydViHHo06000+?=
 =?us-ascii?q?cvHw/I0wMvHd0BrHvaoc7pNKoQS+250LXEwDvBYv5QxDzz6JLIchckofyUQL?=
 =?us-ascii?q?xwbdTeyVEvFwzbiFWbtJHrPzaP2eQJt2iU8ephXv+ohm48tg5xuSOixtssi4?=
 =?us-ascii?q?bVhoIVzUrI9SNiwIkvP9G4R0l7YcC9HZZWqiqUNJN2T9s/T2xntys20L0LtY?=
 =?us-ascii?q?OhcCQUx5kr2QTTZ+GBfoOV+BzsTvyRLi19hH99fbK/gAu9/la4x+3nU8m0zE?=
 =?us-ascii?q?5Kri1YktnQrnwN1wLc6syASvZl4keuwyyP1wHO6uFfO0w0iaraJIIhwr43jJ?=
 =?us-ascii?q?YTt1jMHjTql0nsia+Wd0Ek9vCp6+ThfLrmuoeRO5J7hwzxKKgjmtGzDf4mPg?=
 =?us-ascii?q?UBQWSX4/mw2KXm/ULjQbVKivM2krPesJDfPckbvbO2AxRO34Y/6xewEzem0N?=
 =?us-ascii?q?MCkXkBN1JKYgiLj4fuO1HQOPz4F+uwg0ywkDd3wPDLJqHhDY/OLnjElrfuYK?=
 =?us-ascii?q?x95FRHxQUvzNBf/I5bCrYbLP3vXU/xscTSDgUlPAys3+bnFNJ925sGWW2VH6?=
 =?us-ascii?q?+ZNLjfsUeS6eIyJ+mAfYoVuDH6K/g/+fHil2M2mVgYfaOxx5sYdGi4Huh6I0?=
 =?us-ascii?q?WeeXfshtYBEWEXvgsxVeDqi0ONUSRVZ3msW6Ix/S87CI24AofZXIytg6KO3D?=
 =?us-ascii?q?29HpJIYmBKEFeMEW3nd4+cQfcDdDqSItN9kjwDTbWgRJEu2QiqtA/7zbpnM+?=
 =?us-ascii?q?XV9jQGupPsyNh6+ffTlRco+jxwFMmSz2CNT3pokWMPXTM5wKd/oUkugmuEhJ?=
 =?us-ascii?q?RxmfVDXf9U4f9TWxs7KJ2Um/BzCNf0VhjIVtyIU12hBN6hBGd1Buo43ttGRk?=
 =?us-ascii?q?F6Adjq2gjKwi6CG7YIk/mOA5su/+TX2H2ndOhnzHOT77Usl1krRIN0MGSigq?=
 =?us-ascii?q?Nuv1zIC5Xhj1SSl6Hsc78VmiHK6jHQniK1oEhEXVsoAu3+VncFax6T9I6h6w?=
 =?us-ascii?q?=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BpAAB1yLNb/wHyM5BbGgEBAQEBAgEBAQEHAgEBAQGDN?=
 =?us-ascii?q?SqBZYQclDBMAQEBAQEBBoEILYhtj2k2AYRAAoQOITgUAQMBAQEBAQECAWwog?=
 =?us-ascii?q?jUkAYJfAQUjBBFBEAsOCgICJgICVwYBDAgBAYJeP4F1Dac/ezOEd4UggQuJe?=
 =?us-ascii?q?Bd5gQeBOYJrh3+CVwKOUo5qCZAyBheBSY4RiHuOHiGBVSsIAhgIIQ+DKIIkF?=
 =?us-ascii?q?440I4ErAQGNTgEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 02 Oct 2018 19:39:58 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w92JdvfT022016;
        Tue, 2 Oct 2018 15:39:57 -0400
Subject: Re: [RFC PATCH] selinux: add a fallback to defcontext for native
 labeling
To:     Taras Kondratiuk <takondra@cisco.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        xe-linux-external@cisco.com
References: <20180919165248.53090-1-takondra@cisco.com>
 <9a944aea-f35e-5a49-841d-6bfca8f17b9d@tycho.nsa.gov>
 <153748436388.5590.1406237328277739821@takondra-t460s>
 <66ec16b0-a335-d9ef-deb3-ef391cdd66e0@tycho.nsa.gov>
 <CAHC9VhRorkfqRTsssx_eGMy+fJQtoJew7f5i24UBkZ6tGJ5CUw@mail.gmail.com>
 <153785433233.5039.17960184426345262866@takondra-t460s>
 <a23ad753-8fd4-e9c3-cdbf-391ee154794b@tycho.nsa.gov>
 <CAHC9VhRRArA7_ON5P2JfrKxExwzm5Wznj150pfgijBoR+JxYBA@mail.gmail.com>
 <a185b384-5ef1-5e53-2cc1-066391424dcb@tycho.nsa.gov>
 <153790265614.6091.7582646556934797699@takondra-t460s>
 <153850609939.4490.12129272851093190248@takondra-t460s>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <91112a5a-2e67-28cf-b8a5-b80dc9385bb7@tycho.nsa.gov>
Date:   Tue, 2 Oct 2018 15:41:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <153850609939.4490.12129272851093190248@takondra-t460s>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/2018 02:48 PM, Taras Kondratiuk wrote:
> Quoting Stephen Smalley (2018-09-21 07:40:58)
>> If we set the inode sid to the superblock def_sid on an invalid
>> context, then we lose the association to the original context value.
>> The support for deferred mapping of contexts requires allocating a new
>> SID for the invalid context and storing that SID in the inode, so that
>> if the context later becomes valid upon a policy update/reload, the
>> inode SID will refer to the now valid context.
>> To combine the two, we would need security_context_to_sid_core() to
>> save the def_sid in the context structure for invalid contexts, and
>> change sidtab_search_core() to use that value instead of
>> SECINITSID_UNLABELED for invalid SIDs.  Then the inode would be
>> treated as having the defcontext for access control and getxattr() w/o
>> CAP_MAC_ADMIN purposes, but a subsequent policy update/reload that
>> makes the context valid would automatically cause subsequent accesses
>> to the inode to start using the original context value for access
>> control and getxattr() purposes.  I think that's the behavior you
>> want.
>>
> 
> While implementing the change I've realized that storing default context
> for sidtab_search_core() in the context structure is not enough to
> achieve the desired behavior. The same invalid context may exist in two
> mounts with different 'defcontext', so default context can't be a
> property of a context structure.
> 
> One way to address it is to propagate default context to sidtab_search() all
> the way from inode hooks. But that will be a bit intrusive. Something like
> avc_has_perm_default() will need to be added.
> 
> Other way is to check for context validity in inode hooks and provide a default
> context to avc_has_perm() if the inode's sid is invalid. But this may have
> performance implication since validity check will be done each time in fast
> path.
> 
> Do you see any other options?

I think the original approach is still best.  The def_sid can be part of 
the context structure; you just need to update context_cmp() to compare 
it (as part of the first return statement) so that the same invalid 
context in two mounts with different defcontext= values will allocate 
different SIDs.  Likewise context_cpy() needs to copy the def_sid.

As a separate matter, you should also modify 
security_context_to_sid_force() to pass down the sbsec->def_sid so that 
when userspace with CAP_MAC_ADMIN sets an invalid context on an inode, 
the default context will be used in the same manner.
