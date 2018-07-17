Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C0AECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C059208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwRTxXfj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C059208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731258AbeGQMWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 08:22:48 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:37982 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731109AbeGQMWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 08:22:48 -0400
Received: by mail-wr1-f41.google.com with SMTP id v14-v6so962490wro.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 04:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gE/y2Ug3Wb1m7yOc1Kk83/ly5YDA53/lAZDc+2lkI/w=;
        b=NwRTxXfjc+hITVifotoYN0Aoi72pXV2zQZurK5AhC1uI6AmrHc5UGYWouifCwTTUgK
         kpzf6CaggzWp+6in2Q/FenRrk1oHePEoPf0olfXr5gP4vsWOao6NEHEDeG03if5GlyHk
         o5sM1kC/saEI+qlKg+GXYqweOnnCGRrrRiU6djsoXFFSOT2qlMlHGACbUMnD6Nns8g0h
         8ZKJL7vNNo5FFnUThURQRWJQoHj1X1hvB5eLUltIfErcN9KGuUy5Aa8Y6gt8Wmmdfyx0
         XQ0cAl/88KYo/PA76+ffogT0j+U5MdIAHxTDh4DxGTok95kMS5z2tN4SFQ8HcbhjWMGb
         Dbgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=gE/y2Ug3Wb1m7yOc1Kk83/ly5YDA53/lAZDc+2lkI/w=;
        b=HlGUY4+q3OSO5WrJ1gxjsc3vvr0puF5hS2CwswFPkKMekyHYUcYhn8nbrldAEhqILE
         IMwhYstufR8YAoh71TEbVdP9Xhfds45ni/rSmVQMabIrPuu9jYZEDZVGr5LZ0GQRvG3g
         As8V4yEDOIC7N5BehZ3OkDIrFCaSxjgYW5sgeHyWkPo+7txF5ApisZ12XaVzKHMGa5ub
         Z6KsPbzAEsHKU3UgIoxCUc1EHJJH6yb5JPAegQIkZqg3FejkGynzLTR/bk/1hTqTsLtY
         0om48oUOCD/tsBPw6gEMcfgAwqC2KLomEHKLrMKpxo+ox0ZJuwVXHLtssj8FQfM5Qc1N
         RQAg==
X-Gm-Message-State: AOUpUlGx9qBL6xE6Ene7xRy0CmBIsZ/hUq311EeT75N8oPDONQSi9RBY
        keQrCC0v+Oqc9EbNPO4NY1c=
X-Google-Smtp-Source: AAOMgpf5t8q5VmRkYyLvYva5+0rNeHRjVdwnLJ3THsTxOMeHNKmZN1qBebWVj44upAoVO3wW/tBvMQ==
X-Received: by 2002:adf:a14a:: with SMTP id r10-v6mr1126739wrr.104.1531828230822;
        Tue, 17 Jul 2018 04:50:30 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id v185-v6sm745982wme.30.2018.07.17.04.50.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 04:50:30 -0700 (PDT)
Date:   Tue, 17 Jul 2018 13:50:28 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [tip:efi/core] efi/esrt: Only call efi_mem_reserve() for boot
 services memory
Message-ID: <20180717115028.GA15594@gmail.com>
References: <tip-61f0d55569463a1af897117ff47d202b0ccb2e24@git.kernel.org>
 <CAKv+Gu_iy1EkfWEzDE4zbkydU7EqXv+mQx9PTrYKpJWfXHSVig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_iy1EkfWEzDE4zbkydU7EqXv+mQx9PTrYKpJWfXHSVig@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> Hello Ingo,
> 
> Thanks for pulling this directly. I will have another batch for
> efi/core by the end of the week (and another urgent patch as well).
> 
> There is one remaining issue with mixed mode that I cc'ed you and
> Kirill on, but since that seems to be a v4.17 regression, I will keep
> that as a separate thing.

Sounds good to me!

Thanks,

	Ingo
