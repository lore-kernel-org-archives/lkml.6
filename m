Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E653C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3764F20672
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XhvHjlGK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3764F20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731206AbeKZWDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 17:03:05 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33422 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730635AbeKZWDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 17:03:05 -0500
Received: by mail-wm1-f67.google.com with SMTP id 79so16310703wmo.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 03:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EwtnTGDk73qNySKwRAKgEBn5iXeDODEswSfu5lxXIdQ=;
        b=XhvHjlGK98Q0ltPxen64R6bAaPdMMqLkMhQsLvzdgQzY0lNhoQNIbn1m2c6YTTik/e
         mcIB3xMwt3PUZW8yed+dxhbCYLnHGsGzHQrVAIi9w3rasLFXFjmCR5D2GhNLkso9crhB
         g9V7i2HZuqpDMJ1b6rxKQtU2Oq2kEzlQg/5CY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EwtnTGDk73qNySKwRAKgEBn5iXeDODEswSfu5lxXIdQ=;
        b=i+ErpEqqsqR1f2DEwHNNv+odCNWZ6mCp2fbEsyPVbB+xc25B+JZTbrQ9QvTuMFfbRa
         Hmd8WHAAxc4HhP2GuImYbH6BMIgFP5IPaOQkx6OvaJK3UF5RpDE9kKf/KQW3OoRssYd5
         XaDVkBzYmuffZaM9tnUzuFGAB0mp27s1PpWQgkMzgSWVaMY9ia82FKfBUrbP0+szsvC5
         u4VnvpgwxM3gl2UqwGAPb49emj4YerPIX3WNvh4ClekIUIjYpWJ8QDNFkIxXBHaFUHa/
         xCeht0fRH6bGN+xpKtyMTar5Al+bwzc51gGc2h7Tet8O94eA+iNdmDVomL+hWPms6xiZ
         202Q==
X-Gm-Message-State: AGRZ1gK2NKxV8tfTt+JIlJtatbaaeC61TIeRabDjn+BxvV/biBMTDWT3
        sJP26Pg2jvpoiyPj0z7joSJkPQ==
X-Google-Smtp-Source: AJdET5cWmppAz2xkPjYCClEiXdUHlWfaGH+795pEjaq+tyP85XLkMBPuU3rvhLZQKBMdn3gC9L+q5w==
X-Received: by 2002:a1c:a183:: with SMTP id k125mr22252117wme.25.1543230557059;
        Mon, 26 Nov 2018 03:09:17 -0800 (PST)
Received: from queper01-ThinkPad-T460s ([217.140.96.141])
        by smtp.gmail.com with ESMTPSA id z9sm22858469wrs.63.2018.11.26.03.09.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 03:09:16 -0800 (PST)
Date:   Mon, 26 Nov 2018 11:09:15 +0000
From:   Quentin Perret <quentin.perret@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org,
        Chris Redpath <chris.redpath@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V3 2/2] base/drivers/arch_topology: Default dmips-mhz if
 they are not set in DT
Message-ID: <20181126110915.372tanwevpfcr7zp@queper01-ThinkPad-T460s>
References: <1543221866-19671-1-git-send-email-daniel.lezcano@linaro.org>
 <1543221866-19671-2-git-send-email-daniel.lezcano@linaro.org>
 <20181126095224.i5se3n5lavww4a2n@queper01-ThinkPad-T460s>
 <97f85a4b-efb6-b26f-94d0-cd538c83a03e@linaro.org>
 <20181126101955.pdn76f2ujeb6urxz@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126101955.pdn76f2ujeb6urxz@vireshk-i7>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 Nov 2018 at 15:49:55 (+0530), Viresh Kumar wrote:
> On 26-11-18, 11:08, Daniel Lezcano wrote:
> > On 26/11/2018 10:52, Quentin Perret wrote:
> > > Maybe you want to test 'if (!raw_capacity || cap_parsing_failed)' at the
> > > top of topology_parse_cpu_capacity() ?
> > 
> > I prefer to update the documentation, it makes more sense than adding
> > more cumbersome tests in the current code.
> 
> +1
> 
> Throwing an error and ignoring DT number completely for the capacity
> are good enough in my opinion as well.
> 
> And who cares for the platforms that can't even fill the DT properly :)

Right, I think we all agree the case with a partially filled DT is
broken. I don't actually care too much about the behaviour in this case,
but it needs to be consistent with the doc.

So, as long as you fix the doc, that change is fine by me :-)

Thanks,
Quentin
