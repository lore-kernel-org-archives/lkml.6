Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E2FC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44D46208E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:58:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44D46208E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389318AbeHGRNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 13:13:22 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:55677 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387617AbeHGRNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 13:13:21 -0400
Received: by mail-it0-f66.google.com with SMTP id d10-v6so22418163itj.5;
        Tue, 07 Aug 2018 07:58:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C3jZHYHcPCetqER9Ta55VeiRyxBiBHVO1CPfDeOQR2g=;
        b=jqcu/Nuwi6B0vlf5PlAtLoEdI4L7Hn5be630rX5YoCdvufCQZ6xcZJuC1IMnJvWLq+
         wv602l4Xkz03thh+QOvUF5Eg6f1sXIk/QOMXrkvOcovHrrMlhb0zJfCIVPoo/bCpVEQJ
         GgAyA5bgCa5P1ACOvJZUwdHZzFw3FCVi6cSYCg6mtGuMZu/azrCe7SYnMCeDk1qchset
         o8hHXWT2I71AzEcf+m67IB6/nsewTlBGY6CRuHykg70x4ZbfinpVz+w+sY4JbQ4icoXW
         /+nGTSQHEtPJ4S1UFimGvVq2sj5Vhi6OF/7uQ4r4WxpY5sE5ymwtdIUpEGy90Vq0PFuS
         kHYw==
X-Gm-Message-State: AOUpUlFWGgMqSW7a9xDKBeHOBu+/oaBHp888NBHXWbs4qcy1Qyo2UPnG
        CleNPIdZgtZc7iSBD2gIwQ==
X-Google-Smtp-Source: AA+uWPxnK7PtfadlaJ4ThtowvI5OyYwo7l0BGBCwEV2ddvdDSj5xTAiIjlZQAxA376gCE6AulYytKA==
X-Received: by 2002:a24:818a:: with SMTP id q132-v6mr2267473itd.51.1533653918492;
        Tue, 07 Aug 2018 07:58:38 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id z195-v6sm675787ioe.38.2018.08.07.07.58.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 07:58:37 -0700 (PDT)
Date:   Tue, 7 Aug 2018 08:58:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     jic23@kernel.org, broonie@kernel.org, lars@metafoo.de,
        Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        mark.rutland@arm.com, davem@davemloft.net,
        mchehab+samsung@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/6] dt-bindings: iio: accel: Add docs for ADXL372
Message-ID: <20180807145837.GA6742@rob-hp-laptop>
References: <1533557087-10401-1-git-send-email-stefan.popa@analog.com>
 <1533557087-10401-3-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533557087-10401-3-git-send-email-stefan.popa@analog.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 03:04:43PM +0300, Stefan Popa wrote:
> Add the device tree binding documentation for the ADXL372 3-axis digital
> accelerometer.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> ---
>  .../devicetree/bindings/iio/accel/adxl372.txt      | 22 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/adxl372.txt

Reviewed-by: Rob Herring <robh@kernel.org>
