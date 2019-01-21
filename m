Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C36C2F42E
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3364E2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548084622;
	bh=/9yiyM37lI5mXcvTtShAJOkP4q3xJhnEgtT0ld7eDlE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=D/XfqVtXF8jlFINXgHXlcBSb+CVvKVQHY2RYHhtafx4kWwOSB9JIYeyETYsHip3Y8
	 3ipK3WX2WnIRBkX+tkz20JysfhlYK25dJHuejPUPinJtIgm+l+VWSqovcJNjx4FVOF
	 O4Ri8mDffN6lHLDkqJHv3Y39FLXH2bebDYuNVAag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbfAUPaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 10:30:21 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44220 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728561AbfAUPaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 10:30:19 -0500
Received: by mail-ot1-f65.google.com with SMTP id f18so20812078otl.11;
        Mon, 21 Jan 2019 07:30:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MGZmCsGV4ereTxx/nisevNb6yjZTfhF5rPIoDeCfGdI=;
        b=AnDFg0x2Jn8VdLX2L7aP+eQCFNcU4frXdr8AqthIYUqsriiHexFaYdy+DbCaY/EU6X
         2BeFuhDqdPCC36qK9w6PRJ/n/fmsr79QVwc1lXfcEyh7yhYcfdpFLRcUZFewaIYM+em/
         RYOfulWW+9NcXrHoRGqjSAFN7vCWfyMr8i8r3Avl/m6rN8q3p3amx+zvWnNMBh8/NVoA
         fTKe9CuKZQZ4Av+X72cn7zIvqos5MSWV9z84njVEKj+gGVX7NI9iUOZvdoWj9UemXFmT
         QVQRy477lDc3gLnn46nkL1ryTN8HsQB8lhjwN3MR8lrdnIZBzxmhLBJgkoIa6TpY1WdX
         7aIQ==
X-Gm-Message-State: AJcUukfiAUO9KNVe4SP6SMPwUArKltAX9CXv3gKnBh1Khs+08jk7YHSj
        CzfGd19AG0RSJiZEG4vYlg==
X-Google-Smtp-Source: ALg8bN5tGpExEUlSOrUh6i94VTlkTi1/Rr8LsQL0OnEpbilq7cVPqoMdFFR9aqehARKlbM3Dnnd9BQ==
X-Received: by 2002:a9d:3d24:: with SMTP id a33mr20186193otc.365.1548084618386;
        Mon, 21 Jan 2019 07:30:18 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y25sm5481953otq.60.2019.01.21.07.30.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 07:30:17 -0800 (PST)
Date:   Mon, 21 Jan 2019 09:30:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Erin Lo <erin.lo@mediatek.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:REMOTE PROCESSOR (REMOTEPROC) SUBSYSTEM" 
        <linux-remoteproc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC v3 1/5] dt-bindings: Add a binding for Mediatek SCP
Message-ID: <20190121153017.GA4608@bogus>
References: <20190121071833.43443-1-pihsun@chromium.org>
 <20190121071833.43443-2-pihsun@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121071833.43443-2-pihsun@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2019 15:18:29 +0800, Pi-Hsun Shih wrote:
> From: Erin Lo <erin.lo@mediatek.com>
> 
> Add a DT binding documentation of SCP for the
> MT8183 SoC from Mediatek.
> 
> Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> ---
> Changes from v2:
>  - No change. I realized that for this patch series, there's no need to
>    add anything under the mt8183-scp node (neither the mt8183-rpmsg or
>    the cros-ec-rpmsg) for them to work, since mt8183-rpmsg is added
>    directly as a rproc_subdev by code, and cros-ec-rpmsg is dynamically
>    created by SCP name service.
> 
> Changes from v1:
>  - No change.
> ---
>  .../devicetree/bindings/remoteproc/mtk,scp.txt         | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/mtk,scp.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
