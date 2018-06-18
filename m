Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2432C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 06:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5536B208E8
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 06:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d45OBlv9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5536B208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754882AbeFRGP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 02:15:56 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35097 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754458AbeFRGPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 02:15:55 -0400
Received: by mail-pf0-f194.google.com with SMTP id c22-v6so7633902pfi.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jun 2018 23:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c5PLhgJu+k846jOX+xtKTb+HjTELTh72nbVQm02eqbY=;
        b=d45OBlv9UI3KpR9O95y8pdzLPnwZiE8sS8p6h02pyYuyGag7JVud4d+rqZMwphdlv9
         m8mFtbwRLikr3UYLT+vEdyUWWI86udiJ1nYciA5ccgTVl+cvWek866kHfUbIvbMpouiH
         oJ0aY5nwCWMCUsPWT5oU6UKh48ryLUzo4lcjrdVys5W1bZRa4RnQEkJ2pJk51iAvl3zz
         7Qg0xPs9tnvb2g3mp4sv4ZtV/Lb4ZaTIEWwbOw3CyM6B8vxdj3ERDWBECc2XnEbST59o
         fXVVaz707lE1k16A9Oae5cl3XTTvaiHj6IcGnmv+6eYdriFCMBtJwH1AMbn8Nzkqas/m
         i/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c5PLhgJu+k846jOX+xtKTb+HjTELTh72nbVQm02eqbY=;
        b=UT466F9pr8FmlYQE5L3KQvzshLK+sWGnv4Cvos94i+pNZmsVe6ZUQTq2a6r7G7NwOT
         lqWFFc6orhRPv1iRF08UELrN7INNxImr0K8+B3gSLHJCTm2WS5uIsbhKd1k4H2zE1LXl
         TDlkZ8K7fE54iaB3ddMcPbe41mH4znPF1/ayKdE3SZW9YZOKL9xJ4pL/hYV57tTc+l2D
         lQMtlOJGSPoNmorGzciddxkuo4zEpFOrykCV0DzeRUddJ/ZuXGpZJ33pFYiEUEaUvHNl
         9HLSXV4bYLymJydtvXTI/AihWmHOvqAoNiSsRAZkW2eQzLDv5/2O7H6Gkdjmx+jYhTCH
         G3Rw==
X-Gm-Message-State: APt69E09IryiuOmxG3iLdpipb/gB4f1mwn9T7eHyzeJ9WmpxUwYtJqZb
        LkuYFaaE5Oyhkm7UtEa4wQs=
X-Google-Smtp-Source: ADUXVKKtUNmeIsm94pZuXX94Bt/14r2k9SdVFEGO7FxPUYzggL5LiGwPrsC82a+rkhH58aE1PvSOfg==
X-Received: by 2002:a65:6210:: with SMTP id d16-v6mr9623341pgv.272.1529302554858;
        Sun, 17 Jun 2018 23:15:54 -0700 (PDT)
Received: from localhost ([110.70.54.122])
        by smtp.gmail.com with ESMTPSA id b72-v6sm26703026pfj.56.2018.06.17.23.15.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Jun 2018 23:15:53 -0700 (PDT)
Date:   Mon, 18 Jun 2018 15:15:50 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Maninder Singh <maninder1.s@samsung.com>
Cc:     pmladek@suse.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        a.sahrawat@samsung.com, pankaj.m@samsung.com, v.narang@samsung.com
Subject: Re: [PATCH v2] printk: make sure to print log on console.
Message-ID: <20180618061550.GA27996@jagdpanzerIV>
References: <CGME20180601090029epcas5p3cc93d4bfbebb3199f0a2684058da7e26@epcas5p3.samsung.com>
 <20180601090029epcas5p3cc93d4bfbebb3199f0a2684058da7e26~z-a_jkmrI2993329933epcas5p3q@epcas5p3.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601090029epcas5p3cc93d4bfbebb3199f0a2684058da7e26~z-a_jkmrI2993329933epcas5p3q@epcas5p3.samsung.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/01/18 14:26), Maninder Singh wrote:
>
> Signed-off-by: Vaneet Narang <v.narang@samsung.com>
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
