Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70995C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3340A2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aO2jXo9c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3340A2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbeLLPgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 10:36:02 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39393 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbeLLPgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 10:36:02 -0500
Received: by mail-ed1-f65.google.com with SMTP id b14so15898781edt.6;
        Wed, 12 Dec 2018 07:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W89X3rrftkS34pp8m4+cNsxgaqdG/+ly7NIdp+tMwg8=;
        b=aO2jXo9cna//uAcdtmyRdaUZLdOg7nZCHKkZ6UQ2LuVVA9GwunE1scGMZ5MVTinzbf
         +AzWr+gHGAmMYbWwnh8qbddvV9pMQNMSnWDbk3KXQ9H1ee/9AUTui8myA4OLiiysZo3p
         FmepUaKYUY3+tscWYNhUNG9ntUZJh9yc2QqGcBNHiz0v0r9YhcRV08ULGxhJz3Npywjx
         Xs0MpBgV/r/bkDF1iLMKjyPCzlKiDtG42lYtbAE8PlXcrgnujj7VGddPY4g6PLG9n5c3
         OY7WZAhdJ3EiVpfO/s9kCOYImShh8UV7KvWOVEDUueqGh8QAarclkvjjTCPs6QWVMRtB
         xKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W89X3rrftkS34pp8m4+cNsxgaqdG/+ly7NIdp+tMwg8=;
        b=SYB8Xrwc9nvpcl7KusiVANynvUV/aA9r4Fuz0GpD6M0eIT7CnbIcKg+0467wAywiqg
         hIMUT3ztf6Nc68VflYsWMHWtelWwSf5E3z9JFXdSQ0YE7qNoIHjcmQZVTQL+om/I2Obu
         sf1IVxtUDLF6CoC/Zr+Zcf3UGKlDf1ltCO5H3yNMArHc5J6lB7NypNeey8PRBOtXOO9v
         1hGAuDAYMRwNvOkd5kFd2P04Oc588IA6+MvsQ4ZTZzv6iWrIHmhSbx3BZNVvll4WbFQ/
         2xcSZXIQAt4mSs/TkOzKonxaIflHvRAEVO8hzv8V/M1Psc5gSIn9F3HRdF/9t09FXuxz
         y+YA==
X-Gm-Message-State: AA+aEWahUsFL8c5vxBoXbAAiDqNQB/FkdGvKNp6iEe62NBYmZnq7Sctz
        QhvVfYlpEOB3b9cv7U6X3SpXX+DpKeCbkhZk7d4=
X-Google-Smtp-Source: AFSGD/W36/Y9Nq871ioxR//LgBld/IrhxxEkPkbBXz7QpoAxX5Y2MzX8JaowLaWzv5t7FYbXspPDozxDek3fyP6also=
X-Received: by 2002:a17:906:4a4b:: with SMTP id a11-v6mr15704988ejv.68.1544628959470;
 Wed, 12 Dec 2018 07:35:59 -0800 (PST)
MIME-Version: 1.0
References: <20181211202520.16799-1-deepa.kernel@gmail.com>
 <20181211202520.16799-7-deepa.kernel@gmail.com> <CAF=yD-LDWrjxK+XFv-KNAoyP7NCOZiL00n5PkzQ-5aEzq+eCLQ@mail.gmail.com>
In-Reply-To: <CAF=yD-LDWrjxK+XFv-KNAoyP7NCOZiL00n5PkzQ-5aEzq+eCLQ@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Wed, 12 Dec 2018 10:35:23 -0500
Message-ID: <CAF=yD-J8Ea1ope3ZBgPCufnMxDgGArhqRdvszz44u29BJAPS7w@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] socket: Add SO_TIMESTAMP[NS]_NEW
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        jejb@parisc-linux.org, ralf@linux-mips.org, rth@twiddle.net,
        linux-alpha@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linux-rdma@vger.kernel.org,
        sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This did not address yet the previous comments on consistency and
> unnecessary code churn.
>
> The existing logic to differentiate SO_TIMESTAMP from SO_TIMESTAMPNS
> in both tcp_recv_timestamp and __sock_recv_timestamp is
>
>   if (sock_flag(sk, SOCK_RCVTSTAMP)) {
>       if (sock_flag(sk, SOCK_RCVTSTAMPNS))
>           /* timespec case */
>       else
>           /* timeval case */
>   }
>
> A new level of nesting needs to be added to differentiate .._OLD from .._NEW.
>
> Even if massively changing the original functions, please do so
> consistently, either
>
>   if (sock_flag(sk, SOCK_RCVTSTAMP)) {
>       if (sock_flag(sk, SOCK_TSTAMP_NEW) {
>           /* new code */
>       } else {
>           if (sock_flag(sk, SOCK_RCVTSTAMPNS))
>               /* timespec case */
>           else
>               /* timeval case */
>      }
>   }

This first example is wrong. I meant

   if (sock_flag(sk, SOCK_RCVTSTAMP)) {
       if (sock_flag(sk, SOCK_RCVTSTAMPNS)) {
           if (sock_flag(sk, SOCK_TSTAMP_NEW)
                /* new code */
          else
                /* timespec case */
       } else {
           if (sock_flag(sk, SOCK_TSTAMP_NEW)
                /* new code */
          else
                /* timeval case */
        }
   }
