Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746DDC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 03:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D8E7214D5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 03:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="CbYK9DDC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D8E7214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbeIZJxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 05:53:17 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40326 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbeIZJxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 05:53:17 -0400
Received: by mail-lf1-f67.google.com with SMTP id t22-v6so12170492lfb.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 20:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7tFMaeI7+E55X4pwVOWFAW6asXs0wEAOcc6K4tRzGWQ=;
        b=CbYK9DDCC6yvrnXZgxsTuQ6KgRAESgKEq4UfRcJd1bu0rq2MNvSmzs4kzGuCW0EKY0
         blrALgw3qhhaq0huBGjFHUsPqpvW30i9JWRQdvtK1vhUbcEJSp8BvK3HOFtj9XVbydqb
         GR5+1boOvACPA1FAo/ARNBS7uCZ5N8qGkSo0xoeoKuyQgWG7OpHGHiaxz09v/vbmrC74
         PK698bht5hhuhWRRm0p1LEuzAsZWUoIVSM9/62wSdKK6aQyarML7fu1DDlkO2CwfO+iU
         nqFUjjNZc6x16R/hPuyEaOk+zoHtwzsh4NE3VsG8hfxw65aAqcZg2jy425nS0BY8NqRi
         2I9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7tFMaeI7+E55X4pwVOWFAW6asXs0wEAOcc6K4tRzGWQ=;
        b=RB35XDK5jmXX0TWhdHn35xKb6T0kkplBeYE6H7HTeoHXJaduTnzYK1mE9RiR2qFjsc
         2hTxugTiAvCfnWDfb2dj3aKZ+hgSNZMvzzNYqUE2Tqzq7bSFWcNJH5yPF/qziv52kXQ7
         SFNrA8wFyGftyrMYVI91+h0xQZyYSMHZf2tJ4B+gC4C6dR9wUd+ZFWa2RfSfafkrSAH0
         ABfI6hoJ2CWFFvc1xcw8thYbOV1DxTGgzuZaIXvlBIZ0mDdUMODX+tNn6Ve/A0CApd7v
         /veBr+rjAWljAuvJsLcAq8fu7QlQqDhGuREkR1kf/ZcPey+lBWGQMdGnps1/YLlw9uuU
         TnQw==
X-Gm-Message-State: ABuFfoh2NuqxzqTpSO6IrksJ2NWRhbV1zF1tI6dORecimYYLrVJv1nPk
        VmKFPwOQIdjmzHAmP/TqxVaZ6w==
X-Google-Smtp-Source: ACcGV63NrlbjbSNCMeGLdvwjczCWKMkq6WtUv5Y6Oxrafl0/Ghzzj012Xwno7a9eGMbd8FMr5uvQ4g==
X-Received: by 2002:a19:1709:: with SMTP id n9-v6mr2865400lfi.74.1537933346449;
        Tue, 25 Sep 2018 20:42:26 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.se.alltele.net. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id i28-v6sm751833lfc.87.2018.09.25.20.42.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 20:42:25 -0700 (PDT)
Date:   Tue, 25 Sep 2018 13:48:02 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Patrice CHOTARD <patrice.chotard@st.com>
Cc:     "arnd@arndb.de" <arnd@arndb.de>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "arm@kernel.org" <arm@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] STi DT update for v4.20 round 1
Message-ID: <20180925204802.slqzlekvjm5j3fiv@localhost>
References: <7250e85d-374a-76e7-fa8a-4911ef7a12ae@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7250e85d-374a-76e7-fa8a-4911ef7a12ae@st.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 04:21:26PM +0000, Patrice CHOTARD wrote:
> Hi Arnd, Kevin, Olof
> 
> PLease consider this first round of STi dts update for v4.20
> 
> The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
> 
>   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pchotard/sti.git
> tags/sti-dt-for-v4.20-round1
> 
> for you to fetch changes up to b5b4c8dd5c44edc112a362f87a8d8953336571bd:
> 
>   ARM: dts: stih410: change syntax of multiple DAI (2018-09-25 17:41:51
> +0200)
> 
> ----------------------------------------------------------------
> STi DT update:
>  _ Change syntax of multiple DAI links

Merged, thanks.


-Olof
