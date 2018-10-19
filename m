Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96561ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 20:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 365EF21486
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 20:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBzOiixm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 365EF21486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbeJTFHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 01:07:42 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34361 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbeJTFHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 01:07:42 -0400
Received: by mail-oi1-f195.google.com with SMTP id v69-v6so27897646oif.1;
        Fri, 19 Oct 2018 13:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+q89g1JP+/BTT9VWEclDbxxqLPPAV6In3M7Y30v4eEs=;
        b=YBzOiixmbroxcq5Rtyc7QRmHyLFv43UBiLlwFjas/sDsTNJ3lVXmkfZwGYOhZrA0ac
         BOSmTArmdvHbvMNqiE8xJnEeAwA71yge02CwcQ2aepXIhO/UoGC+1iEGjKygwqpUhoLo
         SS7U4XeYQRexn3Sn9k7EVmQituogaE9hs32cUgnW9QcMCmutN+WMLQ4zZZAMqCoA1/Mw
         hoXr330Kgp6myc7yftdwoCt7gypDywbgm6JHRlCJbBTepZllafRpz8OwF5lSkMe8lnhG
         7/f2Tm7Jtfp10/6TMpwWP9JGwujAZ0l/6ndHKd3hV9fAUO0/h5B+sY2xmgOwbc5p8E7J
         QB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+q89g1JP+/BTT9VWEclDbxxqLPPAV6In3M7Y30v4eEs=;
        b=C0+aEAhV0F1bV1hkGH7aGYGDki6NfSz6zYRKRJQVsc4/rQ1vIpeF4Q2ruj5YXAJm7V
         jD03FbK9WeYjGXztytAHoUcHFWYEzYHNHtUAxSFEQOHKQ0lu27wOCc4tIbo0EK2Jwq1x
         XTMLP1Mxmi15g/MoaKzaLlBCA2IuiZg3hUeY/fTmzPNimRQ1+ijCBtU1t3yqVf4z02jS
         zvRwYy8kW2CXnULNqgF5jFMZBTAg/VXhJwGMJpNmCxPA9G5dDbfGmpHvUGLdGUZp2R1Z
         jLmkx/cN2tU7r2xly4CrpHfdabO3sxE9JqSo3zY7KrS4u0+/eElclWAyM2uZgg68el+7
         V0ew==
X-Gm-Message-State: ABuFfogjP+vckz4Mnr35TM+/CyCwZCK1NgYNakgP0AzDXPn/G7V0hiHV
        unuyNJ/CXLFrqm5PGN13tFS9/pLMP82yG+du71M=
X-Google-Smtp-Source: ACcGV62j1xd7IofCbBSw2SlbET0hdTZZDQdSfZvR11cLOxHTj40fVatmdsoBNdRYS/tzMQGN/UXgcmOsT+I8QO0g7SY=
X-Received: by 2002:aca:e144:: with SMTP id y65-v6mr18038530oig.90.1539982796364;
 Fri, 19 Oct 2018 13:59:56 -0700 (PDT)
MIME-Version: 1.0
References: <20181018215541.4768-1-natechancellor@gmail.com>
In-Reply-To: <20181018215541.4768-1-natechancellor@gmail.com>
From:   adam radford <aradford@gmail.com>
Date:   Fri, 19 Oct 2018 13:59:45 -0700
Message-ID: <CAHtARFESqN+3S+uy8pV40BFe0PZ96fDHL7WtRW3=cmtg24igzQ@mail.gmail.com>
Subject: Re: [PATCH] scsi: 3w-{sas,9xxx}: Use unsigned char for cdb
To:     natechancellor@gmail.com
Cc:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 2:55 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns a few times:
>
> drivers/scsi/3w-sas.c:386:11: warning: implicit conversion from 'int' to
> 'char' changes value from 128 to -128 [-Wconstant-conversion]
>         cdb[4] = TW_ALLOCATION_LENGTH; /* allocation length */
>                ~ ^~~~~~~~~~~~~~~~~~~~
>
> Update cdb's type to unsigned char, which matches the type of the cdb
> member in struct TW_Command_Apache.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/158
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/scsi/3w-9xxx.c | 12 ++++++++----
>  drivers/scsi/3w-sas.c  |  8 +++++---
>  2 files changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/scsi/3w-9xxx.c b/drivers/scsi/3w-9xxx.c
> index 05293babb031..2d655a97b959 100644
> --- a/drivers/scsi/3w-9xxx.c
> +++ b/drivers/scsi/3w-9xxx.c
> @@ -143,7 +143,9 @@ static int twa_poll_status_gone(TW_Device_Extension *tw_dev, u32 flag, int secon
>  static int twa_post_command_packet(TW_Device_Extension *tw_dev, int request_id, char internal);
>  static int twa_reset_device_extension(TW_Device_Extension *tw_dev);
>  static int twa_reset_sequence(TW_Device_Extension *tw_dev, int soft_reset);
> -static int twa_scsiop_execute_scsi(TW_Device_Extension *tw_dev, int request_id, char *cdb, int use_sg, TW_SG_Entry *sglistarg);
> +static int twa_scsiop_execute_scsi(TW_Device_Extension *tw_dev, int request_id,
> +                                  unsigned char *cdb, int use_sg,
> +                                  TW_SG_Entry *sglistarg);
>  static void twa_scsiop_execute_scsi_complete(TW_Device_Extension *tw_dev, int request_id);
>  static char *twa_string_lookup(twa_message_type *table, unsigned int aen_code);
>
> @@ -278,7 +280,7 @@ static int twa_aen_complete(TW_Device_Extension *tw_dev, int request_id)
>  static int twa_aen_drain_queue(TW_Device_Extension *tw_dev, int no_check_reset)
>  {
>         int request_id = 0;
> -       char cdb[TW_MAX_CDB_LEN];
> +       unsigned char cdb[TW_MAX_CDB_LEN];
>         TW_SG_Entry sglist[1];
>         int finished = 0, count = 0;
>         TW_Command_Full *full_command_packet;
> @@ -423,7 +425,7 @@ static void twa_aen_queue_event(TW_Device_Extension *tw_dev, TW_Command_Apache_H
>  /* This function will read the aen queue from the isr */
>  static int twa_aen_read_queue(TW_Device_Extension *tw_dev, int request_id)
>  {
> -       char cdb[TW_MAX_CDB_LEN];
> +       unsigned char cdb[TW_MAX_CDB_LEN];
>         TW_SG_Entry sglist[1];
>         TW_Command_Full *full_command_packet;
>         int retval = 1;
> @@ -1798,7 +1800,9 @@ static int twa_scsi_queue_lck(struct scsi_cmnd *SCpnt, void (*done)(struct scsi_
>  static DEF_SCSI_QCMD(twa_scsi_queue)
>
>  /* This function hands scsi cdb's to the firmware */
> -static int twa_scsiop_execute_scsi(TW_Device_Extension *tw_dev, int request_id, char *cdb, int use_sg, TW_SG_Entry *sglistarg)
> +static int twa_scsiop_execute_scsi(TW_Device_Extension *tw_dev, int request_id,
> +                                  unsigned char *cdb, int use_sg,
> +                                  TW_SG_Entry *sglistarg)
>  {
>         TW_Command_Full *full_command_packet;
>         TW_Command_Apache *command_packet;
> diff --git a/drivers/scsi/3w-sas.c b/drivers/scsi/3w-sas.c
> index 266bdac75304..480cf82700e9 100644
> --- a/drivers/scsi/3w-sas.c
> +++ b/drivers/scsi/3w-sas.c
> @@ -287,7 +287,9 @@ static int twl_post_command_packet(TW_Device_Extension *tw_dev, int request_id)
>  } /* End twl_post_command_packet() */
>
>  /* This function hands scsi cdb's to the firmware */
> -static int twl_scsiop_execute_scsi(TW_Device_Extension *tw_dev, int request_id, char *cdb, int use_sg, TW_SG_Entry_ISO *sglistarg)
> +static int twl_scsiop_execute_scsi(TW_Device_Extension *tw_dev, int request_id,
> +                                  unsigned char *cdb, int use_sg,
> +                                  TW_SG_Entry_ISO *sglistarg)
>  {
>         TW_Command_Full *full_command_packet;
>         TW_Command_Apache *command_packet;
> @@ -372,7 +374,7 @@ static int twl_scsiop_execute_scsi(TW_Device_Extension *tw_dev, int request_id,
>  /* This function will read the aen queue from the isr */
>  static int twl_aen_read_queue(TW_Device_Extension *tw_dev, int request_id)
>  {
> -       char cdb[TW_MAX_CDB_LEN];
> +       unsigned char cdb[TW_MAX_CDB_LEN];
>         TW_SG_Entry_ISO sglist[1];
>         TW_Command_Full *full_command_packet;
>         int retval = 1;
> @@ -554,7 +556,7 @@ static int twl_poll_response(TW_Device_Extension *tw_dev, int request_id, int se
>  static int twl_aen_drain_queue(TW_Device_Extension *tw_dev, int no_check_reset)
>  {
>         int request_id = 0;
> -       char cdb[TW_MAX_CDB_LEN];
> +       unsigned char cdb[TW_MAX_CDB_LEN];
>         TW_SG_Entry_ISO sglist[1];
>         int finished = 0, count = 0;
>         TW_Command_Full *full_command_packet;
> --
> 2.19.1
>

Looks ok.

Signed-off-by: Adam Radford <aradford@gmail.com>

-Adam
