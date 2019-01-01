Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB541C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 21:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 716BA2075D
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 21:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMDj26td"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbfAAVOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 16:14:16 -0500
Received: from mail-qk1-f177.google.com ([209.85.222.177]:38327 "EHLO
        mail-qk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbfAAVOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 16:14:16 -0500
Received: by mail-qk1-f177.google.com with SMTP id a1so17013007qkc.5;
        Tue, 01 Jan 2019 13:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CTq7IoGF1tZTgS+Tvf6pyDSgt77gp3pd8SqthfgklVk=;
        b=JMDj26tduCwljLUqoaRK+J1pLyEIEas8onGbGIb21oxS/P/kIHAyfCGmMgBIR4Ec6o
         yo0K/WyIUnXwaDbqAUG1vahjRKj5JEEkIRrcegKH7ROEC7VkS4aWwv7TGAxpEEaoA/Tg
         qJQoI7NhfuG3QmYyFqIFfsiq/FBaxasS9cHQGVhKNY6a3TvDjVIKn+6yGewi8KHCNzJr
         iS7fXWSTVSbj4FYLr2tbUI9CfaPrHQcgYFitxcOichMBbC3988eNcpBwS9qrivs8Wsf2
         /6niE2iM2JPZ4qf1Dv+GaOkPfpX8XKtQ4OzpD0ctzQEQ+VCLNScWGzInuCTsEygFQ/ET
         3ocA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CTq7IoGF1tZTgS+Tvf6pyDSgt77gp3pd8SqthfgklVk=;
        b=VzKU75zh5AFW/ieOMH2GyCCuWXssU1kMzqQ9SV0uPtyUOXxMqPQs2+fTnZVbjJpCWv
         XrD92NwMEDq4Sk0yNBzk50j2ZovD9YCu79E36EIr2ytoZY9NnGre9njVuA5CQIV7D/Gz
         HI8V4BQBvUUSfEIztkylU5PZSvWR+JQ0pTvtIIjQrAHD2SCURmI3YB3sD/7TeU2B0h+l
         B35dnWB1FyEfqT+tRcSdI5ALp2wPAYHR5QG+NVGj6YxNd719z+tuVpS1y7nk/lXGDVI9
         jtrEnxIZ3Y0Hb2Ue3xCBK0OAG41ULMYdR4eqV562wFAY0UQSn6S9gu2jXVfsJjfp7Kzd
         Ac+g==
X-Gm-Message-State: AJcUukfgV/+Bx3LZEv79aBQq1AaUsHCFS4iZ4pMFpiDt0iXCAFy1ELzs
        pMqkGtMQSDbperCJpKRg8nVuv39To1CNvEDFETatfLtTV0c=
X-Google-Smtp-Source: ALg8bN50GqRIuUVyRrQiWARg24t+wlXTfYXbMaW87+DDlcxPeoAsjj3IM30WI8GcO3hZk7um07LefGeS7xEuORDp4PM=
X-Received: by 2002:a37:bdc6:: with SMTP id n189mr37838018qkf.330.1546377253497;
 Tue, 01 Jan 2019 13:14:13 -0800 (PST)
MIME-Version: 1.0
References: <CALaQ_hoq+QfxGTi5aggfm6RehsiZOvmYk-Mz-Geu3TLdNrRXcg@mail.gmail.com>
In-Reply-To: <CALaQ_hoq+QfxGTi5aggfm6RehsiZOvmYk-Mz-Geu3TLdNrRXcg@mail.gmail.com>
From:   Nathan Royce <nroycea+kernel@gmail.com>
Date:   Tue, 1 Jan 2019 15:14:02 -0600
Message-ID: <CALaQ_hp26KFcF95-yY31rtdhiG3XKJ_A4_B7nsysbJMPEy6k5g@mail.gmail.com>
Subject: Re: kernel: xhci_hcd 0000:00:14.0: ERROR unknown event type 37 -
 Kernel 4.19.13
To:     linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        mathias.nyman@linux.intel.com, gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like this particular issue may have been due to a touchy/finicky
connection.

I removed my tuner from my hub and removed the hub from my
motherboard's USB and put my tuner in directly.
It STILL produced the error, but after I put everything back and
played around a little, the errors stopped.

Just to be sure, I also rebooted and it's still fine. No xhci errors at all.
The only thing I've done recently (within the past few days) was play
with my scanner which is also on that hub and maybe brushed my tuner
cable or something.

On Tue, Jan 1, 2019 at 12:57 PM Nathan Royce <nroycea+kernel@gmail.com> wrote:
>
> Kernel 4.19.13
>
> 00:14.0 USB controller: Intel Corporation 9 Series Chipset Family USB
> xHCI Controller
>
> Around 400 "unknown event type 37" messages logged in a 2 second span.
> *****
> Jan 01 02:08:07 computername tvheadend[2370]: linuxdvb: Auvitek AU8522
> QAM/8VSB Frontend #0 : ATSC-T #0 - poll TIMEOUT
> Jan 01 02:08:00 computername tvheadend[2370]: linuxdvb: Auvitek AU8522
> QAM/8VSB Frontend #0 : ATSC-T #0 - poll TIMEOUT
> Jan 01 02:07:56 computername kernel: xhci_hcd 0000:00:14.0: ERROR
> unknown event type 37
> ...
> Jan 01 02:07:55 computername kernel: xhci_hcd 0000:00:14.0: ERROR
> unknown event type 37
> Jan 01 02:07:55 computername kernel: xhci_hcd 0000:00:14.0: ERROR
> unknown event type 37
> Jan 01 02:07:52 computername tvheadend[2370]: linuxdvb: Auvitek AU8522
> QAM/8VSB Frontend #0 : ATSC-T #0 - poll TIMEOUT
> Jan 01 02:07:44 computername tvheadend[2370]: linuxdvb: Auvitek AU8522
> QAM/8VSB Frontend #0 : ATSC-T #0 - poll TIMEOUT
> *****
>
> I question whether this also caused kemleak to crash as well (will
> post after this).
>
> Regarding my tv tuner, it isn't supported by the kernel specifically,
> but is close enough that all I have to do is alter a single source
> file to include my device's pid, and it works just fine almost all of
> the time.
