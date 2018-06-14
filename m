Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 3C4C2C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 16:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC857208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 16:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cb5stogI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC857208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936004AbeFNQkE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 12:40:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:35334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755208AbeFNQkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 12:40:01 -0400
Received: from mail-yw0-f170.google.com (mail-yw0-f170.google.com [209.85.161.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C591208D4;
        Thu, 14 Jun 2018 16:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528994401;
        bh=jQv6zqoGKC3VZkF50Yp2HCNY47eSzNgvnbxTB5q5GT0=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=cb5stogIberEwIkcUGfJ+1gpuku5ZsVbmMfHiO8+CqDQ2/HlTyg2ZMAzYmJln8Mw8
         Dy02TugiFJY30LkPsg3jMGbmizfLyS4Iz0bnpQRH9DJmuOze+Z3x64tUevT5EhXGqn
         yJ42EJMR2QJDy5RNUXQ9piZ/EgtPfOR4tx4CKoqA=
Received: by mail-yw0-f170.google.com with SMTP id v131-v6so2360282ywg.2;
        Thu, 14 Jun 2018 09:40:01 -0700 (PDT)
X-Gm-Message-State: APt69E2ZNx1w77zImMj+m3FnTpdW4M3dhkBAUfQm4d7IRFGf64dVN7Rj
        1NOnwQ1hGhpbctUBeEyzFXX27/UnaGTG1cMOf58=
X-Google-Smtp-Source: ADUXVKJxKtLi1R97ibuOul2HuiVjpHXIvEYCljjtLSdezO07aF4JCILrFIlbCJuj77RqYnQcm8e+8ru6ONL4yeYtN9w=
X-Received: by 2002:a81:94c5:: with SMTP id l188-v6mr1738871ywg.463.1528994400484;
 Thu, 14 Jun 2018 09:40:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5b:b87:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 09:39:20 -0700 (PDT)
In-Reply-To: <948d6c0304eecaf916d21af5cfb0be21df80ed42.1528990947.git.mchehab+samsung@kernel.org>
References: <cover.1528990947.git.mchehab+samsung@kernel.org> <948d6c0304eecaf916d21af5cfb0be21df80ed42.1528990947.git.mchehab+samsung@kernel.org>
From:   Alan Tull <atull@kernel.org>
Date:   Thu, 14 Jun 2018 11:39:20 -0500
X-Gmail-Original-Message-ID: <CANk1AXRnnYketpdvrsvN11hL6G9=WinzWHVM4k9VrGJZJ99pLQ@mail.gmail.com>
Message-ID: <CANk1AXRnnYketpdvrsvN11hL6G9=WinzWHVM4k9VrGJZJ99pLQ@mail.gmail.com>
Subject: Re: [PATCH v3 21/27] MAINTAINERS: get rid of non-existing Documentation/fpga
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 11:09 AM, Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
> This directory seems to have moved to a new place
> (Documentation/driver-api/fpga/), with is already at MAINTAINERS.
>
> So, get rid of the old location.

Wow, you caught that fast!  There's other documentation coming to this
directory soon.  IMO we might as well leave it.  We don't need to keep
adding and deleting this line from MAINTAINERS.

Also, why didn't you cc linux-fpga mailing list on this?  I guess you
ran get_maintainer.pl after adding this patch? :)

Alan

>
> Cc: Alan Tull <atull@kernel.org>
> Cc: Moritz Fischer <mdf@kernel.org>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 783ce44b3e7a..67641f5bb373 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5632,7 +5632,6 @@ L:        linux-fpga@vger.kernel.org
>  S:     Maintained
>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/atull/linux-fpga.git
>  Q:     http://patchwork.kernel.org/project/linux-fpga/list/
> -F:     Documentation/fpga/
>  F:     Documentation/driver-api/fpga/
>  F:     Documentation/devicetree/bindings/fpga/
>  F:     drivers/fpga/
> --
> 2.17.1
>
