Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B803C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 19:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3325120855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 19:38:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3325120855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbeIKAeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 20:34:16 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:40008 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbeIKAeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 20:34:16 -0400
Received: by mail-oi0-f65.google.com with SMTP id l202-v6so42502655oig.7;
        Mon, 10 Sep 2018 12:38:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0mbkP2cJsDNsm8mcprmYA8Qw3IgaR/ZRHMqWMMWqyUA=;
        b=M1QeUUfUp92zVg+YLgdAEoQoyqo/Wpcyx6kgdWMmqeVhqoCUUANPoOshsisTZt+hm/
         PGNCEnvMhMF3hMpJJgu+7Sb+5ydwBJ+i5lErQ5SOXBHP5L7mrOGAwOtPxZU1BizZt1ig
         mrVXtMPXM2rueCkqGB7aT2FG/0sk0I53d7+7Z3q3XfLoj0B/94HHOwOAmvt5ik0BLiQs
         e4WDjX3kPmec9bpD+XpVCLeIGPOGkXYzjeIh+FxK8ZqUse7W9MumZr3Ho61FF6A2fZs/
         eJR9Lxor49pPhn3uQazbjEEfNIC/hlnoIFpbaittTnLQSxAZtd6ld2dstCWGNgveVuvX
         ekxA==
X-Gm-Message-State: APzg51Bh9nL4YsCssCGdSi5gGSrQ3ZBsmGDQVIeFpzCIA8thnbYnxmwg
        UrPV0I8l6zweZLVEKFnIOw==
X-Google-Smtp-Source: ANB0VdZ2ruWkSK7o/8lb0jw26mZDCFMWuyXny+n1EEC4w6s1+BpBX5mKTkDfLD8hEw4wChfLTNebAQ==
X-Received: by 2002:aca:650d:: with SMTP id m13-v6mr24553338oim.178.1536608318187;
        Mon, 10 Sep 2018 12:38:38 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u21-v6sm18157472oie.22.2018.09.10.12.38.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 12:38:37 -0700 (PDT)
Date:   Mon, 10 Sep 2018 14:38:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hanjie Lin <hanjie.lin@amlogic.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Yue Wang <yue.wang@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        Yixun Lan <yixun.lan@amlogic.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: PCI: meson: add DT bindings for
 Amlogic Meson PCIe controller
Message-ID: <20180910193836.GA21297@bogus>
References: <1535616829-167936-1-git-send-email-hanjie.lin@amlogic.com>
 <1535616829-167936-2-git-send-email-hanjie.lin@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535616829-167936-2-git-send-email-hanjie.lin@amlogic.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2018 16:13:48 +0800, Hanjie Lin wrote:
> From: Yue Wang <yue.wang@amlogic.com>
> 
> The Amlogic Meson PCIe host controller is based on the Synopsys DesignWare
> PCI core. This patch adds documentation for the DT bindings in Meson PCIe
> controller.
> 
> Signed-off-by: Yue Wang <yue.wang@amlogic.com>
> Signed-off-by: Hanjie Lin <hanjie.lin@amlogic.com>
> ---
>  .../devicetree/bindings/pci/amlogic,meson-pcie.txt | 70 ++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
