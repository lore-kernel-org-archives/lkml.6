Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90E4C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 04:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 483232133F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 04:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="wy9SttF/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 483232133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbeIMJ44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 05:56:56 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41469 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbeIMJ44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 05:56:56 -0400
Received: by mail-pl1-f193.google.com with SMTP id b12-v6so2026920plr.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 21:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:organization:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=C1ff93F3HnIlnWt2J1vdjG+cd1b+9wB4UQ9L725wbxQ=;
        b=wy9SttF/yaaa9CXFA8NK+mATEiPeHTSgVLu9lDxrVPLZp51PB4sRv2hYuib3CWwN9f
         ddvOL3fLZTrI95TTIFs9H1/UyddSb1kO0Zwhq3QpeXT3lL8OQ2xls/rQROgHEOHoOl1n
         v0RH4QhDvWezCYFY9D26mExikzVt5eXmhQH7eh3ccJ6EBG0nb8UEKLkgnHkVMhyNojIa
         Y3AHpgBzw8mnKRN6MgBJuKwBE6lCz23lV69a7M6QYX74fcE9AbFR9DaJCRMxWCx4XZNz
         VJkcjHOg/4hBoUazloB47lpLOrJNzNWydNAEk/ki+nPJyTIEerseoKHQi7+Kl4SXKdCM
         biNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:organization:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=C1ff93F3HnIlnWt2J1vdjG+cd1b+9wB4UQ9L725wbxQ=;
        b=hh3jL1Th2GAen7niGEK4FknVR+p/Ln/rNGvuMcrGq/F8qiZ122TpY+qwAkv9DrL7EW
         5qOA3u7VwOfAZd+zFR14mvcY3WzWRimki39wRfZ0bnN5LtSDadovxZMUy/kYGI6dh5RL
         Ltnw3yKKdH+DPOeFhLeHxmhhcCEaIPhEvgQa0stRCvsVsvwTMd9UfZnPVxOBSh1t+JbH
         1w+CmqgGhhdoDMSmveVcApMXknLG/kJ+l3zCJ3ftvXbseiaRX8ynZKmdXVkp5Ho38e3G
         Vj2FhanbzQLC89KBaIQMhoIMBNsHgLlqI+MmlINi4n0JMol3oy04kQABKz1F0kPu6LnA
         PA8w==
X-Gm-Message-State: APzg51AmFgg5eB3e5j5XhICJiuPmubcJTgsAdq+WruKy+y5XglnS+Lbh
        pxzGM2XVYK9mg4y7Q4so09o0JA==
X-Google-Smtp-Source: ANB0VdbVlAAn4eqXVZ+4tpLp/XbeXon7eBz0LE7H6B3ex3MTcl1dJ3qdamYz0yv5/gfp/oiVxzfglA==
X-Received: by 2002:a17:902:c6b:: with SMTP id 98-v6mr5381213pls.233.1536814150274;
        Wed, 12 Sep 2018 21:49:10 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id t21-v6sm4431965pfi.73.2018.09.12.21.49.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 21:49:09 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH] arm64: defconfig: enable modules for amlogic s400 sound card
Organization: BayLibre
References: <20180828122735.28919-1-jbrunet@baylibre.com>
Date:   Wed, 12 Sep 2018 21:49:08 -0700
In-Reply-To: <20180828122735.28919-1-jbrunet@baylibre.com> (Jerome Brunet's
        message of "Tue, 28 Aug 2018 14:27:35 +0200")
Message-ID: <7hmusmvw6z.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> Compile the necessary drivers as modules, including codecs, for the
> s400 sound card.
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Applied to v4.20/defconfig.

Thanks,

Kevin
