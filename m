Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281E8C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDFE02080A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RvaadJPM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDFE02080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729975AbeKADDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 23:03:13 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44359 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729357AbeKADDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 23:03:13 -0400
Received: by mail-lj1-f193.google.com with SMTP id k19-v6so7168979lji.11
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 11:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zXRgRI5pnmUBoinZARXpNxJmOznmU+GSTbP95319txQ=;
        b=RvaadJPMlPrfm2djm8w4eTOefeRn07ye1kxTjV+SHMI/n4ZRZBK4vxNrOlA6VUMjVg
         KV0QNELhvzwh0IPfM2HDg+H+2BvM854INCSdrrg4TtD2HKZtC5cHCEK/NmbRiej48Lcq
         MLs2GCUd8Sf1wz0HmaZ7NCuLGYHkWsqZg1F1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zXRgRI5pnmUBoinZARXpNxJmOznmU+GSTbP95319txQ=;
        b=GpCBYWOT+pdgUccgb4zVjHqF4iZL+KHfHByMQA1S54HZ6Bw8uKiD46xFpCa/nPbIc7
         9NjbkT28c+xME3MbsIT6nDRzl/mSdUOzy8YyxSaD+MSJ7sPzyxBdRAkkZRFcUbFe7gaX
         mn3OyaFCbhDa/6b19hI9F/Pnpv4nYfpVsx3+GpK7vw2FQ4QpLLtwmtHwwQEvBuwshseN
         3ANPgaE1Gp1W6+cTMb91POdtIGV4Gr1gl3xqtvq3IzJdtCcdCpcE4E/B05De52+mtg62
         zXohONW9vv9BeeNsYp1oRRZwZR+ldvw3t0viCdMtk5a79qTFktxuceR9MlUvGl8GjwA3
         TpLw==
X-Gm-Message-State: AGRZ1gIkAEWOGNyngQQLg8OR0C6bqIZh3PgbTlIqoGfPEQU/a1+v1l18
        OxU0QQNZhCXm6/V8lOoVE0E+R9XbpXjp0Q==
X-Google-Smtp-Source: AJdET5e7ysoBSDod7B5NQ/XIWiQLIMe3nvsn/5qW+U26V8+H+OddFB8ezJGEShY8lN9zu6c2cvr7FQ==
X-Received: by 2002:a2e:350e:: with SMTP id z14-v6mr2655473ljz.49.1541009046096;
        Wed, 31 Oct 2018 11:04:06 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id q13-v6sm4223118lfk.25.2018.10.31.11.04.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 11:04:05 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id x85-v6so11481384ljb.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 11:04:04 -0700 (PDT)
X-Received: by 2002:a2e:874e:: with SMTP id q14-v6mr696235ljj.120.1541009044061;
 Wed, 31 Oct 2018 11:04:04 -0700 (PDT)
MIME-Version: 1.0
References: <20181030144910.460a8635@w520.home>
In-Reply-To: <20181030144910.460a8635@w520.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 31 Oct 2018 11:03:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg8qX2qnRuunbm9SPR-xhSP9gr3E1ES6xU49=0vaXBuGw@mail.gmail.com>
Message-ID: <CAHk-=wg8qX2qnRuunbm9SPR-xhSP9gr3E1ES6xU49=0vaXBuGw@mail.gmail.com>
Subject: Re: [GIT PULL] VFIO updates for v4.20-rc1
To:     alex.williamson@redhat.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 1:49 PM Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> VFIO updates for v4.20

Pulled,

                   Linus
