Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437EEC2F421
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11A3920870
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548085569;
	bh=Gyl+Fze3OBARskjAUZXONNCtDc+KqG9ieGinQCfmFAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Mnpb7cHUuV6fzCUaR+8DQ6L1EJNXdlPfgTyfNmHDkal75tU5ND5O6tPhyBQt/y8PK
	 fY9T6cnztiVHtS2NfCh5fU90BLQbfCIZnst4Sbnn7IFrywgaV9oWKpeNhR7XaYkVcd
	 Gwqe9p5UzACj+OnXXZ/VhkTjtJsiJ4YeyXMasOLM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730564AbfAUPqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 10:46:07 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35313 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729851AbfAUPqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 10:46:06 -0500
Received: by mail-oi1-f195.google.com with SMTP id v6so14889697oif.2;
        Mon, 21 Jan 2019 07:46:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ha4x6ul4D1MkN/u9NGKVHR88B0fKxkfsJVzB1Wl7ytc=;
        b=oMFxVzUboJYivO2Sqws2+A1b7y060HIfwGOkpWiK5nk1+J8kWepf6PK547+SJsnjCL
         eBklIdwpxO1eLkgsvZC27xoQi5DLJ2LEAuBCpHqEDNWnHDVuk1tJY8An21GzCBCPwxJk
         O413vmdll2v8nIKhORLnLPoDIigaCkfqDe2vC76iHSwxvUEwckPAJSUeD5P8D3ju8pKn
         2YFnDTaxTWZfT5u78MBCXGIMf4yhaxP7J5RxnYT7esBamyFutitk6oZipRDts8AvqR6f
         LGzcto+YAnj/FMPQV5B0Xz6lZsZCS1g8JLaoUdhL8YGoD5TUh9/UkC1UtAPPTmDHk1ZO
         2SLw==
X-Gm-Message-State: AJcUukc8vIG9go0PENg3eGtYd4nRziA9m3q/Vm0I4DLqi9IjNA7txdGm
        Od84aFLJWgBm5z3VRvDXBQ==
X-Google-Smtp-Source: ALg8bN5v1cWPqknWj916R9twcYnGsRfn95vwAPSo41mss88VjKmQqC9Ng8VbLOBSRJ8Z4kftiroMUQ==
X-Received: by 2002:aca:a11:: with SMTP id 17mr5734647oik.15.1548085565792;
        Mon, 21 Jan 2019 07:46:05 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n130sm6198661oif.10.2019.01.21.07.46.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 07:46:05 -0800 (PST)
Date:   Mon, 21 Jan 2019 09:46:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     mark.rutland@arm.com, michals@xilinx.com, RAJANV@xilinx.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, JOLLYS@xilinx.com,
        chinnikishore369@gmail.com, robh+dt@kernel.org,
        Nava kishore Manne <nava.manne@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>
Subject: Re: [PATCH v3 3/6] dt-bindings: reset: Add bindings for ZynqMP reset
 driver
Message-ID: <20190121154604.GA30149@bogus>
References: <20190121173835.21173-1-nava.manne@xilinx.com>
 <20190121173835.21173-4-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121173835.21173-4-nava.manne@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2019 23:08:32 +0530, Nava kishore Manne wrote:
> Add documentation to describe Xilinx ZynqMP reset driver
> bindings.
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> Signed-off-by: Jolly Shah <jollys@xilinx.com>
> ---
> Changes for v3:
> 		-Moved reset outputs definitions info into
> 		 a header file(xlnx-zynqmp-resets.h).
> 
>  .../bindings/reset/xlnx,zynqmp-reset.txt      |  52 +++++++
>  .../dt-bindings/reset/xlnx-zynqmp-resets.h    | 130 ++++++++++++++++++
>  2 files changed, 182 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt
>  create mode 100644 include/dt-bindings/reset/xlnx-zynqmp-resets.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
