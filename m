Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752756AbeC2NUC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 09:20:02 -0400
Received: from ozlabs.org ([103.22.144.67]:39851 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751211AbeC2NUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 09:20:00 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Shea Levy <shea@shealevy.com>, Joe Perches <joe@perches.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        "Oliver O'Halloran" <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 14/16] powerpc: Use generic free_initrd_mem.
In-Reply-To: <874lkzudkc.fsf@xps13.shealevy.com>
References: <20180328152714.6103-1-shea@shealevy.com> <20180328203659.18692-1-shea@shealevy.com> <20180328203659.18692-15-shea@shealevy.com> <1522269853.12357.135.camel@perches.com> <874lkzudkc.fsf@xps13.shealevy.com>
Date: Fri, 30 Mar 2018 00:19:40 +1100
Message-ID: <87a7ur10k3.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shea Levy <shea@shealevy.com> writes:

> Joe Perches <joe@perches.com> writes:
>
>> On Wed, 2018-03-28 at 16:36 -0400, Shea Levy wrote:
>>> Signed-off-by: Shea Levy <shea@shealevy.com>
>>
>> Most people seem to want some form of commit message
>> and not just your sign-off.
>>
>
> Ah, if the subject is insufficient I can add some more detail.

Yeah please do.

Seeing this patch in isolation, with no change log, I might think it's
safe for me to just apply it.

But that would break the build because I don't have patch 1.

So for starters you need to explain that part, eg something like:

  A previous patch in the series added a weak definition of
  free_initrd_mem() in init/initramfs.c.

  The powerpc implementation is identical, so it can be removed allowing
  the generic version to be used.


Then you could also tell me if you did/didn't build/boot test it.

cheers
