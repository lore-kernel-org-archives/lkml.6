Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199D3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEF9A20643
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xd8BIsx9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfBYOsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 09:48:41 -0500
Received: from mail-qt1-f171.google.com ([209.85.160.171]:42016 "EHLO
        mail-qt1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfBYOsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 09:48:40 -0500
Received: by mail-qt1-f171.google.com with SMTP id u7so1508535qtg.9;
        Mon, 25 Feb 2019 06:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ugoBBgKvmATfV4urbSHWyWz2MlcVsCPThqQ0gojn1mA=;
        b=Xd8BIsx9m0axLjcO/5JFg3foFv/JKI/cZO06M+XlY733ySovRcfESW/aClR2ja7om2
         ZuHNRi+6Xe8ZJ72hK6cV7xLBoWyef7ohLW31D2D+y4Rt6mVrdlIIzj/e5Ytpz/PI1w2C
         X9ZouIN1I89I+BNxr8dKESE26Mquh0La34gWFOitRn1h8Jq71lK8xFft/MLgZou5+s9H
         AgglHcL9cNYJMbKaHDCQpXJyxnBXI4EKOD+3CHBKSg4a/rL9C//2ivTc7CKuu1WSRK10
         o7v443nXMEx5+j4G+uHiaaI0RPxYV469yEU+SHTC7tC7FcgeULBDDnXnofYe0rij4CK+
         rTQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ugoBBgKvmATfV4urbSHWyWz2MlcVsCPThqQ0gojn1mA=;
        b=t+Z6n2zcm/atcGeKIO4ixXrrtbANsz0qv12aOe2RreKwEU3zu2TEjppPkCpSJmdCa9
         lmk4QtT9XZ3SglsL0DJvJyuoOatLf2+/19KQf5tDjZfpQdWmHwqaKqhFzwoL8DogV2hm
         IJBbEXTbsgtuiF4sgJbHSt8R9D5zJPlLezCjhUeoZyRP3R8oTyQl+QlxGuwuoq5OZ93I
         MnDsmjQPBpMIzaPdY1A55PY15X60S9lYq5NlOt2l4B4Q01GdeTg1VrUwYOQdfhcKg1+G
         bN/7utupSFFFmS1qAjryEP9UVPWGsZ4INAMZk4O5tV66wGeYmfus4ixUFRTc1JV0+7lN
         0GCw==
X-Gm-Message-State: AHQUAubo6LcBNLIOGjRAsj3/kGCwMIl50zlhgObklMElhG4Ky5Nv87Xg
        pD97AHBc3qs61ReMlhgu3a8=
X-Google-Smtp-Source: AHgI3IZ9LU5ks2mnLsGbjCqg3DKzQI+qm7PmcC2hdIaVq0O7Ff8r7R3TpZC/OUEQ0+Z5fcm8yFmXqg==
X-Received: by 2002:a0c:9e10:: with SMTP id p16mr6017410qve.176.1551106119637;
        Mon, 25 Feb 2019 06:48:39 -0800 (PST)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id j129sm5061134qkd.18.2019.02.25.06.48.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 06:48:38 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0366C4039C; Mon, 25 Feb 2019 11:48:36 -0300 (-03)
Date:   Mon, 25 Feb 2019 11:48:35 -0300
To:     Tony Jones <tonyj@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Subject: Re: [PATCH 14/15] perf script python: add Python3 support to
 syscall-counts-by-pid.py
Message-ID: <20190225144835.GN31136@kernel.org>
References: <20190222230619.17887-1-tonyj@suse.de>
 <20190222230619.17887-15-tonyj@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222230619.17887-15-tonyj@suse.de>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Feb 22, 2019 at 03:06:18PM -0800, Tony Jones escreveu:
> Support both Python2 and Python3 in the syscall-counts-by-pid.py script

Applied
