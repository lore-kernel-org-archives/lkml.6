Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97AF4ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 10:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5304421523
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 10:01:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5304421523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbeJQR4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 13:56:14 -0400
Received: from mga09.intel.com ([134.134.136.24]:38731 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726947AbeJQR4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 13:56:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2018 03:01:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,392,1534834800"; 
   d="scan'208";a="99946849"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.72.61])
  by fmsmga001.fm.intel.com with ESMTP; 17 Oct 2018 03:01:13 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] docs: Introduce deprecated APIs list
In-Reply-To: <aed0041d-7c28-4dfb-91b5-fc83174d8744@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20181017021708.GA22211@beast> <aed0041d-7c28-4dfb-91b5-fc83174d8744@infradead.org>
Date:   Wed, 17 Oct 2018 13:00:56 +0300
Message-ID: <875zy0ki3r.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Oct 2018, Randy Dunlap <rdunlap@infradead.org> wrote:
> On 10/16/18 7:17 PM, Kees Cook wrote:
>> As discussed in the "API replacement/deprecation" thread[1], this
>> makes an effort to document what things shouldn't get (re)added to the
>> kernel, by introducing Documentation/process/deprecated.rst. It also
>> adds the overflow kerndoc to ReST output, and tweaks the struct_size()
>> documentation to parse correctly.
>> 
>> [1] https://lists.linuxfoundation.org/pipermail/ksummit-discuss/2018-September/005282.html
>> 
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>  Documentation/driver-api/basics.rst  |  3 +
>>  Documentation/process/deprecated.rst | 99 ++++++++++++++++++++++++++++
>>  Documentation/process/index.rst      |  1 +
>>  include/linux/overflow.h             |  2 +-
>>  4 files changed, 104 insertions(+), 1 deletion(-)
>>  create mode 100644 Documentation/process/deprecated.rst
>
>
>> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
>> index 40b48e2133cb..2f224f43dd06 100644
>> --- a/include/linux/overflow.h
>> +++ b/include/linux/overflow.h
>> @@ -291,7 +291,7 @@ static inline __must_check size_t __ab_c_size(size_t n, size_t size, size_t c)
>>  }
>>  
>>  /**
>> - * struct_size() - Calculate size of structure with trailing array.
>> + * function struct_size() - Calculate size of structure with trailing array.
>
> That syntax is not explained nor documented in Documentation/doc-guide/kernel-doc.rst.
>
> Is the root problem that the function name begins with "struct"?
> Please explain in the patch description.

Indeed, shouldn't be needed.

BR,
Jani.

>
>>   * @p: Pointer to the structure.
>>   * @member: Name of the array member.
>>   * @n: Number of elements in the array.
>
>
> thanks.

-- 
Jani Nikula, Intel Open Source Graphics Center
