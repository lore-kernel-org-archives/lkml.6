Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDE5C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D536825CA6
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:33:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D536825CA6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752380AbeFYPdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:33:47 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:44443 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751958AbeFYPdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:33:44 -0400
Received: by mail-yw0-f194.google.com with SMTP id k18-v6so4897450ywm.11;
        Mon, 25 Jun 2018 08:33:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hjs9S2ETlu16lhgJ28UR2qaWu0DKscST58Xf4BC4f60=;
        b=msCcQiiit3bz14i7FnGU6+vP4rHLXNUTe8B7ut0Q/7yzgIhTIlnJwm4zwDqF8NOb5E
         /RZW1NyhLKVbRiWQDFqxb96/wcSj/hLY3s/V8UnFmJFnZxLxsi+M6s6rO7mIkBZrRw10
         pYng1zWxviLJ0WYxDyZNsjT7umqsa1eeF6xWno3Nfcj8srki8sYS2Fx29n/TqwY4iCWb
         OmN+CnKzx1fMKnuXJ9M7OSMGiRuPHFnJCoSbhAtLlgdeV2wd9TPfjYmIGexG49nGB95Y
         lRRoKsSv0Mqny8gl/l1oajiPwXQ8qgCKvbGkrpkaCEtUFQ4YqmpEAILXV0dJ5zrEdWKZ
         cPeg==
X-Gm-Message-State: APt69E2mzum6f+SF54NankHek9JUzRZttpcjm5YipsitPQf39W/HCM1D
        zqhq0fk8w9FdUXn6w2nn/1jnRNY=
X-Google-Smtp-Source: ADUXVKIUsrkmbedHI1/rayGYB3ZbYLqrdUDTsC5W4FDxybxfgytvMl3det3wQJGpVB4tfRTOMwbeZg==
X-Received: by 2002:a0d:c8c1:: with SMTP id k184-v6mr5909138ywd.177.1529940823743;
        Mon, 25 Jun 2018 08:33:43 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id n204-v6sm5427636ywb.72.2018.06.25.08.33.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 08:33:42 -0700 (PDT)
Date:   Mon, 25 Jun 2018 09:33:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v4 09/12] dt-bindings: PM / OPP: add opp-throttlers
 property
Message-ID: <20180625153341.GB23270@rob-hp-laptop>
References: <20180621015237.100100-1-mka@chromium.org>
 <20180621015237.100100-10-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621015237.100100-10-mka@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 06:52:34PM -0700, Matthias Kaehlcke wrote:
> The optional opp-throttlers property is used to configure the throttlers
> (see drivers/misc/throttler/*) that use a given OPP to throttle the
> corresponding device(s).
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Brian Norris <briannorris@chromium.org>
> ---
> Changes in v4:
> - added 'Reviewed-by: Brian Norris <briannorris@chromium.org>' tag
> 
> Changes in v3:
> - none
> 
> Changes in v2:
> - patch added to series
> ---
>  Documentation/devicetree/bindings/opp/opp.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
> index c396c4c0af92..747e79740c75 100644
> --- a/Documentation/devicetree/bindings/opp/opp.txt
> +++ b/Documentation/devicetree/bindings/opp/opp.txt
> @@ -170,6 +170,9 @@ Optional properties:
>    functioning of the current device at the current OPP (where this property is
>    present).
>  
> +- opp-throttlers: Array with phandles of throttlers that use this OPP to
> +  throttle the corresponding device(s).
> +

I think it would be better to make this a boolean for each OPP entry and 
then add "operating-points-v2" property to the EC node to point to the 
OPP table. Unless there is some need for a different throttler for each 
OPP entry?

Rob
