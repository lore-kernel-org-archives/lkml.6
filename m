Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F30ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 07:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD93120850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 07:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WoiE7gIC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD93120850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbeGRHwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 03:52:49 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39329 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbeGRHwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 03:52:49 -0400
Received: by mail-pg1-f195.google.com with SMTP id g2-v6so1596820pgs.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 00:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l3A/Xy6R6gzm4XFckEYuI0TFxTzuCr4V/p/HOBczHVE=;
        b=WoiE7gICj2OmJgpxTk2/IQSXBIlRlXw6vj4vgbvOjgxA7FFvjYtg4mPNsKpkSV2SDt
         tIFvy/t0Baxcg+9eVRFKdVPRsz8o3tlf7bP4yTSofdYMUVAlL/06V2VSaW/XjomJlXrG
         OUJLyISQUWW0MDUqqEGWCFkn/VN0tAqCwHw+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l3A/Xy6R6gzm4XFckEYuI0TFxTzuCr4V/p/HOBczHVE=;
        b=jeqeQ3jv2/mxo7y9pPYVqfG799JeCpPkLjDVcTsCT4yeCpp0BcCjrf5JOTS2h14c+U
         CC4Pw+8TDD4cj7gfcYG5YqMMHTv6SkUpwWns1mdZwVWEeCZ4ySdjgi/fbg9oQuJcdSWv
         o1ZPYNp1lCx6txUzfK5RPYm4vX0LzNIltrA4Ohkqu4FyS5HQzGVLocmzEgdBJMsFd6Mv
         zDejfs82g7vHzeKTsovJfMsteaa40me8YAhXj6uV7yQ2cVe7iIOJTXX16Iq+vwo7878g
         T6Cfxxk97F5LtKUxo/57MwlYp7pyQoQz88R5QmZV8nqT55YrvIoWkM+a07OzjlsEDbNK
         /1rw==
X-Gm-Message-State: AOUpUlEMECWlkB7Vw58xoQiJAnm/a6HTXXo9jYOBqK626lf2dEkJsrFu
        bhJxmMqKSKngjshHfMX3DP6slg==
X-Google-Smtp-Source: AAOMgpcO3cTCN07osMZNZeJ0nAx1yPpesb7DhA74rNffe3Kr0/sD3DS9omZ7U7wH7Is94HNpLo6x0Q==
X-Received: by 2002:a63:be4a:: with SMTP id g10-v6mr4609483pgo.378.1531898184546;
        Wed, 18 Jul 2018 00:16:24 -0700 (PDT)
Received: from localhost ([122.171.235.75])
        by smtp.gmail.com with ESMTPSA id j75-v6sm7077293pfj.102.2018.07.18.00.16.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 00:16:23 -0700 (PDT)
Date:   Wed, 18 Jul 2018 12:46:22 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linaro-kernel <linaro-kernel@lists.linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Nishanth Menon <nm@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH V3 11/16] cpufreq: dt: Pass regulator name to the OPP core
Message-ID: <20180718071622.ujb7xm2whryyhu5v@vireshk-i7>
References: <cover.1454992186.git.viresh.kumar@linaro.org>
 <ad55cd1a03e712e2c0c49701e87a37199cb8376e.1454992187.git.viresh.kumar@linaro.org>
 <CAMuHMdXgE3oOVdYFy3kzmOv4FXvjU4rC39gUDUtMNJCdB__2AA@mail.gmail.com>
 <20180718055029.rdo427kozpwqm2bc@vireshk-i7>
 <CAMuHMdU=FNhWh_oroBZb8NkUr_fsvUvYxBHH6=KErqU9_Xi4ZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdU=FNhWh_oroBZb8NkUr_fsvUvYxBHH6=KErqU9_Xi4ZQ@mail.gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-07-18, 09:09, Geert Uytterhoeven wrote:
> IMHO they should be documented somewhere, with a link to
> Documentation/devicetree/bindings/regulator/regulator.txt.
> How else can a DTS writer know he/she needs them?
> Without cpu-supply (and clock!) properties, cpufreq can't work.
> 
> Candidates:
>   - Documentation/devicetree/bindings/cpufreq/cpufreq-dt.txt
>     This has operating points without clocks nor cpu-supply, but with
>     clock-latency (for which clock? ;-)
>   - Documentation/devicetree/bindings/cpufreq/arm_big_little_dt.txt
>     Again, operating points without clocks nor cpu-supply, but with
>     clock-latency.

Sounds reasonable. Will cook patches for that soon. Thanks.

-- 
viresh
