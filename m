Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA503C31681
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97E9420879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548090554;
	bh=23+qyf9uShTaxcn569y60O6rItm+sWWw4RnTgSNoD9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YZFP7maaeswmS3fNqN4kb1oANv/6WdYeImlnYqrDCeFTsjk61HMQ1aaw3uC0NkeTt
	 WaCPOIjIH5bnQ7odJxpHUx2OJe5QuhEm+W7OzUmqnPmVDTtT3MW8tMEA+jvI7DfNSQ
	 2FL9+B9cryD05a9NTGoSGEskdBEWck7JqwPQWxdA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbfAURJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 12:09:12 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33048 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfAURJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 12:09:11 -0500
Received: by mail-ot1-f66.google.com with SMTP id i20so21192614otl.0;
        Mon, 21 Jan 2019 09:09:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vxe1DFDMhLD+4kqrUQTKR+OGErAZITvYwBYiudjM6vI=;
        b=eM2IZrEJn0NgnyMsToAJ0B4to9K9QvfpcAIOs7JJcmeuFzb24379wzRncrW6V2+/Nt
         ha4ZqFdCIiILx/obT4sKWavq1JHZ2lfiun2orv97RWIr3BTQpAmJLr4bNnQTUTjh9PBX
         6FurOioia39A0rmL7EJ7pqXyg9DD0ilyApjMfnOo2hivKncZuEsJsj42i8MsIbYjb9a3
         LqDei428tKg4wWB/X8I+6PngwKqQL5yNvxrVDo+wUr2gw7jZ5ftxP7FdrM/Eo6UhIdjU
         ppbSlpgPAg2CitMX6tK/OZKiTcEG/kaX2Yp98m9Ta3JpXI9gRrbm7+tkwaI7b7AAEvnq
         QnZA==
X-Gm-Message-State: AJcUuke+XdpTWODtmZVvCg2XvvStitiom17DiW5ZVuOaSEnpV9XUo4cM
        6adIjQTl2Y2IBAlGNWoH7w==
X-Google-Smtp-Source: ALg8bN70UicKRfjEbeAmBk3kNr0Bl1UzyYzhbpkChDu+hQDdebX0i1p813vFb8bGrLNVb7yXvHNCjQ==
X-Received: by 2002:a9d:620f:: with SMTP id g15mr18845099otj.296.1548090551140;
        Mon, 21 Jan 2019 09:09:11 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l6sm5754831otk.51.2019.01.21.09.09.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 09:09:10 -0800 (PST)
Date:   Mon, 21 Jan 2019 11:09:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Loys Ollivier <lollivier@baylibre.com>
Cc:     devicetree@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Loys Ollivier <lollivier@baylibre.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: Add vendor prefix for "GlobalTop
 Technology, Inc."
Message-ID: <20190121170909.GA928@bogus>
References: <1547744074-28308-1-git-send-email-lollivier@baylibre.com>
 <1547744074-28308-2-git-send-email-lollivier@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547744074-28308-2-git-send-email-lollivier@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jan 2019 17:54:31 +0100, Loys Ollivier wrote:
> Add globaltop vendor definition.
> 
> Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
> ---
> 
> v2: Alphabetical order
> 
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
