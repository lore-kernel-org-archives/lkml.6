Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A275ECE567
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CE5E206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ed9iyHl5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CE5E206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729405AbeIRP0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 11:26:32 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39332 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbeIRP0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 11:26:31 -0400
Received: by mail-pg1-f194.google.com with SMTP id i190-v6so772863pgc.6;
        Tue, 18 Sep 2018 02:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3eUCVi98dkEm1RMZ4qQhPNWICytBGuC6Ng6gRyy/H7w=;
        b=ed9iyHl5ibQRzD5Ka3LHRsaP1HvaGeMcTwon8rIyroENEt/wXdUDbV94rg1sxtCuXM
         ipRBlCzLVELz1ewWzEMoEp73tWixAUNairB2JRsrv/5pzpfrDay4IYI4qSjyvw7okYaV
         wXkkAt1Y1F+j+L8aMaRX/7c1ayKfPvztyJFar9D5MQQcY8mu9wvacrYprTKNTBIVx0UR
         FV52YOVXxqvv6sHSy623bymi0xIrn0axCPpjp3/y1YmC4TrJEyg7ppYJQNE92hV69Rvl
         iAP2guxKzOqHt3qw0j5My2QEL3Igsc0xKK6tcgBWW7C3iGVFVV+4FDE2vvvj+ZCNy/CY
         Garw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3eUCVi98dkEm1RMZ4qQhPNWICytBGuC6Ng6gRyy/H7w=;
        b=nm8bUyo1lIAZvh2cCPM+qE7BRrhlOfPDVhAQm80rzK1TWvt9TpeObqwbXMri+pXXBc
         It2+eZ8YTRHSq0TBADWMhEPraFsMQ/cGSbeQJ5QM4F8o02cvlZdr0lhy2XWExovZJJQf
         RJ5Eyzg5yL28xYiiz+Qd7dVffRghW2j5gfb/mNY4g/MxKaYdIlCaXioolYjD8XssPW9Y
         Gx6DfNWeGr2HR5m/vOnuVehf3ishzdPZn3bwp4Z2Y3DwZj1O+LTUOhz0At5m04oNXLaK
         H+qgvF61soD/DWKXm9K5+S6S6+VpNbn0Ywxnws9zFNE/fGig2hN6rt8ZLNooQ0QxMvnl
         g4kg==
X-Gm-Message-State: APzg51BXEEme0t4/0/+FZRyStNmDnHEjNFR+NauX9lJa/X17Vieu9rrY
        o7DiWZji7I/B41vamhlXFxA=
X-Google-Smtp-Source: ANB0VdZ/DJHV9XvwkK8HXFmp+pbmWxJwnbUGOPmVjq8YiLhteOV8zb7kMRuYFgjSVyHOgfJHeDJrbA==
X-Received: by 2002:a63:5706:: with SMTP id l6-v6mr27877664pgb.118.1537264481309;
        Tue, 18 Sep 2018 02:54:41 -0700 (PDT)
Received: from localhost ([110.70.59.176])
        by smtp.gmail.com with ESMTPSA id s16-v6sm21622802pfm.114.2018.09.18.02.54.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Sep 2018 02:54:40 -0700 (PDT)
Date:   Tue, 18 Sep 2018 18:54:37 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/33] vfs: Implement a filesystem superblock
 creation/configuration context [ver #11]
Message-ID: <20180918095437.GB417@jagdpanzerIV>
References: <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
 <153313714181.13253.304098108512966976.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153313714181.13253.304098108512966976.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (08/01/18 16:25), David Howells wrote:
[..]
> @@ -2460,18 +2428,41 @@ static int do_remount(struct path *path, int ms_flags, int sb_flags,
>  	if (!can_change_locked_flags(mnt, mnt_flags))
>  		return -EPERM;
>  
> -	err = security_sb_remount(sb, data, data_size);
> -	if (err)
> -		return err;
> +	if (type->init_fs_context) {
> +		fc = vfs_sb_reconfig(path, sb_flags);
> +		if (IS_ERR(fc))
> +			return PTR_ERR(fc);
> +
> +		err = parse_monolithic_mount_data(fc, data, data_size);
> +		if (err < 0)
> +			goto err_fc;
> +
> +		if (fc->ops->validate) {
> +			err = fc->ops->validate(fc);
> +			if (err < 0)
> +				goto err_fc;
> +		}
> +
> +		err = security_fs_context_validate(fc);
> +		if (err)
> +			return err;

		goto err_fc?

> +	} else {
> +		err = security_sb_remount(sb, data, data_size);
> +		if (err)
> +			return err;
> +	}

		goto err_fc?

	-ss
