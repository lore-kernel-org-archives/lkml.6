Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A0BC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D0A82064E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="K3cpbuCZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D0A82064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbeJDRWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 13:22:03 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45131 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbeJDRWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 13:22:03 -0400
Received: by mail-qk1-f194.google.com with SMTP id m8-v6so5349435qka.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 03:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ke5WuS0t5vYZBR1SGk8dIP78ZGDdI1LS+9akXfY7bQg=;
        b=K3cpbuCZQVLWf6wZ8k2oOkvahhinKrAHaqHKhs0fC+s9B0/MsAz8+XsWTrt2Yf5+MN
         CjiDzVz5xoEcltmSUukSFsok1iaUU2fcOyWALN+kzDscfjnUjgddBvbG2A5hNDEBnson
         NF23zDA7sFnP8Idmeq87GTkkKpZ+VrDzLrMb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ke5WuS0t5vYZBR1SGk8dIP78ZGDdI1LS+9akXfY7bQg=;
        b=j12tnhgioxMuzlf9Sl696D1KDWgncHv/S+HUrbn57HQ0SrQziutI7alGG3Yx6Zbu2d
         AF2/d6rJHQZ5WuZuEbBCqbM332QbNGUN2L9OjEJE6iLad/eMLASmz7zIVCA1tkShvwc6
         TRZeOeLuODF2iaMLB7HshfZmgiYGNbwr+By8vY6jb2t36cNK7dcHefrkzFd/XOoURvuy
         uxTn+OCCr63+b5UuV0njl5Q0/TPF6mBed9BgB9m0P/1EP8LDtA9Ny6M1UTOvIhqF2Gmg
         jgM1KapbzEuB6CBwH/slTHnyXdzNpmw7WZ/o9lCjbbEIqajx6IL8TDCHuiHLYqpg1B1M
         a99w==
X-Gm-Message-State: ABuFfoiREQkEngYuiy74vKl6eElTUVKuffKgNP+Eas7JcX9jqwxVyrMJ
        jC81J54zNnpQ82zjOj+EJgj4XlFMSBGGKM9SyaanhQ==
X-Google-Smtp-Source: ACcGV6386eQaPmpOjKg5m55lFC+bQflhWcKiBjvfZqch5MlbXqrrRWMuvVleM7SSkgWULIjI4Fmc2SPCheCMtiAzD9o=
X-Received: by 2002:a37:9385:: with SMTP id v127-v6mr4526534qkd.71.1538648964918;
 Thu, 04 Oct 2018 03:29:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1537183087.git.joe@perches.com> <36d906ff0d22e530024eb487a3a6dbb224f6a1b0.1537183088.git.joe@perches.com>
In-Reply-To: <36d906ff0d22e530024eb487a3a6dbb224f6a1b0.1537183088.git.joe@perches.com>
From:   Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
Date:   Thu, 4 Oct 2018 15:59:54 +0530
Message-ID: <CA+RiK661kgeLsRkj7Mt4_U7dhNh4tOtwHYky1xohBpVENPWw5w@mail.gmail.com>
Subject: Re: [PATCH 5/7] mpt3sas: Remove KERN_WARNING from panic uses
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

Please consider this patch as Acked-by: Suganath Prabu
<suganath-prabu.subramani@broadcom.com>

Thanks.
On Mon, Sep 17, 2018 at 8:31 PM Joe Perches <joe@perches.com> wrote:
>
> Remove the logging level as panic calls stop the machine and should
> always be emitted regardless of requested logging level.
>
> These existing panic uses are perhaps inappropriate.
>
> Miscellanea:
>
> o Coalesce formats and convert MPT3SAS_FMT to "%s: " to improve clarity
>
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/scsi/mpt3sas/mpt3sas_config.c | 41 +++++++++++++----------------------
>  1 file changed, 15 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/scsi/mpt3sas/mpt3sas_config.c b/drivers/scsi/mpt3sas/mpt3sas_config.c
> index 38d3b163b5d1..02209447f4ef 100644
> --- a/drivers/scsi/mpt3sas/mpt3sas_config.c
> +++ b/drivers/scsi/mpt3sas/mpt3sas_config.c
> @@ -421,12 +421,10 @@ _config_request(struct MPT3SAS_ADAPTER *ioc, Mpi2ConfigRequest_t
>                     (mpi_reply->Header.PageType & 0xF)) {
>                         _debug_dump_mf(mpi_request, ioc->request_sz/4);
>                         _debug_dump_reply(mpi_reply, ioc->request_sz/4);
> -                       panic(KERN_WARNING MPT3SAS_FMT "%s: Firmware BUG:" \
> -                           " mpi_reply mismatch: Requested PageType(0x%02x)" \
> -                           " Reply PageType(0x%02x)\n", \
> -                           ioc->name, __func__,
> -                           (mpi_request->Header.PageType & 0xF),
> -                           (mpi_reply->Header.PageType & 0xF));
> +                       panic("%s: %s: Firmware BUG: mpi_reply mismatch: Requested PageType(0x%02x) Reply PageType(0x%02x)\n",
> +                             ioc->name, __func__,
> +                             mpi_request->Header.PageType & 0xF,
> +                             mpi_reply->Header.PageType & 0xF);
>                 }
>
>                 if (((mpi_request->Header.PageType & 0xF) ==
> @@ -434,11 +432,10 @@ _config_request(struct MPT3SAS_ADAPTER *ioc, Mpi2ConfigRequest_t
>                     mpi_request->ExtPageType != mpi_reply->ExtPageType) {
>                         _debug_dump_mf(mpi_request, ioc->request_sz/4);
>                         _debug_dump_reply(mpi_reply, ioc->request_sz/4);
> -                       panic(KERN_WARNING MPT3SAS_FMT "%s: Firmware BUG:" \
> -                           " mpi_reply mismatch: Requested ExtPageType(0x%02x)"
> -                           " Reply ExtPageType(0x%02x)\n",
> -                           ioc->name, __func__, mpi_request->ExtPageType,
> -                           mpi_reply->ExtPageType);
> +                       panic("%s: %s: Firmware BUG: mpi_reply mismatch: Requested ExtPageType(0x%02x) Reply ExtPageType(0x%02x)\n",
> +                             ioc->name, __func__,
> +                             mpi_request->ExtPageType,
> +                             mpi_reply->ExtPageType);
>                 }
>                 ioc_status = le16_to_cpu(mpi_reply->IOCStatus)
>                     & MPI2_IOCSTATUS_MASK;
> @@ -461,14 +458,10 @@ _config_request(struct MPT3SAS_ADAPTER *ioc, Mpi2ConfigRequest_t
>                                 _debug_dump_reply(mpi_reply, ioc->request_sz/4);
>                                 _debug_dump_config(p, min_t(u16, mem.sz,
>                                     config_page_sz)/4);
> -                               panic(KERN_WARNING MPT3SAS_FMT
> -                                       "%s: Firmware BUG:" \
> -                                   " config page mismatch:"
> -                                   " Requested PageType(0x%02x)"
> -                                   " Reply PageType(0x%02x)\n",
> -                                   ioc->name, __func__,
> -                                   (mpi_request->Header.PageType & 0xF),
> -                                   (p[3] & 0xF));
> +                               panic("%s: %s: Firmware BUG: config page mismatch: Requested PageType(0x%02x) Reply PageType(0x%02x)\n",
> +                                     ioc->name, __func__,
> +                                     mpi_request->Header.PageType & 0xF,
> +                                     p[3] & 0xF);
>                         }
>
>                         if (((mpi_request->Header.PageType & 0xF) ==
> @@ -478,13 +471,9 @@ _config_request(struct MPT3SAS_ADAPTER *ioc, Mpi2ConfigRequest_t
>                                 _debug_dump_reply(mpi_reply, ioc->request_sz/4);
>                                 _debug_dump_config(p, min_t(u16, mem.sz,
>                                     config_page_sz)/4);
> -                               panic(KERN_WARNING MPT3SAS_FMT
> -                                       "%s: Firmware BUG:" \
> -                                   " config page mismatch:"
> -                                   " Requested ExtPageType(0x%02x)"
> -                                   " Reply ExtPageType(0x%02x)\n",
> -                                   ioc->name, __func__,
> -                                   mpi_request->ExtPageType, p[6]);
> +                               panic("%s: %s: Firmware BUG: config page mismatch: Requested ExtPageType(0x%02x) Reply ExtPageType(0x%02x)\n",
> +                                     ioc->name, __func__,
> +                                     mpi_request->ExtPageType, p[6]);
>                         }
>                 }
>                 memcpy(config_page, mem.page, min_t(u16, mem.sz,
> --
> 2.15.0
>
