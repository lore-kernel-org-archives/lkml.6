Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C3EC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 06:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00A3C208E9
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 06:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="isE0pF5P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00A3C208E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbeHWKQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 06:16:10 -0400
Received: from aer-iport-1.cisco.com ([173.38.203.51]:41905 "EHLO
        aer-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbeHWKQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 06:16:09 -0400
X-Greylist: delayed 583 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Aug 2018 06:16:08 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1529; q=dns/txt; s=iport;
  t=1535006881; x=1536216481;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=VE8ey/r4TulkVB4jtIl8V3rfBJ9JTx4pscJAeyVxr7M=;
  b=isE0pF5PoGNYloZh9ymTLuaVzt1QlHGG2VpJ4mLcTTJOpuaJJxT+iYd7
   opNKmG4gYhz0nzbb5vI7bJdQMWaa7oWCjOqPwtZP4RQll+QvqnhylZvDx
   0oXufCP6vn4uaup/Hvaov7R0JahHOF0Ga7rPQMvcktqTzQVZfVqcGblps
   M=;
X-IronPort-AV: E=Sophos;i="5.53,277,1531785600"; 
   d="scan'208";a="6045832"
Received: from aer-iport-nat.cisco.com (HELO aer-core-2.cisco.com) ([173.38.203.22])
  by aer-iport-1.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Aug 2018 06:38:18 +0000
Received: from [10.61.230.125] ([10.61.230.125])
        (authenticated bits=0)
        by aer-core-2.cisco.com (8.15.2/8.15.2) with ESMTPSA id w7N6cHuF000972
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 23 Aug 2018 06:38:18 GMT
Subject: Re: v4.19-rc0: compile problem in ./include/media/cec.h:82:24:
To:     Pavel Machek <pavel@ucw.cz>, hans.verkuil@cisco.com,
        mchehab+samsung@kernel.org,
        kernel list <linux-kernel@vger.kernel.org>
References: <20180822204426.GA23832@amd> <20180822211212.GA30897@amd>
From:   Hans Verkuil <hansverk@cisco.com>
Message-ID: <2412c578-637b-547a-aa20-79a5dc33a94c@cisco.com>
Date:   Thu, 23 Aug 2018 08:38:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180822211212.GA30897@amd>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-User: hansverk
X-Outbound-SMTP-Client: 10.61.230.125, [10.61.230.125]
X-Outbound-Node: aer-core-2.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/08/18 23:12, Pavel Machek wrote:
> Hi!
> 
>> I'm getting this in -rc0:
>>
>>   CC      drivers/gpu/drm/ttm/ttm_tt.o
>>   In file included from ./include/media/cec-notifier.h:13:0,
>>                    from drivers/gpu/drm/i915/intel_drv.h:42,
>> 		                    from
>>   drivers/gpu/drm/i915/i915_trace.h:11,
>>                    from drivers/gpu/drm/i915/i915_drv.h:2667,
>> 		                    from
>>   drivers/gpu/drm/i915/i915_irq.c:36:
>>   ./include/media/cec.h:82:24: error: ‘CEC_EVENT_PIN_5V_HIGH’
>>   undeclared here (not in a function)
>>    #define CEC_NUM_EVENTS CEC_EVENT_PIN_5V_HIGH
>>                            ^
>> 			   ./include/media/cec.h:94:26: note: in
>>   expansion of macro ‘CEC_NUM_EVENTS’
>>     struct list_head events[CEC_NUM_EVENTS]; /* queued events */
>>                               ^
>>  CC      drivers/input/serio/serport.o
>>
>> Reverting 4786b0d6f3ca6da8db02b0a58cd2b785cb0b80ab seems to help.
> 
> No, sorry, it does not. I was confused. Let me try
> 
> HDMI CEC support (MEDIA_CEC_SUPPORT) [N/y/?] (NEW) y
> 
> No change.
> 
> Let me add
> 
> #include <uapi/linux/cec.h>
> 
> into include/media/cec.h... no.
> 
> Any ideas?
> 								Pavel
> 

media/cec.h includes linux/cec-funcs.h which includes linux/cec.h. This last
header defines CEC_EVENT_PIN_5V_HIGH.

If it doesn't for some reason, then you have some broken tree since it definitely
is there if I look at the current mainline kernel.

Regards,

	Hans
