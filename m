Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9A0C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8E3520840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="VfqYg5/F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389811AbfAPIpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 03:45:21 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53846 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388860AbfAPIpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 03:45:21 -0500
Received: by mail-wm1-f68.google.com with SMTP id d15so1048525wmb.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 00:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=80QEo/8XjNwWT1qeB3SgGGH0v9JGCbCB1Cnq7X69qrg=;
        b=VfqYg5/FpQTt0ix2YSSrA0MqvKT46jkDjc5w4RjYekDAWyjncJQMam8T0hsK2DT6hj
         2Pvfij2RALQjWCnWugz3LPWNPJFx7JGDk6WI7oJXxmpCAeBE/Hb139NH3y4JszJTY/L2
         mPMp735GMW2U2rPy7YTkSfBdg8lzhY1v2kmexCkDBsrJiGIEflbL+20bM+IBRzL3jzar
         LiRDKh6L5Bya2NAMeRKeqhV+iqWsmyhVYL5b6XZMYjhWrm/6D1G4H9ueBzEYauhE49/U
         ldbjXd7c+TwJxQoz4u8Frt3jt86CYbqj5y0A/aXtYf4AcKd/lqemUizg3TL7TGHJCcgf
         nWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=80QEo/8XjNwWT1qeB3SgGGH0v9JGCbCB1Cnq7X69qrg=;
        b=gQNkqVmmbyWzA1DKkH8FHgmSheLmF2VRIbnP9MBpqVO3IOHO2NoJhsQ8rPoI1mIq15
         pcZNSURQApuTIe7M8RwqSr87hulw0f6JKz6HaddZG17RSvIrSZpGKUNMwQp5hoTmmfC0
         FiqnpvY9VTfi8L/7HWvTjZJFXwPg8d+y3/KDUJPkjMp5MkibgaNEGYrl866v/rx9D6JC
         5/THtF5wr79+3iUmpQI/FA5K7veFbcFh74aD/VshrCsZvU6bC+lgGb3UNx8sTA8126RS
         WHoAdadOcgEG1nDEVhvhG93U4qqOx7GD6OFaCEn0xKI5byyxVhjvYZLmtadVxRWW0rQf
         6jJQ==
X-Gm-Message-State: AJcUukclwWVghr04qNFKDWAht0LPTM4oLg0IR1Kif0UqMLPHdQRyXBNX
        NNh5nNvMhi1dW1cRDVdr/n2I1rwVFygvfw==
X-Google-Smtp-Source: ALg8bN6NrH/QlN4focxAxSSbzkJ0akdCLu3sYrHS+HBB0RzYzl6B9YRJYo084Z6CTvaOyFUPjIsdXg==
X-Received: by 2002:a1c:c707:: with SMTP id x7mr6388758wmf.120.1547628319474;
        Wed, 16 Jan 2019 00:45:19 -0800 (PST)
Received: from brauner.io ([154.119.33.254])
        by smtp.gmail.com with ESMTPSA id n11sm21121287wrw.60.2019.01.16.00.45.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 00:45:18 -0800 (PST)
Date:   Wed, 16 Jan 2019 09:45:13 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next v2] binderfs: fix error return code in
 binderfs_fill_super()
Message-ID: <20190116084511.3vehgzruomfka6ve@brauner.io>
References: <1547607664-5612-1-git-send-email-weiyongjun1@huawei.com>
 <1547627642-96450-1-git-send-email-weiyongjun1@huawei.com>
 <20190116084108.lubcpqaflkzmwfvp@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190116084108.lubcpqaflkzmwfvp@brauner.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 09:41:08AM +0100, Christian Brauner wrote:
> On Wed, Jan 16, 2019 at 08:34:02AM +0000, Wei Yongjun wrote:
> > Fix to return a negative error code -ENOMEM from the new_inode() and
> > d_make_root() error handling cases instead of 0, as done elsewhere in
> > this function.
> > 
> > Fixes: 3ad20fe393b3 ("binder: implement binderfs")
> 
> This should be:
> 
> Fixes: 849d540ddfcd ("binderfs: implement "max" mount option")
> 
> If you have added that feel free to also add my Reviewed-by.

Also, this does need to go into char-misc-linus and not -next so you can
drop the -next prefix from the [PATCH ...] prefix. :) Greg will do the
right thing in any case but it's just clearer if you don't add it. :)

Thanks!
Christian
