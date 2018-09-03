Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A4DC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 22:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90CC920856
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 22:30:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90CC920856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbeIDCwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 22:52:17 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:37073 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbeIDCwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 22:52:17 -0400
Received: by mail-it0-f66.google.com with SMTP id h20-v6so2506980itf.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 15:30:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/XUmSJrN13enuNcOJ1j5O1slBs/suXcVgyhjmUz7H9U=;
        b=paB0iAi0peuhx8C9OIEaYaYWqSzknnd8eSSLwH5TsWOPAneYNZG5RzjwpuWU61XOUy
         eptGuV7S0dLqXJXceP+erlZCGL6UDlr1juxyBGpXDasB+MTqZhUbt+7wIjC+QmF+vni2
         1XzW4kF7cY4E1MCC+g0oGOGU56XyTDxC4vsS9uk0Do8UtnG4U22n3drRTam/O/UAWIjE
         yf/KkKWOlA12fG5q72HP5q7OVM4Hw4q1POqrthSzMdqwnyAA0bnJuKdBhrx8ugot8qgb
         r6W0DEddgXPGAVykNq5QDaME41TP2TDFgy+uZolCM7MT0RY6T5A9KhkNU/US+54Z8S42
         rq6A==
X-Gm-Message-State: APzg51CSHnaaSoHK8uULT9fRMAEv4RynEhSB6BMNFO68pbcUPYQryob7
        UR1BhMj+5rC9uT0a7uAoMUIR9ErsVEMLDqlY8Nsa72Xc
X-Google-Smtp-Source: ANB0VdbRFr2JbkyBC4tOXy9Dz60OvXkLbXmdQ4YIY0ok9AbWCUGYUHI5tW/k/hH4v1fRWNKY+jUmqyZUhMznF2BthRs=
X-Received: by 2002:a24:dd88:: with SMTP id t130-v6mr6105225itf.129.1536013803872;
 Mon, 03 Sep 2018 15:30:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:54c7:0:0:0:0:0 with HTTP; Mon, 3 Sep 2018 15:30:02 -0700 (PDT)
In-Reply-To: <c7a6541c-53e9-f6bd-7589-11f089b57080@infradead.org>
References: <c7a6541c-53e9-f6bd-7589-11f089b57080@infradead.org>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Tue, 4 Sep 2018 00:30:02 +0200
Message-ID: <CAHc6FU6jzP5OwXPv18KJYt8jNCz_CJ_BPfTn8J5PqFFQjmh2Tw@mail.gmail.com>
Subject: Re: [PATCH] fs/posix_acl.c: fix kernel-doc warnings, formatting, and typo
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 September 2018 at 22:52, Randy Dunlap <rdunlap@infradead.org> wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Fix kernel-doc warnings in fs/posic_acl.c.
> Also fix one typo (setgit -> setgid).
>
> ../fs/posix_acl.c:646: warning: Function parameter or member 'inode' not described in 'posix_acl_update_mode'
> ../fs/posix_acl.c:646: warning: Function parameter or member 'mode_p' not described in 'posix_acl_update_mode'
> ../fs/posix_acl.c:646: warning: Function parameter or member 'acl' not described in 'posix_acl_update_mode'
>
> Fixes: 073931017b49d ("posix_acl: Clear SGID bit when setting file permissions")
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Andreas Gruenbacher <agruenba@redhat.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/posix_acl.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> --- lnx-419-rc2.orig/fs/posix_acl.c
> +++ lnx-419-rc2/fs/posix_acl.c
> @@ -630,12 +630,15 @@ EXPORT_SYMBOL_GPL(posix_acl_create);
>
>  /**
>   * posix_acl_update_mode  -  update mode in set_acl
> + * @inode: target inode
> + * @mode_p: mode (pointer) for update
> + * @acl: acl pointer
>   *
>   * Update the file mode when setting an ACL: compute the new file permission
>   * bits based on the ACL.  In addition, if the ACL is equivalent to the new
> - * file mode, set *acl to NULL to indicate that no ACL should be set.
> + * file mode, set ``*acl`` to NULL to indicate that no ACL should be set.

Should be turned into *@acl instead.

>   *
> - * As with chmod, clear the setgit bit if the caller is not in the owning group
> + * As with chmod, clear the setgid bit if the caller is not in the owning group
>   * or capable of CAP_FSETID (see inode_change_ok).
>   *
>   * Called from set_acl inode operations.

Otherwise,
Acked-by: Andreas Gruenbacher <agruenba@redhat.com>

Thanks,
Andreas
