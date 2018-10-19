Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567B2ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A69F2145D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NF5sb/Tx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A69F2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbeJSQHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 12:07:33 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35044 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbeJSQHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 12:07:32 -0400
Received: by mail-pl1-f193.google.com with SMTP id f8-v6so15545737plb.2;
        Fri, 19 Oct 2018 01:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=X5NyWNcg8O0ywhKZAJ/dR5+la6AkOxsY6ZyLPqIWpXs=;
        b=NF5sb/TxavO2j8uhWLVhItSQL41QE7IzupiNAjwAVvdZ6HU7iZtWujgwLEkQxLNR1J
         CvZJxPWZMyEdfV/Gz0SBW9VzKEz575A2g6ZKZpBvAp0S0OCZ4JDsIPdM02LnKtz5MYGw
         QoClN4XuTilaq79Ldnw8+hmrd5fR+8BYLHjCZV2pldaIayOx/Ecbp/rYP46vd3hJwiGM
         VTiFbzk4zRVzvVofAjkC7zGA6GCV6BWZWUaP/CCbQlOM9bDUw/Y3K1VtxJ402dmMc/O9
         /kqvCzwFaT5vqbIIXTky4yCoyurSQxCULapwmzfT4qec99dHiGt00ZIoIF7Oo9w9iFRq
         SwUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=X5NyWNcg8O0ywhKZAJ/dR5+la6AkOxsY6ZyLPqIWpXs=;
        b=LoUuiuOQD5eBPLWJ5dgF67hbcBwJEUZ8mfWUQuHWtrW7JC19JwNvvQTQSrTcq82htZ
         6xcHIpz8lnpB8S7jcIM7bShoWRUpwSR/ft+sIbl1UongvuIB/yczmA9abZEiZsKdjs5Q
         H45bKzHWw6Sz4Z0SrkB3R+GOfdAUaH9s6bpntOatri9FNmTpbn0tiHdZfbzsTr6D1HYi
         TL0VOsViC3BFw2+cM+Mj30ICCPncFyPFiiNl8Mm/MUqaLDQ+YQvARSxH6niABOJX8t7x
         UrITwIIyUHzVBufZDOvUVuZ5u0ye+fOHciTeE8pNwIIYLSt22AXmef6CzdP9ItY62woC
         nFxA==
X-Gm-Message-State: ABuFfoisY4Bq4uX4OTEB+Ld65nDeUkuUpBGRUzvO3bk9J2S2YOEOibQT
        1BcSJlwhPo8FYVFWKtKg3QoMqzeeifVR1H9kz5g=
X-Google-Smtp-Source: ACcGV62hAFsNEMtYmqZiBO6Mrvhm9ISRTirwIe6fj4sHctmu4h+XUpptGmuyRCuw7c0OT8VwBTwARpPFy+KEjCvhh0I=
X-Received: by 2002:a17:902:5a89:: with SMTP id r9-v6mr32606398pli.95.1539936155442;
 Fri, 19 Oct 2018 01:02:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAEK8JBAgRwHZDBrNDNmmRXC3WgX9tVqeoFk5edLHfJL9OWQ-zg@mail.gmail.com>
In-Reply-To: <CAEK8JBAgRwHZDBrNDNmmRXC3WgX9tVqeoFk5edLHfJL9OWQ-zg@mail.gmail.com>
From:   Feng Li <lifeng1519@gmail.com>
Date:   Fri, 19 Oct 2018 16:02:08 +0800
Message-ID: <CAEK8JBDHAaAcjZ0GhQLY_q7Q5=hPPXzJsPkC3ziTZKHQoOJ0YA@mail.gmail.com>
Subject: Re: [PATCH] smartpqi: Fix timeout of smartpqi probe stage
To:     Don Brace <don.brace@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        esc.storagedev@microsemi.com,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     fengli@smartx.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just Ping.
This is a very serious issue. The OS boot from this raid controller
couldn't find bock devices after installing OS.

I think this patch should be merged asap.

Feng Li <lifeng1519@gmail.com> =E4=BA=8E2018=E5=B9=B410=E6=9C=8812=E6=97=A5=
=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=8811:13=E5=86=99=E9=81=93=EF=BC=9A
>
> I use 'HPE Smart Array E208i-a SR Gen10 Controller', and pass through
> the SAS controller from ESXi 6.0U1 to VM, which is installed CentOS 7.4/7=
.5.
> The disk is not found.
>
> The error log is "controller not ready after 30 seconds."
>
> Add some logs, and could check the probe stage needs nearly 36s to match =
the
> status.
>
> Signed-off-by: Li Feng <fengli@smartx.com>
> ---
>  drivers/scsi/smartpqi/smartpqi_sis.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/smartpqi/smartpqi_sis.c
> b/drivers/scsi/smartpqi/smartpqi_sis.c
> index 5141bd4c9..bc7efdacb 100644
> --- a/drivers/scsi/smartpqi/smartpqi_sis.c
> +++ b/drivers/scsi/smartpqi/smartpqi_sis.c
> @@ -59,7 +59,7 @@
>
>  #define SIS_CTRL_KERNEL_UP 0x80
>  #define SIS_CTRL_KERNEL_PANIC 0x100
> -#define SIS_CTRL_READY_TIMEOUT_SECS 30
> +#define SIS_CTRL_READY_TIMEOUT_SECS 90
>  #define SIS_CTRL_READY_RESUME_TIMEOUT_SECS 90
>  #define SIS_CTRL_READY_POLL_INTERVAL_MSECS 10
>
> --
> 2.11.0



--=20
Thanks and Best Regards,
Feng Li(Alex)
