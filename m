Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BDFC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 11:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16F8526A02
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 11:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gM3479rv";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lFoQ/mYs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16F8526A02
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935026AbeFZLs1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 07:48:27 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36002 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934063AbeFZLsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 07:48:22 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 24B84605A5; Tue, 26 Jun 2018 11:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530013702;
        bh=Ju5PDCR6GEMWZ/D+xu8WHOCoS7i4Sk1oB5vT4WYxb5Q=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=gM3479rvmcKPHVX0vc0veDJbNvEDwPdgRSaL4d3H+YbIrtgwBX97nI6q5HLWFAHU/
         OZ4X3yh/ehST4dbniYRYRTjFjGReqybYdnEopuiLnTvLA+/XDrfqEkpXzIPUcyWIem
         8w3cG5RkYjDTgpnHM14gDErv3mhJWm8OMb0gvfeQ=
Received: from mail-qk0-f173.google.com (mail-qk0-f173.google.com [209.85.220.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0452260714;
        Tue, 26 Jun 2018 11:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530013701;
        bh=Ju5PDCR6GEMWZ/D+xu8WHOCoS7i4Sk1oB5vT4WYxb5Q=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=lFoQ/mYsUBw4rCFlft50DtYnB/2FN0p6hIEMtjk58EaeLoibULgTHeDEySwJkNQpO
         AWg79n6/tXPt47noFFrMt7EdotCZLatOKeFEpiWAlhcumfMt/nJeKIKUfjneI11/t3
         ohnLt6Zh1CRyZJQv1VEPxJRR8hGxLZHDJQdnv3hA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0452260714
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qk0-f173.google.com with SMTP id c131-v6so9291262qkb.0;
        Tue, 26 Jun 2018 04:48:20 -0700 (PDT)
X-Gm-Message-State: APt69E2RqiZPjSKpM5tFCRsqzkLAHSl4AFxxvheH/718HPfYiM8mmUcA
        ZKUca17nKj0X9eqen8+Oggj+nHLuu/V/RCH20u0=
X-Google-Smtp-Source: AAOMgpfb0JdxBwJLginx0Ukw8V233JY7/nmRBWvLe+XwdVN1cXJGAozDZpmw/SbAr5D9/hSx/lGrv3JtFa66Y7PgsEY=
X-Received: by 2002:a37:7a46:: with SMTP id v67-v6mr893395qkc.32.1530013700237;
 Tue, 26 Jun 2018 04:48:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:1082:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 04:48:19
 -0700 (PDT)
In-Reply-To: <6354476.UjADPVylrh@aspire.rjw.lan>
References: <20180530095704.5788-1-vivek.gautam@codeaurora.org>
 <541c84e9-47fc-e7bc-8249-1477b9e63455@codeaurora.org> <CAFp+6iGwcbOm0p33o9NEE7YBZNNvRsBeU0ySy0HcEmvq8mhBJA@mail.gmail.com>
 <6354476.UjADPVylrh@aspire.rjw.lan>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Tue, 26 Jun 2018 17:18:19 +0530
X-Gmail-Original-Message-ID: <CAFp+6iEapavf-Fta9Gs8Dg8g6CDtvymAWdjT=Jng7mnjiCNxpA@mail.gmail.com>
Message-ID: <CAFp+6iEapavf-Fta9Gs8Dg8g6CDtvymAWdjT=Jng7mnjiCNxpA@mail.gmail.com>
Subject: Re: [PATCH 1/1] device core: Add flag to autoremove device link on
 supplier unbind
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Greg KH <gregkh@linuxfoundation.org>, lukas@wunner.de,
        dmitry.torokhov@gmail.com, aspriel@gmail.com,
        Robin Murphy <robin.murphy@arm.com>,
        open list <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On Tue, Jun 26, 2018 at 3:49 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Tuesday, June 26, 2018 12:03:44 PM CEST Vivek Gautam wrote:
>> On Wed, May 30, 2018 at 6:21 PM, Vivek Gautam
>> <vivek.gautam@codeaurora.org> wrote:
>>
>> Adding Ulf and Marek for their side of comments.
>> In summary, we do not want to not maintain a device link pointer
>> when adding a device link in supplier's driver, to delete the link later.
>> An autoremove flag from the suppliers side (similar to what we already
>> have for consumer side) can help autoremove the device link
>> when supplier driver goes away.
>>
>> Hi Rafael, Lukas,
>> Gentle ping. Can you please consider reviewing this patch.
>
> ISTR telling you that I didn't like the DL_FLAG_AUTOREMOVE_S name
> as it is too similar to another existing flag.  That hasn't changed.

Right. I thought to gather more comments about the patch overall
before attempting to respin with the changed name.
I will send the next version.

>
> BTW, please CC the patch to linux-pm when you resend it.

Sure. I will do that. Thanks.

Best regards
Vivek

>
> Thanks,
> Rafael
>



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
