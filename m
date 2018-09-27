Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39563C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01F2F216C4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:21:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01F2F216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbeI1Bkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 21:40:53 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35242 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727995AbeI1Bkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 21:40:53 -0400
Received: by mail-ot1-f67.google.com with SMTP id j9-v6so3716859otl.2;
        Thu, 27 Sep 2018 12:21:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+aJ3HuTZll2adN0Q4hVjhLUiA4OJPiHGHL6ZQq5o9No=;
        b=Hn5ZC9aImyVGGJy9yojPO5DnyJ2xBa1i2VP80uk2zes0hBUyq7v48VS1YGnCIE9Uou
         znD+C5LHq0fD6FTvINqLIpVkRG15dKc/VSrD83nrDYtz8Pu4CXCfH9I7m9cYdTGr0qFL
         y4GhufTF//dtZUGxjGIYx4kDxZoI/f0ZS/vzMKup9PIjv8TzV6lDNFAAXgnRIbMuPs8M
         pLOQNfDVfvHwLFOatCOIaG9aomM0u6KcdqZwNRcPyqKErPSvg6SrQ7+9Hh0SvLiul273
         tQF+56rM35kn0KgcwWz3nHQgEHuZsBjVm6j22t2saUC3U/0Wr5K4tmFdRNF5P4jScEid
         ZJlg==
X-Gm-Message-State: ABuFfogzbETRmobeWJniHZNI3gHp4NYkhZW2HXVdU4FhSkwlCxN5aQtW
        cX2x5jLB2jNQwOsF2T8l0A+F066cT0tF
X-Google-Smtp-Source: ACcGV612hchqza3zVTaFFqXL+7mOeu751h4ESGcKXkOBjIHt2OYNkRP4Pb5MtbfEDqH0z2UICdvXBQ==
X-Received: by 2002:a9d:7281:: with SMTP id t1-v6mr8140323otj.345.1538076065510;
        Thu, 27 Sep 2018 12:21:05 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z33-v6sm1094613otz.71.2018.09.27.12.21.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 12:21:04 -0700 (PDT)
Date:   Thu, 27 Sep 2018 14:21:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     mark.rutland@arm.com, michal.simek@xilinx.com,
        srinivas.kandagatla@linaro.org, jollys@xilinx.com,
        rajanv@xilinx.com, sboyd@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3 2/3] dt-bindings: fpga: Add bindings for ZynqMP
 nvmem driver
Message-ID: <20180927192104.GA7898@bogus>
References: <20180922134149.5693-1-nava.manne@xilinx.com>
 <20180922134149.5693-3-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180922134149.5693-3-nava.manne@xilinx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 22, 2018 at 07:11:48PM +0530, Nava kishore Manne wrote:
> Add documentation to describe Xilinx ZynqMP nvmem driver
> bindings.
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
> Changes for v3:
> 		-None.
> Changes for v2:
>                 -Moved nvmem_firmware node as a child to
>                  firwmare node.
> 
>  .../firmware/xilinx/xlnx,zynqmp-firmware.txt  | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)

There are various components of the zynqmp firmware bindings being sent 
separately. I cannot review it piece by piece. So please the firmware 
bindings as a complete set. Really, I mainly need to see a complete 
example.

Rob
