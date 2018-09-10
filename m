Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D25BC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 18:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0EA420854
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 18:16:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0EA420854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbeIJXLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 19:11:32 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35407 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbeIJXLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 19:11:32 -0400
Received: by mail-oi0-f66.google.com with SMTP id m11-v6so42058187oic.2;
        Mon, 10 Sep 2018 11:16:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DOtMaM82IZTVqmXs3l1GX72EOchfCwYYWv9WfsnCDJY=;
        b=mQsAUZbqfB1Ecu5ACyi0c3ZYow+vHkQcMH/tRZmJYN2vKiIaxlUqB1KzAGqDB5788Z
         bCaoojiP46vTaZIG1ktyJwnaTNIEPKv19RSyim4lmiuH8spbidOAHyX/hcf8e57ORSEb
         LehRHE2Rutphu2EPB9DQrfcTbHbk2qOjJbrEw3eHUVWJlCoglrCaNxDwgLgW02cRfV60
         W1d0XuPS8F8D1phr2GHcgvlvK83NJjNlDaIUw3dcHJKMGuKVrlj9Bn1ciPe/1tjGtklw
         hHpZEeGN9c0mfboH1qaTec5BlUWjE9q4h4xGXv90JrUZWoTvO1hI7t35jaSyKIHJUOZL
         YS3g==
X-Gm-Message-State: APzg51CuQPKXGVOShBtyTE1HbkBGYjOEEAi3o2oTyB9goxrtuh7qvVIo
        YFNk1uNeg+tyevbA+lKK4Q==
X-Google-Smtp-Source: ANB0VdbCDZw7ooN+GHdDG5yYdDuT0ZrHtHvMVPzbGuQz58y8RfMzX7R9GM1cEsCdZrfHM742WcBlcw==
X-Received: by 2002:aca:cf44:: with SMTP id f65-v6mr24430067oig.356.1536603372478;
        Mon, 10 Sep 2018 11:16:12 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s145-v6sm33180305oih.16.2018.09.10.11.16.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 11:16:10 -0700 (PDT)
Date:   Mon, 10 Sep 2018 13:16:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Eddie James <eajames@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, jdelvare@suse.com,
        linux-doc@vger.kernel.org, openbmc@lists.ozlabs.org,
        gregkh@linuxfoundation.org, mark.rutland@arm.com,
        linux@roeck-us.net, joel@jms.id.au, benh@kernel.crashing.org
Subject: Re: [PATCH v5 01/10] dt-bindings: fsi: Add P9 OCC device
 documentation
Message-ID: <20180910181610.GA5907@bogus>
References: <1535664761-86018-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1535664761-86018-2-git-send-email-eajames@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535664761-86018-2-git-send-email-eajames@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 04:32:32PM -0500, Eddie James wrote:
> Document the bindings for the FSI-attached POWER9 On-Chip Controller.
> 
> Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
> ---
>  Documentation/devicetree/bindings/fsi/ibm,p9-occ.txt | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fsi/ibm,p9-occ.txt
> 
> diff --git a/Documentation/devicetree/bindings/fsi/ibm,p9-occ.txt b/Documentation/devicetree/bindings/fsi/ibm,p9-occ.txt
> new file mode 100644
> index 0000000..46372f6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fsi/ibm,p9-occ.txt
> @@ -0,0 +1,15 @@
> +Device-tree bindings for FSI-attached POWER9 On-Chip Controller (OCC)
> +---------------------------------------------------------------------
> +
> +This is the binding for the P9 On-Chip Controller accessed over FSI from a
> +service processor. See fsi.txt for details on bindings for FSI slave and CFAM
> +nodes.
> +
> +Required properties:
> + - compatible = "ibm,p9-occ"
> +
> +Examples:
> +
> +    occ {

FSI slave devices are supposed to have an address according to the 
binding doc.

> +        compatible = "ibm,p9-occ";
> +    };
> -- 
> 1.8.3.1
> 
