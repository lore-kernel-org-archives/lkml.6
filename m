Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACEDECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 01:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 149D4214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 01:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BwvwgqAk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 149D4214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbeIQGda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 02:33:30 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54069 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbeIQGda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 02:33:30 -0400
Received: by mail-wm1-f68.google.com with SMTP id b19-v6so7575508wme.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Sep 2018 18:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jEA8p2ODr5vZTLdy7z0aioz5O7MehEnESxH51ivCxxg=;
        b=BwvwgqAkgSnxmvqgDdgn6eX/iq0LY85pkJ92AOGd2SrhmqZU01J9Qy2e+kEJQsi5s4
         rhcDHFX0vlyLnYOb6SrMdPAqhcwuguLv1i6LSm858SdtSyORYh84uR2NTFNM2VQcqAld
         DdcAdAsPUmIIIzaW+wnwoQYUKt7nUnQc1y6LM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jEA8p2ODr5vZTLdy7z0aioz5O7MehEnESxH51ivCxxg=;
        b=Fr89snsUIXep9NQEYmaYc7tRdcGITCBlM1BtCJ3LkmwI3RlbBs2UvjFu1OVPEljfHn
         WxTJNhehJVRMxeZ6Hno/+SSmEzg7DbDdH4uGzsX1NbolVhsK0pckvwA8ZY+HUX4krxMw
         YCxPOXmAS6zwQP0b9tIaMdVjVdgFGv9TsrCmut1ggawpfPnacl2tQSlX6hi8cnUyRXqk
         5Ay6IIgV7JTy45rwJNx02ygheP7Cw/VLjnGN5BkrtxGd3gkzH5XgdHLDiz+ASWm+XUnW
         dG6XvM+hrC8rNLMdvVa9L6tCJOLgLiz0pdeRhsYqhVaTswagZMWk6aiQIHwE8geUIMhC
         6jDA==
X-Gm-Message-State: APzg51BEUDjbsH30zgvP7cuBqxpuNE+GJfqyNP4tK7r0Oq8ROBF+78Vp
        Yc6ne/5hQ92v8QqAKeg31XD6yA==
X-Google-Smtp-Source: ANB0Vdbj5Clvref89tWVZV50LML1yKymqq9eJ3v+X593saudAqvwtLHTMPEWs9TvYl+K/oHCXwu75A==
X-Received: by 2002:a1c:c3c6:: with SMTP id t189-v6mr8565376wmf.59.1537146513494;
        Sun, 16 Sep 2018 18:08:33 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id z21-v6sm4567546wmi.29.2018.09.16.18.08.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 16 Sep 2018 18:08:32 -0700 (PDT)
Date:   Mon, 17 Sep 2018 02:08:20 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     robh+dt@kernel.org, broonie@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, bgoswami@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH v3 02/13] mfd: wcd9335: add support to wcd9335 core
Message-ID: <20180917010820.GB3900@dell>
References: <20180904102500.30318-1-srinivas.kandagatla@linaro.org>
 <20180904102500.30318-3-srinivas.kandagatla@linaro.org>
 <20180911153340.GY4185@dell>
 <94c68436-b618-40fc-46d6-165799312289@linaro.org>
 <20180912085848.GP4185@dell>
 <b4ddfd10-360c-a844-8542-1f81a1cc9c6b@linaro.org>
 <20180912105941.GS4185@dell>
 <11f213e5-8c93-f75f-1b74-517f00cd9a96@linaro.org>
 <20180912114633.GU4185@dell>
 <ffcf1b3a-b66c-6e0e-3e7a-da092e9d1894@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ffcf1b3a-b66c-6e0e-3e7a-da092e9d1894@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Sep 2018, Srinivas Kandagatla wrote:

> 
> > > 
> > > There are two parts for device to be ready to talk at bus level:
> > > 1> power up and reset,
> > > 2> enumerate and assign a logical address by the slimbus controller.
> > > 
> > > First part as you said is already done in probe.
> > > When second part happens when status callback is invoked, that is when the
> > > slimdevice is ready for any kind of communication at bus level.
> > 
> > I see.  I still think it's hacky to conduct start-up procedures when
> > all the SS requested was status.  Perhaps it needs a new API call
> > init()?
> 
> When we added these callbacks the purpose of this was to allow drivers to do
> specific setup/teardown.
> 
> AFIAU,

What does that mean?

> even-though if we add init(), SLIMbus would still call it just before
> or after status which to me is redundant ATM.
> Its up to slim driver what it exactly whats to do with status, in some cases
> this can involve setting up the device.

If you say so! ;)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
