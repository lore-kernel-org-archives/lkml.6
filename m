Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D160DECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 16:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A26D214DD
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 16:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="iX8hUhNO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A26D214DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbeIQWEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 18:04:44 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38782 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728808AbeIQWEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 18:04:43 -0400
Received: by mail-wr1-f68.google.com with SMTP id w11-v6so18016623wrc.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 09:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AByq2AhHXWnJDosROY6yaJ3l5HETmewYU/Jp+CoJNlI=;
        b=iX8hUhNOzDgPiAHzEV4qB6SYq/1dINNyxvsLBJ9kzC0gHTAYIPaFvXcm4rU4Tt1nfU
         hh/yWUL+GrGaDs7RMCuxInkt3y2Q+EBGPO629gxArXfSTA2+RkA1NkyWya9CGYWRFIlk
         HfHQ7lMMPWGUYQsdwaoATEpX0UXgGPQVdpueLKwWN9v9SoPa6sGbdRNge1Im40496QQt
         vJxm0KZLzbiBULeJuY06lzQFc5T70hFsgf6MoGUVkK5M938mhbNv66UZQQDyHpbfLugv
         e+gUFDYmySiGgJmxOFamcaKOdnEHUMxKBrcVaLzgwokRnzmuOQWPTNVwo6Ndp4kIeAIg
         zC0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AByq2AhHXWnJDosROY6yaJ3l5HETmewYU/Jp+CoJNlI=;
        b=qwE6LVaFdMlEsGKwg0s2ICfKtudLzce50/Y9qf/lzDGLLHgaCZs53/Uu5fmlTbYVFu
         xMBdrkGOCv4nrvmpBIh/+yHK0j//Pjtrm2hU8EUbOFmJEg/RNjXD+VUQbm/glGDvpVSk
         aba/xvdsrcoXOvM75WYP2zalZHkeNA6LH9phRG1qlnMCKPNvfwEBq7rQC1/yrR4aMLrs
         psWrrQtToAXHuVxTqj64+1EF1kr1dADBIJ+JwZbDv9fpy3h9WbYikY5/aAVpA8D/z31A
         dsgUvcmiAxZ0+/R8yqFLd1Mc1Ql0N2ZGSIAxPtbLKOia+g5B8Tryd+5uK9SF1wMWZ9co
         cdcw==
X-Gm-Message-State: APzg51B2JmmqhjHSXSTrck1p/30y2Cky1o4KpPwvrY0a6oxydwu50enb
        ktEOTR7hSm+4DuB7i+JUqZ8FzzwVsdiPoJoLdlhf/A==
X-Google-Smtp-Source: ANB0VdZvT66Aio1YB55L4rd9hNYtJXMF68NeFm2wYhqlvQttvnLyQaEuHov5mkiBZUNZ0z2W3QerFN10Ioa/vUs57mc=
X-Received: by 2002:a5d:528f:: with SMTP id c15-v6mr20179228wrv.102.1537202194685;
 Mon, 17 Sep 2018 09:36:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:686:0:0:0:0:0 with HTTP; Mon, 17 Sep 2018 09:36:33 -0700 (PDT)
In-Reply-To: <9c33c57e-2ce2-8752-b851-f85c03a7d761@xs4all.nl>
References: <20180911150938.3844-1-mjourdan@baylibre.com> <9c33c57e-2ce2-8752-b851-f85c03a7d761@xs4all.nl>
From:   Maxime Jourdan <mjourdan@baylibre.com>
Date:   Mon, 17 Sep 2018 18:36:33 +0200
Message-ID: <CAMO6nay7u4nMZcND6+g-GJAFsFcGrp_GDKBhVjeXVzpjF0ND4Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Add Amlogic video decoder driver
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-09-17 16:51 GMT+02:00 Hans Verkuil <hverkuil@xs4all.nl>:
> On 09/11/2018 05:09 PM, Maxime Jourdan wrote:
>>  - Moved the single instance check (returning -EBUSY) to start/stop streaming
>>  The check was previously in queue_setup but there was no great location to
>>  clear it except for .close().
>
> Actually, you can clear it by called VIDIOC_REQBUFS with count set to 0. That
> freed all buffers and clears this.
>
> Now, the difference between queue_setup and start/stop streaming is that if you
> do this in queue_setup you'll know early on that the device is busy. It is
> reasonable to assume that you only allocate buffers when you also want to start
> streaming, so that it a good place to know this quickly.
>
> Whereas with start_streaming you won't know until you call STREAMON, or even later
> if you start streaming with no buffers queued, since start_streaming won't
> be called until you have at least 'min_buffers_needed' buffers queued (1 for this
> driver). So in that case EBUSY won't be returned until the first VIDIOC_QBUF.
>
> My preference is to check this in queue_setup, but it is up to you to decide.
> Just be aware of the difference between the two options.
>
> Regards,
>
>         Hans

I could for instance keep track of which queue(s) have been called
with queue_setup, catch calls to VIDIOC_REQBUFS with count set to 0,
and clear the current session once both queues have been reset ?

You leverage another issue with min_buffers_needed. It's indeed set to
1 but this value is wrong for the CAPTURE queue. The problem is that
this value changes depending on the codec and the amount of CAPTURE
buffers requested by userspace.
Ultimately I want it set to the total amount of CAPTURE buffers,
because the hardware needs the full buffer list before starting a
decode job.
Am I free to change this queue parameter later, or is m2m_queue_init
the only place to do it ?

Thanks,
Maxime
