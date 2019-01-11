Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE510C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DE8120878
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547244693;
	bh=dMRTzjojEFisfO8da13HuK+UKHbFgH98Q/9nTzp0lUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2q6r7fgUY96XBDn6cKkgKIL+qko9UyPYdNCTW8gI9g1sVos7tmTZFR7BJBAbYPi62
	 sbwqnnPjtBYzht5Ms8c19Ud22x2dP2ElX58KW81PVRPKXSI54B4gOD9Tfpr1q7apfd
	 8Ng/+1Q1W3iTh/AGqsBhHxXZRr1rW747NiXsbkoI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfAKWLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 17:11:32 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39287 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbfAKWLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 17:11:32 -0500
Received: by mail-oi1-f193.google.com with SMTP id i6so13480826oia.6;
        Fri, 11 Jan 2019 14:11:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sYGW55MCmAeRFZJO2w2gA1vaSLdO6YECqq0T8c512Jc=;
        b=X3qtBLqcYC9NR1vzkBiP+eFYXigJAZLLvvd+ASri+V1oM/aamofj7LABTqKIq2ts42
         EK+TyCZT8kujVcurb3AKYE46IhmDQfEQ3lWjX49UOpucZpO8JaTh3Ux2Y4H9QrpHWDYh
         kQjXRyEfPgXP3kEB2I1zFseURXCXxw8Yyd1cEVaR0yhEyLliBu0QdvggLia6sTqVd8TL
         d4NQU9nbHcNOmEF/3rnR+EK5kAWfJcjZcTIMnDuLQyOmlDjk4sphC+o/m+QCKUsZYKWb
         avD6+/YsGx1Ufqk6yuy3aaIqWVRmjH7+qMWC2HJOSa3cUowzon+g6Ynmng4FzLOgwLCk
         ld1w==
X-Gm-Message-State: AJcUukd1HAg4JxmcTKyvv7V3DEMsAgTQgAAhoIeAMOatE7QoP5oHaqwv
        lakD++VKBqe7aN9xulKe1g==
X-Google-Smtp-Source: ALg8bN4rw7uMm6wB6LodUFUlcgt8M+17btS4zr2fOR0h8CzbyZ69X/BfoA3qUIgD1q37vmr6ZH7Ksg==
X-Received: by 2002:aca:fd91:: with SMTP id b139mr10503784oii.83.1547244691029;
        Fri, 11 Jan 2019 14:11:31 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l5sm34743859oil.15.2019.01.11.14.11.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 14:11:30 -0800 (PST)
Date:   Fri, 11 Jan 2019 16:11:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [(RFC) PATCH v2 7/7] soc: qcom: aoss-qmp: Add cooling device
 support
Message-ID: <20190111221129.GA25616@bogus>
References: <20190106080915.4493-1-bjorn.andersson@linaro.org>
 <20190106080915.4493-8-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190106080915.4493-8-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 06, 2019 at 12:09:15AM -0800, Bjorn Andersson wrote:
> The AOSS provides three cooling devices "cx", "mx" and "ebi" that must
> be enabled when temperature goes below a certain level to counter low
> temperature issues. Probe these devices, when described in DeviceTree.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> We do not yet have the necessary support in the thermal framework to implement
> the cooling device associated with the QMP, so I've just included this patch as
> an RFC in this series.

I'd be fine if you include the binding part now. Looks fine to me.

> 
>  .../bindings/soc/qcom/qcom,aoss-qmp.txt       | 18 ++++++++++
>  drivers/soc/qcom/aoss-qmp.c                   | 36 +++++++++++++++++++
>  2 files changed, 54 insertions(+)
