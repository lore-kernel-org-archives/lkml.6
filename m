Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752657AbeEUOUF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 10:20:05 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:38399 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751576AbeEUOUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 10:20:02 -0400
X-Google-Smtp-Source: AB8JxZr6X/cyTvxbwsd06SDizwGr8XVgYf2jzGC+agVop/PVR2kGXUWgYtFRZkA1S5N+mA3oEHWj2w==
Subject: Re: [PATCH 00/13] convert block layer to bioset_init()/mempool_init()
To: Mike Snitzer <snitzer@redhat.com>,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        hch@infradead.org, colyli@suse.de, darrick.wong@oracle.com, clm@fb.com,
        bacik@fb.com, linux-xfs@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-btrfs@vger.kernel.org, linux-raid@vger.kernel.org,
        neilb@suse.com
References: <20180520222558.7053-1-kent.overstreet@gmail.com>
 <20180521140348.GA19069@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <686d7df6-c7d1-48a6-b7ff-48dc8aff6a62@kernel.dk>
Date: Mon, 21 May 2018 08:19:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180521140348.GA19069@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/21/18 8:03 AM, Mike Snitzer wrote:
> On Sun, May 20 2018 at  6:25pm -0400,
> Kent Overstreet <kent.overstreet@gmail.com> wrote:
> 
>> Jens - this series does the rest of the conversions that Christoph wanted, and
>> drops bioset_create().
>>
>> Only lightly tested, but the changes are pretty mechanical. Based on your
>> for-next tree.
> 
> By switching 'mempool_t *' to 'mempool_t' and 'bio_set *' to 'bio_set'
> you've altered the alignment of members in data structures.  So I'll
> need to audit all the data structures you've modified in DM.
> 
> Could we get the backstory on _why_ you're making this change?
> Would go a long way to helping me appreciate why this is a good use of
> anyone's time.

Yeah, it's in the first series, it gets rid of a pointer indirection.

-- 
Jens Axboe
