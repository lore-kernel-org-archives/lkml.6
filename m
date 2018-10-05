Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3215C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7907A208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u+jXrjyu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7907A208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbeJFACu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 20:02:50 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43060 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728214AbeJFACt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 20:02:49 -0400
Received: by mail-lj1-f193.google.com with SMTP id r8-v6so12204199ljc.10
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 10:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+6xQNPup1xQjIR0+We24WXHQYKF4tHYaVxahBjByoos=;
        b=u+jXrjyup3yi0DlhNaeT2Ynx0qOGA+dtK6bjYEK6Gl/vL8AwQx1aDJ80KtwkinjlN/
         9yuXKHc9TZbb2YwAiMKgE7VDZuOeu0SRbAyur4iSbq6OvCRAJTThn1gtTr9tePoRyCJz
         pFsB3doCnAjrQsvMSTcBRJ2cdM23NwikCyOJM5ztgWMwcxR4LILTLb+H2mf5HpiLmMQ1
         B2cGZYfmrJhbYfDiHdOP63fU6cYdgTegKjOSrqxgUfS3WN/sYpWRKWyNhgzc7SMeeUGV
         M3JiIbEsXJ0AAztsvdQIMBx9IEWnsXte7kxvkPGS3F6DmZUTNS2l9FM8PAcasjTIfSky
         Djlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+6xQNPup1xQjIR0+We24WXHQYKF4tHYaVxahBjByoos=;
        b=MTNxotS9IsGTS4M4+g6vz0r0RilrbFenqZgsbZ0oYrqJt9IEpO7I9b0VcbIx1X4vXo
         a5Sn1eA30fXpGOBsjHL8JBl/aByo6Ulj1nxLf7T0utUOYKFMXCiOLNvmBhN89cM8Y38s
         zynI9f34euJ5NDpN2wme2+vg/HVzv/iVXIZi2W0XdH7buQUruoaoEE6uQV1oMyhTa/X3
         WNrDpPZEpkOMqIR/AZshqBR0Ne00TY3MJ97bxDgs+XbIxqNyXVE96t94UG3cJw62Ws7P
         0I5uWSOBVpUefMVZC61TVgE481WdoscxX8CMKTocw/jhseyRf0z3WtifVZVndT24fvKg
         knaw==
X-Gm-Message-State: ABuFfogIJ1FM+VCi1oemKZobmF5ehu2X7ZuF4Z1OZSE57Gbfmb7g5BQU
        K1llOHwqnuJcORZ7JtKUGMKW0XD3VOykg4SW1x4=
X-Google-Smtp-Source: ACcGV60fXR3jqycy2m8fGsXooP3RUkDXob7Zqzcapp6bcNH+LZci+cy9EkWn9evht4jZkqAO9wZqfS0rwKoPyZBdHAc=
X-Received: by 2002:a2e:900c:: with SMTP id h12-v6mr8403910ljg.121.1538758992394;
 Fri, 05 Oct 2018 10:03:12 -0700 (PDT)
MIME-Version: 1.0
References: <20181005071234.GA8803@embeddedor.com>
In-Reply-To: <20181005071234.GA8803@embeddedor.com>
From:   Allen Hubbe <allenbh@gmail.com>
Date:   Fri, 5 Oct 2018 13:03:01 -0400
Message-ID: <CAJ80sasrMXyC4jDGG+-wDLLXSApM6-HdgmgGwNMtH7AMwPdCUg@mail.gmail.com>
Subject: Re: [PATCH] ntb: ntb_transport: Mark expected switch fall-throughs
To:     gustavo@embeddedor.com
Cc:     Jon Mason <jdmason@kudzu.us>, dave.jiang@intel.com,
        linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 5, 2018 at 3:12 AM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
>
> Addresses-Coverity-ID: 1373888 ("Missing break in switch")
> Addresses-Coverity-ID: 1373889 ("Missing break in switch")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Acked-by: Allen Hubbe <allenbh@gmail.com>

> ---
>  drivers/ntb/ntb_transport.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 9398959..c643b9c 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -1278,6 +1278,7 @@ static void ntb_rx_copy_callback(void *data,
>                 case DMA_TRANS_READ_FAILED:
>                 case DMA_TRANS_WRITE_FAILED:
>                         entry->errors++;
> +                       /* fall through */
>                 case DMA_TRANS_ABORTED:
>                 {
>                         struct ntb_transport_qp *qp = entry->qp;
> @@ -1533,6 +1534,7 @@ static void ntb_tx_copy_callback(void *data,
>                 case DMA_TRANS_READ_FAILED:
>                 case DMA_TRANS_WRITE_FAILED:
>                         entry->errors++;
> +                       /* fall through */
>                 case DMA_TRANS_ABORTED:
>                 {
>                         void __iomem *offset =
> --
> 2.7.4
