Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B5EC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 06:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 750D420869
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 06:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QiDmPXqZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 750D420869
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbeIDKY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 06:24:59 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:39119 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbeIDKY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 06:24:59 -0400
Received: by mail-oi0-f68.google.com with SMTP id c190-v6so4561632oig.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 23:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PStyeojd7kHTdTJBBBTJ9XSRnBvRc3Wv7uAg+KgBJ1s=;
        b=QiDmPXqZNK5Kb/9o6L7V4ABjbDuQge5qJBsGdFBLm/+JPtllxBGhc5EgIy8zQPwNSA
         D9HbNHU0wrOobQ8GheIpOX4rCVBwZoWXIHtGx9RpMQes8Z7/8gQchDhYPVvt15YYxMa9
         bxIJu4FRS+mwGRWTXYco2n1xzBh3PbAopQq0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PStyeojd7kHTdTJBBBTJ9XSRnBvRc3Wv7uAg+KgBJ1s=;
        b=DcXleJEBvbPltUODgKxqyZGfYSNGKjaiTl54/vUiUeLTgzirA8cliTpNA4GsmxIyWR
         ZLLSz74FLXN1SavPNha5FPZ6Rv+1jnnQcXuwJWFqUOTOmfeiuV3wCGdEOBZsyeua2Vqv
         uXak258L5jWxGNVGVq2MZZ1UbZwDe0Rd1Jb+DPfsJZI6+Bmad/d2k1/OWGbd04ubbf0E
         Ow4+hhRkZ/9k/4o8Mij6AcChSw1mbkRBCOqU6I7Hec4xAyqfOVggAqdOCyhVxQ4Am7kQ
         G1AUzPgVJ6uvvfs/Tc0JnNJaIqFimBaw7/fyIm/QiG6vWcqQ311ADvowZbOqLXi7XTNq
         6XTA==
X-Gm-Message-State: APzg51BZZiTo1cah/yRDsyE4r4Qrg12QDmqjv/OcdTrotDUWjkJvoTx8
        EStUZmIjD/kkBzX+ZSLbQV3bkXlY+QMn2wq5LPuHsw==
X-Google-Smtp-Source: ANB0VdbCDfLWDNOOCvlVNpoZS66d4MMp8poqxBLc7EaEVO/ahFZJRZWzR/v+pqf2M/AMFbBkLPaTbzeW3yYlN0TG+aY=
X-Received: by 2002:aca:d4cd:: with SMTP id l196-v6mr23795288oig.15.1536040884494;
 Mon, 03 Sep 2018 23:01:24 -0700 (PDT)
MIME-Version: 1.0
References: <20180901092529.11828-1-yuehaibing@huawei.com>
In-Reply-To: <20180901092529.11828-1-yuehaibing@huawei.com>
From:   Sathya Perla <sathya.perla@broadcom.com>
Date:   Tue, 4 Sep 2018 11:31:13 +0530
Message-ID: <CAKvpyk3RZB8ioSKLRxjD-DsJwsFOEsum9r2kH34WkktLkd9FNg@mail.gmail.com>
Subject: Re: [PATCH net-next] bnxt_en: Properly get address type of
 encapsulation IP headers
To:     yuehaibing@huawei.com
Cc:     David Miller <davem@davemloft.net>,
        Michael Chan <michael.chan@broadcom.com>,
        open list <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 1, 2018 at 2:56 PM YueHaibing <yuehaibing@huawei.com> wrote:
>
> gcc '-Wunused-but-set-variable' warning:
>
> drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c: In function 'bnxt_tc_parse_flow':
> drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c:186:6: warning:
>  variable 'addr_type' set but not used [-Wunused-but-set-variable]
>
> As done elsewhere in TC/flower offload code, the address type of
> the encapsulation IP headers should be realized accroding to the
> addr_type field of the encapsulation control dissector key.
...
>  drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
> index 092c817..5c625e5 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
> @@ -242,7 +242,7 @@ static int bnxt_tc_parse_flow(struct bnxt *bp,
>                 flow->l2_key.num_vlans = 1;
>         }
>
> -       if (dissector_uses_key(dissector, FLOW_DISSECTOR_KEY_IPV4_ADDRS)) {

 __skb_flow_dissect() (in net/core/flow_dissector.c) uses the same
construct. So, can you clarify what you are trying to fix here
functionally. Thanks.
