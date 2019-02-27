Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7F1C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 15:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0A7520684
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 15:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551281638;
	bh=NlH7X5PsMh8aGpE/KrZDZDMxRw3svIQqQ9REU9W1rrs=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=hTcj13JJa0F0juKi+r7Z7PysOCqGphFDB/VSJI/+bE4XWFyNzFGXL/dOvEnceX9y1
	 yMz7Pl8dSX2s4MpfijMtn77gElo5eLQKBykW+bjdUeMn9cau+t2WIqQ8A3wGLCoET9
	 0VTdz4S9R8jF1oObi8L/eTg9/5uZ0Mcg/P/qzJQo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730059AbfB0Pd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 10:33:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:40158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbfB0Pdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 10:33:55 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF30C20684;
        Wed, 27 Feb 2019 15:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551281634;
        bh=NlH7X5PsMh8aGpE/KrZDZDMxRw3svIQqQ9REU9W1rrs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mSiCQbt422wPstYsAPx3uJgPjgUjVeuPQUwZ6FIW3wQwXl68Hxg7NfIyYMJO1KsqN
         MqlEgz3NlJ7j5cJJ3h2fN3rHdMmXz+Tqow1MmNH+VTkScyiJFhjrbzupUeH4C9p9zT
         xmZrYNkwpI9yo9X/yfTrZ3nyD6d2lT+kZ09mA8YA=
Subject: Re: [PATCH v2 5/5] selftests/ima: loading kernel modules
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-kselftest@vger.kernel.org
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Vorel <pvorel@suse.cz>, shuah <shuah@kernel.org>
References: <1551223620-11586-1-git-send-email-zohar@linux.ibm.com>
 <1551223620-11586-6-git-send-email-zohar@linux.ibm.com>
 <19d494c6-ecb1-b884-2d23-5f556b3ec05b@kernel.org>
 <1551276893.10911.23.camel@linux.ibm.com>
From:   shuah <shuah@kernel.org>
Message-ID: <ab45b574-4791-d42a-f566-ab9886525549@kernel.org>
Date:   Wed, 27 Feb 2019 08:33:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1551276893.10911.23.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mimi,

On 2/27/19 7:14 AM, Mimi Zohar wrote:
> Hi Shuah,
> 
>>> diff --git a/tools/testing/selftests/ima/test_kernel_module.sh b/tools/testing/selftests/ima/test_kernel_module.sh
>>> new file mode 100755
>>> index 000000000000..4009e1b60b03
>>> --- /dev/null
>>> +++ b/tools/testing/selftests/ima/test_kernel_module.sh
>>> @@ -0,0 +1,96 @@
>>> +#!/bin/sh
>>> +# SPDX-License-Identifier: GPL-2.0-or-later
>>
>> Same here
>>
>> # SPDX-License-Identifier: GPL-2.0
> 
> Sure, I'll make the change here and in the other places.
> 
> 

Thanks.

>>> +get_secureboot_mode
>>> +if [ $? -eq 0 ]; then
>>> +	log_skip "secure boot not enabled"
>>> +fi
>>> +
>>> +# get the kernel config
>>> +get_kconfig
>>> +
>>
>> get_kconfig() will be good candidate as a kselftest common
>> function. Is that possible?
> 
> Sure, where would it go?  get_kconfig calls log_skip.  I didn't see
> any common logging functions.  Petr suggested defining a set of common
> logging functions.  Did you want to only make "log_skip" a common
> function or the other logging functions log_pass, log_fail, log_info
> as well?
> 

We can do this as a separate effort in the interest of getting these
in the interest of getting these in.

We have common functions in ksefltest.h for c and we don't have them
for tests scripts. We might be able to collect common routines such
as get_kconfig into a common .sh and include in tests. If you have time
to do this, that will be great. It can be done as a separate effort.

thanks,
-- Shuah
