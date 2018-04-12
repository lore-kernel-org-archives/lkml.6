Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752793AbeDLJLZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 05:11:25 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50396 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751832AbeDLJLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 05:11:23 -0400
X-Google-Smtp-Source: AIpwx49TNFHJolWF6kuduksUaSbarGn5wOOP3B8IPuGoe3qAPBaoAqEcvq1OG0K+IF6H1y5HeG9hOQ==
Cc: mtk.manpages@gmail.com, linux-man@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] readv.2, io_submit.2: Document RWF_APPEND added in
 Linux 4.16
To: =?UTF-8?Q?J=c3=bcrg_Billeter?= <j@bitron.ch>
References: <1f559be3-93df-ccdd-02dc-39c83c83a8c9@gmail.com>
 <20180406135106.30342-1-j@bitron.ch>
From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <e81fe2fe-1fa0-f348-7811-e5bc6235e903@gmail.com>
Date: Thu, 12 Apr 2018 11:11:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180406135106.30342-1-j@bitron.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/06/2018 03:51 PM, Jürg Billeter wrote:
> Signed-off-by: Jürg Billeter <j@bitron.ch>

Thanks, Jürg. Patch applied.

Cheers,

Michael


> ---
> Changes since version 1:
> - Explain offset handling
> 
>  man2/io_submit.2 | 13 +++++++++++++
>  man2/readv.2     | 17 +++++++++++++++++
>  2 files changed, 30 insertions(+)
> 
> diff --git a/man2/io_submit.2 b/man2/io_submit.2
> index 397fd0b75..25961138a 100644
> --- a/man2/io_submit.2
> +++ b/man2/io_submit.2
> @@ -111,6 +111,19 @@ field of the
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
> +The
> +.I aio_offset
> +field is ignored. The file offset is not changed.
>  .RE
>  .TP
>  .I aio_lio_opcode
> diff --git a/man2/readv.2 b/man2/readv.2
> index b3b7b9658..9ef250e11 100644
> --- a/man2/readv.2
> +++ b/man2/readv.2
> @@ -248,6 +248,23 @@ to
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
> +The
> +.I offset
> +argument does not affect the write operation, the data is always appended
> +to the end of the file. However, if the
> +.I offset
> +argument is \-1, the current file offset is updated.
> +This matches the behavior when the file is opened in append mode.
>  .SH RETURN VALUE
>  On success,
>  .BR readv (),
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
