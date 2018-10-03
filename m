Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B17C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A017820644
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:56:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A017820644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbeJCWpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 18:45:47 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35533 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbeJCWpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 18:45:47 -0400
Received: by mail-pf1-f196.google.com with SMTP id p12-v6so1907532pfh.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 08:56:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sNa4gvNipovMEih9uq9u3hfhinaCO/faXsGKMCrwRtU=;
        b=WaB5f1OOtKuvBl/OB9eF2p+fXX/9xu3QjoALXypko361Qvzageot4MkEEjv9+NWJmL
         TYOtrLlkGKRQpFC56Cpy74VztD1uYqvcV+QUBb4ZbuN0jV5kDl23OESy0p08al5iIOZl
         HvZ03BPB8IUZqSKm/Acvrl1xSseQJBjR8F7HTc+RnieF4KEAwbL0iYE8BF2cz28Rftxx
         xERIiMYtWWEGAgZyPofhNGNVGNp1LJUaFd9649KKMt3yrn4Fe/aZqqzyqpjRxXPkze2x
         23bkbBMgNJYxZ4KLr88hlyZUDcfH5kBqgAulC57EKjPq22eIM7y/bUiz9oxmfndOcGwm
         o2/w==
X-Gm-Message-State: ABuFfohlJkNtCM7W3ELlzrDTNmZf+XPodrfe7jsCsmILOSVCv8n5VNe5
        iHnHa3FzXGpTz8ZQEXJJycPxCmfy8ITSfw==
X-Google-Smtp-Source: ACcGV62LNaixhFONvtufr90QVIIoMCxDuHR80anWHTTZYlfGm2J8jX0J01FtjjC64dZLefHe/ygG0Q==
X-Received: by 2002:a62:8490:: with SMTP id k138-v6mr2247690pfd.177.1538582208028;
        Wed, 03 Oct 2018 08:56:48 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id m27-v6sm3558012pff.187.2018.10.03.08.56.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Oct 2018 08:56:47 -0700 (PDT)
Message-ID: <1538582206.205649.21.camel@acm.org>
Subject: Re: [PATCH 0/6] lib/scatterlist: sgl API fixes and cleanups
From:   Bart Van Assche <bvanassche@acm.org>
To:     Tvrtko Ursulin <tursulin@ursulin.net>, linux-kernel@vger.kernel.org
Cc:     tvrtko.ursulin@linux.intel.com,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Date:   Wed, 03 Oct 2018 08:56:46 -0700
In-Reply-To: <20180926141625.17727-1-tvrtko.ursulin@linux.intel.com>
References: <20180926141625.17727-1-tvrtko.ursulin@linux.intel.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-09-26 at 15:16 +-0100, Tvrtko Ursulin wrote:
+AD4 From: Tvrtko Ursulin +ADw-tvrtko.ursulin+AEA-intel.com+AD4
+AD4 
+AD4 Mostly same fixes and cleanups I've sent earlier in the year, but with some
+AD4 patches dropped and some split into smaller ones as per request.

I think in order for a patch series to get noticed that the maintainer the
series is sent to should appear in the +ACI-To+ACI field of the e-mail. If you
resend this patch series, please Cc the linux-block mailing list and please
also use my current e-mail address. I only noticed this patch series today
because my old e-mail address occurs in the Cc list of this patch series.

Thanks,

Bart.


