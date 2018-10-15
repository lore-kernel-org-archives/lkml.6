Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C26CC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 20:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFBE420869
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 20:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PMGornX8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFBE420869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbeJPEpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 00:45:13 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:47053 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbeJPEpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 00:45:13 -0400
Received: by mail-yb1-f196.google.com with SMTP id o8-v6so8043732ybk.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 13:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fRC/lUBMTxvViipBmFsJkueN/VvoYnA3tePvRx2rIvw=;
        b=PMGornX8fn3v20pRvqS6FLR0hzegayODeKuLsXNBmrwZwKnUYTb38y/AGQvAEcpijn
         IT8lqt4QGrc/qxQQfwsQGwKCkWvF+pUe2C/ZZIzAsYZJwS4+mRlYAkgFfqFwsz+/DNAr
         c1RT8mBlJjQp0+YWX+mLinhShpnY0rUJmlB4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fRC/lUBMTxvViipBmFsJkueN/VvoYnA3tePvRx2rIvw=;
        b=uMIEBJA0oe3p5zkWG36OKpYs1fXjgqHiwr1AwnQaGJzDUnD+7qPxeGTQd7XhKMJrdJ
         3A5yzgWQa+QjqJvheNPI53ibhLA6nbl8neyP+GF3wgyLUrugSL+QsVujzWwWwcpotRkE
         q4HR96WsfU0/RnvpSTvwdT9B8OHjkwmu5iK/u6s388AmHi46rXYFYfdMTgh6/d6/cI9Y
         cQwlMW/dc96A2GWTIMh10C653+k2OSR7N7fZPTyHd5y+31iOZloJyrlGt8xAqAmu2i7j
         uYVy1GKk0+8FEpBlcXJzJcdGdjQ1z8TguiYZtpc7yAlaOb6InLwhG2menT7gSJKv+RqJ
         Gy3w==
X-Gm-Message-State: ABuFfogFNDYnwjHGmc5LKDRo1+dGQh8n184nk3v92F8jLczDHKJlt+fF
        fXB8dxZCRjtnfyeaHH2e1PNV4E8nkMU=
X-Google-Smtp-Source: ACcGV61NMsU3QBwQ2jfH3w/WGzOyYQze1/mG4GLJa/24J4R27NIATADIqQJt7TFDPnOD9UIRuVhkbw==
X-Received: by 2002:a25:8112:: with SMTP id o18-v6mr9940546ybk.484.1539637096143;
        Mon, 15 Oct 2018 13:58:16 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id n186-v6sm3210602ywn.16.2018.10.15.13.58.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 13:58:14 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id g15-v6so8053731ybf.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 13:58:14 -0700 (PDT)
X-Received: by 2002:a25:3588:: with SMTP id c130-v6mr10145931yba.410.1539637094097;
 Mon, 15 Oct 2018 13:58:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Mon, 15 Oct 2018 13:58:13
 -0700 (PDT)
In-Reply-To: <1539202115.12644.9.camel@HansenPartnership.com>
References: <1539202053.12644.8.camel@HansenPartnership.com> <1539202115.12644.9.camel@HansenPartnership.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 15 Oct 2018 13:58:13 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLmpB1t1DFNeUj3chGv6EiEuNHXnFXFshEKAqPokA5X9w@mail.gmail.com>
Message-ID: <CAGXu5jLmpB1t1DFNeUj3chGv6EiEuNHXnFXFshEKAqPokA5X9w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] code-of-conduct: Fix the ambiguity about
 collecting email addresses
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 1:08 PM, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
> The current code of conduct has an ambiguity in the it considers publishi=
ng
> private information such as email addresses unacceptable behaviour.  Sinc=
e
> the Linux kernel collects and publishes email addresses as part of the pa=
tch
> process, add an exception clause for email addresses ordinarily collected=
 by
> the project to correct this ambiguity.
>
> Fixes: 8a104f8b5867c682 ("Code of Conduct: Let's revamp it.")
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Shuah Khan <shuah@kernel.org>
> Acked-by: Guenter Roeck <linux@roeck-us.net>
> Reviewed-by: Alan Cox <alan@llwyncelyn.cymru>
> Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  Documentation/process/code-of-conduct.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/process/code-of-conduct.rst b/Documentation/pr=
ocess/code-of-conduct.rst
> index ab7c24b5478c..aa40e34e7785 100644
> --- a/Documentation/process/code-of-conduct.rst
> +++ b/Documentation/process/code-of-conduct.rst
> @@ -31,7 +31,7 @@ Examples of unacceptable behavior by participants inclu=
de:
>  * Trolling, insulting/derogatory comments, and personal or political att=
acks
>  * Public or private harassment
>  * Publishing others=E2=80=99 private information, such as a physical or =
electronic
> -  address, without explicit permission
> +  address not ordinarily collected by the project, without explicit perm=
ission
>  * Other conduct which could reasonably be considered inappropriate in a
>    professional setting
>
> --
> 2.13.7
>



--=20
Kees Cook
Pixel Security
