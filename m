Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 879EDC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E4AE20870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFNPMhb6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E4AE20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbeLMTSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 14:18:40 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36292 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbeLMTSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 14:18:39 -0500
Received: by mail-qt1-f194.google.com with SMTP id t13so3479909qtn.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 11:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q6yXRiCNJgPjlUmsY+nqAH0pBk6/eg2nefPvcAKhK9w=;
        b=nFNPMhb6gEe940yRMkuQABMB6UNyMn7mKt+fIANuZGA2AaZAJd6HT13xXIwJHkc7WO
         5YIOEj0XzIydWnadVdKpznWttkcUl34FF9x+lrcCX23fQYXu99vaW7OjBaM+f60FZOAi
         c/WnSMa1oiexGmUP1bpCVKxpX9QNCdxbt8N60cbHCb3rGQcDT+zjDKGGmLR2aREvu0TE
         ij1LtHt4aiyD2zapxyTSkEONUMCsgWtB9n8RYl3a1egIPJ8nhkbqonnti+3ZSFdkNOLN
         Q2yJEij5caTi5hdGZqISrNIrjaUx5oUwO1V7w16dazkW79R+747W0hU/7vwxkY5Oo6MC
         X4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q6yXRiCNJgPjlUmsY+nqAH0pBk6/eg2nefPvcAKhK9w=;
        b=RIo/Mga/8WmulLJAKACVyeghYGeCOVVc22d9io4ruOQnrNChINzPGXoGZltAATKWYV
         zhjOXaWf6O5xPMKnPxG08THARs2o0bw7viNRhkfec9kMzeeSfaygyWzNXCVIv+Pd064e
         FkHMGzRYRSYcIhFx9A2Zep2K6L0jKsaYCm0OGBKh4lq2oNiCW5to0jPhwIj6L/t5wGyN
         Dxwg2C8D0QD8+/l0aIzgsPucO9vzXqQsLJnAg38Bol7eljmd9A4ysW+EFOZ/halY4iKX
         st5mDVB/v66feQu/aFPfYt6zsOXGdi8rN9ExE/hBhJKgovAykmPMY+szlOM+nBzLs8g4
         r0gg==
X-Gm-Message-State: AA+aEWbRlq5BIkUFZvrHtHTNl8PjvqmKjq1VhZaqtHs9DPMIxPtYGXSe
        UPgRBerpJ0UhLKN+UJ+djCwsNuXxl/aijv8rHOKF+Q==
X-Google-Smtp-Source: AFSGD/WUVcvXjHFVwx2W1VIccireHS1DX9aEn6D6jg+A+bAqpudYOJJ+hrr5DoNWGqmZsJz4rm1WFI81NBG1iK5nFmc=
X-Received: by 2002:ac8:13c5:: with SMTP id i5mr25463005qtj.365.1544728718806;
 Thu, 13 Dec 2018 11:18:38 -0800 (PST)
MIME-Version: 1.0
References: <20181213134915.24722-1-kraxel@redhat.com>
In-Reply-To: <20181213134915.24722-1-kraxel@redhat.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 14 Dec 2018 05:18:26 +1000
Message-ID: <CAPM=9tyOHiR+Ou-h=qRpwtM+zzX-5z7W59+h8xKD=FSY4qbnsQ@mail.gmail.com>
Subject: Re: [PATCH] drm/virtio: switch to generic fbdev emulation
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO CORE, NET..." 
        <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Dec 2018 at 23:49, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Seems correct to me,

Reviewed-by: Dave Airlie <airlied@redhat.com>
