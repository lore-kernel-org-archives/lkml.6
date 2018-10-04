Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1631BC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D22FE2098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZBuHQuVi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D22FE2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbeJDRWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 13:22:44 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46859 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727150AbeJDRWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 13:22:44 -0400
Received: by mail-qt1-f196.google.com with SMTP id d8-v6so9201496qtk.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 03:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1zbGcIeqystMMZ/BurEPqxC87kh3n3li3OD+cLA695Q=;
        b=ZBuHQuViKdMXZtjk3yL7NvCY93qfNe8j8kkcjaWtBiUOuWSiGCE/81IoI98TLuVhdO
         7wG7yl1f7m9kntqtXre0TCHLdgZLuYwoSXxj15gt4iWapEQdDs87N+HYnuBLV3v5agHU
         fkwDh79gqOfIQZoIV3LvmqBXjFMV6a/dPfJpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1zbGcIeqystMMZ/BurEPqxC87kh3n3li3OD+cLA695Q=;
        b=Fehjyv1Wzi/cKEtFz9h6Nu6XxLE5q8nocYDc2N/dXSlND92Oumynita41fwFC8mKAH
         K1kOjlnkpz0SV9H1EthrzDyqNrq4yYPJ+uCZLqjAr+mkx4z+GcD1L8rvx2GefIw1tTcz
         BjGUq4SDoFZVMrcjSgRQDsoZDcEADt/R6wSHeDC/mMIhvyLQVVGbM3IqtXfEcFECSRi2
         m+83bjTtWob4SpTlEcqg8f51DxCSSxk00FS+MUgmw6xiZci4KAbwoQB7bLpchCiejyHk
         LTbjkx4tcaRngHul7k/nwKz72XVOWXu3tm1rtJKtz1US0VoD+IEONhM8G9hdzNmSTA5N
         E7lQ==
X-Gm-Message-State: ABuFfojriIMs57F2hvjOMe83i3luqo3hTB37LpL31pkCjxRzNqxSP2Re
        ZkrsYg7iaWFGs7MHukFBQonhFYb6myb9hlVDd9/9lQ==
X-Google-Smtp-Source: ACcGV6228cXj9ACP7jzHs4hFch11siiJ2plmvjphZ2AnxNxpnJFDQ7wZ0Rgcwwau2OYvTASx6WCQnaQxqENhWHYznXA=
X-Received: by 2002:ac8:ec3:: with SMTP id w3-v6mr4565529qti.138.1538649005863;
 Thu, 04 Oct 2018 03:30:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1537183087.git.joe@perches.com> <b2223bcc61daab4132ece3867cb93ee0426707dd.1537183088.git.joe@perches.com>
In-Reply-To: <b2223bcc61daab4132ece3867cb93ee0426707dd.1537183088.git.joe@perches.com>
From:   Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
Date:   Thu, 4 Oct 2018 16:00:34 +0530
Message-ID: <CA+RiK66FZfZ-PXY0MddAr=6oKYfNkXHs-sNZ5BuCkQyxDTRNLQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] mpt3sas: Remove unused macro MPT3SAS_FMT
To:     joe@perches.com
Cc:     Sathya Prakash <sathya.prakash@broadcom.com>,
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
On Mon, Sep 17, 2018 at 8:33 PM Joe Perches <joe@perches.com> wrote:
>
> All the uses have been removed, delete the macro.
>
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/scsi/mpt3sas/mpt3sas_base.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.h b/drivers/scsi/mpt3sas/mpt3sas_base.h
> index 941a4faf20be..8f1d6b071b39 100644
> --- a/drivers/scsi/mpt3sas/mpt3sas_base.h
> +++ b/drivers/scsi/mpt3sas/mpt3sas_base.h
> @@ -158,8 +158,6 @@ struct mpt3sas_nvme_cmd {
>  /*
>   * logging format
>   */
> -#define MPT3SAS_FMT                    "%s: "
> -
>  #define ioc_err(ioc, fmt, ...)                                         \
>         pr_err("%s: " fmt, (ioc)->name, ##__VA_ARGS__)
>  #define ioc_notice(ioc, fmt, ...)                                      \
> --
> 2.15.0
>
