Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C73ECDE3B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 157642087A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RmeqGByi";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jZrvaTWK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 157642087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbeJRGS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 02:18:57 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58524 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbeJRGS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 02:18:56 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0CFA360B73; Wed, 17 Oct 2018 22:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539814872;
        bh=jJoG70O5KkpHrahwfC+EwcgyKkz4cI/KgVpAE7fjfBk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RmeqGByiwrAhfnXXqhLIi52WwwWbX7vNskU7kg1LyDaiTtmn0Yo468akP/o/wjUt8
         595jUAjuEpLXlVm9NvaCv0ahFwzublqN8rIOaXBzsaYkA2iORyDhYG0qedagfoF88Q
         GPRWzdGIoGFIuaCFewqQ+H5gqi59k2h0fYPHAEq4=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 759C560B73;
        Wed, 17 Oct 2018 22:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539814871;
        bh=jJoG70O5KkpHrahwfC+EwcgyKkz4cI/KgVpAE7fjfBk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jZrvaTWKqE/XsRggRmaj3EFhtxQ3GYdyzhxBEv1fziC59AmjLuiIDvo3+FyCm78yy
         6SOQjKt6Pp/QVlNipI5BUseqzhSODV/lOHFlvMa5it27t4N0QP8Unfi9S2wr+KK8a6
         UBW18QX74j7VwjVLnQvqkRe9D4rnTh50wUYo2oLQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 759C560B73
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH 1/2] serial: set suppress_bind_attrs flag only if builtin
To:     Andrew Morton <akpm@linux-foundation.org>,
        Anders Roxell <anders.roxell@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, gregkh@linuxfoundation.org,
        linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-serial@vger.kernel.org, tj@kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20181017140311.28679-1-anders.roxell@linaro.org>
 <20181017150546.0d451252950214bec74a6fc8@linux-foundation.org>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <e0763032-3ae6-b352-e586-ad131ce689ca@codeaurora.org>
Date:   Wed, 17 Oct 2018 16:21:08 -0600
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181017150546.0d451252950214bec74a6fc8@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/2018 4:05 PM, Andrew Morton wrote:
> On Wed, 17 Oct 2018 16:03:10 +0200 Anders Roxell <anders.roxell@linaro.org> wrote:
> 
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Co-developed-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> 
> This should have Arnd's Signed-off-by: as well.

I'm just interested to know, why?

-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
