Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDB6C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3699120866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hp/j8ZDy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3699120866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbeJPXGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 19:06:48 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41092 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbeJPXGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 19:06:48 -0400
Received: by mail-pl1-f196.google.com with SMTP id q17-v6so11178520plr.8;
        Tue, 16 Oct 2018 08:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i1Tb8RO8kUCJ7AjqU4T7Xbd9xcXPAfNQUWNldVZMZrw=;
        b=hp/j8ZDyhctQgniwoK5ychRuABUQX+1nrnNDKwkLI/LUqE2Cu4FStJNbPhWUR2LkXU
         QjPF2PQrBxvmmcEQnV/LVMgU2W1aZQr1fesc1VUeKCKdvJJkGwuZWIUbVkv6KqqfU++M
         Qt4dH6XvnNlfr2DrByAuxprrZQ8jfyYG4JZylBmlkZjphXR5w7/02TDqJlpkf0gqtBIW
         +v+yx8EXW7HmyD+U99NcnfPpR1TceXnPZ9DdKDGNQT3oZ5NQE6diT3c6P/ofVxqmDsUv
         vp5SH8pWzIKWYVSbM2joGgvcA0UO8gm6jPYGLvwOBbTWziXxx9/RbxDtKsbv69jvP0J0
         1tEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i1Tb8RO8kUCJ7AjqU4T7Xbd9xcXPAfNQUWNldVZMZrw=;
        b=q8m6gsaI5OSTeahEW0p1EFqir882NeAxU6WbnW7aCRHuHdRyiKcqX8RPC1fFrJ2Hms
         vn/U4/sy9nE8Ke3Xs9G27noz07j18sEGVOb/m403NU/Mu7i9vWOVQfPh4oYI7BF0Xxf2
         7HUWMKoXyT5CYTMwioFYxWxoylDKDZ1KsiMqxwYG3qPFUb4nGW86z80r+kwo9KWGxmK4
         DcxsKDMrcocm/OOmWlNZUQBVLyHlSJgqSy3Sjf3YLnNxhyIYr2KVoylBpid2y2hxGLb/
         a1VyZqPMV/L9UFjpaDrPY5jvvaBNDQdGGfoMgfTJTDPHfVtt7nHEhEfRJyItxHMG+zx1
         99dA==
X-Gm-Message-State: ABuFfohfSZ9zI/lCN1MHIhV3S44CNnSy91tq3fEfxPV5FTKneO1XmMnN
        w9NE8nS9I9F6F+IZrtfNdzs=
X-Google-Smtp-Source: ACcGV60Tt8CuOqjFdAYBGMmZ6rzlZIQaRoTtxIw5n0NAgBLT2XEI3fIS89Iw/nxOKCHcFM8MZDxG/w==
X-Received: by 2002:a17:902:8e8b:: with SMTP id bg11-v6mr21626318plb.219.1539702952897;
        Tue, 16 Oct 2018 08:15:52 -0700 (PDT)
Received: from localhost (c-24-4-232-171.hsd1.ca.comcast.net. [24.4.232.171])
        by smtp.gmail.com with ESMTPSA id e64-v6sm18577236pfe.55.2018.10.16.08.15.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 08:15:51 -0700 (PDT)
Date:   Tue, 16 Oct 2018 08:15:49 -0700
From:   Richard Cochran <richardcochran@gmail.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ptp: fix Spectre v1 vulnerability
Message-ID: <20181016151549.4ynsmoubmp3ywcf6@localhost>
References: <20181016130641.GA603@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016130641.GA603@embeddedor.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 03:06:41PM +0200, Gustavo A. R. Silva wrote:
> pin_index can be indirectly controlled by user-space, hence leading
> to a potential exploitation of the Spectre variant 1 vulnerability.
> 
> This issue was detected with the help of Smatch:
> 
> drivers/ptp/ptp_chardev.c:253 ptp_ioctl() warn: potential spectre issue
> 'ops->pin_config' [r] (local cap)
> 
> Fix this by sanitizing pin_index before using it to index
> ops->pin_config, and before passing it as an argument to
> function ptp_set_pinfunc(), in which it is used to index
> info->pin_config.

Acked-by: Richard Cochran <richardcochran@gmail.com>
