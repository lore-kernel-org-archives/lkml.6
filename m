Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70ECFECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20E3220652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:44:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20E3220652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388258AbeGTSdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 14:33:33 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:55012 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388131AbeGTSdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 14:33:33 -0400
Received: by mail-it0-f66.google.com with SMTP id s7-v6so15731378itb.4;
        Fri, 20 Jul 2018 10:44:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3qjaxhZiPqXgoHeEQv3WSR4yjT2pCyKRuB4foDYEB2I=;
        b=BkJplodzp85V3c03BlNfRi3JiBMhSbyhH/B8RASD7MiRxL3HO86WATwcsu/sd7XABB
         ysqYtJm8KoqACioP/I4NUmSNODnwbaVcXFph6th4OH0Wpx2liHjqflc025tYypJVepCg
         cOagDnfLlDYZUV1VMHDjaDZfe+aO6XVlGVHNN1AEtYo07SONSGeJrKGVwDjWF9Y1xgrQ
         qt+Wkno4uGvW63Y98R9eYoygAhd6M0FEiQyH2v5BKRzIcO+iSWbA9ChTBDEUnSURvYiZ
         hDcE7edD7flpY+fKZyxbEDscWQNvMVdhArJZbtXEbZkOkhgJp0m9a7ihBzJUlZSwkpOq
         96yw==
X-Gm-Message-State: AOUpUlEenmOYApFbm9bQJ2S8kBRmWe3W69HPNuBtsc1NUZ1BTWE1UqHq
        x7ne1DGkTr6vu8IkKRQYEPCPg2VXzg==
X-Google-Smtp-Source: AAOMgpcklknfWRQCj9v8svjnaFK8B308I9ZANiStnmMK2OqUJQZL9r4HoxSM+Gy+JxU+VmEi1cR9tg==
X-Received: by 2002:a24:54c3:: with SMTP id t186-v6mr2762454ita.55.1532108654200;
        Fri, 20 Jul 2018 10:44:14 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id k71-v6sm1614325itk.2.2018.07.20.10.44.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 10:44:13 -0700 (PDT)
Date:   Fri, 20 Jul 2018 11:44:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mars Cheng <mars.cheng@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, wsd_upstream@mediatek.com,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, Owen Chen <owen.chen@mediatek.com>
Subject: Re: [PATCH v5 02/11] dt-bindings: mediatek: Add smi dts binding for
 Mediatek MT6765 SoC
Message-ID: <20180720174413.GA31579@rob-hp-laptop>
References: <1531817552-17221-1-git-send-email-mars.cheng@mediatek.com>
 <1531817552-17221-3-git-send-email-mars.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531817552-17221-3-git-send-email-mars.cheng@mediatek.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 04:52:23PM +0800, Mars Cheng wrote:
> This patch adds MT6765 smi binding document
> 
> Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
> Signed-off-by: Owen Chen <owen.chen@mediatek.com>
> ---
>  .../memory-controllers/mediatek,smi-common.txt     |    1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
