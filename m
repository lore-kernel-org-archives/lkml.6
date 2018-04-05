Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2640917-1522926311-2-12342130989206412658
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522926310; b=W3gUSli11Y5SmFqP3dc/++rhw7ZZc/Nwodib7cKCcdHbzox9i6
    P8DXXzj4uAC0bNhb6IKBw3JNumRGvIBlY+UcBthGl7RfRwhmbD5qwkcg/NzXgQce
    Y3lH457BgMWHnfhgJopCnajdyBKy/HLU4M9vqTbrkMFG4kMfrJs22U0/SeQdZaWl
    IKaG9mp/Q+M21fG1Z5AV5J3g2FBS2R8i/5cgxuwuV9wujYxU8XoNOCCRQq4OlbBc
    //VdCqNFcjgXIRAOlWqxzOSd90IDMBnBQ8ZrZU7J22ummKIkpUJ8765RpVueVEdR
    YScw2EKpjhZNnIEXYJjnBboIx7WtPKNmRrzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522926310; bh=kJiaqLwrUx3EghUyqkRo91UafKNesvpM1yPGuHiF8l
    M=; b=aSwN9ghHxHS0v0XeAvQQ36j18RLUJe7392HMV7/X00Dxr2azuhY0zVhO5l
    MpYXdLytvYWP5XcahZMe0l110ALkyaXbIVXNJYZfAMm7MTrwcOojpxbrZuxeDQyk
    mvu525opZHUqTPZvniA0Y+db3eKYFbxhSM6IgGnXtzFIGtjtQ9O8VGnT7MnphcrL
    yxkA+MvXMcbe/lJNiBC/9SiBm+K8Z4LhAgT3U/HSDhAIi3J8mxi/WKfw9NaWIiC9
    BBmPbMAqGzBpeuxxIXxsaVnPAVGY6bCd2m42GVntyZYRNvxFRr+tirgn8UrhftY+
    4o3LSJCz/n41FL/1/RZAsggw0HDA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=jhEkymJh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=B/k6TUrK;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=jhEkymJh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=B/k6TUrK;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCaHdaUQVrfR659IszjvxfCIqsu81cJcDlss5f/M6XYMK9P5k51kKcCgQrcijQkzd2ZISw1cfzlWvLpPPyo7I1ZmU1hb4HAc3LdYXmZcqzSQ3gDSuog/
    5m2OV1HGlbdGeWvpbPkkzVqhA6xief9SFtP96fPv987rfNw6SOgBJH0WIDxfF3AZUiCmfL0AmDazgYoY7uXx2qnV16P2C5P8vHLRmAkLqXHH9kIR4FF4yzfc
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=i3X5FwGiAAAA:8 a=KKAkSRfTAAAA:8 a=8b9GpE9nAAAA:8
    a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=6mLbiPaCz5qGD_VPZx8A:9 a=QEXdDO2ut3YA:10
    a=kGx2xdnZ_AYA:10 a=mmqRlSCDY2ywfjPLJ4af:22 a=cvBusfyB2V15izCimMoJ:22
    a=T3LWEMljR5ZiDmsYVIUa:22 a=Vxmtnl_E_bksehYqCbjh:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751249AbeDELFI (ORCPT <rfc822;greg@kroah.com>);
        Thu, 5 Apr 2018 07:05:08 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34599 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751038AbeDELFG (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 5 Apr 2018 07:05:06 -0400
X-Google-Smtp-Source: AIpwx4+MlaApPFmYHqpJiFh2pGyMLg64D8QoaCyOi0LJnXlDoTlFAkrE/UDpbjtnKLVAkRW1jJ7F55Cw2NR4y8hOHCQ=
MIME-Version: 1.0
In-Reply-To: <20180403053401.30045-1-oohall@gmail.com>
References: <20180403053401.30045-1-oohall@gmail.com>
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date: Thu, 5 Apr 2018 13:05:05 +0200
Message-ID: <CA+M3ks4RPe_jo-LKKCNU22fzQWO3nvJEiZYg_mB6tSVd9PgqZA@mail.gmail.com>
Subject: Re: [PATCH] drm/sti: Depend on OF rather than selecting it
To: "Oliver O'Halloran" <oohall@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-ia64@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-04-03 7:34 GMT+02:00 Oliver O'Halloran <oohall@gmail.com>:
> Commit cc6b741c6f63 ("drm: sti: remove useless fields from vtg
> structure") reworked some code inside of this driver and made it select
> CONFIG_OF. This results in the entire OF layer being enabled when
> building an allmodconfig on ia64. OF on ia64 is completely unsupported
> so this isn't a great state of affairs.
>
> The 0day robot noticed a link-time failure on ia64 caused by
> using of_node_to_nid() in an otherwise unrelated driver. The
> generic fallback for of_node_to_nid() only exists when:
>
>         defined(CONFIG_OF) && defined(CONFIG_NUMA) == false
>
> Since CONFIG_NUMA is usually selected for IA64 we get the link failure.
> Fix this by making the driver depend on OF rather than selecting it,
> odds are that was the original intent.
>
> Link: https://lists.01.org/pipermail/kbuild-all/2018-March/045172.html
> Fixes: cc6b741c6f63 ("drm: sti: remove useless fields from vtg structure")
> Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> Cc: Vincent Abriou <vincent.abriou@st.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-ia64@vger.kernel.org
> Cc: stable@vger.kernel.org
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>

Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>

> ---
> Cc`ed to stable since the ia64 guys might want it backported. I'm not
> bothered if it just goes into mainline.
> ---
>  drivers/gpu/drm/sti/Kconfig | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/sti/Kconfig b/drivers/gpu/drm/sti/Kconfig
> index cca4b3c9aeb5..1963cc1b1cc5 100644
> --- a/drivers/gpu/drm/sti/Kconfig
> +++ b/drivers/gpu/drm/sti/Kconfig
> @@ -1,6 +1,6 @@
>  config DRM_STI
>         tristate "DRM Support for STMicroelectronics SoC stiH4xx Series"
> -       depends on DRM && (ARCH_STI || ARCH_MULTIPLATFORM)
> +       depends on OF && DRM && (ARCH_STI || ARCH_MULTIPLATFORM)
>         select RESET_CONTROLLER
>         select DRM_KMS_HELPER
>         select DRM_GEM_CMA_HELPER
> @@ -8,6 +8,5 @@ config DRM_STI
>         select DRM_PANEL
>         select FW_LOADER
>         select SND_SOC_HDMI_CODEC if SND_SOC
> -       select OF
>         help
>           Choose this option to enable DRM on STM stiH4xx chipset
> --
> 2.9.5
>
