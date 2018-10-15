Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BDBC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 14:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFAD020652
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 14:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CnvALjWi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFAD020652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbeJOVrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 17:47:17 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40819 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbeJOVrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 17:47:17 -0400
Received: by mail-ot1-f68.google.com with SMTP id w67so18970180ota.7;
        Mon, 15 Oct 2018 07:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bb8P+H4dJaP7OsaLaoqw7yL6kxhvV4jwhSeN0ofkutc=;
        b=CnvALjWi4i6jWH3VHlNIXEzzmWUHqq597Hw+vk5aVHlQzi8/Z7hw6OSBPSpgFlcvBr
         cW9WMv77KiMDYvytWvQWjYpEb1n6SJ2dvvjGoa7fw2N/4siMUTLNkbV1NX63tKvfhZOh
         XfaesngBeZO8J1FDcIsgc7P+d84e41wSgj/Egod1wWbVQGKuIm+zelHw3C5cvdVVD7x5
         f/eOQbC+q7vt/9WowpjiAwiX/jZ6orrRdlYcHBuAsj8so8nwJhO0aT8hE8qfmN9TEh0U
         27phwbpJT+IiCFzAcp4Vc2gP4jQwMTrY8OL4MGqFf/FoXacoGYxHEXldLMzluGwNFZqZ
         tMdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bb8P+H4dJaP7OsaLaoqw7yL6kxhvV4jwhSeN0ofkutc=;
        b=ZH1x5Fhf6oy94KHouY3Lu36JCw1nCNaAFxqBoRK+aoPshk0d6szq1ndOpq6pG99xwV
         9l+JDj4tnRCyzbPoBE4PZdrXjibxwOxQ9Y18vC0qE8+WE4brLt0R135B+d3tOpwF/hF6
         1BwKu/Y3JRa+qzvUl5pohf4X9uIrpajA9eDH6jGxrll1Vdqg1XwBVXt9ul0iGtupesOJ
         EryoN3S/LJCF/YVD4YMbV5Flq5VDHsLUz9jcATyhxbciMTnQZOLZ2j271gP/XK21QVn6
         K5CxAmltt9I0XlVlM8ZiumdgJLMp+k4k5WAHRnjmGmE3YLRaxmikoOstphTJBkIbeopf
         KuzQ==
X-Gm-Message-State: ABuFfogHNwI8BBHov3sL0cyjkILsc9ZR0AywyNzBb1k99gkXqRafgBUQ
        kHsEO/yrtq8peMmAlTyrwi9lXLVqr00yQqa3VTE=
X-Google-Smtp-Source: ACcGV62ZhUehMm7M1GbIlK1NLRMyT3zq7ZWayN5KmB8OWmnBEY620Ge9sELml+XmsfZds4YUNNClEhnUVRNnZd8fChM=
X-Received: by 2002:a9d:477:: with SMTP id 110mr10772667otc.78.1539612111903;
 Mon, 15 Oct 2018 07:01:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1539609921.git.leonard.crestez@nxp.com> <cc337772e1b7ed0c0884b5035c1d0bd4adfee10f.1539609921.git.leonard.crestez@nxp.com>
In-Reply-To: <cc337772e1b7ed0c0884b5035c1d0bd4adfee10f.1539609921.git.leonard.crestez@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 15 Oct 2018 11:01:58 -0300
Message-ID: <CAOMZO5BAhsyr_aDL3DSi2qNh17kNFLfrOYetDt-gKhNe3z4jGQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: crypto: Mention clocks for mxs-dcp
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Horia Geanta Neag <horia.geanta@nxp.com>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 10:28 AM Leonard Crestez
<leonard.crestez@nxp.com> wrote:
>
> Explicit clock enabling is required on 6sll and 6ull so mention that
> standard clock bindings are used.
>
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
