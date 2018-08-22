Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A326C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 13:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDFCF214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 13:58:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDFCF214FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbeHVRX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 13:23:28 -0400
Received: from h2.hallyn.com ([78.46.35.8]:34944 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728197AbeHVRX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 13:23:28 -0400
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 44FDD120C33; Wed, 22 Aug 2018 08:58:25 -0500 (CDT)
Date:   Wed, 22 Aug 2018 08:58:25 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Christian Brauner <christian@brauner.io>
Cc:     serge@hallyn.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] security/capabilities: remove check for -EINVAL
Message-ID: <20180822135825.GA7223@mail.hallyn.com>
References: <20180822115240.18196-1-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180822115240.18196-1-christian@brauner.io>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Christian Brauner (christian@brauner.io):
> bprm_caps_from_vfs_caps() never returned -EINVAL so remove the
> rc == -EINVAL check.
> 
> Signed-off-by: Christian Brauner <christian@brauner.io>

Thanks.

Reviewed-by: Serge Hallyn <serge@hallyn.com>

> ---
> v0 -> v1
> - non-functional changes:
>   adapt commit message to reflect the fact that
>   bprm_caps_from_vfs_caps() never actuall returned -EINVAL.
> ---
>  security/commoncap.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/security/commoncap.c b/security/commoncap.c
> index f4c33abd9959..6012f0cd8157 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -684,9 +684,6 @@ static int get_file_caps(struct linux_binprm *bprm, bool *effective, bool *has_f
>  	}
>  
>  	rc = bprm_caps_from_vfs_caps(&vcaps, bprm, effective, has_fcap);
> -	if (rc == -EINVAL)
> -		printk(KERN_NOTICE "%s: cap_from_disk returned %d for %s\n",
> -		       __func__, rc, bprm->filename);
>  
>  out:
>  	if (rc)
> -- 
> 2.17.1
