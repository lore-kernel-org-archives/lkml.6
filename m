Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C5AECDE39
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 17:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F103E2148E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 17:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EHBzKqHo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F103E2148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbeJRBiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 21:38:11 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51343 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727095AbeJRBiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 21:38:11 -0400
Received: by mail-wm1-f67.google.com with SMTP id 143-v6so2833795wmf.1;
        Wed, 17 Oct 2018 10:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=BaB1/ce/hClSK2KU+l/jGQZH5ku1viGcKGjClrGj5CU=;
        b=EHBzKqHorV+fOacP9lG+jrNem57ALDL41SMD+xRiNEwYORjrTqhS5g3e/3hFOJpK95
         9F3JHgRQyZjJJuc0hL2QFx/r19zjZJix2Ph58wdrX4l+O35KdaonDqoGAp2VdC0yUqhi
         mtxaCXL3lGJ8oUf49Lrrw2w8fr6p+lM9YXqxBkZxfM/+okoskKCsnncGowLCqLH8GQiO
         /lHb40e3EAu6Vcyjj7zwyqaN9QdZ/+LsNtUBS/JTYl/+t9L8iiiji+fawVF3GQoJhP0a
         nwt8OvCOb7Em0b/DB/EOZl5aMdV+Oya7Q86wpD4N9JfU6mX5l22yy/Me4aQJ6TKeDPy2
         3klg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=BaB1/ce/hClSK2KU+l/jGQZH5ku1viGcKGjClrGj5CU=;
        b=b1g6Y4HChjdtqBT0hyP0ayuT47cBaSES6DpAvIKMbjcF2ejmVAsr2GG1JoWdJaKFXB
         UTAzIW5povax2Eop+M/U3AoIWZQyzmmDWvbWil6hYAr7H6axaYPr60cxuYLnlgI12ZgX
         vPlihJAiH8oZV6ibYES/z5yUvKafgZLmgfEgJbOQiAEKdwKZuNfp4F3HmZcpKnRhV7Es
         wwm8VK338GM2CCO3016kRD9boPd5N4EzKh8Gb80hlElIAGAdZe+IpCq5JajQOAD/J3jI
         Ws0NHkIPCfqZoXD1r2RNihklqXcxDt6ojeqqrS8E5RJSEAR7ZAQA999YdXN+AP5l9PwJ
         BZGQ==
X-Gm-Message-State: ABuFfoi2XHxQwVgsseENk636PGstQ1XvEyDcbFZIC+up4O1XIHbtaSux
        zmJve3byP/oQLPDzg9ZR8ft1Awo4zhU=
X-Google-Smtp-Source: ACcGV61d1Lxsc64pTbJsJHnWawv5T5KTK+8Ss+4mB21cPGBZNoqc23gAK+yI1DULeYdY54yvRDp5iw==
X-Received: by 2002:a1c:ed07:: with SMTP id l7-v6mr3828490wmh.47.1539798085828;
        Wed, 17 Oct 2018 10:41:25 -0700 (PDT)
Received: from [172.16.8.139] (host-89-243-172-161.as13285.net. [89.243.172.161])
        by smtp.gmail.com with ESMTPSA id z12-v6sm16357505wrv.46.2018.10.17.10.41.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 10:41:25 -0700 (PDT)
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
From:   Alan Jenkins <alan.christopher.jenkins@gmail.com>
Message-ID: <7b409325-9e23-aa5e-916f-cb362a6940aa@gmail.com>
Date:   Wed, 17 Oct 2018 18:41:24 +0100
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

On 17/10/2018 16:45, David Howells wrote:
> Alan Jenkins <alan.christopher.jenkins@gmail.com> wrote:
>
>> I agree.  I'm happy to see this is using the same check as do_remount().
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

I tried to answer this question in my reply to Eric correcting me.  Eric 
was right to correct me.  I now understand the comment above 
do_remount() is incorrect.  I re-reviewed your diff in light of that.  I 
re-endorse your diff as a way to solve the problem I raised.

(I think it would be useful to remove the misleading comment above 
do_remount(), to avoid future confusion.)

 > @@ -186,6 +186,10 @@ SYSCALL_DEFINE3(fspick, int, dfd, const char 
__user *, path, unsigned int, flags

>  	if (ret < 0)
>  		goto err;
>  
> +	ret = -EINVAL;
> +	if (target.mnt->mnt_root != target.dentry)
> +		goto err_path;
> +

( the "if" statement it adds to fspick() is equivalent to the second 
"if" statement in do_remount(): )

static  int  do_remount <https://elixir.bootlin.com/linux/v4.18/ident/do_remount>(struct  path <https://elixir.bootlin.com/linux/v4.18/ident/path>  *path <https://elixir.bootlin.com/linux/v4.18/ident/path>,  int  ms_flags,  int  sb_flags,
		int  mnt_flags,  void  *data)
{
	int  err;
	struct  super_block <https://elixir.bootlin.com/linux/v4.18/ident/super_block>  *sb  =  path <https://elixir.bootlin.com/linux/v4.18/ident/path>->mnt 
<https://elixir.bootlin.com/linux/v4.18/ident/mnt>->mnt_sb;
	struct  mount <https://elixir.bootlin.com/linux/v4.18/ident/mount>  *mnt <https://elixir.bootlin.com/linux/v4.18/ident/mnt>  =  real_mount 
<https://elixir.bootlin.com/linux/v4.18/ident/real_mount>(path 
<https://elixir.bootlin.com/linux/v4.18/ident/path>->mnt 
<https://elixir.bootlin.com/linux/v4.18/ident/mnt>);

	if  (!check_mnt <https://elixir.bootlin.com/linux/v4.18/ident/check_mnt>(mnt 
<https://elixir.bootlin.com/linux/v4.18/ident/mnt>))
		return  -EINVAL <https://elixir.bootlin.com/linux/v4.18/ident/EINVAL>;

	if  (path <https://elixir.bootlin.com/linux/v4.18/ident/path>->dentry  !=  path <https://elixir.bootlin.com/linux/v4.18/ident/path>->mnt 
<https://elixir.bootlin.com/linux/v4.18/ident/mnt>->mnt_root)
		return  -EINVAL <https://elixir.bootlin.com/linux/v4.18/ident/EINVAL>;

Thanks

Alan

