Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0ADECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 17:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A50820831
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 17:42:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A50820831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbeJYCK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 22:10:58 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46774 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbeJYCK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 22:10:58 -0400
Received: by mail-oi1-f193.google.com with SMTP id k64-v6so4773376oia.13;
        Wed, 24 Oct 2018 10:42:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eGDB/rIcwVbISMoDkLNQXIw2+BVUx909x8SiePfhKIs=;
        b=SrKCyjYBBflPA+HCWNEnwIMVsdrs9tUfACzh5tYmVE8mg12w1smCmAElhLibbxXr/R
         PDFt5vmVLyBbTUyMY79A+NPtKmlgktTEijtiYGrrindAMtARINQ+ilT41kZ/lNKESSrj
         u4vj7643DjXPnXCxLzSJp01GhR+xmFIfEvYweUqy+ZlhvzwiO7pmnQEM8p6hiHlYW3q7
         8UMjAOD0DxFXje3h2+/62mBkgJszH+NLH/lctaXh3VSrneowcuLBtZEEGT61letZevWF
         67ZaUiZq+oN6uuz7utcaeODXrtWKr6pk+tWFjeSr2rUm4v8YIcPv6k+nQhqYL7yUzcuP
         2XdA==
X-Gm-Message-State: AGRZ1gLs3OR+RXjS9cfC0YsQK5hwKfeqDLExhLJ79fH90b4y6RiSE6cK
        I7etZs7icjW2YkeeHkSm5g==
X-Google-Smtp-Source: AJdET5eJ/fwkJ7J3X8o6Bn6lHLFSZ6kb5Z/gLjsLCMaLBlqDYyNVXZl71XpoxgOmOHVyQfk59pqZqQ==
X-Received: by 2002:aca:fc04:: with SMTP id a4-v6mr2000938oii.288.1540402919824;
        Wed, 24 Oct 2018 10:41:59 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y57sm2047312oti.15.2018.10.24.10.41.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 10:41:59 -0700 (PDT)
Date:   Wed, 24 Oct 2018 12:41:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     Luis Oliveira <luis.oliveira@synopsys.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        joao.pinto@synopsys.com, festevam@gmail.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Keiichi Watanabe <keiichiw@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Todor Tomov <todor.tomov@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [V3, 3/4] Documentation: dt-bindings: media: Document bindings
 for DW MIPI CSI-2 Host
Message-ID: <20181024174158.GB2902@bogus>
References: <1539953556-35762-1-git-send-email-lolivei@synopsys.com>
 <1539953556-35762-4-git-send-email-lolivei@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539953556-35762-4-git-send-email-lolivei@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 02:52:25PM +0200, Luis Oliveira wrote:
> Add bindings for Synopsys DesignWare MIPI CSI-2 host.

Also, drop "Documentation: " from the subject. All bindings are 
documentation and the preferred prefix is 'dt-bindings: <binding dir>: '.

> 
> Signed-off-by: Luis Oliveira <lolivei@synopsys.com>
> ---
> Changelog
> v2-V3
> - removed IPI settings
> 
>  .../devicetree/bindings/media/snps,dw-csi-plat.txt | 52 ++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/snps,dw-csi-plat.txt
