Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FF0C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 975EA2554C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iWuIBqAD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 975EA2554C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752240AbeGBNQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:16:36 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:54917 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751415AbeGBNQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:16:33 -0400
Received: by mail-it0-f67.google.com with SMTP id s7-v6so1161206itb.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 06:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NpHQkYeHKKp/UEvI/AbNEpm8cp2SD+4irWUt7fLWkBw=;
        b=iWuIBqADVEp6/GCAxtBuIwzm9L2FB9ysSSxDssrR0kBcPwZ+HrxXOP3NW3L+0gnB49
         dSbFNzZMGMOPHDZS/PsJU0cKFgv2uYGcpnj0Zs9ugJVMh5aI0nwRBhDnCvxOgGbkJumX
         fqrAQwyLYnAFRPlIzSk12WxbkHhICYZVFU92w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NpHQkYeHKKp/UEvI/AbNEpm8cp2SD+4irWUt7fLWkBw=;
        b=L0/Up6YS+OpbJQ348weanYvftISc/RRMGWt/vRfU8qGxgBih/hXVs2OM6VYNkO5OSD
         LxP45DvkMrhsP72BLUtK3iMFg8a2SneLv/hi7R457aYDQTL9GJilnIZLcBbQzAp9GmxI
         +Iog1cIQbgWNFmhinHG+As3+3U7Xf+c674YONIP68iFdaGAjM8zuDs1XXwiCw7RyhYYt
         OZXT2mvP0AWXDLAy7hdfvcxO4MR1gxN4orvXWaU2mYKSL5jGTv2dVNYx1LMuBHrI5fsX
         K87Wp0G1TFTUKaxz5zfGgz2itH5rbp29C7fe1K3NgtGlTCxWb+c20n9nYmCedq3cmdxl
         YJ/w==
X-Gm-Message-State: APt69E05OiLVMC1Mo7AHmYj3aRdJ8NjcmM1BVbqWbxULgBZ27cnzvS2f
        O/hi91BrmgFeG0LK1vRYZGFxgSax133srIN8W+eUow==
X-Google-Smtp-Source: AAOMgpekhIq+87Cv2Lo55lxjNnvXGL7zLHv6o5ql8nQNOcvQ43P+JEZ2B0ROZ99r6kWMdRfzpIch+FR5jIIqn/V/zPE=
X-Received: by 2002:a02:570c:: with SMTP id u12-v6mr20780884jaa.142.1530537392741;
 Mon, 02 Jul 2018 06:16:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:818f:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 06:16:32 -0700 (PDT)
In-Reply-To: <CAPDyKFo7FP5bL8doK3P749Rcyzh_H-3SzG+GZVJb2pp9j_ZH_A@mail.gmail.com>
References: <1527590335-171787-1-git-send-email-xiaqing17@hisilicon.com> <CAPDyKFo7FP5bL8doK3P749Rcyzh_H-3SzG+GZVJb2pp9j_ZH_A@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 2 Jul 2018 15:16:32 +0200
Message-ID: <CAPDyKFrLY=rH+xaYSd=Qr72BVtk0UPeHkY4s0GTeU+0NHks-zg@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: fix card threshold control configuration
To:     Shawn Lin <shawn.lin@rock-chips.com>,
        Evgeniy Didin <Evgeniy.Didin@synopsys.com>,
        Doug Anderson <dianders@chromium.org>
Cc:     Jaehoon Chung <jh80.chung@samsung.com>,
        Qing Xia <xiaqing17@hisilicon.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 June 2018 at 14:20, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> + Shawn Lin, Evgeniy Didin, Doug Andersson
>
> On 29 May 2018 at 12:38, Qing Xia <xiaqing17@hisilicon.com> wrote:
>> From: x00270170 <xiaqing17@hisilicon.com>
>>
>> Card write threshold control is supposed to be set since controller
>> version 2.80a for data write in HS400 mode and data read in
>> HS200/HS400/SDR104 mode. However the current code returns without
>> configuring it in the case of data writing in HS400 mode.
>> Meanwhile the patch fixes that the current code goes to
>> 'disable' when doing data reading in HS400 mode.
>>
>> Signed-off-by: Qing Xia <xiaqing17@hisilicon.com>
>
> This looks good to me. However, it seems like Jaehoon has been busy,
> no response yet.
>
> I have looped in a few more people to see if they thinks this makes sense.

It sounds this should be a fix for regression (also confirmed
off-list). Could you please resend and by adding a fixes tag?

In the meantime, I have applied this for my next branch, as to get it
tested. I can move it later to fixes if needed.

[...]

Kind regards
Uffe
