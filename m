Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 0K+BACNeGVsgLwAAmS7hNA
	; Thu, 07 Jun 2018 16:33:49 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 51A68607E7; Thu,  7 Jun 2018 16:33:49 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="oGQ5A675"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_MED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id AD318601D2;
	Thu,  7 Jun 2018 16:33:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AD318601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753932AbeFGQdr (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:33:47 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:36959 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753909AbeFGQdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 12:33:45 -0400
Received: by mail-pg0-f41.google.com with SMTP id r21-v6so4674542pgv.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 09:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=wWEPR9Sa9GTfTcdZvvpj0JHTiL37HlRwKc/VZW+efj0=;
        b=oGQ5A675lUOoXJoWAl0kPBa/gzb58NU5zr8R7c6I3urWpo7IqU5+Uw4EH/IZcm5ZFz
         7LyCj8hUK85yDBnf6Lk/hh9O9bxp4U/1OXTHz3hJA47rnZb2euMPeKjhySHhhdKOeupk
         jdIbaN2wUi01OTT1pexm9MNGtIzqS+xbPYfWTTImtgmbPqB+NngG+6INvyxMlFlCBzKF
         lYJtmLCbeGqjNmX9YwTDGEa++tkkiYdahpvj68M0cOUYaoS48u7jQdjJD+P5FnnGGslJ
         3+vMxd8ekfZwsDoyH1tyq2tzpvY/Cf9ms0sg52zqQalqK8rEhPWYJslxHIPcQ1A83wrM
         +fQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=wWEPR9Sa9GTfTcdZvvpj0JHTiL37HlRwKc/VZW+efj0=;
        b=omxM89SVu1XeacX+e4ulXzGkHT0XUgaLr/VRBHlk9Q/zQbRxic2nFssk0ZNsZxv15I
         vS7iKZ4mltLVrgRfAu8RLXOM2mwEVoxcfHuPhP3nn15zjU0vTtij6Fi47mvx6SJ4HuZH
         oxd1EUVNSUs4QiIUtLrQCmOzMDvYS45VbVA9Gy6cMpJtPUmE3QVVQJMCjfSGvI+oeRn8
         HAa2EWCbRihBBb9xiWcmtNJo8WuP8A7x85DaA5cu1uUchY9SQ6kAmudu/Me1/Hq+f/53
         kpct6lrpGjw8GGDRgbJ7oeWKO/Pah1DiaBBM4mTjJbocla/FUbno0DxTynconrCmDJnO
         gNSg==
X-Gm-Message-State: APt69E1vUqIo9INlbBqidCgYLvCnLryYLxzSrT72UsVsPqWcgYhSSEqZ
        yNxCTAG8DDwVxW4rSQ7HeKl9mA==
X-Google-Smtp-Source: ADUXVKKYG38WuROhBCj1LL2w6NjyNLghLITZ1lWTX1EDoBnys+z6Pl3+MZnijJK15LYxt7hLFgSO2Q==
X-Received: by 2002:a63:2ac4:: with SMTP id q187-v6mr2218997pgq.333.1528389224689;
        Thu, 07 Jun 2018 09:33:44 -0700 (PDT)
Received: from cakuba.netronome.com ([75.53.12.129])
        by smtp.gmail.com with ESMTPSA id 131-v6sm97398685pfa.128.2018.06.07.09.33.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Jun 2018 09:33:44 -0700 (PDT)
Date: Thu, 7 Jun 2018 09:33:40 -0700
From: Jakub Kicinski <jakub.kicinski@netronome.com>
To: Kees Cook <keescook@chromium.org>
Cc: Quentin Monnet <quentin.monnet@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: nfp: bpf: perf event output helpers support
Message-ID: <20180607093340.1742a5d1@cakuba.netronome.com>
In-Reply-To: <CAGXu5jJq774LZY1xUCKxG3Z4MkJ_JBJP7veB5gUCy4meb_PtSA@mail.gmail.com>
References: <CAGXu5jJq774LZY1xUCKxG3Z4MkJ_JBJP7veB5gUCy4meb_PtSA@mail.gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jun 2018 22:15:04 -0700, Kees Cook wrote:
> > +       rcu_read_lock();
> > +       if (!rhashtable_lookup_fast(&bpf->maps_neutral, &map,
> > +                                   nfp_bpf_maps_neutral_params)) {
> > +               rcu_read_unlock();
> > +               pr_warn("perf event: dest map pointer %px not recognized, dropping event\n",
> > +                       map);  
> 
> Please don't use %px on kernel pointers unless you absolutely have
> to[1]. It seems like this value wouldn't be actionable here, so likely
> it's best to just remove its use entirely.

We're using kernel pointer as an opaque handle when communicating with
the device.  We need the actual value to correlate things.  Maybe I used
the %px slightly out of spite there, because I forgot %p is now useless
and wasted half an hour on debugging an endian issue :S

This message can only really trigger when root loads a specific BPF map
onto the device and FW is buggy.  Can I fix it in -next?  I'm making
changes to this part of the code anyway.
