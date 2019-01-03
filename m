Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA71C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A883A2184B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546543393;
	bh=9fuiE71CnIetHavAkmTxkUmfId+EMcOpCFsQ7MDkh8Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0juRn5VMvkwJpRrAaCD5ujofO3Czefko8hxPoOtNjUdVwuBLXJAJywKpDTiP8hfKt
	 0Fdo1yK0xSx/3sK0zVQPPcehLwUHm7EhrfSwTA92tn+ZaMefKT/T/Ho22DQKAcsf9M
	 ySBPA/NOrI851HDfBI/1iLz/k4aLt6uPPVbQc9xQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfACTXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 14:23:12 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:33597 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfACTXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 14:23:11 -0500
Received: by mail-io1-f65.google.com with SMTP id t24so27858022ioi.0;
        Thu, 03 Jan 2019 11:23:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hKMN0hpq+/jcMTDWf2h/27DjjkDxdUwdk8lzBZytIUw=;
        b=n0TOBG2fQ50kx/XYdyadF5+6DdulpCUApFSlykUK6X2GRQhj0spZeRPxeqc07WhJo9
         3pgB6GGVgOWWmiaXIVgS6FBDr0UNS/mZvNJOknW5Ch4SPTdVBT5s+4izuaJzp24UhQyf
         WuzbI/RPQSEYIzfL6wQN7mnciJivoE1Shq7zzEmYSfHdtYjcLYCedwDRgb5WYiiaQ1tF
         GS8usdGEMq9RfqXyKZEVmhtGQtYbC62Qk3F+4RnGJbrtVHupYogIFOWUcJucnWDsEL2M
         TXCd/9DPadXCe/dzdsJEamXT8NRRvkQcfZV4guLUcLn/Plq6eq6JX5wEqr6igEaZmSKp
         sl4w==
X-Gm-Message-State: AJcUukcSQCkpeIBPWt0QcdpqXX6vJ9FVFWNykgRNkjNhuqi1dXeq6+Hx
        9TMv2qzMabPLqhzYlxlpu6XVsO4=
X-Google-Smtp-Source: ALg8bN6BttsupZdvN37T3bb/h0KSkrF5elEJYocxKlK0oVXXXNr3JhXqksYU4Z6Pzs0W8HnugDLC5g==
X-Received: by 2002:a5e:860a:: with SMTP id z10mr31702177ioj.35.1546543390492;
        Thu, 03 Jan 2019 11:23:10 -0800 (PST)
Received: from localhost ([24.51.61.172])
        by smtp.gmail.com with ESMTPSA id 196sm22186871itu.33.2019.01.03.11.23.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Jan 2019 11:23:09 -0800 (PST)
Date:   Thu, 3 Jan 2019 13:23:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     qii wang <qii.wang@mediatek.com>
Cc:     wsa@the-dreams.de, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        srv_heupstream@mediatek.com, leilk.liu@mediatek.com,
        qii.wang@mediatek.com, ryder.lee@mediatek.com
Subject: Re: [PATCH 5/6] dt-bindings: i2c: Add Mediatek MT8183 i2c binding
Message-ID: <20190103192309.GA18564@bogus>
References: <1545397111-24183-1-git-send-email-qii.wang@mediatek.com>
 <1545397111-24183-6-git-send-email-qii.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545397111-24183-6-git-send-email-qii.wang@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Dec 2018 20:58:30 +0800, qii wang wrote:
> Add MT8183 i2c binding to binding file. Compare to 2712 i2c
> controller, MT8183 has different registers, offsets, clock,
> and multi-user function.
> 
> Signed-off-by: qii wang <qii.wang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-mtk.txt |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
