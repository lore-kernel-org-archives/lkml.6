Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38C0C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2A142070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546888832;
	bh=wU1EP0dXW/CeQFDW4W7z8/tN4EN7Za01mQr9aLBww+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EtI3MvR775NRVGfMRuP+i1s4wfwfuwchJpSZotmNbFZNS31Pd6FK7GXNHOU2N3M2Y
	 MrXIx+8v7aS9dd+83zci6q6k0zdCpbpRaNpQIjrCKB1ac48ASbxJcO0V/SopYZWn2l
	 0ZQ98QvwP5W4aG9DMrh+WHO92QYXniGytUVkyLFk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbfAGTUc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 14:20:32 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45336 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726978AbfAGTUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 14:20:31 -0500
Received: by mail-ed1-f65.google.com with SMTP id d39so1939402edb.12;
        Mon, 07 Jan 2019 11:20:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=9OtQndmec6bQR1I6yUSMhLSXVuG78p4NcJxwO3xOt5c=;
        b=jSWWk4dAgjFNGpi37T1GoaW1LuJTfyGklklFQbWhnXDlngpoxVmgUP4MTvkwvKZyte
         h1litcTwyX8A80gOTrL7r7mSYnmb01UNjhBjmYhA/Aunza/WWuixPWJ4lWzlDfb7iblI
         nHysymNQuWNjQZxoRi7SfcMge8KuppkOC6P/CtTFNYKMwuhzHoNuahiWtRve17vZ7YPX
         SVzZuM4iSKHXdYWzmSh7Ny2PHiS1YiCkQg7x3HRsF8Yqw6gTOQb5MO036wl7UzzI13IF
         0LcZjFg8S+toBJkwDwBObUqa1YQIJduZvKRgXiYOd7Ii7xh47lG5m7FPQH4BLXkyB3fk
         SN2A==
X-Gm-Message-State: AA+aEWbs1WlGLDVTefBg7q81hYyQhZHeqQ9oKK5fz44s3T5xFeDojgV1
        GeEyaPdAk47JsVkCwm4oVfA=
X-Google-Smtp-Source: AFSGD/VwN5WrwNZ7SC2N9eKCOO12rnO6kY7zq35N+Moi0rAbNdosYqVFzdzQnXgeAowuCZ0uy9ucCA==
X-Received: by 2002:a05:6402:796:: with SMTP id d22mr58406782edy.81.1546888829438;
        Mon, 07 Jan 2019 11:20:29 -0800 (PST)
Received: from kozik-lap ([194.230.155.148])
        by smtp.googlemail.com with ESMTPSA id n29sm30613041edd.40.2019.01.07.11.20.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 11:20:28 -0800 (PST)
Date:   Mon, 7 Jan 2019 20:20:26 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     kgene@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, xc-racer2@live.ca,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] ARM: dts: s5pv210: galaxys: Remove hardcoded bootargs
Message-ID: <20190107192026.GA3313@kozik-lap>
References: <20181228161819.18931-1-pawel.mikolaj.chmiel@gmail.com>
 <20181228161819.18931-3-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20181228161819.18931-3-pawel.mikolaj.chmiel@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 05:18:15PM +0100, Paweł Chmiel wrote:
> Since we have uboot (flashed in place of stock kernel),
> it's not needed anymore to hardcode bootargs.
> 
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  arch/arm/boot/dts/s5pv210-galaxys.dts | 7 -------

Thanks, applied.

Best regards,
Krzysztof

