Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B396C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1365021773
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fG6iuFbp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbfBKWKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 17:10:15 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42096 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbfBKWKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 17:10:15 -0500
Received: by mail-pl1-f195.google.com with SMTP id s1so208339plp.9;
        Mon, 11 Feb 2019 14:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LxcC57AYJDo5lH5zr4TmrdEFiY3rzHyU9M3v9CWzcGM=;
        b=fG6iuFbpTY+GGY9cDzGLj91T/DGLd6gH1b+eqyJVb654VALHOY4v828m0FI8QYho3Y
         biOYxRbO3jzRTLw1/hzNHptD2VsddjrBcsFkksxv8inPic07KIuvWwPBTA5MLUjo1khu
         v5g//K3z6GBn/rh09Pn5T7B2KdHbF/I5q6lbn/o70NApT5rFwUAme6OcJj/MbH1ABmG6
         KP2n7Ri50FUuqqhCXcTDdOAHpySt2sb9AO9ppdkGQE0ICrA6QN+L3GdtuRMrjfB7JZ/R
         QgdXo8nLePLs4zO34iP6nBuB3YlvVxPRdZxRcZO35hEcE7zuJPuJpOASn3edcKTKO5CX
         OFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LxcC57AYJDo5lH5zr4TmrdEFiY3rzHyU9M3v9CWzcGM=;
        b=lQZ0frtUtyF568wLrVX/aRxxT4NL1HCyktwj8o7uAD12bRQDOajcVuE+/+99Wv7ipT
         NN6DEEIvbKetnBeslUnOnaftPmaCSQ9F6dYbeGJamlTFR/E9djTrZKy+DJQHFWlyejph
         yiNttmqSTmVHgPdQ4b7Web9fijNUFRi47mgU6xzruiLTYfTNJlOQfY9NU8vZTdhF7YhY
         D31dsdOkksObDPUYxOwjdzM7CY0HXu0ZLb/2VhThE9koa5/1CSA91t8ubrhsbkTzJIWD
         JT9beDWYa6UEbLOsWmD7TP45qE2HLBxBIq4eKrixUmJDMUj/7tz0fGujR64JmUKv7c+O
         Yd1w==
X-Gm-Message-State: AHQUAuYcd/Y0M0JXa7nrB2YctlbR4HTHKcflmowMIGg2L3Zq43BFnlky
        Pg9lCu3XpH+y9oHywh3gbOw=
X-Google-Smtp-Source: AHgI3IY64Yo0AfrzfDwTjD+ZV2DFiLkPgasxWlYLeXYogmPqcgE6PQbXVkDMd/9zpk3gesqfbk61aw==
X-Received: by 2002:a17:902:6f09:: with SMTP id w9mr470097plk.309.1549923013739;
        Mon, 11 Feb 2019 14:10:13 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id 1sm215206pfy.68.2019.02.11.14.10.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 14:10:12 -0800 (PST)
Date:   Mon, 11 Feb 2019 14:10:11 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Vignesh R <vigneshr@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: input: ti-tsc-adc: Add new compatible
 for AM654 SoCs
Message-ID: <20190211221011.GA149505@dtor-ws>
References: <20190108052631.4169-1-vigneshr@ti.com>
 <3623af02-063d-9077-1e59-99d8cfe93ddd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3623af02-063d-9077-1e59-99d8cfe93ddd@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vignesh,

On Mon, Feb 11, 2019 at 11:10:59AM +0530, Vignesh R wrote:
> Hi Dmitry,
> 
> On 08/01/19 10:56 AM, Vignesh R wrote:
> > AM654 SoCs has ADC IP which is similar to AM335x, but without the
> > touchscreen part. Add new compatible to handle AM654 SoCs. Also, it
> > seems that existing compatible strings used in the kernel DTs were never
> > documented. So, document them now.
> > 
> > Signed-off-by: Vignesh R <vigneshr@ti.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> 
> If there are no comments, could you queue this bindings patch? This will
> help me in getting ADC DT nodes to be merged into ARM SoC tree.

Sorry I did not realize you waited for me. Yes, please feel free to
merge through your tree.

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks,

-- 
Dmitry
