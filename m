Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7418C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9562520844
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:42:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9562520844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbeIFXS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 19:18:57 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40628 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbeIFXS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 19:18:57 -0400
Received: by mail-pf1-f196.google.com with SMTP id s13-v6so5713082pfi.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 11:42:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xTC0Oyy855old/gbdOWMYBwmjd/ysI2FD60FSB36zZ0=;
        b=VNJ2V2v3/5661W8LyJks9gimunHsXDZ+xWYhJ3d46o5SqGDXxJGbrm3mUG9IKASlOK
         7ykB/yuS2d6KPn0p4qDTUtuj2zEhceywUFsmvzLmhdE2E7Vn5REIh9XmBZerIVtZPY7F
         vkXg4yaW93fHr+bujLhfaUjW/n/sgVJl1wB/vv2njahkTIGvBjxBKS8e5HuuJnpbDjNU
         43ie5MF0813UJ1wn/xsTxeHlKolhbCdWecUgCyJq9eeXt+hD7okWpFj2CxvGbUINdeNs
         gxLZURtKwLdphy32XmIEH68B80/jZgGqnmxUI2Ce3dvjSQcIMkwSqyifbLUqymxLJM6M
         DWaQ==
X-Gm-Message-State: APzg51At1yFJ7ZzrgPHODIQwadNXiLm5gRdDdZWobclIj5gNn8lwQStB
        6a5Y0feODHHvd8wOEiw85BjZWN5NvYg=
X-Google-Smtp-Source: ANB0VdZphvFmQc0QTy2mIBzER2yTqJsRWFly/Q6rpBnWf7csdC2Bubh8fEKvtRj/vEnhJ1WY4I5X+Q==
X-Received: by 2002:aa7:818f:: with SMTP id g15-v6mr4312573pfi.71.1536259331681;
        Thu, 06 Sep 2018 11:42:11 -0700 (PDT)
Received: from localhost ([207.114.172.147])
        by smtp.gmail.com with ESMTPSA id a16-v6sm6311797pgv.29.2018.09.06.11.42.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Sep 2018 11:42:11 -0700 (PDT)
Date:   Thu, 6 Sep 2018 11:42:10 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Alan Tull <atull@kernel.org>
Cc:     Moritz Fischer <mdf@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 7/8] docs: fpga: document fpga manager flags
Message-ID: <20180906184210.GC20419@archbook>
References: <20180904212237.3078-1-atull@kernel.org>
 <20180904212237.3078-8-atull@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180904212237.3078-8-atull@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 04:22:36PM -0500, Alan Tull wrote:
> Add flags #defines to kerneldoc documentation in a
> useful place.
> 
> Signed-off-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
> ---
> v2: add description for FPGA_MGR_ENCRYPTED_BITSTREAM
> ---
>  Documentation/driver-api/fpga/fpga-mgr.rst |  5 +++++
>  include/linux/fpga/fpga-mgr.h              | 20 ++++++++++++++------
>  2 files changed, 19 insertions(+), 6 deletions(-)
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
> index 1ca02ce..e8ca62b 100644
> --- a/include/linux/fpga/fpga-mgr.h
> +++ b/include/linux/fpga/fpga-mgr.h
> @@ -53,12 +53,20 @@ enum fpga_mgr_states {
>  	FPGA_MGR_STATE_OPERATING,
>  };
>  
> -/*
> - * FPGA Manager flags
> - * FPGA_MGR_PARTIAL_RECONFIG: do partial reconfiguration if supported
> - * FPGA_MGR_EXTERNAL_CONFIG: FPGA has been configured prior to Linux booting
> - * FPGA_MGR_BITSTREAM_LSB_FIRST: SPI bitstream bit order is LSB first
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
> + * %FPGA_MGR_ENCRYPTED_BITSTREAM: indicates bitstream is encrypted
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

Thanks for doing this,

Moritz
