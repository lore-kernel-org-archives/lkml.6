Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08EABC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACC522148E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:02:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACC522148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbeHPWDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 18:03:08 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:33381 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbeHPWDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 18:03:07 -0400
Received: by mail-pl0-f68.google.com with SMTP id b90-v6so2530445plb.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 12:02:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=djKNDuekVLyr38epOlSq3wP9TgAafepG8mJSzmhFlTs=;
        b=irl71JZr4Xy6c9XCDIix1SvmsVvvYTIaRz6kbAWIwFTkyiKwCSlX4uzkkgAozFtouA
         8XAWDzQ/3NUwp8M30YRFsq+xBSFs6PoNwXDFPsM5S/6LOp0UsxhGxj6ombZHXIlMpL7u
         FyxuUMZ60pSjmpRx+yWH8t6fRslkEZGXm3mHXtbYXnoFhkGUSqAKc1ug7kfVivez35U5
         UpIi6LHrQMVsq2g62SbqYyZhO6feDZNe5QClAbeIBWowZ9X5qu1YEFKgIdDejDu3m2jm
         pYNSrLvVF098edwXKEnac3pKH+numpxukMZIlWRYFdxpYj7FAbibieR0LUwODnWyW5Vg
         DXmA==
X-Gm-Message-State: AOUpUlFhjUDf5CndKRxVj2moaGsSvLJVFPnJbvZJHjfjHe8c9HXPvKEq
        eaoMVdRy2Be55LTjRQcNZRRNOQ==
X-Google-Smtp-Source: AA+uWPzz6G/NTEkB/NDEr1esqdp6Uw5+fRFXNHYnSgDjULur8o5mRI57Mxydu7/bgvOocFs70j6i/g==
X-Received: by 2002:a17:902:b28:: with SMTP id 37-v6mr30031666plq.337.1534446174013;
        Thu, 16 Aug 2018 12:02:54 -0700 (PDT)
Received: from localhost ([207.114.172.147])
        by smtp.gmail.com with ESMTPSA id l27-v6sm41537pfi.180.2018.08.16.12.02.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Aug 2018 12:02:53 -0700 (PDT)
Date:   Thu, 16 Aug 2018 12:02:52 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Alan Tull <atull@kernel.org>
Cc:     Moritz Fischer <mdf@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 7/8] docs: fpga: document fpga manager flags
Message-ID: <20180816190252.GB3932@archbook>
References: <20180814191526.3247-1-atull@kernel.org>
 <20180814191526.3247-8-atull@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180814191526.3247-8-atull@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On Tue, Aug 14, 2018 at 02:15:25PM -0500, Alan Tull wrote:
> Add flags #defines to kerneldoc documentation in a
> useful place.
> 
> Signed-off-by: Alan Tull <atull@kernel.org>
> ---
>  Documentation/driver-api/fpga/fpga-mgr.rst |  5 +++++
>  include/linux/fpga/fpga-mgr.h              | 18 ++++++++++++------
>  2 files changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/driver-api/fpga/fpga-mgr.rst b/Documentation/driver-api/fpga/fpga-mgr.rst
> index 431556d..db8885e 100644
> --- a/Documentation/driver-api/fpga/fpga-mgr.rst
> +++ b/Documentation/driver-api/fpga/fpga-mgr.rst
> @@ -183,6 +183,11 @@ API for implementing a new FPGA Manager driver
>  API for programming an FPGA
>  ---------------------------
>  
> +FPGA Manager flags
> +
> +.. kernel-doc:: include/linux/fpga/fpga-mgr.h
> +   :doc: FPGA Manager flags
> +
>  .. kernel-doc:: include/linux/fpga/fpga-mgr.h
>     :functions: fpga_image_info
>  
> diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
> index 1ca02ce..777c502 100644
> --- a/include/linux/fpga/fpga-mgr.h
> +++ b/include/linux/fpga/fpga-mgr.h
> @@ -53,12 +53,18 @@ enum fpga_mgr_states {
>  	FPGA_MGR_STATE_OPERATING,
>  };
>  
> -/*
> - * FPGA Manager flags
> - * FPGA_MGR_PARTIAL_RECONFIG: do partial reconfiguration if supported
> - * FPGA_MGR_EXTERNAL_CONFIG: FPGA has been configured prior to Linux booting
> - * FPGA_MGR_BITSTREAM_LSB_FIRST: SPI bitstream bit order is LSB first

We are actually missing the ENCRYPTED flag here, can you add that while
we're at it? I must've forgotten to add that back then ... derp.

> - * FPGA_MGR_COMPRESSED_BITSTREAM: FPGA bitstream is compressed
> +/**
> + * DOC: FPGA Manager flags
> + *
> + * Flags used in the &fpga_image_info->flags field
> + *
> + * %FPGA_MGR_PARTIAL_RECONFIG: do partial reconfiguration if supported
> + *
> + * %FPGA_MGR_EXTERNAL_CONFIG: FPGA has been configured prior to Linux booting
> + *
> + * %FPGA_MGR_BITSTREAM_LSB_FIRST: SPI bitstream bit order is LSB first
> + *
> + * %FPGA_MGR_COMPRESSED_BITSTREAM: FPGA bitstream is compressed
>   */
>  #define FPGA_MGR_PARTIAL_RECONFIG	BIT(0)
>  #define FPGA_MGR_EXTERNAL_CONFIG	BIT(1)
> -- 
> 2.7.4
> 

Thanks,
Moritz
