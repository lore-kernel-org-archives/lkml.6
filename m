Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C1DC0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 18:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7388F20833
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 18:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Acgn6mO9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7388F20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbeKDDeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 23:34:25 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43836 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727603AbeKDDeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 23:34:24 -0400
Received: by mail-pf1-f194.google.com with SMTP id g7-v6so224708pfo.10;
        Sat, 03 Nov 2018 11:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tfml+S7kfXze+ezdg2wKbpOeDLNIeZbLVHdP6ucnpA8=;
        b=Acgn6mO9ZHs26vktaeTvZGV01wERATEZp/9UaMRia6nFuCDsStz0sTVeivgbz/DhUv
         JXxmar6Yi0aV1f8j4yMn6t4FZE/QdcLo1bSoqMAQis7EpgHLtt2YpuEApN7wMZb4FQMT
         cy4n7/Jq4xv1IunQ1F3hJeOizi0lGVChh+T2m/1ULdegCWKiJAbHair2kh5/A0lhLlVO
         amxvOQoOh0L8lLOVwW5MR8/1AN9y1bKmb7SHhj/Ispqs2dttHcXnWoL5DDDE8lwaPRen
         0+KEunZM7hA9A0MCbz6Gz6m0tOH0fDiPpYCI9WByAV2zhYb8yF2btirzRHlAk8cFpkLb
         LPWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tfml+S7kfXze+ezdg2wKbpOeDLNIeZbLVHdP6ucnpA8=;
        b=NHNFQ6fm+SmoHrDVzsLiLR+JYZ443r0Fh54gAP/CF5/uMADPaDPo4o8DJ33s7O4RC9
         aeJOumfRuZA3kGf5wpFgwecpufs50G45RfdeOqQlN4mrJe04zFJLBRGpF5QuxRqFY3ns
         SJfRbztTogSGymi72pXHGCFazxLuWWO3WrkNy5FtwnM96Wu/SEHE7scWdy6P451cpPDu
         JdJuH3qimEPdqGDw7cE9gxSkKSFDFT9VIiBfSsmO9u3+TCAess1ymhKqLXDmYpFLgd2b
         XbJk+bmG/Psnmh05qprdAJheqtmpcd+DsRjSH7GnHlXmJyf6ILy7p4aTPionawLBC+7c
         /rfw==
X-Gm-Message-State: AGRZ1gLKXo4nft3OzHxHZwree5mQj4uvM+aedg3g5WYfxYn7GmTtnsdi
        CN7DF+xB22Ampt5RuuJHOKrCmtnJL/vQy4w9UXZe4A==
X-Google-Smtp-Source: AJdET5fgGTl0uTXYMpfbOsVd7Ej9KGBepgsO+LFLSEQxpYX1e27hlZW+kfF/J9Ci1iRVpXFD2A6Y8NTnE5t20fwAz4o=
X-Received: by 2002:a62:444f:: with SMTP id r76-v6mr16777951pfa.111.1541269343620;
 Sat, 03 Nov 2018 11:22:23 -0700 (PDT)
MIME-Version: 1.0
References: <20181103155944.3028-1-colin.king@canonical.com>
In-Reply-To: <20181103155944.3028-1-colin.king@canonical.com>
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 3 Nov 2018 13:22:11 -0500
Message-ID: <CAH2r5mtejuFDR=y13U3xiGwMOKoP3eOcHzk9midYLcwWp19Dyg@mail.gmail.com>
Subject: Re: [PATCH] cifs: clean up indentation, replace spaces with tab
To:     Colin King <colin.king@canonical.com>
Cc:     Steve French <sfrench@samba.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

merged into cifs-2.6.git for-next
On Sat, Nov 3, 2018 at 11:00 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> Trivial fix to clean up indentation, replace spaces with tab
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  fs/cifs/cifsencrypt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/cifs/cifsencrypt.c b/fs/cifs/cifsencrypt.c
> index 85b31cfa2f3c..ecdff344e8fe 100644
> --- a/fs/cifs/cifsencrypt.c
> +++ b/fs/cifs/cifsencrypt.c
> @@ -224,7 +224,7 @@ int cifs_verify_signature(struct smb_rqst *rqst,
>         if (cifs_pdu->Command == SMB_COM_LOCKING_ANDX) {
>                 struct smb_com_lock_req *pSMB =
>                         (struct smb_com_lock_req *)cifs_pdu;
> -           if (pSMB->LockType & LOCKING_ANDX_OPLOCK_RELEASE)
> +               if (pSMB->LockType & LOCKING_ANDX_OPLOCK_RELEASE)
>                         return 0;
>         }
>
> --
> 2.19.1
>


-- 
Thanks,

Steve
