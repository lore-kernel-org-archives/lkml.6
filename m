Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC24C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 14:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D70D62147D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 14:21:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D70D62147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391762AbeHPRUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 13:20:06 -0400
Received: from uphb19pa08.eemsg.mail.mil ([214.24.26.82]:27560 "EHLO
        USFB19PA11.eemsg.mail.mil" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726312AbeHPRUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 13:20:05 -0400
X-Greylist: delayed 596 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Aug 2018 13:20:04 EDT
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA11.eemsg.mail.mil with ESMTP/TLS/AES256-SHA; 16 Aug 2018 14:11:12 +0000
X-IronPort-AV: E=Sophos;i="5.53,247,1531785600"; 
   d="scan'208";a="17090905"
IronPort-PHdr: =?us-ascii?q?9a23=3AqaZrgB2MN8334Ke4smDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZsesQKf/xwZ3uMQTl6Ol3ixeRBMOHs6wC07KempujcFRI2YyGvnEGfc4EfD?=
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
 =?us-ascii?q?ZnAdmijQ7M3zCsA7ALk7yHHps08rjT33LpPcZy127G1LU9j1khWsZBKGqoi7?=
 =?us-ascii?q?Jh+gbWHoLGjkSZl722eqQBxy7N73yOzW6PvEFDTA5wSr/JUWwCakfMqtT5/E?=
 =?us-ascii?q?zCRae0Cbs7KgtB1dKCKqxSZ9L0l1pGWunsNM7eY22rnWewHgiHxrWXYYrrfW?=
 =?us-ascii?q?UdwDvSCEwenw8P+naGMBA0Bj29rGLGEDxuCVXvblvx/uZgrnO0UFE7zweQY0?=
 =?us-ascii?q?19zba65xkViuCfS/4I37IEvjshpCtwHFqnw93WDN+ArRJ7fKpAedM9/EtH1W?=
 =?us-ascii?q?XBugx+JJygLrtihkIAfARxpE7u0xR3CoNdkckltn8qzQxyKb6G31NFbT+XwZ?=
 =?us-ascii?q?fwOrjPIGno4B+vc7LW2k3Z0NuO4KgP8vY4pE/lvAyyEkoi8nNn08Ra0neG55?=
 =?us-ascii?q?XKChYSXoz1Ukot6xd6oLTaMWEB4Nb/3GZhIOGPuT/LxtwtCfFtnh2pZNpOdr?=
 =?us-ascii?q?iPFAbvHckXHeCvLvAnnx6iaRdSeKhR+bQyMsfjd/Kc1KOtPeBvtDanlnhcpo?=
 =?us-ascii?q?dl30ST/i54DOXP2tJNx/CewxvCVDrmilqlmt74lJoCZjwIGGe7jy/+C8oZYq?=
 =?us-ascii?q?x0YJZOEmqlPte22sQ7gpnhRnpV3ECsCklA28KzfxeWKVvn0kkYzkkToHq6iQ?=
 =?us-ascii?q?Ok3jd0lHcvtaPZ0yvQh6zZUTMsGStHRXJpkEz3CYy1lMwBGhDxKQ8zm1/t6U?=
 =?us-ascii?q?/kyu5braJkIm/7QEFUciywJGZnFuO8u7yPbsgJ9NUkti5UeOW6fV2eDLX6pl?=
 =?us-ascii?q?9S0DniBHdTwhg/dje3qtP4mQB3jCSWK3M35HPDe8h27RPe4sHMA/9XwjcCAi?=
 =?us-ascii?q?J/jGr5HF+5auK18M2UmpGLieW3U2asR9UHaiXw5Z+Rvyu8o2txCFuwmO7lyY?=
 =?us-ascii?q?6vKhQzzSKuj4oibi7PthupJ9Cxj6k=3D?=
X-IPAS-Result: =?us-ascii?q?A2CuBABahXVb/wHyM5BcHAEBAQQBAQoBAYMlgXoSKINui?=
 =?us-ascii?q?GmMBgEBAQEBAQaBCAgliFyNOYF6hHcCg2E2FgECAQEBAQEBAgFsKII1JAGCX?=
 =?us-ascii?q?gEFIwQRUQsYAgImAgJXBgEMBgIBAYJfP4F1Dah6ezODfgFphXmBC4gkeYEHg?=
 =?us-ascii?q?TkMgio1h3+CVwKNQo0rCY9VBhWOLpRpByqBUisIAhgIIQ+DJIIlFxGNUFIjM?=
 =?us-ascii?q?I5QAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 16 Aug 2018 14:11:10 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w7GEB6gR029392;
        Thu, 16 Aug 2018 10:11:06 -0400
Subject: Re: [PATCH RFC 5/5] SELinux: Support SELinux determination of
 side-channel vulnerability
To:     Casey Schaufler <casey.schaufler@intel.com>,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        SMACK-discuss@lists.01.org, dave.hansen@intel.com,
        deneen.t.dock@intel.com, kristen@linux.intel.com,
        arjan@linux.intel.com
References: <20180815235355.14908-1-casey.schaufler@intel.com>
 <20180815235355.14908-6-casey.schaufler@intel.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <0b383282-1369-79e9-d111-f03e2897660e@tycho.nsa.gov>
Date:   Thu, 16 Aug 2018 10:12:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180815235355.14908-6-casey.schaufler@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/15/2018 07:53 PM, Casey Schaufler wrote:
> SELinux considers tasks to be side-channel safe if they
> have PROCESS_SHARE access.
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
> +				    SECCLASS_PROCESS, PROCESS__SHARE, 0, &avd);
> +}

If you are going to apply this kind of check, is there a reason you 
wouldn't just use the ptrace checking logic?  Just call 
ptrace_may_access() with PTRACE_MODE_READ and dispense with having a 
separate hook altogether.  Then you get uids/gids, caps, dumpable, and 
security module checking for free.

Regardless, I don't think share permission is the right answer here; it 
has very different semantics and security implications, and is almost 
never allowed in Android policy (just one instance for kernel->init 
transition).

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

