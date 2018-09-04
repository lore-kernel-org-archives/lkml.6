Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2FDC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 06:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E04220873
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 06:38:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E04220873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbeIDLCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 07:02:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36881 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726016AbeIDLCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 07:02:24 -0400
Received: from carbon-x1.hos.anvin.org (c-24-5-245-234.hsd1.ca.comcast.net [24.5.245.234] (may be forged))
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id w846aGBP3587245
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Mon, 3 Sep 2018 23:36:17 -0700
Subject: Re: [PATCH 1/3] x86/boot: Add bit fields into xloadflags for 5-level
 kernel checking
To:     Baoquan He <bhe@redhat.com>, kirill.shutemov@linux.intel.com
Cc:     x86@kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org
References: <20180829141624.13985-1-bhe@redhat.com>
 <20180829141624.13985-2-bhe@redhat.com>
 <6ea94875-ae07-6220-eb3e-d3f830cdac03@zytor.com>
 <20180904034414.GI1740@192.168.1.3>
 <4546fc39-4982-4c91-c812-0df1e9bc9e20@zytor.com>
 <20180904052036.GJ1740@192.168.1.3>
 <c4f65956-ad99-84ee-d4bf-044a6f0c5010@zytor.com>
 <20180904060649.GK1740@192.168.1.3>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <44fc1530-eb88-d8c5-7465-e48c91799a98@zytor.com>
Date:   Mon, 3 Sep 2018 23:36:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180904060649.GK1740@192.168.1.3>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/18 23:06, Baoquan He wrote:
>>
>> That makes no sense.  I'm talking about *entering* the kernel; the second
>> kernel should switch to 5-level mode as necessary.
> 
> OK, I didn't get your point. I forget what difficulty was met so that
> Kirill need to take this way. In that way, we will never have chance to
> put kernel above 64TB even from 5-level kernel to jump to 5-level
> kernel.
> 

It sounds like you have no intent of doing that anyway?  Now, that is
something one could use an xloadflag for, as I previously stated: "this kernel
supports being entered in 5-level mode."

	-hpa

