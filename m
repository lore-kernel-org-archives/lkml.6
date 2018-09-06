Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216EDC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B87982075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:43:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B87982075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730459AbeIFXU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 19:20:26 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44880 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728943AbeIFXU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 19:20:26 -0400
Received: by mail-pg1-f195.google.com with SMTP id r1-v6so5657264pgp.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 11:43:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jA6lvvJ/PoqJVG5+GJ9mkM1oymchTRZvGp41dY2g0/8=;
        b=SsLh2wJMWC6ymURJq16XZn3rlPlD2ZvhcyfrYp2vM9Dp5fbaoEcVg1OhRQWvmtAngU
         xoFo/fsC8N2/myWbh7y/oM4Ov7N3VsSMOYpALV/UTidHWxr/ak1Y9A1Ihgx0V582WfaB
         GvmVbYgkEHnKTRDooJPiWiB5KrXpcAlX/XjOHC6ylALFfJRrRS8AttbBxspX7+zpCeUb
         krQW+GzKAiR6N2COluriCglzPJYdkEUg5x+C4GrdVXee+HAjdWO3A/peVpCYH4offAsc
         Ni4nsxvwGw+tvQKYOyZBchED+DWWKv+s7DnYxgxabAge97TbNmwQosNgU7NeeP5IfXoJ
         rV7Q==
X-Gm-Message-State: APzg51D62grDp3iMqEFT8aQ7MQgXN75NsqYCXdgRWO8ilLuYOVMFsnVW
        fpdJbdEk42plx9l9FpZqoxwsRA==
X-Google-Smtp-Source: ANB0VdYlFPKKct5E5mziLzE5zCqVofVZJRv9K6/aMgKTYu0OuX51fHf9EHPNFDBskzoHiHSi5VPDTw==
X-Received: by 2002:a63:549:: with SMTP id 70-v6mr4323562pgf.385.1536259420474;
        Thu, 06 Sep 2018 11:43:40 -0700 (PDT)
Received: from localhost ([207.114.172.147])
        by smtp.gmail.com with ESMTPSA id w12-v6sm8202437pfd.110.2018.09.06.11.43.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Sep 2018 11:43:39 -0700 (PDT)
Date:   Thu, 6 Sep 2018 11:43:38 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Alan Tull <atull@kernel.org>
Cc:     Moritz Fischer <mdf@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 6/8] fpga: bridge: fix obvious function documentation
 error
Message-ID: <20180906184338.GD20419@archbook>
References: <20180904212237.3078-1-atull@kernel.org>
 <20180904212237.3078-7-atull@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180904212237.3078-7-atull@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 04:22:35PM -0500, Alan Tull wrote:
> fpga_bridge_dev_match() returns a FPGA bridge struct, not a
> FPGA manager struct so s/manager/bridge/.
> 
> Signed-off-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
> ---
> v2: no change in v2 of patchset
> ---
>  drivers/fpga/fpga-bridge.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
> index c39d35f..7b0071a 100644
> --- a/drivers/fpga/fpga-bridge.c
> +++ b/drivers/fpga/fpga-bridge.c
> @@ -125,7 +125,7 @@ static int fpga_bridge_dev_match(struct device *dev, const void *data)
>   *
>   * Given a device, get an exclusive reference to a fpga bridge.
>   *
> - * Return: fpga manager struct or IS_ERR() condition containing error code.
> + * Return: fpga bridge struct or IS_ERR() condition containing error code.
>   */
>  struct fpga_bridge *fpga_bridge_get(struct device *dev,
>  				    struct fpga_image_info *info)
> -- 
> 2.7.4
> 

Thanks,

Moritz
