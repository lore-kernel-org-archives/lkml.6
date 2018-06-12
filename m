Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id BF72BC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FA3C2084E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:24:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FA3C2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934906AbeFLWYa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 18:24:30 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:44841 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934418AbeFLWY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 18:24:28 -0400
Received: by mail-pf0-f194.google.com with SMTP id h12-v6so256990pfk.11;
        Tue, 12 Jun 2018 15:24:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J9IvU1cX1LPBQyS4HNvbWY1dc6IN6lPqYJsKAqWSv+4=;
        b=MlpXfIq+zWwjZHbnUDdz/Opyh706l3t8ksNjNRjmQ9bEj4Ef/VzyCZdHaLhR370E1h
         JunvB7yCo4tPyQMf7qOPY6bKTnw8q3Y49rebXQnhfxUYLisBiIykvrClT9t1tm+/m5q8
         lWEABb+yF05aLy1aFsGegA1ZtC/R3+0jISOdSW5FymFVRU7HpIsQwzg/qCeyVvUXlet9
         flx+JLN79eKK86+VR141zQWO/zhDkRhdUFa6MzLamxUKIs6jjS8iIgKa/9ffXYPpqc+d
         zkPGGo8oSp2Q7SYn1W+jWe9PwLtlJIWFMo4AYn3euIhOwzmdIW5h7iCCAD2n7NacVmiK
         HOxA==
X-Gm-Message-State: APt69E36v/wlLcbVPzz9q5qvVFtLurUZcmFQDNIz31rhAYXBDMqrZM/E
        TxlnsgB3j554u2AHL+b4MA==
X-Google-Smtp-Source: ADUXVKKw/kgMcb9uEw33ozCvkfkt43vl+oiIIbms0Mxdyl71WZIv+fUJKHV+hH0J0087r2+Ig1auEQ==
X-Received: by 2002:a63:7211:: with SMTP id n17-v6mr1815539pgc.94.1528842267392;
        Tue, 12 Jun 2018 15:24:27 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id v26-v6sm1308471pfe.13.2018.06.12.15.24.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 15:24:26 -0700 (PDT)
Date:   Tue, 12 Jun 2018 16:24:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Songjun Wu <songjun.wu@linux.intel.com>
Cc:     hua.ma@linux.intel.com, yixin.zhu@linux.intel.com,
        chuanhua.lei@intel.com, linux-mips@linux-mips.org,
        qi-ming.wu@intel.com, linux-clk@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 1/7] MIPS: dts: Add aliases node for lantiq danube serial
Message-ID: <20180612222424.GA2197@rob-hp-laptop>
References: <20180612054034.4969-1-songjun.wu@linux.intel.com>
 <20180612054034.4969-2-songjun.wu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612054034.4969-2-songjun.wu@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 01:40:28PM +0800, Songjun Wu wrote:
> Previous implementation uses a hard-coded register value to check if
> the current serial entity is the console entity.
> Now the lantiq serial driver uses the aliases for the index of the
> serial port.
> The lantiq danube serial dts are updated with aliases to support this.
> 
> Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
> ---
> 
>  arch/mips/boot/dts/lantiq/danube.dtsi | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/mips/boot/dts/lantiq/danube.dtsi b/arch/mips/boot/dts/lantiq/danube.dtsi
> index 2dd950181f8a..7a9e15da6bd0 100644
> --- a/arch/mips/boot/dts/lantiq/danube.dtsi
> +++ b/arch/mips/boot/dts/lantiq/danube.dtsi
> @@ -4,6 +4,10 @@
>  	#size-cells = <1>;
>  	compatible = "lantiq,xway", "lantiq,danube";
>  
> +	aliases {
> +		serial0 = &asc1;
> +	};
> +
>  	cpus {
>  		cpu@0 {
>  			compatible = "mips,mips24Kc";
> @@ -74,7 +78,7 @@
>  			reg = <0xE100A00 0x100>;
>  		};
>  
> -		serial@E100C00 {
> +		asc1: serial@E100C00 {

Fix this to be lower case hex while you are at it.

>  			compatible = "lantiq,asc";
>  			reg = <0xE100C00 0x400>;
>  			interrupt-parent = <&icu0>;
> -- 
> 2.11.0
> 
