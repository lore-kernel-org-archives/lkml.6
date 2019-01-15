Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C0FAC43444
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F26E20859
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4A9K5KA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388383AbfAORdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 12:33:10 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:56183 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388368AbfAORdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 12:33:10 -0500
Received: by mail-it1-f195.google.com with SMTP id m62so6288774ith.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 09:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S50Xi4pVAc+Lyh59ZSjL/y5SVO6FfgukN3lKwSidzeo=;
        b=V4A9K5KA8NUcmLIAhCSIdhcwYkmrCHBXpJA79gPXIU/6dNcDg/Wr4rbZw9RInvka6A
         4wFYdF2XaAqg25fsh5B/9nzfbRB/IRn4GQifmyHWyPynZ/0yrLyXgqqEgIS4yOlPqp0e
         OM6sF67zo7TlCzc/GOfE+dmwX3IEcUjiLIQjzRIbs+D0u/BfnP15y1aaeryalcDu9jib
         AhqUljOogvAHWgTwlElYcMU3iVC/I3zLuqAZmeSANQ/A4yG0GnwGwa58VjEL4TAwCa95
         YmSZCapAe0z7nZHxni/8jhQ0w1gZgKwQntZxbUfCPdcUmSr2XJNRH4Wdvv55dohPy2iL
         Fo8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S50Xi4pVAc+Lyh59ZSjL/y5SVO6FfgukN3lKwSidzeo=;
        b=ko4w7YiyMJJk++3fFV5c5U2h402ln97Xio85QPuZjrd7nWLlkbqc0oHyn4FwH/d2Ka
         y3jpvjZ/ZZMUx+H10Gtt2svdlslPWvSdN2UNX4wyu5kIvuVC6HONEktXQ+HUhRQX10DA
         U+UUYDv0X9nufltIj58wypsi9x/2iiP+wMh2uggMh6uvUICj8c0bFeBRkC4XylHkaUXy
         +eBCKjAqN8R2Kz7Ye84SFhBD+4BNcctskooesEdBswX3DJrUBcX6DZJXjn0HOl57fxkR
         96mrAti+n6RzfTtdsQEpXfilsgHNEWhG4DBhaEIJgwHO+J0AdOD5mupA6wdfW6rotjZo
         XduQ==
X-Gm-Message-State: AJcUukdoGFABJm6PpRfYHRKoiydio+pn7K0C3mY8jPXV8avad1IgOfjC
        FAzkuBuFi4hbgromIu9+GEDXx5sUifmePioA6kU=
X-Google-Smtp-Source: ALg8bN4IvoHxs8NybM2gTNfJqn1APkSFRXfq76jK8lq06qnjyRxURVwADsaDc9OZ7Nc8GNyA+bX1Vmk3LKXgYomSa10=
X-Received: by 2002:a02:48c6:: with SMTP id p189mr2580513jaa.89.1547573589087;
 Tue, 15 Jan 2019 09:33:09 -0800 (PST)
MIME-Version: 1.0
References: <20190115153000.GA15206@kroah.com> <20190115170221.26693-1-thirtythreeforty@gmail.com>
 <20190115172009.GB30853@kroah.com>
In-Reply-To: <20190115172009.GB30853@kroah.com>
From:   George Hilliard <thirtythreeforty@gmail.com>
Date:   Tue, 15 Jan 2019 10:32:57 -0700
Message-ID: <CACmrr9hyu4PbV7tkxJsEdFj=BHx_1MBxpYLa_7MteitbgWX=OA@mail.gmail.com>
Subject: Re: [PATCH v3] staging: Mediatek: Use individual config flags in Makefile
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        NeilBrown <neil@brown.name>, sergio.paracuellos@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 10:20 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> What changed from v2 and v1?  That always goes below the --- line.
>
> Please fix that up and resend v4.
>
Sent. Didn't know to do that - first time contributor here. Sorry
about the churn and thanks for your patience!

Cheers,
George
