Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC54EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 895E320855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kUxFhSXE";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="byUw6VHB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbfAQP3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 10:29:00 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:55526 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfAQP3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 10:29:00 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C215960807; Thu, 17 Jan 2019 15:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547738938;
        bh=X0Bs3pUe4+evpE7MdCKhnWyxlZN3PSJfCdvI9jWXUQQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=kUxFhSXE00jjlpi+MGLxetr3G5IhNbm/35kIvh2IDiPT6au37o+j3qxqJ+VbKbzV2
         hNNroE26+IJYYt63QMGCOy5tEasvEa5mXq9tCC4SJWDQy1gFdgv/pYTgh38v0m9XI7
         aUYo6lKjmQbIhV3gFbdHSeQrBIeNUMWfE7OjPSkg=
Received: from [192.168.1.100] (unknown [157.45.228.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3F444601D2;
        Thu, 17 Jan 2019 15:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547738937;
        bh=X0Bs3pUe4+evpE7MdCKhnWyxlZN3PSJfCdvI9jWXUQQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=byUw6VHBF/99Jq86aac5PiNOz1l9wPIiuxijrPfcM/NtPQD15sA9bZLnmetCROypJ
         mhlyn29lbTiB0IV0LCPpAuCcQ4dg0f3k8CdYPNtbV6scLQqUtbHOzqVXWsrTdiVYoP
         nvC3aVkXZvgsLzE7VMzNR305X0N96XIUdCynZGao=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3F444601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH] pstore/ram: Fix console ramoops to show the previous boot
 logs
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Guenter Roeck <groeck@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20190117062620.23908-1-saiprakash.ranjan@codeaurora.org>
 <20190117151833.GA51139@google.com>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <79870bf9-e40c-2249-0859-b2404af296c1@codeaurora.org>
Date:   Thu, 17 Jan 2019 20:58:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190117151833.GA51139@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/2019 8:48 PM, Joel Fernandes wrote:
> On Thu, Jan 17, 2019 at 11:56:20AM +0530, Sai Prakash Ranjan wrote:
>> commit b05c950698fe ("pstore/ram: Simplify ramoops_get_next_prz()
>> arguments") changed update assignment in getting next persistent
>> ram zone by adding a check for record type. But the check always
>> returns true since the record type is assigned 0. And this breaks
>> console ramoops by showing current console log instead of previous
>> log on warm reset and hard reset (actually hard reset should not
>> be showing any logs).
>>
>> Fix this by having persistent ram zone type check instead of record
>> type check. Tested this on SDM845 MTP and dragonboard 410c.
>>
>> Reproducing this issue is simple as below:
>>
>> 1. Trigger hard reset and mount pstore. Will see console-ramoops
>>     record in the mounted location which is the current log.
>>
>> 2. Trigger warm reset and mount pstore. Will see the current
>>     console-ramoops record instead of previous record.
>>
>> Fixes: b05c950698fe ("pstore/ram: Simplify ramoops_get_next_prz() arguments")
>> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> 
> 
> Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 

Thanks Joel.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
