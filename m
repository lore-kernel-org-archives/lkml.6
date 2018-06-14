Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FAKE_REPLY_C,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 03903C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 20:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A092E208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 20:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TABCspmh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A092E208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755437AbeFNUKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 16:10:02 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:42972 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755265AbeFNUKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 16:10:00 -0400
Received: by mail-wr0-f171.google.com with SMTP id w10-v6so7695284wrk.9;
        Thu, 14 Jun 2018 13:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=R9oBzNzy6F0b/9q/6sN2dNxP/OmIgu9qQ38Fktg2+uY=;
        b=TABCspmhhK7E/YTX4KOo0/++RtblzR5loYT6c9zUVPFchai9yhUz7iJxp0fIZDrefW
         LydfsNORuuuxNT956r+liV5fIdgC3rawE/5GUFfN6eWk9nAipHZJQ/vrFxpTxu45j5Wo
         PYVQ3d0uiNBlXEmVqRGy+KPIAL6PoZm/vMnaKg0+SoBEtFVPyI/eScEa6MfDFH+0jtP3
         lR4+NAbxJ4Wqv7Fx9zIRKfsnGkvTSJagqmTwjSFXzRioPHGxam7B8OHkSAuz1/nNmwvw
         de6lSVuC+2AnfXgK24fPSrJbdY5mbFDTzThDrZC1gNHxNxMqMUCpz9x+5OGmqJ8AWzpF
         USOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=R9oBzNzy6F0b/9q/6sN2dNxP/OmIgu9qQ38Fktg2+uY=;
        b=EP8nqlY+k/IxQKPp+UeHfBiIB7QKupSsY2/ykCdXDXxd+jFMCWnZwaKoo5GQ01njRz
         c5H7iUskPvglI80pzkPdu8difCBv1OXnx92V9NzVt7FVG+XBWUQvwz1g3+FbkRVOD7Ji
         f/6co9+a/pGc8KOVtzUkF8S9QLBvn2RWEL2Buvzyrv0eeNjyIlqXFH7sZQAx98zY6vWY
         Bm5fYIg3etbIqPSrrc/VhWn+tpSr3tQH06a2066adk0gXaY5TX8b2X3+OmswY6hG+th2
         NNtudpSddkvQexVHzRKS5MJ3HwRaTWzq20h9rraiGQCfiE4HSowaCBp8yC3IBCDkOnrB
         5W/g==
X-Gm-Message-State: APt69E2Bf7MbZnEjvQuENjkeW5i++xhcy/ZzzB9/ddObh+Nw4VAdmtN2
        SK145rrn1LcFqNuL09EOYxpC
X-Google-Smtp-Source: ADUXVKIh39liZfHdkMTu7q2CkE7uneKQrZSG2xdf64KgIA6YDt+kZVf5CPylsRPYSioD687u1aChYQ==
X-Received: by 2002:adf:fb92:: with SMTP id a18-v6mr3401102wrr.278.1529006999185;
        Thu, 14 Jun 2018 13:09:59 -0700 (PDT)
Received: from avx2 (nat4-minsk-pool-46-53-177-92.telecom.by. [46.53.177.92])
        by smtp.gmail.com with ESMTPSA id l15-v6sm5609006wrs.95.2018.06.14.13.09.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 13:09:58 -0700 (PDT)
Date:   Thu, 14 Jun 2018 23:09:56 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     dhowells@redhat.com
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proc: Make inline name size calculation automatic
Message-ID: <20180614200956.GB7137@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Require a minimum inline name size of 33+1 to allow for names that look
> like two hex numbers with a dash between.

Hi, David.

Why 34? /proc will fallback to separate allocation for name anyway.

I sent nearly identical patch earlier.
https://marc.info/?l=linux-kernel&m=152667374404900&w=4

If you compare, the differences are:

* no BUILD_BUG_ON,
* 64 bytes is too litle even on 32-bit,
* 512 bytes is probably too much even on 64-bit.

> -	.name		= proc_root.inline_name,
> -	.inline_name	= "/proc",
> +	.name		= "/proc",

This will "uninline" 5 bytes wasting space.
