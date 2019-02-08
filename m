Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D213C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 08:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB0A72147C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 08:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="vk4hDK1a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfBHIBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 03:01:46 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40527 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727127AbfBHIBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 03:01:46 -0500
Received: by mail-ed1-f67.google.com with SMTP id g22so2008009edr.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 00:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0UWWfzBZwmtp06MD7tTOFl15RNd95H3+jE26xLtAo0o=;
        b=vk4hDK1a4WnrgVZQ9DH3JoG9ZUZRVrAj6UFzspIDJ92ZfwkC8sCe2pav/SycRKl8jE
         zUbyNvATeAw2vpeG84dqH6rDPZijYqzwDzNqTuwgd2xnQk9EK2oyXqSNtbrfWHHREOtA
         rzKh+xjNWDmENTQo4neqec4EyomlGub4Yb+fn1Ad0ciymaOtqocmBNy13+PmB5Us1qck
         pvYwZTvraUHpVOsksyjT2VFlGcd1usL0PoLLjIQIVeRIxYP5nsvC7NtEl8eCB4+96v1e
         B1dtEMvpVxAs0Rse/ZUpTUWG2nyneOYhs+CpQ+QHQkFCXA0i5qGJegORBJ4aLIal+a1n
         fm+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0UWWfzBZwmtp06MD7tTOFl15RNd95H3+jE26xLtAo0o=;
        b=puoooqbjIVsm+E94iOjOfOfONZheBeiC6gYz2oT8zTS9bch2NACOp3GA4fJhjLwBTu
         1LgFr0cdGIHQEED+kLlJ11Vim8v+pKU+aPNjQtQBDPyeU3KXiDsjVfsn2+es5QMin/CF
         oFxgBAuI5CGA3BrLAuSea1YYL19T+SltuX0wqFQu6DqZObkESqTsI86km5M8jgCYhd4/
         TNl2NC/k8kiI+kE4SqXIDEGfTQf/OKiviFDEu3jGkdEIBx+2pStxq9JzkJc0eeWuMLKC
         ETn5jaLaVWnWGKoN3LVktYecX6TCeJiT4l7ugv45uTKt3yzWaLv1vkWLE6C5oxcfNO5M
         gnyw==
X-Gm-Message-State: AHQUAuaMiDhhSNIGcA4XH5s31NnJiIJr63x2IHRcOYVgPwVJiLaxjfwx
        9mf9f1BlFO8pZI0bwoj6JLZMqg==
X-Google-Smtp-Source: AHgI3IaItRXpNpAKQ9wTPaXCwL98GYgdtWPeoEDGrHytX+U/Wg68/92RhzbP5eZBLg/t0oAwYsHSmw==
X-Received: by 2002:aa7:c981:: with SMTP id c1mr15854411edt.54.1549612904379;
        Fri, 08 Feb 2019 00:01:44 -0800 (PST)
Received: from netronome.com ([2001:982:756:703:d63d:7eff:fe99:ac9d])
        by smtp.gmail.com with ESMTPSA id x38sm448447edx.24.2019.02.08.00.01.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Feb 2019 00:01:43 -0800 (PST)
Date:   Fri, 8 Feb 2019 09:01:42 +0100
From:   Simon Horman <simon.horman@netronome.com>
To:     Eli Cohen <eli@mellanox.com>
Cc:     jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jakub.kicinski@netronome.com,
        dirk.vandermerwe@netronome.com, francois.theron@netronome.com,
        quentin.monnet@netronome.com, john.hurley@netronome.com,
        edwin.peer@netronome.com
Subject: Re: [PATCH net-next 2/2] net: Change TCA_ACT_* to TCA_ID_* to match
 that of TCA_ID_POLICE
Message-ID: <20190208080141.dlksz5dfkufj2sbm@netronome.com>
References: <20190207074549.29861-1-eli@mellanox.com>
 <20190207074549.29861-3-eli@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207074549.29861-3-eli@mellanox.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 09:45:49AM +0200, Eli Cohen wrote:
> Modify the kernel users of the TCA_ACT_* macros to use TCA_ID_*. For
> example, use TCA_ID_GACT instead of TCA_ACT_GACT. This will align with
> TCA_ID_POLICE and also differentiates these identifier, used in struct
> tc_action_ops type field, from other macros starting with TCA_ACT_.
> 
> To make things clearer, we name the enum defining the TCA_ID_*
> identifiers and also change the "type" field of struct tc_action to
> id.
> 
> Signed-off-by: Eli Cohen <eli@mellanox.com>
> Acked-by: Jiri Pirko <jiri@mellanox.com>

...

> diff --git a/include/uapi/linux/pkt_cls.h b/include/uapi/linux/pkt_cls.h
> index 7ab55f97e7c4..51a0496f78ea 100644
> --- a/include/uapi/linux/pkt_cls.h
> +++ b/include/uapi/linux/pkt_cls.h
> @@ -85,7 +85,7 @@ enum {
>  #define TCA_ACT_SAMPLE 26
>  
>  /* Action type identifiers*/
> -enum {
> +enum tca_id {
>  	TCA_ID_UNSPEC = 0,
>  	TCA_ID_POLICE = 1,
>  	TCA_ID_GACT = TCA_ACT_GACT,

This change updates the UAPI. It seems to me that it would not
break existing users. But I would like to ask if this has been
given due consideration.

...
