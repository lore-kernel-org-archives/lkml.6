Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4CFECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1452120833
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LomIHWLz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1452120833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbeINWpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 18:45:23 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44851 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727944AbeINWpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 18:45:22 -0400
Received: by mail-pg1-f195.google.com with SMTP id r1-v6so4700032pgp.11;
        Fri, 14 Sep 2018 10:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LYy4U30W9CXaRMDIWIE+0IZC6vFUBA6J0Ce531OTL5I=;
        b=LomIHWLzvMSKc0Xf3Ryv3F63sfn2uYmRoa8uD+N6gsGUSyEwPZJ+XmN0Tb3gL1Vggj
         rFbLb5cuvnUrMICN5V8N2eqww7ARl1aA6ukZqh1kWOrNvShH+s/P/kfyVY9d4+CmvW1V
         QNEpbm43ynAQIW7w7Gc8twYBp5EPSN23LFyuYA26sO+BZNIZQVrPb0Dv3iLcXY22TGQG
         IbRMwG4HarvK19XjFV0WxAGAoGFn+55eYumbTd57Nsn4+WokXiUzeDTxe+kYVLiCNbi5
         Ek5+lD1DeYerlW9aSVMZXqFp3Q5kZKFdNpmjobnxvNxZKN/M6w+LWsibTRvUWIVAepyW
         6tFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=LYy4U30W9CXaRMDIWIE+0IZC6vFUBA6J0Ce531OTL5I=;
        b=iLV+ns5vhaNtKjv4kvf9iI3+jqLMkYOCcCq4+8yhJS/h0rJF3H3vtthEnUs9piPLY+
         qwwrZVSHargVfH7lpQ2293lFpx1sMUSvuDf750SKsXPQvFefCJa7kLL0eGNf3c7QR242
         HQ/3BZVYhE6iV+VJf1YP3By6Bi/AmAxuQ73SvPDK9XYGW1lLH17XUyMY7T6kBTgIlIor
         vFHTSuALWzvGYKPHWNT+1JUOCvHJndJ2SrsZozIRmgLim7iaObfjiRARWoqKdb+Jz1C/
         Cm+CH50fnjFOUDvgkfXJNa/auqajQHmw3lwttMll+iz5HPGL3oMeYs9UTMvD2jkdfcWF
         Vg1g==
X-Gm-Message-State: APzg51CNlDHyrfZHLs5vlT/bBkE/16BJyAc4nR1e50cqWRC1oa9K6Dsa
        ivhQLpcC36ptbwF4xkK6kNU=
X-Google-Smtp-Source: ANB0VdYMDc3had1DLpWlv70CQ9pYIY4MJ+oCUiDLKd1wXVrjHK+tXbqolIfZ/MGWv2Wv2MiCjx3p2Q==
X-Received: by 2002:a63:e0e:: with SMTP id d14-v6mr11096274pgl.38.1536946194493;
        Fri, 14 Sep 2018 10:29:54 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id x82-v6sm14926729pfe.129.2018.09.14.10.29.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 10:29:53 -0700 (PDT)
Date:   Fri, 14 Sep 2018 10:29:53 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Radu Rendec <radu.rendec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dt-bindings: watchdog: add mpc8xxx-wdt support
Message-ID: <20180914172953.GF26861@roeck-us.net>
References: <5edda1a360cf7867b98a72a1dfa22db3bd5ed7b4.1536931725.git.christophe.leroy@c-s.fr>
 <e68ed01cdfba5b7610559607a3c706b294a216fc.1536931725.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e68ed01cdfba5b7610559607a3c706b294a216fc.1536931725.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 01:32:03PM +0000, Christophe Leroy wrote:
> Add description of DT bindings for mpc8xxx-wdt driver which
> handles the CPU watchdog timer on the mpc83xx, mpc86xx and mpc8xx.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  .../devicetree/bindings/watchdog/mpc8xxx-wdt.txt   | 25 ++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/mpc8xxx-wdt.txt
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/mpc8xxx-wdt.txt b/Documentation/devicetree/bindings/watchdog/mpc8xxx-wdt.txt
> new file mode 100644
> index 000000000000..1d99e1e4d306
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/mpc8xxx-wdt.txt
> @@ -0,0 +1,25 @@
> +* Freescale mpc8xxx watchdog driver (For 83xx, 86xx and 8xx)
> +
> +Required properties:
> +- compatible: Shall contain one of the following:
> +	"mpc83xx_wdt" for an mpc83xx
> +	"fsl,mpc8610-wdt" for an mpc86xx
> +	"fsl,mpc823-wdt" for an mpc8xx
> +- reg: base physical address and length of the area hosting the
> +       watchdog registers.
> +		On the 83xx, "Watchdog Timer Registers" area:	<0x200 0x100>
> +		On the 86xx, "Watchdog Timer Registers" area:	<0xe4000 0x100>
> +		On the 8xx, "General System Interface Unit" area: <0x0 0x10>
> +

Note for Rob: The above has been implemented for several years.
This is merely to document the current implementation.
Maybe "mpc83xx_wdt" should be deprecated and replaced, but I think
that should be a separate patch.

> +Optional properties:
> +- reg: additionnal physical address and length (4) of location of the

s/additionnal/additional/

> +       Reset Status Register (called RSTRSCR on the mpc86xx)
> +       		On the 83xx, it is located at offset 0x910
> +       		On the 86xx, it is located at offset 0xe0094
> +       		On the 8xx, it is located at offset 0x288
> +
> +Example:
> +		WDT: watchdog@0 {
> +		    compatible = "fsl,mpc823-wdt";
> +		    reg = <0x0 0x10 0x288 0x4>;
> +		};
> -- 
> 2.13.3
> 
