Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE44C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8303B20855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G3U5Rvpb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfAQXGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 18:06:08 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:43657 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbfAQXGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 18:06:07 -0500
Received: by mail-vk1-f196.google.com with SMTP id o130so2662158vke.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 15:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3++QwggVgt/M6drKQrvAWQ5dHnTM4nGc4kIVQQRcQrs=;
        b=G3U5RvpbT+N58/j5KZ70qc/ifYN+WC2vsj2HsKkTl9N4rrZrQBN9tEZ7eXGbLfCeAZ
         rUs0PbINWRSToOs4mc1D61Ieyd6VCcJB+TfzrVW9tnipxl/8wFhY8ER2vI5oB6TyUUqF
         d7VZszNcvMckawHjrZVZhTACb78PnkUGxJ2wI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3++QwggVgt/M6drKQrvAWQ5dHnTM4nGc4kIVQQRcQrs=;
        b=RHIiXtF9zDHAEEfFn3giSEF5M/DzRmRHFHj9UbpzNFHbS4V/Ky2cU+hsXDngwZWEH/
         523Vw+qi8a2+foT4VDdN+6ybcmfggYUovhyHfQ7tGHWF+yh73/td22D+KgBFHOVmi1GC
         SlnLGAiE01DMOYSb2FLN8DQO7cAx84Wuy9r/9hmc3P3BIXvV1snzh74m04TQGgKxAm1e
         qzbj8CI0qh2Dp/NN8tKhtYN2fioQr91tH/7BxDv8h+nyVxBF9SB42z7meoGd/Qo4lN9w
         8OKElvBv2zBz2u1V9JE3hpmKbBVQ7AntIMnegMceFYGOwf3nyS5cUgGs2KVoy+wi2eYS
         mz6g==
X-Gm-Message-State: AJcUukeHf+2XX+i3STOQRoc+y/9rKX/F1ZmwuLqXBIEZ7ObeuB/jZGfe
        biFTd98nCKNRX0vz8JVtEJG6LMs8ig8=
X-Google-Smtp-Source: ALg8bN6lmSJODbsj+v1OlPr6THnwE611BjGBbBLJbY7pBnWqLNcGjRvrSA8W+Ef+XlmEkcrCHQykOw==
X-Received: by 2002:a1f:e807:: with SMTP id f7mr6217663vkh.16.1547766366120;
        Thu, 17 Jan 2019 15:06:06 -0800 (PST)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com. [209.85.221.180])
        by smtp.gmail.com with ESMTPSA id y195sm49463821vkd.0.2019.01.17.15.06.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 15:06:04 -0800 (PST)
Received: by mail-vk1-f180.google.com with SMTP id y14so2658860vky.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 15:06:03 -0800 (PST)
X-Received: by 2002:a1f:bfd6:: with SMTP id p205mr5222098vkf.70.1547766363362;
 Thu, 17 Jan 2019 15:06:03 -0800 (PST)
MIME-Version: 1.0
References: <20190114192201.23779-1-sibis@codeaurora.org>
In-Reply-To: <20190114192201.23779-1-sibis@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 17 Jan 2019 15:05:51 -0800
X-Gmail-Original-Message-ID: <CAD=FV=V2XoaDVy9hnh-S=jbzU-Di0KoD7gM2CxpZm3646k9ZjA@mail.gmail.com>
Message-ID: <CAD=FV=V2XoaDVy9hnh-S=jbzU-Di0KoD7gM2CxpZm3646k9ZjA@mail.gmail.com>
Subject: Re: [PATCH v6] arm64: dts: qcom: sdm845: Add Q6V5 MSS node
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        tsoni@codeaurora.org, clew@codeaurora.org, akdwived@codeaurora.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-remoteproc@vger.kernel.org,
        Evan Green <evgreen@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        sricharan@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jan 14, 2019 at 11:22 AM Sibi Sankar <sibis@codeaurora.org> wrote:
> +               mss_pil: remoteproc@4080000 {
> +                       compatible = "qcom,sdm845-mss-pil";
> +                       reg = <0x04080000 0x408>, <0x04180000 0x48>;

This will now need to be adjusted to:

reg = <0 0x04080000 0 0x408>, <0 0x04180000 0 0x48>;

This fixes things up to deal with the patch ("arm64: dts: qcom:
sdm845: Increase address and size cells for soc"), AKA:
- https://patchwork.kernel.org/patch/10767511/
- https://lkml.kernel.org/r/20190117042940.25487-2-bjorn.andersson@linaro.org


-Doug
