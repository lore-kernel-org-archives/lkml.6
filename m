Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13CFC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 16:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A15132080A
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 16:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546444913;
	bh=X1ZMa+c6ccFOpKPUVP49OXd6c3miTX6G7hPLIsunuAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=snN2gPLTZmuARLhLmzqZPOJEBp6iS3bpOzXe6xe2nY1DFoQKBocbMbvNwGnixfOWD
	 b0Clg3U6ncUc9mJI0+0PDbvwMsop4J9yR3Usv88fs/jHVDnYcnPGrCkgubb7JMvosZ
	 hdDtsF53l069I90knOYlZbUrJDef0n2ac8nD/d6U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729993AbfABQBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 11:01:52 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:45774 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729042AbfABQBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 11:01:52 -0500
Received: by mail-yw1-f65.google.com with SMTP id d190so12171090ywd.12;
        Wed, 02 Jan 2019 08:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2gyVo0zAuaMWKPgLYFM54CA4UZusSqF/vmUNVGmnVPA=;
        b=IEe4J+U6qnkKybj/9bNuccNj6QC9KJjBObWp99oXRW7+c1O7RobYOMrHouyiRO3nxR
         jzfHjhK81pJkFuPWTLUtEprSyZ6WU2CjS00X6NJ0PrREd5dQdKh5NxILr9hzuvhSm7d/
         11t+Gbk4OB+bnUdR9o2K6e+1U9ANO6NRlJDq00K6jE/7niaNy4QYL9Kj0vSQdALyPB2J
         hyUGHTVI6rBuBr1VmvnCT8LTGatl5OvU1y7nueqUV/EadeRwo4oBFe9W0ZYCPANBuafI
         2Fp4zcLoKtiVPNIlZJZqItsyHZxJZdd/qzPpITwhvyRyoRyda8gy4FNhrkfDndsm6uTR
         R2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=2gyVo0zAuaMWKPgLYFM54CA4UZusSqF/vmUNVGmnVPA=;
        b=r9BNzd18IDvT571x3/1rSnkhCNQggGLtQiJiSyI4ccCINI/Bo4bCUKRtB3Nya87bDU
         uze71JvAEpV9A/dh47zYGDwv4z/XFDF3i7Fc4TvVUZCbrKLyY+YpCAXlURkLL61sWnkk
         t1tF8oCjKQqNk49vZcAdaG6UQdptUyX8Bjdsq1vVJEPNlQIPoeGOCa4g1U3CKCa4FqI5
         OFRV+wq84dQg7F7r5iH6eN9naitlaz62Lz7fL3pGVczVWr+v3QKJKKgVFTu5A55Icga5
         WnT43jD+cSlxGLEcaYaBU4r2DVhYkwCXH5G269sCIokkb2M3iyuFLmS4S5GZaXhmEQOW
         vmxQ==
X-Gm-Message-State: AA+aEWZtBpuwyg7RJcAeztCfv5SqLzbn1RnmeYYx9hbCcVf7jWQXBwx8
        x2GNRzE0donXUtgxHq5y43k=
X-Google-Smtp-Source: AFSGD/U7YnrKdfqGB5L7h7dljEExW9Nh/rBBiqylysQakK8/8RC9TpQBTuRJdk5DzuQkIQtyFnTd9A==
X-Received: by 2002:a0d:f2c5:: with SMTP id b188mr44799419ywf.341.1546444911379;
        Wed, 02 Jan 2019 08:01:51 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::6:f03d])
        by smtp.gmail.com with ESMTPSA id r63sm20848514ywe.18.2019.01.02.08.01.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 08:01:50 -0800 (PST)
Date:   Wed, 2 Jan 2019 08:01:49 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Otto Sabart <ottosabart@seberm.com>
Cc:     linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] doc: cgroup: highlight all paths using the :file:
 inline markup
Message-ID: <20190102160149.GQ2509588@devbig004.ftw2.facebook.com>
References: <20181230165044.GA3097@personal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181230165044.GA3097@personal>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 30, 2018 at 05:50:44PM +0100, Otto Sabart wrote:
> Improve readability using the :file: markup.

Heh, that's a minor plus for formatted output and minor minus for the
source.  If this is a convention generally followed for
documentations, I have no objects.  That said, can you please reflow
the lines?

Thanks.

-- 
tejun
