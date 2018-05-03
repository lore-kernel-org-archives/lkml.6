Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751989AbeECB1t (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 21:27:49 -0400
Received: from mta-p4.oit.umn.edu ([134.84.196.204]:47574 "EHLO
        mta-p4.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751745AbeECB1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 21:27:47 -0400
X-Google-Smtp-Source: AB8JxZplYUvsNKIfcAWKFScaq10hbUUjUPRDP7i1qZomUQ2OwuQ6wzEsVx/vHcCcQEOHLuhc0voO+9v8WCSS9VIFMrA=
MIME-Version: 1.0
In-Reply-To: <20180503012402.GK5105@localhost.localdomain>
References: <1525310145-28102-1-git-send-email-wang6495@umn.edu> <20180503012402.GK5105@localhost.localdomain>
From: Wenwen Wang <wang6495@umn.edu>
Date: Wed, 2 May 2018 20:27:05 -0500
X-Gmail-Original-Message-ID: <CAAa=b7f+dfDUZR7tHvmSQgTcNDmGjvCn9ZK9eevKGF+bNd2Aqg@mail.gmail.com>
Message-ID: <CAAa=b7f+dfDUZR7tHvmSQgTcNDmGjvCn9ZK9eevKGF+bNd2Aqg@mail.gmail.com>
Subject: Re: [PATCH] sctp: fix a potential missing-check bug
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: Kangjie Lu <kjlu@umn.edu>, Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:SCTP PROTOCOL" <linux-sctp@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Wenwen Wang <wang6495@umn.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 2, 2018 at 8:24 PM, Marcelo Ricardo Leitner
<marcelo.leitner@gmail.com> wrote:
> On Wed, May 02, 2018 at 08:15:45PM -0500, Wenwen Wang wrote:
>> In sctp_setsockopt_maxseg(), the integer 'val' is compared against min_len
>> and max_len to check whether it is in the appropriate range. If it is not,
>> an error code -EINVAL will be returned. This is enforced by a security
>> check. But, this check is only executed when 'val' is not 0. In fact, if
>> 'val' is 0, it will be assigned with a new value (if the return value of
>> the function sctp_id2assoc() is not 0) in the following execution. However,
>> this new value of 'val' is not checked before it is used to assigned to
>> asoc->user_frag. That means it is possible that the new value of 'val'
>> could be out of the expected range. This can cause security issues
>> such as buffer overflows, e.g., the new value of 'val' is used as an index
>> to access a buffer.
>>
>> This patch inserts a check for the new value of 'val' to see if it is in
>> the expected range. If it is not, an error code -EINVAL will be returned.
>>
>> Signed-off-by: Wenwen Wang <wang6495@umn.edu>
>> ---
>>  net/sctp/socket.c | 22 +++++++++++-----------
>>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> ?
> This patch is the same as previous one. git send-email <old file>
> maybe?
>
>   Marcelo

Thanks for your suggestion, Marcelo. I can send the old file. But, I
have added a line of comment in this patch.

Wenwen
