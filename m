Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF9BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CC7A20855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VzCCAx3D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbfAQGzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 01:55:16 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39830 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727601AbfAQGzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 01:55:16 -0500
Received: by mail-pl1-f193.google.com with SMTP id 101so4275743pld.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 22:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4aXtZT6Ye8b+elrJxqIkiwN6z0WaU7g2S4YpAZ4q8Og=;
        b=VzCCAx3DfqHSBg0hq5xzdm2Frpa63SjJAJuK6gWpChapj9b7TeJKFk+so9WzVASNwO
         /iIIyplGr/Ltk+2LhKseG2LZjgKZWrNYcqLfTvP4CsclUsit1dVP6IYQYrmNAvLKfL7i
         89oI2o/ZWcKohm34ZAx8T3C44CyPY99lQu+/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4aXtZT6Ye8b+elrJxqIkiwN6z0WaU7g2S4YpAZ4q8Og=;
        b=H/YEBn29aTHEsutCG5vQDAxO66GiRtRCwVvbm2GvBGkGpb4Vm3iyptbdVIouwatUPp
         UOH7vWvYZsXniXpz7lLyUG9a+2r0yhClIdm2cArW8mdlQPjWDABPXI4eEJdc1crJCGI6
         9W0R7TA3BqSH8NWEoixMjoxLLt9hV4AzqA9prgofMQ8uKRvI/msZQOfwB7zPRBwLZI2G
         n4R9n7ROKHUGI5aFxZumD8VMP16CsQcD4PQatoVmtgiRY+1wx2RWb96pr5rFacVtkeyi
         FpnyIk3S+f4xB3IVU00Reyvvq6E7DKKpy/TxfHZZlnarC3msAqLz8lYJfE4YbPuGfL6z
         nZqQ==
X-Gm-Message-State: AJcUukf5lccUQ2TInG/uQvr9bPRdtJ5V+7rT3V7J/Z9ih+C6gDulgiCf
        xtVtUl4CGbLyFBHQf77Fsp29Nw==
X-Google-Smtp-Source: ALg8bN4y267hnZ+7a0iGGnLcJfIWLnk+j3eAXUsOepG5lkFjqXUXXV8LD0W0yBAfVZgxvpe9rAH8JQ==
X-Received: by 2002:a17:902:a5c3:: with SMTP id t3mr13609005plq.117.1547708115340;
        Wed, 16 Jan 2019 22:55:15 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id x19sm1656495pfk.14.2019.01.16.22.55.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 22:55:14 -0800 (PST)
Date:   Wed, 16 Jan 2019 22:54:34 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        andy.gross@linaro.org, david.brown@linaro.org,
        jassisinghbrar@gmail.com, mark.rutland@arm.com,
        mturquette@baylibre.com, robh+dt@kernel.org, will.deacon@arm.com,
        vkoul@kernel.org, sibis@codeaurora.org, georgi.djakov@linaro.org,
        arnd@arndb.de, horms+renesas@verge.net.au, heiko@sntech.de,
        enric.balletbo@collabora.com, jagan@amarulasolutions.com,
        olof@lixom.net, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 05/13] clk: qcom: apcs-msm8916: get parent clock names
 from DT
Message-ID: <20190117065434.GL25498@builder>
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1545039990-19984-6-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <154508986359.19322.1555129141976726505@swboyd.mtv.corp.google.com>
 <20181218143503.GA32562@centauri.ideon.se>
 <72bc192f-b60a-1209-7818-78a2fed07831@linaro.org>
 <154603613437.179992.1170701312259011363@swboyd.mtv.corp.google.com>
 <45a9e033-16e8-e0f9-36cf-3b892af1bd8f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45a9e033-16e8-e0f9-36cf-3b892af1bd8f@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 31 Dec 00:42 PST 2018, Jorge Ramirez wrote:

[..]
> I am not completely sure of what you mean. are you saying that the original
> patch is good and we should just provide another patch (not part of the
> current patch series) to remove the compatibility?
> 

You're expected to make sure that db410c continues to function on
existing DTBs, at least for a considerable amount of time.

Regards,
Bjorn
