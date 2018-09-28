Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C170C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 20:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44E492073F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 20:31:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44E492073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbeI2C5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 22:57:05 -0400
Received: from ucol19pa13.eemsg.mail.mil ([214.24.24.86]:36016 "EHLO
        ucol19pa13.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbeI2C5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 22:57:05 -0400
X-EEMSG-check-008: 629948039|UCOL19PA13_EEMSG_MP11.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.54,316,1534809600"; 
   d="scan'208";a="629948039"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by ucol19pa13.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 28 Sep 2018 20:31:32 +0000
X-IronPort-AV: E=Sophos;i="5.54,316,1534809600"; 
   d="scan'208";a="18825008"
IronPort-PHdr: =?us-ascii?q?9a23=3A2ns7rRXyjgd+zlda/YxrFs3rcJbV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYZRGCu6dThVPEFb/W9+hDw7KP9fy4BipYud6oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9uLhi6txndutULioZ+N6g9zQ?=
 =?us-ascii?q?fErGFVcOpM32NoIlyTnxf45siu+ZNo7jpdtfE8+cNeSKv2Z6s3Q6BWAzQgKG?=
 =?us-ascii?q?A1+dbktQLfQguV53sTSXsZnxxVCAXY9h76X5Pxsizntuph3SSRIMP7QawoVT?=
 =?us-ascii?q?mk8qxmUwHjhjsZODEl8WHXks1wg7xdoBK9vBx03orYbJiIOPZiYq/ReNUXSm?=
 =?us-ascii?q?RbXsZVSidPHIWyYYUSBOYFJOpUsZXxq14IoBCjBwejGfnvxydViHH2w6M63e?=
 =?us-ascii?q?cvHw/I0wMvHd0BrHvaoc7pNKoRS+250LXEwDvBYv5QxDzz6JLIchckofyUQL?=
 =?us-ascii?q?xwbdTeyVEvFwzbiFWbtJHrPzaP2eQJt2iU8ephXv+ohm48tg5xuSOixtssi4?=
 =?us-ascii?q?bVhoIVzUrI9SNiwIkvP9G4R0l7YcC9HZZWqiqUNJN2T9s/T2xntys20L0LtY?=
 =?us-ascii?q?OhcCQUx5kr2QTTZ+GBfoOV+BzsTvyRLi19hH99fbK/gAu9/la4x+3nU8m0zE?=
 =?us-ascii?q?5Kri1YktnQrnwN1wLc6syASvZl4keuwyyP1wHO6uFfO0w0iaraJIIhwr43jJ?=
 =?us-ascii?q?YTt1jMHjTql0nsia+Wd0Ek9vCp6+ThfLrmuoeRO5J7hwzxKKgjmtGzDf4mPg?=
 =?us-ascii?q?UBQWSX4/mw2KXm/ULjQbVKivM2krPesJDfPckbvbO2AxRO34Y/6xewEzem0N?=
 =?us-ascii?q?MCkXkBN1JKYgiLj4fuO1HQOPz4F+uwg0ywkDd3wPDLJr7hDYvTIXjYjLjher?=
 =?us-ascii?q?F9601HxQUvzdBf/ZVUCrQAIPLuX0/9rtvYDgU2Mwas2eboFM191p8CWWKIGq?=
 =?us-ascii?q?KWLLndsUSW6eMvOOSMf5MauDbnJPg46f7uiWE2mUUEcaa1x5Qbcmy3HvNjI0?=
 =?us-ascii?q?+Be3rjns8BEXsWvgo5VOHqiliCUTlJZ3aoXqI8/So2CIS8AofGWI+tgaaN3C?=
 =?us-ascii?q?ChHp1ZfmpGEEyDEW/0d4WYXPcBcCCSIshhkjwCT7ShSYgh1RG0uw/80LpoMO?=
 =?us-ascii?q?zU9zYEup350th14OvTlRAu+jNuC8SRyX2CT2ZxnmkQXT85wLh/oVBhyleEya?=
 =?us-ascii?q?V4m+JXFdpc5/NUUwc6M4fQz+9kBNDoXALOYNOJRU2nQtm/BTExScwxzMEUb0?=
 =?us-ascii?q?ZmAdqijQ3D3zCwDLMPkbyEGoY48qDE33LpPcZy127G1LU9j1khWsZPLXephr?=
 =?us-ascii?q?N79wXIH47GiViZl6KzeaQZ2y7N832DwnSUsE5EVw5wVL3PXWoDaUvOsdT5+k?=
 =?us-ascii?q?TCQqeyBrs9KQtO186DJrFRatL1jVVJXurjONraY22vgWe9HheIxrWQbIX0f2?=
 =?us-ascii?q?URxjnSCE8BkwoL53aJKRA+Bju9o2LZFDFuEVPvY0Xx8ehxsX+7VVE7wB2Xb0?=
 =?us-ascii?q?171rq15h4UieWZS/MUw70EpSMhpCtvEVaj0NLZFcCAqxBifKpCe9M95klI1W?=
 =?us-ascii?q?bDuwx6JJygILhohkQCfARvo0PuyxJ3B51cnsgttnMl1xR9Kb6D3VNFeTKY24?=
 =?us-ascii?q?r8OrvJJWnu5BqvcbLZ2knC0NaK/acC8PA4q1TlvAG0GUsu6mho095J3HaH+J?=
 =?us-ascii?q?XKAxQdUYjrXkY06Rd6vbfabTc554/O0n1sK6a0uCfY2901HOsl1gqgf9BHPa?=
 =?us-ascii?q?OAFQ/yFdAaBse3JOMwgVimchIEMftM9K47IcymbeGK2K21M+Z6mjKpk2BH7J?=
 =?us-ascii?q?p60kKW+Cp2UvTI0Iodw/GEwguHUC/xjFOgssDxhIBFaigeHmmhxij+Ao5eeK?=
 =?us-ascii?q?lycJ0VCWehPcK33M9yh53zVH5C8l6sGVcG1NWueRqIYFyulTFXgGcarGfvsi?=
 =?us-ascii?q?y/zHQgkDwktaGY2y/myOT4cx8GJ2sNQ3Nt2xOkCoGvgsFSZ0OoZhUnkBa/rR?=
 =?us-ascii?q?LxzrNWtYxkJGnaXElMcjKzJGgkWay14OmseclKvag0vD1XXeL0WlWTTrrwsl?=
 =?us-ascii?q?NOyC/4N3dPzzA8MTexs9P2mAIs2zHVF2p6sHeMIZI4/hzY/tGJAKcLhjc=3D?=
X-IPAS-Result: =?us-ascii?q?A2AHAABsjq5b/wHyM5BcGgEBAQEBAgEBAQEHAgEBAQGBU?=
 =?us-ascii?q?YFkKoFlKIN0iBWMMEwBAQEBAQEGgTWIa41rgXo2AYRAAoN7ITQYAQMBAQEBA?=
 =?us-ascii?q?QECAWwogjUkAYJeAQEBAQIBIw8BBUEFCwkCGAICJgICVwYBDAYCAQGCXj+Bd?=
 =?us-ascii?q?QUIiRqbTYEuigyBC4lzF3mBB4E5gmuEfoMBglcCiCiFX48WCYlOhlwGF4FHj?=
 =?us-ascii?q?gGId41uOIFVKwgCGAghDzuCbJBwIzB7AQGMSAEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 28 Sep 2018 20:31:32 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8SKVVp0021038;
        Fri, 28 Sep 2018 16:31:31 -0400
Subject: Re: [PATCH security-next v3 00/29] LSM: Explict LSM ordering
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Cc:     James Morris <jmorris@namei.org>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20180925001832.18322-1-keescook@chromium.org>
 <e6122c7d-bd29-d081-3c1e-96b7c369d4fe@schaufler-ca.com>
 <CAGXu5jKQVDW8Wp0ESv2raa0xJnHCCMNqFCzZ5jSVXQ=Dp7FF8A@mail.gmail.com>
 <cb49b4c4-a379-7a8e-41a6-6e6a4afb6fe5@tycho.nsa.gov>
Message-ID: <145fab48-969f-0aed-74e8-ac0a5bb1c79b@tycho.nsa.gov>
Date:   Fri, 28 Sep 2018 16:33:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <cb49b4c4-a379-7a8e-41a6-6e6a4afb6fe5@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/28/2018 04:25 PM, Stephen Smalley wrote:
> On 09/28/2018 04:01 PM, Kees Cook wrote:
>> On Fri, Sep 28, 2018 at 8:55 AM, Casey Schaufler 
>> <casey@schaufler-ca.com> wrote:
>>> On 9/24/2018 5:18 PM, Kees Cook wrote:
>>>> v3:
>>>> - add CONFIG_LSM_ENABLE and refactor resulting logic
>>>
>>> Kees, you can add my
>>>
>>>          Reviewed-by:Casey Schaufler <casey@schaufler-ca.com>
>>>
>>> for this entire patch set. Thank you for taking this on, it's
>>> a significant and important chunk of the LSM infrastructure
>>> update.
>>
>> Thanks!
>>
>> John, you'd looked at this a bit too -- do the results line up with
>> your expectations?
>>
>> Any thoughts from SELinux, TOMOYO, or IMA folks?
> 
> What's it relative to?  First patch fails for me on current security/next.

Never mind - user error ;)

> Is there a branch in your repo that has the v3 patches?

But still wondered about this one.

> 
>>
>> -Kees
>>
>>>
>>>
>>>> ...
>>>> Breakdown of patches:
>>>>
>>>> Infrastructure improvements (no logical changes):
>>>>    LSM: Correctly announce start of LSM initialization
>>>>    vmlinux.lds.h: Avoid copy/paste of security_init section
>>>>    LSM: Rename .security_initcall section to .lsm_info
>>>>    LSM: Remove initcall tracing
>>>>    LSM: Convert from initcall to struct lsm_info
>>>>    vmlinux.lds.h: Move LSM_TABLE into INIT_DATA
>>>>    LSM: Convert security_initcall() into DEFINE_LSM()
>>>>    LSM: Record LSM name in struct lsm_info
>>>>    LSM: Provide init debugging infrastructure
>>>>    LSM: Don't ignore initialization failures
>>>>
>>>> Split "integrity" out into "ordered initialization" (no logical 
>>>> changes):
>>>>    LSM: Introduce LSM_FLAG_LEGACY_MAJOR
>>>>    LSM: Provide separate ordered initialization
>>>>
>>>> Provide centralized LSM enable/disable infrastructure:
>>>>    LoadPin: Rename "enable" to "enforce"
>>>>    LSM: Plumb visibility into optional "enabled" state
>>>>    LSM: Lift LSM selection out of individual LSMs
>>>>    LSM: Prepare for arbitrary LSM enabling
>>>>    LSM: Introduce CONFIG_LSM_ENABLE
>>>>    LSM: Introduce lsm.enable= and lsm.disable=
>>>>    LSM: Prepare for reorganizing "security=" logic
>>>>    LSM: Refactor "security=" in terms of enable/disable
>>>>
>>>> Provide centralized LSM ordering infrastructure:
>>>>    LSM: Build ordered list of ordered LSMs for init
>>>>    LSM: Introduce CONFIG_LSM_ORDER
>>>>    LSM: Introduce "lsm.order=" for boottime ordering
>>>>
>>>> Move minor LSMs into ordered LSM initialization:
>>>>    LoadPin: Initialize as ordered LSM
>>>>    Yama: Initialize as ordered LSM
>>>>    LSM: Introduce enum lsm_order
>>>>    capability: Initialize as LSM_ORDER_FIRST
>>>>
>>>> Move major LSMs into ordered LSM initialization:
>>>>    LSM: Separate idea of "major" LSM from "exclusive" LSM
>>>>    LSM: Add all exclusive LSMs to ordered initialization
>>>>
>>>> -Kees
>>>>
>>>>   .../admin-guide/kernel-parameters.txt         |  20 +
>>>>   arch/arc/kernel/vmlinux.lds.S                 |   1 -
>>>>   arch/arm/kernel/vmlinux-xip.lds.S             |   1 -
>>>>   arch/arm64/kernel/vmlinux.lds.S               |   1 -
>>>>   arch/h8300/kernel/vmlinux.lds.S               |   1 -
>>>>   arch/microblaze/kernel/vmlinux.lds.S          |   2 -
>>>>   arch/powerpc/kernel/vmlinux.lds.S             |   2 -
>>>>   arch/um/include/asm/common.lds.S              |   2 -
>>>>   arch/xtensa/kernel/vmlinux.lds.S              |   1 -
>>>>   include/asm-generic/vmlinux.lds.h             |  25 +-
>>>>   include/linux/init.h                          |   2 -
>>>>   include/linux/lsm_hooks.h                     |  43 ++-
>>>>   include/linux/module.h                        |   1 -
>>>>   security/Kconfig                              |  61 ++-
>>>>   security/apparmor/lsm.c                       |  16 +-
>>>>   security/commoncap.c                          |   8 +-
>>>>   security/integrity/iint.c                     |   5 +-
>>>>   security/loadpin/Kconfig                      |   4 +-
>>>>   security/loadpin/loadpin.c                    |  28 +-
>>>>   security/security.c                           | 351 
>>>> +++++++++++++++---
>>>>   security/selinux/hooks.c                      |  16 +-
>>>>   security/smack/smack_lsm.c                    |   8 +-
>>>>   security/tomoyo/tomoyo.c                      |   7 +-
>>>>   security/yama/yama_lsm.c                      |   7 +-
>>>>   24 files changed, 438 insertions(+), 175 deletions(-)
>>>>
>>>
>>
>>
>>
> 

