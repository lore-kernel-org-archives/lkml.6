Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F248C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EF8620896
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QWboTOMl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbfAHJyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 04:54:55 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54065 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbfAHJyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 04:54:55 -0500
Received: by mail-wm1-f68.google.com with SMTP id d15so3482035wmb.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 01:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=RZqrXdy5IG0VR21/QTyfh8+W8hBNnz1taGQf3I3pakc=;
        b=QWboTOMlmOnh40KJgIkfoFDwiz/BqM0NGKZSmcWsEXE+ZmH9JqhdzkYPtq2xl2s7Rq
         ayGFI8isGiJKEy3C5asObVxXnHOXqnG+1zo7xk7xTD623aPB5DoJp6LecwAqcRLVf1jP
         U2Z3U1sst1rXutd8rB0wJxN+lSlrufH/CIRnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=RZqrXdy5IG0VR21/QTyfh8+W8hBNnz1taGQf3I3pakc=;
        b=C+4RYYG3ynqRkXBf4tTIaV6Zr1gn4KR4HBfc2bNfvxIhDN26+oJYcowFs8fvgkbVFn
         mOae6OSsC8elEG0+IJCr5vs4Cw8iptulpkMLgaZUl1KX/BIZx6w0zq3WKMh7VryISxvv
         Bypxnzs6Ua2yohQb8e9WDB1leqidxSsAqE4rwj0d5Jp5vey7kJYXCxR2MuG0RVrkOovm
         Sz1FgvwCOtY+LT/QY3BbffFxg3SjYbrAwfiQDBkKaQI24+QoKUvYofGpdb6w3Ek4EJ5W
         bY3Gd0yuk2P5UT6uCMdLMX5V78Ry0VGsJo5AfyBZ03WEkPrarsm5IQANGbqEaASz2As4
         t0Sw==
X-Gm-Message-State: AJcUukdpVKJajSbESpzE+y0k+RTaRulxAG/xIp/hBg79J5gXcmP0A7OC
        XcfbVIi9Fh80UTlhm9Dv9InvPg==
X-Google-Smtp-Source: ALg8bN4KchvJKPrja7lejMZKj1A9vqrEgDraVHHHN5O96DUa/xTeH71mlKjBwM74LTvCFQo93f5OSw==
X-Received: by 2002:a7b:c76b:: with SMTP id x11mr1153437wmk.37.1546941293312;
        Tue, 08 Jan 2019 01:54:53 -0800 (PST)
Received: from dell ([2.27.35.240])
        by smtp.gmail.com with ESMTPSA id q12sm45206351wrx.31.2019.01.08.01.54.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 01:54:52 -0800 (PST)
Date:   Tue, 8 Jan 2019 09:54:50 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Cheng-Yi Chiang <cychiang@chromium.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        alsa-devel@alsa-project.org, dgreid@chromium.org,
        tzungbi@chromium.org, Rohit kumar <rohitkr@codeaurora.org>
Subject: Re: [PATCH v3 1/3] mfd: cros_ec: Add commands to control codec
Message-ID: <20190108095450.GA27286@dell>
References: <20181226070317.72022-1-cychiang@chromium.org>
 <20190107192402.GW9570@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190107192402.GW9570@sirena.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Jan 2019, Mark Brown wrote:

> On Wed, Dec 26, 2018 at 03:03:15PM +0800, Cheng-Yi Chiang wrote:
> 
> > Note: This patch is merged to mfd tree for-mfd-next branch already.
> > But this is still needed on sound tree for-next branch in order to
> > compile cros_ec_codec driver.
> 
> Is there a tag I can merge?

Afraid not, but I reserve the right to rebase my tree, so if you want
one, you can have one.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
