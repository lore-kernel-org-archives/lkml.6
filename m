Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F13C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CCE820827
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:07:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CCE820827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730724AbeKGEea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 23:34:30 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34543 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730511AbeKGEe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 23:34:29 -0500
Received: by mail-pf1-f193.google.com with SMTP id y18-v6so4150752pfn.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 11:07:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZOPVA8zFxyK+6MVWH3nLDhrgWskDUoQalnpwOfFk3AU=;
        b=pwOJDVSazCegSupUGStDOkvVZkeZQ+12soZP5MfO0tgbvcqG44XrkVABEgQCrvBkNc
         1i8LjZ4LAVkiaiW2Q4js0dHaW40cpgsSUw1XitVGzk3wnzn4cBq21ZRDGyH8mb4VzCaM
         BRPUGbAkO21qbHevHqOKTtSXBab0F5XcffB0BAQW9fJiUgXzMDXgdzskKDDS/jnkAOha
         2glhPbr7skLzgaW139+LpGQziYGeJk3kDZxI2/LTdyoSK9gvLA4FkRRy02bbzghJybrl
         FmWYhw7w43JL7LMppWeaACxZVcScQRr+561puJTIrnbIPPmSo89b8KCJWlZtz4S/aXE0
         ImAg==
X-Gm-Message-State: AGRZ1gKaQg8LjrAqeGzKqIV5zveqrNh74VfLSQcpfHVQNL69r1UYASNa
        FIUl5w6OznrrnZNii8E3eh7pWA==
X-Google-Smtp-Source: AJdET5fM5sDJgsuob/XDerJ9Kfr762VoB2NvOIox+0aZVi9VDqaccpzJ93a2YBLj7hHncbqGryyJYw==
X-Received: by 2002:a63:df13:: with SMTP id u19mr5050865pgg.294.1541531269616;
        Tue, 06 Nov 2018 11:07:49 -0800 (PST)
Received: from localhost ([207.114.172.147])
        by smtp.gmail.com with ESMTPSA id g72-v6sm62414597pfd.181.2018.11.06.11.07.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 11:07:48 -0800 (PST)
Date:   Tue, 6 Nov 2018 11:07:47 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     richard.gong@linux.intel.com
Cc:     gregkh@linuxfoundation.org, catalin.marinas@arm.com,
        will.deacon@arm.com, dinguyen@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, atull@kernel.org, mdf@kernel.org,
        arnd@arndb.de, corbet@lwn.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, todd.riffel@intel.com,
        richard.gong@intel.com
Subject: Re: [PATCHv10 4/8] dt-bindings: fpga: add Stratix10 SoC FPGA manager
 binding
Message-ID: <20181106190747.GA5690@archbook>
References: <1541523172-5171-1-git-send-email-richard.gong@linux.intel.com>
 <1541523172-5171-5-git-send-email-richard.gong@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541523172-5171-5-git-send-email-richard.gong@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

On Tue, Nov 06, 2018 at 10:52:48AM -0600, richard.gong@linux.intel.com wrote:
> From: Alan Tull <atull@kernel.org>
> 
> Add a Device Tree binding for the Intel Stratix10 SoC FPGA manager.
> 
> Signed-off-by: Alan Tull <atull@kernel.org>
> Signed-off-by: Richard Gong <richard.gong@intel.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
> ---
> v2: this patch is added in patch set version 2
> v3: change to put fpga_mgr node under firmware/svc node
> v4: s/fpga-mgr@0/fpga-mgr/ to remove unit_address
>     add Richard's signed-off-by
> v5: add Reviewed-by Rob Herring
> v6: no change
> v7: no change
> v8: no change
> v9: no change
> v10: no change
> ---
>  .../bindings/fpga/intel-stratix10-soc-fpga-mgr.txt      | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt
> 
> diff --git a/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt b/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt
> new file mode 100644
> index 0000000..6e03f79
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt
> @@ -0,0 +1,17 @@
> +Intel Stratix10 SoC FPGA Manager
> +
> +Required properties:
> +The fpga_mgr node has the following mandatory property, must be located under
> +firmware/svc node.
> +
> +- compatible : should contain "intel,stratix10-soc-fpga-mgr"
> +
> +Example:
> +
> +	firmware {
> +		svc {
> +			fpga_mgr: fpga-mgr {
> +				compatible = "intel,stratix10-soc-fpga-mgr";
> +			};
> +		};
> +	};
> -- 
> 2.7.4
> 
Thanks,
Moritz
