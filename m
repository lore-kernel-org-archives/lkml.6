Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F48C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 20:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E21B0205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 20:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vhNdsmuF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E21B0205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbeKBFeh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 01:34:37 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:45772 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727734AbeKBFeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 01:34:37 -0400
Received: by mail-ua1-f68.google.com with SMTP id x3so7674758ual.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 13:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SCv09X55C7i17BM8MLWGXS11rE4kdWDNQXR/kUkOGFE=;
        b=vhNdsmuFKYBmg3ko3zF9rTBk20aBsJDp6rF7P+w+9AgYyTNlCTW3HQZO63grV3NyPz
         fh1lkZ91bqMDq/58Ih4Dpa2EMGq6C/phZ+hmDAVTyiUZBP2XzkNs9CWDJ75KgBsTQZVs
         RfnjevrH/VFKl6hdzsW8Kiibv79Udeyo3k9YZuWZtbrP9dHA6Ru9RR4uAYqf7qvuoBcM
         RCHxF0j29u1V5NyEshEY6Ae6YgiI5bQEmXT8lfPS2SVQAXaponHvfRrG4tw6WnjlXmrM
         ZU1VXhNdwLvrd5W2GWExMN/kHQh1to3R+2rW6pkmx8fyV6xuL8zOt+fe/OHiwt9TP8Um
         JeOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SCv09X55C7i17BM8MLWGXS11rE4kdWDNQXR/kUkOGFE=;
        b=mHa7cdnWRBs0PY5bi0yjWHAPVAkqT91nkxz2V3DZzL/CQDJ3Q+daW6GZjpPmrh4L1b
         CcWL2AGRxGj0YsRy9MKs22Rza9sZ+xcrcl43qcWX+DwxUJih4eMufzeQmt90V3qgGOUO
         joCgDJsvGWZrYcN/U4e/Sx7KySebup8oMOPAgP6XR4EztWS10waOecWlFY5qrkcajB3m
         5GyYJZVn/XgBrYEVaIuQ3CGAKvPB4JbU2wQXQCehpGIAqNm4B63XY0VOJ3IqwvqO7PZl
         gtWbl8rVQeAMG3ycITBm3md380+qtYeBouXsU2KKnrxnmA/2uTe60Ib6Di1OpWk/YtB1
         LLkw==
X-Gm-Message-State: AGRZ1gKtzNCpZV/IgZWEa4Gn+3WanZZCNTJvSmd27cxL+AMWnuYuBWQu
        zPd1u4QNpKvBTlxWRfVgPVR7LFkaKye7627wYQhxQg==
X-Google-Smtp-Source: AJdET5caTqU0Yz6nkhkXdZOxRIRnLhheJMP08wYZh9c3SoVT18Z24zJzcqI1b+OJSkOim/qxD1joYxs0/hjcfCQnz8Q=
X-Received: by 2002:ab0:7488:: with SMTP id n8mr4217793uap.115.1541104205465;
 Thu, 01 Nov 2018 13:30:05 -0700 (PDT)
MIME-Version: 1.0
References: <1541073999-11752-1-git-send-email-vbadigan@codeaurora.org> <1541073999-11752-2-git-send-email-vbadigan@codeaurora.org>
In-Reply-To: <1541073999-11752-2-git-send-email-vbadigan@codeaurora.org>
From:   Doug Anderson <dianders@google.com>
Date:   Thu, 1 Nov 2018 13:29:54 -0700
Message-ID: <CAD=FV=V9AdCgOSonb0tu==DgKRKeZxto+aGwxmdbHAqrmfMrDQ@mail.gmail.com>
Subject: Re: [PATCH V3 1/2] dt-bindings: mmc: sdhci-msm: Add new compatible
 string for SDM845 SOC
To:     vbadigan@codeaurora.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Asutosh Das <asutoshd@codeaurora.org>, riteshh@codeaurora.org,
        stummala@codeaurora.org, sayalil@codeaurora.org,
        Mark Rutland <mark.rutland@arm.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Nov 1, 2018 at 5:07 AM Veerabhadrarao Badiganti
<vbadigan@codeaurora.org> wrote:
>
> For SDM845 SOC, new compatible string  "qcom,sdm845-sdhci" is added.
>
> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> index 502b3b8..f2ffbeb 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> @@ -7,6 +7,7 @@ Required properties:
>  - compatible: Should contain:
>                 "qcom,sdhci-msm-v4" for sdcc versions less than 5.0
>                 "qcom,sdhci-msm-v5" for sdcc versions >= 5.0
> +               "qcom,sdm845-sdhci" for sdm845 SOC

It's up to Rob of course, but IMO it seems a nicer way forward to
include both the SoC-specific string and the "version" string in all
cases.  I'd write this for the full text:

 - compatible: Should contain a SoC-specific string and a IP version string:
      version strings:
           "qcom,sdhci-msm-v4" for sdcc versions less than 5.0
           "qcom,sdhci-msm-v5" for sdcc version 5.0
      full compatible strings with SoC and version:
           "qcom,apq8084", "qcom,sdhci-msm-v4"
           "qcom,msm8974", "qcom,sdhci-msm-v4"
           "qcom,msm8916", "qcom,sdhci-msm-v4"
           "qcom,msm8992", "qcom,sdhci-msm-v4"
           "qcom,msm8996", "qcom,sdhci-msm-v4"
           "qcom,sdm845-sdhci", "qcom,sdhci-msm-v5"

   NOTE that some old device tree files may be floating around that only
   have the string "qcom,sdhci-msm-v4" without the SoC compatible string
   but doing that should be considered a deprecated practice.

-Doug
