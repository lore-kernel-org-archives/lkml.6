Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D773C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 20:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E94102098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 20:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NRKpC4Zs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E94102098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbeJQERL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 00:17:11 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:46800 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbeJQERL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 00:17:11 -0400
Received: by mail-vk1-f194.google.com with SMTP id h186so4318588vkh.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 13:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oOG9/si3oFUQBBr19f8zMSrCSy4/XHZFZZWajHYysw0=;
        b=NRKpC4ZsMY5d/5JyI5qVbiRq+UvJnWXzfy+40fI7OcHuyQYkbhUbCSglB2foQHGREk
         vlpbjvdheov9et3E5kiAWUMYblTPgdVdtnkmTFK6C/E8SgRr8QuRePyPxTZontFO1Q7p
         b9gX/ZMoIk9iI8oXlE/3yuCP24nxR2OsUrYUigm5ADDsIVwtjLDrVCLv49E3gDF8OpKI
         KRkih4bGgPb6wnEGLrLkC1kQRWDmblbe8gesf98z++YTAchW9GABrRLlo2orl0LjSr0y
         iFWtexr7m1ZRUR6xSl1ObU9Zo+gRBXEa144yKbzsAODBVOoNemAM0HMkbWP5pLsHTlMl
         PLNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oOG9/si3oFUQBBr19f8zMSrCSy4/XHZFZZWajHYysw0=;
        b=AazQhVfT4e59prxLEgiPwzWKn9KduXxAZVWJWQwFkAZ4lELfRfcGqtQdS6zTj3wXUP
         F4RlOSmkE6Nrx4XAfYBSORt22jdVWvk34LuVgZeFUXJOnI0d3g07p3GvbzVx7cVKYGl5
         g7Vn+Kq3KdiNWfU9yn38ymIdkc9dqotGtzvnODpY2GH07+FkD2ma1YhliQHdRhjGXBYS
         tlEl6zdcDrdE4eNyNhqHbuyg7bkgo80WyUP0pQ3YqTpnA1JFDS7RbipA0dnfUvHZW7pj
         6gNIUJnxyMumFJmOxUS4kraSaam4V2hVnoeyFacNVM1o9+Wl9NZRYzdrYvSTYaPXFzjT
         tHCg==
X-Gm-Message-State: ABuFfoi5R7TrSJe3UIctgLADdzGmNHcDkG7NpN91PEcX/VrdUGnR9QwY
        JYbixmYM9U0XwvbvYOlCjSXuAGeyk/kDHCoKlTiFdg==
X-Google-Smtp-Source: ACcGV62EVqZaW8jxBw/XOJODtbMYyXAsIH7Z0rMdAohbhr1qra+ebF2eYVrGWvoeDcKzGNMi0fkMF00qeEh03KyNchE=
X-Received: by 2002:a1f:4c86:: with SMTP id z128-v6mr9393352vka.73.1539721503815;
 Tue, 16 Oct 2018 13:25:03 -0700 (PDT)
MIME-Version: 1.0
References: <1539699060-3055-1-git-send-email-msavaliy@codeaurora.org>
In-Reply-To: <1539699060-3055-1-git-send-email-msavaliy@codeaurora.org>
From:   Doug Anderson <dianders@google.com>
Date:   Tue, 16 Oct 2018 13:24:52 -0700
Message-ID: <CAD=FV=Uv6yaHCu7_N+ExLDRHHe6cRpNpc6vGBy-Q6kxavuuzNw@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: qcom_geni_serial: Rectify UART suspend mechanism
To:     msavaliy@codeaurora.org
Cc:     alokc@codeaurora.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 16, 2018 at 7:11 AM Mukesh, Savaliya
<msavaliy@codeaurora.org> wrote:
>
> From: Mukesh Kumar Savaliya <msavaliy@codeaurora.org>
>
> UART driver checks for the PM state and denies suspend if state is ACTIVE.
> This makes UART to deny suspend when client keeps port open which is not
> correct. Instead follow framework and obey suspend-resume callbacks.
>
> Signed-off-by: Mukesh Kumar Savaliya <msavaliy@codeaurora.org>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 36 ++++++-----------------------------
>  1 file changed, 6 insertions(+), 30 deletions(-)

Looks peachy.  Getting rid of all that unnecessary code and moving
away from the "no_irq" suspend op makes lots of sense to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
