Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC168C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 613E82081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WOq7/LNK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 613E82081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbeLKJZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 04:25:55 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46041 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbeLKJZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 04:25:54 -0500
Received: by mail-pg1-f194.google.com with SMTP id y4so6352411pgc.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 01:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8tdgDo/HXIx0+xDqmYYm8THjkQtHccWwlqCwVYW+NFM=;
        b=WOq7/LNK0L8ZgrBYnhUboQOH3ulg0gfBQ2JD5Jj+WDf6jVPH2Wrn3rCjrdIMtscoQn
         fTXS5oI/OEeGNZDtKn/5yhtNrnVsWsHV98Vss7paO0GQIroNJy/XForOExHmoHxY0W2G
         ytVDQ6/xncKVTNEtibbWFhb6zfT1BTyena6k8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8tdgDo/HXIx0+xDqmYYm8THjkQtHccWwlqCwVYW+NFM=;
        b=nIm5wvD2Siwkx2FRm0qacZgBxdPnIMsdmBN1SgFLXJjKzZMqF3iokRNm6AnNeNBzwL
         mN2L2qOmdbI8Spcb7vw+kmZgt5LWZI7LdVtGG8OGrl/telcE+oBIazxIE1ySZsxawons
         CWog4l7B6f9CtC0paR4b5yHsUcMwXMFXEMpREEQrpez98JPacptUHdjTnInwCKYCq/iB
         fOQsDbvQzfrnfjVrrgiSrkjWoTZUkaoMdVMscpyTD8b1zTbbMeNfM0ecP//E8Sh/DBpS
         FMDQ9EUa3MBlbBAQsTjRuoQ0ExWD81WU5/vb/JWdO8SfjzBoZpb+iUS6X7Sj3Bp6fNBQ
         zyeg==
X-Gm-Message-State: AA+aEWZ3xj4urLyCPRS1OVfnqV2TU6ixAUT55oN1OxWWzOWp21kW0npU
        QmYh7LPjXsf8w4L2P/CGQbJKqQ==
X-Google-Smtp-Source: AFSGD/VtsoC4MZ3cpTh5KBSb7nGeM3vLA8pSpM6tvfBxtz91JrdDIT3TsJFX0obhg0O1n5INBFUX3A==
X-Received: by 2002:a63:e516:: with SMTP id r22mr14217318pgh.256.1544520352508;
        Tue, 11 Dec 2018 01:25:52 -0800 (PST)
Received: from localhost ([122.172.23.29])
        by smtp.gmail.com with ESMTPSA id v184sm19188877pfb.182.2018.12.11.01.25.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 01:25:51 -0800 (PST)
Date:   Tue, 11 Dec 2018 14:55:49 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] PM / OPP: Always expose one supply in debugfs
Message-ID: <20181211092549.2ydogec7bnlfokwy@vireshk-i7>
References: <20181210113247.11412-1-quentin.perret@arm.com>
 <20181210115410.clyrxhp5plptrf5n@queper01-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210115410.clyrxhp5plptrf5n@queper01-lin>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-12-18, 11:54, Quentin Perret wrote:
> On Monday 10 Dec 2018 at 11:32:47 (+0000), Quentin Perret wrote:
> > On some platforms, the opp_table->regulator_count field is kept at zero
> > even though opp->supplies is always allocated. However, the loop used to
> > display the supplies in the debugfs doesn't deal correctly with this,
> > which results in the supplies not being displayed in debugfs on those
> > platforms.
> > 
> > Fix this by making sure to always display at least once supply in
> > debugfs.
> > 
> > Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> > 
> > ---
> > 
> > This has been observed on Juno r2 which uses SCPI and Hikey960 which
> > uses DT. I am not particularly familiar with that part of the code, so
> > I'm not sure if this is even remotely correct (hence the RFC tag).
> > 
> > I first thought setting opp_table->regulator_count to 1 would be the
> > right fix but that causes other issues. This fix seems to work OK on
> > Juno and Hikey960, at least.
> > 
> > Feedback is welcome :-)
> 
> Hmm, so I just figured what I'm doing here is basically reverting:
> 
>     1fae788ed640 ("PM / OPP: Don't create debugfs "supply-0" directory unnecessarily")
> 
> Should I send a proper revert instead of this patch ? It _is_ handy to
> read voltage numbers when available.

First of all I am really happy that someone apart from me is using this debug
interface :)

At least that patch was correct and if we have to fix something, it should be
fixed somewhere else.

I tried to reproduce the issue on hikey and straight away understood why it is
behaving that way. There is no "cpu-supply" property defined for the CPUs.

I looked at juno driver and couldn't see any references to voltage there. Are
you trying to add that support ?

Anyway, this should still be fixed irrespective of the "cpu-supply" property.
The other fix you mentioned about setting opp_table->regulator_count to 1 is
actually the right thing to do but the fix may require changes at multiple
places. I can help writing a patch for that if you want, else I am open to you
giving it a shot :)

Thanks.

-- 
viresh
