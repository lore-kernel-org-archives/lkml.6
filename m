Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D04C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 04:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAA2020866
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 04:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KmzEseNQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730031AbeLTERV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 23:17:21 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35666 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729892AbeLTERU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 23:17:20 -0500
Received: by mail-qt1-f195.google.com with SMTP id v11so439262qtc.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 20:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HRF0UAfjOn85kKu4KTT18GuqaqgVP0PGSxppUuvKtto=;
        b=KmzEseNQ0R9r/LB4FIxwmpEODIU/nMitATIRE+L042KTkN/bAkOww9iU7xLR5GFd7J
         FwUxlgqLH7ngPVuH6g8ZLRRX1vOUm4ImY0hXX46goL/KyGzo8A4SDbDNdAMfuA4b3h7R
         XEgEAS3UbNv213S0yBboZMEL9TbezWY1FkDUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HRF0UAfjOn85kKu4KTT18GuqaqgVP0PGSxppUuvKtto=;
        b=OjDGKKHY0qdP6y5ghtGz+eZHtUpRe0afg15SerdIg2bfyCJqmfPDrwvDCrS0laWFru
         7zTSwOixYFs64IbB87j8r+v9yxLRRAtSFYDGoP0ieq6FpY5+E/mKywYEFkVaSJJvBl+v
         zV68IEzlTn/vwLYb+7ElAhl7V7wmtKZn3pmp8OvVCcwZnZ4EmOV8fI6Kl712Lx0d44JO
         BsdvRqN3aDcZwqvdQDBWGDB9AQXBv40KhEZ9wTV+6os68G6ALUOTnmfLTJcZvznQ0JjH
         SlkB8e9d40qEEL/JLZERlIP9WAOMDlGIblSuYBsikM1zWG7i6XZph6vmjo/gfIxr/21D
         jVxg==
X-Gm-Message-State: AA+aEWbQEgJbatmrrJRQnP8Fp8LEpcMnbSYSCqKvuc0XmALwP61OrFA4
        zsulP3r8JwA1l95VvSmajkwrtV8M0IVUnxlZFGTgiw==
X-Google-Smtp-Source: AFSGD/W3TlEXhdl5Z237Z6ZFN6JSaT1ydSkXN4Axwocufm2hDlsLF7XIynGg7j+nUulfxQX9FI3Ob1u5WocYFourX88=
X-Received: by 2002:ac8:b0e:: with SMTP id e14mr24963871qti.336.1545279439456;
 Wed, 19 Dec 2018 20:17:19 -0800 (PST)
MIME-Version: 1.0
References: <cover.1543374820.git.gustavo@embeddedor.com> <892c3e5e27213c1c2f3da128afe958429bbef672.1543374820.git.gustavo@embeddedor.com>
 <4bce4543-ae65-8dfa-cbe6-405d78003129@embeddedor.com>
In-Reply-To: <4bce4543-ae65-8dfa-cbe6-405d78003129@embeddedor.com>
From:   Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
Date:   Thu, 20 Dec 2018 09:49:04 +0530
Message-ID: <CA+RiK64O=zLKdbF4KRXYGD23qi3Ajv5S2oPoKuSbksbMwOHu_A@mail.gmail.com>
Subject: Re: [PATCH 31/41] scsi: mpt3sas: mpt3sas_scsih: Mark expected switch fall-through
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        PDL-MPT-FUSIONLINUX <MPT-FusionLinux.pdl@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,

This patch may not apply smoothly over 4.21/scsi-queue.
Our previous patch for Aero had some changes in this switch case.
Can you resend this patch with latest code base ?

Thanks,
Suganath prabu


On Thu, Dec 20, 2018 at 5:37 AM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> Hi,
>
> Friendly ping:
>
> Who can ack or review this patch, please?
>
> Thanks
> --
> Gustavo
>
> On 11/27/18 10:32 PM, Gustavo A. R. Silva wrote:
> > In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> > where we are expecting to fall through.
> >
> > Addresses-Coverity-ID: 1475400 ("Missing break in switch")
> > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> > ---
> >   drivers/scsi/mpt3sas/mpt3sas_scsih.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
> > index 5b9806d0719e..920b80ce4748 100644
> > --- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
> > +++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
> > @@ -10370,6 +10370,7 @@ _scsih_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >               case MPI26_MFGPAGE_DEVID_CFG_SEC_3916:
> >                       dev_info(&pdev->dev,
> >                           "HBA is in Configurable Secure mode\n");
> > +                     /* fall through */
> >               case MPI26_MFGPAGE_DEVID_SAS3508:
> >               case MPI26_MFGPAGE_DEVID_SAS3508_1:
> >               case MPI26_MFGPAGE_DEVID_SAS3408:
> >
