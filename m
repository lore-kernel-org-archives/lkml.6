Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151CBECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 20:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A759F2085B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 20:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKgHH2eE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A759F2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbeJ0FPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 01:15:16 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:45459 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725759AbeJ0FPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 01:15:15 -0400
Received: by mail-yb1-f194.google.com with SMTP id 131-v6so1001260ybe.12;
        Fri, 26 Oct 2018 13:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4CU2riIn3esuOcYEGiC2H5Ifs0RbVo5jE375McKxpCM=;
        b=fKgHH2eELFy0XVKI9p/Xjy9Zhly+gH3zjqPXht0I5N5Y44n7sxTA5QxNPWIxEULsxs
         kfkVsqP73vgZPmGDQ+t4pv3qVyBgY5wgP6X8JrdnmtGFA/4BHJDw2JH4/HWQacZDAVUP
         zvLJmNliTQYX3VM+2ePn2CEFIMTk6KClkUL2LlwrBTa/CeLb/EyHiGwfyebM0/WNBWPw
         FoHuoE0yA6MvgxZq1fJw1Tm12sCJBXAPchTTRuqFPcsrUYwR1Z4ktwIDjkq9CsDFRCj+
         aZPsyaj8Nas6jQUoSowi83mAjHHPBqTxaeEhqd5y5cZq7kYipagnX4hjAzpwXJAWoi2k
         vkww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4CU2riIn3esuOcYEGiC2H5Ifs0RbVo5jE375McKxpCM=;
        b=f2sR+gC6q5KV5+viblfzt76QUWE/XN+oKDApbr13lGrbpXF64hUZ+gglWqW0czHWwM
         wVrKu/1+pspQY0dkBJI0fxaaSuh9VfWx8G89asqK+2AcyH/Js187ElXpGdikedXTy7fL
         s5wcvM/8jCpjox2CPtGOKbnam5m7gx+6MDO3jax72oICgrfH4mlR0+obXUY/DFPpSPMs
         ynWR4I7X3EgISKzm56/kTyOB7fwYre4JfsrHXBtZJBCOq/XaOF+hJuDAfQMJjCPzdG6L
         NmiRC2KZUuN1UO1DGXDHJQ//7DV9hbwj4jUpgi79Y1UnSOXUIdQEEDiyc6MSsVn5LFIF
         47AA==
X-Gm-Message-State: AGRZ1gK4YdM6M6CBvVqFsC2hxDba5iVTRfKWM6bc6rL4REF6BNbhmdAG
        CNB7i+F0TwfxkKfGghPnHnunJQwgoCU9FKIcsgE=
X-Google-Smtp-Source: AJdET5eeqdUJDSrcPX9zxLuLmrOPuZlFZJU/gZ1NhTrf6LLN5BX+SxuCbNWndwc6ZeggszoGMIaS8SN4YGigSuBNgSU=
X-Received: by 2002:a5b:883:: with SMTP id e3-v6mr5170324ybq.227.1540586207077;
 Fri, 26 Oct 2018 13:36:47 -0700 (PDT)
MIME-Version: 1.0
References: <20181026134516.1234-1-diego.viola@gmail.com> <3d9dd60b-7bfe-bc1c-b971-0935a84dcf45@kernel.dk>
In-Reply-To: <3d9dd60b-7bfe-bc1c-b971-0935a84dcf45@kernel.dk>
From:   Diego Viola <diego.viola@gmail.com>
Date:   Fri, 26 Oct 2018 17:36:35 -0300
Message-ID: <CA+ToGPHR7s4kTKdSh3rpjvxPQN+Y+Qfv=vT2icJ1Gh55X3-mTg@mail.gmail.com>
Subject: Re: [PATCH v3] libata: Apply NOLPM quirk for SAMSUNG MZ7TD256HAFV-000L9
To:     axboe@kernel.dk
Cc:     hdegoede@redhat.com, tj@kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 11:21 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 10/26/18 7:45 AM, Diego Viola wrote:
> > med_power_with_dipm causes my T450 to freeze with a SAMSUNG
> > MZ7TD256HAFV-000L9 SSD (firmware DXT02L5Q).
> >
> > Switching the LPM to max_performance fixes this issue.
>
> Applied, thanks.
>
> --
> Jens Axboe
>

Jens, Hans,

Thank you.

Diego
