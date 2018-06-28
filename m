Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF64AC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 900AB24336
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ocyBXG32"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 900AB24336
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965936AbeF1NIq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 09:08:46 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39867 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965894AbeF1NIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 09:08:43 -0400
Received: by mail-wm0-f66.google.com with SMTP id p11-v6so8947468wmc.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 06:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WWk8bT98G82DyCaGkkSl3QGm8rTHi9hG65tCtLSp4x8=;
        b=ocyBXG325K0uyd4SkfcH9yNNG/V084vz5OckzchnpOd2OOcKtDSSUwnMJMGerRonDF
         cbUAaAwLOsZ+L05Fh06+tmvLj/T7L5gTSEO+8I/F3E4/jOn/uAaOCWyThgfe3Px+4Lcf
         y1jVyikqqlQ74eIrRH+LlBARnrKrSUA0hkbsOYK4eU4fPSdJWDOwHizexDY0noA/c0TW
         wegAXhh6EzMuRjMwAI3oRhhk7/XCb8IFx+ZY4131AoxINHwZjHvicubWY0AW4nmzboXp
         iOP8zY4YkO6tVplfakXOLrK0EulVUGOYChTrrgsk/gEim6JZS+jzhHfjq8jDw8sKY+C/
         sKNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WWk8bT98G82DyCaGkkSl3QGm8rTHi9hG65tCtLSp4x8=;
        b=FwX8pZhriNyhVTsxxF3SngHKOrQuEdq1u2quo6WiAs5QjWWzGI+JKlIid644EQh3OE
         3ZdG8H61rAFIRfRP6mq+RDU1jO32mxQDaSmWrn9UQOjkaIOi3CyA3ntV+0NerNSlbGZF
         h+27ek+KU7X8jMcSSgjv6yF3jj84lsTPL8JLtjQWeCAfMGnvJSrBZ7j9dFPrPUqLa+0A
         Hl4VmWHTQfnqWqG9iZRTfulPymX6kILG4ZfokhBmUTRK6VedgD1CCbKx8KEPp3xGx5CC
         yhJxbyAocYuS1ZGMHFQzpZswOc8u1c++lWRLekSi1wNn3hgb1NJHIg8m1BffIDBX9Ymv
         /sSg==
X-Gm-Message-State: APt69E0Kn6Ll/QFe7dqPggZh8eSmo1DPuRG2gcbuUxpmAGMoDu/Wt2I/
        vt/aEqFfVF9T/uzKdunHVU/nVA==
X-Google-Smtp-Source: AAOMgperUksoAvNbaHsbYEfsFlVwWIOkDIvdftv7QJyoJSyXX4alzTYZ5G8smsvpv+EpWbptn60NJw==
X-Received: by 2002:a1c:afd4:: with SMTP id y203-v6mr7837302wme.55.1530191322583;
        Thu, 28 Jun 2018 06:08:42 -0700 (PDT)
Received: from boomer ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id h15-v6sm9158564wrp.79.2018.06.28.06.08.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Jun 2018 06:08:41 -0700 (PDT)
Message-ID: <1530191320.2900.109.camel@baylibre.com>
Subject: Re: [PATCH] ASoC: dpcm: extend channel merging to the backend cpu
 dai
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Jiada Wang <jiada_wang@mentor.com>
Date:   Thu, 28 Jun 2018 15:08:40 +0200
In-Reply-To: <20180628101550.GC14040@sirena.org.uk>
References: <20180627094818.5885-1-jbrunet@baylibre.com>
         <20180628101550.GC14040@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-06-28 at 11:15 +0100, Mark Brown wrote:
> On Wed, Jun 27, 2018 at 11:48:18AM +0200, Jerome Brunet wrote:
> 
> >  As you've probably noticed, this patch applies on top Jiada's patch
> >  pf4c277b817cc ("ASoC: soc-pcm: DPCM cares BE channel constraint")
> 
> That isn't a valid hash...

Indeed :) Sorry about that, it was f4c277b817cc (drop the p)
