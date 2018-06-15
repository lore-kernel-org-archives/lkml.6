Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id DAAA1C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 13:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85C1A20896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 13:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="zx+OUasZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85C1A20896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verdurent.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756153AbeFONHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 09:07:24 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:46692 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755869AbeFONHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 09:07:21 -0400
Received: by mail-ot0-f196.google.com with SMTP id v24-v6so2360900otk.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 06:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jc1sjMc/GV3KsPf66bQTUkWG1eoL2jEYrFZnqhjEAtw=;
        b=zx+OUasZ2zsZwwspzz2FYkFtybG3nX+5kgUD5Ukfo8p5WqWYp1rEma1wtAp8hibSs+
         7pNqO+IhQLBPkw5cC7ebsVDA+aACW8cIDZCIkQQLgiTqhj7Z9n0eu3ZOa3cu3tyl8RfJ
         Ju9RqA4uSXljBg/u5INh5lWBiwwuDfxWGOytJ8A1ddVG6XiF9roZbUKCkdKO/MVNoOrc
         tjHKDVi2xp4MZFZYgRwH7QEvNvMZqkegVIQjArb3dY19RgNmtIhrKvFoZ9dgotXIoa8+
         ZoqGyXOv6u6o1mNV27YgHDHKUGEQouwJ33f8OdzHvBQZtr5esG8GRMckserVKW3+Lc6m
         zA6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jc1sjMc/GV3KsPf66bQTUkWG1eoL2jEYrFZnqhjEAtw=;
        b=gUinwTpufCOYc/VTydkSBvPvJcnuqhQV8EguuqHZMLyqymjAayoUl6JmN0N/lepZYk
         g+rLdDtjVW40p+g5c9qb4CQKJiY9Wn8q39YOU5YePQO3AuC/IQwTdl436CBo5wMsMpDH
         1ktAzQPPWTuWcKd+PIKE02sqrGGEA/jmbdHYgNZI4L57fMFfR9J3MaUMDQvM10UqMfGO
         ccv2NSt0oZq1mQlFKIy+axL5AEhys1dI7xadIkCDijIuaOCc08dhFuE7+VkOsYqoxlzn
         Bq/Z3P4LWfDBrh/ZswdIb8JH5QlxRtFIQNzaR7f34p/+T+XnZ5cMI2xuMSX6SO2Pt/GT
         JyFQ==
X-Gm-Message-State: APt69E2BwQURD0yRzv/Zg48UNbPXllSZjRRhZ8TPI+Y0zsWluRRrdEbN
        DEb3GMSi1Kq9Rjt/G+1oNmf1mhdK4s6r3f08rC0AJdDocvc=
X-Google-Smtp-Source: ADUXVKLaaFA9E01PN6XKX62OQy2p02fe9TMuIQ+qaFKvxntG1YIey/aFIawuc9KqA/zuBwpuP1gYWMouuV6hkidzGBw=
X-Received: by 2002:a9d:38a:: with SMTP id f10-v6mr880406otf.265.1529068041337;
 Fri, 15 Jun 2018 06:07:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:99ab:0:0:0:0:0 with HTTP; Fri, 15 Jun 2018 06:07:20
 -0700 (PDT)
In-Reply-To: <1528801355-18719-2-git-send-email-tdas@codeaurora.org>
References: <1528801355-18719-1-git-send-email-tdas@codeaurora.org> <1528801355-18719-2-git-send-email-tdas@codeaurora.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Fri, 15 Jun 2018 16:07:20 +0300
Message-ID: <CAHLCerOBTbBGC61qD=u1=4GWi=w64rPbWXFFGdv-9B-UO8A5BQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ FW bindings
To:     Taniya Das <tdas@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <skannan@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 2:02 PM, Taniya Das <tdas@codeaurora.org> wrote:
> Add QCOM cpufreq firmware device bindings for Qualcomm Technology Inc's
> SoCs. This is required for managing the cpu frequency transitions which are
> controlled by firmware.
>
> Signed-off-by: Taniya Das <tdas@codeaurora.org>


> +       qcom,cpufreq-fw {
> +               compatible = "qcom,cpufreq-fw";
> +
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +
> +               freq_domain_table0 : freq_table0 {
> +                       reg = <0x17d43920 0x4>, <0x17d43110 0x500>,
> +                                <0x17d41000 0x4>;

Changing the enable address to 0x17d43000 would make this a working
example, I think.

> +                       reg-names = "perf", "lut", "enable";
> +               };
> +
> +               freq_domain_table1 : freq_table1 {
> +                       reg = <0x17d46120 0x4>, <0x17d45910 0x500>,
> +                               <0x17d45800 0x4> ;
> +                       reg-names = "perf", "lut", "enable";
> +               };
> +       };
