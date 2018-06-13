Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 628D9C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 07:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18C91208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 07:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GPNQa4U1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18C91208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754533AbeFMHWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 03:22:30 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:45249 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754510AbeFMHW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 03:22:28 -0400
Received: by mail-wr0-f194.google.com with SMTP id o12-v6so1521690wrm.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 00:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9dkFgFqvODD0uJIjrCRbRvFwWdb3FI4gdFBJB5tOKcM=;
        b=GPNQa4U1/MPWwkL5X9Cke/nNlgN9VaGkRneaok7fN7D3amWiRENF+WFYcBQO9EBl0K
         BqpkMyiyyfKqCJATT+HryAPoECJhXmbeFwuG9ABf9l8UfMSuEqm5z96yHZuP2AAvq0qo
         6tVG9/WD7eS+030Fj6axOIq1RQJTvCJn+OqOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9dkFgFqvODD0uJIjrCRbRvFwWdb3FI4gdFBJB5tOKcM=;
        b=jC7tbDFKjIr7IutDNg6RsCPuosHROlGZwTNVVQQeqOFRFCkv2Q5WTRIZPAaVIjumGk
         52ZmQ5BW6HnmNcQmGZCUCCzd0K0YtymtdAyPMIpyfyv5vwnJw1s5Hsz5YMvVm54BEy31
         owdDlXSeTAjiBWKG5xwetiBR8XpK7k8Mr9dmof0LRfn280kURXdf/AkVFHK5j/KEn6Hy
         oEiWnFnyoUiK/edfzTUzhdZgOz+eNJxaUSYhICnQf6t0FuhoWIv6uioMwjx9ZEd+8zn5
         p4b7Y0ChsMZ3457Tbnw2jiG8vBno6RvZnuzXz0gbco4NLrne6H6+rBiCITaqKlCvmr1g
         baQg==
X-Gm-Message-State: APt69E3lpN4qB2nXdigiayCuJO6FQJmgAebys2dbJofa80g89ZAPcBb8
        rMLz8vC0dyOZs1+Yo8Q58Et4Mg==
X-Google-Smtp-Source: ADUXVKKY5NOQgAK0/wd+69Mw+5vgV+VazN9uL42iVD8+F873LSr6CIRL+/e0rIsjn8KRAPzUtC5Klg==
X-Received: by 2002:adf:a6b8:: with SMTP id t53-v6mr3334744wrc.45.1528874546706;
        Wed, 13 Jun 2018 00:22:26 -0700 (PDT)
Received: from localhost (LPuteaux-656-1-48-212.w82-127.abo.wanadoo.fr. [82.127.83.212])
        by smtp.gmail.com with ESMTPSA id r9-v6sm1476480wrs.63.2018.06.13.00.22.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 00:22:26 -0700 (PDT)
Date:   Wed, 13 Jun 2018 09:22:24 +0200
From:   Andy Gross <andy.gross@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        david.brown@linaro.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: apq8096-db820c: disable uart0 by default
Message-ID: <20180613072224.GA4034@hector.bewan>
References: <20180612144806.19201-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612144806.19201-1-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 03:48:06PM +0100, Srinivas Kandagatla wrote:
> Access to UART0 is disabled by bootloaders. By leaving it enabled by
> default would reboot the board.
> Disable this for now, this would alteast give a board which boots.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Thanks for this patch.  I'll queue it up for a fixes-for-rc1


Andy
