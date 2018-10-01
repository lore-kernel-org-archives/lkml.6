Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DEBC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 21:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C4122146D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 21:50:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C4122146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbeJBEab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 00:30:31 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34156 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbeJBEaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 00:30:30 -0400
Received: by mail-ot1-f65.google.com with SMTP id i12-v6so14784203otl.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 14:50:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/O6QRlDqLd5gAz8+kYofksX8uV70Hv28i08lFxCk0tU=;
        b=d2OqIGTVxKwDQB8VNuY/+ZXOp5d++cswCo5VJYQRqPsMPibRVxOsYteAXlqlG7LUOR
         oBfUpMjvvnLVyp/wc7gmoycQc7wJgvdjN7fMddvcN6osj389J9WmgX7XRCYVLqc4CSL2
         +QeUmMNb06pwN/0lXPck2n00ADOgzYVt4UU/rDtyVrinvG1DpfUiyHqCsY4Ncsdx+t6c
         XRKUCERkJFKjMOpZVDEftdmFTVTgL4l4oA165RSWogh9FKwmPmgl92fm7hdUhehe73dP
         Fn511nhuRIxq+vsRFptN7FDGZ9OltDgBifTRZ/Pg3YwgPJU/xg6pokKLUWuIERjHb/OV
         DZ3w==
X-Gm-Message-State: ABuFfog64IA1PDdzf55yjfFJMqMhrrcvBb7j6j0jV4XNlIiYYrUOWHde
        TvQ6bnlSrFr/x37irJ/MHPih1H3+YeI=
X-Google-Smtp-Source: ACcGV62KQjfWio6rS1WWiqr+fPU+Xip4WjcGrnUhWfPWuDaF4OPj0mutSle3ypCoTFxIc5m8hWk9Qw==
X-Received: by 2002:a9d:4008:: with SMTP id m8-v6mr7976533ote.283.1538430635373;
        Mon, 01 Oct 2018 14:50:35 -0700 (PDT)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com. [209.85.167.180])
        by smtp.gmail.com with ESMTPSA id e7-v6sm4248724oii.26.2018.10.01.14.50.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 14:50:34 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id v69-v6so5218854oif.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 14:50:34 -0700 (PDT)
X-Received: by 2002:aca:2cc6:: with SMTP id s189-v6mr6444310ois.72.1538430634410;
 Mon, 01 Oct 2018 14:50:34 -0700 (PDT)
MIME-Version: 1.0
References: <1538124204-31406-1-git-send-email-madalin.bucur@nxp.com> <1538124204-31406-6-git-send-email-madalin.bucur@nxp.com>
In-Reply-To: <1538124204-31406-6-git-send-email-madalin.bucur@nxp.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Mon, 1 Oct 2018 16:50:22 -0500
X-Gmail-Original-Message-ID: <CADRPPNQgGAYTCmppyxPwQnnC433QLm21D5iq_4EvSj0LrsAxGQ@mail.gmail.com>
Message-ID: <CADRPPNQgGAYTCmppyxPwQnnC433QLm21D5iq_4EvSj0LrsAxGQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] soc/fsl_qbman: export coalesce change API
To:     madalin.bucur@nxp.com
Cc:     Roy Pledge <roy.pledge@nxp.com>, claudiu.manoil@nxp.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Scott Wood <oss@buserror.net>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 3:45 AM Madalin Bucur <madalin.bucur@nxp.com> wrote:
>
> Export the API required to control the QMan portal interrupt coalescing
> settings.

These are new APIs not just old APIs being exported.  What is the user
of these APIs?  Is the user being submitted?  We cannot have APIs in
kernel that has no users.

>
> Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
> ---
>  drivers/soc/fsl/qbman/qman.c | 31 +++++++++++++++++++++++++++++++
>  include/soc/fsl/qman.h       | 27 +++++++++++++++++++++++++++
>  2 files changed, 58 insertions(+)
>
> diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
> index 99d0f87889b8..8ab75bb44c4d 100644
> --- a/drivers/soc/fsl/qbman/qman.c
> +++ b/drivers/soc/fsl/qbman/qman.c
> @@ -1012,6 +1012,37 @@ static inline void put_affine_portal(void)
>
>  static struct workqueue_struct *qm_portal_wq;
>
> +void qman_dqrr_set_ithresh(struct qman_portal *portal, u8 ithresh)
> +{
> +       if (!portal)
> +               return;
> +
> +       qm_dqrr_set_ithresh(&portal->p, ithresh);
> +       portal->p.dqrr.ithresh = ithresh;
> +}
> +EXPORT_SYMBOL(qman_dqrr_set_ithresh);
> +
> +void qman_dqrr_get_ithresh(struct qman_portal *portal, u8 *ithresh)
> +{
> +       if (portal && ithresh)
> +               *ithresh = portal->p.dqrr.ithresh;
> +}
> +EXPORT_SYMBOL(qman_dqrr_get_ithresh);
> +
> +void qman_portal_get_iperiod(struct qman_portal *portal, u32 *iperiod)
> +{
> +       if (portal && iperiod)
> +               *iperiod = qm_in(&portal->p, QM_REG_ITPR);
> +}
> +EXPORT_SYMBOL(qman_portal_get_iperiod);
> +
> +void qman_portal_set_iperiod(struct qman_portal *portal, u32 iperiod)
> +{
> +       if (portal)
> +               qm_out(&portal->p, QM_REG_ITPR, iperiod);
> +}
> +EXPORT_SYMBOL(qman_portal_set_iperiod);
> +
>  int qman_wq_alloc(void)
>  {
>         qm_portal_wq = alloc_workqueue("qman_portal_wq", 0, 1);
> diff --git a/include/soc/fsl/qman.h b/include/soc/fsl/qman.h
> index d4dfefdee6c1..42f50eb51529 100644
> --- a/include/soc/fsl/qman.h
> +++ b/include/soc/fsl/qman.h
> @@ -1186,4 +1186,31 @@ int qman_alloc_cgrid_range(u32 *result, u32 count);
>   */
>  int qman_release_cgrid(u32 id);
>
> +/**
> + * qman_dqrr_get_ithresh - Get coalesce interrupt threshold
> + * @portal: portal to get the value for
> + * @ithresh: threshold pointer
> + */
> +void qman_dqrr_get_ithresh(struct qman_portal *portal, u8 *ithresh);
> +
> +/**
> + * qman_dqrr_set_ithresh - Set coalesce interrupt threshold
> + * @portal: portal to set the new value on
> + * @ithresh: new threshold value
> + */
> +void qman_dqrr_set_ithresh(struct qman_portal *portal, u8 ithresh);
> +
> +/**
> + * qman_dqrr_get_iperiod - Get coalesce interrupt period
> + * @portal: portal to get the value for
> + * @iperiod: period pointer
> + */
> +void qman_portal_get_iperiod(struct qman_portal *portal, u32 *iperiod);
> +/*
> + * qman_dqrr_set_iperiod - Set coalesce interrupt period
> + * @portal: portal to set the new value on
> + * @ithresh: new period value
> + */
> +void qman_portal_set_iperiod(struct qman_portal *portal, u32 iperiod);
> +
>  #endif /* __FSL_QMAN_H */
> --
> 2.1.0
>
