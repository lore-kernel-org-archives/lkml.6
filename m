Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236D5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6E3E217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550519238;
	bh=w7A2PCla5Ssfq2rflg7OxzXhdlvnuY+13wYK2TIsuZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Bq7wMkwF8ofu07v/tUhYXQo0vCMubxP0Qce4r9pFgXTN/4yDm+MlD1Ef0ZNUa6hDA
	 eYBqFO3+nrQanHT9Jb+wz1/gzW2vs1L1MqEutjnnfAg6OmJKR5WlIgbydzgEPk6vh8
	 vlZWXRW6Q8u0iK6IydZDU2XYYtXMhgVyxRMMkK7Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbfBRTrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 14:47:16 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46845 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfBRTrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 14:47:16 -0500
Received: by mail-ot1-f65.google.com with SMTP id c18so8678054otl.13;
        Mon, 18 Feb 2019 11:47:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jtQJLb3Ix4NUvp/w/Kzu9WLZGLamYJr6jSx5praA95k=;
        b=i1nDsYXKhcEoxVTwmMA6HDyWQnbPxx5Ysnaxppb3EGRqpkQoEthsFjP91DFsXxDFXB
         +IJgBEZdpEvEBYz7FWIvOLKrzSh1vJl/AOxGrGM65i+FLPuTjYRab1GzkKwjtvry5nL+
         R++LM9oFN6KllHSkIjG542tMcPQnxD9OzbEuG8+nCximVKnY13W0AvYyHVkk30J5LuZ7
         NXMfbO5Q46qWq35TF7nlPcPp7fhHyhySr7qtWI4tQFx6OCWxgqUsTdxz2+lvmcLOHKeh
         OtsisME3ZYXfEjG1PAZsXSWim8avkGe72fDRYNtHNV15WUnjVEa+WMGDLM/LVlOl0XYX
         nbEg==
X-Gm-Message-State: AHQUAuZqhmkYG9A6Q7z/wBweXUlqW9hZtencyeW+AFADzptsYXDpuqk1
        +fqAC5VEbrXkgheBlYAECohu+Uc=
X-Google-Smtp-Source: AHgI3IYUOlMsxewbwCgNLhuYw8dHBxiB8mGxoRweaxqnEBKmMU5CP3RtMsZLT8zSohjB3HOpdmj/lQ==
X-Received: by 2002:a9d:7651:: with SMTP id o17mr14513723otl.279.1550519235336;
        Mon, 18 Feb 2019 11:47:15 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n187sm2974187oia.34.2019.02.18.11.47.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 11:47:14 -0800 (PST)
Date:   Mon, 18 Feb 2019 13:47:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH V2 1/2] dt-bindings: hwmon: Add optional regulator
 support to pwm-fan
Message-ID: <20190218194714.GA6350@bogus>
References: <1549557480-14436-1-git-send-email-stefan.wahren@i2se.com>
 <1549557480-14436-2-git-send-email-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549557480-14436-2-git-send-email-stefan.wahren@i2se.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  7 Feb 2019 17:37:59 +0100, Stefan Wahren wrote:
> This adds an optional regulator support (e.g. switchable supply) to the
> pwm fan binding.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  Documentation/devicetree/bindings/hwmon/pwm-fan.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
