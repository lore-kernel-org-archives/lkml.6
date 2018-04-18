Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753784AbeDRMjd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 08:39:33 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:44482 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752747AbeDRMjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 08:39:32 -0400
Subject: Re: [PATCH v4 01/10] x86/microcode/AMD: Subtract SECTION_HDR_SIZE
 from file leftover length
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1521150415.git.mail@maciej.szmigiero.name>
 <b4854b17-e3ba-54d6-488d-0e0bfffe4c71@maciej.szmigiero.name>
 <20180318161200.GA2036@cz.tnic>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Message-ID: <fe58b934-eafe-9ed6-a089-a58caaf90fc8@maciej.szmigiero.name>
Date: Wed, 18 Apr 2018 14:39:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180318161200.GA2036@cz.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.03.2018 17:12, Borislav Petkov wrote:
> On Fri, Mar 16, 2018 at 12:07:42AM +0100, Maciej S. Szmigiero wrote:
>> verify_patch_size() function verifies whether the microcode container file
>> remaining size is large enough to contain a patch of the indicated size.
>>
>> However, the section header length is not included in this indicated size
>> but it is present in the leftover file length so it should be subtracted
>> from the leftover file length before passing this value to
>> verify_patch_size().
>>
>> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
>> ---
>>  arch/x86/kernel/cpu/microcode/amd.c | 11 ++++++++++-
>>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> I split the comment and applied this:
> 
> ---
> From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
> Date: Fri, 16 Mar 2018 00:07:42 +0100
> Subject: [PATCH] x86/microcode/AMD: Subtract SECTION_HDR_SIZE from file
>  leftover length

Can't really find this commit in any tree I have looked at (bp.git and
tip.git at kernel.org).
Was it pushed somewhere else?

Maciej
