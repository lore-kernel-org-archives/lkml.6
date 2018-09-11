Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFA4C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A399204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Wme4xofE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A399204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbeIKOw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 10:52:58 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:39242 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbeIKOw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 10:52:58 -0400
Received: by mail-it0-f47.google.com with SMTP id h1-v6so658752itj.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 02:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc;
        bh=u5BkxY+oRfyXUFoEOZvXJG0D6J+f+qv4P4sIMVkrFC8=;
        b=Wme4xofEa5BxfKaKeDVwXdnat3J4vZxTk0kjDX+yWX9s4rjJdvbT8SdbAFh65KdE2A
         zb8fMZH3hrI6gi7XSSmczqPCi4dRZ//Ir4ax0t8DPOsJZwM80mo/rkmxQX8oDKLL1UjX
         H27AT+hXpD+hCElM9e2s8Zh4NMchVLQmrghTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc;
        bh=u5BkxY+oRfyXUFoEOZvXJG0D6J+f+qv4P4sIMVkrFC8=;
        b=PDoRjBY/0VOTZZgeyiPZOTcriNpDs3663h0CZidcapXmZE1e3NbbyVAr8UabZFf9p0
         JoE0aBfBXAyHkHTpIic737NRf3GS4DeuR627nLoUiEWYa5LpHavzKmY3Nd6wUb8V+Bjc
         kv/Cop5QJV+2FBk+dasy0l2MT34QSg0I4BAPfO6+gue+cmoyxykZ4epmbyMRjeMwS/37
         VTPUyY+igifJcJhHEEqLZMqfZ9klBGfyKcmxGOUEeY8OMWGGBrcSjDe+6uZPSHZhWKBA
         S8qFkBnYCTOufZQrCrcfT2P4bekqCPc9Woj58Mxcy7kf0Mj3o5EVWMHvQ0LoQR68YYE+
         LOkQ==
X-Gm-Message-State: APzg51C0ZcP32+Bvhi7Us1jUba/f+5UU3Cu1teuOM51g3L8u8BPaCdfr
        VkH+KGjKjvysWEwu8ngpGWUmqzJu4dTra1gJkp/WDg==
X-Google-Smtp-Source: ANB0VdYuQDJAlVf2qWPyfet61a3rlCmFh8EdLyRTxaiFw393Py8tF/2VROSRUWMw1ep3KkRkTSYaXSPHsVhKPPy9Jt8=
X-Received: by 2002:a24:eec7:: with SMTP id b190-v6mr704322iti.32.1536659664379;
 Tue, 11 Sep 2018 02:54:24 -0700 (PDT)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
References: <eccc46e12890a1d033d9003837012502@mail.gmail.com>
 <20180829084618.GA24765@ming.t460p> <300d6fef733ca76ced581f8c6304bac6@mail.gmail.com>
 <20180911092126.GA10330@lst.de>
In-Reply-To: <20180911092126.GA10330@lst.de>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQL9fTS7902n0VSYivL2AMCzXDd9xwGQx87UAiSubfsBEAZEn6JyQukA
Date:   Tue, 11 Sep 2018 15:24:22 +0530
Message-ID: <0b542db5145d878ef1b839387445987d@mail.gmail.com>
Subject: RE: Affinity managed interrupts vs non-managed interrupts
To:     Christoph Hellwig <hch@lst.de>,
        Sumit Saxena <sumit.saxena@broadcom.com>
Cc:     Ming Lei <ming.lei@redhat.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org,
        Shivasharan Srikanteshwara 
        <shivasharan.srikanteshwara@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> The point I don't get here is why you need separate reply queues for
> the interrupt coalesce setting.  Shouldn't this just be a flag at
> submission time that indicates the amount of coalescing that should
> happen?
>
> What is the benefit of having different completion queues?

Having different set of queues (it will is something like N:16 where N
queues are without interrupt coalescing and 16 dedicated queues for
interrupt coalescing) we want to avoid penalty introduced by interrupt
coalescing especially for lower QD profiles.

Kashyap
