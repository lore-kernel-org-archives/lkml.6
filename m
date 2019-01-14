Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C76C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 07:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF05120659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 07:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cqmFd0L/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfANHUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 02:20:42 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52577 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbfANHUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 02:20:42 -0500
Received: by mail-wm1-f67.google.com with SMTP id m1so7756934wml.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jan 2019 23:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=uaEFQl7o7PIZISfh6e19MxEPCuPZawfHSjFd0EO2Ym8=;
        b=cqmFd0L/W1Xdg7iTljRNGxIYnqYJbVQ2yoM9CJB7HxImPqwHrTGaiIQVZvR0ap/Rm4
         IPng4jrz+Lc5B4Dl105FdTXHiSDT7xf7emujEYcuOEnw/nguWn6u/kn9EGC1k8bVHJRF
         0eJuo8gFiXfr+1yFo0oEf9qASRban0kZCZ13k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=uaEFQl7o7PIZISfh6e19MxEPCuPZawfHSjFd0EO2Ym8=;
        b=Fc/y6t0U0VsyqebTiT0bBeYVRdvDpWQWkzOVWaqhmL+YvBUD4RX/oeRlcxm404tpB0
         UCQkfvFNWA1m/gFz3rZiTlHVnnJ1Eiv4VG3ZJ4o7N4HH2BFl8xnLlVbVPTA+dKf2apQq
         WXTeOAEQwPYPE9NsAh3oowJddXmWaZL05YT2tSdYv6eUagretZskHvr4Gi09TdFwJHCi
         yGXubKZ4jcHEgO3RRbsdUycerpSuuRwwCtJQ0baGEr2HUJhZi6Yok/VGdsvwsPk0C5Fs
         bZm5gHDSaTcUUeBL4SHY0VpBQKa3ueRs1cYiZz+pCpifT/eB8ynPJhoHLhGLlVUogRap
         ZHeA==
X-Gm-Message-State: AJcUukfO8lkBJJkQU0gWSImgfcoFi0lNki0IJzt5J3g/ZcfKw3cxRyxS
        27D4H9CMCuaBDLreR4rrbE4+ReKrxJg=
X-Google-Smtp-Source: ALg8bN43Ge4GpBzAatPGBywEzj3oWGM8gw7pW/0UFSTydLIu09OH5hWuqvL434yUYZLRe3rdk8/HZA==
X-Received: by 2002:a7b:c08f:: with SMTP id r15mr10783660wmh.118.1547450440288;
        Sun, 13 Jan 2019 23:20:40 -0800 (PST)
Received: from dell ([2.27.35.240])
        by smtp.gmail.com with ESMTPSA id h131sm39215260wmd.17.2019.01.13.23.20.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 13 Jan 2019 23:20:39 -0800 (PST)
Date:   Mon, 14 Jan 2019 07:20:40 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] MFD for v5.0
Message-ID: <20190114072040.GA4703@dell>
References: <20190109072018.GB27286@dell>
 <20190113231006.GC18710@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190113231006.GC18710@amd>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2019, Pavel Machek wrote:

> On Wed 2019-01-09 07:20:18, Lee Jones wrote:
> > Good morning Linus,
> > 
> > Please accept my apologies for the lateness.
> 
> I'd say that for 5.1, you are pretty early :-).

Ha ha!  Yes, indeed.  It seems sending late messes with the brain!

Ideally I'd like this accepted for 5.0 please.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
