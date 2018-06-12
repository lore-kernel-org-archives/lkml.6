Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 73785C004E4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 02:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16E7D208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 02:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="h/TFpXl0";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="h/TFpXl0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16E7D208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964813AbeFLCDF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 22:03:05 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33506 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933494AbeFLCDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 22:03:04 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C7A62607A4; Tue, 12 Jun 2018 02:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528768983;
        bh=s6BRrJy6jQjGEnd0chBEfF3LCmMYqNpEsvBiGD+5c98=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=h/TFpXl0rbFH/DXb3ejFohUrU+b277fzA1H+CX7Si0SDFB5JYYkv05ZnBkWCMX4cp
         /LJrGCauWSZL/3oAJIupp4/pcC4AIB2tOpItCxrjC1t2uUjNS7NDsvRdBnfapa8qYx
         O54p76WhU2z4uj8qUy/hlu+C+c1RFj/j1uTxRJds=
Received: from [192.168.1.125] (cpe-24-28-70-126.austin.res.rr.com [24.28.70.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: timur@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F33B16074D;
        Tue, 12 Jun 2018 02:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528768983;
        bh=s6BRrJy6jQjGEnd0chBEfF3LCmMYqNpEsvBiGD+5c98=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=h/TFpXl0rbFH/DXb3ejFohUrU+b277fzA1H+CX7Si0SDFB5JYYkv05ZnBkWCMX4cp
         /LJrGCauWSZL/3oAJIupp4/pcC4AIB2tOpItCxrjC1t2uUjNS7NDsvRdBnfapa8qYx
         O54p76WhU2z4uj8qUy/hlu+C+c1RFj/j1uTxRJds=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F33B16074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=timur@codeaurora.org
Subject: Re: [PATCH net] net: qcom/emac: Add missing of_node_put()
To:     YueHaibing <yuehaibing@huawei.com>, davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20180611130345.15172-1-yuehaibing@huawei.com>
From:   Timur Tabi <timur@codeaurora.org>
Message-ID: <6fbe0bf5-821f-3789-9e75-08ba23391c67@codeaurora.org>
Date:   Mon, 11 Jun 2018 21:03:01 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180611130345.15172-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/11/18 8:03 AM, YueHaibing wrote:
> Add missing of_node_put() call for device node returned by
> of_parse_phandle().

Hmmmm... This shouldn't be necessary.  I was very careful with calls to 
of_node_put().  Give me a day or two to confirm, please.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
