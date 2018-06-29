Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6ED6C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7229E27EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtmGEOZ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7229E27EA1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936264AbeF2Lqz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 07:46:55 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41696 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936196AbeF2Lqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 07:46:53 -0400
Received: by mail-lj1-f193.google.com with SMTP id a17-v6so3964960ljd.8;
        Fri, 29 Jun 2018 04:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wiYC1svQLiRI/HD1hn5iiyNoxS7cgoGUQX+dWtvPeQg=;
        b=YtmGEOZ0PqXhmGnVA96EezkgVySr6EjAS1lXjDm21klrBmcLEK02dy6X8yI/R1drTm
         yTzJMq9BybNfiIV4DBa/Gk8HVctXr46KO7FKMnDVDOmCr4QNvcq4/KED4E3WzA5lL6jm
         15zh+tegV3Z9VLpsCR/CLnqLLguC4UupI/WZyNItOXSFjqzQZe4AcbLJsjaqpXHnPb0F
         7ay3KUhbJ37JnRKIbFVv2/W9z8FVdUzwI0ZQ5P0chz84q+pvGYDLnWJW4s7IjuraXW6v
         gRB9D3ajuEw5B5DSXhKmSGp+PD9k7ZTQ7RPBVVYCnyFtCrxxe7qWz2HaLBu6YAqwy25l
         cLTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=wiYC1svQLiRI/HD1hn5iiyNoxS7cgoGUQX+dWtvPeQg=;
        b=X8x7BBr91saH9D6l5ylC9A3EVXs1bQ3iNO4FNlZANJO84uh1/l4c9m08qJTcBVsd0D
         RunjCBDu999GwgsNfb6ZfktHtc50+S0A/AcMIEnS963E4PHVhCkxa72vzA++yEiZbI73
         SjEeFHyc5vyUKIJJg8Mkx7mBqfxeVpHLMeZpwW6YAGABvZSODC7spxgZM630URlmmdN+
         xY++6Knw2nnceQ1jwQs+0DZIncJiRIz0UaK7uzhC/H7df/xoZf/SV8T0y8PsyntWk+6p
         BwPqP+BVOPe5YMBTQ1+gp1mUOIM6seEbfSgkTRPct+oIzmuLU4aS0rbjnfPStJhbnMc4
         R3Aw==
X-Gm-Message-State: APt69E0GZ3zRSuyiFN1mBmqpe+BIV/xv+LD4oMDuk5w4TZIMSDGP7wAL
        9tpjbL++jdWHmyPy7ur65GI=
X-Google-Smtp-Source: AAOMgpdbRYfZRwJw1AHQ2Yy/GnFOZSUPVWGnhEQpzYZWKhkpyKQcxoOIG0g7E3N3xmky5yCAskKdxA==
X-Received: by 2002:a2e:8654:: with SMTP id i20-v6mr9794014ljj.43.1530272812100;
        Fri, 29 Jun 2018 04:46:52 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id x17-v6sm1175034ljx.13.2018.06.29.04.46.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jun 2018 04:46:51 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1fYrrS-0002XW-Fj; Fri, 29 Jun 2018 13:46:47 +0200
Date:   Fri, 29 Jun 2018 13:46:46 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        alan@linux.intel.com, Johan Hovold <johan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Arnd Bergmann <arnd@arndb.de>,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 0/8] gnss: add new GNSS subsystem
Message-ID: <20180629114646.GU629@localhost>
References: <20180601082259.17563-1-johan@kernel.org>
 <20180628120103.GA28131@kroah.com>
 <20180629094607.GC31718@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180629094607.GC31718@amd>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 11:46:07AM +0200, Pavel Machek wrote:
> 
> > > Finally, note that documentation (including kerneldoc) remains to be
> > > written, but hopefully this will not hinder review given that the
> > > current interfaces are fairly self-describing.
> > 
> > This all looks great.  Thanks for doing this work and adding a new
> > subsystem for something that has been asked for for many years.
> > 
> > All now merged in my tree, nice job!
> 
> I don't think discussion was finished on this one.
> 
> In particular, we agreed that /dev/gnssrawX would be better device
> name, so that we still have place where to put proper abstraction
> layer in future.

I did not agree with you on that. I said we could consider that name if
this was to be changed at all, which I do not think is necessary for
the reasons spelled out in this thread.

Johan
