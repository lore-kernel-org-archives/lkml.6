Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD59C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAC1B2148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jSX14q4L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfA1Guf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 01:50:35 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53931 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfA1Gue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 01:50:34 -0500
Received: by mail-wm1-f68.google.com with SMTP id d15so12692707wmb.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 22:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=zySYNKIWrtX4JtR2a1Sbfj1iDdBwX9NEAwr/jQmKIgw=;
        b=jSX14q4LQDUNgdy6D6SmeOlKoRmpJ3IVq/ZYsUigD7s71RqtsLaQoY4ffuBOKAhE6n
         NqHfbd/cYsNwtSNpzJLjqy5Ld8qHDorZ7dPd1AUx2XD3q9b6EC02ofwH/uIf0n/bTai5
         3XVfHcugwc6b8idS+4rCWmvDWuzcorFLWnMdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zySYNKIWrtX4JtR2a1Sbfj1iDdBwX9NEAwr/jQmKIgw=;
        b=Yoob9hx6pnkk6d0cFw44dqRMBA+1Bn9HTlJaL/rRqqZh5P36OycRgcJR8Yly7mWzDI
         N+I7phkNwwxiZ5otI+hCKfUoYJNJeBAW6jqsn8aSVaIeIpo3isg64CO82rWrH2NrLUIP
         vtWjt88LlbTiTi2hhici4vMNlNtmC9EWb7f/deyunMp9bgWnIaLV07QxUSYIlPfj8X8/
         Lj+459edPXfaZQoNCy8HMKWMDs6Pub4/8/+ForZb30afwVjF/45GJ97ye/42rkJTw+OK
         tPEupR+IyUS7y0DM39foGjFZVcoHskum9XPWiFaTyPogMvDLu0HCwKPmN1emI4BJdHUL
         Z75g==
X-Gm-Message-State: AJcUukcrprbxT8198Ty4CHaz64AlIjit3JhLdv794cWeVdNTFeTFSn/U
        L+vVLJe02WbvpTdPZfM4Yt3E/Q==
X-Google-Smtp-Source: ALg8bN4qY8d/xxZniatSLM1FH+OwqpO6/eihlw7eYwTWUIgkftGkwupJg4UdkOTlvO81pvzPw6rThw==
X-Received: by 2002:a1c:4108:: with SMTP id o8mr15183969wma.91.1548658232790;
        Sun, 27 Jan 2019 22:50:32 -0800 (PST)
Received: from dell ([2.27.35.198])
        by smtp.gmail.com with ESMTPSA id e17sm180988387wri.36.2019.01.27.22.50.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 Jan 2019 22:50:31 -0800 (PST)
Date:   Mon, 28 Jan 2019 06:50:30 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Cheng-yi Chiang <cychiang@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        alsa-devel@alsa-project.org, Dylan Reid <dgreid@chromium.org>,
        tzungbi@chromium.org, Rohit kumar <rohitkr@codeaurora.org>
Subject: Re: [PATCH v3 1/3] mfd: cros_ec: Add commands to control codec
Message-ID: <20190128065030.GA4678@dell>
References: <20181226070317.72022-1-cychiang@chromium.org>
 <20190107192402.GW9570@sirena.org.uk>
 <20190108095450.GA27286@dell>
 <20190108161238.GG6590@sirena.org.uk>
 <CAFv8NwK4=m1ffsyTruMPw534FVK6QBeaMKxxW461aS_yNYugNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFv8NwK4=m1ffsyTruMPw534FVK6QBeaMKxxW461aS_yNYugNg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jan 2019, Cheng-yi Chiang wrote:

> Hi Lee,
>   Could you please give Mark a tag so he can merge ?
> The later patch for cros_ec_codec driver is pending on it.

Apologies for not getting back to you.

I was waiting to see if my late PR would be merged.

It was, which means the tag you were asking for is actually upstream.

Any issues, let me know.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
