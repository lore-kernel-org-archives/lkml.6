Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC75C64E75
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 16:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4539222A4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 16:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYPlaWOE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbeLXQKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 11:10:54 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37439 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbeLXQKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 11:10:54 -0500
Received: by mail-pf1-f193.google.com with SMTP id y126so5945135pfb.4;
        Mon, 24 Dec 2018 08:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H6NtWCE1jUb1Ui0xZ1ZBBTANDL9C7ONXqtCEAySMvnc=;
        b=lYPlaWOESn5aD8yTf5ODkMFCwu0JPaaboNBMbAqZnILPPVKPuu9rHuuCfqo5pJD/0w
         Xw9fWXN2egvGbfDM7pOfGtXQjfo+mAnueUnvj15mHuxa6yOpFeSwmmk5OfA468AwWmj9
         VbwgFACFcdFJN+o12w9Wk74eqrRjavk0DRIjkjZZ+ny2UsWC7HdVyUKdQFoD1/lrfuab
         TcMZHHnruDKmwAkKKmCu4uKyBVUr8aTx8KnGnoKn6a/F016eAWF6o++uxL5SUn6U7cPA
         EwJRTJTrFMXggPXg+pip4lmKLFv5MDCyS9GjMm6rptNTz85LMCkfAS80FC3a8I7VRhkv
         cfgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H6NtWCE1jUb1Ui0xZ1ZBBTANDL9C7ONXqtCEAySMvnc=;
        b=HGmXjU/VxHxiRw073/fE1djYywiPz402O5is7H4hw0g2Isrr0xijBNYzQRl2YYt9aq
         iJOFlRgWGbtMpzpuAmaS3ltftzTZpx9yOwd9BJVshXeOlOyDnWP1JAFHcQFbbdW8Lkrb
         IgAvwG6Utyt537age6l7CMdGKkLW6qWGPgKrz5m5OzvIb7mFxd9FWO69foo6RAihUUMo
         MbfUTXXKG6IEmN3cAm1sruXuV5lroR6CmlwHE6w7lT/lNF5ow9gnzbOxPczwxv1cD+a9
         BzQL1aszfig22cvQok75qs1vhu6teXWqp86lvmpFkqu7Ihd75xNclFjadpTTlGM72xaI
         T1lA==
X-Gm-Message-State: AJcUukek3V2ne2GlLrNaYVJalCwLQEXY7Dihc9LX3V+tpEt/qJeyXtDJ
        tWEaSud2sOHNritrxGUlYmkq9A17MC9aQ9xnYQCBhg==
X-Google-Smtp-Source: ALg8bN6vyz5mzhOzffXMO6mHaZUIKfIXB2vEgKbB/tNX78LQoVLQTG8cu/U/IJswmRGeLu6U/7T3CrhkrRImURZlPQk=
X-Received: by 2002:a63:61c8:: with SMTP id v191mr12877684pgb.242.1545667852748;
 Mon, 24 Dec 2018 08:10:52 -0800 (PST)
MIME-Version: 1.0
References: <20181224224542.375a5515@canb.auug.org.au>
In-Reply-To: <20181224224542.375a5515@canb.auug.org.au>
From:   Steve French <smfrench@gmail.com>
Date:   Mon, 24 Dec 2018 10:10:41 -0600
Message-ID: <CAH2r5muQq-3=iK_2j2WvG9dN-_ui_p2jHv4x6Fah+JcHFzo8VQ@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the cifs tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed and remerged to cifs-2.6.git for-next

On Mon, Dec 24, 2018 at 5:45 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Commit
>
>   87410161a381 ("cifs: check kzalloc return")
>
> is missing a Signed-off-by from its author.
>
> --
> Cheers,
> Stephen Rothwell



-- 
Thanks,

Steve
