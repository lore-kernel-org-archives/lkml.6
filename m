Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE48C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 21:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A988261A4
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 21:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="D4n6DL3X";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B0CHOeCP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A988261A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752600AbeFYVrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 17:47:21 -0400
Received: from mail-yw0-f182.google.com ([209.85.161.182]:38268 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751556AbeFYVrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 17:47:20 -0400
Received: by mail-yw0-f182.google.com with SMTP id w13-v6so5325261ywa.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 14:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=pwo/4mDDv+A0X05OMt9xnH8uvlL36hkxWaWHUGkFd1k=;
        b=D4n6DL3XokJSB+wBE6vskEz76M0So+qwpypvHJjkS/sgaFk5WxWWhnC8Z8Mpn3Jj4F
         xOv65hANAss1LSSMI7vgZMMrI3OBV1vLhqm8WefIos1t30+CmTinX9b4QBv4EnVXefJE
         NHw06SAOaz46IhXaWAEroqgUkkfp/ET8qLxAykWmrGSAahWXLikWPPITmBY1xTIy+Oc/
         jKutis9McyHw6hWrfHf6c2DpNWVMyvh4BeJaok04vlUglx2CfVh3Hwjsc94mDU3Lm1tE
         /mpDxtA53PQallP3JEfBhdSQJfAvD1rfD1fo+uHXEopsA3XJMfr/3umBscPBNwzDQxKf
         zGxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=pwo/4mDDv+A0X05OMt9xnH8uvlL36hkxWaWHUGkFd1k=;
        b=B0CHOeCP2m5EjSCJsB60q7cWtjNoFsVhKAbqoCBiFU2SQLnWkbZF49iQLQE4nLSc7U
         4WLCdOAxcVYvT3SX16NosLinNoIGxe4HiK+A8dXbAZH8UnzMBFDByv0Vvgm6t0L7lBex
         wGwb84apaLSUxAhcE5hXK2fY+wrVpL8nmQE3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=pwo/4mDDv+A0X05OMt9xnH8uvlL36hkxWaWHUGkFd1k=;
        b=XiCYFyk6X9crRfw9lnVCFAJ8PQtB66Jaxnlr4jdft/75+PWehl5OH2q763uC0/O8ax
         ECSqi3xbLq/O4p9GMgWwejs/EgioT3sc9HfGECB+pSl4cEIyStGMnzVeRlAtF0/JP0ui
         vWknGVPD8R25FxlVNV1GnejivaA/c7Y1OW4TY2l8ZXa1ZsR/xuCmI7Sj8m3czPkUGLPg
         R6VEn5V4RGB5lCnRQBa+2qZnF8G75T1Poeojpj0sTQ3zfREoVqt/yC1OqWD7xFYkHWvz
         0a2xM1CvwsTRbgtL4PSJwSeEIeeQ4Kn43bD8Pm51//VUdcqE78s8ELuC9ddyMfqVKV7U
         sH3w==
X-Gm-Message-State: APt69E1ydE4hQ7sqLdTbveB7UrUFVpxIoCXM/r4T4BTCAtEgIYoMImVy
        HIbM3OOHGE2OTLK9lYs3aK/IZpBhANWDkV34ffLOqw==
X-Google-Smtp-Source: ADUXVKJrvovdP7akTuvWC+9PF/eZILVrBOaQWMmK85S9jzGGn1vuXo/ndmVU8Jo0xhFeGnygV1w0DlTNBfPxtyCEkZs=
X-Received: by 2002:a81:8a81:: with SMTP id a123-v6mr6663831ywg.95.1529963239444;
 Mon, 25 Jun 2018 14:47:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Mon, 25 Jun 2018 14:47:18
 -0700 (PDT)
In-Reply-To: <CACO55tuUROCr14Eq-Yn_OcD21QBjfa33b0Oj4oAthEz5NHHhrA@mail.gmail.com>
References: <20180524172436.GA17738@beast> <CACO55ttzvFZqUjXNut5n0ENR9e2+N2WfWnKnjfaWgNesspQ9UA@mail.gmail.com>
 <CAGXu5jL3GyJxd9EJ=gKb+SY98t2h2Q4VMt0b0fYt8KBBuP2_9Q@mail.gmail.com> <CACO55tuUROCr14Eq-Yn_OcD21QBjfa33b0Oj4oAthEz5NHHhrA@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 25 Jun 2018 14:47:18 -0700
X-Google-Sender-Auth: CDwtXILfnGGeFvwldSTMYGMXqHc
Message-ID: <CAGXu5jKuK687hg6JkToiRaMpOV=rOLJgkcNU51ZXnSzqKvojhg@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH] drm/nouveau/secboot/acr: Remove VLA usage
To:     Karol Herbst <kherbst@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 2:40 PM, Karol Herbst <kherbst@redhat.com> wrote:
> Your patch is fine as it is though, because it doesn't add a new
> issue, it just showed us there is a potential one. We should keep that
> in mind and see how we want to fix that up. I can imagine that this
> might cause some issues in some places, maybe it is totally fine.

Okay, thanks! Who can take the patch into their tree?

-Kees

-- 
Kees Cook
Pixel Security
