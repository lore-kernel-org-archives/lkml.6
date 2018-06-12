Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 49D1FC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 15:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F25AA208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 15:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kudzu-us.20150623.gappssmtp.com header.i=@kudzu-us.20150623.gappssmtp.com header.b="a1K854le"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F25AA208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kudzu.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934504AbeFLP7f (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 11:59:35 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:38196 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934050AbeFLP7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 11:59:33 -0400
Received: by mail-io0-f194.google.com with SMTP id l19-v6so28677121ioj.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 08:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6srdUGDMIVnDtA/ksB62yI5BOyICDwDPaYi+LrFPkoM=;
        b=a1K854le4jRBfszXa2OQH+ZQUEmnwE9H6T5q6uJxZzyyKNEpgEnFI5meycWQ+tympX
         1Tu//IKu14Vr31GiQBdbkGDRxJeL4zpwCsZAxtFg1qVjkNo/9/7outZeP9OzZ4PSTeZp
         Jqj5gqeTSGrk2Fmr2YJx24W7fErlxTTqXc/NhjmgOdkkql96l2JS6Jjq8/vh3sT/kPeh
         RNR+Oh1ZMwLepTnveNxUuDMmn3srt3CA+fM7mSYkhnqLmT/4t/p7c3v4PXRm41ud7TyI
         U3EtEfVzwUAy9lPLWEhcdOQsBlYbzhwc3GM2CqIw16qxks90EFgOstuXxE76iIFk/R7i
         EXxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6srdUGDMIVnDtA/ksB62yI5BOyICDwDPaYi+LrFPkoM=;
        b=SfwFfnoD3uQnAwW2s3nEZtyGYdFMyFrJmucAVC28jQTTIC4uN+bTx1V8zRTeZeBeUP
         oyO01ANnmvIx8mlCu6yN5ZIOHCBGs83uSgHwj0L0WzquHJGygp/F4A2HgK5ewmvRhyB5
         QmqX+mPGACRSQ0CB9zUK4PtsMGER10XZsaqd20Kz9fZuVWyquI/26WlbkWOJR91AQi9e
         v+pNVfh+QgL9c1t6raMCku+7IvzI1sFWrT9FWXLndZKF90VXqBJQ7GDjPlDKhGOSG9lI
         /tbA6kq5aFddKS83z8TNPnQr2li8gYFFl2qApCpcFet+WyK0vuW86aklWwaXdDkum3pP
         onTg==
X-Gm-Message-State: APt69E3lxImvShJvc4yg4P8ecO6rHvi4pXOxUQWYKKWC3lSxGfvUmBnj
        WB0Xq99OBSW+Mz/aEVJ3MxqXu8Aobwve5tFq7qlTxg==
X-Google-Smtp-Source: ADUXVKKbKyBl/f2LsO/YQz8tfqcWQ6+DcU3E8A5TzGrycPMZMmeejypIzqIKv9vUte1yrT5YTdJ7unUhp+jUwwMUE5s=
X-Received: by 2002:a6b:82c7:: with SMTP id m68-v6mr1070146ioi.118.1528819173077;
 Tue, 12 Jun 2018 08:59:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ad5:5147:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 08:59:32
 -0700 (PDT)
In-Reply-To: <20180609000819.13883-4-logang@deltatee.com>
References: <20180609000819.13883-1-logang@deltatee.com> <20180609000819.13883-4-logang@deltatee.com>
From:   Jon Mason <jdmason@kudzu.us>
Date:   Tue, 12 Jun 2018 11:59:32 -0400
Message-ID: <CAPoiz9yF1c8ybJzA1ViUkvgxo2=u9ytTn6+kYuKv1HZSsUOuWw@mail.gmail.com>
Subject: Re: [PATCH 3/8] NTB: Fix the default port and peer numbers for legacy drivers
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-ntb <linux-ntb@googlegroups.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 8, 2018 at 8:08 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
> When the commit adding ntb_default_port_number() and
> ntb_default_peer_port_number()  entered the kernel there was no
> users of it so it was impossible to tell what the API needed.
>
> When a user finally landed a year later (ntb_pingpong) there were
> more NTB topologies were created and no consideration was considered
> to how other drivers had changed.
>
> Now that there is a user it can be fixed to provide a sensible default
> for the legacy drivers that do not implement ntb_{peer_}port_number().
> Seeing ntb_pingpong doesn't check error codes returning EINVAL was also
> not sensible.
>
> Patches for ntb_pingpong and ntb_perf follow (which are broken
> otherwise) to support hardware that doesn't have port numbers. This is
> important not only to not break support with existing drivers but for
> the cross link topology which, due to its perfect symmetry, cannot
> assign unique port numbers to each side.

This is a very long way of saying "no clients are checking the error
codes, so removing them". :)
I think the history and references to follow-on patches are not
necessary in the commit message and belong more in a 0/X.

This is more of a feature than a bug fix.  Can you break this (and the
pingpong and perf changes caused by this) off into a separate series,
as I'll want to apply this to the ntb-next and not bugfixes branch?

Thanks,
Jon

> Fixes: 1e5301196a88 ("NTB: Add indexed ports NTB API")
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/ntb/ntb.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/ntb/ntb.c b/drivers/ntb/ntb.c
> index 93f24440d11d..d955a92a095a 100644
> --- a/drivers/ntb/ntb.c
> +++ b/drivers/ntb/ntb.c
> @@ -225,10 +225,8 @@ int ntb_default_port_number(struct ntb_dev *ntb)
>         case NTB_TOPO_B2B_DSD:
>                 return NTB_PORT_SEC_DSD;
>         default:
> -               break;
> +               return 0;
>         }
> -
> -       return -EINVAL;
>  }
>  EXPORT_SYMBOL(ntb_default_port_number);
>
> @@ -251,10 +249,8 @@ int ntb_default_peer_port_number(struct ntb_dev *ntb, int pidx)
>         case NTB_TOPO_B2B_DSD:
>                 return NTB_PORT_PRI_USD;
>         default:
> -               break;
> +               return 0;
>         }
> -
> -       return -EINVAL;
>  }
>  EXPORT_SYMBOL(ntb_default_peer_port_number);
>
> @@ -326,4 +322,3 @@ static void __exit ntb_driver_exit(void)
>         bus_unregister(&ntb_bus);
>  }
>  module_exit(ntb_driver_exit);
> -
> --
> 2.11.0
>
