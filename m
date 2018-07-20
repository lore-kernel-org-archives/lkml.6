Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB39ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24C6D20833
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:43:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24C6D20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732144AbeGTPbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 11:31:55 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:55252 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732042AbeGTPbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 11:31:55 -0400
Received: by mail-it0-f68.google.com with SMTP id s7-v6so14974617itb.4;
        Fri, 20 Jul 2018 07:43:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tpiSy5XptTYkyuOB0yAjar9+1pUCTsIguT/7yIDbfYQ=;
        b=KUY4XPnpU4SfmIf2XBsSi2Iid1C7Dolv5U8gjNBbJ3WAihWX5UvtocEbegNL2js99J
         UuoJRrA9/f2L4ZhEsSjMDhlv4qqNu87oaTg8Zs5J7xEiN1osC7k4DqebvEFsPGM+XHT/
         7lmAnvfGZvEW7ZdDXdenVHkklY3KL7argttashSWRNWXA1F4KWgUfLOuHHaOoNcF2MVR
         gRtj4842w/6NIXTB0/lOyr/pnaI6YVomV2G9F7Gl29e4hMjPxDd4b8XmPW4z3s/+KU5t
         23pYiu4IrHg/ld741yjGOGdUZX+2qhPy8wCxllirNOSyG+sqzWjeeigkiJn6lfaXtJNT
         W69A==
X-Gm-Message-State: AOUpUlGmuTPFeOPlIPP5fszkz7dfuSlygb7j3rkf+GdD0wmSbS0+DcMm
        x0lomzHENYcXIk4zi4tmQA==
X-Google-Smtp-Source: AAOMgpc7d1qZRrqB816iva0/6u965e7tjwZyaSzcPnZ+MFpjHhuji2k6afCq2nC+8BV7iPZAs+L7eA==
X-Received: by 2002:a02:8d17:: with SMTP id h23-v6mr2128459jak.115.1532097798405;
        Fri, 20 Jul 2018 07:43:18 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id 204-v6sm1026934itx.4.2018.07.20.07.43.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 07:43:17 -0700 (PDT)
Date:   Fri, 20 Jul 2018 08:43:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, mark.rutland@arm.com, davem@davemloft.net,
        mchehab+samsung@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, rdunlap@infradead.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] dt-bindings: iio: accel: Add docs for ADXL372
Message-ID: <20180720144316.GA25713@rob-hp-laptop>
References: <1531409697-19957-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531409697-19957-1-git-send-email-stefan.popa@analog.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 06:34:57PM +0300, Stefan Popa wrote:
> Add the device tree binding documentation for the ADXL372 3-axis digital
> accelerometer.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> ---
>  Documentation/devicetree/bindings/iio/accel/adxl372.txt | 16 ++++++++++++++++
>  MAINTAINERS                                             |  1 +
>  2 files changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/adxl372.txt

Reviewed-by: Rob Herring <robh@kernel.org>
