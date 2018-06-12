Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 51D0EC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 05:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC5D020693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 05:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUh851Jh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC5D020693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753934AbeFLFJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 01:09:43 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55031 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752612AbeFLFJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 01:09:42 -0400
Received: by mail-wm0-f65.google.com with SMTP id o13-v6so18192928wmf.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 22:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YxAhb/+HtOxLdlzgZn2r2s02sJSh6IqrDgDaPuwqhvA=;
        b=IUh851Jhs9e12bJCnjFf+fFosws6iE/y/bZlaHjUQKAY4q2knWfe1kRyVSvDRLUVXo
         Ttf0AfMLB1z1bc29vcCl3JZS5aR2JdRPhHPRRj4M+el38k7ZnqygeI7JUZ1lJIqHMm73
         3+nouy3JMMR1HeLAKw9QJ7ICrXWlOCPjMXhoOhSH5lSf70bqmbfcC28S3+ZvFOlrK9Hk
         itgSZrVuXW6OsPd5iwEeuE6BNf5CJ4m1NW+W3r5Yv3KSz8Z9xVsYJ8NuOlt4bE3pIHee
         lF4c0c51R6dIq7i89HeEZOf6tH0iN0LH5Q7yn35o7Rr0Cf8Q4qgElxags1UKarK5ddZU
         +g7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YxAhb/+HtOxLdlzgZn2r2s02sJSh6IqrDgDaPuwqhvA=;
        b=ttFBVWb/pvzXlsiy94ozGrSdqoGlBRnuXNTrDLDv/l2bb2Fppa6lYIdTK4g5OvKO3A
         kZ1GlnKzc7azNCOJPcxeKfTAs7zqYzpk/IFJju7SZIdX0onu0jpyWScTCBcjzKmNss63
         dURnrHNIS+UiFpFr06CH1t0ZPmVAIYy/fJNOZvr0bhyXyE5idePAjYmepCS8K8SEJKMV
         bF5eks8WVUQa2z2qSbN7eTEDItokCwcqk1Lr0fu0h+VxvOYAQ08kkVy0P3g7APE+dB++
         At/vMtmxVuqAF4DXkTbqKf6W8aJAwPz3sPTZXYSGNLPWTOAS432JVX0iDqaPqZjwJJGT
         rS3g==
X-Gm-Message-State: APt69E2+yWq0/YmXasM/9BkkEZqARxQd2oSKHDwBE14SB/mWC8jCD8wl
        BxsPqmjLpKcbAyAHgKDuNw==
X-Google-Smtp-Source: ADUXVKL6GpBPL/eDWUEJWFZ10+++7xb4k4HxaJQ3pnU5IKFYDzJOvY3+THd1ftepcr93VHFTKqzUQQ==
X-Received: by 2002:a1c:f106:: with SMTP id p6-v6mr999212wmh.68.1528780181012;
        Mon, 11 Jun 2018 22:09:41 -0700 (PDT)
Received: from avx2 (nat4-minsk-pool-46-53-177-92.telecom.by. [46.53.177.92])
        by smtp.gmail.com with ESMTPSA id i10-v6sm302134wmf.4.2018.06.11.22.09.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 22:09:40 -0700 (PDT)
Date:   Tue, 12 Jun 2018 08:09:38 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proc: add error handling for kmem_cache_create
Message-ID: <20180612050937.GA2985@avx2>
References: <1528777434-40324-1-git-send-email-jiazhouyang09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1528777434-40324-1-git-send-email-jiazhouyang09@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 12:23:52PM +0800, Zhouyang Jia wrote:
> When kmem_cache_create fails, the lack of error-handling code may
> cause unexpected results.
> 
> This patch adds error-handling code after calling kmem_cache_create.

>  	pde_opener_cache =
>  		kmem_cache_create("pde_opener", sizeof(struct pde_opener), 0,
>  				  SLAB_ACCOUNT|SLAB_PANIC, NULL);
> +	if (!proc_inode_cachep || !pde_opener_cache)
> +		return -ENOMEM;

SLAB_PANIC was added to not worry about error handling.
