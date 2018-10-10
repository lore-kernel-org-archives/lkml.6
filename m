Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8F3C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E18E12086D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPxZ54e2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E18E12086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbeJJVN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 17:13:29 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:42031 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbeJJVN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 17:13:29 -0400
Received: by mail-wr1-f41.google.com with SMTP id g15-v6so5827581wru.9;
        Wed, 10 Oct 2018 06:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j5FyxAyXKseeKZutFLAjQ5ObTg6PqV8DUYvdcx+/S9c=;
        b=kPxZ54e2GgOG63ZPRubSizgx+e8IBqYmnmH8uaKu6blD4si1IOpLUyJXwuWb6xq90O
         3Z2C/Nupiwc4vZqSLoTuSdYC3bSV1WpyT4Zn0vmJURslyQNFYEaaOqw+kJj/q+eCqk0Q
         0t3bwXYrAjD0QFnYHWf/zq1jBdbnkiCrHZONcoBqmxRPnCLjC5I/nj1oNnyhsMkDcMHR
         2E7xH+2gEt5gA71tR+lhIDMS9OuGcHbU5MwUQMDtNRk4S31lpK7IXo/q6tcBfFug7Ad0
         XtzP96fky6AsiUuvjvRr+CltTRrPSauYtFJcW63T+ZpmFP0vkHKNqZwrfbrNqOAlTAgk
         +Vcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j5FyxAyXKseeKZutFLAjQ5ObTg6PqV8DUYvdcx+/S9c=;
        b=En+ssR4q1gO6XZVc6jJHmrnoSmE5F2Dw+yqnSCVzAZGFmQ/ihikyP34guDZCiCYffT
         qHGr1k89Xh7DFA/iv0wGj4A+O6u8oo5bhe3JWlmkMlgNyOjdoMoy1TkuMUw0SnGbsOc9
         ayrSRxQhezWtUEe7UDzqTC878qCCzQaI7eGp3GIwymUCTJn2TrGIszunJVM54UKgrDY6
         8puW9zCvpeGowg9FT4Pb7HCdT1sp1R5r8vWxpIiDakz+Ke4Xg72LEXwKLL/3bvQVQYo2
         l5yB0ah1L1fwi7AKWqcGDMFCDjNNEoL+/cea+OvnY2dDYGLonTUl2dL5kA0Ksy8gGkNU
         ZrOA==
X-Gm-Message-State: ABuFfoh4m35wQ4EVtdRWoYe3O1/NKcTYkGi08B5CwgnH4pbM18g8VYZ0
        A3EdpplyE0oZpkPlL7oZNkA=
X-Google-Smtp-Source: ACcGV61kebs88MK6K7akNu62uoOLl8dP1sR1h4Q0AqHRJoLnzdHrmF+qt5Rkmj4b/NMxIg9D0a2/HQ==
X-Received: by 2002:adf:f941:: with SMTP id q1-v6mr5139709wrr.151.1539179470760;
        Wed, 10 Oct 2018 06:51:10 -0700 (PDT)
Received: from localhost (p2E5BEEEA.dip0.t-ipconnect.de. [46.91.238.234])
        by smtp.gmail.com with ESMTPSA id c64-v6sm12826142wma.44.2018.10.10.06.51.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 06:51:10 -0700 (PDT)
Date:   Wed, 10 Oct 2018 15:51:09 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     palmer@sifive.com, linux-riscv@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, hch@infradead.org
Subject: Re: [RFC 1/4] pwm: sifive: Add DT documentation for SiFive PWM
 Controller.
Message-ID: <20181010135109.GE21134@ulmo>
References: <1539111085-25502-1-git-send-email-atish.patra@wdc.com>
 <1539111085-25502-2-git-send-email-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="n+lFg1Zro7sl44OB"
Content-Disposition: inline
In-Reply-To: <1539111085-25502-2-git-send-email-atish.patra@wdc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n+lFg1Zro7sl44OB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 09, 2018 at 11:51:22AM -0700, Atish Patra wrote:
[...]
> +- interrupts: one interrupt per PWM channel (currently unused in the driver)

This should probably say what the interrupt is used for. And once you
have that, remove the comment about it being unused in the driver. DT
is OS agnostic, so "driver" is very unspecific and your claim may
actually be false.

Thierry

--n+lFg1Zro7sl44OB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlu+A80ACgkQ3SOs138+
s6Em+A//YNUERpXON1hDSTruvUjUYuyLVi7AhJJCbc+1AadlHjGwaLrId2I1Tjy0
3QoZUDLbpHx9hzzH9wYy7XoCQQsL6HVxEhImolxeeUli89A9SBW0zpPWXayYWdtA
k+fsVgAPYEiEjuqtvfxjCc6MLpIosC+WJa8GB0WpxB5vFC5BzvDwB7xDOr10hETO
Pw2dKKjmWjG3WYV2jk7Vx7W/qJDOoK16D3VyXgkxwg1YfKRGsZAiAGIC6IREFiFj
EFGxaGXDfn3tpoP2qUrnCBFAfwUAZ35GT7c+yjpiQKhRnUhv9y3M4dm1xEJT5FG4
oGhWb8ZAN/dejJf3QuIX53uD09qdqJ2/hfvO5YPYDa7S/5qIYJt9DXl9h/aMNjB9
HkGMFRRwmh/LaZYE06clCIayuYOwDpLtmbXhn8E9+QtxIR1PRXBTK7V8bsR0unvN
pREDxvjSRvDxTSH7sNxADnEouktJlhKCfl1iZ/rMw+9TavqkgIxD60+CvIlp2gnd
cYvEUDkqvLEAHenkICplYiIO7EgVPF36GLdy4UoS+Lp8zIHKfQa6ReCZTPiJGux4
pGx6NOojw9tGhf9F+SR8QLIVbEHKzNbdvXafV2QMmKlOpLnoOMmgSapXdETznHM4
sJKEO82dlN0kQ7uv/wV4wO6RGmXzHNdkSvngHsRrob6+yfPWRdg=
=osbe
-----END PGP SIGNATURE-----

--n+lFg1Zro7sl44OB--
