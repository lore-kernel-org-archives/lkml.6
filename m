Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18D4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D6E32077B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550851153;
	bh=qhlnoMK1lx1KRR17AZc6kj3iOUcSL0fZ8p8QIQ0RH2o=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=cyqPECVmhZ6mXt9R8r7JZbnxhp7daYuBzLmPxP1LU9inPdvo//wvDM3aXTvvOAdol
	 rvnA+mFqpnLDGQIom+Z1+uW/9xk3zDOjp6GzD0rW0xjBuQ5rtD7VOPPiQMNYdFzQDV
	 BDrIS0s9pfpUFBmVLJJat/DHmk4AUt95K1Gei9TA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfBVP7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 10:59:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:39050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbfBVP7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 10:59:11 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 880732070D;
        Fri, 22 Feb 2019 15:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550851150;
        bh=qhlnoMK1lx1KRR17AZc6kj3iOUcSL0fZ8p8QIQ0RH2o=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=tdgwcbzXc3F+icJLCtNElpx+l1manzP+afwaDiLKytz4Hta6+0MbFhjUIJ1sGtQwN
         ijzktFPeVaqcg2h/MJZvQ83b8PmKNsxijPsNKcH2q8lUVik9Aip7ER/Wh/iP4FrGXu
         BGdksrK6txUkAMBpjf0rP5S/pS6B3S2tdS5RQnI4=
Subject: Re: [PATCH v2 1/2] selftests/ftrace: Replace echo -e with printf
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Juerg Haefliger <juerg.haefliger@canonical.com>
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, Juerg Haefliger <juergh@canonical.com>,
        shuah <shuah@kernel.org>
References: <20190220161333.28109-1-juergh@canonical.com>
 <20190222091021.10178-1-juergh@canonical.com>
 <20190222091021.10178-2-juergh@canonical.com>
 <20190222235810.ae69b00c57442b5fb9dd01a8@kernel.org>
From:   shuah <shuah@kernel.org>
Message-ID: <7a9d8ad8-8520-a0f7-9c55-94740a3a1248@kernel.org>
Date:   Fri, 22 Feb 2019 08:58:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190222235810.ae69b00c57442b5fb9dd01a8@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Juerg,

On 2/22/19 7:58 AM, Masami Hiramatsu wrote:
> On Fri, 22 Feb 2019 10:10:20 +0100
> Juerg Haefliger <juerg.haefliger@canonical.com> wrote:
> 
>> echo -e is not POSIX. Depending on what /bin/sh is, we can get
>> incorrect output like:
>> $ -e -n [1] Basic trace file check
>> $ -e 	[PASS]
>>
>> Fix that by using printf instead.
>>
>> Signed-off-by: Juerg Haefliger <juergh@canonical.com>
> 
> Looks good to me.
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> 

I wasn't on the To or Cc on the original patch. Make sure to
run the get_maintainers and include the people it recommends.

Please resend the patch to me, so I can take it for 5.1-rc1

thanks,
-- Shuah
