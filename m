Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0057C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 17:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EE462145D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 17:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FfpE1KP5";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fb8FRZ6w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EE462145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbeHXVdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 17:33:11 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57018 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbeHXVdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 17:33:10 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 331DD604BE; Fri, 24 Aug 2018 17:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535133450;
        bh=wHelyK272wiLmJ6OadXZCiGGtuaZQImPUZG2g8E/0L0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FfpE1KP5gkJAtfXgQHDwGsAJslPLiLHkwYziWIR24sEs9xpyIYuTrz+awGX7uV5AM
         ePHWPh8wVh+kbDg/fxKFOZ2gZv0P4vUA7+P7S2xDocsOTpGn+O+nk6lLx6zWumfdhF
         Ng6DZysO/BykyRlRLYTV9QSZfceHNyDeUSUKVO3o=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 87D5D6022B;
        Fri, 24 Aug 2018 17:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535133449;
        bh=wHelyK272wiLmJ6OadXZCiGGtuaZQImPUZG2g8E/0L0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fb8FRZ6w48n/DQ/XIJQ9px4/m56ZqmiF3lWfC9XKOSdek6/iOCd4ahXw1tLJvWA8I
         lUFRumXb9PwZCMKHAd4Qy0UwVWdcBg1YY0//7iqLC5mGUtAf9rvDM+yTZlmmsD3jBT
         BGQ2hV4Phbu2Dmv4nTzvhWa7IZVNRZwdCmtI/scQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 24 Aug 2018 10:57:29 -0700
From:   vnkgutta@codeaurora.org
To:     Evan Green <evgreen@chromium.org>
Cc:     robh@kernel.org, mchehab@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, tsoni@codeaurora.org,
        ckadabi@codeaurora.org, rishabhb@codeaurora.org, bp@alien8.de
Subject: Re: [PATCH v2 2/4] drivers: soc: Add support to register LLCC EDAC
 driver
In-Reply-To: <CAE=gft4X9jbBJvQPykdiLRrQMJfhuGy4myjU9QKD2rjTUkLegg@mail.gmail.com>
References: <1534550915-18230-1-git-send-email-vnkgutta@codeaurora.org>
 <1534550915-18230-3-git-send-email-vnkgutta@codeaurora.org>
 <CAE=gft4X9jbBJvQPykdiLRrQMJfhuGy4myjU9QKD2rjTUkLegg@mail.gmail.com>
Message-ID: <135a75daa3eb3c5fcb8029a87e5d3f48@codeaurora.org>
X-Sender: vnkgutta@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-23 16:01, Evan Green wrote:
> On Fri, Aug 17, 2018 at 5:08 PM Venkata Narendra Kumar Gutta
> <vnkgutta@codeaurora.org> wrote:
>> 
>> Cache error reporting controller is to detect and report single
> 
> Should be "Cache error reporting controller detects and reports 
> single"...

Ok. I'll update this in next patchset.

> 
> Other than that:
> Reviewed-by: Evan Green <evgreen@chromium.org>

Thanks
