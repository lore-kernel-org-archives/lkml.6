Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A305FC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 16:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7536220665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 16:54:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7536220665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbeJXBST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 21:18:19 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:43029 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbeJXBSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 21:18:18 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id D2D812135F;
        Tue, 23 Oct 2018 16:54:06 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo02-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zN8XFL-AcAFY; Tue, 23 Oct 2018 16:54:06 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 597A121A94;
        Tue, 23 Oct 2018 16:53:43 +0000 (UTC)
Subject: Re: [PATCH 00/10] tools: Various build flags fixes
To:     Jiri Olsa <jolsa@redhat.com>, Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Thomas Renninger <trenn@suse.de>,
        lkml <linux-kernel@vger.kernel.org>,
        Markus Mayer <mmayer@broadcom.com>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        "Herton R. Krzesinski" <herton@redhat.com>,
        Shuah Khan <shuah@kernel.org>
References: <20181016150614.21260-1-jolsa@kernel.org>
 <1915425.8MElBxF9G6@house> <afaa611b-a44d-70f8-9908-8bad14986db4@kernel.org>
 <20181022085106.GC2452@krava>
 <1ed0552d-4c37-552b-feb6-1ba17dc5dc1b@kernel.org>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <99e2893a-bfc8-d5df-59f3-57dcaa2ce49e@kernel.org>
Date:   Tue, 23 Oct 2018 10:53:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1ed0552d-4c37-552b-feb6-1ba17dc5dc1b@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/2018 09:17 AM, Shuah Khan wrote:
> On 10/22/2018 02:51 AM, Jiri Olsa wrote:
>> On Wed, Oct 17, 2018 at 09:28:16AM -0600, Shuah Khan wrote:
>>> On 10/17/2018 07:23 AM, Thomas Renninger wrote:
>>>> On Tuesday, October 16, 2018 5:06:05 PM CEST Jiri Olsa wrote:
>>>>> hi,
>>>>> while hardening some of the tools rpm, we noticed we
>>>>> can't pass build flags to some of them.
>>>>>
>>>>> Sending separate tools fixes for what we found. It's
>>>>> mostly override for CFLAGS and adding LDFLAGS to the
>>>>> build commands.
>>>>
>>>> Looks fine for the cpupower patches 3/10 and 4/10.
>>>> (Feel free to add a Reviewed-by or Acked-by for them
>>>> if you have to resend).
>>>>
>>>
>>> Thanks Thomas.
>>>
>>> Hi Jiri,
>>>
>>> Same here for cpupower patches 3/10 and 4/10. Please let me know
>>> if you would like me to take these through the cpupower patch flow.
>>
>> that would be great, any idea about 5/10?:

3/10 and 4/10 are now in kernel/git/shuah/linux.git cpupower branch and
will be included in my pull request for 4.20-rc1 or rc2 to Rafael. 

thanks,
-- Shuah
