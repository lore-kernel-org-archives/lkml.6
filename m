Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6FFECE567
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A83320858
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MZmmk4bY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A83320858
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbeIRMdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 08:33:21 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:42438 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbeIRMdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 08:33:21 -0400
Received: by mail-yb1-f196.google.com with SMTP id 13-v6so373330ybn.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 00:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4tqST6+QjOt1EVyktNa+b+MxjaW9ENeWvx2NkOS5GTs=;
        b=MZmmk4bYZR8H0INGp+l+1+4WBxmfOT+Ma4SgMG2MLoeyddl11F9s02brwnxBmGmn1h
         gGGJVt1CWuHsNOZwEDnrrvPf38dtVJYXseYW4mXCPFRGb9rJZ3chxdTKOg4C3LmImhyl
         Bi4vy+bGwL3Tt3LUEepKqTsI5eh85ydvV0rwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4tqST6+QjOt1EVyktNa+b+MxjaW9ENeWvx2NkOS5GTs=;
        b=nv8i0BmomfHaz+41cNAP/dSzRC4WpHeJsyRq0Nm07ZOc+aPrEqDnM4Q23d1YobfGyq
         JTQz48mw3wNxDkB7Htn8MNOQWVyJW+G3aluETPvx5ELaY34wADMHPb+Qn9C9797Pi62j
         YhX1Jw/ZijFhMF77cFC8x3ghky7x8qn9NnHLltU/+ddMXRVlozLHvsD+hRC68Aazowfx
         dgS9/Vvprs8MKG6VdY8P0eF5mMjIOHvzmM/NPtdqFrwqH3Gxt5hEuEsiByFE7PBuJafv
         i6a+OTBnSf7wcVrU162LXUnVRdDfwb4bwpzGWPkyce9dMMOwXZJZ0i0opnfmzsUd5F2f
         opUA==
X-Gm-Message-State: APzg51DJcL9E9LSGhfuLhDV7DJ4AdeoUZcpy2TNOpLfBxbXkyDgoU0jF
        CctJuKHXk04vVWFqaNLLr+InW+jrT0xLFnB8fvFumQ==
X-Google-Smtp-Source: ANB0VdZtjt/y9rZScGMlLTLvP5Uolb+cGZmQYXPoUQsaodKFoZKrRUryeu9z5xd1pt7cBm2GAPInbgu5Uw85P8rMRhE=
X-Received: by 2002:a25:d490:: with SMTP id m138-v6mr12464830ybf.487.1537254127495;
 Tue, 18 Sep 2018 00:02:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:7d84:0:0:0:0:0 with HTTP; Tue, 18 Sep 2018 00:02:06
 -0700 (PDT)
In-Reply-To: <1537246516-33100-1-git-send-email-zhongjiang@huawei.com>
References: <1537246516-33100-1-git-send-email-zhongjiang@huawei.com>
From:   Michael Chan <michael.chan@broadcom.com>
Date:   Tue, 18 Sep 2018 00:02:06 -0700
Message-ID: <CACKFLin=rgt7EyWJ-P5jhkAQR5NweCWp-5AZN=FoH+AGpVNZWw@mail.gmail.com>
Subject: Re: [PATCH v2] net: bnxt: Fix a uninitialized variable warning.
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     David Miller <davem@davemloft.net>,
        Vasundhara Volam <vasundhara-v.volam@broadcom.com>,
        Netdev <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 9:55 PM, zhong jiang <zhongjiang@huawei.com> wrote:
> Fix the following compile warning:
>
> drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c:49:5: warning: =E2=80=
=98nvm_param.dir_type=E2=80=99 may be used uninitialized in this function [=
-Wmaybe-uninitialized]
>   if (nvm_param.dir_type =3D=3D BNXT_NVM_PORT_CFG)
>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c b/drivers/=
net/ethernet/broadcom/bnxt/bnxt_devlink.c
> index f3b9fbc..1ae56fc 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
> @@ -46,6 +46,9 @@ static int bnxt_hwrm_nvm_req(struct bnxt *bp, u32 param=
_id, void *msg,
>                 }
>         }
>
> +       if (i =3D=3D ARRAY_SIZE(nvm_params))
> +               return -EINVAL;
> +

-EOPNOTSUPP might be a better return code.  Other than that, it looks
good to me.  Thanks.

>         if (nvm_param.dir_type =3D=3D BNXT_NVM_PORT_CFG)
>                 idx =3D bp->pf.port_id;
>         else if (nvm_param.dir_type =3D=3D BNXT_NVM_FUNC_CFG)
> --
> 1.7.12.4
>
