Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8EF3C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 21:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ECB62133F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 21:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tjpEDMNK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ECB62133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbeK1IR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 03:17:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:48038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbeK1IR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 03:17:26 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D2F3208E4;
        Tue, 27 Nov 2018 21:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543353494;
        bh=v1VFyfXSdFod5kZfxtSXXhgDSogqP1bW148EQxR7Q5M=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=tjpEDMNKdtfjK53DN42GN/+ez9A5sYVzI8Xz5ybfk/d53IShxLmzqq+roxVLLFJsm
         TlMOsfrXHLWQ3+aQ5g7EV7D+KNpt3XjlSRhjbCase6+aDDBQfL/iZc7JIo+DUig1Y5
         lLOhUfJMkKoxoUuKbudM2XdBYItkGOZPrSh0tRLU=
Subject: Re: linux-next: Signed-off-by missing for commit in the kselftest
 tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Rue <dan.rue@linaro.org>, shuah@kernel.org
References: <20181128073603.3786e528@canb.auug.org.au>
From:   shuah <shuah@kernel.org>
Message-ID: <6235956e-5edd-3b7d-1898-ab55094a7e16@kernel.org>
Date:   Tue, 27 Nov 2018 14:17:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181128073603.3786e528@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/18 1:36 PM, Stephen Rothwell wrote:
> Hi Shuah,
> 
> Commit
> 
>    623ea0df7083 ("selftests: firmware: remove use of non-standard diff -Z option")
> 
> is missing a Signed-off-by from its author.
> 

Thanks for catching this. I will fix it. This is the result of change 
log content messing up the commit: The diff -Z in the change log 
resulted in throwing out the Signed-off and Acked-by.

-----------------------------------------------------------------
diff -Z is used to trim the trailing whitespace when comparing the
loaded firmware file with the source firmware file. However, per the
comment in the source code, -Z should not be necessary. In testing, the
input and output files are identical.

Additionally, -Z is not a standard option and is not available in
environments such as busybox. When -Z is not supported, diff fails with
a usage error, which is suppressed, but then causes read_firmwares() to
exit with a false failure message.
--------------------------------------------------------------------

Oh well! I will fix-up the change-log and amend the commit.

thanks,
-- Shuah
