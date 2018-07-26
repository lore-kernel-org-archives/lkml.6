Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01EE9C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D36320673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cz/u2jnN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D36320673
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731598AbeGZQLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 12:11:49 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:33631 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730517AbeGZQLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 12:11:49 -0400
Received: by mail-qt0-f195.google.com with SMTP id c15-v6so1828702qtp.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 07:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QGdFZAf+qgfLjp3esZUm5frcqOnzR19zF8vZ1a3gaYM=;
        b=cz/u2jnN3ELHNIvZoFLcMUaJqOmAYz2BWGPq1RI1s5NlHhb3vo1XoHReKitDHZhQGB
         8lS/PDaJH6A9FIdXQQleiZAQLXA5dbODUTqHG8wy5jW0nCkoGDv+psIOVHVXkFDtyLZq
         Xr0X5itKGq8NjQGqh/3/a6Y48M5ESll7U7gGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QGdFZAf+qgfLjp3esZUm5frcqOnzR19zF8vZ1a3gaYM=;
        b=AImnO16h+Y8k6ocSTF64lP9DXjZSNFV670sIF8y6VQPM6qGNYVwulN6jUFBD5pX3M0
         35u0nQZbdtYbdBIIyS+l3iNoMVbDOJJduibE8GZG3Kux5cHV+CZCrexEXOK625bLtECd
         d9DxjnPu5YyPkUvEisgeC4VaonTTEd0c2YljlR8TUwfTG+JAR08+/PdYbCWbYI2av1Xy
         RdTCBqmYa0NqyDoxqs6iSFPw+LPmvLxeTyjNSTE5c5Yzxwd1Uemhl+FxANTeDMZCeZcE
         aU2G/TPjNBmx8SqF+BYb35gP4QWRYDEVDszucceLHAPnpuOGpn33EYpT+3kn0aFQ7XTp
         wNRQ==
X-Gm-Message-State: AOUpUlG9WXx1Wz1REwYcM9L+wKP6TBrIqdXQonhzJZ0mQv1WwNiNKFSx
        MvmBnBOIaH7DDlUgQiFjyxfiCYJo0uZEK6us8A9y9g==
X-Google-Smtp-Source: AAOMgpcYSk4CsoBnBQy7TFsIDOEkAf7Gb6xgEgg8HWjkM88C0pL7ShSipC1SZcno+bxFusvtVc+BTgyNHhyy0BTwV44=
X-Received: by 2002:a0c:9dd0:: with SMTP id p16-v6mr1957816qvf.211.1532616874756;
 Thu, 26 Jul 2018 07:54:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:9206:0:0:0:0:0 with HTTP; Thu, 26 Jul 2018 07:54:34
 -0700 (PDT)
In-Reply-To: <20180725111459.10800-1-yuehaibing@huawei.com>
References: <20180725111459.10800-1-yuehaibing@huawei.com>
From:   Vasundhara Volam <vasundhara-v.volam@broadcom.com>
Date:   Thu, 26 Jul 2018 20:24:34 +0530
Message-ID: <CAACQVJo8zB2H6AtQZEVK-nfg8j0f9oVPrBSMjq+CKoQ+xeVrUA@mail.gmail.com>
Subject: Re: [PATCH net-next] bnxt_en: combine 'else if' and 'else' into
 single branche
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     David Miller <davem@davemloft.net>,
        "michael.chan@broadcom.com" <michael.chan@broadcom.com>,
        open list <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 4:44 PM, YueHaibing <yuehaibing@huawei.com> wrote:
>
> The else-if branch and else branch set mac_ok to true similarly,
> so combine the two into single else branch.
>
> Aslo add comments to explain the two conditions, which
> from Michael Chan and Vasundhara Volam.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
> index a649108..f560845 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
> @@ -956,9 +956,13 @@ static int bnxt_vf_validate_set_mac(struct bnxt *bp, struct bnxt_vf_info *vf)
>         } else if (is_valid_ether_addr(vf->vf_mac_addr)) {
>                 if (ether_addr_equal((const u8 *)req->l2_addr, vf->vf_mac_addr))
>                         mac_ok = true;
> -       } else if (bp->hwrm_spec_code < 0x10202) {
> -               mac_ok = true;
>         } else {
> +               /* There are two cases:
> +                * 1.If firmware spec < 0x10202,VF MAC address is not forwarded
> +                *   to the PF and so it doesn't have to match
> +                * 2.Allow VF to modify it's own MAC when PF has not assigned a
> +                *   valid MAC address and firmware spec >= 0x10202
> +                */
No, this is not correct either. You are not covering both conditions.
else part with cover if (!is_valid_ether_addr(vf->vf_mac_addr))
before.
>                 mac_ok = true;
>         }
>         if (mac_ok)
> --
> 2.7.0
>
>
