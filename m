Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC7FC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 18:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06FED20875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 18:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHCRqG9A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06FED20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388611AbeGXTay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 15:30:54 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:35106 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388409AbeGXTay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 15:30:54 -0400
Received: by mail-ed1-f46.google.com with SMTP id e6-v6so4936528edr.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 11:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Hj9pb6SXOkZjhEFtTO+CicARixKFIiQEk3s1A9p6VL0=;
        b=LHCRqG9AcFYE38j88PrPdrUhVMi2ZlmR1Ua49ncxqntrZH+xyz9xzXvKA1l8gn3Ndw
         c9l/g+H8KAp91zFwRKBeBZfC/XWm5U8C2nfyhtMqJSLB1G1Sb9CiuZZAVmOjfMO5jCOm
         wGkpQUDwM+I2WbAM5KRAR5gttp87pL7xDlRQ2d5WoUxCjir436lf1S4vUTTV33v9emz7
         +kJtfOG5pplpHfJoBsfFuAPh2eS8I6UEF6jJU4ZH3jsAcXmjmSWE70rg1+EH7+8EVTlm
         XZyTfTqazMf5PUa4CdqxrDN4+SGehgw5qcE8nGN4VddBeMUHZFjI26DBcKubX+AbTTjY
         mFSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hj9pb6SXOkZjhEFtTO+CicARixKFIiQEk3s1A9p6VL0=;
        b=jeTMyM09mkoABJareQ94+TXS5Rr4M1iTLnxcOWV/TciDFGORVrattRt2zgmUi6MKZK
         xFr1a+bAvmQ0fqwIiUTHL4c5ovE6hDHLKZD2l7R+nbb/06RWpbgBv/+j9NbNOi7xD84T
         /CPj1fHGwc6QE/Upw4fwHSlo243vjFSC1n9TGcGXXEBjdKG6XK3txm2Ptu7p+OF0GBpX
         E+SX2tk/YsIXRD3rzvxRuQV8Wzk+NK/TNckaa5np4EMYHIsfOkcOLEgwdRB1qG/RIX1B
         UQALtoC44hrZMqpHWj/i+s8v5De06xdzeRhxjvhvJVpS1INqkaiQq3Ek0gsFR/3cH74L
         PY6A==
X-Gm-Message-State: AOUpUlFOv9N1JbrfFO51OvOszFeFk3wx5Mi3XF+r6X//FklKPvQHWvCu
        xnsKR3d65B1rUur1VHxyReGtVQU=
X-Google-Smtp-Source: AAOMgpfQ5EWNa0nEnsbwMBPmFWy5Kx5jN78EDx8TAU7OUCQwTATnO5LydveCAWHS+eA+o9PH2urYiA==
X-Received: by 2002:a50:adaa:: with SMTP id a39-v6mr20078895edd.194.1532456590197;
        Tue, 24 Jul 2018 11:23:10 -0700 (PDT)
Received: from avx2 (nat4-minsk-pool-46-53-177-92.telecom.by. [46.53.177.92])
        by smtp.gmail.com with ESMTPSA id g6-v6sm6621591edn.28.2018.07.24.11.23.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 11:23:09 -0700 (PDT)
Date:   Tue, 24 Jul 2018 21:23:07 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, dancol@google.com, vbabka@suse.cz
Subject: Re: + mm-proc-pid-maps-remove-is_pid-and-related-wrappers.patch
 added to -mm tree
Message-ID: <20180724182307.GA27053@avx2>
References: <20180723235540.qS9To%akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180723235540.qS9To%akpm@linux-foundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 04:55:40PM -0700, akpm@linux-foundation.org wrote:
> 
> The patch titled
>      Subject: mm: /proc/pid/*maps remove is_pid and related wrappers
> has been added to the -mm tree.  Its filename is
>      mm-proc-pid-maps-remove-is_pid-and-related-wrappers.patch

Reviewed-by: Alexey Dobriyan <adobriyan@gmail.com>
