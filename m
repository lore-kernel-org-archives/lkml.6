Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B5CC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1641020652
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:11:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1641020652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbeJDWEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 18:04:43 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43231 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727355AbeJDWEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 18:04:42 -0400
Received: by mail-pg1-f194.google.com with SMTP id 80-v6so3283764pgh.10;
        Thu, 04 Oct 2018 08:11:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q2W8R1FFLUHNquwmu9Iew0zKD9sT9pbfhuPUxwlu5Rw=;
        b=nFBzMvoaiBZ/LOYd5vlFCQfMZiiEAWe/tm+dp7ZQtocDC8NZQHKwfeWPN8Vm5HKejd
         8MoUtRLe5GUbaHo8uLCJaoNT+vdD0dex2sh01WJwZuASI4SGt6dT+/vUSTaPqcdaqMu5
         A5pPZRSJ7HHG989k0QOj50okW0l4UUnxFF2IHQhvnt4j4zd8WkP/Oo+KGbarlV1a55IC
         YYuunGLOegwq0w9Tohl+mMDxCZm94CXj1LPr2Xx21nCkuh8KQb3pNG67XKmSvn+tvvMm
         +LOW6mnAaLdG+xAtpx7Q0j1Bx19Vzff2+K9enKhg4TEeEEnIF1thkxQ+UjdaaRVxj42x
         T1eg==
X-Gm-Message-State: ABuFfoim3W7NTTfv5XX/6wbscNoQiysnHoBeu/1q3fyG2Ip5XsZkAAjv
        8YeRPXgCe5iAVDKJEomqiikw+ahQkyH9CA==
X-Google-Smtp-Source: ACcGV62hRK5soVGadZevmYUKJmSC+/+0jFdhdwHSTio0dj6SuucY0nQjNmMS7q8ZqgUWV2KvfnxAOw==
X-Received: by 2002:a63:78cc:: with SMTP id t195-v6mr6136665pgc.329.1538665859979;
        Thu, 04 Oct 2018 08:10:59 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id r205-v6sm11437839pgr.11.2018.10.04.08.10.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 08:10:59 -0700 (PDT)
Message-ID: <1538665857.230807.1.camel@acm.org>
Subject: Re: [PATCH] block: BFQ default for single queue devices
From:   Bart Van Assche <bvanassche@acm.org>
To:     Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     oleksandr@natalenko.name, Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-mtd@lists.infradead.org, Pavel Machek <pavel@ucw.cz>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jan Kara <jack@suse.cz>, aherrmann@suse.com, mgorman@suse.com,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        bfq-iosched@googlegroups.com
Date:   Thu, 04 Oct 2018 08:10:57 -0700
In-Reply-To: <20181004101305.GA6412@sirena.org.uk>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
         <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk>
         <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
         <1eca41df95ff660eb247a3de666adeb4@natalenko.name>
         <CACRpkdYG2Y=rspbZ_o=H3REXTEfOcaiqEyQD4kzO=G=d63V3yA@mail.gmail.com>
         <20181004101305.GA6412@sirena.org.uk>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-10-04 at 11:13 +-0100, Mark Brown wrote:
+AD4 On Thu, Oct 04, 2018 at 10:14:38AM +-0200, Linus Walleij wrote:
+AD4 
+AD4 +AD4 And these are millions and millions of deployed
+AD4 +AD4 systems not using udev+-systemd we are talking about,
+AD4 +AD4 they are not fringe hobby projects. It's not that I
+AD4 +AD4 personally dislike udev or anything, I kind of like
+AD4 +AD4 it, but these tailored distros simply don't use it
+AD4 +AD4 and they are huge in numbers. They need help to do
+AD4 +AD4 the right thing. Fixing a udev rule doesn't solve
+AD4 +AD4 even half the world's problems I'm afraid.
+AD4 
+AD4 Further, even those embedded systems that do use udev (some of them do
+AD4 lean heavily on modern init stuff like that and systemd, especially when
+AD4 boot time is a priority) they'll still need to get the relevant udev
+AD4 rule installed somehow.

Hi Mark,

Are you aware that the systemd source tree includes a set of udev rules?
See also https://github.com/systemd/systemd/tree/master/rules.

Bart.
