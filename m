Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF952ECDE39
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 17:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97F1E21476
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 17:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qsDzS7XO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97F1E21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbeJRBFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 21:05:37 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55716 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbeJRBFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 21:05:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=cnqrxNVi8U9hCXQV081RSmpPpwbl6DRe7xEs2k9UVjo=; b=qsDzS7XOx2FPRx7ltEcC1qmyW7
        hMjf6GwhxmEGlQAEI5yNTFWEYvyQ73ZBlk7+ZUC6c8SrtaUG3gaVNMvYMqmaA8cbfgijbLXotG7kI
        loR0QDMepRM1YXpnBY9CeV2WxRiX2Op12vQTBsgEvUwzCK3SSFcX23WSycaxTA7wITi9rX/gjfXSN
        vZYq/Xvwf9ltCXg2nfHbJzZ8PTm0H1cpC2P/T2z+z4CE/GCLnFBZesFgnC8RRv9xzZIuElt2LDdSq
        H5T7GKxrpnbM6MQ1NYi8H6xIjAUgpqVqPo3DKrW5SMrGN+1waaxNgXd1NQlJhSu6cV7OLdgLnbpcs
        nnWFKjjA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gCpJY-0003BU-4X; Wed, 17 Oct 2018 17:08:56 +0000
Subject: Re: [PATCH] docs: Introduce deprecated APIs list
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <20181017021708.GA22211@beast>
 <aed0041d-7c28-4dfb-91b5-fc83174d8744@infradead.org>
 <875zy0ki3r.fsf@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <70d6b61f-25af-f903-0693-46e649c08aff@infradead.org>
Date:   Wed, 17 Oct 2018 10:08:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <875zy0ki3r.fsf@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/18 3:00 AM, Jani Nikula wrote:
> On Tue, 16 Oct 2018, Randy Dunlap <rdunlap@infradead.org> wrote:
>> On 10/16/18 7:17 PM, Kees Cook wrote:
>>> As discussed in the "API replacement/deprecation" thread[1], this
>>> makes an effort to document what things shouldn't get (re)added to the
>>> kernel, by introducing Documentation/process/deprecated.rst. It also
>>> adds the overflow kerndoc to ReST output, and tweaks the struct_size()
>>> documentation to parse correctly.
>>>
>>> [1] https://lists.linuxfoundation.org/pipermail/ksummit-discuss/2018-September/005282.html
>>>
>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>> ---
>>>  Documentation/driver-api/basics.rst  |  3 +
>>>  Documentation/process/deprecated.rst | 99 ++++++++++++++++++++++++++++
>>>  Documentation/process/index.rst      |  1 +
>>>  include/linux/overflow.h             |  2 +-
>>>  4 files changed, 104 insertions(+), 1 deletion(-)
>>>  create mode 100644 Documentation/process/deprecated.rst
>>
>>
>>> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
>>> index 40b48e2133cb..2f224f43dd06 100644
>>> --- a/include/linux/overflow.h
>>> +++ b/include/linux/overflow.h
>>> @@ -291,7 +291,7 @@ static inline __must_check size_t __ab_c_size(size_t n, size_t size, size_t c)
>>>  }
>>>  
>>>  /**
>>> - * struct_size() - Calculate size of structure with trailing array.
>>> + * function struct_size() - Calculate size of structure with trailing array.
>>
>> That syntax is not explained nor documented in Documentation/doc-guide/kernel-doc.rst.
>>
>> Is the root problem that the function name begins with "struct"?
>> Please explain in the patch description.
> 
> Indeed, shouldn't be needed.
> 
> BR,
> Jani.
> 
>>
>>>   * @p: Pointer to the structure.
>>>   * @member: Name of the array member.
>>>   * @n: Number of elements in the array.
>>
>>
>> thanks.


Well, this is just a guess (no testing), but in scripts/kernel-doc (at line
1907 in 4.19-rc8), we can see:

	if ($identifier =~ m/^struct/) {
	    $decl_type = 'struct';
	} elsif ($identifier =~ m/^union/) {
	    $decl_type = 'union';
	} elsif ($identifier =~ m/^enum/) {
	    $decl_type = 'enum';
	} elsif ($identifier =~ m/^typedef/) {
	    $decl_type = 'typedef';
	} else {
	    $decl_type = 'function';
	}

I wouldn't be surprised if a function named "struct_size" looks like a
type struct.  Maybe it needs to be more strict, with either a space or
word boundary at the end of each type string.  E.g.:

	if ($identifier =~ m/^struct\b/) {
	    $decl_type = 'struct';
	} elsif ($identifier =~ m/^union\b/) {
	    $decl_type = 'union';
	} elsif ($identifier =~ m/^enum\b/) {
	    $decl_type = 'enum';
	} elsif ($identifier =~ m/^typedef\b/) {
	    $decl_type = 'typedef';
	} else {
	    $decl_type = 'function';
	}



-- 
~Randy
