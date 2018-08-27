Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D6E9C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41FDD21746
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dug-com.20150623.gappssmtp.com header.i=@dug-com.20150623.gappssmtp.com header.b="weZ1VTw6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41FDD21746
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dug.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbeH0LvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 07:51:11 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33826 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbeH0LvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 07:51:11 -0400
Received: by mail-lj1-f196.google.com with SMTP id f8-v6so11607716ljk.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 01:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dug-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ALCwcykmaU0YOxg+d8a4J5QlmaiBIWFIT/+5PZOF8lA=;
        b=weZ1VTw67Z4nCUn5ubWjUIgaVO8qIG64n9SHAWUz1WBL7o51Oi0+ffJk6wyig12K9o
         SlXvpAmBhbS+yiFrKOt55n+1pjCGyfSXGhlr5OjTYGdSBPVGEoiVxtVFb4tkWqnZXc/6
         LvNZJIy7tgEHO/5OudyhaUPBj9kumi6iMb6iNG/2exaWhytBO0ggqoIM46ZBbmgFc+mL
         oZ2+uQBjsbiEz4OkKFl8LwzI7R1iQYhdp2urAd3Hmg1GIOAAyhH07gxvqPPPtOkBuVtj
         zIWFERG7JfNalyA5bInUdFzlEi41XpKyToMDTpPn1CIYdpkdb5/w/VAMq261zw5rRRhw
         CASQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ALCwcykmaU0YOxg+d8a4J5QlmaiBIWFIT/+5PZOF8lA=;
        b=rXs7jKrd4y50McY4tqXNKYEK/qxkoqCt5nj5FYGlq3UEdyOvAdz8FYmnumxKsaioRX
         PT7cVqrzrXdCMJxwNGHWfY8+38HnIB76XsTW848ENO1T0sjiSkbNEZVWnVt5LyNuBAkz
         yKi1MH8kECNNB9pJ3voV36Ch0srInwAoEYyEeUjBTYnWnaIZ2X/NqsllHDsI4X3dLqUt
         cQRSO23ECUGUVtLlTaSToT1m2Bx9J7FOZSd4mAh/obFOrU3I3zqq0btesoWwnoOD7uQg
         xMGiFD2f6DjgKgHJERXcjKlhdDt6llrWxEdrZmFEozOGEBU+0yhVCknUexXDXJO1pp3+
         9eYA==
X-Gm-Message-State: APzg51BuKDL3wWkrRIxm28u7zAa4WdDoJaBHxWqoR6kVPTAoDJlGtmtG
        NaYmwJEY+LKE6UI4WeTogHMNtL2aOos6QonVWa5H6A==
X-Google-Smtp-Source: ANB0VdaDMI8G+72clQ5KjaCkX1pEj7L2a+fqXjp3ZonDC9oleK1yhOHdjE+ziUzrXwAV4mLqXXqljpKhmOjdQWvATJQ=
X-Received: by 2002:a2e:8098:: with SMTP id i24-v6mr7549954ljg.36.1535357136736;
 Mon, 27 Aug 2018 01:05:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:390c:0:0:0:0:0 with HTTP; Mon, 27 Aug 2018 01:05:35
 -0700 (PDT)
In-Reply-To: <20180827075248.GB18175@nazgul.tnic>
References: <20180825035039.14409-1-jacekt@dugeo.com> <20180827075248.GB18175@nazgul.tnic>
From:   Jacek Tomaka <jacekt@dug.com>
Date:   Mon, 27 Aug 2018 16:05:35 +0800
Message-ID: <CAKVxXCX9H_LvNVayNxBq5NPLDWLAothi_Y2+my+2qN7srfH=mA@mail.gmail.com>
Subject: Re: [PATCH] x86/microcode: allow non-root reading of microcode
 version and processor flags
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Jacek Tomaka <jacek.tomaka@poczta.fm>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 3:52 PM, Borislav Petkov <bp@alien8.de> wrote:

> Your From: is Jacek Tomaka <jacekt@dugeo.com> and your SOB is different.
> Which one should I use?
Please use my SOB: Jacek Tomaka <jacek.tomaka@poczta.fm>

> (Having a single email address for both is easier...)
Sorry about the trouble.

Regards.
Jacek Tomaka
