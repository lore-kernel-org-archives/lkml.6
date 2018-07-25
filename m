Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53A9C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 601CB20882
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSDSB488"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 601CB20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbeGYQSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 12:18:06 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:37647 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728357AbeGYQSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 12:18:06 -0400
Received: by mail-vk0-f66.google.com with SMTP id v72-v6so3957365vkd.4;
        Wed, 25 Jul 2018 08:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mKvFcf9HM4qwTrOfP0SSasTN/CA7wUlrNHiMvmSH6TM=;
        b=HSDSB488bvycix0tWHNfBeOrSbAIaXurtnlZq24O9gS33k//EBoYSfS+Rre+BHpytn
         stLRxVGyvM9JCkNnyLGEv+zGNZbHJ1Oj0gV1E6RIIiS4kGVGD1Ryw0Turkmh6bWrMRml
         kEyxUGtoRclw1D0ibkWbV+TyIDJwYy/eLR86PjkCQ5dvH7bdYWFIsmTlcYKCsTjw4x3k
         9XfAcMqHLlVAQGDp5v0luQUIWz4ZPg1/7Y8qEviXHU6x4QG8wuqvHQFs5V2bOjrMvrB1
         c0ndAmmsoONJX2cOwfrPMKS1+t4/Seoh2ky1+gBvKDQgwwNt4RtHt06BBfn9EPJ6Y1tS
         tK+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mKvFcf9HM4qwTrOfP0SSasTN/CA7wUlrNHiMvmSH6TM=;
        b=mZdj6aOZYX+tHpXTsrJjg0bgFPIkZ/ysWveHewayAQYdRRXvCjtipqe/JOsjcpnWla
         xEHKyCrfOXL26NEy8R6xzv4ARW4mC00g46J6jaZ2phCQSXZLc0SLe9Rtj6+Sfg6S/5qF
         4uReik57TXuU85UGp6O5MJH+V5Z8T5quBKXZ3QYP1lVLXpaD/vIQhn++b9eQdOkbq4OH
         eeKxOQgXVtbNLS7vPgkfQbPc8MRXMCQnMLZwlUUJRMxApa8VXhCdGhp8emslGOAM/hC4
         g4BhVHSYgQiOwWQFDptAWNxU8H4dvUNCddVKZ3XXZSurXcpsVrvXo4eva2EV17gxK2ZP
         tzVQ==
X-Gm-Message-State: AOUpUlGhCnMrKoTGUXFsvzed4F1GHsiUWnSW8dibjTtX1VmYuP525esN
        QLBPGEYUTkt+KYvwSZ77hDV3Fjx5/Dib7e9R+FfOSJ3P
X-Google-Smtp-Source: AAOMgpeWoBrp8gnB8UGX81yEtGM/NHdqPzS0Lp+z5MgRgkr2hAr6smOHwJ22XUYOOO3CXg9BzQ5xGMcVsv1Wsgf86NQ=
X-Received: by 2002:a1f:c884:: with SMTP id y126-v6mr13017408vkf.76.1532531160695;
 Wed, 25 Jul 2018 08:06:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Wed, 25 Jul 2018 08:06:00
 -0700 (PDT)
In-Reply-To: <1532519491-19502-5-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1532519491-19502-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <1532519491-19502-5-git-send-email-anurag.kumar.vulisha@xilinx.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 25 Jul 2018 18:06:00 +0300
Message-ID: <CAHp75VfM8h9CKXO9bfmF74fcLW68Rs+1514Je=o1jOFd52Uf7A@mail.gmail.com>
Subject: Re: [PATCH 4/8] usb: dwc3: implement stream transfer timeout
To:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        v.anuragkumar@gmail.com, USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 2:51 PM, Anurag Kumar Vulisha
<anurag.kumar.vulisha@xilinx.com> wrote:
> According to dwc3 databook when streams are used, it may be possible
> for the host and device become out of sync, where device may wait for
> host to issue prime transcation and host may wait for device to issue
> erdy. To avoid such deadlock, timeout needs to be implemented. After
> timeout occurs, device will first stop transfer and restart the transfer
> again. This patch does the same.

> +/*
> + * Timeout value in msecs used by stream_timeout_timer when streams are enabled
> + */
> +#define STREAM_TIMEOUT         50

Perhaps, STREAM_TIMEOUT_MS 50

Dunno about this driver, but it's a usual practice to help reader with
understanding code on the first glance.

-- 
With Best Regards,
Andy Shevchenko
