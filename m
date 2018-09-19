Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B731ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7F8920858
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:58:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7F8920858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732729AbeITAiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 20:38:06 -0400
Received: from ucol19pa13.eemsg.mail.mil ([214.24.24.86]:57927 "EHLO
        ucol19pa13.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731632AbeITAiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 20:38:06 -0400
X-EEMSG-check-008: 625464877|UCOL19PA13_EEMSG_MP11.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.53,395,1531785600"; 
   d="scan'208";a="625464877"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by ucol19pa13.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 19 Sep 2018 18:58:45 +0000
X-IronPort-AV: E=Sophos;i="5.53,395,1531785600"; 
   d="scan'208";a="18440905"
IronPort-PHdr: =?us-ascii?q?9a23=3Ac8YMbxRM32KfYnkgDPprGu3jZdpsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa67ZRWFt8tkgFKBZ4jH8fUM07OQ7/i/HzRYqb+681k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba9wIRmssQndqtQdjJd/JKo21h?=
 =?us-ascii?q?bHuGZDdf5MxWNvK1KTnhL86dm18ZV+7SleuO8v+tBZX6nicKs2UbJXDDI9M2?=
 =?us-ascii?q?Ao/8LrrgXMTRGO5nQHTGoblAdDDhXf4xH7WpfxtTb6tvZ41SKHM8D6Uaw4VD?=
 =?us-ascii?q?K/5KpwVhTmlDkIOCI48GHPi8x/kqRboA66pxdix4LYeZyZOOZicq/Ye94VS3?=
 =?us-ascii?q?BBXsJMXCJfBI2yYZYEA+4YMepGs4Xxol0Dpga8CwaxHuPi0iJGiGH43aM60O?=
 =?us-ascii?q?ovHw/J0wMiEN0Sv3rZt8n1OaUIXOyp0KXFwzfOYvVL0jn98ojIdRUhrOmRU7?=
 =?us-ascii?q?Jsb8XR0UkvGB3Djl6NtILlOima1uAJs2eF7+trSOWii3U6pAFquTWv2scthZ?=
 =?us-ascii?q?XJhoIS0FzE8z55z5wvKd23T057f8epHZ1NvC+ZL4t7Wt4uTm5ntSogyrAKpI?=
 =?us-ascii?q?S3cDYFxZg53RLTdvqKeJWS7B35TuaeOzJ4iWpgeLK4mhm971Ctyvb5VsmoyF?=
 =?us-ascii?q?ZKqTdFksXUunANyRPT7s+HR+Nh/ki7wzaP1h3T6vpeLUAolavUN54hwrkqmp?=
 =?us-ascii?q?oVrUvDBTP5lF/zjK+XckUo4umo6+L5bbX6vpKQKoB5hw7kPqkuh8CzG/o0Pw?=
 =?us-ascii?q?cQU2SB5OiwzLjj8lf4QLVOgP02iK7ZsJXCKMQAu6G5GBRY0poj6hmjDzem18?=
 =?us-ascii?q?4UnX8cLF1fYh6HgI/pO0/WLPDiEfi/m0iskCtsx/3eIr3uGJbNLn/FkLj8Z7?=
 =?us-ascii?q?Zy8VVRxxYyzdBE+51UDasNL+70Wk/0rNbYFAM2MxSow+b7D9VwzpseVniSAq?=
 =?us-ascii?q?+dK67SqUWH5v8rI+WVYY8VvzH9K+I76PL0kXA5nlodd7Gz3ZQLcHC4AuhmI0?=
 =?us-ascii?q?KBbHXymtcOC30KvgslTOHxkF2NSyRTZ3epX6Ik4jE0Ep6pApnZSoCqmryB0z?=
 =?us-ascii?q?+xHodKaWBeFlCMDXDoep2AW/cNbiKSP8BgniUHVbe/UY8h0w+htAvhxrp5Ie?=
 =?us-ascii?q?rb5DcYuYjg1Ndr/e3Tkw899ThuA8SayWGNQHl+nnkUSD8uwKB/vUt9x0+M0K?=
 =?us-ascii?q?dmmvBYEd1T5/VUUgY1LJLT0eN7C8zsVQLbeNeGUlKmT866DjEwVdI+39gOb1?=
 =?us-ascii?q?xhFNWlixCQlxatVoMcjbWQTL8z9K7G1mTwOsU1n2rP164ng0MvasBOLmahwK?=
 =?us-ascii?q?V48l6XT7bAjkHRsqGtb6lUiDbE6WOr1WOTuARdVwlqXOPOWnVJIgP7t9Xyrn?=
 =?us-ascii?q?vLVb61QeAqKgJbyNWqMqJQa8bxiVxNSbHkItuIMEyrnGLlPgqF3rOBasLRfm?=
 =?us-ascii?q?wZ2CjMQBwfnxs74WeNNQ94ADyo5W3ZEmo9RhrUf0rw/Lwm+zuARUguwlTPNh?=
 =?us-ascii?q?c52g=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2DNAQAgm6Jb/wHyM5BdHAEBAQQBAQoBAYFSgVwqgWQog?=
 =?us-ascii?q?3OVEwEBAQEBAQaBCC2IaY1jgXo2AYRAAoM7ITYWAQMBAQEBAQECAWwogjUkA?=
 =?us-ascii?q?YJeAQEBAQIBIwQRNAoDEAsOCgICJgICVwYBDAYCAQEXgkc/gXUFCKVcezOEd?=
 =?us-ascii?q?4UbgQuJYhd5gQeBOYJrhEchgxeCVwKIPIVxjiwJkBwGF48aljgELYFVKwgCG?=
 =?us-ascii?q?AghD4MngiUXjjMjMHsBAYoZgkwBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 19 Sep 2018 18:58:47 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8JIwkgn009626;
        Wed, 19 Sep 2018 14:58:47 -0400
Subject: Re: [RFC PATCH] selinux: add a fallback to defcontext for native
 labeling
To:     Taras Kondratiuk <takondra@cisco.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>
Cc:     selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        xe-linux-external@cisco.com
References: <20180919165248.53090-1-takondra@cisco.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <f283c1e7-19eb-2b99-3fef-a19e2bf99a2b@tycho.nsa.gov>
Date:   Wed, 19 Sep 2018 15:00:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180919165248.53090-1-takondra@cisco.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/19/2018 12:52 PM, Taras Kondratiuk wrote:
> When files on NFSv4 server are not properly labeled (label doesn't match
> a policy on a client) they will end up with unlabeled_t type which is
> too generic. We would like to be able to set a default context per
> mount. 'defcontext' mount option looks like a nice solution, but it
> doesn't seem to be fully implemented for native labeling. Default
> context is stored, but is never used.
> 
> The patch adds a fallback to a default context if a received context is
> invalid. If the inode context is already initialized, then it is left
> untouched to preserve a context set locally on a client.

Can you explain the use case further?  Why are you exporting a 
filesystem with security labeling enabled to a client that doesn't 
understand all of the labels used within it?  Why wouldn't you just 
disable NFSv4 security labeling and/or use a regular context= mount to 
assign a single context to all files in the mount?

To be clear, defcontext= doesn't work that way for local/FS_USE_XATTR 
filesystems. The context specified by it is only used for:
1) files that don't implement the xattr inode operations at all,
2) files that lack a security.selinux xattr,
3) the MLS portion of the context if it was missing (strictly as a 
legacy compatibility mechanism for RHEL4 which predated the enabling of 
the MLS field/logic).

A file with a security.selinux xattr that is invalid under policy for 
any reason other than a missing MLS field will be handled as having the 
unlabeled context.

So this would be a divergence in semantics for defcontext= between 
local/FS_USE_XATTR and NFS/FS_USE_NATIVE filesystems.

> 
> Signed-off-by: Taras Kondratiuk <takondra@cisco.com>
> ---
>   security/selinux/hooks.c | 25 ++++++++++++++++++++++++-
>   1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index ad9a9b8e9979..f7debe798bf5 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6598,7 +6598,30 @@ static void selinux_inode_invalidate_secctx(struct inode *inode)
>    */
>   static int selinux_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
>   {
> -	return selinux_inode_setsecurity(inode, XATTR_SELINUX_SUFFIX, ctx, ctxlen, 0);
> +	struct superblock_security_struct *sbsec;
> +	struct inode_security_struct *isec;
> +	int rc;
> +
> +	rc = selinux_inode_setsecurity(inode, XATTR_SELINUX_SUFFIX, ctx, ctxlen, 0);

In this case, we likely don't gain much by reusing 
selinux_inode_setsecurity() here and could just inline the relevant 
portion of it if we were to make this change.  Logically they mean 
different things.

> +
> +	/*
> +	 * In case of Native labeling with defcontext mount option fall back
> +	 * to a default SID if received context is invalid.
> +	 */
> +	if (rc == -EINVAL) {
> +		sbsec = inode->i_sb->s_security;
> +		if (sbsec->behavior == SECURITY_FS_USE_NATIVE &&
> +		    sbsec->flags & DEFCONTEXT_MNT) {
> +			isec = inode->i_security;
> +			if (!isec->initialized) {
> +				isec->sclass = inode_mode_to_security_class(inode->i_mode);
> +				isec->sid = sbsec->def_sid;
> +				isec->initialized = 1;
> +			}
> +			rc = 0;
> +		}
> +	}
> +	return rc;
>   }
>   
>   /*
> 

