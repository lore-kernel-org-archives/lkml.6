Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7F6C2F42E
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A1E82085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548084279;
	bh=B7WQa3z9dIHsqasCiq1qUr98WwVj9yFFV3r/ftd5hPA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Nn32McbDtaEYpicYa5WrAZdJOdpOaOM79UC2+Il2FbadFZAimzPzevJgDKoOgu/sN
	 25O4a/LGSfxljgJJ15pfARcqObjwkqwCJWii1YlyCJ/V4pyRTo7G/MDEQKqqMaXllz
	 1gsb4Bajw3Q4D0wp1n/kvLOvfFmKKi84S7wkG3nA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730162AbfAUPYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 10:24:37 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39341 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728707AbfAUPYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 10:24:36 -0500
Received: by mail-ot1-f68.google.com with SMTP id n8so20826267otl.6;
        Mon, 21 Jan 2019 07:24:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HGpsqY3RhcjOZJBUNcKEGQVCllQxVUBLvI02gy+AAyw=;
        b=rA34XRZ1tg7GGC+p91jU9fG06sHyp2cnR3o7pXDnMBoO77+FY2MEuUdhkaIMzwaVIR
         ojpBSeXpxBTy4G9yqBnFKu1YAfYvwMTlziFg0YAtOqxgTKwqYEoakijFqDlPmE/MJ/RU
         liCgZIV6C+RUaD247HyUnZ6ktNZoJhBl5ieb2k0bAiVTE6xiL3bAvIHGXUoDoOStNbSu
         xcbLveCb3j49KgekTUBVJznZEc5K3v6zyPdyuV7rp07RV3ekgHIjOo/xyWGzwq67iINQ
         55CJvWt+p+XvDvViqB1bEy+W1uehI5FzgzKypiFDFxIm2Q0vxvvVqvWfhxvvp1TM+sLh
         wovg==
X-Gm-Message-State: AJcUukevN4IliG7kdNJJ2bNLjjE0BCMOz9eT/GFKWOkmJk/RnHFgruI8
        G5Jvf1c8kcbe4GYuvpJfmg==
X-Google-Smtp-Source: ALg8bN4brnaVBrXKQ5fs5+MXaDj0EKq+cslkta3DFKCVElkjvf8lEzaglVyPFqoIcK2vRo4T3IVXIQ==
X-Received: by 2002:a9d:c6a:: with SMTP id 97mr19103045otr.163.1548084275169;
        Mon, 21 Jan 2019 07:24:35 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p129sm6139292oif.17.2019.01.21.07.24.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 07:24:34 -0800 (PST)
Date:   Mon, 21 Jan 2019 09:24:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Andrew Jeffery <andrew@aj.id.au>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Joel Stanley <joel@jms.id.au>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v3 2/6] dt-bindings: rtc: Add quartz-load-femtofarads
 property
Message-ID: <20190121152434.GA27828@bogus>
References: <20190119090031.29147-1-sam@ravnborg.org>
 <20190119090031.29147-3-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190119090031.29147-3-sam@ravnborg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Jan 2019 10:00:27 +0100, Sam Ravnborg wrote:
> The quartz-load-femtofarads are relevant for
> several users. Add it as a common property in rtc.
> Note that valid values and default values must be documented.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Suggested-by: Rob Herring <robh+dt@kernel.org>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> ---
>  Documentation/devicetree/bindings/rtc/rtc.txt | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
