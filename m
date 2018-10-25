Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF05C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 06:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D86020838
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 06:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kDNRp0xv";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RcnhBHbs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D86020838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbeJYOrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 10:47:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58490 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbeJYOrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 10:47:16 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4FD00602BA; Thu, 25 Oct 2018 06:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540448160;
        bh=lOq98bvQ0U+kKwWrN7NM4PWPzHD0/dLKT3j8MJZLyoQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kDNRp0xv48qcjtjatsOz40wrCXFNhYFCeSIghsujLh3z58y48lVnYmIzSUy/purn+
         /dHGyTqeB5TSzCT7I7NI5SVczggmJLVNOZf0FjDJAym4jgoXi+8cnTOXEVg1ViOjns
         fSYPAxW+oVALc8F4H8i+JpO3z/IBaI56icExahfc=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 649C4602BA;
        Thu, 25 Oct 2018 06:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540448159;
        bh=lOq98bvQ0U+kKwWrN7NM4PWPzHD0/dLKT3j8MJZLyoQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RcnhBHbsv6EpnErzaGWk3awwPjCIc6Xd+wSxk+pW++bKrDL8DvtFj9nY/d1R5HDVp
         Je8yNx2y3itb1M/50XiLDMaZpX+jk7AmUsfPkg29Y+qjdxMEbD1IAfMfXXUGkJgnag
         RjsezDynKF6LTxHR15B6sx70GMhJAkcEW1TjOLiw=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 25 Oct 2018 11:45:59 +0530
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Evan Green <evgreen@chromium.org>, Rob Herring <robh@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Stephen Boyd <swboyd@chromium.org>, cang@codeaurora.org,
        LKML <linux-kernel@vger.kernel.org>,
        Manu Gautam <mgautam@codeaurora.org>
Subject: Re: [PATCH v4 2/5] phy: qcom-qmp: Utilize fully-specified DT
 registers
In-Reply-To: <CAD=FV=VoBLh+SFmo8NieRT6LrOopkKRE86xiEMt_ap2gyDZXWw@mail.gmail.com>
References: <20181024172735.154304-1-evgreen@chromium.org>
 <20181024172735.154304-3-evgreen@chromium.org>
 <6b3edcc1-eaca-0fac-7ec4-a7390650b13b@codeaurora.org>
 <CAD=FV=VoBLh+SFmo8NieRT6LrOopkKRE86xiEMt_ap2gyDZXWw@mail.gmail.com>
Message-ID: <e4b227a63e8c803e4758c7bb8fd62d9f@codeaurora.org>
X-Sender: vivek.gautam@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-25 02:06, Doug Anderson wrote:
> Hi,
> 
> On Wed, Oct 24, 2018 at 11:29 AM Vivek Gautam
> <vivek.gautam@codeaurora.org> wrote:
>> Thanks for the patch.
>> I am starting to think that the driver is heavily relying on the
>> resource indices to request
>> all these areas ioremapped. Is it a good way forward that driver and 
>> the
>> dt bindings are
>> chained together?
>> Should we rather switch to requesting these resources by some names?
>> 
>> Rob can comment on this possibly.
> 
> I thought about suggesting that but I know that Rob really doesn't
> like accessing register ranges by name [1].  Even in cases where you
> reference things by name Rob likes there to be a fully defined order
> and once you have a fully defined order you don't really need the
> names unless you have more than one optional register range.

Right, I second that. I was looking for options. :)

> 
> In any case, Rob already gave his review to Evan's bindings change.  
> See:
> 
> https://lore.kernel.org/r/20181023002903.GA16854@bogus

Yea, I saw that too.

Best regards
Vivek

> 
> ...so my vote would be to keep it as Evan's patch series has it and
> not try to bikeshed it.
> 
> 
>> Reviewed-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> 
> Thanks for the review!
> 
> 
> [1]
> https://lkml.kernel.org/r/CAL_Jsq+MMunmVWqeW9v2RyzsMKP+=kMzeTHNMG4JDHM7Fy0HBg@mail.gmail.com
> 
> -Doug
