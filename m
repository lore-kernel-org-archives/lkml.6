Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB98C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4859420657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMlggeh0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388983AbfAOSpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 13:45:25 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41967 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729764AbfAOSpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 13:45:25 -0500
Received: by mail-pg1-f193.google.com with SMTP id m1so1596971pgq.8;
        Tue, 15 Jan 2019 10:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cO/0VxesyPC4E0ZI3n3MmKRrjxXhYxvu6OgX0juHDE4=;
        b=fMlggeh0CwgjQ7MHU7vkmE4AnxdDAuQAinhNQJYMlG/Wd95UL9kwaXTZU+RLShfZTQ
         Zl+4LhXf9vaLV0QvqAjDJNkzmj2gsUi8wV1eMYGBxcLd+p3UDiTBY11BOpjMi8cgsDVg
         S6EVV0urfmuZFZ0tLRy4ElVT3LLR5O6RyngwPuOJAGo83EeZRbIcrEcIYvJzsn/YBzE0
         y28oY3ia42u+K4C0WeWh1BHeu+sYyGtK2WPDI/8iEWgoIxFoYYV9CX0CX3hFRdJth45d
         goZmxRHKCHRBx1nG3+B2P+WDoLThVCJG1jOs1tziD7DzJdtk1sJnvv7ryvNxK3gDzqkE
         bxGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cO/0VxesyPC4E0ZI3n3MmKRrjxXhYxvu6OgX0juHDE4=;
        b=OF8NAMJbU4OZOQLqqs8ZZVJPf4vGV79q6/eWwqiH/hp2O8ewiDujkFi700YoFAHA4v
         VNaW1KDxIhxptPO0lubHVMHQ8uiSz1qAsw9u7Cbxd/FiF4FHewfwntqOwHc4RS45LE96
         xlokG+DLE9W+Et79/B3aAX303m+4xwXClrR96TuJM6WYMTas15BDIaBIzH7Gg/S2thhH
         EyD7KScGkQYOXzCancaVL2EHAxDXF/YO3UBUPwGqQoYWN8ljBPdP6oEkcEiv8QRhTwmF
         PnADdJ957K/PyKh/qGp5WRuZ+ZHXEW4NbQ9FhnL+yKS3g+RKsxidWo012ocSKex18Jmd
         0O4A==
X-Gm-Message-State: AJcUukdD6lLI2hHD3CCctXGFctV78c/r3ls9I6Df+NrmTE6frYN4E+eR
        oZZlINaFNwfZaAmQ8JIngoE=
X-Google-Smtp-Source: ALg8bN6JOizKorLjbo/cl1ZdqFRkx1EXAE8oSyeU49GocGkLwzewed/TO4gnZl4wLPzv4QyTbTFkag==
X-Received: by 2002:a63:db48:: with SMTP id x8mr4846719pgi.365.1547577923743;
        Tue, 15 Jan 2019 10:45:23 -0800 (PST)
Received: from himanshu-Vostro-3559 ([103.233.116.134])
        by smtp.gmail.com with ESMTPSA id m11sm4178876pgh.51.2019.01.15.10.45.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 10:45:22 -0800 (PST)
Date:   Wed, 16 Jan 2019 00:15:15 +0530
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     Sebastien Bourdelin <sebastien.bourdelin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org, pmeerw@pmeerw.net, lars@metafoo.de,
        knaack.h@gmx.de, jic23@kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: iio: chemical: Add bindings for
 bme680
Message-ID: <20190115184515.GB10186@himanshu-Vostro-3559>
References: <20190114201914.24572-1-sebastien.bourdelin@gmail.com>
 <20190114201914.24572-2-sebastien.bourdelin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114201914.24572-2-sebastien.bourdelin@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 03:19:14PM -0500, Sebastien Bourdelin wrote:
> BME680 is a pressure/temperature/humidity/voc sensor.
> 
> Signed-off-by: Sebastien Bourdelin <sebastien.bourdelin@gmail.com>
> ---
> v2 -> v3:
>   - change i2c address to 0x76 as it seems more reliable: Suggested by Himanshu Jha <himanshujha199640@gmail.com>
>   - rebase on master
> ---
>  .../devicetree/bindings/iio/chemical/bme680.txt       | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/chemical/bme680.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/chemical/bme680.txt b/Documentation/devicetree/bindings/iio/chemical/bme680.txt
> new file mode 100644
> index 000000000000..7f3827cfb2ff
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/chemical/bme680.txt
> @@ -0,0 +1,11 @@
> +Bosch Sensortec BME680 pressure/temperature/humidity/voc sensors
> +
> +Required properties:
> +- compatible: must be "bosch,bme680"
> +
> +Example:
> +
> +bme680@76 {
> +          compatible = "bosch,bme680";
> +          reg = <0x76>;
> +};

Thanks,

	Acked-by: Himanshu Jha <himanshujha199640@gmail.com>

-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
