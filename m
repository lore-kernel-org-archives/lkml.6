Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525D5C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 15:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E92B420869
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 15:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NbeV32q7";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="G0lsyLF9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E92B420869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbeICT0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 15:26:07 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43246 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbeICT0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 15:26:06 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2CF8D6044E; Mon,  3 Sep 2018 15:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535987132;
        bh=0U/REbaAWzKz/yP8n2qy6cwo+1RhXgErXo8Rx4Hsl1Y=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=NbeV32q7+N//RcOAyqMKqUtjuyRo2A3uuxQsTngV7+TGsp36+QkouLDkl0LcTXd7l
         IR4CMC6vZvyZBQ6L1TY5vA6lhNiauYhANxAGnjlPkcZfNhi+OP7fQGbYnTjCKpEyau
         boZR0MlSHa+2iZghnRO9DmVdCeekrAjgQSY9n/o8=
Received: from WUFANW10 (c-71-205-14-210.hsd1.co.comcast.net [71.205.14.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wufan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AE8B06038E;
        Mon,  3 Sep 2018 15:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535987131;
        bh=0U/REbaAWzKz/yP8n2qy6cwo+1RhXgErXo8Rx4Hsl1Y=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=G0lsyLF94dxOp6xrpxJ9rkHY1ymtgZHAbtpa4qiEtBf9AELa0bbQTPLwpHofMdkLp
         br5lQcxyw+MXMdWYoFu2OTYbckoLwFIR/j7X0XwEPdPuSlkebzO7I/pfoLoBv/cK/s
         fnzvSJmfTX15qcL9NC/V6F2I/3hWujT07syCaL34=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AE8B06038E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=wufan@codeaurora.org
From:   "wufan" <wufan@codeaurora.org>
To:     "'tanxiaofei'" <tanxiaofei@huawei.com>,
        "'John Garry'" <john.garry@huawei.com>,
        "'James Morse'" <james.morse@arm.com>
Cc:     "'Zhengqiang'" <zhengqiang10@huawei.com>, <mchehab@kernel.org>,
        <bp@alien8.de>, <baicar.tyler@gmail.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "'Linuxarm'" <linuxarm@huawei.com>,
        "'wanghuiqiang'" <wanghuiqiang@huawei.com>,
        "'Shiju Jose'" <shiju.jose@huawei.com>
References: <1535567632-18089-1-git-send-email-wufan@codeaurora.org> <5eab89c6-c063-cbc2-4d02-459faf87698a@arm.com> <6cc3c5e2-3827-a89c-e37b-09728a34f21f@huawei.com> <5B891308.40407@huawei.com>
In-Reply-To: <5B891308.40407@huawei.com>
Subject: RE: [PATCH] EDAC, ghes: use CPER module handles to locate DIMMs
Date:   Mon, 3 Sep 2018 09:05:29 -0600
Message-ID: <003201d44397$8eb02c20$ac108460$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHcLsFbwflxxBzVeG17JegIRw3gmAHUN31rALBI7BwCDdR5JKSqPigw
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks tanxiaofei!

Boris/James, are you OK to sign off, or you want to see more tests on 
this patch? 

Thanks,
Fan

> -----Original Message-----
> From: tanxiaofei <tanxiaofei@huawei.com>
> Sent: Friday, August 31, 2018 4:06 AM
> 
> Hi James,
> 
> Our platform do not set CPER_MEM_VALID_MODULE_HANDLE in GHES
> Memory errors.
> 
> Thanks,
> tanxiaofei


