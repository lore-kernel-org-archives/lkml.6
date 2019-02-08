Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FCBC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACA88205C9
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549638909;
	bh=+oh4azHrDc1Xhto/NfUIVgGq5qsFwKX/i21egYPfjEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=okBX5IbEm/OrVtLgh54sR7fchX2RcO8gtULvMnRhqVoICPl3+iEXIpEt7dU8E8NrL
	 wkn/4hVr9m/9OPt5m2GQqs0rBoHAwxoOPQ6VwrQxbhbHQC8s/vhlkQ/k3pPl7fpiL3
	 NNYMp8Pu5UbtuHCdm9Tz+c8uVBRmV7TIWZmSolDo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbfBHPPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 10:15:08 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40499 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727470AbfBHPPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 10:15:07 -0500
Received: by mail-lf1-f67.google.com with SMTP id t14so2782588lfk.7;
        Fri, 08 Feb 2019 07:15:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wdbwdA1/UubJRkNQpKhkpwnTYpuoCadoh8QoLjPgSGs=;
        b=p7/ooUDRFMaMXahHLXl0TC90xtgQZGr132q2/OEDM4udezRGMNuA9kJ/XUstFn9WiU
         H2MENIHInXA22Mri8xFlmRJH5nzb3gMGIWPQVTMqkUXTL2ozHHMrfRamETGR5bzjI4TQ
         FnSb0mUmxmbXJCOeE7t+dYWn1lQ0enACRKfkjTwMMnnTvTPHLcrDXJ9I4SxY0WaRvJN7
         U5/Knnf4VQCicsX+x2YUYTNCVjBlPEC6wFXyez5o82EgHmTw7ijRIWsQgKmu7tYYjUOI
         hZASWqtiJUS23PgI7zZF3z5NJkIZjBMMgC1D9Biyb3l4QmbyOyFluODjm5o48Xru1WAb
         ZuEA==
X-Gm-Message-State: AHQUAubI/liEPy/cPXRdtAXZNItymteQVKSAOU3Y8yWuh2FMfDwo8xuO
        zp/vmvZee/ugDDtaBcw1ixo=
X-Google-Smtp-Source: AHgI3IZTwg270jJ2UUxi04WjSgTkQJZks1C76pqk0d8mHIyc3Bz6akqSik0r+ppARaxal46w6bFM1w==
X-Received: by 2002:a19:aa87:: with SMTP id t129mr14414452lfe.139.1549638905382;
        Fri, 08 Feb 2019 07:15:05 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id q21-v6sm422165ljc.5.2019.02.08.07.15.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 07:15:04 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gs7rq-0006wT-Ju; Fri, 08 Feb 2019 16:15:02 +0100
Date:   Fri, 8 Feb 2019 16:15:02 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Johan Hovold <johan@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] ASoC: msm8916-wcd-analog: add missing license
 information
Message-ID: <20190208151502.GP4686@localhost>
References: <20190207165755.1548-1-johan@kernel.org>
 <20190207165755.1548-2-johan@kernel.org>
 <20190208115341.GB6695@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208115341.GB6695@sirena.org.uk>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 11:53:41AM +0000, Mark Brown wrote:
> On Thu, Feb 07, 2019 at 05:57:53PM +0100, Johan Hovold wrote:
> 
> > +++ b/sound/soc/codecs/msm8916-wcd-analog.c
> > @@ -1,3 +1,8 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2016, The Linux Foundation. All rights reserved.
> > + */
> 
> Please use a C++ comment for the whole thing so it looks more consistent
> with the rest of ASoC (and a bit neater in general).

Ah, yes, that makes sense for consistency since you've already enforced
that style. And while I don't think the all-c++-comment headers look
better in general, for the single copyright statement case it's not too
bad.

v2 under way.

Johan
