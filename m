Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751975AbeECBYJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 21:24:09 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:36769 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751745AbeECBYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 21:24:07 -0400
X-Google-Smtp-Source: AB8JxZoMF4VyPD8cBrRAdd9AoYKCadAzW46VYsAzk0B19eOJywkimcqxw5s7Prtrf18bl30pvn2h0A==
Date: Wed, 2 May 2018 22:24:02 -0300
From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To: Wenwen Wang <wang6495@umn.edu>
Cc: Kangjie Lu <kjlu@umn.edu>, Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:SCTP PROTOCOL" <linux-sctp@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sctp: fix a potential missing-check bug
Message-ID: <20180503012402.GK5105@localhost.localdomain>
References: <1525310145-28102-1-git-send-email-wang6495@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525310145-28102-1-git-send-email-wang6495@umn.edu>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 02, 2018 at 08:15:45PM -0500, Wenwen Wang wrote:
> In sctp_setsockopt_maxseg(), the integer 'val' is compared against min_len
> and max_len to check whether it is in the appropriate range. If it is not,
> an error code -EINVAL will be returned. This is enforced by a security
> check. But, this check is only executed when 'val' is not 0. In fact, if
> 'val' is 0, it will be assigned with a new value (if the return value of
> the function sctp_id2assoc() is not 0) in the following execution. However,
> this new value of 'val' is not checked before it is used to assigned to
> asoc->user_frag. That means it is possible that the new value of 'val'
> could be out of the expected range. This can cause security issues
> such as buffer overflows, e.g., the new value of 'val' is used as an index
> to access a buffer.
>
> This patch inserts a check for the new value of 'val' to see if it is in
> the expected range. If it is not, an error code -EINVAL will be returned.
>
> Signed-off-by: Wenwen Wang <wang6495@umn.edu>
> ---
>  net/sctp/socket.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)

?
This patch is the same as previous one. git send-email <old file>
maybe?

  Marcelo
