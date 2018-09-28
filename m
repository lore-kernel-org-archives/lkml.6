Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E05C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 20:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B90820657
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 20:23:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B90820657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbeI2CtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 22:49:12 -0400
Received: from uhil19pa11.eemsg.mail.mil ([214.24.21.84]:17591 "EHLO
        uhil19pa11.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbeI2CtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 22:49:12 -0400
X-EEMSG-check-008: 341359092|UHIL19PA11_EEMSG_MP9.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by uhil19pa11.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 28 Sep 2018 20:23:47 +0000
X-IronPort-AV: E=Sophos;i="5.54,316,1534809600"; 
   d="scan'208";a="16347792"
IronPort-PHdr: =?us-ascii?q?9a23=3AL+3UCRMWbeFVFMryeJYl6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0K/n+ocbcNUDSrc9gkEXOFd2Cra4c1KyO6+jJYi8p2d65qncMcZhBBV?=
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
 =?us-ascii?q?QXh2MLLF1CeBKZl4TpIU3BIOjkDfejhFShiDRryO7YMb36HprNKX/DkLT6cL?=
 =?us-ascii?q?lh605c0g0zzdVe55JJD7ENOvXzWlX+tNbAFB82LxS0w/r7CNV6zo4RRXiAAr?=
 =?us-ascii?q?SHP6LSqlKI/f4gI+mWa48Itjb9L+Yq5+T3gXAlg1ARZ7Wm3ZwSaHqgBPRpP1?=
 =?us-ascii?q?2ZYWbwgtcGCWoKvA8+TOvwiF2YUD5TfG2/X6Qm6TE+Fo2mDJ3PRoe3gLyOxC?=
 =?us-ascii?q?27BIFZZnhaClCQFnflb4eEW/AMaCKUOMNhkDsEVbi7RI8nzhGhqgn6xqF7Ie?=
 =?us-ascii?q?XO/C0YspTj1Nlp6OLJkRE+7yB7D8OY02uVVWF7gnsIRyMq3KB4uUF90kmM0a?=
 =?us-ascii?q?53g/xFFNxT4epFUgQkOp7Gyex1FdTyVxnAftuQTFamRcumDi8rQtIq2dAOYF?=
 =?us-ascii?q?t9G8+4gRzZ2SqlHaUZl76TBJYs6KLTw2DxJ9phy3bBzKQhl0MpQtZLNWC9nq?=
 =?us-ascii?q?5w7RXTB4rQn0WckKaqcr4c0zDX+GifymqOuVlSUBRsXqXdQXAfekzWoMzl6U?=
 =?us-ascii?q?zYVL+hF7QmPhFaycGeKqtFcMDpjVtCRPj9ItTTeGOxm2GsBRmWwrOAdpble2?=
 =?us-ascii?q?IY3C/FEkgLjxgT/WqaNQg5Hiqhp2PeDDpzFVPgek/s6vdxp2+mTk8uzgGKc0?=
 =?us-ascii?q?1g26Ow+h4SmPOcVvcT0awftSc/pDV7Aky908jVC9WevQphertTYdcn7FdAz2?=
 =?us-ascii?q?LZuBR3Poa8IKB6ml4ebwN3slvy2BVwEIVPitYlrG8xwQp2J6OY1klNdzWG0p?=
 =?us-ascii?q?DsIrfXMHX9/Aiza67K3VHTyNKW+qYJ6PQlpFTvpRymFk0+/Hh8zdlV3GWT5o?=
 =?us-ascii?q?/QAAoRT53xSEA3+AZ+p73AZSk9/YzU32V2Maaoqj/Cx84pBOw9xxakftdfNr?=
 =?us-ascii?q?6EFQDrH8IAHcihNOwqlkO3bhILIu9S7rQ4P8C4ePuc3q6kIuJgkCihjWRd74?=
 =?us-ascii?q?B3yliM+DZkSu7Uw5YFxOmV3g+GVzf6kVegvdn7mYNaajEIGGqw1yzkCZVPZq?=
 =?us-ascii?q?19Y4kLE32iI86pydVkgZ7iRXpY+ESkB1Mc18/6MSaVOn/w0BYY/kMQojTzmi?=
 =?us-ascii?q?a11DdzlDIBpaqF2ynP3uGkcwAIbCoDb2B5gEakGoO0hs0UWEWyJ1winQCo9G?=
 =?us-ascii?q?7hzKhSuap7InOWSk4OdC/zeTJMSKy144GebtZP5ZVgiiBeVOCxcBjOUbLmiw?=
 =?us-ascii?q?cL2CPkWW1FzXY0cC/86caxpABzlG/IdCU7l3HeY8wlgE6FvNE=3D?=
X-IPAS-Result: =?us-ascii?q?A2AHAAA5ja5b/wHyM5BcGgEBAQEBAgEBAQEHAgEBAQGBU?=
 =?us-ascii?q?YFkKoFlKIN0iBWMMEwBAQEBAQEGgTWIa41rgXo2AYRAAoN7ITQYAQMBAQEBA?=
 =?us-ascii?q?QECAWwogjUkAYJfAQUjFUEQCxgCAiYCAlcGAQwGAgEBgl4/gXUNpGqBLoR3h?=
 =?us-ascii?q?RWBC4lzF3mBB4E5gmuEfoMBglcCiCiFX0COVgmJToZcBheBR44BiHeNbjiBV?=
 =?us-ascii?q?SsIAhgIIQ87gmyQcCMwewEBjEgBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 28 Sep 2018 20:23:46 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8SKNdxb020974;
        Fri, 28 Sep 2018 16:23:41 -0400
Subject: Re: [PATCH security-next v3 00/29] LSM: Explict LSM ordering
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
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <cb49b4c4-a379-7a8e-41a6-6e6a4afb6fe5@tycho.nsa.gov>
Date:   Fri, 28 Sep 2018 16:25:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5jKQVDW8Wp0ESv2raa0xJnHCCMNqFCzZ5jSVXQ=Dp7FF8A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/28/2018 04:01 PM, Kees Cook wrote:
> On Fri, Sep 28, 2018 at 8:55 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 9/24/2018 5:18 PM, Kees Cook wrote:
>>> v3:
>>> - add CONFIG_LSM_ENABLE and refactor resulting logic
>>
>> Kees, you can add my
>>
>>          Reviewed-by:Casey Schaufler <casey@schaufler-ca.com>
>>
>> for this entire patch set. Thank you for taking this on, it's
>> a significant and important chunk of the LSM infrastructure
>> update.
> 
> Thanks!
> 
> John, you'd looked at this a bit too -- do the results line up with
> your expectations?
> 
> Any thoughts from SELinux, TOMOYO, or IMA folks?

What's it relative to?  First patch fails for me on current security/next.

Is there a branch in your repo that has the v3 patches?

> 
> -Kees
> 
>>
>>
>>> ...
>>> Breakdown of patches:
>>>
>>> Infrastructure improvements (no logical changes):
>>>    LSM: Correctly announce start of LSM initialization
>>>    vmlinux.lds.h: Avoid copy/paste of security_init section
>>>    LSM: Rename .security_initcall section to .lsm_info
>>>    LSM: Remove initcall tracing
>>>    LSM: Convert from initcall to struct lsm_info
>>>    vmlinux.lds.h: Move LSM_TABLE into INIT_DATA
>>>    LSM: Convert security_initcall() into DEFINE_LSM()
>>>    LSM: Record LSM name in struct lsm_info
>>>    LSM: Provide init debugging infrastructure
>>>    LSM: Don't ignore initialization failures
>>>
>>> Split "integrity" out into "ordered initialization" (no logical changes):
>>>    LSM: Introduce LSM_FLAG_LEGACY_MAJOR
>>>    LSM: Provide separate ordered initialization
>>>
>>> Provide centralized LSM enable/disable infrastructure:
>>>    LoadPin: Rename "enable" to "enforce"
>>>    LSM: Plumb visibility into optional "enabled" state
>>>    LSM: Lift LSM selection out of individual LSMs
>>>    LSM: Prepare for arbitrary LSM enabling
>>>    LSM: Introduce CONFIG_LSM_ENABLE
>>>    LSM: Introduce lsm.enable= and lsm.disable=
>>>    LSM: Prepare for reorganizing "security=" logic
>>>    LSM: Refactor "security=" in terms of enable/disable
>>>
>>> Provide centralized LSM ordering infrastructure:
>>>    LSM: Build ordered list of ordered LSMs for init
>>>    LSM: Introduce CONFIG_LSM_ORDER
>>>    LSM: Introduce "lsm.order=" for boottime ordering
>>>
>>> Move minor LSMs into ordered LSM initialization:
>>>    LoadPin: Initialize as ordered LSM
>>>    Yama: Initialize as ordered LSM
>>>    LSM: Introduce enum lsm_order
>>>    capability: Initialize as LSM_ORDER_FIRST
>>>
>>> Move major LSMs into ordered LSM initialization:
>>>    LSM: Separate idea of "major" LSM from "exclusive" LSM
>>>    LSM: Add all exclusive LSMs to ordered initialization
>>>
>>> -Kees
>>>
>>>   .../admin-guide/kernel-parameters.txt         |  20 +
>>>   arch/arc/kernel/vmlinux.lds.S                 |   1 -
>>>   arch/arm/kernel/vmlinux-xip.lds.S             |   1 -
>>>   arch/arm64/kernel/vmlinux.lds.S               |   1 -
>>>   arch/h8300/kernel/vmlinux.lds.S               |   1 -
>>>   arch/microblaze/kernel/vmlinux.lds.S          |   2 -
>>>   arch/powerpc/kernel/vmlinux.lds.S             |   2 -
>>>   arch/um/include/asm/common.lds.S              |   2 -
>>>   arch/xtensa/kernel/vmlinux.lds.S              |   1 -
>>>   include/asm-generic/vmlinux.lds.h             |  25 +-
>>>   include/linux/init.h                          |   2 -
>>>   include/linux/lsm_hooks.h                     |  43 ++-
>>>   include/linux/module.h                        |   1 -
>>>   security/Kconfig                              |  61 ++-
>>>   security/apparmor/lsm.c                       |  16 +-
>>>   security/commoncap.c                          |   8 +-
>>>   security/integrity/iint.c                     |   5 +-
>>>   security/loadpin/Kconfig                      |   4 +-
>>>   security/loadpin/loadpin.c                    |  28 +-
>>>   security/security.c                           | 351 +++++++++++++++---
>>>   security/selinux/hooks.c                      |  16 +-
>>>   security/smack/smack_lsm.c                    |   8 +-
>>>   security/tomoyo/tomoyo.c                      |   7 +-
>>>   security/yama/yama_lsm.c                      |   7 +-
>>>   24 files changed, 438 insertions(+), 175 deletions(-)
>>>
>>
> 
> 
> 

