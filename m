Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B49C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0B0A2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:29:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0B0A2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbeJPWTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:19:45 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:59344 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbeJPWTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:19:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 623A440CB0;
        Tue, 16 Oct 2018 14:29:01 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo03-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Olq4BHJR8aFl; Tue, 16 Oct 2018 14:29:01 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id EA73E40C38;
        Tue, 16 Oct 2018 14:28:53 +0000 (UTC)
Subject: Re: [PATCH] tools/power/cpupower: fix compilation with STATIC=true
To:     Thomas Renninger <trenn@suse.de>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org, Shuah Khan <shuah@kernel.org>
References: <153968018626.397151.17942194042449956995.stgit@buzz>
 <2028892.8FmI4CMcI5@house>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <4a4cb4dc-16d7-7f71-eb99-d4b1e7788862@kernel.org>
Date:   Tue, 16 Oct 2018 08:28:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <2028892.8FmI4CMcI5@house>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/2018 05:39 AM, Thomas Renninger wrote:
> On Tuesday, October 16, 2018 10:56:26 AM CEST Konstantin Khlebnikov wrote:
>> Rename duplicate sysfs_read_file into cpupower_read_sysfs and fix linking.
>>
>> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> 
> Acked-by: Thomas Renninger <trenn@suse.de>
> 
> Thanks!
> 
>> -       $(OUTPUT)../lib/cpufreq.o $(OUTPUT)../lib/sysfs.o
>> +       $(OUTPUT)../lib/cpufreq.o $(OUTPUT)../lib/cpupower.o
> 
> I also looked at this and would only have fixed half of it (overseeing above
> old leftover from cpupower lib introduction).
> I guess, this patch from Konstantin is better and the correct solution.
> 

Thank you both. I will get this into 4.20-rc1 or rc2 depending on how timing
works.

I think this applies to stable as well.

thanks,
-- Shuah
