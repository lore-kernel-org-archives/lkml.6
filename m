Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4278BC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8AEE23F66
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9CMyt4q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8AEE23F66
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753818AbeGCG7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 02:59:25 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34013 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752636AbeGCG7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 02:59:24 -0400
Received: by mail-wr0-f194.google.com with SMTP id a12-v6so740353wro.1;
        Mon, 02 Jul 2018 23:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Mo7sHAkPXcxDt9nHL2ucu3nQkf6MgzEk5hwKTDDkIPA=;
        b=e9CMyt4qCj9VgOmyLyhif4txDdxM8ydlEZwrl/GBc5SUh/jmlJs8z128Q6OBl2VY+z
         QVjqLbSNt897NDBbSvSGoCxbzt6/iE/0+7p8ruazwpLM0PeRDXhioqOJeIL/5PmCY9rj
         lhIVlQASxtNR6GYOUPP8dsl1qXegLp4v4Rvwn3+onibJIzW+RrBvEvCVHOrRuq09c3q5
         ZCj7JpjdqC7ASWp69JBPwaL0MI+xwdru0SZH0ALkaU4ir/MRKIWlsWMX/pXhNdsSdHz2
         h4ptKdeQaHS1/oCmmqTQUrhpIYgoOHuDCzuU1WGeVPwb+qBvlE5hWKn0OmbLyJ298LIa
         mB6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Mo7sHAkPXcxDt9nHL2ucu3nQkf6MgzEk5hwKTDDkIPA=;
        b=UyehXh1wKAdRK5zvTLRoB+VgkHIwvIa5dgT3mAgXMnHQcIpYhE2OBbAO0vULiznu4Z
         0fUZUvfu9Xy+Qmgo8jG8ehWNrfWv/kct6BcxnkmFU9847e2fNtmjLCoXg58DjWgGFrRv
         ikS5nWCCYP8KAZ7dw+Vg5+Y3tNMm4TQbhFPMglsLMWbIIrNc1zyeSwFmfkLr7O8Dx+nK
         o8qTr6zwSP7KF5XLuvzbN2dBFghgIGq2gG7zzrFwpdiiwJFQjixVX0IbxRWQqWUmAN7B
         vKDD5L+ydg1WfWI2nRfcloJb7NOLcB80Cnw1wwt8gK7PRfYuTa1yQAnSK0ShpfERVhMN
         K7bA==
X-Gm-Message-State: APt69E1QfcTg8sO5//iWxret/3kP0JO5rJF2NCVtHpttUkG1lgL6QJjy
        zgFlRD+PyRI/uSC1dGswfwd9rn/dpma+Bekto/k=
X-Google-Smtp-Source: AAOMgpd6XE8iuI5ZoTdzTDe1wiNZcKmtwgXorF9ZSnRGEa9HD7BfeWeXBTmSBOJgRDXisfkVfiOxzDqlSgt2b4gZ+TA=
X-Received: by 2002:adf:adc9:: with SMTP id w67-v6mr13607392wrc.135.1530601162296;
 Mon, 02 Jul 2018 23:59:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:97c6:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 23:59:21 -0700 (PDT)
In-Reply-To: <20180703065413.6098-1-jthumshirn@suse.de>
References: <20180703065413.6098-1-jthumshirn@suse.de>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Tue, 3 Jul 2018 14:59:21 +0800
Message-ID: <CACVXFVOVxP+o66RG_Dk-yBTcUo54Y9c_52=3TpCQna9Se1NXkw@mail.gmail.com>
Subject: Re: [RFC] scsi: switch to scsi-mq by default
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <Bart.VanAssche@sandisk.com>,
        Hannes Reinecke <hare@suse.de>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 3, 2018 at 2:54 PM, Johannes Thumshirn <jthumshirn@suse.de> wrote:
> It has been more than one year since we tried to change the default
> from legacy to multi queue in SCSI. Back then we had to retract the
> change because of performance issues with rotating disks.
>
> In the meantime there have been a substantial amount of performance
> improvements, thus we can re-enable scsi-mq without a significant
> performance penalty.
>
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  drivers/scsi/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
> index 35c909bbf8ba..bd115bab162e 100644
> --- a/drivers/scsi/Kconfig
> +++ b/drivers/scsi/Kconfig
> @@ -49,6 +49,7 @@ config SCSI_NETLINK
>
>  config SCSI_MQ_DEFAULT
>         bool "SCSI: use blk-mq I/O path by default"
> +       default y
>         depends on SCSI
>         ---help---
>           This option enables the new blk-mq based I/O path for SCSI
> --
> 2.16.4
>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


thanks,
Ming Lei
