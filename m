Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DF1C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 20:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B19EE2083F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 20:09:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B19EE2083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbeJEDD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 23:03:58 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40311 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbeJEDD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 23:03:58 -0400
Received: by mail-pf1-f195.google.com with SMTP id s5-v6so3910147pfj.7;
        Thu, 04 Oct 2018 13:09:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=828Vwuzv9z3xgzCoJykZprfmqgh9ENoEERPPFWqIA88=;
        b=sC+K/R79ebCjQs1FlbvNyHWYWORnCiEqnMpiRDNkSLDD/J+v23FP3tanVrM+7xNy9u
         jyTqEkUT8DFz9FtCi+rcV7SIEQnIEzLa7pOxsbdqaURIkqdXA+hQJCaEs24ZbAd7i88S
         qoGoTF/v1wP3XU3MPzAXiSUYWkniwOq9xpMmCUl+XN5jQaHbIzJN4mqye28Wx1lhTlp9
         wN2F6If9lfAuyK5ZWoVY72pKWV80mY2moiEYdfpPcMHNzbypYkdb4QeceKoTLztWSzCb
         +mR2gWZMMtYHzrHmP/MIoEYyPvuwxnCFqnz77DVDh5LQjecMbN+2SauYHeP36A9XgqT6
         wfyw==
X-Gm-Message-State: ABuFfohK9lWiv8FCmJJDslkNd79QgAbHsR4F4/E9pOJsDBWljgF+oKyk
        C/bhfLwU/fWrR6vUqTFzMLg=
X-Google-Smtp-Source: ACcGV61Vq4XTm3LXEYO745k0tJvU832P7ap507Ytw0xN6WPnjTo/IN8ag6pTgrfQXruVhiJOImRSqg==
X-Received: by 2002:a62:1095:: with SMTP id 21-v6mr8257039pfq.227.1538683748430;
        Thu, 04 Oct 2018 13:09:08 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id w127-v6sm7843726pfd.112.2018.10.04.13.09.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 13:09:07 -0700 (PDT)
Message-ID: <1538683746.230807.9.camel@acm.org>
Subject: Re: [PATCH] block: BFQ default for single queue devices
From:   Bart Van Assche <bvanassche@acm.org>
To:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-mtd@lists.infradead.org, Pavel Machek <pavel@ucw.cz>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jan Kara <jack@suse.cz>, Andreas Herrmann <aherrmann@suse.com>,
        Mel Gorman <mgorman@suse.com>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Thu, 04 Oct 2018 13:09:06 -0700
In-Reply-To: <20181004202553.71c2599c@alans-desktop>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
         <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk>
         <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
         <1538582091.205649.20.camel@acm.org>
         <20181004202553.71c2599c@alans-desktop>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-10-04 at 20:25 +-0100, Alan Cox wrote:
+AD4 +AD4 I agree with Jens that it's best to leave it to the Linux distributors to
+AD4 +AD4 select a default I/O scheduler.
+AD4 
+AD4 That assumes such a thing exists. The kernel knows what devices it is
+AD4 dealing with. The kernel 'default' ought to be 'whatever is usually best
+AD4 for this device'. A distro cannot just pick a correct single default
+AD4 because NVME and USB sticks are both normal and rather different in needs.

Which I/O scheduler works best also depends which workload the user will run.
BFQ has significant advantages for interactive workloads like video replay
with concurrent background I/O but probably slows down kernel builds. That's
why I'm not sure whether the kernel should select the default I/O scheduler.

Bart.
