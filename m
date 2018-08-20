Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2BEC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9613621581
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:01:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9613621581
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbeHTTRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 15:17:25 -0400
Received: from upbd19pa08.eemsg.mail.mil ([214.24.27.83]:37093 "EHLO
        upbd19pa08.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbeHTTRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 15:17:24 -0400
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by upbd19pa08.eemsg.mail.mil with ESMTP/TLS/AES256-SHA; 20 Aug 2018 16:01:08 +0000
X-IronPort-AV: E=Sophos;i="5.53,265,1531785600"; 
   d="scan'208";a="17208450"
IronPort-PHdr: =?us-ascii?q?9a23=3AC4t1tR12MrR9kUDusmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZsesTKfvxwZ3uMQTl6Ol3ixeRBMOHs6wC07KempujcFRI2YyGvnEGfc4EfD?=
 =?us-ascii?q?4+ouJSoTYdBtWYA1bwNv/gYn9yNs1DUFh44yPzahANS47xaFLIv3K98yMZFA?=
 =?us-ascii?q?nhOgppPOT1HZPZg9iq2+yo9JDffwRFiCChbb9uMR67sRjfus4KjIV4N60/0A?=
 =?us-ascii?q?HJonxGe+RXwWNnO1eelAvi68mz4ZBu7T1et+ou+MBcX6r6eb84TaFDAzQ9L2?=
 =?us-ascii?q?81/szrugLdQgaJ+3ART38ZkhtMAwjC8RH6QpL8uTb0u+ZhxCWXO9D9QKsqUj?=
 =?us-ascii?q?q+8ahkVB7oiD8GNzEn9mHXltdwh79frB64uhBz35LYbISTOfVwZKPdec4RS3?=
 =?us-ascii?q?RHUMhfSidNBpqwY5UTA+YEO+tTsovzqEYUrRamGAeiGu3vxD9LiHH406I13O?=
 =?us-ascii?q?YuHh3J0gE7A9IDsm7ZoMnpOKocU+24yrTDwzXZb/NR3Dfw8JXGcgw/rvGUXb?=
 =?us-ascii?q?J/b8zRwlQyGQPAlFqQrYjlMC2V1+8QtGWb9PdvVfm0hm47qwB+vjivxsA2ho?=
 =?us-ascii?q?nPnYIa0ErI9Sp+wIYrPNC1TlNwb928EJZIqi2XOIR7TtkiTm11oio21LILtY?=
 =?us-ascii?q?ChcCQXzpks2gTRZOadc4eS5xLuTOORITBli317YL+/nBOy8VS4yu37S8m0zE?=
 =?us-ascii?q?5GripbndnIsXAAzwDT5dKdSvt840ehwiyD1wHV6uFKJkA0jrTUJII7zr4slp?=
 =?us-ascii?q?scrUTDHijslEXwkKCWbVkr9vKt6+TmZrXqvp6cN4lqhQHiKqkih8OyDOsiPg?=
 =?us-ascii?q?UOQmSX4/qw2bL98UHjXblGlvg2nbPYsJDeK8QbvKm5AwpN34Y49hm/FCyr0M?=
 =?us-ascii?q?gYnHYbLFJFfwiLj47yO17UOvz4AvC/g0q0nDdx2//GJqHhAonKLnXbjLjuZ6?=
 =?us-ascii?q?195FBcyQYp1tBQ+5JUBascIPL9Xk/+qsbYAwQ4Mwyy3+boFtF92pkCVmKIB6?=
 =?us-ascii?q?+TKLnSvkOQ5uIzP+mMY5cYuDXjJPg/4f7hk3s5lUYdfaazx5sYdW63HvJnI0?=
 =?us-ascii?q?WfbnrhmdMBEWYRvgoiV+zmklqCUSZNaHa0UaMz/DU7CIa8AYjfQYCthaSL3D?=
 =?us-ascii?q?2nEZ1OemBGFleMHG/sd4WFXfcMdS2TLtZikjMaT7ihTZEu1RW1uQ/kxLpoMP?=
 =?us-ascii?q?DU9jcbtZ39zth14fPclRUo+TxzFcSd3HmHT3tokWMQWz82wKd/rFR5yleC16?=
 =?us-ascii?q?h4nvNZGcVI5/xXTgg6KITcz+1mC9HyQw7Be9CJR0u7QtWiHz48Vcwxw9AQbE?=
 =?us-ascii?q?ZnAdmijQ7M3zCsA7ALk7yHHps08rjT33LpPcZy127G1LU9j1khWsZAKHephr?=
 =?us-ascii?q?Bh+ATJB47GiUOZl720eqQaxyPN9WGDzXaQs0FcSgJ/TaLFXXUHbEvMsdv5/l?=
 =?us-ascii?q?/CT6OpCbk/LwRO18iCJbVUZd3vl1lGWO3vN8nZY22tmGe9HheIxrWQbIX0f2?=
 =?us-ascii?q?URxjnSCE8BkwoL53aJKRA+Bju9o2LZFDFuFkjvY0L38elitny7SFQ5zwWLb0?=
 =?us-ascii?q?1nyrq09QQZhf2aS/MPwL0EvD0tpClzHFa4x9jWEcaPpxJ9fKVAZtMw+E1I1X?=
 =?us-ascii?q?jbtwNnOJytNKRihl8YcwRqsELizRR3CoNckcc0qHMm1hZ9KaWd0AAJSzTN9p?=
 =?us-ascii?q?nrN6yfEWLy9Q2hb6PMkgXV2c2b6+EU4/QxtlvnsRuBF0w+/nEh2N5QhT/U5Z?=
 =?us-ascii?q?jQCgcWFJL4SEo68Rl8qJneYzIh/MXTzXBqLqCwtnnJ3NdtTO8kzAuwOtRSKq?=
 =?us-ascii?q?WJECfsHMAAQcujMuonnx6udB1AdORT8rMketirfOac2bK6eeNnkC+igExZ74?=
 =?us-ascii?q?1nlEGB7SxxTqjPxZlBi+qV2gqBSifUkEaqssexn5tNIz4VAC73xSH6CchRb6?=
 =?us-ascii?q?tpcIAjCGGyLsnxzdJ7w9bhVnhV+VjlGxUK38SqURuUc1H5mwZX0ABfomamgj?=
 =?us-ascii?q?e1yRRwkjc0vuye2jDDx6Lpcx9DcmdRRmBkpVPtJ5WkydEcQEWsKQMukUiL/0?=
 =?us-ascii?q?H/kpNHqbx/Im+bekJBeyz7Pik2SaernqaTaM5IrpUzuGNYV/rqMgPScaL0vx?=
 =?us-ascii?q?ZPi3CrJGBZ3j1uMmjw4pg=3D?=
X-IPAS-Result: =?us-ascii?q?A2DtAwBM5Xpb/wHyM5BcHAEBAQQBAQoBAYMlgXoSKINwi?=
 =?us-ascii?q?GmMCQEBAQEBBoEILYhcjzWEdwKDbjcVAQIBAQEBAQECAWwogjUkAYJdAQEBA?=
 =?us-ascii?q?QIBIwQRUQsYAgImAgJXBgEMBgIBAYJfP4F1BQimeHszhGiFdIELiCR5gQeBO?=
 =?us-ascii?q?YI2NYd/glcCjUeNNQmPWgYVjjiUfyKBUisIAhgIIQ+DJIIlFxGOIiMwjxsBA?=
 =?us-ascii?q?Q?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 20 Aug 2018 16:01:07 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w7KG14PX007959;
        Mon, 20 Aug 2018 12:01:04 -0400
Subject: Re: [PATCH RFC v2 5/5] SELinux: Support SELinux determination of
 side-channel vulnerability
To:     Casey Schaufler <casey.schaufler@intel.com>,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        dave.hansen@intel.com, deneen.t.dock@intel.com,
        kristen@linux.intel.com, arjan@linux.intel.com
References: <20180817221624.10232-1-casey.schaufler@intel.com>
 <20180817221624.10232-6-casey.schaufler@intel.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <6e70b7c7-d932-91c8-35d1-70bd6cef16a5@tycho.nsa.gov>
Date:   Mon, 20 Aug 2018 12:02:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180817221624.10232-6-casey.schaufler@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/17/2018 06:16 PM, Casey Schaufler wrote:
> SELinux considers tasks to be side-channel safe if they
> have PROCESS_SHARE access.

Now the description and the code no longer match.

> 
> Signed-off-by: Casey Schaufler <casey.schaufler@intel.com>
> ---
>   security/selinux/hooks.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index a8bf324130f5..7fbd7d7ac1cb 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -4219,6 +4219,14 @@ static void selinux_task_to_inode(struct task_struct *p,
>   	spin_unlock(&isec->lock);
>   }
>   
> +static int selinux_task_safe_sidechannel(struct task_struct *p)
> +{
> +	struct av_decision avd;
> +
> +	return avc_has_perm_noaudit(&selinux_state, current_sid(), task_sid(p),
> +				    SECCLASS_FILE, FILE__READ, 0, &avd);
> +}

And my question from before still stands:  why do we need a new hook and 
new security module instead of just using ptrace_may_access()?

> +
>   /* Returns error only if unable to parse addresses */
>   static int selinux_parse_skb_ipv4(struct sk_buff *skb,
>   			struct common_audit_data *ad, u8 *proto)
> @@ -7002,6 +7010,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>   	LSM_HOOK_INIT(task_movememory, selinux_task_movememory),
>   	LSM_HOOK_INIT(task_kill, selinux_task_kill),
>   	LSM_HOOK_INIT(task_to_inode, selinux_task_to_inode),
> +	LSM_HOOK_INIT(task_safe_sidechannel, selinux_task_safe_sidechannel),
>   
>   	LSM_HOOK_INIT(ipc_permission, selinux_ipc_permission),
>   	LSM_HOOK_INIT(ipc_getsecid, selinux_ipc_getsecid),
> 

