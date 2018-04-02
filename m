Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932437AbeDBUBu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 16:01:50 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:39474 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756542AbeDBUBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 16:01:48 -0400
X-Google-Smtp-Source: AIpwx4+ODr+btGD8h2fUM9/TCSOLFTk7wzfCMYkxBNxTYBXOcpO+3vLbAA0thEXIXLQIhI9GNj9wMiWxvMRX/+Dj1ms=
MIME-Version: 1.0
In-Reply-To: <014501d3cabc$e5f22370$b1d66a50$@nexbridge.com>
References: <xmqq6059z9kz.fsf@gitster-ct.c.googlers.com> <014501d3cabc$e5f22370$b1d66a50$@nexbridge.com>
From: Stefan Beller <sbeller@google.com>
Date: Mon, 2 Apr 2018 13:01:46 -0700
Message-ID: <CAGZ79kZOpwQFFf7CM1Msjat_bQXcuPb6eym7z28iU=8UYjfvDg@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git v2.17.0
To: "Randall S. Becker" <rsbecker@nexbridge.com>
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 2, 2018 at 12:57 PM, Randall S. Becker
<rsbecker@nexbridge.com> wrote:
> On April 2, 2018 3:34 PM, Junio C Hamano wrote:
>> The latest feature release Git v2.17.0 is now available at the usual places.  It is
>> comprised of 516 non-merge commits since v2.16.0, contributed by 71
>> people, 20 of which are new faces.
>
> Just a heads up. I think this one might have gotten missed at some point a few months back. I think it was submitted back in January. Not sure where it fell off or whether it was just dropped.
>
> diff --git a/transport-helper.c b/transport-helper.c
> index 3f380d87d..5ee7007f6 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -1212,7 +1212,7 @@ static int udt_do_read(struct unidirectional_transfer *t)
>                 return 0;       /* No space for more. */
>
>         transfer_debug("%s is readable", t->src_name);
> -       bytes = read(t->src, t->buf + t->bufuse, BUFFERSIZE - t->bufuse);
> +       bytes = xread(t->src, t->buf + t->bufuse, BUFFERSIZE - t->bufuse);
>         if (bytes < 0 && errno != EWOULDBLOCK && errno != EAGAIN &&
>                 errno != EINTR) {
>                 error_errno("read(%s) failed", t->src_name);

Patch at https://public-inbox.org/git/010f01d38a9e$a5c4f290$f14ed7b0$@nexbridge.com/
