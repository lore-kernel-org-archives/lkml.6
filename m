Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29361C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFF8920838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544224713;
	bh=Z1zDJ5csIF/85m2d+n+ze9rGcwwD+w4T3lrsHWJSpak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wccTD8DscjN7NpUnu8Hw+ycwFiImXzmC1FAsTXHWDaZi24KB1sslm3d2sEg1XtfVt
	 vsaXy1qmzrwVtoO8N3cu1r32CTzHwIPcpIx9MCD4Pe46CiENa/hU2u1eAwyRyT1b3G
	 LEpAq7dRhNUoYSbw0GBmT7FYZ65qb5EIW80DuPgU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFF8920838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbeLGXSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 18:18:31 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34485 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbeLGXSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 18:18:31 -0500
Received: by mail-ot1-f65.google.com with SMTP id t5so5388413otk.1;
        Fri, 07 Dec 2018 15:18:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y1if/eXBYaK4jnbBoAlnZCwpWnNN3TFLhYIyeSWuga8=;
        b=a3AMMZV4fsOIVCxQ3/oJg8or81xpxhxrbCkdRPnLqWVjuvTMnoFplsnun9rZNHK+Z4
         mtBXZmGufE2Xkx9BbSgcORsGcP9glrNxeub7kWFWkdJ65ZbXunVDFuHIxd0LZLe2l6pt
         28h8EvKqibYEqYS9oesl0PAfVEh+KXjEjNL8N27Oe36G5e0PntHyCViPiQznLzftO5wj
         Mcm30jsJIRYkAbmZOU5suJj9CdePJPLPegg9ITcwix5wYAioe+Z5NbJFosmMjONXgwIV
         Q5IwDAQoMGUcPhB0tlKiJLwVbHd7CCpE2IBo6J+qCYTtUtN9v+Be0g8wNSQ8UtmxOHwJ
         y7nw==
X-Gm-Message-State: AA+aEWYJ66r276gen2FREpWrQx6teWlvBgOdjlZQPMM6ZOkmj7kgXnZ1
        SvL6CslSbBMpq86VOcuFCSmh02k=
X-Google-Smtp-Source: AFSGD/V5tpPjjcfobKlnV4ZlcAbFGDsdRxy1l1qKR3H5kgB1sAmtoQw9Q9iVso8p0YyefsJJM7tH+g==
X-Received: by 2002:a9d:2287:: with SMTP id y7mr2652263ota.47.1544224710002;
        Fri, 07 Dec 2018 15:18:30 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f18sm2472822otl.18.2018.12.07.15.18.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 15:18:29 -0800 (PST)
Date:   Fri, 7 Dec 2018 17:18:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     freedreno@lists.freedesktop.org, Chris.Healy@zii.aero,
        festevam@gmail.com, Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 5/5] dt-bindings: display: msm/gpu: document
 amd,imageon compatible
Message-ID: <20181207231828.GA17290@bogus>
References: <20181204151702.8514-1-jonathan@marek.ca>
 <20181204151702.8514-5-jonathan@marek.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204151702.8514-5-jonathan@marek.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  4 Dec 2018 10:17:01 -0500, Jonathan Marek wrote:
> Document the new amd,imageon compatible, used for non-qcom hardware that
> uses the drm/msm driver (iMX5).
> 
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>  Documentation/devicetree/bindings/display/msm/gpu.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
