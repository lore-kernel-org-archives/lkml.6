Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1644DC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 09:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9C0D208B1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 09:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="W07C2fRt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9C0D208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbeH0Ngv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 09:36:51 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:54162 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbeH0Ngu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 09:36:50 -0400
Received: by mail-it0-f67.google.com with SMTP id p79-v6so1522557itp.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 02:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=s2+xvctHrxBO7ohWHKKWSI14MWKDl8j3eR3ERLYW4r0=;
        b=W07C2fRtpxyxw9K2hHLQR48LJIuFzVhNFO+7CbkIUTbHZ16LSH7833z2yV+Bo9Gj+M
         h1nUu9qqQfAz8ec9pEksfhTty4Wn+9e3TIgNIfGcR7l27GK3AJB2XvSEZvhbfooJYaEG
         y2MhNQRvntT6f0d4+/oq9WsQsvAtgSnHkoDUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=s2+xvctHrxBO7ohWHKKWSI14MWKDl8j3eR3ERLYW4r0=;
        b=G3GWU+PivaGH+tQPLFA/v5O/tqYtC+27BEOsGtoGXJz2MZFWAUfhM9WjO/f8b5KQcv
         XNyowHZeN36/brqeL70gnzq+7Am8SSjti867wUW0gude0wggNUPKI9kNx7YDMBNgVJXT
         fzcAMv5tZ5H+xPEUqWDXOGrJtZ6G5R112TOt7oTJfx2DAaiWMonaGejCpifeX9k3IRxK
         QgGNmalmDE/lPugs5I7DWPDGG1+B9bNl0PjwYfwJqS1WeqdNKBwCPEEN5rCuzZ1ZLCTj
         0O5mkA52ruTebZzKXdRsARTXF/uSslKPwbGBFcX9zW8ip7Bd8JXxozC+d2K7MAV2Nof9
         NPhA==
X-Gm-Message-State: APzg51Bt/epjUk/gzWqjlSjm7lwVZJhnzms9ZIXL1HGJipF0MBom9Uhc
        +dEfPCPjHjRwfiys17TT0zjGQ5ye/hEEHcHOCfxQqA==
X-Google-Smtp-Source: ANB0VdYWGr/uCtoLsZn62goy0qzbscnX7lQu3Z7sz4sdAUH9Uw92B9ah+fQQF6yaWFyAalqP27CcNW48/ItX4zzU0c8=
X-Received: by 2002:a24:5f92:: with SMTP id r140-v6mr6412092itb.45.1535363453420;
 Mon, 27 Aug 2018 02:50:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:2b03:0:0:0:0:0 with HTTP; Mon, 27 Aug 2018 02:50:52
 -0700 (PDT)
In-Reply-To: <20180824091103.GA9100@ulmo>
References: <1533924845-1466-1-git-send-email-avienamo@nvidia.com> <20180824091103.GA9100@ulmo>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 27 Aug 2018 11:50:52 +0200
Message-ID: <CAPDyKFrXQwjvNQeAbWfNeoc+wSfb+EeD-XrudHjeKGxsYS2-9A@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] Tegra SDHCI support HS400 on Tegra210 and Tegra186
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Aapo Vienamo <avienamo@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, linux-tegra@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 August 2018 at 11:11, Thierry Reding <thierry.reding@gmail.com> wrote:
> On Fri, Aug 10, 2018 at 09:13:57PM +0300, Aapo Vienamo wrote:
>> Hi all,
>> This series implements support for HS400 signaling on Tegra210 and
>> Tegra186. This includes programming the DQS trimmer values, implementing
>> enhanced strobe and HS400 delay line calibration.
>>
>> This series depends on the "Tegra SDHCI add support for HS200 and UHS
>> signaling" series.
>>
>> Changelog:
>> v2:
>>       - Document in dt-bindings which controllers support HS400
>>       - Use val instead of reg in tegra_sdhci_set_dqs_trim()
>>       - Change "dt" to "DT" in "mmc: tegra: Parse and program DQS trim
>>         value" commit message
>>       - Add spaces around << in tegra_sdhci_set_dqs_trim()
>>       - Make the "mmc: tegra: Implement HS400 enhanced strobe" commit
>>         message more detailed
>>       - Remove a debug print from tegra_sdhci_hs400_enhanced_strobe()
>>       - Add blank lines around if-else-block in
>>         tegra_sdhci_hs400_enhanced_strobe()
>>       - Use val instead of reg in tegra_sdhci_hs400_enhanced_strobe()
>>       - Make commit message of "mmc: tegra: Implement HS400 delay line
>>         calibration" more detailed
>>
>> Aapo Vienamo (8):
>>   dt-bindings: mmc: Add DQS trim value to Tegra SDHCI
>>   mmc: tegra: Parse and program DQS trim value
>>   mmc: tegra: Implement HS400 enhanced strobe
>>   mmc: tegra: Implement HS400 delay line calibration
>>   arm64: dts: tegra186: Add SDMMC4 DQS trim value
>>   arm64: dts: tegra210: Add SDMMC4 DQS trim value
>>   arm64: dts: tegra186: Enable HS400
>>   arm64: dts: tegra210: Enable HS400
>>
>>  .../bindings/mmc/nvidia,tegra20-sdhci.txt          |  4 ++
>>  arch/arm64/boot/dts/nvidia/tegra186.dtsi           |  2 +
>>  arch/arm64/boot/dts/nvidia/tegra210.dtsi           |  2 +
>>  drivers/mmc/host/sdhci-tegra.c                     | 84 +++++++++++++++++++++-
>>  4 files changed, 89 insertions(+), 3 deletions(-)
>
> Ulf, Adrian,
>
> Aapo just reminded me of this small series that also has a dependency on
> the UHS signalling series posted earlier. I think it's easiest if I just
> stash this on top of the existing branch that I have and send this along
> with the rest as part of a pull request early after v4.19-rc1.

Yep, that would be convenient for me.

Although, we first need some input from Adrian.

Kind regards
Uffe
