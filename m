Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9035C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 19:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F7AA20834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 19:15:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F7AA20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbeJZDtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 23:49:12 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34335 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbeJZDtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 23:49:12 -0400
Received: by mail-ot1-f65.google.com with SMTP id r10so4849919otk.1;
        Thu, 25 Oct 2018 12:15:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0eDm40MVu11j9+TdfdsMlinDWeBwx1ao6Alg6UQanR4=;
        b=ZA5Yd0Bm304sURvCUAlsfieNfVM39cVIG0oCwRiE3HGI6wTdwvff2Z1RvodjdJrHpe
         xU0EVmHqTWBQHaLRSu+C4GI30xTacEMduf+TKXmwpZIRHUzm7RFLbKTURZVwB3H4ygep
         H5TiiH8I9zc08GFQ4wQ3XGwk3jqDkVmVpsdI3eDwBrEKdE0Ak+rdJrTrMJ7FQ7yYnKmV
         3Pz5iktXEcWm/4iErDaoRwtOfkdSrTw6NdvBouxe/DDkvzt+CS9VtZVJGwKcLOezzX0q
         ZhnlGy8208smTx87lUPAsbn+jnw65MPunxQn1V6ov9z9CBuJdeeq92U0RzcDnQ+Cw9Ol
         o8NQ==
X-Gm-Message-State: AGRZ1gJ2ApqhVsXkBaoUi6GmjapLufgwPvXJKVPeJK1f6oLwuCQ6gHo2
        q0JU92Vi8yZkbo8QlvLDKw==
X-Google-Smtp-Source: AJdET5ddj5qH66M6XDbcQbaopkmfvMP969k1xVJZdlCl20X4CZysv2KWGyWw568gLE4dc07ToLyxRA==
X-Received: by 2002:a9d:5a6:: with SMTP id 35mr301172otd.221.1540494909937;
        Thu, 25 Oct 2018 12:15:09 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a68-v6sm1964896oih.19.2018.10.25.12.15.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 12:15:09 -0700 (PDT)
Date:   Thu, 25 Oct 2018 14:15:08 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     srinivas.kandagatla@linaro.org, mark.rutland@arm.com,
        michal.simek@xilinx.com, jollys@xilinx.com, rajanv@xilinx.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: nvmem: Add bindings for ZynqMP nvmem
 driver
Message-ID: <20181025191508.GA26613@bogus>
References: <20181020083603.27602-1-nava.manne@xilinx.com>
 <20181020083603.27602-3-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181020083603.27602-3-nava.manne@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 20, 2018 at 02:06:02PM +0530, Nava kishore Manne wrote:
> Add documentation to describe Xilinx ZynqMP nvmem driver
> bindings.
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
> Changes for v1:
> 		Created a Seperate(New) DT binding file as
> 		suggested by Rob.
> 
> Changes for RFC-V3:
>                 -None.
> 
> Changes for RFC-V2:
>                 -Moved nvmem_firmware node as a child to
>                  firwmare node.
> 
>  .../bindings/nvmem/xlnx,zynqmp-nvmem.txt           | 37 ++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt

Before I okay any ZynqMP firmware related bindings, I want to see a 
complete binding, not things added one by one.

Rob
