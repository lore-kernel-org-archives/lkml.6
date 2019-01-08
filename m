Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0C3C43612
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58AA8206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcbxLlYk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbfAHODo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 09:03:44 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45920 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728112AbfAHODo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 09:03:44 -0500
Received: by mail-ed1-f67.google.com with SMTP id d39so4290782edb.12;
        Tue, 08 Jan 2019 06:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2u1e3R9FKHkYT4sG/wFzD0rdqI12hDyfz5KaMxjR9iM=;
        b=mcbxLlYku3eSZzrS/PjlTJ61jmlRNiW3xrwNwVihU0gjdoTaCxClHPWdPw06gGNCst
         pgiUoNjbMhcqYifr0k1Q7EDqZZyEJHnH5ftiIWC8OwymLkxpWEblgvN+zwwnQcr60IgD
         uJ0zvHlCpfXHyxppAOGFysgq2mlrcUYF+RnLeXvfb2Tui4pAFQtEng7gFFwIf1ZBoovJ
         /z09MSZZUKdR4QZHmyDIJL8Aitsf0Tyk0Rf+zsu7vfhxpNC2Ywvj4EsCxRJxJ1N1wDy3
         ErupAlDDHue0uvy7bCVWuLyfuCwOMH/FfEkf2hC28eY73vrqao9OQmBoDHt46CQ//U/U
         7ecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2u1e3R9FKHkYT4sG/wFzD0rdqI12hDyfz5KaMxjR9iM=;
        b=eq4EyZ+XBdrooeo2XT808udCRLvWB6++y6vGhO1DOGAJ64hYPwshMmWpKctxkwvK4w
         DtOOgmGQSNqgXDIhnsBO/Vl58GlhqvMV+kezw8okX/uPbtW/wf2C/X0UurAzdiHOpYo7
         +zvaKnAT2gONUM7yyxUs/62nTCpYwgg1B/AOIKCnVFPB7dyzvBaXIEER53CXYbxMH1hZ
         iM0FZtCmNXjfBegT79kNf3vj6p/JD2gFl6wodY/frHZpwyyQSPwWHeG6tk10w6srLSni
         K4IUja8QRMuPJpQ13Fpa6MjRvK+7E8co7QoES3TuxrdcPFAPR5CDw/11RcmAvhvf7195
         mfjA==
X-Gm-Message-State: AJcUukdbC8U/aB7WkVAsJOEcriLS/sqEy+oNlNVltjpuE+/Jeb7vgLco
        geccVTrr3q03ELZFlg6dRldKAD8ZyVIY7eL8kJPHFkjG
X-Google-Smtp-Source: ALg8bN453R5saFqFOpbgB3YAaZKfrniUSmxZl/c7AK2PgUcuJTNqiyqy57xyMuerhUb1JcWqH6igw4czO1mR4K4LS3E=
X-Received: by 2002:a50:a458:: with SMTP id v24mr2182504edb.241.1546956221463;
 Tue, 08 Jan 2019 06:03:41 -0800 (PST)
MIME-Version: 1.0
References: <20190108032657.8331-1-deepa.kernel@gmail.com> <20190108032657.8331-7-deepa.kernel@gmail.com>
In-Reply-To: <20190108032657.8331-7-deepa.kernel@gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Tue, 8 Jan 2019 09:03:04 -0500
Message-ID: <CAF=yD-L_KbVEbMaY6-3uA4Sp7gDMPEcF7+74J4TzukXb33t55w@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] socket: Add SO_TIMESTAMP[NS]_NEW
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Ralf Baechle <ralf@linux-mips.org>, rth@twiddle.net,
        linux-alpha@vger.kernel.org,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-rdma@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 7, 2019 at 10:29 PM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>
> Add SO_TIMESTAMP_NEW and SO_TIMESTAMPNS_NEW variants of
> socket timestamp options.
> These are the y2038 safe versions of the SO_TIMESTAMP_OLD
> and SO_TIMESTAMPNS_OLD for all architectures.
>
> Note that the format of scm_timestamping.ts[0] is not changed
> in this patch.
>
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> Cc: jejb@parisc-linux.org
> Cc: ralf@linux-mips.org
> Cc: rth@twiddle.net
> Cc: linux-alpha@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> Cc: linux-parisc@vger.kernel.org
> Cc: linux-rdma@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: sparclinux@vger.kernel.org

> @@ -1864,20 +1864,39 @@ static void tcp_update_recv_tstamps(struct sk_buff *skb,
>  static void tcp_recv_timestamp(struct msghdr *msg, const struct sock *sk,
>                                struct scm_timestamping *tss)
>  {
> -       struct __kernel_old_timeval tv;
>         bool has_timestamping = false;
> +       int new_tstamp = sock_flag(sk, SOCK_TSTAMP_NEW);

nit: move above has_timestamping to maintain reverse christmas tree ordering
