Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751523AbeDERvp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 13:51:45 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33730 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751285AbeDERvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 13:51:43 -0400
X-Google-Smtp-Source: AIpwx48UPd3xh/pIC5IpdA78qDKwcR3op9T/O4+P2MmyTSMMWClw7XOiy1lzUhb3yEx39iFshOmsWw==
Cc: mtk.manpages@gmail.com, linux-man@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] readv.2, io_submit.2: Document RWF_APPEND added in Linux
 4.16
To: =?UTF-8?Q?J=c3=bcrg_Billeter?= <j@bitron.ch>
References: <20180328194911.49632-1-j@bitron.ch>
From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <1f559be3-93df-ccdd-02dc-39c83c83a8c9@gmail.com>
Date: Thu, 5 Apr 2018 19:49:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180328194911.49632-1-j@bitron.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jürg

Thanks for the patch, but there are some details that are
unexplained in the text and in the kernel commit message.

Does the use of these flags change the file offset? The text
should make this point explicit.

Presumably, when using this flag for pwritev2(), the
'offset' argument of the call is ignored. Presumably, the
same is true for the 'aio_offset' field of the 'iocb'
structure when using io_submit(). This point should be
also be made explicit in the patch.

Would you be willing to revise the patch to include the
answers to these questions?

Cheers,

Michael


On 03/28/2018 09:49 PM, Jürg Billeter wrote:
> Signed-off-by: Jürg Billeter <j@bitron.ch>
> ---
>  man2/io_submit.2 | 10 ++++++++++
>  man2/readv.2     | 10 ++++++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/man2/io_submit.2 b/man2/io_submit.2
> index 397fd0b75..79fcdfee4 100644
> --- a/man2/io_submit.2
> +++ b/man2/io_submit.2
> @@ -111,6 +111,16 @@ field of the
>  .I io_event
>  structure (see
>  .BR io_getevents (2)).
> +.TP
> +.BR RWF_APPEND " (since Linux 4.16)"
> +.\" commit e1fc742e14e01d84d9693c4aca4ab23da65811fb
> +Append data to the end of the file.
> +See the description of the flag of the same name in
> +.BR pwritev2 (2)
> +as well as the description of
> +.B O_APPEND
> +in
> +.BR open (2).
>  .RE
>  .TP
>  .I aio_lio_opcode
> diff --git a/man2/readv.2 b/man2/readv.2
> index b3b7b9658..668fba576 100644
> --- a/man2/readv.2
> +++ b/man2/readv.2
> @@ -248,6 +248,16 @@ to
>  .BR EAGAIN .
>  Currently, this flag is meaningful only for
>  .BR preadv2 ().
> +.TP
> +.BR RWF_APPEND " (since Linux 4.16)"
> +.\" commit e1fc742e14e01d84d9693c4aca4ab23da65811fb
> +Provide a per-write equivalent of the
> +.B O_APPEND
> +.BR open (2)
> +flag.
> +This flag is meaningful only for
> +.BR pwritev2 (),
> +and its effect applies only to the data range written by the system call.
>  .SH RETURN VALUE
>  On success,
>  .BR readv (),
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
