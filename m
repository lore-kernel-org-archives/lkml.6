Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9EB9C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F55222360
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwKB0bP1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F55222360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731179AbeKNDAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 22:00:01 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39442 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727042AbeKNDAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 22:00:01 -0500
Received: by mail-lf1-f67.google.com with SMTP id n18so9369181lfh.6;
        Tue, 13 Nov 2018 09:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/QeiSTlRuzYqsrfJ9QtGHcxOFn/FgX4yL1652SLxPRk=;
        b=GwKB0bP14dioTBHu8PzYL/xW+fhO+ULb8tyQbzYsVbRhtZ2YNTszhduuKR1+24YqVH
         EIFfUbWkhNy/32Not5ZW518gJTIXXSiAzbIsw09hIUL5+7QIKSACRH6AhwQzaU+y6QI8
         Wi5WF4zLxD61DHL8b1uyqm/YSKrU0dFKLj5NDnTfI8n0obEoLnqn8JENq+d1yvwjRwcB
         96vymFpZJ4aabiwWlGYdtbYsjo8VyCSzGrVrbRcKL5yIjR6PHFR01lelRjP/7KTz9dAS
         UfFqUDFOHQuCntJZbSc4rDi+kjvamM6MqGJMHRkHB3FouUgSpAQLbuF6UKv5De7ynENW
         /srw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/QeiSTlRuzYqsrfJ9QtGHcxOFn/FgX4yL1652SLxPRk=;
        b=OXV76s3xv1z/eDq4vacLc9KxHcaP43Nva5GM3M7XT3MVsBsWF8pnqg4sbikgyft5+F
         8usIDTxwtLgNOZBAagTCbqMXO564fHCClaZPLAHAw3ttIpdgCSO5CXYExeLQlH/oOG/M
         1z1JR0fbq9RKyyPtGujhc4KGC+mjwwj9OE69RotpqfLskJ9ehlOECRSq4f9gmWgvk8gB
         XQG87KC7LuWxMdbktRC5UIqtGSxLwhgM+VRll7SZ4YNooPLB4ferlrQ59wCssIx8eSDA
         UTUsUkCDCn/3URZXdz1YaI0AYTZAIx9Fc0TZotivSS5A//wPdfligKRAzSlkzB2pIOB8
         rfFw==
X-Gm-Message-State: AGRZ1gKyv3bWZgDoEMc0Gsj+ZYmNpcCFtYjIbkzfjVj55B+MCmRFuEFj
        wWTj99u+6yLIqeLdV91VaW8=
X-Google-Smtp-Source: AJdET5f6TlrXrwybo5y5lB3A8grnF2kDqxui2PXpcsMl+ct16rcvuQYEXNSBdv2bpoGl4z8q4DV7bA==
X-Received: by 2002:a19:fc09:: with SMTP id a9mr3610917lfi.21.1542128462828;
        Tue, 13 Nov 2018 09:01:02 -0800 (PST)
Received: from uranus.localdomain ([5.18.102.224])
        by smtp.gmail.com with ESMTPSA id f80sm3507230lff.64.2018.11.13.09.01.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 09:01:01 -0800 (PST)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 2C0B84608E4; Tue, 13 Nov 2018 20:01:01 +0300 (MSK)
Date:   Tue, 13 Nov 2018 20:01:01 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        Rafael David Tinoco <rafael.tinoco@linaro.org>
Subject: Re: [PATCH v2] proc: fixup map_files test on arm
Message-ID: <20181113170101.GX13195@uranus.lan>
References: <20181110184920.GA18252@avx2>
 <1541904527.857883.1572718104.2AE8D0DA@webmail.messagingengine.com>
 <20181112141456.GA15690@avx2>
 <20181112155559.GV13195@uranus.lan>
 <f1805813-62b7-8572-d906-bc49b62d1bf3@linaro.org>
 <20181113165446.GA28157@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113165446.GA28157@avx2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 07:54:46PM +0300, Alexey Dobriyan wrote:
> https://bugs.linaro.org/show_bug.cgi?id=3782
> 
> Turns out arm doesn't allow to map address 0, so try minimum virtual
> address instead.
> 
> Reported-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
> Tested-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Acked-by: Cyrill Gorcunov <gorcunov@gmail.com>

Thank you!
