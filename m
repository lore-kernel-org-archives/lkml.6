Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92040ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C13F2084A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:52:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C13F2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731912AbeGTOkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 10:40:41 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:55125 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727693AbeGTOkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 10:40:40 -0400
Received: by mail-it0-f67.google.com with SMTP id s7-v6so14744574itb.4;
        Fri, 20 Jul 2018 06:52:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bZS4uUH3QWwdLuGznzXQqUroeIW9K0JLURQSoZn8tKc=;
        b=j9b6aOFavldevh+ClXQfgukSUPyTiw2E/Wkf09AvQ6zO9zyrwyRLZ59S3zwtKLfEBe
         ddBrvjwjl34/BUti2roafHx4668yvVVUINFzpHhFbzi/M5bV9/r91qTtdBnauaXYIEMc
         uaj0uCjKuB8q1T+ZkaWcV4jJUJAUZyI3iSzfIPN8vK62aCM4dazEnjilxXOupvRm5FTh
         Odbt+i5zzyUWxaWhd8EA6x+U42k8UeWucEj0yOtzi7UKdq4JcFrt6iiKCUhzyW+3dhol
         HkNCIogn8zsNM+JH0+kXCSBUF/8FdJcA/QYAkRqK+fj/+VZIXmEpgP+qYXC8YBPOxfNt
         jutA==
X-Gm-Message-State: AOUpUlGIH6hL264oIc4YySlfv684eSLC3lLhddNFMOITMfE+suv9SAW1
        ovawyOC6G/BNJdIq4ALITQ+KvEE=
X-Google-Smtp-Source: AAOMgpdNUWVo+pDOsZ9brOb9vSm6tvgyKs/78YV5Cf8sx7bRr+0/Yq00dvV6ne8q9BmEiReVuaRk1w==
X-Received: by 2002:a24:3507:: with SMTP id k7-v6mr1921406ita.13.1532094736334;
        Fri, 20 Jul 2018 06:52:16 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id b201-v6sm1017048itc.32.2018.07.20.06.52.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 06:52:15 -0700 (PDT)
Date:   Fri, 20 Jul 2018 07:52:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] reset: meson: add dt-bindings for meson-axg audio arb
Message-ID: <20180720135215.GA31492@rob-hp-laptop>
References: <20180706143122.7612-1-jbrunet@baylibre.com>
 <20180706143122.7612-2-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706143122.7612-2-jbrunet@baylibre.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 04:31:21PM +0200, Jerome Brunet wrote:
> Add dt-bindings for the audio memory arbitror found on Amlogic's
> A113 based SoCs

s/arbitror/arbiter/

> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  .../bindings/reset/amlogic,meson-axg-audio-arb.txt  | 21 +++++++++++++++++++++
>  .../dt-bindings/reset/amlogic,meson-axg-audio-arb.h | 17 +++++++++++++++++
>  2 files changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/amlogic,meson-axg-audio-arb.txt
>  create mode 100644 include/dt-bindings/reset/amlogic,meson-axg-audio-arb.h
> 
> diff --git a/Documentation/devicetree/bindings/reset/amlogic,meson-axg-audio-arb.txt b/Documentation/devicetree/bindings/reset/amlogic,meson-axg-audio-arb.txt
> new file mode 100644
> index 000000000000..e29b3463f2e1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/amlogic,meson-axg-audio-arb.txt
> @@ -0,0 +1,21 @@
> +* Amlogic audio memory arbitror controller

s/arbitror/arbiter/

With that,

Reviewed-by: Rob Herring <robh@kernel.org>
