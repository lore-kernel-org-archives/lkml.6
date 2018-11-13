Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E46C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 08:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04A492245E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 08:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="j/w37nH8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04A492245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731306AbeKMSVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 13:21:10 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50857 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730969AbeKMSVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 13:21:10 -0500
Received: by mail-wm1-f65.google.com with SMTP id 124-v6so11003926wmw.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 00:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=DDnpujIyQoY0xn1VazT6evKycjBMOR7np8nsrCrpVQQ=;
        b=j/w37nH8upXKs9TjtJvnKRqDS9a2ueSAL3bRhEt6ePBTGG8DulmaHd/hj3hQWQNxHf
         yMiEY3POyKQlspIB58EUyLaY36znB7YgmOlGwOs5vAqryT0gFJG025Qh3bJ/hq9woLPs
         Ia8vzbXti4nvYODmLmH5KGLIo9wrOj7GAnJ18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=DDnpujIyQoY0xn1VazT6evKycjBMOR7np8nsrCrpVQQ=;
        b=GfiohCwPfYNdXxhuqPyiuhab9BrfU/3gE35KbVgyz9QHp1PLV4CqoCtcY088Y6w/c3
         eg+cGmb8u7cmGJsAFMle+dLI4vkpEk0NNI0zJxPNpWFfuvlXcHhexYUX3kM7ISuLObay
         0+hkIFgJ8lXE1YC+BKseRivQXMM/8jKR/cyn5j4DTV1530Yvl9BGi2Au0vVUuX8e7MZn
         JHBiWAYRdLkOkeBGs3LwWKNlhLATMZu/iUgvQE44QjKww6Tj1AfTjXMzdJMPxoiZfaoQ
         gKMiUzSr2NncZffOKnHwEAVGLA1WtN2yP2ugV2FVhaG6oIXnYavaghD2FtNPsPPKpZpw
         7oOw==
X-Gm-Message-State: AGRZ1gIO7farpRIdLLihbfen5oU71bhaFTXLepFebBFTWP7xUAqqVkZ2
        qrQljCjExlgp5cLgX+WmCaSvnoR8OoU=
X-Google-Smtp-Source: AJdET5d380c/ejfMaqk9abBmA7pg53QtONeK1whqhcNr/u1X0c55tPa5Lyv4Law7qmfnMHKDFuVL6w==
X-Received: by 2002:a1c:750d:: with SMTP id o13-v6mr2370125wmc.100.1542097448905;
        Tue, 13 Nov 2018 00:24:08 -0800 (PST)
Received: from dell ([2.31.167.205])
        by smtp.gmail.com with ESMTPSA id z192-v6sm8869862wmc.37.2018.11.13.00.24.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 00:24:08 -0800 (PST)
Date:   Tue, 13 Nov 2018 08:24:06 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: madera: Add shared data for accessory detection
Message-ID: <20181113082406.GA3513@dell>
References: <20181112152837.21553-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181112152837.21553-1-rf@opensource.cirrus.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Nov 2018, Richard Fitzgerald wrote:

> Add variables to struct madera that will be shared by the
> extcon and audio codec drivers to synchronize output state
> during accessory detection. Also add a mutex to protect
> the DAPM pointer.

Why the odd 58 char line feeds?

Not a blocker.  Just looks strange.

> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
>  drivers/mfd/madera-core.c       | 3 +++
>  include/linux/mfd/madera/core.h | 7 +++++++
>  2 files changed, 10 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
