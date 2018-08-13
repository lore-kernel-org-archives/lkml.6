Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5064FC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 16:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ACA221730
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 16:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="psBV5Knb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ACA221730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730032AbeHMTW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 15:22:59 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41705 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728540AbeHMTW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 15:22:59 -0400
Received: by mail-wr1-f65.google.com with SMTP id j5-v6so14806857wrr.8;
        Mon, 13 Aug 2018 09:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/0ij0tW3hgtqz1OQL/6weqcDi/Q9htE/8hIqkEpwquk=;
        b=psBV5Knbxy4qAaJl1WqrDyQfq5mXWuIWQmDKs5njr2xVVx3Obd5EsIWBhVPmElPuHR
         aXwkLitPlVvmNOofU31obIdxgchkEPsaRVGj1Ac6Mm3TCPOp67o69VVKV6/5UvpLw/ih
         Wc5f+ESHPdU0dYYZDJVP4bvrRXdMF7/n1f+XLeyhN+Yqow6FynoI/tEcWGP++aiGVWjC
         AU7dc3a/2O7x4xruT6WI6N+FzqY0HtctoO9TcRQ27EzghMFY/oOrDwcV00dsGKB/8NOx
         lrwGkmTNmIVWdNZHNGFK2NaXCVbVSxLoKRIyf9JVPz0YFtmDgUX7VZfsxLVvE+A14hI3
         okMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/0ij0tW3hgtqz1OQL/6weqcDi/Q9htE/8hIqkEpwquk=;
        b=r8s1IroYfActu1g+K/Csdhe6dTZxUkyuN/9oTrQlR08Ld/C9s6J9lm3vfhdtwttHxc
         dGLipJwNKcrViwZzOh2PuFaoPZ9KD/Bx6o7IcwP5AihG63dpgu1yPF5itapa9aj9j0ul
         fhRO40WnAdtsrAG7PmrBjhc1g2shVFDdm/rTy2pngXQLl90+5hKONmbe7FYIlG0K0un1
         KG2FGhNaXgPyZXPirF1Pf+Kct75KGCpyDfa3j7PaNL3ICc2p9/dKPtLQqdgQFrjJHDLO
         7xiWM0tdA4WDKqvY+/hLjA9y0V8vbLGmqSwt0Q0vSUWBxm5oAWwR+eSG6mGCURAed0jd
         s/4Q==
X-Gm-Message-State: AOUpUlHMurgBXrL1/1TWLWnE0t9j4Cy9PWiXqGAty57TegzoLo1iXMuD
        pTxMg+auVHAqAo1iQwuntBRiJ1b8Cyg=
X-Google-Smtp-Source: AA+uWPzjnjIcUiXp4fAyyrSO3Cx9et62DQgwGD0CBI0TA/ydrzVOOt6pkV55uFKiLc/Kay6CJoBo7g==
X-Received: by 2002:a5d:4e49:: with SMTP id r9-v6mr10707646wrt.27.1534178399013;
        Mon, 13 Aug 2018 09:39:59 -0700 (PDT)
Received: from ?IPv6:2001:a61:25e2:700:4f0c:c4f8:e531:4a0d? ([2001:a61:25e2:700:4f0c:c4f8:e531:4a0d])
        by smtp.gmail.com with ESMTPSA id e133-v6sm24665643wma.33.2018.08.13.09.39.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 09:39:58 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, jmoyer@redhat.com, rgoldwyn@suse.com,
        linux-man@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] io_submit.2: Add IOCB_FLAG_IOPRIO
To:     adam.manzanares@wdc.com
References: <20180713205831.8134-1-adam.manzanares@wdc.com>
From:   "Michael Kerrisk (man-opages)" <mtk.manpages@gmail.com>
Message-ID: <aa1c919e-e2c2-6bee-2db6-72c097436c0f@gmail.com>
Date:   Mon, 13 Aug 2018 18:39:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180713205831.8134-1-adam.manzanares@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Adam,

On 07/13/2018 10:58 PM, adam.manzanares@wdc.com wrote:
> From: Adam Manzanares <adam.manzanares@wdc.com>
> 
> The newly added IOCB_FLAG_IOPRIO aio_flag introduces
> new behaviors and return values.
> 
> The details of this new feature are posted here:
> https://lkml.org/lkml/2018/5/22/809

Thanks for this patch. I've applied it, but I have a question below 
about a detail that probably needs fixing.

> Signed-off-by: Adam Manzanares <adam.manzanares@wdc.com>
> ---
>   man2/io_submit.2 | 34 +++++++++++++++++++++++++++-------
>   1 file changed, 27 insertions(+), 7 deletions(-)
> 
> diff --git a/man2/io_submit.2 b/man2/io_submit.2
> index d17e3122a..15e1ecdea 100644
> --- a/man2/io_submit.2
> +++ b/man2/io_submit.2
> @@ -164,14 +164,26 @@ This is the size of the buffer pointed to by
>   This is the file offset at which the I/O operation is to be performed.
>   .TP
>   .I aio_flags
> -This is the flag to be passed iocb structure.
> -The only valid value is
> -.BR IOCB_FLAG_RESFD ,
> -which indicates that the asynchronous I/O control must signal the file
> +This is the set of flags associated with the iocb structure.
> +The valid values are:
> +.RS
> +.TP
> +.BR IOCB_FLAG_RESFD
> +Asynchronous I/O control must signal the file
>   descriptor mentioned in
>   .I aio_resfd
>   upon completion.
>   .TP
> +.BR IOCB_FLAG_IOPRIO " (since Linux 4.18)"
> +.\" commit d9a08a9e616beeccdbd0e7262b7225ffdfa49e92
> +Interpret the
> +.I aio_reqprio
> +field as an
> +.B IOPRIO_VALUE
> +as defined by
> +.IR linux/ioprio.h.
> +.RE
> +.TP
>   .I aio_resfd
>   The file descriptor to signal in the event of asynchronous I/O completion.
>   .SH RETURN VALUE
> @@ -196,13 +208,21 @@ The AIO context specified by \fIctx_id\fP is invalid.
>   \fInr\fP is less than 0.
>   The \fIiocb\fP at
>   .I *iocbpp[0]
> -is not properly initialized,
> -or the operation specified is invalid for the file descriptor
> -in the \fIiocb\fP.
> +is not properly initialized, the operation specified is invalid for the file
> +descriptor in the \fIiocb\fP, or the value in the
> +.I aio_reqprio
> +field is invalid.
>   .TP
>   .B ENOSYS
>   .BR io_submit ()
>   is not implemented on this architecture.
> +.TP
> +.B EPERM
> +The aio_reqprio field is set with the class
> +.B IOPRIO_CLASS_RT
> +, but the submitting context does not have the

What does "submitting context" mean? Threads/tasks/processes have
capabilities. Can you rephrase in terms of processes/threads?

Thanks,

Michael

> +.B CAP_SYS_ADMIN
> +privilege.
>   .SH VERSIONS
>   .PP
>   The asynchronous I/O system calls first appeared in Linux 2.5.
> 
