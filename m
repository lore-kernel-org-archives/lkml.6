Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751242AbeCJR0I (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 12:26:08 -0500
Received: from vps-vb.mhejs.net ([37.28.154.113]:34004 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750884AbeCJR0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 12:26:07 -0500
Subject: Re: [PATCH] x86/microcode/AMD: check microcode file sanity before
 loading it
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <34e9d679-2eca-90cf-9a95-3864f0be060e@maciej.szmigiero.name>
 <f61522e6-fa15-0fc1-feef-6e0c84d6fc80@maciej.szmigiero.name>
 <20180310164654.GD8261@pd.tnic>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Message-ID: <b290050f-7102-aebf-6a4d-79d63c7335e0@maciej.szmigiero.name>
Date: Sat, 10 Mar 2018 18:26:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180310164654.GD8261@pd.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.03.2018 17:46, Borislav Petkov wrote:
> On Sat, Mar 10, 2018 at 05:16:40PM +0100, Maciej S. Szmigiero wrote:
(..)
>> There is no container file at all for family 17h (Zen) so
>> distributions like OpenSUSE that include this file must have gotten it
>> from some other source
> 
> Or maybe they've gotten it from AMD directly. Don't you think that
> getting microcode from the CPU vendor directly is the logical thing?

"some other source" than linux-firmware includes the CPU vendor.

Also please note that while OpenSUSE can get the microcode directly
from the CPU vendor there seems to be no official AMD web site that
distributes microcode.
And it looks like other distros simply get it from OpenSUSE:
https://bugs.archlinux.org/task/56951

>> That's why to get things like IBPB it is sometimes necessary to use
>> a newer microcode version than included in linux-firmware, sourced for
>> example from a BIOS update.
> 
> linux-firmware will get F17h microcode soon.

Great!
Hope it will include latest production versions for the whole family
17h.

>> Since BIOS updates contain only actual (raw) microcode updates one
>> has to place it in a microcode container file so this driver can parse
>> it.
>>
>> As far I know there is no tool to automate this work so one has to
>> manually tweak the container metadata.
> 
> Let me get this straight: am I reading this correctly that you've tried
> to carve out the F17h microcode from a BIOS update blob and you're
> trying to load that?!?
>
> If so, you could've simply taken a distro microcode package and used
> F17h microcode from there - they are all the same.
> 

"microcode_amd_fam17h.bin" from both my distro (Gentoo) and OpenSUSE
only contains family 23 model 2 microcode while my Ryzen is model 1.

And my motherboard BIOS-loaded microcode is too old to contain IBPB
support.

Maciej
