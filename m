Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id WoUeFwEUGVtLOAAAmS7hNA
	; Thu, 07 Jun 2018 11:17:08 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 8CD57608B8; Thu,  7 Jun 2018 11:17:08 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HvlFl97K"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id F219D60290;
	Thu,  7 Jun 2018 11:17:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F219D60290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932533AbeFGLRE (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 07:17:04 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:32876 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932085AbeFGLRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 07:17:02 -0400
Received: by mail-lf0-f68.google.com with SMTP id y20-v6so14098134lfy.0;
        Thu, 07 Jun 2018 04:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4Z3F5LVMeqfv12JfNQZiBFf8/++v0K+gVRwV1xuQgWU=;
        b=HvlFl97KSHPe9ZK0RTLb9bpG02QnnJKEYZyNqE39H8W+wgRmvLQthyDa8PhV8EVopC
         JswajA7McKY4f1P2TG/I0khz+eP4YJTzQuwtRcTMmHP8vBPGjg/Sg1Ot+VZry5er34E7
         iZUJ1kKOTHFlt8ueqmJVQdt92YEjt5Ftdnq72TQYCO52RwNWtMP3eIuwSZZwQ6gLPU7d
         7GzzNWwStsInLImuBYkS+TxZ+dm69HSJm2D0U9exFmqZtRDWIuBNnjDSKWq5ua1hhm1k
         NC290/2V0sXewMLu+/0FWUXLyTrFZQ4qWTkrsCo21h+eNSvkxFE1e8cgE4qsVqe7AAda
         U0Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4Z3F5LVMeqfv12JfNQZiBFf8/++v0K+gVRwV1xuQgWU=;
        b=nSmZTL4zyk5ryyMUI0Nhvy6tbA9KDlO77z9vLv1HHYgcAKqRbF5Ul6x9JtknOiQlyE
         3IZOYGZiPSi++vcwORhqcA6cPDJBfYRXczlSacjwg82VoaH3ImNHQRp4gYKTUUGZNDUS
         NiKN9cgSgb70Plbc+ibS6O9TZ6d13JEn3O7q+GDehWTky2ONsU/BwpDkIxa7H+F2MdSc
         wvxl+Atvvqq7tSuqvZse9spqVJkoF0xQuMiUILcRtGvTaU8067SpWLs1KqZ8m9S5RzYT
         L35ooDYMstAElM8uKMmNvv9MVOLj8m260Pg431+dauAheRWpf0z0Ew3sEOQJ4M5vsbOL
         4avw==
X-Gm-Message-State: APt69E0St92UdvZPWQfzaI/rYIH1E7yiH3CDVOJAMJ1GpDkT1WLezt0A
        VyziDy3QPl8b18ZTtBRIvdsL/eqPXIS6qpAGow==
X-Google-Smtp-Source: ADUXVKIHTZP7YXc6rP/pVq2P6JWFBMBxmLZaNWQTcWh9Y+I8IoLiK5DbIsrkETmEhJI0GvPcDkU06Q1rEhkR6JFyK/8=
X-Received: by 2002:a19:d957:: with SMTP id q84-v6mr1031051lfg.79.1528370221059;
 Thu, 07 Jun 2018 04:17:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:a7c2:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 04:17:00 -0700 (PDT)
In-Reply-To: <20180530194807.31657-16-longli@linuxonhyperv.com>
References: <20180530194807.31657-1-longli@linuxonhyperv.com> <20180530194807.31657-16-longli@linuxonhyperv.com>
From: Pavel Shilovsky <piastryyy@gmail.com>
Date: Thu, 7 Jun 2018 04:17:00 -0700
Message-ID: <CAKywueRi=9j=3xPzv1wBJKT2KaZzor1=TMYHiTUUSL5KXrp8QA@mail.gmail.com>
Subject: Re: [Patch v2 15/15] CIFS: Add direct I/O functions to file_operations
To: Long Li <longli@microsoft.com>
Cc: Steve French <sfrench@samba.org>,
        linux-cifs <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-05-30 12:48 GMT-07:00 Long Li <longli@linuxonhyperv.com>:
> From: Long Li <longli@microsoft.com>
>
> With direct read/write functions implemented, add them to file_operations.
> When mounting with "cache=none", CIFS uses direct I/O.
>
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>  fs/cifs/cifsfs.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
> index 62f1662..e84f8c2 100644
> --- a/fs/cifs/cifsfs.c
> +++ b/fs/cifs/cifsfs.c
> @@ -1113,9 +1113,8 @@ const struct file_operations cifs_file_strict_ops = {
>  };
>
>  const struct file_operations cifs_file_direct_ops = {
> -       /* BB reevaluate whether they can be done with directio, no cache */
> -       .read_iter = cifs_user_readv,
> -       .write_iter = cifs_user_writev,
> +       .read_iter = cifs_direct_readv,
> +       .write_iter = cifs_direct_writev,

I would postpone making this change until we have asynchronous I/O
support for direct mode.

--
Best regards,
Pavel Shilovsky
