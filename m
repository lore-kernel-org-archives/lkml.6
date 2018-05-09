Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965458AbeEIT3H (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 15:29:07 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41221 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964931AbeEIT3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 15:29:06 -0400
Subject: Re: [PATCH] x86: pad assembly functions with INT3
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: tglx@linutronix.de, mingo@redhat.com, linux-kernel@vger.kernel.org,
        x86@kernel.org
References: <20180507213755.GA32406@avx2>
 <EF6BC538-EED3-4718-8AD2-DA2F60B580B1@zytor.com>
 <20180509165517.GD16034@avx2>
From: "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <5682ec5f-5d95-4028-ecc5-99f92bcadd14@zytor.com>
Date: Wed, 9 May 2018 12:28:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180509165517.GD16034@avx2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09/18 09:55, Alexey Dobriyan wrote:
> On Mon, May 07, 2018 at 02:41:14PM -0700, hpa@zytor.com wrote:
>>> -#define __ALIGN		.p2align 4, 0x90
>>> +#define __ALIGN		.p2align 4, 0xCC
>>
>> Acked-by: H. Peter Anvin <h.peter.anvin@in tel.com>
> 
> Thanks!
> 
> If someone knows how to control _compiler_ inter-function padding,
> please tell.
> 

I think I have a gcc feature enhancement request for that. It can't be
done without gcc's knowledge of when a fallthrough is happening (I
presume you took that into account in your patch set.)

	-hpa
