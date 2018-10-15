Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1FFC71130
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6180B2083C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:17:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6180B2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbeJOUCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 16:02:31 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37651 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbeJOUCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 16:02:31 -0400
Received: from mail-wr1-f71.google.com ([209.85.221.71])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <guilherme.piccoli@canonical.com>)
        id 1gC1oN-00066r-S6
        for linux-kernel@vger.kernel.org; Mon, 15 Oct 2018 12:17:27 +0000
Received: by mail-wr1-f71.google.com with SMTP id f13-v6so16093518wrr.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 05:17:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AOb1R5aFH5r0sqhjBZszXEV/tmHnzZ9QfAusThRgpdQ=;
        b=JHe7hzoJUBp06VL/pawaFDD+usyCqlQIWaQzWKEH8dUn7x3z/geotHhDMcFIaNs7Di
         dbCUpfvChbF8aHs1rlhyoz/UnqnUNfLskYnmiQq7fXGEi8ND604st4A4IG75pzjbsSA+
         GKlwQtUYzcl7vMEHAPUCah7Ab+ZBFrkqAVqJ3CdkQfGPd7VHIku9O7GJbbGPqFqFScCQ
         ThJmu9ff9jqH7fxpaHxLETzoQ7uEiGtPSsQ5A+zlJGnQLJCNzcMnulNjxE+9VtW5j0u3
         YthxvLMI8NP8c7eZe65fS+JdmPadO+hFnTYAe6BYaG73IgCVFoCMnauSJLTX2sSpYBHC
         9GGA==
X-Gm-Message-State: ABuFfohfSRBcdOFuneAQ7xiXm1XIcHtdKTs3H9zbecr0OfkBj4q8ov9F
        sLj0ODCOO8XzPJcd9HnV4beNRIMJvxhg5qHwnC5jdlnTaDteGjpDkh1AVcXgp7X579Jfw+0hERW
        5wuKZcpHqTd1Dx7M68PbvhOsdYb9K2xboLUzoD5Gq8fAq9g7wENMtJm6SbQ==
X-Received: by 2002:adf:ba87:: with SMTP id p7-v6mr13438141wrg.203.1539605847588;
        Mon, 15 Oct 2018 05:17:27 -0700 (PDT)
X-Google-Smtp-Source: ACcGV63JqQBxTiE/ChIhH0TMY9S8NiTQ8YXGZuKPtb81wfuKUHn6REroKQ7L8tsdZ8jxq0D8dp8i6k+XmcXyuwJrY6M=
X-Received: by 2002:adf:ba87:: with SMTP id p7-v6mr13438129wrg.203.1539605847339;
 Mon, 15 Oct 2018 05:17:27 -0700 (PDT)
MIME-Version: 1.0
References: <8c61fd04-969a-cb09-6595-7ee23d214ab1@canonical.com>
 <99f1353a-e1a0-5ade-4aad-3eb62ea42a66@canonical.com> <1538515983.4348.93.camel@arista.com>
 <CAHD1Q_xv4PSsJ3AcKd5i+QZ8On9jqPZsa+p46bCiKubhzVJerQ@mail.gmail.com> <1539359857.2706.23.camel@arista.com>
In-Reply-To: <1539359857.2706.23.camel@arista.com>
From:   Guilherme Piccoli <gpiccoli@canonical.com>
Date:   Mon, 15 Oct 2018 09:16:51 -0300
Message-ID: <CAHD1Q_zmHfMaD5cYH3e0RdcyDXdVjkkX6sqN22H0htQmmRQ0_Q@mail.gmail.com>
Subject: Re: [PATCHv5 3/7] tty: Hold tty_ldisc_lock() during tty_reopen()
To:     dima@arista.com
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 12:57 PM Dmitry Safonov <dima@arista.com> wrote:
>
> Hi Guilherme,
>
> Just to let you know - I've done with more urgent issues now,
> so I'll be back on this patch on Monday, installing qemu-system-hppa
> and debugging the root case.
>
> Thanks,
> Dmitry

Awesome Dmitry, thanks for the heads-up. I'm willing to help to debug and test
too, I'm still trying to reproduce here.

Cheers,


Guilherme
