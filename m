Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id knlCEroRHlsAVQAAmS7hNA
	; Mon, 11 Jun 2018 06:08:26 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9EFBF60791; Mon, 11 Jun 2018 06:08:26 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y+hKhTa7"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 18EA1601D2;
	Mon, 11 Jun 2018 06:08:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 18EA1601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754022AbeFKGIY (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 02:08:24 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33662 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753899AbeFKGIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 02:08:22 -0400
Received: by mail-wr0-f193.google.com with SMTP id k16-v6so18988413wro.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jun 2018 23:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=l6tEjtqAuhx4ZeeZk4L+PI6scv/gpK1JTNd7q/+7EmM=;
        b=Y+hKhTa7zPN3NQwSXYyYJNLdvDOa829nSRT10EaOT3h9V5F81d2Qu8xWC9N4QiAN+V
         CRNzf5tkijkqBCCRAokb3RTwZx0RCtFP6XtT00HEL8gakRQ1dBy+fYXOfUmVhUQTKDaR
         MVWSFXm+EzderTRH/YMUr/F3qs2CV8rwa9QyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=l6tEjtqAuhx4ZeeZk4L+PI6scv/gpK1JTNd7q/+7EmM=;
        b=RexO5N2ZAlI6K4/fD2ESryVRLK7uhKEI7otFaxRKrKYwTsJqJHPr4Vnfk4OuMAOxW1
         zHLLvzDtT+m5MDH6JIxP+4J9e6hYDDDLWmrtKACwCuinLnz0Z4VqZAiRAnTBzCc/p5NF
         lLh9prksR9Gb34SunkKV+bLyJG2HLUXsF5JwGT1INxluD0zMRJMkCGX2ypXiIjKjBGyR
         LgV0hD853F0VS/okB8shyumuuS8+dIpA1y4FcGsofiRYEVlv95KwgDd5XsVjmsjuSajc
         OJXEylK2CsEsdVN9pABkl+H3W+MKEp6uOvBhkJeVDmyXX6KweVddHOdcLvtYJKtkMF0x
         ivSQ==
X-Gm-Message-State: APt69E3dKji1m7MFF1OxPvwNCJqBjY+jZ9ByVblFlRbppOy80PEOV6m8
        GfqMmQkQJfzVkKHSxFAfBTS7jw==
X-Google-Smtp-Source: ADUXVKLfUc4LVywaeLDJrn2D+uAQPTA7wRZuMHse27NuA7IgxpxOjhI2sIKBG2dIuDAfeG0sSuTQnA==
X-Received: by 2002:adf:c444:: with SMTP id a4-v6mr12444263wrg.20.1528697301797;
        Sun, 10 Jun 2018 23:08:21 -0700 (PDT)
Received: from dell ([2.31.163.53])
        by smtp.gmail.com with ESMTPSA id z5-v6sm22475465wrh.10.2018.06.10.23.08.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Jun 2018 23:08:20 -0700 (PDT)
Date: Mon, 11 Jun 2018 07:08:19 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Benson Leung <bleung@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Gwendal Grignou <gwendal@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: cros_ec: remove unused __remove function
Message-ID: <20180611060819.GD5278@dell>
References: <20180608144834.3003465-1-arnd@arndb.de>
 <20180608181956.GA110395@decatoncale.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180608181956.GA110395@decatoncale.mtv.corp.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Jun 2018, Benson Leung wrote:

> 
> On Fri, Jun 08, 2018 at 04:48:06PM +0200, Arnd Bergmann wrote:
> > This function is no longer called, so we get a harmless
> > warning until it is removed as well:
> > 
> > drivers/mfd/cros_ec_dev.c:265:13: error: '__remove' defined but not used [-Werror=unused-function]
> > 
> > Fixes: 3aa2177e4787 ("mfd: cros_ec: Use devm_kzalloc for private data")
> 
> Gwendal, in PATCH v2 of https://patchwork.kernel.org/patch/10439449/
> you mentioned that you readded the __remove to avoid a warning when built
> as a module. Can you explain what's going on?

Yes please, and quickly.  I'm going to sent the patch-set today.  If I
don't hear from you promptly, I'll probably pull the patch!

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
