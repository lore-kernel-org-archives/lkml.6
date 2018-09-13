Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF3FC43143
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 19:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7BD920853
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 19:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sfE5DRX+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7BD920853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbeINA4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 20:56:05 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:35759 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbeINA4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 20:56:04 -0400
Received: by mail-it0-f52.google.com with SMTP id 139-v6so9344657itf.0;
        Thu, 13 Sep 2018 12:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RhGKjVNuZ69pvS4r+DB/mHzU5FoCyggNhMHf7+Jacgo=;
        b=sfE5DRX+sEtgkCCDEEKsY4BozdyC6YIRcV3C93KKkqSU6bgjOIML157NAgv9u8Sz+M
         HjhpNgWeDfnKc9scCekj6kM9+xJsH8OYpFeZftA/K3+YU3aKVFiJ6VdIfDBzQfSNBZV3
         xEUGrUHzH50OwHBqdz/nBDGBgfbXSbSRAY09+Sik6bx615hQsj1R7J2ksDxBK5nfKpsd
         h/SG2EG/LHyPVe4fglFFUOOOycH9o7gEbKvTCeRYXcqImHVevVXBpPsGr5DFLRBtdwMt
         61JUHXZeo+zoSKrUf/eLXjNHTnAbF/v5m5wvjOca+oGXv0Zr65/WVRIgUIJSVTGk+ZmV
         vtTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RhGKjVNuZ69pvS4r+DB/mHzU5FoCyggNhMHf7+Jacgo=;
        b=my35JHkEREHZB6wynAH1W0RogG7QrW2uEy3EBfxZXeqZTyKSjLkh1zzS1wG10adXhZ
         FcqJzWKvS1rYrR9s0vAIFKlBjKB6PSYnWTDsw5xYnCf+xIm2Xn8ZTfQHP7sDAVJWjs7D
         6qCW4WuyS7D5p++Z2tpma9F+dSFtazb8DwLHyAqp5KUldRJzAAxbgNvCx50WERmumsdW
         STOJBQIRI4rYgHXWNVcoJfOP+3JqOwFoP62JwzNigraEv8SYXgIdZ6MYwMb/IL9lKK1n
         Mgk0O8S47Md1RNHYp7rzoZWjBalZcuIp/+slgSJRSziRPS0ZshjfICAZjDdpsNd53CYS
         hBqg==
X-Gm-Message-State: APzg51AvituTdLVkV7WH9O/l8EFhid+E5aWgEzF9nZMUEKgCgIhzK4Em
        lsLS+EZiFT3caAOHl9lcLA2B9DupwRTUW8djORmiun6/
X-Google-Smtp-Source: ANB0VdZlNg4l7YEfrN4EfHoDCdVOORpZ6+3cq3xIU+0iX0OgAV7sGWaz2D5OlV9d5/OTlWhLNvEA0HTqXuOrs7+z6E8=
X-Received: by 2002:a24:68c2:: with SMTP id v185-v6mr7626473itb.128.1536867907420;
 Thu, 13 Sep 2018 12:45:07 -0700 (PDT)
MIME-Version: 1.0
References: <20180912183519.GA31506@vnote> <20180912185517.GE3902@linux-r8p5> <c158b639852d48d382445d33da8c6a1e@AcuMS.aculab.com>
In-Reply-To: <c158b639852d48d382445d33da8c6a1e@AcuMS.aculab.com>
From:   Eugene Korenevsky <ekorenevsky@gmail.com>
Date:   Thu, 13 Sep 2018 22:44:56 +0300
Message-ID: <CAJC2YLb+YM11jzWLVTea6gEa=Ou2rdJC1rY9TbK+yOpAfyWFyg@mail.gmail.com>
Subject: Re: [PATCH v3] efi: take size of partition entry from GPT header
To:     David.Laight@aculab.com
Cc:     Davidlohr Bueso <dave@stgolabs.net>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Please rearrange this like:
> >
> >        for (i = 0; i < le32_to_cpu(gpt->num_partition_entries) &&
> >                             i < state->limit-1; i++)
>
> Better still cache le32_to_cpu(gpt->num_partition_entries) to a local
> so that it only has to be calculated once (even if it gets spilled
> to the stack).
> It can be bounded by state->limit-1 at the same time.

This is block I/O, slow path. No need for such micro optimizations here.
GCC is capable to do such optimizations automatically, and it does as
I can see from disassembly.
Anyway this would be a subject for another patch.

-- 
Eugene
