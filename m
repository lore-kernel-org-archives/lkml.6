Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592C2C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 19:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 049A9216F6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 19:13:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 049A9216F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389927AbeHGV3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:29:40 -0400
Received: from mga02.intel.com ([134.134.136.20]:57418 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388948AbeHGV3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:29:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2018 12:13:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,456,1526367600"; 
   d="scan'208";a="60634214"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga007.fm.intel.com with ESMTP; 07 Aug 2018 12:13:47 -0700
Message-ID: <87753f10135e5f0791a6bfecb37ddecf7fd5b977.camel@linux.intel.com>
Subject: Re: [PATCH v2] ASoC: rt5677: Fix initialization of
 rt5677_of_match.data
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Matthias Kaehlcke <mka@chromium.org>,
        Bard Liao <bardliao@realtek.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>
Date:   Tue, 07 Aug 2018 22:13:47 +0300
In-Reply-To: <20180807171940.150507-1-mka@chromium.org>
References: <20180807171940.150507-1-mka@chromium.org>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-08-07 at 10:19 -0700, Matthias Kaehlcke wrote:
> The driver expects to find the device id in rt5677_of_match.data,
> however
> it is currently assigned to rt5677_of_match.type. Fix this.
> 
> The problem was found with the help of clang:
>   sound/soc/codecs/rt5677.c:5010:36: warning: expression which
> evaluates to
>   zero treated as a null pointer constant of type 'const void *'
>   [-Wnon-literal-null-conversion]
>     { .compatible = "realtek,rt5677", RT5677 },
>                                       ^~~~~~
> 
> Fixes: ddc9e69b9dc2 ("ASoC: rt5677: Hide platform data in the module
> sources")
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

While this is correct fix, it seems it was never used.

Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
 
>  static const struct of_device_id rt5677_of_match[] = {
> -	{ .compatible = "realtek,rt5677", RT5677 },
> +	{ .compatible = "realtek,rt5677", .data = (const void *)RT5677
> },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, rt5677_of_match);

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
