Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532E7C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10FD020870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548256077;
	bh=GzYMHgytKUjYpXQoMtfF+MD8fD7CbJ862YoePiDkiIY=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=epVL1ZNufIM9AbnI4RiAkqEeHVujtiQMxMIodYYgU8/zLTi07rxX4ObijpbB818r8
	 MjcvdSBmnPDXMNUz7iehadO7YjiNPfqlf3ZR5QKo0XYCpkJ9dkKFKv204RI9lDBdDI
	 wqmSvRxofNkhP4aFK63Kp+abAqTsmQJtQXY+kevw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbfAWPHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 10:07:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:36578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725896AbfAWPHz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 10:07:55 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A35620870;
        Wed, 23 Jan 2019 15:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548256074;
        bh=GzYMHgytKUjYpXQoMtfF+MD8fD7CbJ862YoePiDkiIY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=zmrmCy2j9Ss7cCvW0WVKpjXwLuupC5SbTvZaAtOh/HYPRMYaNJeLFPVi6PHvd5dZD
         tAeNIMltYtfJTVzrK/TssuQ7FXSs2/nFybcv8BAOzkX2VLTNslMHCf9Z2UAo5w5Lnz
         RT7Mpq5lKP9DPBQhd7G5f5tfv0rjJLuUfRDXQjvM=
Subject: Re: [PATCH][V2] selftests: cpu-hotplug: fix case where CPUs offline >
 CPUs present
To:     Colin Ian King <colin.king@canonical.com>,
        linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <20190110123802.13832-1-colin.king@canonical.com>
 <abb5a36f-e513-e3ba-3286-4cc2026ef580@canonical.com>
From:   shuah <shuah@kernel.org>
Message-ID: <c18c3293-631d-2deb-794d-b7057ea2c50d@kernel.org>
Date:   Wed, 23 Jan 2019 08:07:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <abb5a36f-e513-e3ba-3286-4cc2026ef580@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/19 6:25 AM, Colin Ian King wrote:
> ping?
> 
> On 10/01/2019 12:38, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> The cpu-hotplug test assumes that we can offline the maximum CPU as
>> described by /sys/devices/system/cpu/offline.  However, in the case
>> where the number of CPUs exceeds like kernel configuration then
>> the offline count can be greater than the present count and we end
>> up trying to test the offlining of a CPU that is not available to
>> offline.  Fix this by testing the maximum present CPU instead.
>>
>> Also, the test currently offlines the CPU and does not online it,
>> so fix this by onlining the CPU after the test.
>>
>> Fixes: d89dffa976bc ("fault-injection: add selftests for cpu and memory hotplug")
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>>
>> ---
>>
>> V2: remove some debug and an empty line

Sorry for the delay. I will take this for 5.0-rc5

thanks,
-- Shuah
