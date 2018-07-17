Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A038ECDFB4
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21DEC20693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMQ/lrad"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21DEC20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730880AbeGQVrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 17:47:22 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:42107 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729805AbeGQVrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 17:47:22 -0400
Received: by mail-qk0-f195.google.com with SMTP id 26-v6so1316430qks.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 14:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FVTkNR7nNyWkc6bGhuDo4SJ8a/oDmhYgh0e0q5v3tsU=;
        b=hMQ/lradULhm1iiZR470AcyhPXvqk4rVYwb8oB/Tl7k2lwEnAa4lXZI8mt3Y3uygNv
         wjin9deEg2T53GJ0eLs7ISgYyk1W6j8DeRWoB89oBlSHiDJFMWT29AIin1NlFkzPYxrY
         a6JjNpT9HIlg4By+KvQrVj7Bqnj0wDFJwTRLT9vfl7j5tOY7gbtYeGt8t5sSGWAyC2Yh
         7Mj1GFV2K8W1VSLgDDGQImcanuP81u4KET3HgOi50+yDswUNbh6WJZBXCvxUFnozI879
         Dv6dCxcIJ94FzVwvce5lj9SYtIOB2dTzuxVKBvIZEXxoIf1VssLJgZPaqr2sOHQ3R5dm
         oc4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FVTkNR7nNyWkc6bGhuDo4SJ8a/oDmhYgh0e0q5v3tsU=;
        b=eFs+uQim7IjA2eYk10m0oFrcMfstEnjk5UiIMJVtvEpHpMLmGFzHVX2aP9TkLUhIbF
         jNA9IybjYD0Szm+PgkGmxMXR9aK2wt6mlohAAS6lo527CcYBL0hf1JUbCmufL4JyyzMR
         9e+FzLiHJQYjm8tcSKt43NTH1UJoHiQdk5g49chAiPKEDqLyX8QavWcdIP1M+I2OuKRG
         1ZdInEXzBBnC4HSC98yPrTkFsgsNZ5us5v7IUxOGJVSVQQghlrzJefJYazdS/QDwF4TS
         QfgQIH0OQXGPRNGHcOgxS9Gfj5CfAtGu1CXqEBHYsjcQmZKfWmuWm3t6DEhJlLxSkM1E
         Zplg==
X-Gm-Message-State: AOUpUlEzHQjRYg0NELWjM3/g3Bg+yvqUl6Q9pxw/2P9VQV/s/YCxroUE
        yubqYI907DAoDsGBYU/Kfj0=
X-Google-Smtp-Source: AAOMgpcVn+3ueySVV2M72AcDybkDr4o9oXka603KLPUudYzBPZjwbMTEvraYpYins/lSlrdSKM/N2Q==
X-Received: by 2002:a37:7486:: with SMTP id p128-v6mr3124806qkc.335.1531861972457;
        Tue, 17 Jul 2018 14:12:52 -0700 (PDT)
Received: from oc6857751186.ibm.com (c-24-20-82-131.hsd1.or.comcast.net. [24.20.82.131])
        by smtp.gmail.com with ESMTPSA id a19-v6sm1970655qta.50.2018.07.17.14.12.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 14:12:51 -0700 (PDT)
Subject: Re: [PATCH] powerpc/msi: Remove VLA usage
To:     Kees Cook <keescook@chromium.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Rob Herring <robh@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>
References: <20180629185254.GA37557@beast>
From:   Tyrel Datwyler <turtle.in.the.kernel@gmail.com>
Message-ID: <911632d5-b54c-b632-75d9-7628a0cfc490@gmail.com>
Date:   Tue, 17 Jul 2018 14:12:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180629185254.GA37557@beast>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/29/2018 11:52 AM, Kees Cook wrote:
> In the quest to remove all stack VLA usage from the kernel[1], this
> switches from an unchanging variable to a constant expression to eliminate
> the VLA generation.
> 
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---

Reviewed-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
