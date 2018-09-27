Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0066C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AEBE216C4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:48:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AEBE216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbeI0WHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 18:07:07 -0400
Received: from uphb19pa11.eemsg.mail.mil ([214.24.26.85]:37331 "EHLO
        USFB19PA14.eemsg.mail.mil" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727212AbeI0WHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 18:07:07 -0400
X-EEMSG-check-008: 84730646|USFB19PA14_EEMSG_MP10.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA14.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 27 Sep 2018 15:48:11 +0000
X-IronPort-AV: E=Sophos;i="5.54,311,1534809600"; 
   d="scan'208";a="16290307"
IronPort-PHdr: =?us-ascii?q?9a23=3AYbuwEx2Fc+jeA4T1smDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZsesQLvvxwZ3uMQTl6Ol3ixeRBMOHs60C07KempujcFRI2YyGvnEGfc4EfD?=
 =?us-ascii?q?4+ouJSoTYdBtWYA1bwNv/gYn9yNs1DUFh44yPzahANS47xaFLIv3K98yMZFA?=
 =?us-ascii?q?nhOgppPOT1HZPZg9iq2+yo9JDffwdFiCChbb9uMR67sRjfus4KjIV4N60/0A?=
 =?us-ascii?q?HJonxGe+RXwWNnO1eelAvi68mz4ZBu7T1et+ou+MBcX6r6eb84TaFDAzQ9L2?=
 =?us-ascii?q?81/szrugLdQgaJ+3ART38ZkhtMAwjC8RH6QpL8uTb0u+ZhxCWXO9D9QKsqUj?=
 =?us-ascii?q?q+8ahkVB7oiD8GNzEn9mHXltdwh79frB64uhBz35LYbISTOfVwZKPdec4RS3?=
 =?us-ascii?q?RHUMhfSidNBpqwY5YTA+YEO+tTsovzqEYUrRamGAeiGu3vxD9LiHH406I13O?=
 =?us-ascii?q?YuHh3J0gE7A9IDsm7ZoMnpOKocU+24yrTDwzXZb/NR3Dfw8JXGcgw/rvGUXb?=
 =?us-ascii?q?J/b8zRwlQyGQPAlFqQrYjlMC2V1+8QtGWb9PdvVfm0hm47qwB+vjivxsA2ho?=
 =?us-ascii?q?nPnYIa0ErI9Sp+wIYrPNC1TlNwb9CjEJtVrS6aNo12T9shQ252oiY6zKMJuZ?=
 =?us-ascii?q?qhcCgN0pQnyBjSYOGEfYiQ+h/vSemcLDhiiH9lZb6znQi+/Ee+xuHmS8W51k?=
 =?us-ascii?q?tBoDBfndnWrH8N0gTe6s2ASvRg4EiswS2P1wXP6uFcJkA0iLbbJ4YhwrEukp?=
 =?us-ascii?q?oTtlzOHjPsl0Xsja+Wa14k9vK06+XnfrrmppicO5Vyig7iKaQhhtazAeE5Mg?=
 =?us-ascii?q?gKR2Sb+OK826P//UDhXblHgfI7nrPZvZzHP8gXuKG0DxFP3oo+8xq/Ci2p0N?=
 =?us-ascii?q?UcnXkJNlJFfxeHgpDyO17TO/D1Fuu/glSwnzdrwPDKJLvhAo7XIXTZn7fheq?=
 =?us-ascii?q?h951ZGyAUv1dBf+45UCrYZLf3vQEDxr8LXDx8jPwyv3+nnCM9y1p4QWWKLHK?=
 =?us-ascii?q?CZKrjfsV6O5uIzPeaMYJUZtyr6K/gg//Tul2M2mUcBfam12psacHO4Eep8I0?=
 =?us-ascii?q?Wff3Xshs4NEWcQsQokUePllluCUT9VZ3a9RK884jA7CJm6DYfYXIyth6SB0z?=
 =?us-ascii?q?m9HpxYfG9GDlSMHW30eIWDXvcGcDiSLdN5kjwYSbihTJcs1RWvtA/81rpmIf?=
 =?us-ascii?q?PY+i4GupL50th6+enTmAos9Tx7EcudyXuBT2JqkWMSQT85wqR/rVZ6yleZ3q?=
 =?us-ascii?q?hym+ZYGsBL5/NVTgc6MobRz+h7C9D0RwLAcc6FSE24Tdq6HDExVNMxw8MOYk?=
 =?us-ascii?q?pkHtWiiQ3M3zeuA7ALjLGLGpM0/bzG33TrJMZy1WzG1K8/gFkiWMdPMnemhq?=
 =?us-ascii?q?Fn/QjJG4HJi1mZl7qtdakEwSHC7nmDwnSUsEFYSgFwV77FUm4ZZkbNrNT54F?=
 =?us-ascii?q?/CQKGqCbg9LgRBzsuCILNQatL1lVVGWOvjONPGbm2shWiwAwiHya2KbIbwZ2?=
 =?us-ascii?q?URxjjSCE8YnAAQ5nuGNA4+Bju/rGLaFjBhCVXvY0b0++lktHy7VlM0zx2Nb0?=
 =?us-ascii?q?B51Lq14B8VheeAS/wN2LIJoyMhqzRyHFag0NPaEduApwx9fKpCZdMx+ktI1W?=
 =?us-ascii?q?XctwZlJJyvM7hihkICcwRwp07hzQ93Codansgst34qyAtyKaSF0FJObT+Y3J?=
 =?us-ascii?q?bwOqHJJWn25hygd6nW2lTG2taM5qgP8Og4q0nkvAyxDkot6Whn091O3nuE/J?=
 =?us-ascii?q?rKEQ4SXYv0UkYw8Bh6va/VbjMh6IPT0H0/eZWz5xTLwN84TNAuyh+9cdNSKu?=
 =?us-ascii?q?vQHwbpHtxcHMOuIfEkn1WzRhMCIO1WsqUzOpXiP/iLwqimOKNglSiqgGJG5o?=
 =?us-ascii?q?9V1kOX6zE6TfbF2YkMx/Xe1QyCE3/4jVG8ooX0lJpCaDU6AGWy027nCZRXa6?=
 =?us-ascii?q?k0epwETS+qIsuq1pBlipXwQX9E5RumAF8b3MKBZxWfdRr+0BdW2EBRpmao3W?=
 =?us-ascii?q?Ojwjh1lSw5hraO1yzJheL5fVwIPXAPDGVrk1qqIYGylN0cdEmucwUt0hCi4A?=
 =?us-ascii?q?Kyy6Vdqal5aXWVTUBDfAD3KX1vVu27sb/GK81V6Yg0vCN/VOW6fEDcS7jhrh?=
 =?us-ascii?q?9c2CTmWyNX3jIycRmuu5Pkj1p7jn6QKDB4q3+dMfl52BOXwdvbX/MZiiIPWS?=
 =?us-ascii?q?1QkTDKAh25ON6z8JOfkJKV4c6kUGf0bYFeaSnmy8u7sSK/4WB7SUmkk+ubhs?=
 =?us-ascii?q?zsEQ981zTykdZtS3Ob/17HfoD32vHiYqpcdU5yCQq5spMiFw=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2D8AACr+qxb/wHyM5BaGwEBAQEDAQEBBwMBAQGDNSpmf?=
 =?us-ascii?q?yiDdJUTAQEBAQaBCAgliGuJBoZbMAYBhEACg34hOBQBAwEBAQEBAQIBbBwMg?=
 =?us-ascii?q?jUkAYJeAQEBAQIBIxVGCwsVAwICJgICVwYBDAYCAQGCXj8BgXQFCA+jTIEuh?=
 =?us-ascii?q?AABdoUVBYELiXMXeYEHgRInDIJfgwKEfYJXAo5Ejk0JhkOJZQYXjzori1eKc?=
 =?us-ascii?q?SGBVSsIAhgIIQ+DJxIBghIXiFqFCFIjMAEBAQF3AQGNNAEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 27 Sep 2018 15:48:10 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8RFm4hR004501;
        Thu, 27 Sep 2018 11:48:06 -0400
Subject: Re: [PATCH v5 3/5] SELinux: Prepare for PTRACE_MODE_SCHED
To:     Casey Schaufler <casey.schaufler@intel.com>,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        dave.hansen@intel.com, deneen.t.dock@intel.com,
        kristen@linux.intel.com, arjan@linux.intel.com,
        Paul Moore <paul@paul-moore.com>
References: <20180926203446.2004-1-casey.schaufler@intel.com>
 <20180926203446.2004-4-casey.schaufler@intel.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <6e21f471-ff88-c57c-8892-e0bb626bea12@tycho.nsa.gov>
Date:   Thu, 27 Sep 2018 11:50:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180926203446.2004-4-casey.schaufler@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/26/2018 04:34 PM, Casey Schaufler wrote:
> From: Casey Schaufler <casey@schaufler-ca.com>
> 
> A ptrace access check with mode PTRACE_MODE_SCHED gets called
> from process switching code. This precludes the use of audit or avc,
> as the locking is incompatible. The only available check that
> can be made without using avc is a comparison of the secids.
> This is not very satisfactory as it will indicate possible
> vulnerabilies much too aggressively.
Can you document (in the patch description and/or in the inline 
documentation in lsm_hooks.h) what locks can be safely used when this 
hook is called with PTRACE_MODE_SCHED?  rcu_read_lock() seemingly must 
be safe since it is being called by task_sid() below. Are any other 
locking primitives safe?

Does the PTRACE_MODE_SCHED check have to occur while holding the 
scheduler lock, or could it be performed before taking the lock?

Can you cite the commit or patch posting (e.g. from lore or patchwork) 
that defines PTRACE_MODE_SCHED and its usage as part of the patch 
description for context?  Is this based on the v7 patchset, e.g.
https://lore.kernel.org/lkml/nycvar.YFH.7.76.1809251437340.15880@cbobk.fhfr.pm/

> 
> Signed-off-by: Casey Schaufler <casey.schaufler@intel.com>
> ---
>   security/selinux/hooks.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index ad9a9b8e9979..160239791007 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2267,6 +2267,8 @@ static int selinux_ptrace_access_check(struct task_struct *child,
>   	u32 sid = current_sid();
>   	u32 csid = task_sid(child);
>   
> +	if (mode & PTRACE_MODE_SCHED)
> +		return sid == csid ? 0 : -EACCES;
IIUC, this logic is essentially the same as the uid-based check, 
including the fact that even a "privileged" process is not given any 
special handling since they always return false from ptrace_has_cap() 
for PTRACE_MODE_SCHED. If they are ok with applying IBPB whenever uids 
differ, then doing so whenever sids/contexts differ does not seem like 
an onerous thing.


>   	if (mode & PTRACE_MODE_READ)
>   		return avc_has_perm(&selinux_state,
>   				    sid, csid, SECCLASS_FILE, FILE__READ, NULL);
> 

