Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53FEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7193220643
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnJh5P1p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbfBYOoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 09:44:13 -0500
Received: from mail-qt1-f173.google.com ([209.85.160.173]:37074 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfBYOoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 09:44:12 -0500
Received: by mail-qt1-f173.google.com with SMTP id a48so10725723qtb.4;
        Mon, 25 Feb 2019 06:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c11yyaC9ihy3gAhtbL7RwVvv3zgZ9nuZ15V62KDacC0=;
        b=cnJh5P1pXx9Km93rXnOMjalbBwE4CqnylfZEWxf1jO12U8FX19JE53o6J57y+zuG/s
         H46bFbBMp5lwsY27Q/QNW/y0eCaTQTlAlD9fVQIUjERKadp0lex+ZV57OS+ZyVk39K26
         +Gbxs286SCQaOSjy+MMr8h/6G8RsDSok/xoeQ20GsxZkONpzt9h7rfSxFc/CP6DCFBDV
         ZYt8KwgIJAJAkThtt+Bj35ecKAsY53fm2yglUFTZDKJhDOHgCIhnGFUwLfi1RWNV8FFu
         v37Pi0i9aNCNFoPRXPmrQOyIWlTvdMvISYcCcfxtS4VNiAlaEtlUWTYPLBIdvKK8Ryod
         b4iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c11yyaC9ihy3gAhtbL7RwVvv3zgZ9nuZ15V62KDacC0=;
        b=QT6AaOLheOl+UGSPjYYEtePBt6xE3JWaLM5IZf8gQYAEnkKJPmr3qT+98JOCs//dr/
         Ynye9TrXGDGn+a2kcUZszETFBt6jgMVJ3v+ZYwdpGyIVH0a3xDw08wE/Ln3Oh6oWCjva
         K475bW7Os3MCQ/fFz80vbtWeblxbQTV+XmvTj42WDQQWXIk2JdAboKBb4qF55ausWhVy
         fwp/8ysUSHrfzIOZ0E84zaC6dGuxzkOsF9pp6U9a0n9doaJKQxTsuFPEKGqWIpM0gPJY
         tpL4zE3XPb+k5cjPhbqUyiY2by2cbhNbtlXYzBsgY2efx9A3EZfzhKvIiMd4LDaY1kOF
         Kw7Q==
X-Gm-Message-State: AHQUAubUIxiKh3wZBn05lw9U2myCZZNbUuAtFQklQOzvXUb+vXwh/lV3
        0UGNiGl0umLEQ6VAFuQSG94=
X-Google-Smtp-Source: AHgI3IZ3LcSUs5yND4XgPc68rgyYwFhrL474bUaiMJgQ6WUoCWTz+J7a8jofSBlBjjG91p816r7hkQ==
X-Received: by 2002:ac8:2314:: with SMTP id a20mr4394859qta.127.1551105851158;
        Mon, 25 Feb 2019 06:44:11 -0800 (PST)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id u13sm6866016qtb.2.2019.02.25.06.44.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 06:44:10 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 838E34039C; Mon, 25 Feb 2019 11:44:07 -0300 (-03)
Date:   Mon, 25 Feb 2019 11:44:07 -0300
To:     Tony Jones <tonyj@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH 09/15] perf script python: add Python3 support to
 powerpc-hcalls.py
Message-ID: <20190225144407.GI31136@kernel.org>
References: <20190222230619.17887-1-tonyj@suse.de>
 <20190222230619.17887-10-tonyj@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222230619.17887-10-tonyj@suse.de>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Feb 22, 2019 at 03:06:13PM -0800, Tony Jones escreveu:
> Support both Python2 and Python3 in the powerpc-hcalls.py script

Applied
