Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751907AbeCWOkz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 10:40:55 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:50108 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751689AbeCWOky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 10:40:54 -0400
Subject: Re: [PATCH v4 06/10] x86/microcode/AMD: Check patch size in
 verify_and_add_patch()
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1521150415.git.mail@maciej.szmigiero.name>
 <30562911-7fde-782b-d1b2-03e30b6987c5@maciej.szmigiero.name>
 <20180322161130.GA11575@cz.tnic>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Message-ID: <239ed1f7-cf4a-f187-549f-ea7e08b4e765@maciej.szmigiero.name>
Date: Fri, 23 Mar 2018 15:40:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180322161130.GA11575@cz.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.03.2018 17:11, Borislav Petkov wrote:
> On Fri, Mar 16, 2018 at 12:08:17AM +0100, Maciej S. Szmigiero wrote:
>> @@ -505,7 +505,7 @@ static unsigned int verify_patch_size(u8 family, u32 patch_size,
>>  		break;
>>  	}
>>  
>> -	if (patch_size > min_t(u32, size, max_size)) {
>> +	if (patch_size > min_t(size_t, size, max_size)) {
> 
> So I don't like this conversion to 8-byte-width size_t's. It is not
> necessary. I'm pretty sure we can do fine with signed and unsigned ints.

It is possible to keep verify_patch_size() unmodified (with unsigned int
and u32) but microcode container files >4GB in size then may be rejected,
even if they are technically valid (while a bit unrealistic) on 64-bit
kernels.

Thanks,
Maciej
