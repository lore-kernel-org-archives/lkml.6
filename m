Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752968AbeFARKi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 13:10:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:48300 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751849AbeFARKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 13:10:36 -0400
Date: Fri, 1 Jun 2018 10:10:28 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org,
        tgraf@suug.ch, manfred@colorfullife.com, mhocko@kernel.org,
        guillaume.knispel@supersonicimagine.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 1/5] lib/rhashtable: convert param sanitations to WARN_ON
Message-ID: <20180601171028.3rjlozqmuoofa3iy@linux-r8p5>
References: <20180601160125.30031-1-dave@stgolabs.net>
 <20180601160125.30031-2-dave@stgolabs.net>
 <20180601160944.ji2gsp3pyunlj476@gondor.apana.org.au>
 <20180601165347.kvruerdm3gu57ifv@linux-r8p5>
 <20180601165903.bd3jonbv2jrfcevi@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180601165903.bd3jonbv2jrfcevi@gondor.apana.org.au>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 02 Jun 2018, Herbert Xu wrote:

>On Fri, Jun 01, 2018 at 09:53:47AM -0700, Davidlohr Bueso wrote:
>>
>> Curious, are these users setting up the param structure dynamically
>> or something that they can pass along bogus values?
>>
>> If that's the case then yes, I definitely agree.
>
>It's just a quality of implementation issue.  This is a generic API.
>Sure for early-boot users like yours it makes sense to just WARN_ON
>rather than deal with the messy hash table allocation failure.
>
>But for a driver author writing some kernel module it isn't nice
>to WARN_ON and then crash on a NULL-pointer dereference when we
>can cleanly fail the table init.

Fine, at least patch 2 applies without this one. So Andrew, if you
consider taking this series please drop patch 1 and 5 (which no
longer makes sense as rhashtable_init() won't be returning void
in the future).

If you want me to resend (assuming other issues are not pointed out),
I can do but I wanted to avoid spamming more the necessary.

Thanks,
Davidlohr
