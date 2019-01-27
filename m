Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0323CC282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 23:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC5E2133D
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 23:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbfA0XIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 18:08:17 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:46252 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726302AbfA0XIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 18:08:16 -0500
Received: from mr3.cc.vt.edu (mr3.cc.ipv6.vt.edu [IPv6:2607:b400:92:8500:0:7f:b804:6b0a])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x0RN8GrA025522
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 18:08:16 -0500
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        by mr3.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x0RN8BqE006064
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 18:08:16 -0500
Received: by mail-qt1-f198.google.com with SMTP id n45so18779915qta.5
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 15:08:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:date:message-id;
        bh=QQQI1VeREQLrhDI8VVdoD+egvcJS/4EzoFBcR02kzdA=;
        b=lEFBMeAI6J5K8ps2AKhFzv4zxDpRLc8vqVrFc9bc6HWs3kMaXw/J6Y2cU42qroKs+k
         Zm8dXoRJMnsKyHRS/ufgiQVik6NS79Dc9EENdkjD54pLMLk626M30ZSEn/gPNfaU1bQy
         y1fnAJpIjK3GZ8jfVWupSd+VW2pvlnBqdRAAOTZPWSbIHu4NhWBMSfclYDkdPbvwiZlx
         RDVk2AQgkVd2tFHVxJua4O1lZN7qS1DnzIFyZVkFgCL4+4aZc8kmGQKz8bKqpCNlh6yi
         so+4zmA0CHQoHymD1Ffcq4zf3epIdbciYWIs66VBha1lig7jDjn+lRC9aXgSq9VLlxjL
         PuXQ==
X-Gm-Message-State: AJcUukfEcpBa6PRdxVpDVKCVsW/UYds9O/2A1p7I1Bh6Opu4UKq4XxuK
        L0LWeESq0lkL+nCw0uzVcKDUETTeQSS7L/evup/AgJOwZdLsmQveQTTX++X3/tKudwES3Bim3Fg
        5JxuLI8CdQ/JSvDnOX2EmsujfDqALOrA/iFU=
X-Received: by 2002:a37:61cd:: with SMTP id v196mr17796082qkb.25.1548630491000;
        Sun, 27 Jan 2019 15:08:11 -0800 (PST)
X-Google-Smtp-Source: ALg8bN6YKNOekIeWq2fp5ZJWmzwVkrTCS4z7c8HwfcFREpt0CaQunJIEglpMk5hX4Ez5BUMeqNrmGQ==
X-Received: by 2002:a37:61cd:: with SMTP id v196mr17796068qkb.25.1548630490866;
        Sun, 27 Jan 2019 15:08:10 -0800 (PST)
Received: from turing-police.cc.vt.edu ([2601:5c0:c001:4341::936])
        by smtp.gmail.com with ESMTPSA id w184sm97215556qkw.90.2019.01.27.15.08.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 Jan 2019 15:08:09 -0800 (PST)
From:   valdis.kletnieks@vt.edu
X-Google-Original-From: Valdis.Kletnieks@vt.edu
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Bharath Vedartham <linux.bhar@gmail.com>
cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: iio: industrialio-core: add check when kzalloc fails
In-reply-to: <20190124142755.GA31059@bhar.linux>
References: <20190124142755.GA31059@bhar.linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Sun, 27 Jan 2019 18:08:36 -0500
Message-ID: <17314.1548630516@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2019 19:58:00 +0530, Bharath Vedartham said:
> add code to handle the case when kzalloc fails to allocate memory to dev
>
> Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>

>  		dev_set_name(&dev->dev, "iio:device%d", dev->id);
>  		INIT_LIST_HEAD(&dev->buffer_list);
> +	} else {
> +		return NULL;
>  	}
>  
>  	return dev;

Not needed, as the 'if (dev)' statement fails, dev is already null.
