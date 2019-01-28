Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6397FC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BF662147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548692901;
	bh=qELQnGLLa8WB/zPJAI7lnArdb26J3dlFSSCaOgi+gqQ=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=IpyDHAj9t+c6NwhRuLHliB9CqEhw+GxK62n+T9xqbveyiTOD7yca7oBg5G003lBp9
	 xcnfNOIowLdyVFY6uutQMiX8bohIXkewAWpvqgOySz0VQnBUxMmt2P2K4WWnRb5JJ2
	 blwogZG7SH4Lu+CaB6g77OZslCTf0C7DiImJP39w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390620AbfA1Q2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:28:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:38868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389824AbfA1Q2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:28:12 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 241912175B;
        Mon, 28 Jan 2019 16:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692892;
        bh=qELQnGLLa8WB/zPJAI7lnArdb26J3dlFSSCaOgi+gqQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=xEBzvdm9mX7/NlX9bFaEd/h0rGMGaBXM/NreHP+N9FXqnPYneEZszgF8veXU8bi3H
         +yOqpE6qwz1xQoFq46/OwIdw9AJQEwlfxr34DLVntLvRFg8lndMoNU153OTV2cuwbO
         jvtIPwlpbyJZ7FXjwTae9YXPryb4tvmro16u8dxA=
Subject: Re: [PATCH 1/4] selftests: lib: allow to override CC in the top-level
 Makefile
To:     Denys Dmytriyenko <denys@ti.com>
Cc:     =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>,
        Fathi Boudra <fathi.boudra@linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        shuah <shuah@kernel.org>
References: <20190116174320.14938-1-daniel.diaz@linaro.org>
 <7d75f420-d624-d53d-4fa1-3827c90fa608@kernel.org>
 <CAEUSe7_eYmMSovO4JAabh+83CtY2L8eeMoCVKKS5P-fs7zVhjg@mail.gmail.com>
 <a68c3fdd-081a-74ea-8d98-30eaf3d70446@kernel.org>
 <20190128154242.GB15002@beryl>
From:   shuah <shuah@kernel.org>
Message-ID: <4a5fc384-ee96-54ba-02f5-fc5ab7c79c47@kernel.org>
Date:   Mon, 28 Jan 2019 09:28:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190128154242.GB15002@beryl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/19 8:42 AM, Denys Dmytriyenko wrote:
> On Mon, Jan 28, 2019 at 08:01:15AM -0700, shuah wrote:
>> Hi Daniel,
>>
>> On 1/18/19 10:54 AM, Daniel Díaz wrote:
>>> Hello!
>>>
>>> On Wed, 16 Jan 2019 at 15:56, shuah <shuah@kernel.org> wrote:
>>>>
>>>> On 1/16/19 10:43 AM, Daniel Díaz wrote:
>>>>> From: Fathi Boudra <fathi.boudra@linaro.org>

This is the problem. It says, it came from Fathi Boudra 
<fathi.boudra@linaro.org>


>>>>>
>>>>> Relax CC assignment to allow to override CC in the top-level Makefile.
>>>>>
>>>>> Signed-off-by: Denys Dmytriyenko <denys@ti.com>
> 
> ^^^ I am the original author of the patch and this is my signed-off line.
> 

thanks,
-- Shuah
