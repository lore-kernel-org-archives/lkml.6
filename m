Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C832C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 17:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10278248AE
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 17:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="LnMvJUpc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d9uO6dAA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10278248AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753134AbeGBRAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 13:00:36 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:33697 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752813AbeGBRAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 13:00:23 -0400
Received: by mail-ua0-f193.google.com with SMTP id g18-v6so7752205uak.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 10:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=I+u58XWIlYuHmYzWNPSgoCLOzMQzWwK/OkSVwvLQASM=;
        b=LnMvJUpchRyHT64/O5UcQc3J1gMplNKrYp3UXThfLYg5RJW+3i7X9JncJalWrdwTQW
         yRzg6L7/SiE1LrOUfV9+airYx8BqScK0zuBOl/fE14OvynaylN8H+zz2426sinU6ocCD
         EBqtJRSHgJWVe9cGDMp0Xz6S7mnFTBEr0t8Tk0deL+LU5XRG96oV54dCfoTDWCI+r9Uc
         GNKnAhN++ok5EclNOKdJ+ie/ZfBUriMfCfrRk/s4GsW2fGmJVKRuHRO/DviPgQxlEoT8
         mSTniuZbihvsxFsM44ircVrbYbG73se6O4ogJJrG9Nv3ttMeU7U4iuA0OOMT8pa7wmHJ
         +RZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=I+u58XWIlYuHmYzWNPSgoCLOzMQzWwK/OkSVwvLQASM=;
        b=d9uO6dAAGER/ap/II3WK2YAVpJdqg2kuCzWuK3mYhuS7jbeDG2e2gcFgWOLiPBN9oz
         AOMikudObGxjDdIZtYV35V4gIyDUoQ6c1UBbPM3bwD7DgNxL1dIt8msFvseiKM03aYAL
         P0ee7Pm5MyQcfU3SvQf6+i+zQihYfEUkA0kO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=I+u58XWIlYuHmYzWNPSgoCLOzMQzWwK/OkSVwvLQASM=;
        b=ERmLPriJI0IGSgb2GRRXDHGqU+fyDmwvmUfPuzcdRnsJ9eKYlOC72PJTZFDq+KSMl3
         heYAvPgnnsQaF1g/ihdVAJwayN9ZM6zwyWDw1ywPsjIV1scz0BXdKe/jC2j5L+DpVbTb
         AES1Yo3SFuWV44RnWsRfthnlRohD06HeO+C3GMrc0le+ec9/dftykgxciipKVkhela4U
         q6nyQdmN0D00UU6X8sIEhI8qW4CWxAxk24q2VjqP0C1oRPCdNxMzr9c46BYl271r81qY
         4yQ1lzirnhYAgZxwvGmUmepdkdjcgUDilKsq/WLQIxpzFP98Z+sT+uY6RD2P6ONjw/P8
         tVEA==
X-Gm-Message-State: APt69E3TyRrKAm8pIKkLJY0NNAG69qHU3wLpchwDAqFhqsXyqNyCXKj8
        gkNh6GssmS+Bey3OTjb/zKJlNZL0DmKFpcCkR6LXXA==
X-Google-Smtp-Source: AAOMgpf5GM+3w36knXYvnWsXFMFvfqYHHalQPvyWbcfQ/Tj0kDwC+430wkQWGTAd4/PdC/ZjH3M9HoY1Jux+IIRIZn8=
X-Received: by 2002:ab0:11dd:: with SMTP id q29-v6mr16192664uac.191.1530550821566;
 Mon, 02 Jul 2018 10:00:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:9495:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 10:00:20 -0700 (PDT)
In-Reply-To: <08a08d60-8176-df54-ff0e-ffc195f40d6c@rock-chips.com>
References: <1527590335-171787-1-git-send-email-xiaqing17@hisilicon.com>
 <CAPDyKFo7FP5bL8doK3P749Rcyzh_H-3SzG+GZVJb2pp9j_ZH_A@mail.gmail.com> <08a08d60-8176-df54-ff0e-ffc195f40d6c@rock-chips.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 2 Jul 2018 10:00:20 -0700
X-Google-Sender-Auth: _ZeiE68PeqsdKB3v-j0fVaBXe9E
Message-ID: <CAD=FV=VBQOeaFGnJBBmVtYZjoJo1WdkwkPFaVJ=zr+C=N9iqQw@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: fix card threshold control configuration
To:     Shawn Lin <shawn.lin@rock-chips.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Evgeniy Didin <Evgeniy.Didin@synopsys.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Qing Xia <xiaqing17@hisilicon.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 11, 2018 at 7:17 AM, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> On 2018/6/11 20:20, Ulf Hansson wrote:
>>
>> + Shawn Lin, Evgeniy Didin, Doug Andersson
>>
>> On 29 May 2018 at 12:38, Qing Xia <xiaqing17@hisilicon.com> wrote:
>>>
>>> From: x00270170 <xiaqing17@hisilicon.com>
>>>
>>> Card write threshold control is supposed to be set since controller
>>> version 2.80a for data write in HS400 mode and data read in
>>> HS200/HS400/SDR104 mode. However the current code returns without
>>> configuring it in the case of data writing in HS400 mode.
>>> Meanwhile the patch fixes that the current code goes to
>>> 'disable' when doing data reading in HS400 mode.
>>>
>
> I'm more or less unable to review this, as I don't have 2.80a databook,
> nor a such platform to verify it. :(

Sorry for not responding earlier.  I didn't have a lot of context here
so reviewing it never made it to the top of my queue.  ...but quickly
checking what I can...

I'm in almost the same boat as Shawn.  I don't have any HS400 hardware
using dw_mmc available to me, but I do seem to have the 2.80a databook
hanging around and it agrees that we need to enable the card write
threshold for HS400 writes.  That also matches the comments, so the
patch seems right to me.  Probably Jaehoon would make a better
reviewer since he submitted the original code and also has more
familiarity with HS400 on dw_mmc.

I don't think I have enough context to give a full Reviewed-by, but in
the very least I can confirm that the patch seems sane.

-Doug
