Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0961C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 05:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E42D20862
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 05:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XOKUsqrd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E42D20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbeG0HGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 03:06:12 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:36760 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbeG0HGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 03:06:11 -0400
Received: by mail-qt0-f196.google.com with SMTP id t5-v6so3987296qtn.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 22:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AyOWqV7Wx96+aKn00y1iY+aCN4pwnNfEecIu3hcFAnY=;
        b=XOKUsqrdEzpXI1h3mGOE5wHwHyLLEI8lJPvVMHqsGT/qnHYMAhWUhkqjnB/fqe8sT5
         QsDShu+a3d5/CMW0jnxkBjT1QNEIxVTkHnRKcySDyKIFSZiyEmOZDZDaWp/XVDPJkz3P
         peSJnUzBGTxHRoF27IGwGEBHDzuW0KP8bldig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AyOWqV7Wx96+aKn00y1iY+aCN4pwnNfEecIu3hcFAnY=;
        b=qq3MCU9ZGvffL4ndMujawrB0v7a8qFoOa2IBHsjfdc++8fOV3L2407Ii+Lw4r9+uwd
         BcNlZwJC4ioW2QZKYMSRUbwXE/0PdDAG+wROQIgvCrzQFPcLrGKfkznV+dc1sTuRy2gO
         vKqAYKxO4oxjIcsYGpiRERgq6ytppvkFnrNqbX+NrBnBXSVx02DgTCAwXsrzwnhp1XAu
         de9Nrs0NDRmi4I53cHKDYQntIulZM+c+5/3ONDYEJKiNZCNyLqwG/EFm6GcAVvHPkVoa
         nDRZ1S4CnMUpSxLXzK5IZNLcyUpBeNf476A2ov8pnovKuxdoF5PQGLU/VFT5PtOmCP00
         4l6g==
X-Gm-Message-State: AOUpUlGoAQbhtpHaKGhUCT70x3BfiWgMWgcRfPj0ab/CCPe9QXAKAXAS
        7zyqXOf3tF7w8Zc9uVWNt31CRqTdFo3rakP925qsEA==
X-Google-Smtp-Source: AAOMgpdjKAYWLCYHelpdut7t8Eg1m5IEsHDLkrJ7FbRwpzwL8ws2Nsxh4bJu9W6JvflbzRvZE0JhqoqFt92pKboLhc4=
X-Received: by 2002:ac8:3647:: with SMTP id n7-v6mr4739936qtb.65.1532670357931;
 Thu, 26 Jul 2018 22:45:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:9206:0:0:0:0:0 with HTTP; Thu, 26 Jul 2018 22:45:57
 -0700 (PDT)
In-Reply-To: <CAACQVJo8zB2H6AtQZEVK-nfg8j0f9oVPrBSMjq+CKoQ+xeVrUA@mail.gmail.com>
References: <20180725111459.10800-1-yuehaibing@huawei.com> <CAACQVJo8zB2H6AtQZEVK-nfg8j0f9oVPrBSMjq+CKoQ+xeVrUA@mail.gmail.com>
From:   Vasundhara Volam <vasundhara-v.volam@broadcom.com>
Date:   Fri, 27 Jul 2018 11:15:57 +0530
Message-ID: <CAACQVJqDrVePOVrM3bOnxqUgxbcirDqhStZ3SJW2OBrNYv3d7A@mail.gmail.com>
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

On Thu, Jul 26, 2018 at 8:24 PM, Vasundhara Volam
<vasundhara-v.volam@broadcom.com> wrote:
> On Wed, Jul 25, 2018 at 4:44 PM, YueHaibing <yuehaibing@huawei.com> wrote:
>>
>> The else-if branch and else branch set mac_ok to true similarly,
>> so combine the two into single else branch.
>>
>> Aslo add comments to explain the two conditions, which
>> from Michael Chan and Vasundhara Volam.
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
>> index a649108..f560845 100644
>> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
>> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
>> @@ -956,9 +956,13 @@ static int bnxt_vf_validate_set_mac(struct bnxt *bp, struct bnxt_vf_info *vf)
>>         } else if (is_valid_ether_addr(vf->vf_mac_addr)) {
>>                 if (ether_addr_equal((const u8 *)req->l2_addr, vf->vf_mac_addr))
>>                         mac_ok = true;
>> -       } else if (bp->hwrm_spec_code < 0x10202) {
>> -               mac_ok = true;
>>         } else {
>> +               /* There are two cases:
>> +                * 1.If firmware spec < 0x10202,VF MAC address is not forwarded
>> +                *   to the PF and so it doesn't have to match
>> +                * 2.Allow VF to modify it's own MAC when PF has not assigned a
>> +                *   valid MAC address and firmware spec >= 0x10202
>> +                */
> No, this is not correct either. You are not covering both conditions.
> else part with cover if (!is_valid_ether_addr(vf->vf_mac_addr))
> before.
My apologies, I was thinking one more condition was required.
Patch seems fine.
>>                 mac_ok = true;
>>         }
>>         if (mac_ok)
>> --
>> 2.7.0
>>
>>
