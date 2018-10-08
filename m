Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7821FC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 06:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22AF32086D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 06:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="riuQfpO5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22AF32086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbeJHNOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 09:14:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:54814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbeJHNOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 09:14:05 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D3292086D;
        Mon,  8 Oct 2018 06:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538978643;
        bh=h2OraBqvVIT6rwrr8cpmQ7lkgIPT8l9MnTkeeFzV0yg=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=riuQfpO5xQZTKr/ZACy8i4kDgHD5ZpO0YlSvJiSWJgq0K/ZtJUh9suAfYpZsDB1XU
         tqS0ik7fg1GN11+GrsnDig0HFEwZrZEFu99X3GdXQDv2Qaa6MkzwxFsStiV10En2H7
         mt++3bmFKs7WMkSX1Ofl/fKBTyEVO6E2epjPm4JU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Sodagudi Prasad <psodagud@codeaurora.org>,
        bjorn.andersson@linaro.org, linus.walleij@linaro.org,
        linux-gpio@vger.kernel.org, sboyd@codeaurora.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <9aec322678417753fe4022691f4bfdbe@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org
References: <9aec322678417753fe4022691f4bfdbe@codeaurora.org>
Message-ID: <153897864285.119890.13024399324598460044@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: protected pins and debugfs
Date:   Sun, 07 Oct 2018 23:04:02 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sodagudi Prasad (2018-10-03 05:38:24)
> =

>          for (i =3D 0; i < chip->ngpio; i++, gpio++) {
> +               label =3D gpiochip_is_requested(chip, i);
> +               if (!label)
> +                       continue;
>                  msm_gpio_dbg_show_one(s, NULL, chip, i, gpio);
> -               seq_puts(s, "\n");
>          }
>   }
> =


Does something not work with the following code in
msm_gpio_dbg_show_one()?


        if (!gpiochip_line_is_valid(chip, offset))
		return;

