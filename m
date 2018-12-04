Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4036C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A9B620851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u1ACJAUp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A9B620851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbeLDLbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:31:55 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46104 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbeLDK4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 05:56:18 -0500
Received: by mail-pf1-f193.google.com with SMTP id c73so8013154pfe.13;
        Tue, 04 Dec 2018 02:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2+IPzr31w0id4mq+HkzhcuikzVsMzXfYOT4elQgXOhc=;
        b=u1ACJAUp5fjHnM8ICWJTyxgCIeybsnCQfPIpNlP33msmtyEO0Jw7CxnKcUpF8KjbDj
         u6pMz1Sw5TVKI34mMRO+Ng/uMzPs7nnvjKCiy1NPWDNqgkWmkTbt1PMSD+IC1Imi3/+F
         oF6E3nvmGVgzjRNQtTy5l0TTizwEmVyl498D5rlB2F6tF3STkANcsfjRiVkauMwiq0cS
         ma//wKlRAY6+id2ybC7o4n9PNS5SX+LaIpgS82BNmroiACtukR9zmNpc5e0p92aRMY0L
         HeOHvp+OzOpIuR1B6VlPgSQovsrOu+pUybYdMp87tNviPcbI+ZcHRK+PO5lhYuXsJmBS
         Dz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2+IPzr31w0id4mq+HkzhcuikzVsMzXfYOT4elQgXOhc=;
        b=q0Jj/mdnGdMNCt6ZVcIXjeozTmGxdYkYYtAXR42PkGJ1ReMg8f/ViHfVScYLdLFgq1
         Gc00hgJX+yffuobyOA2ZQ3qBEBbQ3Y202tGlnLl9boJGaiF/83sgeISgeCSEbiCPLgrQ
         fH2RbTxez0D20x6AyEbbyTeTs0eJAYWEtPKmORhA8CJa6XRoSQkf5TwUwAtpaBWLhNrJ
         7yJeuUDE3LR4Tt+eOjbmHmRaBnXf8mbAOiGyYDHXRWJj+JEfQr0eGrAjHP+16LIFq6mY
         HcUqxyF6oO9EjVh0o5t5jMsUHai/o9pF1+hRezbAe2o2BK2RSIJnYGxZDncib2mg5N3K
         wnEw==
X-Gm-Message-State: AA+aEWYxHW/u6sWpfT+b5H91u6h9Ci05BE9rhOOvF1/ED5UjiFKwHFmQ
        t83KwSEk+ho5xt6qILBPt5k=
X-Google-Smtp-Source: AFSGD/WtlmMeP8y9qN1s941zxEC8fhmCwVi8tgUck6PlLQfteCbuYU0fvv+IrplNoBWpiRfiT0v5iQ==
X-Received: by 2002:a63:e19:: with SMTP id d25mr16230433pgl.272.1543920977093;
        Tue, 04 Dec 2018 02:56:17 -0800 (PST)
Received: from [10.231.245.170] ([125.29.25.186])
        by smtp.gmail.com with ESMTPSA id y184sm20206691pgd.71.2018.12.04.02.56.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 02:56:16 -0800 (PST)
Subject: Re: [RFC v3 17/19] of: unittest: migrate tests to run on KUnit
To:     Brendan Higgins <brendanhiggins@google.com>,
        gregkh@linuxfoundation.org, keescook@google.com, mcgrof@kernel.org,
        shuah@kernel.org
Cc:     joel@jms.id.au, mpe@ellerman.id.au, joe@perches.com, brakmo@fb.com,
        rostedt@goodmis.org, Tim.Bird@sony.com, khilman@baylibre.com,
        julia.lawall@lip6.fr, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org, robh@kernel.org,
        dan.j.williams@intel.com, linux-nvdimm@lists.01.org,
        kieran.bingham@ideasonboard.com, knut.omang@oracle.com
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-18-brendanhiggins@google.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <630d0c82-401e-28f8-73fc-6e684ec57bbf@gmail.com>
Date:   Tue, 4 Dec 2018 02:56:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181128193636.254378-18-brendanhiggins@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/18 11:36 AM, Brendan Higgins wrote:
> Migrate tests without any cleanup, or modifying test logic in anyway to
> run under KUnit using the KUnit expectation and assertion API.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>  drivers/of/Kconfig    |    1 +
>  drivers/of/unittest.c | 1405 ++++++++++++++++++++++-------------------
>  2 files changed, 752 insertions(+), 654 deletions(-)

< snip >

I am travelling and will not have an opportunity to properly review this
patch, patch 18, or patch 19 until next week.

-Frank

