Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932266AbeCLNce (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 09:32:34 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:45026 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751725AbeCLNcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 09:32:33 -0400
Subject: Re: [PATCH v2] x86/microcode/AMD: check microcode file sanity before
 loading it
To: Borislav Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <787b0ecc-8c1a-3b5a-82e0-9840c7b7c595@maciej.szmigiero.name>
 <20180312095336.GB9431@pd.tnic>
 <ddf0ddc2-bc46-d61c-7080-0eca26d6bfcf@maciej.szmigiero.name>
 <20180312130653.GC9431@pd.tnic>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Message-ID: <df1e721c-f030-68b4-f197-2592bce97bbf@maciej.szmigiero.name>
Date: Mon, 12 Mar 2018 14:32:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180312130653.GC9431@pd.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.03.2018 14:06, Borislav Petkov wrote:
> On Mon, Mar 12, 2018 at 01:56:59PM +0100, Maciej S. Szmigiero wrote:
(..)
>> Since the maximum entry count in current microcode files is 18 the
> 
> Where did you dream up that 18?

"microcode_amd.bin" in linux-firmware.

>> Also, looking in the past, there probably won't be more than 256 AMD CPU
>> types in one CPU family.
> 
> Wrong.

There is no problem raising this value in that (future) case.
As I wrote previously, currently the maximum used count is 18.

> The only limitation on the equivalence table size we have is the 32-bit
> unsigned length field at offset 8 in the equivalence table header.

Not really, since even in the existing code CONTAINER_HDR_SZ (12) gets
added to this size, then the sum is cast to a (signed) int.
If this value is negative then the file get rejected.

>> This limit is an absolute upper cap of a patch size.
> 
> More dreamt up crap.
> 
> See verify_patch_size() for the actual patch sizes.
> 

It can be changed to the current maximum across sizes for particular
families, but then the limit will need to be raised when adding a new
family (if it uses a larger patch).

Maciej
