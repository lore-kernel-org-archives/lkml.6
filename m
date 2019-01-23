Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FC1C282C3
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 00:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8366320856
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 00:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V6caVWVN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfAWABm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 19:01:42 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:38857 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727199AbfAWABe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 19:01:34 -0500
Received: by mail-vs1-f68.google.com with SMTP id x64so241796vsa.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 16:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cigmukXYvT3GZ9hSv6by7nEQ4A+EVt4AsGYCP5qKehU=;
        b=V6caVWVNdY9Ii5dBZsupt042OqkgkmOt9eMmBAnaYTa5rjEHA0IVua49B0PGVXNufR
         INdmIN0zDoHuVs5qe0/DKhkVOxHmotXml1bD65dBNaPnXHq0L+tCDj58X5088jjSGAn9
         Jf4A5zUY6sVIQcbLkXytj3qVNWMjBjNdnlQok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cigmukXYvT3GZ9hSv6by7nEQ4A+EVt4AsGYCP5qKehU=;
        b=R1HDs3+INRlm2WXaxXSOH1eBSAakELOLVujSA/ZhX11Dx0bkDX2WJTPBLMCnT1m+mG
         P9BPgP0N5p8iK2QQ5L7xblauHUfsdP0cdrZWHdnPOBWpAtIt/VXp4vRLdNFeatMIEK9p
         79I1nzEvSjDXzk0Z58madg74eYtEKiU8JQe336m0rv+8l8X6Y3i4damIv2HcH12ttR1c
         phYqoft/S3W1BruFm/ZGPJw5Y8hpuWMn5s4/ttvUWF1In7Kbl+haFcmq2Y9meguGsc4m
         nhLy4xm1MvQvP8ZLXdgJWRY9UR5eKKoBFLYnzNCKiP9caGs2tKYQVSmwXBzQGHv2EtlT
         P68g==
X-Gm-Message-State: AJcUukd+mZB1b1M8paPGdVc2lreUEuCXcj2V31GTNI30eba/DuEPNi+F
        dqiEvgupUGx0dBCDNiuGSYCVmtogZBs=
X-Google-Smtp-Source: ALg8bN4jvGLgl5BFWORR9k85Or14sS6VsVVfukKG5uMmt593U6zGLBAxknkSChmXVvEMYWt7Vi2nAQ==
X-Received: by 2002:a67:1905:: with SMTP id 5mr10010vsz.102.1548201692229;
        Tue, 22 Jan 2019 16:01:32 -0800 (PST)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id w65sm34191781vsc.16.2019.01.22.16.01.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 16:01:31 -0800 (PST)
Received: by mail-ua1-f41.google.com with SMTP id z24so123653ual.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 16:01:31 -0800 (PST)
X-Received: by 2002:ab0:45d4:: with SMTP id u78mr10819uau.52.1548201690903;
 Tue, 22 Jan 2019 16:01:30 -0800 (PST)
MIME-Version: 1.0
References: <20190122055112.30943-1-bjorn.andersson@linaro.org> <20190122055112.30943-8-bjorn.andersson@linaro.org>
In-Reply-To: <20190122055112.30943-8-bjorn.andersson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 22 Jan 2019 16:01:18 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UW76Jbq70M12+t2DrA04GT8=tD1MfJiRj0KimyZaWTGw@mail.gmail.com>
Message-ID: <CAD=FV=UW76Jbq70M12+t2DrA04GT8=tD1MfJiRj0KimyZaWTGw@mail.gmail.com>
Subject: Re: [PATCH v3 07/10] remoteproc: q6v5-mss: Vote for rpmh power domains
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jan 21, 2019 at 9:52 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> @@ -1333,7 +1431,7 @@ static int q6v5_probe(struct platform_device *pdev)
>         ret = qcom_q6v5_init(&qproc->q6v5, pdev, rproc, MPSS_CRASH_REASON_SMEM,
>                              qcom_msa_handover);
>         if (ret)
> -               goto free_rproc;
> +               goto detach_proxy_pds;
>
>         qproc->mpss_perm = BIT(QCOM_SCM_VMID_HLOS);
>         qproc->mba_perm = BIT(QCOM_SCM_VMID_HLOS);
> @@ -1344,10 +1442,12 @@ static int q6v5_probe(struct platform_device *pdev)
>
>         ret = rproc_add(rproc);
>         if (ret)
> -               goto free_rproc;
> +               goto detach_proxy_pds;

I can't comment on the patch overall since I haven't spent any time in
remoteproc, but as previously pointed out by Sibi, now that you've
landed commit 027045a6e2b7 ("remoteproc: qcom: Add shutdown-ack irq"),
you need to adjust the "goto"s in your patch.  Specifically
(whitespace damaged) atop your whole series:

@@ -1488,7 +1488,7 @@ static int q6v5_probe(struct platform_device *pdev)
        qproc->sysmon = qcom_add_sysmon_subdev(rproc, "modem", 0x12);
        if (IS_ERR(qproc->sysmon)) {
                ret = PTR_ERR(qproc->sysmon);
-               goto free_rproc;
+               goto detach_proxy_pds;
        }

-Doug
