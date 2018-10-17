Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DFBDECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2371521527
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1juynr/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2371521527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbeJQW12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 18:27:28 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36820 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbeJQW11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 18:27:27 -0400
Received: by mail-wr1-f66.google.com with SMTP id y16so29967544wrw.3;
        Wed, 17 Oct 2018 07:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=NPIKIPq9BbMekCEEtHCrFC8HC9DTO2TYmRrXrWkDHxw=;
        b=j1juynr/i2dCIkzhfUeh6nL6KKDp/J0ds9pWT0rz09kdh66T0V7Cy/rKv5lAwwqk7G
         j1UoSL2814JqvIr2fBWqlkw5LNwqTjOjzH+Z/5rGs64BSMvys0YbpfSfVaRVWrMucotY
         0MioKQOU7EMPg0rQCS61OcSVKodGkgvYbB4fgOc57JeMJ5S9M0IaWwWUGo+E70wAZ0bJ
         tXdZ10Bt/5zSZrOGI9/1orWxVYjtJgpVhogF7GvptWzlXQ3ZUtNNgD5/emaofREcTHI8
         hg4OSFsFunWJ+Odr8jctaubqgPJS3lyCMvhBFHS2rO/yR/63ob+G9nXh1rlbYmXN2+tP
         hozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=NPIKIPq9BbMekCEEtHCrFC8HC9DTO2TYmRrXrWkDHxw=;
        b=BF9RiU/bx6W45eCVZU63DzZd6iIrfNGZ1Nfw9KtN2HxJYc4aLzgC3R3CvjLHpwGWRb
         W9j7VTAWZwTbRxeMuckR1uF8cv8i7fiisrLbbJQjdFuXjVzgJlX+J4PWiFh/u8qA6Ul2
         9mECnIhkqy/tHnnz8C9Se4vXLfelIYSPILU7yXYMQOxUhuHga25ZxgVU6TOHJ0Krf/vr
         qnKtWg5zAlYMx3r4EhhbClbPapvezXKmOS/tk+Sl6TnuDk7uwStDUO3Lff69cwlmjLv+
         KMmF4XGyp+be9eHNzzk81rwVjWEGEUMuMbIeOX0bG9/sSYTUKR8pfR4bKCdm65/QWfRD
         8ZTw==
X-Gm-Message-State: ABuFfohNmQH45TvSJcn7p8SyFJlogS16h+W0IfJ9CM35Sk/MVr5D6G0d
        N6NDi98CVpHFKvw8ofhIba9MO0vMUW0=
X-Google-Smtp-Source: ACcGV624MOWsJkh6tKV0t/SgXBHFKKqQZLSrB8+sAm8OVOd1qZsL7/ass1VcyvvQdslCaXrHJJL9ZA==
X-Received: by 2002:a05:6000:12c5:: with SMTP id l5mr23251940wrx.215.1539786688298;
        Wed, 17 Oct 2018 07:31:28 -0700 (PDT)
Received: from [172.16.1.192] (host-89-243-172-161.as13285.net. [89.243.172.161])
        by smtp.gmail.com with ESMTPSA id w11-v6sm27541529wrn.65.2018.10.17.07.31.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 07:31:27 -0700 (PDT)
Subject: Re: [PATCH 31/34] vfs: syscall: Add fspick() to select a superblock
 for reconfiguration [ver #12]
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>, linux-api@vger.kernel.org,
        torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mszeredi@redhat.com
References: <19866.1539782101@warthog.procyon.org.uk>
 <68a2107f-bf70-055b-86cf-1ba2ba9422bf@gmail.com>
 <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk>
 <153754766004.17872.9829232103614083565.stgit@warthog.procyon.org.uk>
 <9b8bf436-65de-13b9-0002-0479d11c18ca@gmail.com>
 <20181013061141.GR32577@ZenIV.linux.org.uk>
 <28710.1539782412@warthog.procyon.org.uk>
From:   Alan Jenkins <alan.christopher.jenkins@gmail.com>
Message-ID: <f6f2553e-f64d-9c26-4290-baf43e5f533b@gmail.com>
Date:   Wed, 17 Oct 2018 15:31:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <28710.1539782412@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/10/2018 14:20, David Howells wrote:
> David Howells <dhowells@redhat.com> wrote:
>
>> I should probably check that the picked point is actually a mountpoint.
> The root of the mount object at the path specified, that is, perhaps with
> something like the attached.
>
> David


I agree.  I'm happy to see this is using the same check as do_remount().


* change filesystem flags. dir should be a physical root of filesystem.
* If you've mounted a non-root directory somewhere and want to do remount
* on it - tough luck.
*/


Thanks

Alan


> ---
> diff --git a/fs/fsopen.c b/fs/fsopen.c
> index f673e93ac456..aaaaa17a233c 100644
> --- a/fs/fsopen.c
> +++ b/fs/fsopen.c
> @@ -186,6 +186,10 @@ SYSCALL_DEFINE3(fspick, int, dfd, const char __user *, path, unsigned int, flags
>   	if (ret < 0)
>   		goto err;
>   
> +	ret = -EINVAL;
> +	if (target.mnt->mnt_root != target.dentry)
> +		goto err_path;
> +
>   	fc = vfs_new_fs_context(target.dentry->d_sb->s_type, target.dentry,
>   				0, 0, FS_CONTEXT_FOR_RECONFIGURE);
>   	if (IS_ERR(fc)) {
>
