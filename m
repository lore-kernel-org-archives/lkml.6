Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2D9C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 15:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 194652184A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 15:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7muRwlc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730620AbfB0PI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 10:08:58 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41335 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729257AbfB0PI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 10:08:57 -0500
Received: by mail-pg1-f195.google.com with SMTP id m1so8093273pgq.8;
        Wed, 27 Feb 2019 07:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ly+8jA1IkY9ftBFxUlZtD1TPf1bZsHrfa4f2IFMESRw=;
        b=S7muRwlcERyiui0B7k6qvbLt2LU+7lXIHrwDvs6tjEJSUpvMKmgG/k7066+bCGRfeH
         KP1dHTiqJacLVzWvvpXxtCfJq8nHNRIY1tbj702w0ippIwyRfJLbtMiP2J0gq7o4UAEX
         vgjmEGkjuVZETnCQsB+M0DGgZclekKR+m4yPiIZWr+e3cVg9Ri6T9u/IDPB9ED0vtGVI
         3kAd3c1497oNb5sESLMfunicn3cKLzm0IKNfh5g+2tE3bLcRzSg54XpluDLLVD0mQMT2
         uPlMAYzyhlE8DGT+auVrqnXgQmabt3WndYyRAb0ZfjwHxi1uDmbwvYHd9Iy064JHCJJY
         ASJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ly+8jA1IkY9ftBFxUlZtD1TPf1bZsHrfa4f2IFMESRw=;
        b=qmPWa+klpXmi3r7RuKv18BkrDfDZUW3vduxNAsMEZuYCKSngRo+ZcLgPAseOc5mP80
         c6cI3ivSbycDD7qDrB05cnutaMbjAg/mA2NjeZ9q7NPOHWO4N7FiroSnuM/HyLHZIpFm
         zTjAsYM//NBHdv6AU37k9L5OGzuuAFjpTD+gzat9nVgKf93tumjSwn7EzjZpexrEsykX
         pLzrtyMHdozU/RCFQeSymMNc10nHeCuYM0tJ6ekhf5EMiYL/k5DaGA8V+oIr8Rigc/Xa
         y3uaSBg/BtFAAZzUw7GfqQNMHeH5kNVHn5tM58mL8qk2x7NqKWcI4Vw5EAVUDCUK91/v
         2oFQ==
X-Gm-Message-State: AHQUAuY7m8p1TOTavNO0iUd70SrJmljSjyN2ZMOzWnwzHscxrgRXqlF0
        O4PZVTzXsh0eHFnoYKggBFSbBKKF
X-Google-Smtp-Source: AHgI3IZzeNdVshgB29zpOxvzos25NFZPXcPEmHzxTv8d8lWfdkHXFWhUdSiGLONHjZOPsNEau+AaNg==
X-Received: by 2002:a62:3681:: with SMTP id d123mr2134364pfa.242.1551280136792;
        Wed, 27 Feb 2019 07:08:56 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id j9sm26468246pfc.67.2019.02.27.07.08.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 07:08:55 -0800 (PST)
Subject: Re: [PATCH v1] drm/tegra: plane: Remove format-modifier checking
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190224153405.8447-1-digetx@gmail.com>
Message-ID: <46fb6670-59ed-0378-cd7e-aea3fd4ee890@gmail.com>
Date:   Wed, 27 Feb 2019 18:08:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190224153405.8447-1-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

24.02.2019 18:34, Dmitry Osipenko пишет:
> Tiling modifier can't be applied to YV12 video overlay because all tiling
> modifiers are filtered out for multi-plane formats. AFAIK, all modifiers
> should work with all of formats, hence the checking is incorrect and
> simply not needed.
> 
> Fixes: e90124cb46bdb ("drm/tegra: plane: Support format modifiers")
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---

For the reference.. this patch needs a stable tag, I did the same mistake in [0]. Thierry, please let me know if you're okay with the change and if you could add the tag while applying the patch, thanks.

[0] https://lkml.org/lkml/2019/2/26/277
