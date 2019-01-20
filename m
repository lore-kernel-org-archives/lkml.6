Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7BCC676F4
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 15:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3682120861
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 15:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="K/BoH4Nr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfATPnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 10:43:35 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:33633 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfATPnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 10:43:35 -0500
Received: by mail-it1-f193.google.com with SMTP id m8so5124715itk.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jan 2019 07:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xt6OSfbY32n9hhAD9g737/33MNLX0J6L8rwgNqtQGC4=;
        b=K/BoH4NrB8SAS/IdxZxBMqXhBQ3FKXUs9x/M+V8tNqEIzc9+NlbNIijpqqIwbK3yuh
         hLSbTR6QWo4XyxisOgqBaKA25hKX0OUAzWwTmZf5xukEgU1ouzRyxxs+NEG9A9vwniMr
         ZD/TTfvf5RTNHqHoZQ3L1hNtu8Zoj/qNDOHI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xt6OSfbY32n9hhAD9g737/33MNLX0J6L8rwgNqtQGC4=;
        b=q2fxUtW+H1jy/vf/uGbCbxojN4ydNNuAehjoThQ21nP85OwkQEU7q6HlXbi3P73Hv0
         h7cJyv+LH6bxJeoFRIkJ/lL0PJI3iB+h6ZrY+gzNkb32m75gbdImQMQ1VBraa3t6HAf8
         GWPWddi4MEKmZH2mwDI+kkGNiWOo8XVRfqZwghOnVCkNDaV/cKiAbBJ/1LXRYaf7yKiL
         Rnaqi3rimc7JpEz9BkGns6jkf4tcX68XUM8x1ZfXdamO9Nn5N4rDFRZTSEHt5IXvlZXu
         K7lsI4jSJeFEJgHw+aks+t234uSZjDTQymyAbbZBbcksjPurTAfmKEBJm1QaOMyaJcmL
         nMXA==
X-Gm-Message-State: AJcUukdfDCTjWmiWuywob/B2FiuCPnAm6aEB2Jyay2TPa5hRh/DHudPu
        O2i50Pt5VOYE9w23fdShAOTrH2UGli3xbEI4hgwfMg==
X-Google-Smtp-Source: ALg8bN7faX177yOYMc/jL/sb/U1fdkkITjUcvPFwl8D2zoWPGloddnuId5odHIL5Fzp9W0QtwVRFK9mJXKN2icjv1Qc=
X-Received: by 2002:a24:edc4:: with SMTP id r187mr16780026ith.158.1547999014337;
 Sun, 20 Jan 2019 07:43:34 -0800 (PST)
MIME-Version: 1.0
References: <20190118105807.26425-1-ard.biesheuvel@linaro.org> <CAGXu5jKa6Tzea9SyTi5aOZusnb+1+yTJhMNaz-Ha8sjR7oCWsw@mail.gmail.com>
In-Reply-To: <CAGXu5jKa6Tzea9SyTi5aOZusnb+1+yTJhMNaz-Ha8sjR7oCWsw@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sun, 20 Jan 2019 16:43:22 +0100
Message-ID: <CAKv+Gu_VBQOfV7Z=PfAoBhUbyNtYg8tHumOciN7Yxa8RuQ06XQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] gcc-plugins: fixes for arm_ssp_per_task_plugin
To:     Kees Cook <keescook@chromium.org>
Cc:     Emese Revfy <re.emese@gmail.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Jan 2019 at 02:51, Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Jan 18, 2019 at 2:58 AM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> >
> > A couple of fixes to permit newer versions of GCC to use the stack
> > protector plugin for ARM.
> >
> > Ard Biesheuvel (2):
> >   gcc-plugins: arm_ssp_per_task_plugin: sign extend the SP mask
> >   gcc-plugins: arm_ssp_per_task_plugin: fix for GCC 9+
>
> Nice; thanks! It seems like these should go into -rc4, yes? I'll get
> them queued up for Linus...
>

Yes, given that it is new code anyway, let's merge it as fixes.
