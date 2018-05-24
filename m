Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966116AbeEXMr0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 08:47:26 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:50939 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965191AbeEXMrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 08:47:21 -0400
X-Google-Smtp-Source: AB8JxZoRU3guVgrqa4ML0NDNZLVsl4bdByGzlMW/nWaXcKHXKyatAjcg/w4ziOgZxWKYkK73EKKxDA==
Subject: Re: [PATCH] block drivers/block: Use octal not symbolic permissions
To: Joe Perches <joe@perches.com>, "Ed L. Cashin" <ed.cashin@acm.org>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jiri Kosina <jikos@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        linux-block@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        Sage Weil <sage@redhat.com>, Alex Elder <elder@kernel.org>,
        Philip Kelleher <pjk1939@linux.vnet.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com,
        nbd@other.debian.org, ceph-devel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        xen-devel@lists.xenproject.org
References: <5e97a292c1ba38a6b5a0caa271d85dc3de1b2aa7.1527105857.git.joe@perches.com>
 <6bf44255-145f-bf14-e254-860731ff9296@kernel.dk>
 <56ee8810463b6c537ca0c10c9f82e6d922acd1f1.camel@perches.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <539cc400-28d7-66df-eb24-77fe95d617a2@kernel.dk>
Date: Thu, 24 May 2018 06:47:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <56ee8810463b6c537ca0c10c9f82e6d922acd1f1.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/18 4:35 PM, Joe Perches wrote:
> On Wed, 2018-05-23 at 15:27 -0600, Jens Axboe wrote:
>> On 5/23/18 2:05 PM, Joe Perches wrote:
>>> Convert the S_<FOO> symbolic permissions to their octal equivalents as
>>> using octal and not symbolic permissions is preferred by many as more
>>> readable.
>>>
>>> see: https://lkml.org/lkml/2016/8/2/1945
>>>
>>> Done with automated conversion via:
>>> $ ./scripts/checkpatch.pl -f --types=SYMBOLIC_PERMS --fix-inplace <files...>
>>>
>>> Miscellanea:
>>>
>>> o Wrapped modified multi-line calls to a single line where appropriate
>>> o Realign modified multi-line calls to open parenthesis
>>
>> Honestly, I see this as pretty needless churn.
> 
> btw:
> 
> There is currently a mixture of symbolic and octal
> permissions uses in block and drivers/block
> 
> ie: 94 octal and 146 symbolic uses.
> 
> If this is applied, all would become octal.

That does help justify the change. My main worry here is creating
unnecessary conflicts, which is always annoying. But it's even more
annoying when the change creating the conflict isn't really that
important at all. Case in point, the patch doesn't apply to the
for-4.18/block branch that it should go into...

-- 
Jens Axboe
