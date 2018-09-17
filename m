Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A35DECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A150B214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fMG7xqKm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A150B214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbeIQXFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 19:05:06 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:42115 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbeIQXFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 19:05:06 -0400
Received: by mail-yw1-f68.google.com with SMTP id n207-v6so5780130ywn.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 10:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jz/n715l7yeDb+a60gPQwWqZ9gZkVJ2S82jYv8jKC2c=;
        b=fMG7xqKmi1v1MxQAt5ce85Vd5RigBwDUkg7uNtrhMsV/vy8Z0mBKAxRApA6xC+Kux+
         /3Znh9Qex567f7Lx1KJbY5TBAAR5sBbwhRfAN4Il14qV/QyeE7wOpMIpIOIOTunRK6j6
         JkyMODMhJKMBxNpl3qWhcAOZMuwrN3wFSh68g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jz/n715l7yeDb+a60gPQwWqZ9gZkVJ2S82jYv8jKC2c=;
        b=BDrsWsSGdgipYvzMkr25F2ICA9/PnowYCmsaoU5UwF+GoaLUxGrqVKjtViY1iKOAwG
         PBa/BOIyPQ8b54rCdfeAKjyEnIrRCFVw0R7q8UxHO5O8gT16Cc+UDEJbt8lvsen9tNiA
         PbK0E/VUW9YFhWXuTPljKH7pcNwLm10ZfpK8bmwt2WoaCwhYcnCbFei+U57pGkng5Jym
         6i8oqARLZSrlwO07sZ18LSkr40OsmS6Eyh6LwS0SSkn7G4ASbIb9AEFKIpPuzSkEcPh5
         xX58OGtPvB5FkEBlL2OGWNaXE5o3IzyVfO3pdDmxooYmBcrVVsPWhxlPpGci25uTPcRB
         VfWQ==
X-Gm-Message-State: APzg51A+iHJSF40lPU2wr3nWhHRiFeBlxrdsyXj8Bgg393vH5ObP61Bu
        3ssIzi1LAuFZDE/ylse7wb6LmvcU861Tu3imiKPROA==
X-Google-Smtp-Source: ANB0VdaqzQrG2G6gVfTrhpLK0mITf6V+u7cEReg/BsAoE2bkNnZWUdOjRzsLg9xuJqKUKPN81H2B5al7L7x7mG84c/Q=
X-Received: by 2002:a0d:e251:: with SMTP id l78-v6mr10973852ywe.218.1537205805015;
 Mon, 17 Sep 2018 10:36:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:7d84:0:0:0:0:0 with HTTP; Mon, 17 Sep 2018 10:36:44
 -0700 (PDT)
In-Reply-To: <1537201883-2518-1-git-send-email-zhongjiang@huawei.com>
References: <1537201883-2518-1-git-send-email-zhongjiang@huawei.com>
From:   Michael Chan <michael.chan@broadcom.com>
Date:   Mon, 17 Sep 2018 10:36:44 -0700
Message-ID: <CACKFLineQuBTUGaBLgRqSTEcVzyZaZAnzy0jOHREKdtCqmy6pQ@mail.gmail.com>
Subject: Re: [PATCH] net: bnxt: Fix a uninitialized variable warning.
To:     zhong jiang <zhongjiang@huawei.com>,
        Vasundhara Volam <vasundhara-v.volam@broadcom.com>
Cc:     David Miller <davem@davemloft.net>,
        Netdev <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 9:31 AM, zhong jiang <zhongjiang@huawei.com> wrote:
>
> Fix the following compile warning:
>
> drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c:49:5: warning: =E2=80=
=98nvm_param.dir_type=E2=80=99 may be used uninitialized in this function [=
-Wmaybe-uninitialized]
>   if (nvm_param.dir_type =3D=3D BNXT_NVM_PORT_CFG)
>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c b/drivers/=
net/ethernet/broadcom/bnxt/bnxt_devlink.c
> index f3b9fbc..ab88217 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
> @@ -31,7 +31,7 @@ static int bnxt_hwrm_nvm_req(struct bnxt *bp, u32 param=
_id, void *msg,
>  {
>         struct hwrm_nvm_get_variable_input *req =3D msg;
>         void *data_addr =3D NULL, *buf =3D NULL;
> -       struct bnxt_dl_nvm_param nvm_param;
> +       struct bnxt_dl_nvm_param nvm_param =3D {0};
>         int bytesize, idx =3D 0, rc, i;
>         dma_addr_t data_dma_addr;
>

I think it is better to return error if there is no param_id match
after the for loop.  The for loop will initialize nvm_param if there
is param_id match.
