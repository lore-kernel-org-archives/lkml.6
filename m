Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4ECEC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 22:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E76A2133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 22:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="aFU2EjQT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E76A2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbeISE2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 00:28:11 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45069 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbeISE2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 00:28:11 -0400
Received: by mail-pf1-f194.google.com with SMTP id i26-v6so1692964pfo.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 15:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=jb/e/0w9ejcwRiwKkXw3Oj92GbmpmKHid10DsSWgFD0=;
        b=aFU2EjQTA3m9tIHrvxfDDpkbWbR24IuD5Mc1UTuLK96csScEF23Gq4P2Lti5vbbPBt
         TkCDrSQ7mAU13hXDghLwAL9Ojs/tVMepvVJcH2P9Z5+1tj8uWYMHOWr8BPyyNQgmjONJ
         qA6VtIpNib5sJ68LZk0YA6dsiCUpmhuFUNMdexDLrcPSsidRxzTNBlVXEqdDWp98IxqJ
         B/orPvwdBMkJZrWI45DwyJ8D3MUMUsk/2cqBROdXeMW15gdjBksuuGDvg+dox9dREtOj
         SrEaKkkK1/M8lVPVDRjVCZLRgzkIJyiUhU2ywGHZAt709oYJa3INlM8pv3oIDvrFHaOW
         Sapg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=jb/e/0w9ejcwRiwKkXw3Oj92GbmpmKHid10DsSWgFD0=;
        b=KUgrt15l3ryKO+kkhb7CriaTpBLTGJABEIilQUYpqLR8yMYJp4Gp8FwIpudSqrrjdM
         V4Ox4IBo2NPhHkNQSuT20R/oBXNhRbvINakBkSEqTR50oxjsmICn8oEyR+Qv5d37p6Jp
         6T6vJJDUsWZNNPH3Ci9KZpHKgw8TiWv2ILeMjQ77OzXmM81WiUci1TB1aV/YkOoDPCBv
         khXsFPQz9eN3lP8iTVJ9G/CIdngt4jYQ5PuCuMOMx+luIEeY3WCJyKLJhSVvH4BdxAAx
         VS3BbOQ/WkaEiX/ZppYjZoJsAQV3C2GzqhF9qudTrIc2gz+gOrVU21TcQ/4Vr4ctdPnZ
         f2eA==
X-Gm-Message-State: APzg51C2Y6TqaMUh9+AMPFgOmXuv5lEH4MJVzO5RegVZ9SKrFQ2L84Jq
        p4mghFm2tUPMvy3A03wEfyvmvA==
X-Google-Smtp-Source: ANB0VdaL4N91HM1RQGTdAeDDbMMSXwragBEhWZfBWXZHlmPjJj9zuDIL0YmHkvacJ4dJf0f7T8nS2Q==
X-Received: by 2002:a63:447:: with SMTP id 68-v6mr29788885pge.409.1537311203002;
        Tue, 18 Sep 2018 15:53:23 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id h4-v6sm27240639pfe.49.2018.09.18.15.53.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 15:53:21 -0700 (PDT)
Date:   Tue, 18 Sep 2018 15:53:21 -0700 (PDT)
X-Google-Original-Date: Tue, 18 Sep 2018 15:52:33 PDT (-0700)
Subject:     Re: [PATCH 14/21] riscv: use for_each_of_cpu_node iterator
In-Reply-To: <20180905193738.19325-15-robh@kernel.org>
CC:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     robh@kernel.org
Message-ID: <mhng-bec6b34b-dd05-410f-bbd2-3a60a196615d@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Sep 2018 12:37:31 PDT (-0700), robh@kernel.org wrote:
> Use the for_each_of_cpu_node iterator to iterate over cpu nodes. This
> has the side effect of defaulting to iterating using "cpu" node names in
> preference to the deprecated (for FDT) device_type == "cpu".
>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: linux-riscv@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Please ack and I will take via the DT tree. This is dependent on the
> first 2 patches.
>
>  arch/riscv/kernel/smpboot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> index 56abab6a9812..3c59afe67951 100644
> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c
> @@ -52,7 +52,7 @@ void __init setup_smp(void)
>  	struct device_node *dn = NULL;
>  	int hart, im_okay_therefore_i_am = 0;
>
> -	while ((dn = of_find_node_by_type(dn, "cpu"))) {
> +	for_each_of_cpu_node(dn) {
>  		hart = riscv_of_processor_hart(dn);
>  		if (hart >= 0) {
>  			set_cpu_possible(hart, true);

Acked-by: Palmer Dabbelt <palmer@sifive.com>

Thanks!
