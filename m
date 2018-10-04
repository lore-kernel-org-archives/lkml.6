Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27466C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8AD22064E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XCJ7iRb8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8AD22064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbeJDRRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 13:17:55 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35882 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbeJDRRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 13:17:55 -0400
Received: by mail-qt1-f194.google.com with SMTP id u34-v6so9228233qth.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 03:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VPdp1v0/7eriOt3eTpR043dZ3Q80G7wLnVZa6LvP/+k=;
        b=XCJ7iRb8JAbK8XHJ++sUzUajH+yOXJ4TjjhkKf3KeaawuA1smtv5OyMqbjUj/a8Gxl
         8h1KgU+6ALPviBzWq1IT5ixxEdaaJqQqs/T6NjFYoK8veSbG0zDrJJW7rOE1+iQ3pnrL
         S96fueN/geg5gMwcYOL+/cRcHFx8zLAacFSIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VPdp1v0/7eriOt3eTpR043dZ3Q80G7wLnVZa6LvP/+k=;
        b=R+11JgbdAVK++Q5P2pgVxkF6qyvEsJB5jiS7DDxNv4YfB+4g3PdVsglcYvXDJwej0/
         QgLk+DkVnX0NAihTQ5hTbp1O2/JtfvMAE8U62Mk7w7uIuCsSS+KCFPy8mGnIZCsWF7rK
         aQrD+m38VgHjB7EqJYOunrIHnMRzh21TmdUWSAPnYgq+nMLW0MWewZnrCX98kPEfgO65
         dWJX1FKetK1fJCnxNDMtxX5ef8XFY0amw9q+fWqMhwMbmCvAMZPOFRbkAHT+ECg3lnwp
         H7wvoGkl3rVIeERWvgWDTmr72N33a//8hxI3jWuyBjU2oA1haYFg/6e+8I1dtHtCDL7e
         kFfQ==
X-Gm-Message-State: ABuFfogWxpoSf+XeTidICzq0V5PbaVvkkGWSC0sA/6Ktfiga7f8MMEO3
        kkm4eXJ8kHY5B2G40DbQ9DccBnmUpy+kwCPGBvx6fQ==
X-Google-Smtp-Source: ACcGV6241ysx7htlVn8FO9V5MLCrPF50grTY6W/YjXG4wU44Y2rlk//BmfbHexnc7+KKr6A3FBhVjuE16Q5DLHsq394=
X-Received: by 2002:a0c:8722:: with SMTP id 31-v6mr4772569qvh.47.1538648718276;
 Thu, 04 Oct 2018 03:25:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1537183087.git.joe@perches.com> <850f37801648df45486d13ff9c11574701f01471.1537183087.git.joe@perches.com>
In-Reply-To: <850f37801648df45486d13ff9c11574701f01471.1537183087.git.joe@perches.com>
From:   Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
Date:   Thu, 4 Oct 2018 15:55:46 +0530
Message-ID: <CA+RiK66XNWSXWFGQ7iq4efZVMyPg_uD7ovEgqagXR+abv4=+0w@mail.gmail.com>
Subject: Re: [PATCH 1/7] mpt3sas: Add ioc_<level> logging macros
To:     joe@perches.com
Cc:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra Basappa <chaitra.basappa@broadcom.com>,
        jejb@linux.vnet.ibm.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        PDL-MPT-FUSIONLINUX <MPT-FusionLinux.pdl@broadcom.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Please consider this patch as Acked-by: Suganath Prabu
<suganath-prabu.subramani@broadcom.com>

Thanks.
On Mon, Sep 17, 2018 at 8:31 PM Joe Perches <joe@perches.com> wrote:
>
> These macros can help identify specific logging uses and eventually
> perhaps reduce object sizes.
>
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/scsi/mpt3sas/mpt3sas_base.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.h b/drivers/scsi/mpt3sas/mpt3sas_base.h
> index 96dc15e90bd8..941a4faf20be 100644
> --- a/drivers/scsi/mpt3sas/mpt3sas_base.h
> +++ b/drivers/scsi/mpt3sas/mpt3sas_base.h
> @@ -160,6 +160,15 @@ struct mpt3sas_nvme_cmd {
>   */
>  #define MPT3SAS_FMT                    "%s: "
>
> +#define ioc_err(ioc, fmt, ...)                                         \
> +       pr_err("%s: " fmt, (ioc)->name, ##__VA_ARGS__)
> +#define ioc_notice(ioc, fmt, ...)                                      \
> +       pr_notice("%s: " fmt, (ioc)->name, ##__VA_ARGS__)
> +#define ioc_warn(ioc, fmt, ...)                                                \
> +       pr_warn("%s: " fmt, (ioc)->name, ##__VA_ARGS__)
> +#define ioc_info(ioc, fmt, ...)                                                \
> +       pr_info("%s: " fmt, (ioc)->name, ##__VA_ARGS__)
> +
>  /*
>   *  WarpDrive Specific Log codes
>   */
> --
> 2.15.0
>
