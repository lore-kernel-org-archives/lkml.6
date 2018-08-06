Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779E6C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 08:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29D5D219DE
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 08:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IhZbGJzs";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QnDr0txr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29D5D219DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbeHFK0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 06:26:48 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38040 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbeHFK0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 06:26:48 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 524FC60B12; Mon,  6 Aug 2018 08:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533543533;
        bh=vJl0i1IFzzFlsvmKDqs7sriqASo3nqDA4HcyDzbphtc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IhZbGJzsUT15toEhgOr/AFzuSLv1LwEFUWzSbaa42z1+IWR/eNtGHzxw+pfVLs3Yy
         vut6sIoYTx+9pwK/RqKREjFh6+AApRqQ4YYRU0JIwLqAdECIKTBQtCLeA7VASTUpz0
         h4bTINrDUil+TgP9cGGvjVaMoE9LGsUBweE5HWQ4=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id B0948604BE;
        Mon,  6 Aug 2018 08:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533543532;
        bh=vJl0i1IFzzFlsvmKDqs7sriqASo3nqDA4HcyDzbphtc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QnDr0txrskX2fwaRaoo8Jk6nd1FbRP5nLFDEeEzhaQHxdoRVxGzAjZWDCfdF3fP4/
         BIQyeZy4a/dN5bXCS/BrY1ZCudSr5mfm/ye6BKsQyt0vDAmlUtWe2xEoLG/TUOGbVp
         9TGWoS0xBmJAI1ULOm9d5nOTeOk/iEMf6Q9Bz2vM=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 06 Aug 2018 13:48:52 +0530
From:   Vikash Garodia <vgarodia@codeaurora.org>
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     hverkuil@xs4all.nl, mchehab@kernel.org, robh@kernel.org,
        mark.rutland@arm.com, andy.gross@linaro.org, arnd@arndb.de,
        bjorn.andersson@linaro.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        acourbot@chromium.org, linux-media-owner@vger.kernel.org
Subject: Re: [PATCH v3 3/4] venus: firmware: add no TZ boot and shutdown
 routine
In-Reply-To: <4727000d-96ef-2dc5-50df-6bdadcaa156e@linaro.org>
References: <1530731212-30474-1-git-send-email-vgarodia@codeaurora.org>
 <1530731212-30474-4-git-send-email-vgarodia@codeaurora.org>
 <4727000d-96ef-2dc5-50df-6bdadcaa156e@linaro.org>
Message-ID: <e482a9af27288c9e8a8ffb5c1de8a209@codeaurora.org>
X-Sender: vgarodia@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stanimir,

Thanks for your review.

On 2018-07-25 15:06, Stanimir Varbanov wrote:
> Hi Vikash,
> 
> On 07/04/2018 10:06 PM, Vikash Garodia wrote:
> 
<snip>

>> 
>>  #define VENUS_PAS_ID			9
>> -#define VENUS_FW_MEM_SIZE		(6 * SZ_1M)
>> +#define VENUS_FW_MEM_SIZE		(5 * SZ_1M)
> 
> This change should be subject to a separate patch.
Ok.

> 
<snip>

>> +	writel_relaxed(reg, reg_base + WRAPPER_A9SS_SW_RESET);
>> +
>> +	/* Make sure reset is asserted before the mapping is removed */
>> +	mb();
> 
> mb() is used for compiler barrier as far as I know, isn't better to 
> just
> read the register and keep the comment?

mb() can ensure that the instructions are ordered. This is needed to 
ensure
reset before the mapping is removed.

Thanks,
Vikash
