Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59EA6ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ACE12086E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t3sVszuw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ACE12086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbeJRGLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 02:11:35 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40382 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbeJRGLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 02:11:35 -0400
Received: by mail-wm1-f66.google.com with SMTP id z204-v6so3755885wmc.5;
        Wed, 17 Oct 2018 15:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=z1nZgFuSAWF4xak9H7pvf35PBoIZxIEAvPRBU2/+bmg=;
        b=t3sVszuw3/PkJBe/BCtjH9klhqUCOAjVpQIPDErgDVRS/88mjVVdLgUwhhA3Bgqgii
         3v25watMk7PT3bg7CjwMVmMtnMzCJtfByrw5eHxBrtIQkDCfM2fKW4FogvZMGjSOjQXz
         fLbZN2vDdu4duC3miQP7FbENwlhoP/dVXAJIQTVQ7EDgQVqR4REzCAegu25oi/XkaVa6
         +RobBQQE6SkGyoaKtyrT0qTXHu0Mdz3YJQIlQtqECgvE3P1DB6XAy0Xquvw9T6xXc6Uj
         9ckulN0jj3lOKHh/90wSOGXlWS/MDLl8tzK1Lj+7hC2Uy+MB8aMKqODcQzRVMGlqanX5
         R/8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=z1nZgFuSAWF4xak9H7pvf35PBoIZxIEAvPRBU2/+bmg=;
        b=fTaLDHN/kMwxohwHlJelwwuyMpkFWPnGQCtlkN3dlA49RSiS+No4RJirJMrwfDCD6M
         RNFDLvn2AICQN1mwR4YwnC5ljsxb0jEtqlJdPPHJk3iAXVVat+28YJijYiVg9NFwHqM+
         /q14LbPyh9qjLD/AqHH7+50Zb4FeX6NzQzoPiAj+OX1szUMBZGmar1phJpxRpWslYkSf
         E2DBsXJlUUvdtFPSsNiEyTTMPhFB5JrzKbFPpXeZkbzQEi/9lP40ib1tlCddGcHgOAmZ
         invzjjVD6TDXybdp9meAuBaImSJOiSRsZmCO3HUcnuIWPwTYua6M2Is/R5o+7AnXEEtV
         6qTw==
X-Gm-Message-State: ABuFfohYVBqyH0ncEkXz3HBcfn4W2uRSQcAMQD2dzH1l5JdifWirttfQ
        RRvaCxhKm7NxvbReIluAB1g7awmdjso=
X-Google-Smtp-Source: ACcGV60z3CMIBlFKJasl3rbqtxz/tScx3N2QaIo93sNtIBzIYR+3G1/MuGc+jFRY73Dttfbyio7ycQ==
X-Received: by 2002:a1c:4385:: with SMTP id q127-v6mr4672146wma.111.1539814429367;
        Wed, 17 Oct 2018 15:13:49 -0700 (PDT)
Received: from [172.16.8.139] (host-89-243-172-161.as13285.net. [89.243.172.161])
        by smtp.gmail.com with ESMTPSA id 33-v6sm5509982wra.48.2018.10.17.15.13.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 15:13:48 -0700 (PDT)
From:   Alan Jenkins <alan.christopher.jenkins@gmail.com>
Subject: Re: [PATCH 31/34] vfs: syscall: Add fspick() to select a superblock
 for reconfiguration [ver #12]
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>, linux-api@vger.kernel.org,
        torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mszeredi@redhat.com
References: <f6f2553e-f64d-9c26-4290-baf43e5f533b@gmail.com>
 <19866.1539782101@warthog.procyon.org.uk>
 <68a2107f-bf70-055b-86cf-1ba2ba9422bf@gmail.com>
 <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk>
 <153754766004.17872.9829232103614083565.stgit@warthog.procyon.org.uk>
 <9b8bf436-65de-13b9-0002-0479d11c18ca@gmail.com>
 <20181013061141.GR32577@ZenIV.linux.org.uk>
 <28710.1539782412@warthog.procyon.org.uk>
 <15867.1539791153@warthog.procyon.org.uk>
Message-ID: <240b2620-02cd-89de-4c22-293af6c5ac8b@gmail.com>
Date:   Wed, 17 Oct 2018 23:13:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <15867.1539791153@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[resent, hopefully with slightly less formatting damage]

On 17/10/2018 16:45, David Howells wrote:

> Alan Jenkins <alan.christopher.jenkins@gmail.com> wrote:
>
>> I agree. I'm happy to see this is using the same check as do_remount().
>>
>>
>> * change filesystem flags. dir should be a physical root of filesystem.
>> * If you've mounted a non-root directory somewhere and want to do remount
>> * on it - tough luck.
>> */
> Are you suggesting that it should only work at the ultimate root of a
> superblock and not a bind mount somewhere within?
>
> That's tricky to make work for NFS because s_root is a dummy dentry.
>
> David


Retro-actively: I do not suggest that.

I tried to answer this question in my reply to Eric correcting me. Eric 
was right to correct me.  I now understand the comment above 
do_remount() is incorrect.  I re-reviewed your diff in light of that.  I 
re-endorse your diff as a way to solve the problem I raised.

(I think it would be useful to remove the misleading comment above 
do_remount(), to avoid future confusion.)


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


( the "if" statement it adds to fspick() is equivalent to the second 
"if" statement in do_remount(): )

static int do_remount(struct path *path, int ms_flags, int sb_flags,
		      int mnt_flags, void *data)
{
	int err;
	struct super_block *sb = path->mnt->mnt_sb;
	struct mount *mnt = real_mount(path->mnt);

	if (!check_mnt(mnt))
		return -EINVAL;

	if (path->dentry != path->mnt->mnt_root)
		return -EINVAL;

Thanks

Alan
