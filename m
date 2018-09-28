Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70882C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 23:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 334BC20657
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 23:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKz+mHLi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 334BC20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbeI2G0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 02:26:06 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39986 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbeI2G0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 02:26:05 -0400
Received: by mail-pf1-f196.google.com with SMTP id s5-v6so5308284pfj.7;
        Fri, 28 Sep 2018 16:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=D5eHZerBRfqeQ3F8rVTt+HYC42dMiPZYu042oCMxCok=;
        b=TKz+mHLiv44jhswgBHs4bUkQpqJK8VQOe98F+iBjE58qIxiSiwsNCGzyz1oQFLPG1l
         GHetkfE4cLx8YDWHrziFI2Ur2fdqnAlioumfod9PNCkszapQLXNODlY1Ey3qR7UnCd2g
         3PxA0NO2HY5cA5IDbFIYyPOIrDVp1EbLB5M+5KL6sn04qTovLSNazbtAG31wfI7iJ1l9
         uLcErbwegOFu5oih7dM/oMFjH/Zho4M6M9uRub9fLgoSfFT1fNXNy4hk2ta9bbJgpN+4
         mxgIoLP9UVLgwUnTCojBcSVFmxEbsPZPBiZL9FFzgshgLycsC8NwcQpOKVGGntQ4ITXp
         tiAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=D5eHZerBRfqeQ3F8rVTt+HYC42dMiPZYu042oCMxCok=;
        b=PsvxN2FsYKTuurukh3RQAGJ8gv4zUlXn8pHncSDEmLuGCWjZ7vImbOyKZNmhBxnoCA
         YEDI5yJ0ItLWLU0SnGW/Q90bhu0Me5jzAYrbngewDXDpu+PKvRpgqHCR6AWkW4SPpEyG
         VwWW0ykW3IMzJc7zsqyw/3Ta1yUiYKMs4ZqSOG19RdbodX0sCbJcy4nWhXjrQ26dVbZx
         4fF8XtlI/rH1KWnNbCs1Uj4UjgXLlG06JftqJVOz0NywBwyg0UpewlS+bmg+M+7P4saD
         Golo0Qoqs4zHg+8GRTMxC5ciooxj4QiErdLIPIiaqBdNEtz4iuBdu5JTGHho3cx/ikAQ
         OQqw==
X-Gm-Message-State: ABuFfohwG69PN6XiP0MIozLhNNcHRoF7fyy7uVbhTk6KylpnHtj5/9jT
        bqvYEAITmmB2ssKLTHJlhL8=
X-Google-Smtp-Source: ACcGV623x1hwBhuMb3bXwb3vEB7b3BSgquGjJ9nYNZpVL8TI8/8lni3uUxLhn/D8JyWV9+fx7EdusA==
X-Received: by 2002:a63:6bc2:: with SMTP id g185-v6mr806580pgc.25.1538179196419;
        Fri, 28 Sep 2018 16:59:56 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id a1-v6sm14500994pfc.28.2018.09.28.16.59.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 16:59:55 -0700 (PDT)
Date:   Fri, 28 Sep 2018 16:59:53 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Ramses =?iso-8859-1?Q?Ram=EDrez?= <ramzeto@gmail.com>
Cc:     Cameron Gutman <aicommander@gmail.com>,
        Mark Furneaux <mark@furneaux.ca>,
        Leo Sperling <leosperling97@gmail.com>,
        Enno Boland <gottox@voidlinux.eu>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Francis Therien <frtherien@gmail.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: Support for Xbox1 PDP Camo series gamepad
Message-ID: <20180928235953.GB182370@dtor-ws>
References: <20180828054812.14428-1-ramzeto@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180828054812.14428-1-ramzeto@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 12:48:11AM -0500, Ramses Ramírez wrote:
> The "Xbox One PDP Wired Controller - Camo series" has a different
> product-id than the regular PDP controller and the PDP stealth series,
> but it uses the same initialization sequence. This patch adds the
> product-id of the camo series to the structures that handle the other
> PDP Xbox One controllers.
> 
> Signed-off-by: Ramses Ramírez <ramzeto@gmail.com>

Applied, thank you.

> ---
>  drivers/input/joystick/xpad.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index cd620e009bad..d4b9db487b16 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -231,6 +231,7 @@ static const struct xpad_device {
>  	{ 0x0e6f, 0x0246, "Rock Candy Gamepad for Xbox One 2015", 0, XTYPE_XBOXONE },
>  	{ 0x0e6f, 0x02ab, "PDP Controller for Xbox One", 0, XTYPE_XBOXONE },
>  	{ 0x0e6f, 0x02a4, "PDP Wired Controller for Xbox One - Stealth Series", 0, XTYPE_XBOXONE },
> +	{ 0x0e6f, 0x02a6, "PDP Wired Controller for Xbox One - Camo Series", 0, XTYPE_XBOXONE },
>  	{ 0x0e6f, 0x0301, "Logic3 Controller", 0, XTYPE_XBOX360 },
>  	{ 0x0e6f, 0x0346, "Rock Candy Gamepad for Xbox One 2016", 0, XTYPE_XBOXONE },
>  	{ 0x0e6f, 0x0401, "Logic3 Controller", 0, XTYPE_XBOX360 },
> @@ -530,6 +531,8 @@ static const struct xboxone_init_packet xboxone_init_packets[] = {
>  	XBOXONE_INIT_PKT(0x0e6f, 0x02ab, xboxone_pdp_init2),
>  	XBOXONE_INIT_PKT(0x0e6f, 0x02a4, xboxone_pdp_init1),
>  	XBOXONE_INIT_PKT(0x0e6f, 0x02a4, xboxone_pdp_init2),
> +	XBOXONE_INIT_PKT(0x0e6f, 0x02a6, xboxone_pdp_init1),
> +	XBOXONE_INIT_PKT(0x0e6f, 0x02a6, xboxone_pdp_init2),
>  	XBOXONE_INIT_PKT(0x24c6, 0x541a, xboxone_rumblebegin_init),
>  	XBOXONE_INIT_PKT(0x24c6, 0x542a, xboxone_rumblebegin_init),
>  	XBOXONE_INIT_PKT(0x24c6, 0x543a, xboxone_rumblebegin_init),
> -- 
> 2.17.1
> 

-- 
Dmitry
