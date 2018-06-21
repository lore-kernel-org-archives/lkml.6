Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02456C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1132208A1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IAtrvfp0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1132208A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933114AbeFUIQg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 04:16:36 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:38356 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932528AbeFUIPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 04:15:21 -0400
Received: by mail-it0-f68.google.com with SMTP id v83-v6so3543393itc.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 01:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MPYff/pYZSFNhhQyfQx4STm/AKPvaIYbpQq5B+hPb1c=;
        b=IAtrvfp0nNlBYfmyZAz4N69nfQ4vgKg28zHTmBDxGSBWaSKnokcnbcRcU8YK8QcPI3
         c1qBetIgHRYb20ojueQ+IFiRvaULum15CMwiiE55pCwwUrOcK6dL8m9CxbbJm0VqJbdz
         THbKHZ4atbQQCre4pdUTBSVFMJJ03Y2ApRT8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MPYff/pYZSFNhhQyfQx4STm/AKPvaIYbpQq5B+hPb1c=;
        b=k/R/r8CrL+EryLDqMf3IHWLw5YGPDVc86pISHO3xXRtvKFA4USYjBAsjG1/ha4TXKE
         5TZjRBPwJ37DuBEbEMryzR5OqfURJ7/gnq6qn6qXxthptH+jgZR0Z7pCcM9tG/lq6d8v
         /LpGA+MYBa7Cl6q8xOUKNubSpKVwXnfPTZqtn7bDnYuvcBbD0k/p1tw5oE9GYApYj43w
         NQAa5+qnUaA6+QrRdP2N0o78KmzZZddSyWMIGV2s3csmq2e6OSpWbHf4YcmCwBmF27tx
         pIfF0b1mYxJdXkRTPCT44kQKHwVjlLYeSSfr5cJOqwkuuofwFiSLq4waKnIuLpMDuL7B
         a4ug==
X-Gm-Message-State: APt69E0nRoZ3fCU2j9orPvgQ7DBiByOzVi26yE5F8kZLGR/7Vkp+hSjH
        9oshtCYVuh5n0xpYBkykHcqHdYWS8dmPm82pXpw=
X-Google-Smtp-Source: ADUXVKIWCyDV2JOoKjWtBp3g10BpGGJEHFVyPrk0LZoOJO+ByDtsSskTIGyVBvsTXzE6drBfsVaVe7v+68RPB3VM12U=
X-Received: by 2002:a24:8046:: with SMTP id g67-v6mr4251656itd.16.1529568921120;
 Thu, 21 Jun 2018 01:15:21 -0700 (PDT)
MIME-Version: 1.0
References: <20180621080624.GO11011@yexl-desktop>
In-Reply-To: <20180621080624.GO11011@yexl-desktop>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 21 Jun 2018 17:15:09 +0900
Message-ID: <CA+55aFxXCD8qLfHcnshLR2_Feb=RLkOFfCeqPF_sShy7rK2cAw@mail.gmail.com>
Subject: Re: [lkp-robot] [Kbuild] 050e9baa9d: netperf.Throughput_total_tps
 -5.6% regression (FYI)
To:     kernel test robot <xiaolong.ye@intel.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        LKP <lkp@01.org>, Huang Ying <ying.huang@intel.com>,
        Aaron Lu <aaron.lu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 5:10 PM kernel test robot <xiaolong.ye@intel.com> wrote:
>
> FYI, we noticed a -5.6% regression of netperf.Throughput_total_tps due to commit 050e9b ("Kbuild: rename CC_STACKPROTECTOR[_STRONG] config variables")

That's perhaps a surprisingly large cost to stack protector, but you
did move from "no stack protector at all":

> $ grep STACKPROTECTOR config-4.17.0-11782-gbe779f0
> CONFIG_HAVE_CC_STACKPROTECTOR=y
> CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
> # CONFIG_CC_STACKPROTECTOR is not set
> CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

To having the *strong* stack protector enabled:

> $ grep STACKPROTECTOR config-4.17.0-11783-g050e9baa
> CONFIG_HAVE_CC_STACKPROTECTOR=y
> CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
> CONFIG_STACKPROTECTOR=y
> CONFIG_STACKPROTECTOR_STRONG=y
> CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

so you're testing the "no overhead" case to the "worst overhead" case.

                Linus
