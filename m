Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9C0C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E46B20872
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="IKbo12OE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E46B20872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753970AbeFTONr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 10:13:47 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:42193 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752891AbeFTONp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 10:13:45 -0400
Received: by mail-ot0-f193.google.com with SMTP id 92-v6so3853008otw.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 07:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8Z8VVmfitXpmsfo6jaLFltuSOq8qeLqoV8fwPstPQ/Y=;
        b=IKbo12OEtqW9rRgEnPxHvnoGN6LsqusgfdDNkEJFp4jSIvcmupAX1A7vvIERgVqWz6
         2J6NdBouu/7IDCWE9q08++k+kM8hdbXqMWWq2yYbCLr/WPqXJN+IdUy8exBeWPFYWsoA
         qThqRu+DmPp2HIdwdda026f+AM+m5OgZ5GjNdYtzB5GnGMu6cMamsjoTwE80GkPDlxFS
         x6QjNtcYRtvkKVw7OBahaIQERbKkMPHVgTEeCEU+XDYzyWH+f4Pu6obeF78Ns6xskGcK
         T1YpiS5tAFufTbeScC92oIlMe0CyL5l7cDttYPjFXXeVIIgRBiX1mM6HZQ8/sYP4AV2v
         0C/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8Z8VVmfitXpmsfo6jaLFltuSOq8qeLqoV8fwPstPQ/Y=;
        b=Sd2+kErScrdxz8ld4079sA57rjEVY/lCOcze7B4Ave6a/RjlKIW9tJTGjNB2JR5iFw
         MWqWO03MfL9HysfnBJ78q/CDX2Zb53yTycNNj7izfv54nTK/NiNxmtk+WD9Bt+oLiBpx
         zwWEXsQNmsGAF+Gul7mfqgqdW1qn69zAiKbPJ1Rbz4xa3+7gboGyUau5o5qh8jQyyQX5
         MEEyqwkvCoBQRDDXqw6duFOR96EFTlZ31+rSgpdPSbEv1z3BDoxPzd/Kyk2dZBHrebT0
         9FS+T0yNSMvArQBKidvCTaAOBywkXGvT+zX0aimFYU5ijY3Pync5N0lhkkFnBHMmxGQu
         /p1w==
X-Gm-Message-State: APt69E2qtl7l0XYZGk4NsiVpjySi1I7222uaWCDQCYaHpOybCN6zPq4t
        pquHlvVbh4pQUCTRdXeqzKGX7/dJpoCyUvvzlipVrA==
X-Google-Smtp-Source: ADUXVKId5ry0NSd/V2BMEeaoez8AIbRrx/iPNje4XXmQ47oJ2CZw8EH5y0PNehMMnC2UWXX9x9eB8vagLTxVLbmI1WE=
X-Received: by 2002:a9d:b52:: with SMTP id p18-v6mr5116741otd.64.1529504024530;
 Wed, 20 Jun 2018 07:13:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:c584:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 07:13:44
 -0700 (PDT)
In-Reply-To: <1529500964-28429-3-git-send-email-jianchao.w.wang@oracle.com>
References: <1529500964-28429-1-git-send-email-jianchao.w.wang@oracle.com> <1529500964-28429-3-git-send-email-jianchao.w.wang@oracle.com>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Wed, 20 Jun 2018 10:13:44 -0400
Message-ID: <CAEzrpqdFZ+HkBx6YG9Y+406dBssUsikbR7yaj9BAEJsWLFL48g@mail.gmail.com>
Subject: Re: [PATCH 2/5] nbd: use __blk_mq_complete_request in timeout path
To:     Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Keith Busch <keith.busch@intel.com>, ulf.hansson@linaro.org,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You can add

Acked-by: Josef Bacik <josef@toxicpanda.com>

for the NBD patch.  Thanks,

Josef

On Wed, Jun 20, 2018 at 9:22 AM, Jianchao Wang
<jianchao.w.wang@oracle.com> wrote:
> To regain the capability to prevent normal completion path from
> entering a timeout request, blk_mq_mark_rq_complete is introduced
> in blk_mq_complete_request. Have to use __blk_mq_complete_request
> in timeout path to complete a timeout request.
>
> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
> ---
>  drivers/block/nbd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 3b7083b..d7e533a 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -354,7 +354,7 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
>         sock_shutdown(nbd);
>         nbd_config_put(nbd);
>  done:
> -       blk_mq_complete_request(req);
> +       __blk_mq_complete_request(req);
>         return BLK_EH_DONE;
>  }
>
> --
> 2.7.4
>
