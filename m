Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E7FC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3367D20863
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549648419;
	bh=+Ab1uWh8o7yamnYN8aXelRxTKt3yGgtY2DO+HsA37VM=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=tDkKZYFIYSCLkWCYyRGpnNMNOFWHnt681HQo+wHmHHV2fy3R+xQcpjZRYSYYCn6bh
	 gWsKmLH0FL9R1niELR6+xtf2KFty3k16jDisXB/hDXWMl1+ncVhpPTFDAUjW540Jpp
	 LIPNn2i3me3aMFKvjxrjSgTz3PWuI+0x0gjm1Cp0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbfBHRxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:53:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:34764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726869AbfBHRxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:53:37 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B531C20863;
        Fri,  8 Feb 2019 17:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549648416;
        bh=+Ab1uWh8o7yamnYN8aXelRxTKt3yGgtY2DO+HsA37VM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Cd1fWi0NwnLyadv3JRNSWPou0NX6FxutkkvPa1CtEugsV0vF51l76BjfyIrZRtBzi
         BGz/lM43uaYYC/B9D/jvgI6XSX3lAu/FpVgMjtv2KGdeaMrJXlLgXSGDjr80w25Wdb
         /9p28vgJ0Vtvp4c3om9awk5PvwJOpe5eJuPrvIHU=
Subject: Re: [PATCH 1/2] selftests: firmware: remove use of non-standard diff
 -Z option
To:     Luis Chamberlain <mcgrof@kernel.org>, Dan Rue <dan.rue@linaro.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kselftest@vger.kernel.org, shuah <shuah@kernel.org>
References: <20181127031218.24419-1-dan.rue@linaro.org>
 <20181127031218.24419-2-dan.rue@linaro.org>
 <20181130023732.GO4922@garbanzo.do-not-panic.com>
 <20181205204341.7fd4ob5c6pwx375m@xps.therub.org>
 <CAB=NE6Wtfe_TafSTU+=0S-n9_vQXaT3FKOrcDrzHBNzj3bY47w@mail.gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <b44fc032-f2dc-dfa4-bc22-7b7689a9b836@kernel.org>
Date:   Fri, 8 Feb 2019 10:53:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAB=NE6Wtfe_TafSTU+=0S-n9_vQXaT3FKOrcDrzHBNzj3bY47w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/19 11:20 AM, Luis Chamberlain wrote:
> On Wed, Dec 5, 2018 at 2:43 PM Dan Rue <dan.rue@linaro.org> wrote:
>>
>> On Thu, Nov 29, 2018 at 06:37:32PM -0800, Luis Chamberlain wrote:
>>> On Mon, Nov 26, 2018 at 09:12:15PM -0600, Dan Rue wrote:
>>>> diff -Z is used to trim the trailing whitespace when comparing the
>>>> loaded firmware file with the source firmware file. However, per the
>>>> comment in the source code, -Z should not be necessary. In testing, the
>>>> input and output files are identical.
>>>>
>>>> Additionally, -Z is not a standard option and is not available in
>>>> environments such as busybox. When -Z is not supported, diff fails with
>>>> a usage error, which is suppressed, but then causes read_firmwares() to
>>>> exit with a false failure message.
>>>
>>> NACK -- this breaks testing on debian:
>>>
>>> Testing with the file present...
>>> Batched request_firmware() try #1: Files
>>> /tmp/tmp.8GWkoSo5jZ/test-firmware.bin and
>>> /sys/devices/virtual/misc/test_firmware/read_firmware differ
>>> request #0: firmware was not loaded
>>>
>>> Please add a quirks check, enable it by default, and remove it for
>>> Busybox.
>>
>> Thanks for the review. Shuah, can you please drop this one?
> 
> So much for review. This patch was still merged. I'll have to request
> this to be reverted now too.
> 
>    Luis
> 

Sorry about this. I will pull the reverts in.

thanks,
-- Shuah
