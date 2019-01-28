Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8206C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A70F520879
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548687691;
	bh=7XEjCl0KpbsI3XrFqClcn/docQTvVXDmb56gU7AkLms=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=yB7jtil9Q1AYSqQaDl+E1m0+mhlOqmzTexA207h7hf4mf8QZ25uDHMasvG4o4hNtA
	 lj+4qJOMB0HiwLfn5uJfotFxXJwJqfK3wdfzJVuaum0h2Gxc0QHkJB9glCQDITMUqa
	 AOU+xwe/xYN+MaTCTwsSooV8K4ZlT0q5bUaS3x5M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfA1PB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:01:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:56082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726682AbfA1PB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:01:29 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FBCC20879;
        Mon, 28 Jan 2019 15:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548687689;
        bh=7XEjCl0KpbsI3XrFqClcn/docQTvVXDmb56gU7AkLms=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Vlj2RDLVbjnNUO4UYJuOvI9n6txfr2EeihNEihqkYSysuRqGUCT60pHfMrWrx+y+w
         kx+ZWTWT9UKhZoRTXJCtjpHYu0VY1dXbgXeRctKNjTXSLYM21AEo9PJxP43hA0cQF9
         LT1gyqr4WXk47B2SSR7MktspHehWXdME1UhGbrpk=
Subject: Re: [PATCH 1/4] selftests: lib: allow to override CC in the top-level
 Makefile
To:     =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>
Cc:     Fathi Boudra <fathi.boudra@linaro.org>,
        Denys Dmytriyenko <denys@ti.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        shuah <shuah@kernel.org>
References: <20190116174320.14938-1-daniel.diaz@linaro.org>
 <7d75f420-d624-d53d-4fa1-3827c90fa608@kernel.org>
 <CAEUSe7_eYmMSovO4JAabh+83CtY2L8eeMoCVKKS5P-fs7zVhjg@mail.gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <a68c3fdd-081a-74ea-8d98-30eaf3d70446@kernel.org>
Date:   Mon, 28 Jan 2019 08:01:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAEUSe7_eYmMSovO4JAabh+83CtY2L8eeMoCVKKS5P-fs7zVhjg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 1/18/19 10:54 AM, Daniel Díaz wrote:
> Hello!
> 
> On Wed, 16 Jan 2019 at 15:56, shuah <shuah@kernel.org> wrote:
>>
>> On 1/16/19 10:43 AM, Daniel Díaz wrote:
>>> From: Fathi Boudra <fathi.boudra@linaro.org>
>>>
>>> Relax CC assignment to allow to override CC in the top-level Makefile.
>>>
>>> Signed-off-by: Denys Dmytriyenko <denys@ti.com>

Author signed-off missing on this patch. I am dropping this patch
from rc5 for now. Please fix it resend the patch. In the future,
I would like to see that author sends the patch.

thanks,
-- Shuah

