Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A2FC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F371E25A6A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="O7oSAK+n";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JmBKTToq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F371E25A6A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753271AbeGBUqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 16:46:24 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:33145 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752860AbeGBUqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 16:46:19 -0400
Received: by mail-yw0-f193.google.com with SMTP id c135-v6so5280814ywa.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 13:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=AhvBn8tDB49gNQwg8vFOYnL3Mu1fa0uhirfafkPCaKY=;
        b=O7oSAK+n07bIAmw6SuScob0FXRtRKJ4Uars5vdIJqmr/yl5ZbPUbTdKqCcpii6DSut
         id1Z3FJWQAorJyo3TyzSq1pXPjKGSiqpFCDZDpO9SVCGMQXDzUCcUdxJzh1Eyt9XSKWt
         yIRKejp4zv9LJMT6orpBvpAh0pYQJiY1Rq7Lhy8UzPoby7wxmOCMs6YhnOPcGENxdk6o
         CS2QjjxgEOhK6KIo6DKwHf5cDvnm7HbPnosaBBNBOuF3OkIlD7Jphz+7ey0ffoLK2i2u
         UlEeFquik68zNsHlbTzxeMWXJqSRt77A9jMCNSy8Px8sPR2CdtfwnD0DV4Ye/SPPgehD
         AUOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=AhvBn8tDB49gNQwg8vFOYnL3Mu1fa0uhirfafkPCaKY=;
        b=JmBKTToqPwiunsOMLBH4Mnl3QJONYM2defjRUWxA6PV+zRfbXZWOPk3okWZFGhZTKa
         eL45EZU7Ic+Bm28HnYRwchLDjLA2pnpCAeCeY9GQ56Yv/DrA/ktWEo/GA+Om27/9FVy8
         eUOlhVxHE68ZbjoAVvvgVtwbmWDUnQ73NhX5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=AhvBn8tDB49gNQwg8vFOYnL3Mu1fa0uhirfafkPCaKY=;
        b=DnoHwXX7JNzW829rJfwX0s5oQ1X5ehYDrHXpiwCe3SHM3b/bie5twMnJQl5knbcFru
         mYFVkCVkGhyVS1/EWyepx8BaMzVXSi3BO7rNzFTDW8Bjsy90Gauff/QiqhAIsQHD7CRp
         fYovXUUgM8ZV7monB/nkk4UvmwIzQlfe7D9GCdRd2DkgDN0VDT9xoybBpExl3I7AUJxS
         HnYZhGMUNAIPIaTswfBhw7hwPt9NS3UsRHGqdUMGLCxdGnvGtH1j+gEhJ2sDCEBeip5r
         4xOs0YfafO4aMSKlNeYWgcFmXqxmF5cz3nUT9BCBPrl4VP/rAAcygEI5r/st+Hf5j5in
         tjyQ==
X-Gm-Message-State: APt69E3xx/mRHDZqXHgTUF9kmVs2WgPOglk0QAZDakZNVvcsF05pzbpL
        UktqKV2hOi90gFcxNKDB/0gt58XXfKTNhhdyitvGJ9OX
X-Google-Smtp-Source: AAOMgpeiELplayCSORlAIVgB4oXiD6Pm2T6h8EC4yVM7iuhwBJFMCjO5uyE6n48RaXjahptK/8y0Ed3cr3s06f1Qgh4=
X-Received: by 2002:a81:8a81:: with SMTP id a123-v6mr13473509ywg.95.1530564378261;
 Mon, 02 Jul 2018 13:46:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 13:46:17 -0700 (PDT)
In-Reply-To: <20180702201402.GA16773@whence.com>
References: <1530302661-20953-1-git-send-email-kamal@canonical.com>
 <CAGXu5jKXtq75+HkziTT-8F0VHvvOiRrtfez60h8hKK1GaE64ug@mail.gmail.com> <20180702201402.GA16773@whence.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 2 Jul 2018 13:46:17 -0700
X-Google-Sender-Auth: 2WCIyn6GKQIQ7-aaWJOIv2HvL0c
Message-ID: <CAGXu5jLKKjf8BOj++4sgayU1N7Q9vMewyJX8o6_JkboPm5qEag@mail.gmail.com>
Subject: Re: [PATCH] security: CONFIG_HARDENED_USERCOPY does not need to
 select BUG
To:     Kamal Mostafa <kamal@canonical.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kamal,

On Mon, Jul 2, 2018 at 1:14 PM, Kamal Mostafa <kamal@canonical.com> wrote:
> On Fri, Jun 29, 2018 at 01:27:08PM -0700, Kees Cook wrote:
>> Do the lkdtm tests for usercopy correctly halt the kernel thread if
>> CONFIG_BUG is removed?
>
> Yes, they do...

Perfect, thanks for double-checking! I'll apply this to my tree.

-Kees

-- 
Kees Cook
Pixel Security
