Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AA9C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2839020664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="smGd3+tH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2839020664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbeJaWjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 18:39:16 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34438 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729130AbeJaWjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 18:39:16 -0400
Received: by mail-pg1-f194.google.com with SMTP id k1-v6so5986310pgq.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 06:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jTHOq0ijxYFYhpkcZAwZHFxOf8ciEjzSD7YiNIKvHZ4=;
        b=smGd3+tHtjsRyMFzU3Bif08CFsFOZwq7vJivKngQHA6kwwEwaBPv/cnkR2VVuJjRph
         GclRP6nK69I1hFuR9GjJjcG/0HJB7dtkLrVQ9MKyI18SDnGiG9QfCrvML/t3Z4a2O+uV
         NcyllrDKnCpWB5rB9vfCbYLJA0be8cZxvSqYvkrvJUd2NTV3TMY9XGZaayh0CNg0HJUl
         9ibnUxPk5zAx6YCTNgOE9IpvH+o3C3/rKSpleWU12XEM04amHnTxW2GqcJmA2i7qePnq
         dQ8y2uNQMhdz3xMKuntyo0oCaaAzLVUMQt9GJUepMm6esJwaY6GQZDVOyxXwMggiuKol
         eL9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=jTHOq0ijxYFYhpkcZAwZHFxOf8ciEjzSD7YiNIKvHZ4=;
        b=WGnxPN9B1nsnpzBi1TGXfLSJZyU6M5BgJ0WQnYuaxJnhbuZIchlh8aP1C9KtKtMLXs
         ahhzEaVN2+ms4LrST9H+9efOEYYx7I81I4ACchWETLaQvl3mdQdBfpPotyjPuCuy4foM
         aB4bhjiNxrks4ybBnfDjwRZ+nPYHfsfyyw2AGl7f6aO8dBPVIUREWXnXZhZXZLFvInIB
         oVSFS71IbCP7i+ChnMxEIgoujUV0C0voml5aVJdNqAOGx4de5wXazyn2zdvndhfYbDKx
         +2LzH1p/13ZHdVYlwwX+iwcCctnsjPMmIjIBfRpiPVUp/IAtqSuQSYg5sMbNS/TpfoMb
         t8Dg==
X-Gm-Message-State: AGRZ1gLKCmHhGufk4ElPCb0TB1L1TG+pGcce3JbFQ4KvfC7OeXiFyL6z
        KX2rHEehqofVKpLWVkysRAo=
X-Google-Smtp-Source: AJdET5fkqq0+B2ZFXjfHgbQf8V9dp+bBYuUlopjc88/ZTaMDC36XALvY7UkFg/uCz2nRj/mttEQBwQ==
X-Received: by 2002:a63:27c1:: with SMTP id n184-v6mr3226233pgn.334.1540993271625;
        Wed, 31 Oct 2018 06:41:11 -0700 (PDT)
Received: from yubo-2 ([191.101.9.198])
        by smtp.gmail.com with ESMTPSA id y1-v6sm30996120pfy.89.2018.10.31.06.41.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 06:41:11 -0700 (PDT)
Date:   Wed, 31 Oct 2018 09:41:10 -0400
From:   YU Bo <tsu.yubo@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] kobject: fix warnings use pr_* to replace  printk
Message-ID: <20181031134109.7t3fy5p6uzj4tpa6@yubo-2>
Mail-Followup-To: Joe Perches <joe@perches.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org, linux-kernel@vger.kernel.org
References: <cover.1540886346.git.tsu.yubo@gmail.com>
 <bdfdef7349f54a69eb5c57764805b8eeb96a24ae.1540886346.git.tsu.yubo@gmail.com>
 <b12c68ec5dc34f69a3538a90a9a17e8d6b853b41.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <b12c68ec5dc34f69a3538a90a9a17e8d6b853b41.camel@perches.com>
User-Agent: NeoMutt/20180512-62-03f98a
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Tue, Oct 30, 2018 at 08:01:50AM -0700, Joe Perches wrote:
>On Tue, 2018-10-30 at 08:01 -0400, Bo YU wrote:
>> Fix warning from checkpatch.pl use pr_* to replace printk
>
>If you look at msg, it can be unterminated with newline.
>
>> diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
>[]
>> @@ -224,7 +224,7 @@ int kobject_synth_uevent(struct kobject *kobj, const char *buf, size_t count)
>>  out:
>>  	if (r) {
>>  		devpath = kobject_get_path(kobj, GFP_KERNEL);
>> -		printk(KERN_WARNING "synth uevent: %s: %s",
>> +		pr_warn("synth uevent: %s: %s",
>>  		       devpath ?: "unknown device",
>>  		       msg ?: "failed to send uevent");
>>  		kfree(devpath);
>
>Perhaps this block should be:
>
>diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
>index 63d0816ab23b..0ba1197f366e 100644
>--- a/lib/kobject_uevent.c
>+++ b/lib/kobject_uevent.c
>@@ -195,12 +195,12 @@ int kobject_synth_uevent(struct kobject *kobj, const char *buf, size_t count)
> 	enum kobject_action action;
> 	const char *action_args;
> 	struct kobj_uevent_env *env;
>-	const char *msg = NULL, *devpath;
>+	const char *msg = NULL;
> 	int r;
>
> 	r = kobject_action_type(buf, count, &action, &action_args);
> 	if (r) {
>-		msg = "unknown uevent action string\n";
>+		msg = "unknown uevent action string";
> 		goto out;
> 	}
>
>@@ -212,7 +212,7 @@ int kobject_synth_uevent(struct kobject *kobj, const char *buf, size_t count)
> 	r = kobject_action_args(action_args,
> 				count - (action_args - buf), &env);
> 	if (r == -EINVAL) {
>-		msg = "incorrect uevent action arguments\n";
>+		msg = "incorrect uevent action arguments";
> 		goto out;
> 	}
>
>@@ -223,10 +223,11 @@ int kobject_synth_uevent(struct kobject *kobj, const char *buf, size_t count)
> 	kfree(env);
> out:
> 	if (r) {
>-		devpath = kobject_get_path(kobj, GFP_KERNEL);
>-		printk(KERN_WARNING "synth uevent: %s: %s",
>-		       devpath ?: "unknown device",
>-		       msg ?: "failed to send uevent");
>+		char *devpath devpath = kobject_get_path(kobj, GFP_KERNEL);
>+
>+		pr_warn("synth uevent: %s: %s\n",
>+			devpath ?: "unknown device",
>+			msg ?: "failed to send uevent");
> 		kfree(devpath);
> 	}
> 	return r;
Sorry, but i have two stupid questions to annoy you:
Q1: If i agree with your patch, here should i to do? Acked-by tag or others or nothing to do?
Q2: In fact, i do not know how to test the patch. Only to cat /sys/bus/pci/* or something?
Thanks,
>
>
