Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5901C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D85420841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="aJTpqjvw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RI3DNTL3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D85420841
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732637AbeGaVe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 17:34:26 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:33681 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732573AbeGaVeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 17:34:25 -0400
Received: by mail-yb0-f194.google.com with SMTP id e84-v6so6631311ybb.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 12:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ytFUQ5OcV1kMs9mpSpA56S6e7JBOT5LKC5ONT+EdH/Q=;
        b=aJTpqjvwd0uonU473lkWmuOC2hL2TEYIWxTRER8C1CIMaqR4VYziDyjVTm1jyDsAZr
         hrpbdCOsVx8/oPlZyamGgGIocZhqyn5UHiVFHNXtUwV5KVnONIu3MibFrU0vsFwVqTBt
         2MiBu/msyDA6xxEFuL/tqzgQpvyAN/buzRCckcaVlZ80NhBhgV2Y8ePHDTpKwP4ocImV
         NYmt4Glifytzr1D1Qz9pjDwE7Txm3XVzxlY+XLVv+1jHVuFwvmC8Y/y/XI+abosGxzpL
         FdsSi/k5HsXg3ydBjyBLMz+yIpNg9r0C/cB1J4nGElzILqFYxL9ChCBijwWWlZY0kkpy
         QQ2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ytFUQ5OcV1kMs9mpSpA56S6e7JBOT5LKC5ONT+EdH/Q=;
        b=RI3DNTL3lHU/lXYBN4Gyyu/peThAgT27BRI05vuoQ/9ZzGGdJYVPba+K5VD2ghCNuw
         a26lqFC/V06UU7zYlKhQIWyE99ZKtTqDkfYpdS3mN+56ZATgJzYSlKZAbFkW+z541yUo
         7S5ct7CcTlQQZNvVoly/qtuLhMK7NjzGzTFvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ytFUQ5OcV1kMs9mpSpA56S6e7JBOT5LKC5ONT+EdH/Q=;
        b=A77dp+LNOqCjIzVdQLgLeIbdhERY7m5t9ru1tjlSSEV0aODOYXRNIHQQbo9y7FRo35
         RlHd8emyE3dhjZXh5lyC/+Zdi2G8eU0b5PTi0SYc+9F/wmh2ibts9ZHAdEQx8hL9coYB
         SjstZFAu8cCD586+n7a77DtaH4JHB6RjQGqMY0iq+c0B+2Wc4t35v3g+c450LsyXAlCC
         +ui3buuMjP8n5R9aLdgpZZAmt1EXOPpVcJEF1hPaNIeF+gl20RC8WRXUxHXpKzB9o1Yn
         spU8w1CMn8lgyMbRgpY6ktymi/Bz6cxU6y4dohFyN5hUF5AvYwVq7Tbaq3GLydKeIL7y
         znpQ==
X-Gm-Message-State: AOUpUlE0bjdIw5fH3SdNU0VLQVK1TK/n3/k6H3ltsx1puzrweHdb+hlS
        pejx5gT9PJ2TGLbJ+NVrkoH3WqoXDzex7mIxdC4VOw==
X-Google-Smtp-Source: AAOMgpe+kVvvo7c2f7ARNbhjj/h9K4jxngf/PptWmMTJ8RIglCr3ZxEZMCSKXgo/vXuwskcLq0K2l+c1eMAZxmGyF2Q=
X-Received: by 2002:a25:a302:: with SMTP id d2-v6mr12613652ybi.193.1533066751513;
 Tue, 31 Jul 2018 12:52:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:6602:0:0:0:0:0 with HTTP; Tue, 31 Jul 2018 12:52:29
 -0700 (PDT)
In-Reply-To: <20180731075305.GA16318@infradead.org>
References: <CAGXu5jJsGWDsZNDJvUUqncSaAcvond_B_J7=BbvVW0X3r6Sxww@mail.gmail.com>
 <aa150272-ffeb-fb8f-7303-0d9502cf9a71@kernel.dk> <20180523142545.GA16248@infradead.org>
 <24d36869-e037-042d-cb16-20a81b34eb76@kernel.dk> <CAGXu5jJn=1Rz=D8VUwv_VoaGoLtaD=+tcPZxQxntweZoZwFa5Q@mail.gmail.com>
 <f4eb4cd5-8976-3990-69b0-26cca054aa45@kernel.dk> <20180524080015.GA2866@infradead.org>
 <CAGXu5j+pRUWgny+h5ToVQXBP8nANjreVhnXjk5TVgy84ufNsRg@mail.gmail.com>
 <20180708202315.GA2239@infradead.org> <CAGXu5jKvUydp6nc3EUCyoGWbUUoiiASMFcBfVVOph1uc_oCNSg@mail.gmail.com>
 <20180731075305.GA16318@infradead.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 31 Jul 2018 12:52:29 -0700
X-Google-Sender-Auth: vg7Yl-BkQHDM4OPN6aaxHtDi610
Message-ID: <CAGXu5jKnGgAV9vC-mn=jQ+PZXaE_pqc5_6=O3XcSwDagm_3ZmA@mail.gmail.com>
Subject: Re: [PATCH 3/6] block: Create scsi_sense.h for SCSI and ATAPI
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Tejun Heo <tj@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "David S. Miller" <davem@davemloft.net>,
        "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>,
        "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
        Uma Krishnan <ukrishn@linux.vnet.ibm.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 12:53 AM, Christoph Hellwig <hch@infradead.org> wrote:
> On Mon, Jul 09, 2018 at 08:56:50AM -0700, Kees Cook wrote:
>> > Btw, did you plan to resend the series with this and your changes
>> > applied?
>>
>> Yeah, I've gotten distracted. I'll try to get to it in the next few days.
>>
>> Thanks for the reminder!
>
> Another little reminder.  I'd hate to miss it for 4.19.

Okay, finally sent. Thanks for the reminders. :)

-Kees

-- 
Kees Cook
Pixel Security
