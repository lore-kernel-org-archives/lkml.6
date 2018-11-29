Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2943C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEAE2213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oL6G39Ra"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEAE2213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbeK3FQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 00:16:05 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35006 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbeK3FQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 00:16:05 -0500
Received: by mail-pl1-f196.google.com with SMTP id p8so1437984plo.2;
        Thu, 29 Nov 2018 10:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mRB2vN2J1+bNM91qQK2cv4Nhem2qd2R+JwNTd+4j+Hs=;
        b=oL6G39RaTSThq9mxgW0veJXK0DWlY17b0rHoHuZYfNpqDghfrIJeLCgi68zsEGAa7L
         /M3eW4Nz42iqWdoLmAKYNNGHj9KK4KYELUaEZb5V6sU8QroT+0rmCbyE8HjZCFWakmfc
         SCrlDgNsTQjLMG0cgjkYZStm1rp3jhDswHG1r+jH1lNQH1OwtW8f+RCDa44iJTOUOF32
         pDVUuaf8On7UoJgCmJaKIppijDdYbw+HrtFgpf+9YiWSq3v24ycsmw8p09LMSp34hsLD
         3tzTmlNQG9GxOv9kGLSeD35Xx6WzNB+qRq3dPNp3zTRKDm/dmE+6a6brnDlUitio4F37
         P4yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mRB2vN2J1+bNM91qQK2cv4Nhem2qd2R+JwNTd+4j+Hs=;
        b=oS0Syeejj8kgxa+twTr+/KaY1PdTgzRuuB+96l59m9I/nz1nBE3kxR86sa1rQ9npqy
         yGCi4B2jHdF4pIrpkfzDTaJfqNoy/zce4G+ITDmw9axqTgJmR1u7fK8Hv+zD1hq+VoUZ
         oVhTrw5qSY1D8bdTS7uQgOC6TCJickNquO7cZGVKBIhnjcnsOpvQW03ki9XFEwCF8znU
         LUXOai3qBHdPajwhqYJIPDXA3TsfMuMmABW/7j+Svbg4uhxsYOAZ0h5t8aMnpC6d56tq
         npfPK/OhCcM8MYUeFkdB1TTtwZbQTbaOGCUyaL+y5LPyzQbzTEQYANyLX/GlRz7N/WzD
         5aig==
X-Gm-Message-State: AA+aEWZE4Tp6hd05VgAe3NiR6RlDB/CqzT4+CTfPGVwP4kIl2QZP1lRR
        DrlxmpE28/KDUmlPsWWvwnFxWPsB
X-Google-Smtp-Source: AFSGD/XwnoqiFKJalUDXIIA5i6Hkbfc6yQH0Aqh6kREDZ5Rnaqq0HsWAsgfvcFASAp8mhOC0Y9ilFA==
X-Received: by 2002:a17:902:bc81:: with SMTP id bb1mr2386141plb.223.1543514991118;
        Thu, 29 Nov 2018 10:09:51 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id d11sm2834963pgi.25.2018.11.29.10.09.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 10:09:50 -0800 (PST)
Date:   Thu, 29 Nov 2018 10:09:47 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Cameron Gutman <aicommander@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark@furneaux.ca, ramzeto@gmail.com
Subject: Re: [PATCH] Input: xpad - quirk all PDP Xbox One gamepads
Message-ID: <20181129180947.GB54791@dtor-ws>
References: <20181128024710.10932-1-aicommander@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128024710.10932-1-aicommander@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 06:47:10PM -0800, Cameron Gutman wrote:
> Since we continue to find tons of new variants [0,1,2,3,4,5,6] that
> need the PDP quirk, let's just quirk all devices from PDP.
> 
> [0]: https://github.com/paroj/xpad/pull/104
> [1]: https://github.com/paroj/xpad/pull/105
> [2]: https://github.com/paroj/xpad/pull/108
> [3]: https://github.com/paroj/xpad/pull/109
> [4]: https://github.com/paroj/xpad/pull/112
> [5]: https://github.com/paroj/xpad/pull/115
> [6]: https://github.com/paroj/xpad/pull/116
> 
> Fixes: e5c9c6a885fa ("Input: xpad - add support for PDP Xbox One controllers")
> Cc: stable@vger.kernel.org
> Signed-off-by: Cameron Gutman <aicommander@gmail.com>

Applied, thank you.

> ---
> Dmitry,
> 
> This patch applies to your for-linus branch, since another PDP
> quirked device was added there.
> 
> 
> Regards,
> Cameron
> ---
>  drivers/input/joystick/xpad.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index d4b9db487b16..cfc8b94527b9 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -480,18 +480,18 @@ static const u8 xboxone_hori_init[] = {
>  };
>  
>  /*
> - * This packet is required for some of the PDP pads to start
> + * This packet is required for most (all?) of the PDP pads to start
>   * sending input reports. These pads include: (0x0e6f:0x02ab),
> - * (0x0e6f:0x02a4).
> + * (0x0e6f:0x02a4), (0x0e6f:0x02a6).
>   */
>  static const u8 xboxone_pdp_init1[] = {
>  	0x0a, 0x20, 0x00, 0x03, 0x00, 0x01, 0x14
>  };
>  
>  /*
> - * This packet is required for some of the PDP pads to start
> + * This packet is required for most (all?) of the PDP pads to start
>   * sending input reports. These pads include: (0x0e6f:0x02ab),
> - * (0x0e6f:0x02a4).
> + * (0x0e6f:0x02a4), (0x0e6f:0x02a6).
>   */
>  static const u8 xboxone_pdp_init2[] = {
>  	0x06, 0x20, 0x00, 0x02, 0x01, 0x00
> @@ -527,12 +527,8 @@ static const struct xboxone_init_packet xboxone_init_packets[] = {
>  	XBOXONE_INIT_PKT(0x0e6f, 0x0165, xboxone_hori_init),
>  	XBOXONE_INIT_PKT(0x0f0d, 0x0067, xboxone_hori_init),
>  	XBOXONE_INIT_PKT(0x0000, 0x0000, xboxone_fw2015_init),
> -	XBOXONE_INIT_PKT(0x0e6f, 0x02ab, xboxone_pdp_init1),
> -	XBOXONE_INIT_PKT(0x0e6f, 0x02ab, xboxone_pdp_init2),
> -	XBOXONE_INIT_PKT(0x0e6f, 0x02a4, xboxone_pdp_init1),
> -	XBOXONE_INIT_PKT(0x0e6f, 0x02a4, xboxone_pdp_init2),
> -	XBOXONE_INIT_PKT(0x0e6f, 0x02a6, xboxone_pdp_init1),
> -	XBOXONE_INIT_PKT(0x0e6f, 0x02a6, xboxone_pdp_init2),
> +	XBOXONE_INIT_PKT(0x0e6f, 0x0000, xboxone_pdp_init1),
> +	XBOXONE_INIT_PKT(0x0e6f, 0x0000, xboxone_pdp_init2),
>  	XBOXONE_INIT_PKT(0x24c6, 0x541a, xboxone_rumblebegin_init),
>  	XBOXONE_INIT_PKT(0x24c6, 0x542a, xboxone_rumblebegin_init),
>  	XBOXONE_INIT_PKT(0x24c6, 0x543a, xboxone_rumblebegin_init),
> -- 
> 2.19.1
> 

-- 
Dmitry
