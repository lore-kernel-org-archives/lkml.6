Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E482C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0B672077B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hc3dUw7t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbfBURFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 12:05:15 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:46228 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbfBURFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 12:05:15 -0500
Received: by mail-io1-f65.google.com with SMTP id k21so2260750ior.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 09:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z5IOgGek8oXlEIjVvCSX0S5Kml5TVWaQgdYQ3wQFoSU=;
        b=Hc3dUw7t1NtrQZQ1s26LtUyZ0X/rv3H2wAYMddGmvz+p17kFy6jiJiNuUTsEBmTjCe
         s3UDqqOiD5SjIunJ4sjxqpmw5e89Oy8CcD8umoB+Ey2iVkV92ulYF8yUuHwgcZ0Pod47
         ShuNWt04aTua47JHu8h4z1MWkEET/C2vtVlkc8X2/VJ3Eb9T/SRKObhcYIGRk5byShlA
         lPKALDtxodrQV/4RuWk2nIhV/k4ih28AhOWSd7WvfA8ZxJEq92lD+Y138UDz6ZO38ciF
         3FXRY60GA1pBJOv/F1obWMadtQ6UqJSbI1hmKyRQ7wBZx8BYFmgzvTq1oZvjdZay1Ksz
         cUJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z5IOgGek8oXlEIjVvCSX0S5Kml5TVWaQgdYQ3wQFoSU=;
        b=CjxBUfRiuxPeyoj9fX7mj5ptKDD8WyQY6C75majW/GXwYIYUTTZPdkIzrBkHo7uDNW
         be4J7w37u8+GoWgyA3L5f5WrGLu2DkSDRevRn8ggXbRMi+ZsK3DhQ6sA67stl37szEn7
         d8IuRVgCv4XOHj3i59+vV0MNmqj8ZSYVfssaoNNFwWgrWbz47rOi5u6NFm+dCmdSYteO
         kTUhL5YjcHVYimwASFNMXR1U9xvsy3QYVfzwREnaq6xUS/xSsKbncjmpodeELmZzTPBq
         MNA2brx8EiMuLBk7NgBV5NdAk4J3nHVeBuYl/nVCEGVSUWg722oRIjFbYKM5b4P18rXd
         J5MQ==
X-Gm-Message-State: AHQUAuZWgOR+G3SwXtp2EcXtmdUnhd3jHIsKs+cFH1gJQ/t8YRdFZTbu
        AYRPtevEl6e4PO7cAtgZbZAGeb+NDbLou88FJKrx1A==
X-Google-Smtp-Source: AHgI3IZL99NYVVFSZ1l9Vf1OqA4MheNXGJ2SPOFF57Yhc2gXgUk6RZpCZhsg1UFRVH03YwdPzHkZ42v8xItM8rPEXXc=
X-Received: by 2002:a02:10c4:: with SMTP id 187mr22745485jay.22.1550768713824;
 Thu, 21 Feb 2019 09:05:13 -0800 (PST)
MIME-Version: 1.0
References: <20190221162419.32384-1-vaishali.thakkar@linaro.org>
 <20190221162419.32384-6-vaishali.thakkar@linaro.org> <20190221163410.GE8727@kroah.com>
In-Reply-To: <20190221163410.GE8727@kroah.com>
From:   Vaishali Thakkar <vaishali.thakkar@linaro.org>
Date:   Thu, 21 Feb 2019 22:35:02 +0530
Message-ID: <CANNG1HVAROCLbitaY7btbdG0Z2MkneFQghM8=MVbfm0LNhrruQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] soc: qcom: socinfo: Expose image information
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2019 at 22:04, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Feb 21, 2019 at 09:54:19PM +0530, Vaishali Thakkar wrote:
> >  static void socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo)
> >  {
> > +     struct smem_image_version *smem_image_version;
> > +     size_t size;
> > +
> >       qcom_socinfo->dbg_root = debugfs_create_dir("qcom_socinfo", NULL);
> >
> >       DEBUGFS_UINT_ADD(raw_version);
> > @@ -314,6 +432,98 @@ static void socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo)
> >       DEBUGFS_ADD(pmic_model);
> >       DEBUGFS_ADD(platform_subtype);
> >       DEBUGFS_ADD(pmic_die_revision);
> > +
> > +     smem_image_version = qcom_smem_get(QCOM_SMEM_HOST_ANY,
> > +                                        SMEM_IMAGE_VERSION_TABLE,
> > +                                        &size);
> > +
> > +     qcom_socinfo->boot = debugfs_create_dir("boot",
> > +                                             qcom_socinfo->dbg_root);
> > +     if (!qcom_socinfo->boot) {
> > +             pr_err("Cannot create boot image directory\n");
> > +             return;
> > +     }
>
> You do not care, do not check please.  Also, even if you wanted to
> check, your error checking was wrong :)

I missed to remove all those checks in this patch. Will do. :)

> > +     DEBUGFS_IMAGE_NAME(name, boot, SMEM_IMAGE_TABLE_BOOT_INDEX);
> > +     DEBUGFS_IMAGE_VARIANT(variant, boot, SMEM_IMAGE_TABLE_BOOT_INDEX);
> > +     DEBUGFS_IMAGE_OEM(oem, boot, SMEM_IMAGE_TABLE_BOOT_INDEX);
> > +
> > +     qcom_socinfo->tz = debugfs_create_dir("tz",
> > +                                           qcom_socinfo->dbg_root);
> > +     if (!qcom_socinfo->tz) {
> > +             pr_err("Cannot create tz image directory\n");
> > +             return;
> > +     }
>
> Same here, no error checking please.
>
> > +     DEBUGFS_IMAGE_NAME(name, tz, SMEM_IMAGE_TABLE_TZ_INDEX);
> > +     DEBUGFS_IMAGE_VARIANT(variant, tz, SMEM_IMAGE_TABLE_TZ_INDEX);
> > +     DEBUGFS_IMAGE_OEM(oem, tz, SMEM_IMAGE_TABLE_TZ_INDEX);
> > +
> > +     qcom_socinfo->rpm = debugfs_create_dir("rpm",
> > +                                            qcom_socinfo->dbg_root);
> > +     if (!qcom_socinfo->rpm) {
> > +             pr_err("Cannot create rpm image directory\n");
> > +             return;
> > +     }
>
> And here.
>
> > +     DEBUGFS_IMAGE_NAME(name, rpm, SMEM_IMAGE_TABLE_RPM_INDEX);
> > +     DEBUGFS_IMAGE_VARIANT(variant, rpm, SMEM_IMAGE_TABLE_RPM_INDEX);
> > +     DEBUGFS_IMAGE_OEM(oem, rpm, SMEM_IMAGE_TABLE_RPM_INDEX);
> > +
> > +     qcom_socinfo->apps = debugfs_create_dir("apps",
> > +                                             qcom_socinfo->dbg_root);
> > +     if (!qcom_socinfo->apps) {
> > +             pr_err("Cannot create apps image directory\n");
> > +             return;
> > +     }
>
> And here.
>
> > +     DEBUGFS_IMAGE_NAME(name, apps, SMEM_IMAGE_TABLE_APPS_INDEX);
> > +     DEBUGFS_IMAGE_VARIANT(variant, apps, SMEM_IMAGE_TABLE_APPS_INDEX);
> > +     DEBUGFS_IMAGE_OEM(oem, apps, SMEM_IMAGE_TABLE_APPS_INDEX);
> > +
> > +     qcom_socinfo->mpss = debugfs_create_dir("mpss",
> > +                                             qcom_socinfo->dbg_root);
> > +     if (!qcom_socinfo->mpss) {
> > +             pr_err("Cannot create mpss image directory\n");
> > +             return;
> > +     }
>
> Yet again...
>
> > +
> > +     DEBUGFS_IMAGE_NAME(name, mpss, SMEM_IMAGE_TABLE_MPSS_INDEX);
> > +     DEBUGFS_IMAGE_VARIANT(variant, mpss, SMEM_IMAGE_TABLE_MPSS_INDEX);
> > +     DEBUGFS_IMAGE_OEM(oem, mpss, SMEM_IMAGE_TABLE_MPSS_INDEX);
> > +
> > +     qcom_socinfo->adsp = debugfs_create_dir("adsp",
> > +                                             qcom_socinfo->dbg_root);
> > +     if (!qcom_socinfo->adsp) {
> > +             pr_err("Cannot create adsp image directory\n");
> > +             return;
> > +     }
>
> And again...
>
> > +
> > +     DEBUGFS_IMAGE_NAME(name, adsp, SMEM_IMAGE_TABLE_ADSP_INDEX);
> > +     DEBUGFS_IMAGE_VARIANT(variant, adsp, SMEM_IMAGE_TABLE_ADSP_INDEX);
> > +     DEBUGFS_IMAGE_OEM(oem, adsp, SMEM_IMAGE_TABLE_ADSP_INDEX);
> > +
> > +     qcom_socinfo->cnss = debugfs_create_dir("cnss",
> > +                                             qcom_socinfo->dbg_root);
> > +     if (!qcom_socinfo->cnss) {
> > +             pr_err("Cannot create cnss image directory\n");
> > +             return;
> > +     }
>
> And again...
>
> > +
> > +     DEBUGFS_IMAGE_NAME(name, cnss, SMEM_IMAGE_TABLE_CNSS_INDEX);
> > +     DEBUGFS_IMAGE_VARIANT(variant, cnss, SMEM_IMAGE_TABLE_CNSS_INDEX);
> > +     DEBUGFS_IMAGE_OEM(oem, cnss, SMEM_IMAGE_TABLE_CNSS_INDEX);
> > +
> > +     qcom_socinfo->video = debugfs_create_dir("video",
> > +                                              qcom_socinfo->dbg_root);
> > +     if (!qcom_socinfo->video) {
> > +             pr_err("Cannot create video image directory\n");
> > +             return;
> > +     }
>
> And one last time.
>
> There, you get to delete a bunch of code, that's always fun :)
>
> thanks,
>
> greg k-h
