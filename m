Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A0AC43612
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B79992183F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547244929;
	bh=E0uK5re5vo6wuGUCgdtuM9YsMCPw/TwNdMnEwykqk6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=c/kUUOh5e90AB832hTTSO4hohvZaHK7JcJhPJREqSPa2anZ83qOeebD7Zuw1M/II/
	 zcBc1MqQ8EcdIQNULuHMJbiEsQ8myMbuz3nhCZd+GghZKinI/5xlokCu4nKqSqK3b0
	 99Dxln8jwiRoOT2kh08u4Ltfn817iSWj13sxyX4U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbfAKWP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 17:15:29 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43919 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfAKWP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 17:15:28 -0500
Received: by mail-oi1-f195.google.com with SMTP id u18so13472373oie.10;
        Fri, 11 Jan 2019 14:15:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PUEH0mxF5qMPbNXeJZzOjZ121n1+X/+nalnq6eKRQ8c=;
        b=rTf6rBiVmx++sROwC3n1gnnqnQhgCoMLaxWVee0VArWsVeCUzdAd0tmwnTOw4UlltQ
         D+dmi5SzfSAj9eHnrb1yLXnDq9rLa7okmsBPKtDSNRIg/8ohNBJGnRRjutwMrFaeMElT
         BTV0ezylrgOQMu1oKG4QTPRaZkEqqWrs/hq2kmGkoI1waOuVma++KwbdVkgzh2ba0ab2
         gIGIcf5JNzbuO9fulsoHJ+z6PM+1OCbpBH17lGTYxA2Mrs/iJz24ICnzmk682qq4Lu89
         OncCsn8aNXvz1FHchCiAxnnecUdcEIJ0MvtB8TlTDKvdo0BiR3jovX53wZ/psnPU4Qpd
         0bXg==
X-Gm-Message-State: AJcUukf+jBnOfnDX1xe0OZbX478qMHZvd0hog4Pij1UeIPKJ7mS1Qn9h
        kFwhPyyKuAKSLylJjcSiyg==
X-Google-Smtp-Source: ALg8bN665lbFzbfJPpAKAy4XjAk7Jw4Pnap6YA4R79vxvFr68WOSxBLlsYRa7tgTyiGIb72ANEaO5Q==
X-Received: by 2002:aca:b4c5:: with SMTP id d188mr10448401oif.309.1547244928058;
        Fri, 11 Jan 2019 14:15:28 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g4sm39436428otp.53.2019.01.11.14.15.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 14:15:27 -0800 (PST)
Date:   Fri, 11 Jan 2019 16:15:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tomasz Duszynski <tduszyns@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: iio: chemical: pms7003: add device tree
 support
Message-ID: <20190111221526.GA29234@bogus>
References: <20190106171614.12615-1-tduszyns@gmail.com>
 <20190106171614.12615-4-tduszyns@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190106171614.12615-4-tduszyns@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 06, 2019 at 06:16:14PM +0100, Tomasz Duszynski wrote:
> Add device tree support for Plantower PMS7003 particulate matter sensor.
> 
> Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
> ---
>  .../bindings/iio/chemical/plantower,pms7003.txt    | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt b/Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt
> new file mode 100644
> index 000000000000..79eb538eb932
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt
> @@ -0,0 +1,14 @@
> +* Plantower PMS7003 particulate matter sensor
> +
> +Required properties:
> +- compatible: must be "plantower,pms7003"

Looks like this has reset and set GPIO lines as well as Vcc supply. 
Bindings should be complete even if the driver or a platform doesn't use 
some parts.

> +
> +Refer to serial/slave-device.txt for generic serial attached device bindings.
> +
> +Example:
> +
> +&uart@0 {
> +	pms7003 {
> +		compatible = "plantower,pms7003";
> +	};
> +};
> -- 
> 2.20.1
> 
