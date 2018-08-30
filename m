Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EE5C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14E602082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ws/eMBl2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14E602082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbeHaC6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 22:58:16 -0400
Received: from mail-oi0-f51.google.com ([209.85.218.51]:43753 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbeHaC6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 22:58:16 -0400
Received: by mail-oi0-f51.google.com with SMTP id b15-v6so18418555oib.10
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 15:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UgrEfV0rIHKpcNHNj0CNpCD4giB7zB2RbJomp4hinyw=;
        b=Ws/eMBl2BcEbNJ6Yw6coWFkrIig6kSPezKMLQojbp9IkQ23+qqUVWT+fOnNHibST+8
         6agR1IsadgausfKfbRb6UuJT9ctAZ9UsMHsSHleibx94/xdRduW7ABOk4pNmOS/vZXUB
         6DrpEgHs+9FN1HIkjF7sMyZuHE6o/ebX5nT83umEU6un+MNADymS7cyIScLz/l+5qPVv
         vVWhs+r4FePCEj/I8F+q/q1/rBKG+hwAUdBdWMh+N2ut9OFUw+BZtOhbKQkYgVNk6iq3
         jiC7JyHBfgukKrGY/nvYDb3JpQ51K7d3+Tj/D0/mSaNXiWkHWU2epWgbCr8pWyG5u87J
         kvRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UgrEfV0rIHKpcNHNj0CNpCD4giB7zB2RbJomp4hinyw=;
        b=Mb3WLM020jpCAujfCxHpSWD0nNLzyYUqOAjbbt0eUz7yuAzvbSk9H9+MFtI82cQsyB
         baaAYg4xklvf3ZKG37k1r1TwjpoZyABXb+f7rGdZbdQsl5KVYjCfn1EVcLbEBEjgCDLu
         yculzKZsnPxf2y8ZSnPhrKnLDvvzt+6SjZqfE91r4rTlG/m90HqtAMxKgZuyqSAam1DY
         fmfYq8YfqZ7eSP90LWF51l/oIdV8R5hWYCHplIyY+6g2yD8+BbiJYLGf7wKA3mANWxpD
         X/oTP63GMzT/h6h+rmvgRMCfJO0oL2zdrunVINFqdVRKWgXOrerUC6iYGTAIKXmf5fqm
         ft2A==
X-Gm-Message-State: APzg51DYSyNSxS0WS1KxWcNpjCZygee0GHSE8z0pqQScHM2QZPOlUfLs
        JvknfVEyEg1OAfsZ2e/goPv+hm8P6Z1LQtMc1uQ=
X-Google-Smtp-Source: ANB0Vdb8XBJpShXhQxipjfBTcUNMH4Wb5syRGnHOyoTuryNnaAk9GfhnN7MFtYmTO4EDSXbFWwtiInwMit5FL+D9BMg=
X-Received: by 2002:a54:4081:: with SMTP id i1-v6mr4361787oii.73.1535669627404;
 Thu, 30 Aug 2018 15:53:47 -0700 (PDT)
MIME-Version: 1.0
References: <20180830223429.30051-1-igor.stoppa@huawei.com> <20180830223429.30051-19-igor.stoppa@huawei.com>
In-Reply-To: <20180830223429.30051-19-igor.stoppa@huawei.com>
From:   Bart Van Assche <bart.vanassche@gmail.com>
Date:   Thu, 30 Aug 2018 15:53:36 -0700
Message-ID: <CAO+b5-oODmT7_tFFzZZrouKUnbm5aXZz4VXS_WkzV-JVzPgPLQ@mail.gmail.com>
Subject: Re: [PATCH 18/23] infiniband: scsi: remove unnecessary unlikely()
To:     igor.stoppa@gmail.com
Cc:     Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        igor.stoppa@huawei.com, Bart Van Assche <bvanassche@acm.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 3:35 PM Igor Stoppa <igor.stoppa@gmail.com> wrote:
>
> WARN_ON() already contains an unlikely(), so it's not necessary to
> wrap it into another.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
