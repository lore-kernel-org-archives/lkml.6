Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D0FC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DE4920843
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UBJb8C3m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DE4920843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbeIZUXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 16:23:37 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36916 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbeIZUXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 16:23:37 -0400
Received: by mail-io1-f67.google.com with SMTP id v14-v6so23397565iob.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 07:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=B5M3kxZJckAo1SQ2ftJhzQKMAQWoRml9wDh/EXK+Ch4=;
        b=UBJb8C3m1i4TEi0K2M6fCd46qJrbjvmbVB0coBfw4VN0vbFKUFCv3r3KAKYb4ungDp
         aDL034u4/RNblgSIXrmrvRHrh68Sp2HRECaGsTcujxfa1eAxVcq02xgGt/Da2FpSDLfu
         QflwaTE7b6341C6SV/LEvNlYL4LQ9su+JUjbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=B5M3kxZJckAo1SQ2ftJhzQKMAQWoRml9wDh/EXK+Ch4=;
        b=SHb9h8sQz97NCLBZFhg55CXdzkrtk3pGyMRNjR/ErCyK57tGLiP7zoN75beGvlYrl6
         gNapSkr37Q0o3Wt/G+w07hwNCtgf3x/YtdnLQreJHaXmVPWHg4b1bhll4y0JKKrSq+VM
         DSsFAnl701Eml/VBkgdrTA0s4VR9DNdU9P8MIVblLp5Ecxk0v5GegnSnT5UEIHDIUMTa
         TYvjyZjP6GOLIKyDQvMx4uV5p5dVR9XbHs8Tr0taR6uw/tOY9891NgAJJ6ehS7Nd/L+s
         PLzrdDx9nnsMNYaM/Lv0jZ7rDqli89biDOD9DJihGgkXoAnLakRMQea1GLHAFJDC3YOH
         PPTQ==
X-Gm-Message-State: ABuFfohZmUSc2xPramrTti6HihZovz8vN2B7gNOdKqRMAv8E9hcfh3g6
        JZV385W/WB7S08DICa5SkEf9u/VFr6q5WuwyQH0YPA==
X-Google-Smtp-Source: ACcGV61SyXUAjn0MjRAjmlFwrqPPvd9ELMT4sOy42u/32kB6//+w963ywFVGPeoDWNMFFZkeqH94gvSRMO2TYF8701I=
X-Received: by 2002:a6b:144b:: with SMTP id 72-v6mr5094152iou.218.1537971028481;
 Wed, 26 Sep 2018 07:10:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:6a18:0:0:0:0:0 with HTTP; Wed, 26 Sep 2018 07:09:47
 -0700 (PDT)
In-Reply-To: <1537964858-30332-2-git-send-email-jonathanh@nvidia.com>
References: <1537964858-30332-1-git-send-email-jonathanh@nvidia.com> <1537964858-30332-2-git-send-email-jonathanh@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 26 Sep 2018 16:09:47 +0200
Message-ID: <CAPDyKFrtw1aYg5QbgRi_jp-xd0VLNeRYhb4HvX4P3AfGjgO0VA@mail.gmail.com>
Subject: Re: [PATCH 1/5] PM / Domains: Export symbol for genpd_dev_pm_attach_by_name
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 September 2018 at 14:27, Jon Hunter <jonathanh@nvidia.com> wrote:
> Export the symbol for genpd_dev_pm_attach_by_name() so that drivers
> built as modules can call this function.
>
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/base/power/domain.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 4b5714199490..b2bbe0d848d2 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2397,6 +2397,7 @@ struct device *genpd_dev_pm_attach_by_name(struct device *dev, char *name)
>
>         return genpd_dev_pm_attach_by_id(dev, index);
>  }
> +EXPORT_SYMBOL_GPL(genpd_dev_pm_attach_by_name);

Driver's shouldn't be calling this function, but instead use
dev_pm_domain_attach_by_name().

Is there any problem with that?

[...]

Kind regards
Uffe
