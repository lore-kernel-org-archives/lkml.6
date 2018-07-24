Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43BF9ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 07:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9CEE205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 07:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OiEK/LVL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9CEE205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388546AbeGXIgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 04:36:14 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:43113 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388385AbeGXIgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 04:36:13 -0400
Received: by mail-yw0-f194.google.com with SMTP id l189-v6so1188343ywb.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 00:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TOuz6DHHJAXa3QUs4hgmNjcOqYDMAYjxpWOCbKgtkmA=;
        b=OiEK/LVLiR8QXMiGXyqvp5MfvplKyupmrpOL4A45I6BzOEUuEO+nE0isogX3J39VPJ
         K6XSEKCsYjqyfcEApgerHSPEwKvlIan1GK1WeFA8EUrh6a1LUvu8VroG4T/PjOf7jkBI
         Fd7OFJhDX2cWUoespZqqGfSYPjR2q5vIwm458=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TOuz6DHHJAXa3QUs4hgmNjcOqYDMAYjxpWOCbKgtkmA=;
        b=Xxot6clvayqknpQ+mbfLGsBPYI3OANj30tJHFD3lSRkvXXVNc1tukdUTsWqITlYK29
         M3lleID2DQ9iHKNvtepOFKrvthOKNkQ2SqhBSJujM918FxsLDB/nOMiLaFkMa2cv2JHD
         wcTTdES3/yQMDjDPt8SyhSzrTFHJecKjPar8/YJHcY5uj2quayJ8Tgmyp7won88EKEnl
         K66pozOeYUVrjAA04WWPXSSMvfwGxuztNj/kg1VH8+nK7uIWjQGAAErTRcGsJmqQHfIa
         Gk0E3Qmvg6RDoiGdu19a8GDJKewEUIfS5c4aVbvEuLBOmCuQZsqz3P44Tame907LTKbQ
         8heg==
X-Gm-Message-State: AOUpUlFWBqH1OcCyGR++kPLcPowg0S9QmrOkh2LS6VQFk1bCqdNz+VSq
        yrU8fzHVqLxnMtMZ8kHxvVNpZlpPuP5bnXWq/dumYQ==
X-Google-Smtp-Source: AAOMgpcgzUyj8zbqaEUtBrPAnYuO5q6m8WMC951N7R4KSVTJ/XflZUDNYAeDsMYsO0MFon1CgXPjW5SI3StBGwHX7W4=
X-Received: by 2002:a0d:f142:: with SMTP id a63-v6mr8591015ywf.204.1532417467731;
 Tue, 24 Jul 2018 00:31:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:e716:0:0:0:0:0 with HTTP; Tue, 24 Jul 2018 00:31:06
 -0700 (PDT)
In-Reply-To: <20180724052454.21524-1-yuehaibing@huawei.com>
References: <20180724052454.21524-1-yuehaibing@huawei.com>
From:   Michael Chan <michael.chan@broadcom.com>
Date:   Tue, 24 Jul 2018 00:31:06 -0700
Message-ID: <CACKFLini64_5N7aVtPAVH3CBYCSsdHAJv35jimR18PJXeV6j5g@mail.gmail.com>
Subject: Re: [PATCH net-next] bnxt_en: Fix logic of forward the VF MAC address
 to PF in bnxt_vf_validate_set_mac
To:     YueHaibing <yuehaibing@huawei.com>,
        Vasundhara Volam <vasundhara-v.volam@broadcom.com>
Cc:     David Miller <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 10:24 PM, YueHaibing <yuehaibing@huawei.com> wrote:
> Based on the comments,req->l2addr must match the VF MAC address
> if firmware spec >= 1.2.2, mac_ok can be true.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
> index a649108..7925964 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
> @@ -954,12 +954,9 @@ static int bnxt_vf_validate_set_mac(struct bnxt *bp, struct bnxt_vf_info *vf)
>                 if (ether_addr_equal((const u8 *)req->l2_addr, vf->mac_addr))
>                         mac_ok = true;
>         } else if (is_valid_ether_addr(vf->vf_mac_addr)) {
> -               if (ether_addr_equal((const u8 *)req->l2_addr, vf->vf_mac_addr))
> +               if (ether_addr_equal((const u8 *)req->l2_addr, vf->vf_mac_addr) &&
> +                   bp->hwrm_spec_code >= 0x10202)
>                         mac_ok = true;

I'm not sure if this is correct.  If firmware spec < 0x10202, the VF
MAC address is not forwarded to the PF and so it doesn't have to match
and mac_ok should still be true.  I think we are missing that
condition with this patch.

I need to let my colleague Vasundhara comment on this.  She is more
familiar with this logic.

> -       } else if (bp->hwrm_spec_code < 0x10202) {
> -               mac_ok = true;
> -       } else {
> -               mac_ok = true;
>         }
>         if (mac_ok)
>                 return bnxt_hwrm_exec_fwd_resp(bp, vf, msg_size);
> --
> 2.7.0
>
>
