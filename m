Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2C0C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D88852063F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547031505;
	bh=sDoxHAhlPA04hTeozlLuf8XsGBWu6hTBtPu5x26V9lQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Xafl3QFL+PFRjHS7wAKLDWMuRbd7npGg5h4qINZ357NLm2spyykfGK9FhaZXFJLwz
	 ggdaJ0o36abAd3MMdxv2dItxR02rs01hJ1AVe3IOz/D8GUfKzqJqnVDF9ML6+Ko4R0
	 7rxqi+PRylZJEDx9FmulwFEcw/6h910xLNr2Q6aM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730548AbfAIK6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 05:58:24 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35378 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729752AbfAIK6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 05:58:24 -0500
Received: by mail-lj1-f194.google.com with SMTP id x85-v6so6119817ljb.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 02:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sDoxHAhlPA04hTeozlLuf8XsGBWu6hTBtPu5x26V9lQ=;
        b=PrhFPAUARi7Nuq4LMd++Q8dGeaNLxSzYlEQtyxtWjEC/4tReJ7c0c4wtKZTOztCO7M
         xB/9PQ9G7UR+T5d6nAJeda3MmOFTitSFF+z4HlFDyYuj4gX9Bv9bED/0DD111Tuw0327
         zjxvJxrXH3c1kXgSO5y3DBHPOEBvE5tOcul7toxsvoL0Pqz01+C4FqLT6N+myWUdi+BH
         m4EFx8GnIxWnzqfCZCHUWi2TxwgTOlnxVd4dKtiqdlPKcea0Nzq32qjPpUS190Lznu2X
         lndRdzzZZRRMEUs8B5aNJ4FJA5MULA4PT5Qf3YeAkEVBUCauscD0Ju8N/M5EhA1bYFQC
         qn7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=sDoxHAhlPA04hTeozlLuf8XsGBWu6hTBtPu5x26V9lQ=;
        b=ZLOObmckL0BExYoQvil2Hk4h//sU+W6eO+JqnMqRZLfFjpFxx18izLN1Z3XUSttAj0
         twGGLKfXzNCUD4Z2HyAibHKcTP7Yaz6oPLGxYAIiI6Kqyxnn9UrIBR/CvutK9amXJGFt
         1FfCzVGdXInadmETpCsJCDlxbd+a9gXwvw6d5VNZQLHcJunVmQb3kxI10LlWIz6fQzaD
         wv0XrI3CSxeFq25Wq9Zqfu2KofEJw1IfxgsGLcMUkTYmBAwzyRWNN1rB2PDR4SsaxeDl
         CKXIJ0IWOApxnbwlseNOYdd0naFMeuX9AX8gZ5nnsswh6S0w4+8kFayDwbfRPQp0m+aY
         p79g==
X-Gm-Message-State: AJcUukeJvmysYnp2MZtFXmmZClFZ2wYFVyfj0cv9Soj7anpdkjOmMiWM
        4v7hnZEB3KJ+WI7H+Z25wrDczmiz
X-Google-Smtp-Source: ALg8bN5u0Zshrkm3ySJYsyREDMC3HqwPbh7paUVAnOSF5DTCHPQke1QCUlkD2iBl84cr2hMB+fKTPA==
X-Received: by 2002:a2e:9d8e:: with SMTP id c14-v6mr3115145ljj.146.1547031501432;
        Wed, 09 Jan 2019 02:58:21 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id e97-v6sm14837455lji.51.2019.01.09.02.58.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 02:58:20 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1ghBZ2-000828-FY; Wed, 09 Jan 2019 11:58:24 +0100
Date:   Wed, 9 Jan 2019 11:58:24 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Nishad Kamdar <nishadkamdar@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@kernel.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] staging: greybus: gpio: Use gpiochip_get_data()
 in place of gpio_chip_to_gb_gpio_controller()
Message-ID: <20190109105824.GJ14782@localhost>
References: <cover.1545488665.git.nishadkamdar@gmail.com>
 <03b274a2b5777d67e9d9b6318b5b2f13ce5c2b66.1545488665.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03b274a2b5777d67e9d9b6318b5b2f13ce5c2b66.1545488665.git.nishadkamdar@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 22, 2018 at 08:21:00PM +0530, Nishad Kamdar wrote:
> This patch drops gpio_chip_to_gb_gpio_controller(),
> and uses gpiochip_get_data() to retrieve the container
> of struct gpio_chip.

So this will break the driver, since gpiochip_add() sets the data
pointer to NULL.

These kind of changes are getting too complicated to do without
something to test against. We had a module simulator at one point, but
not sure what the state of that is now.

I appreciate the effort though, and since we already started, let's try
to finish, but please drop this patch for now.

Johan
