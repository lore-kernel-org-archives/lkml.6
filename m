Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4684EC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 10:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F298021717
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 10:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="f48tuFOP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F298021717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732524AbeHCMGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 08:06:05 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:41062 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728122AbeHCMGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 08:06:04 -0400
Received: by mail-io0-f193.google.com with SMTP id q9-v6so4521285ioj.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 03:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cwwM4ZmIg5b/t6g0BIko0N16SX6FE9E8A0tse56fZB4=;
        b=f48tuFOPiYPS50jfgk3A36bE/473W+tlNO/fVf3BadbD9qIqaabAgYQb8ibNn8jUYV
         NRTeStqYkocGZGENbFumoKVVjDNvdwyf1IV5d8mh+pt46Y31po+TEDIc5hECNI+IzOrQ
         GSbxipUGUBheLl6c4RRl+9a7DNhGr311G1XYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cwwM4ZmIg5b/t6g0BIko0N16SX6FE9E8A0tse56fZB4=;
        b=c2zYSnjRzUbVPdXdOgtYwik8ISkNDvZBzis+si0u6qXkbltlG9YivHMpJpRWzAQRvK
         oheNxW+sq3BCQSl/FbmfDDZgb51BpGDqfWpJdOoOfN/bDH4mCJGmhkJxTII4aw5P2qe+
         f2eCSnEaHxFCBKXGMEajGpyxERwOmkNWyax0a9nNE5OdKVPfVGCeISyMKKmFxggKE0ei
         Q211nakq80W+fvtkHk/7qTxicIuqtimhkUS06oQDEpYPg10ql6Cy5a70n5nL6cgPErzx
         QVjJATPwt7vd+LW8FIp1dOy0AqBu1zjlF+soFKiVOz665JP0YdfaxQjYyF55HrHzEoJV
         XIzA==
X-Gm-Message-State: AOUpUlHhqmq2TTG+jIPGIk89pH3fn44vJzBokbZuovorArM1inYPcHz6
        uvlCzgdWSV4DWewVVVEkopli5G8FPMXqXfVwUDqLir8znos=
X-Google-Smtp-Source: AA+uWPw3KNYT6E6r5KtJpJuVYyy9CjM/56naMTJBb3g4Jrs5pt8WJtsFN2XfsDoWr00Tl7vgtM3HfrMi4T7YeGWBuUQ=
X-Received: by 2002:a6b:144c:: with SMTP id 73-v6mr5329070iou.218.1533291028143;
 Fri, 03 Aug 2018 03:10:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:2b03:0:0:0:0:0 with HTTP; Fri, 3 Aug 2018 03:10:27 -0700 (PDT)
In-Reply-To: <20180629102035.2757-1-rnayak@codeaurora.org>
References: <20180629102035.2757-1-rnayak@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 3 Aug 2018 12:10:27 +0200
Message-ID: <CAPDyKFq=7RrUcspzyZGxYrv8bFHC=hkqMTT1SFeb+H_=Yv_Cxg@mail.gmail.com>
Subject: Re: [PATCH] remoteproc: q6v5: Add support to vote for rpmh power domains
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>, sibis@codeaurora.org,
        linux-remoteproc@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 June 2018 at 12:20, Rajendra Nayak <rnayak@codeaurora.org> wrote:
> With rpmh ARC resources being modelled as power domains with
> performance state, add support to proxy vote on these for SDM845.
> Add support to vote on multiple of them, now that genpd supports
> associating multiple power domains to a device.
>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
> This patch is dependent on the rpmh powerdomain driver
> still under review,
> https://lkml.org/lkml/2018/6/27/7

I assume you intend to re-spin this to use the new
dev_pm_domain_attach_by_name(), once 4.19 rc1 is out, right!?

Anyway, please keep me in the loop.

[...]

> +       if (num_pds > 1) {
> +               for (i = 0; i < num_pds; i++) {
> +                       devs[i] = genpd_dev_pm_attach_by_id(dev, i);

This API is supposed to be called only by the driver core. Please use
dev_pm_domain_attach_by_id|name() instead.

[...]

Kind regards
Uffe
