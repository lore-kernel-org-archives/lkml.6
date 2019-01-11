Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D84C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 732832177B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GcCgZl30"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730190AbfAKJlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 04:41:25 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43748 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbfAKJlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 04:41:25 -0500
Received: by mail-pl1-f194.google.com with SMTP id gn14so6537309plb.10
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 01:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=tbiaA4fJYcgLb1K4vUdUrbau2fblch5OFHfxAA3Jx6Y=;
        b=GcCgZl30ekMXf9dQ34DPGjltcR8nc2we04mXPbjyfOoyXc2Zl1q1KcEV7bT/GppfwU
         oCc4ZV+BHU4YBhAy0zRvvT/VxYJL/AL+L96pfD6qrNlhjdXs0JY645s2SMiSobmpUo9W
         cilKLeB4DmMGU41ItqVFx1uh4Q5NHvHoxKkaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=tbiaA4fJYcgLb1K4vUdUrbau2fblch5OFHfxAA3Jx6Y=;
        b=uEzEQIa0ZfOIfEW//CyQ/ZTfXqIuw3Q2zOGMSNXqH8nwhZGdYQE/vrsFMm5+6o3HcL
         MAIoiH7d1vOF8C83XKZQxgN+7Xv7kIPHF2MDdne26WXcKRTL2PW0ucaBfiZ0WLpKHoea
         1PTK+ifXS+Bktr62L6f6NlHhgQgIZ+GQmrtrWyjiasPNH4Go2FpWE37hM8JZigIXIsfP
         dgupwrYwhFuLbWxhnNqEFjyjSWfirIXvBkhUccakMkjLSLMUVb2UfWxTZgAceDQTJW37
         cuJwnHU7dwAtrpDiQ9LHa6eGu41CVG8HUcwKU+huNaj2t9uF+n7TYqg5mUchJxZXULdq
         hHYg==
X-Gm-Message-State: AJcUukdTEy1q1ONmuRjQiw0gzYUSNr7S0apjpSBLJmexc8fZvYouAbqV
        +Par8fuRttRsaRkmOerpgDKhgQ==
X-Google-Smtp-Source: ALg8bN4IjpnAOTmlVspkQtv7ADosTvS3hRuvvcSpujqPY0ZxmJpnVeiMCadtsOt0Fk91YxcVy7jl0g==
X-Received: by 2002:a17:902:bd0a:: with SMTP id p10mr13524931pls.322.1547199684113;
        Fri, 11 Jan 2019 01:41:24 -0800 (PST)
Received: from localhost ([122.172.34.203])
        by smtp.gmail.com with ESMTPSA id 125sm139472770pfx.159.2019.01.11.01.41.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 01:41:22 -0800 (PST)
Date:   Fri, 11 Jan 2019 15:11:20 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>,
        kgene@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/4] ARM: dts: s5pv210: Add dmc nodes
Message-ID: <20190111094120.6dcnspccp6ufxd4y@vireshk-i7>
References: <20190110205215.22030-1-pawel.mikolaj.chmiel@gmail.com>
 <20190110205215.22030-2-pawel.mikolaj.chmiel@gmail.com>
 <CAJKOXPcWOtTh5nDpZuX=NfrcOcQDPUXoFJLc8JtLs6UEY9LL6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJKOXPcWOtTh5nDpZuX=NfrcOcQDPUXoFJLc8JtLs6UEY9LL6w@mail.gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-01-19, 09:32, Krzysztof Kozlowski wrote:
> On Thu, 10 Jan 2019 at 21:53, Paweł Chmiel
> <pawel.mikolaj.chmiel@gmail.com> wrote:
> >
> > This commit adds dmc nodes, which are needed by s5pv210 cpufreq driver
> > to work.
> >
> > Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> > ---
> >  arch/arm/boot/dts/s5pv210.dtsi | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> 
> Thanks, applied (actually I applied v1 - I hope there were no changes).

Would you like to Ack the other patches so that I can apply them ?

-- 
viresh
