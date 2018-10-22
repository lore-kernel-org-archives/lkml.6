Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D93C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 11:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E14720652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 11:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="J/8yMqyh";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="J/8yMqyh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E14720652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbeJVT37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 15:29:59 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50352 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727700AbeJVT37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 15:29:59 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D93B36079C; Mon, 22 Oct 2018 11:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540206711;
        bh=nybUDrAsZNl0XzTgaCTN4fcXihgdXT31NS8eGz7mMYw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=J/8yMqyhVFhlHQ2yg1Ykq7OgFAU+Fko2xyNtbSI2JoCdimdmSGbu7ZfwrDozSId78
         CuDNormRWcBnfLFTAhhXjaRm9iI8RVzhxWmV++Aja4SBkY/e+ORcCTemYw9Gz9XHd7
         ML8EaQ/3WZUo0b18xQ9NMr9X2b95IJPRe/pFTUAg=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 14C346016D;
        Mon, 22 Oct 2018 11:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540206711;
        bh=nybUDrAsZNl0XzTgaCTN4fcXihgdXT31NS8eGz7mMYw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=J/8yMqyhVFhlHQ2yg1Ykq7OgFAU+Fko2xyNtbSI2JoCdimdmSGbu7ZfwrDozSId78
         CuDNormRWcBnfLFTAhhXjaRm9iI8RVzhxWmV++Aja4SBkY/e+ORcCTemYw9Gz9XHd7
         ML8EaQ/3WZUo0b18xQ9NMr9X2b95IJPRe/pFTUAg=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 22 Oct 2018 16:41:51 +0530
From:   Vikash Garodia <vgarodia@codeaurora.org>
To:     Alexandre Courbot <acourbot@chromium.org>
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-media-owner@vger.kernel.org
Subject: Re: [PATCH v12 0/5] Venus updates - PIL
In-Reply-To: <CAPBb6MWxUNyJEkAUATa7BiXgU1JefoxFseXuaLb+_XsLish8Pw@mail.gmail.com>
References: <1539782303-4091-1-git-send-email-vgarodia@codeaurora.org>
 <CAPBb6MWxUNyJEkAUATa7BiXgU1JefoxFseXuaLb+_XsLish8Pw@mail.gmail.com>
Message-ID: <213d6ccf6f06d4577187cda121a999d3@codeaurora.org>
X-Sender: vgarodia@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Alex.

On 2018-10-22 11:21, Alexandre Courbot wrote:
> Hi Vikash,
> 
> On Wed, Oct 17, 2018 at 10:18 PM Vikash Garodia 
> <vgarodia@codeaurora.org> wrote:
>> 
>> This version of the series
>> * updates the tz flag to unsigned
>> 
>> Stanimir Varbanov (1):
>>   venus: firmware: register separate platform_device for firmware 
>> loader
>> 
>> Vikash Garodia (4):
>>   venus: firmware: add routine to reset ARM9
>>   venus: firmware: move load firmware in a separate function
>>   venus: firmware: add no TZ boot and shutdown routine
>>   dt-bindings: media: Document bindings for venus firmware device
>> 
>>  .../devicetree/bindings/media/qcom,venus.txt       |  14 +-
>>  drivers/media/platform/qcom/venus/core.c           |  24 ++-
>>  drivers/media/platform/qcom/venus/core.h           |   6 +
>>  drivers/media/platform/qcom/venus/firmware.c       | 235 
>> +++++++++++++++++++--
>>  drivers/media/platform/qcom/venus/firmware.h       |  17 +-
>>  drivers/media/platform/qcom/venus/hfi_venus.c      |  13 +-
>>  drivers/media/platform/qcom/venus/hfi_venus_io.h   |   8 +
>>  7 files changed, 274 insertions(+), 43 deletions(-)
> 
> The series:
> 
> Reviewed-by: Alexandre Courbot <acourbot@chromium.org>
> Tested-by: Alexandre Courbot <acourbot@chromium.org>
