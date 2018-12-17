Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D25C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 875C021473
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545086628;
	bh=uOTtjqYFJevB1Nh5cbV3rgcLtVjlnGHaoekY6AIboic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FNc8yIJS57V78lv+OZdk8GqtjQq3KimuR8o3hwevxx4tmx0FjfMWnAfhvpdrtHa59
	 AEc1EYOzb+tPYrS39wIpU2iioUaYsmIMujur2NWM9gqzZKMUfY6w1ibd02P3XCU652
	 gLQH7fct+DylEftpojn+m2HoYMIaSoUNRgA2tGBU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732098AbeLQWnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 17:43:46 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33085 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732023AbeLQWnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 17:43:45 -0500
Received: by mail-ot1-f68.google.com with SMTP id i20so13851059otl.0;
        Mon, 17 Dec 2018 14:43:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SxqmKP+r08Pr++EVF7PcUuJdqYJ3XXrV8S1skbn+Bdg=;
        b=tcxHa3+KPCH3fG55RROaq3uAF0ExhwfjazO5fi1a1dA1i/zUhshnDJQOjdBw6fryZI
         M6DRnDpehGhXxS3LGnAdX1sgbkdxrek0ENfokWXimF3g8rjOtEp/CHC42m2VEe1ZjthD
         kYYkbmT7cNfErVZYQlRp4JIHaB+n+5+6BKPPLKdhlbx+ISQFRzgkYvNjKSWjCL1r6Wae
         9PeDxXBSWPyQLkchkp9xRwfaeQIwl/KomGbQKNEmQzCmigPzj366Zi3cyYSP2KeV0P4+
         1sQ32DYPlTAVcdlzQegGRNQudx0YMfTe/GnsZV+G8HmobHpvXzgfEELQ19PRvzFz22bU
         wTpA==
X-Gm-Message-State: AA+aEWbmGyYVFQThZ9f7Gb0JjvJrJ4arlg5Yw+4qc7xZ86MhH/cX423f
        ZxXnjBdQecakFADdRwUYzA==
X-Google-Smtp-Source: AFSGD/UX2a2StWxDJLRnCQsGAHiOE8RxRypnSHFdqfhHaxnvD3odFZzttpeWMXWgxCLxjDCNm1UD7A==
X-Received: by 2002:a9d:346:: with SMTP id 64mr11196513otv.90.1545086624533;
        Mon, 17 Dec 2018 14:43:44 -0800 (PST)
Received: from localhost (cpe-70-114-214-127.austin.res.rr.com. [70.114.214.127])
        by smtp.gmail.com with ESMTPSA id 102sm8154630otj.65.2018.12.17.14.43.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 14:43:44 -0800 (PST)
Date:   Mon, 17 Dec 2018 16:43:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andreas Brauchli <a.brauchli@elementarea.net>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Brauchli <andreas.brauchli@sensirion.com>
Subject: Re: [PATCH v3 3/3] iio: chemical: sgp30: add device tree support
Message-ID: <20181217224343.GA25009@bogus>
References: <20181213144418.24965-1-andreas.brauchli@sensirion.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213144418.24965-1-andreas.brauchli@sensirion.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Dec 2018 15:44:18 +0100, Andreas Brauchli wrote:
> Add device tree support for Sensirion SGP30/SGPC3 gas sensors.
> 
> Signed-off-by: Andreas Brauchli <andreas.brauchli@sensirion.com>
> ---
>  .../bindings/iio/chemical/sensirion,sgp30.txt     | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirion,sgp30.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
