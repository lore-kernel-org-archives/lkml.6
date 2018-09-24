Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA68ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 16:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9A6621480
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 16:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xpv7LL4b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9A6621480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732372AbeIXWsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 18:48:38 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38026 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730937AbeIXWsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 18:48:37 -0400
Received: by mail-pl1-f194.google.com with SMTP id u11-v6so9367477plq.5;
        Mon, 24 Sep 2018 09:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=PVr/CJ7B+uWXN7854SVkpDqItnQYqwuMnFUoSQxV8bs=;
        b=Xpv7LL4bMVa4bwo1368VNBYToyWdAayAN1ivi17eHf3xqbswyTho4hbKQsyt5R+0Zo
         H6G2512Pc310BfCFRdwMUB64MYTaCq0NN1jYn4FY0kAGB+FLnjihHzvCHBG29Oud0Ic/
         y9xOvRMK4Jb+MRWo4jvk73OpmHI9FFV3LPsNY8t2E9Robo97LM9QMC5Yp6of0oFjJPqR
         20/mjFX6lv1lrDzqlKJ9EVW6sQbjSIVzpkoPw4Vk0h6Ad8TVo3HMWeB+K0XrxxFFyys4
         mIeMxWLsL1rQywwEa48RcFecSzXIj08AyfbWUaud91WDX/+CSvqR4k6tkn9X3a+0cPO2
         o6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=PVr/CJ7B+uWXN7854SVkpDqItnQYqwuMnFUoSQxV8bs=;
        b=Tq0c8v2u+AD3KTQsD8hWJO4RyYwHKIsCyVUmJP4XaQ+Ni9uQQG7ZPNwj/09/R5rE/w
         L+s6CgyMXVP6KR7BXwJUmcxNknBp7Ko0TmXOS15+cgLzaF8SqcWGGxwJHEsZnlu6GZ2P
         m9Iu8M2yVm5+TnwKZ+1u3Wrmw9Owhx2Sr0uNrj9XQl8uBylqNwAd9qoyD456wrrmglEh
         rzdFjRMqPhUle5lqpvPsZDo9+sZCAL2vgd6cFyTfLd7j9qFg4kOlWuD4upO8c1ZHkk+P
         NRnt3qNAWt+X5bBW7h4LgqRuhBohMv9dO9QkUyPAGr/alM/ee4DIrgEjU6JO96V06sRy
         RISg==
X-Gm-Message-State: ABuFfoiXU60EoOxFqyX/q8sVM+e3w1LUTpOI+dXcTg/P+WxSsRcrNdRR
        D2IlgQ8ofRxchhPQSDlRVI0=
X-Google-Smtp-Source: ACcGV634CZNy7lPQUlv2Mq8u44Pv4Vp5Ymsw/U3J1gawYCyNqgiU8ERzwgjZ/7YefbBUdR4Jw7iXkA==
X-Received: by 2002:a17:902:7887:: with SMTP id q7-v6mr11349966pll.111.1537807535963;
        Mon, 24 Sep 2018 09:45:35 -0700 (PDT)
Received: from localhost.localdomain ([2607:fb90:a699:bb10:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id c23-v6sm1149068pfh.26.2018.09.24.09.45.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 09:45:35 -0700 (PDT)
Date:   Mon, 24 Sep 2018 09:45:32 -0700
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Willy Wolff <willy.mh.wolff.ml@gmail.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thermal: power_allocator: remove early break
Message-ID: <20180924164531.GB4988@localhost.localdomain>
References: <20180921130609.j3esni6xwhi2ew7d@inc028000032.lancs.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20180921130609.j3esni6xwhi2ew7d@inc028000032.lancs.ac.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

On Fri, Sep 21, 2018 at 02:06:09PM +0100, Willy Wolff wrote:
> If a trip of type critical is defined before any trip of passive
> or active type, power_allocator governor will not switch on.


But, if a critical trip is reached, the expectation is to perform a
thermal shutdown. Why would you expect to have power allocator
to be activated during the process of a shutdown?

>=20
> Signed-off-by: Willy Wolff <willy.mh.wolff.ml@gmail.com>
> ---
>  drivers/thermal/power_allocator.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/thermal/power_allocator.c b/drivers/thermal/power_al=
locator.c
> index 3055f9a12a17..6544b68e3ebf 100644
> --- a/drivers/thermal/power_allocator.c
> +++ b/drivers/thermal/power_allocator.c
> @@ -496,8 +496,6 @@ static void get_governor_trips(struct thermal_zone_de=
vice *tz,
>  			}
>  		} else if (type =3D=3D THERMAL_TRIP_ACTIVE) {
>  			last_active =3D i;
> -		} else {
> -			break;
>  		}
>  	}
> =20
> --=20
> 2.11.0
>=20
