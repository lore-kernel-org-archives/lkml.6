Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59228C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 09:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF16208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 09:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="wNmiABmG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AF16208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731900AbeGaLMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 07:12:49 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:55476 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729768AbeGaLMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 07:12:49 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 6936F5C01C4;
        Tue, 31 Jul 2018 11:33:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1533029600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mwvbCvv2OuMxGtuXKtr/9W0LxJbMhRQV8RnJOViShYU=;
        b=wNmiABmGBd7vh1ILO1USyJe2z9+0A9euYayc5IcMCfzBngVGMsP31lWjmqIqzh+Ug4mMA4
        Uq3vWvUU8vTO402q5ECIFAri56Tx1RQ65SgiUgcZUzrmVvkjLImp5qy5ZJ58iQw7Z4nGQR
        6wcG0HGxyjtZ6pUUwKFxk++hiqHFP2c=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Tue, 31 Jul 2018 11:33:20 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Aapo Vienamo <avienamo@nvidia.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra-owner@vger.kernel.org
Subject: Re: [PATCH v2 00/10] Tegra SDHCI update the pad autocal procedure
In-Reply-To: <20180730184351.5044cb6e@dhcp-10-21-25-168>
References: <1532608016-14319-1-git-send-email-avienamo@nvidia.com>
 <CAPDyKFo+nv+9qYV=J5k-63cDhQO=L==87RLMj_7BnjEjUf5iEQ@mail.gmail.com>
 <20180730184351.5044cb6e@dhcp-10-21-25-168>
Message-ID: <56e6c8c572a429a987dd7ef7bd898768@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.07.2018 17:43, Aapo Vienamo wrote:
> On Mon, 30 Jul 2018 17:07:59 +0200
> Ulf Hansson <ulf.hansson@linaro.org> wrote:
> 
>> On 26 July 2018 at 14:26, Aapo Vienamo <avienamo@nvidia.com> wrote:
>> > Hi all,
>> >
>> > Update the tegra_sdhci_pad_autocalib() pad drive strength calibration
>> > procedure to match the ones specified in the TRMs of the more recent
>> > SoCs. This was tested on Tegra186, Tegra210, and Tegra124, although it
>> > should not break things older generations either.

I can give this a try on Tegra 3 here.

>> >
>> > This series depends on the "Tegra SDHCI enable 1.8 V signaling on
>> > Tegar210 and Tegra186" series posted earlier.
>>
>> According to the cover letter of the above series, it states that it
>> depends on $subject series. A circular dependency. :-)
> 
> The dependency chain goes like this: "Tegra SDHCI update the pad
> autocal procedure" -> "Tegra SDHCI enable 1.8 V signaling on Tegar210
> and Tegra186" -> "Tegra PMC pinctrl pad configuration".
> 
>> In fact, there should be no dependency at all or else there seems to
>> be a DT compatibility problem here...
> 
> From a functionality perspective there's no strict dependency, however,
> I don't think "[PATCH v2 09/10] mmc: tegra: Perform pad calibration
> after voltage switch" can be applied cleanly without
> "[PATCH v2 03/10] mmc: tegra: Reconfigure pad voltages during voltage
> switching" from the "Tegra SDHCI enable 1.8 V signaling on Tegar210 and
> Tegra186" series.
> 
>> Anyway, I think it actually makes sense to fold in all changes into
>> one series. Make sure the dt-doc changes comes first, then the driver
>> changes and finally arm64/dts changes. This should make it easy to
>> follow the review and I can pick the mmc parts and the soc maintainer
>> can pick the arm64/dts changes.
> 
> I've sent the changes in multiple part because I've been working on
> further changes to the driver while the previous parts have been
> getting reviewed. This is still the case and there's still going to be
> at least one more series which adds support for HS200 tuning and some
> smaller changes after it. However, the HS200 work is probably going to
> be ready for review in a day or two. I can send these as a one series
> from now on, although at this point it would be 27 patches in total
> and even more with the HS200 patches.
> 
> I can do that if you prefer to do it that way. Makes my life somewhat
> easier too.

...that would make it easier for my testing too, so I wait for the next
revision and will give it a try on Tegra 3 then.

--
Stefan

> 
>  -Aapo
> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
