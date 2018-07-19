Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77C9C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 12:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0662D2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 12:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxWtBSNR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0662D2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731235AbeGSMwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 08:52:23 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42213 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727489AbeGSMwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 08:52:22 -0400
Received: by mail-pg1-f195.google.com with SMTP id y4-v6so3567317pgp.9;
        Thu, 19 Jul 2018 05:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bMu8Fi3pHigZInUUMKFPEkET+QY2hckCoVBrP3Yv/7g=;
        b=cxWtBSNRlvv1l7kSHc0KeFWACgY5fcQ5oMW9AMkLSLh7KrZ0meyBuNFjpCppwbIZGS
         D0UuXkF/+4dzkduhQJNNmKp4llHvtB7Prfk192I9uwgxaJR3IFgQ2VB8kE6Nvp5rgnHv
         M+pDYGm18sLNM9NuZz89Ds6jzlCaSN004Uw9TRNhIJ+seCYHLJ7XsjcFaWpTpj9Pbxa8
         CQFB3pd4F06c96RWr2k0lDWLydwa2f4WvtnIXHearL3uIhVELDWiVlfs1YN8jczRnZic
         w7JIiT/6J2u8MjBYMB8EyLB0n85V046The9SMH3+ZvYxNXuuEbWNHZw9g90QyH/fDEwA
         lTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bMu8Fi3pHigZInUUMKFPEkET+QY2hckCoVBrP3Yv/7g=;
        b=R6hqjBoAHBzqho023QaerXVFk5gpi0F92turuHqgqB42rYfuOJ+8OhNbKhhzY6SHep
         D5z1mfsjQdgz878x5M7VMhMSngpguOCLq4P9scrxiTpo3Lb6mrizkyP3pmLa/wJ5eseS
         GErEGiDTml408rfHORAV24ePX2MQ7dtrUmXWlhjJMHQAmsMDRlW1CHl/5ObUscv8IE30
         qP2+5S4gFgC2CWA39cwUPED065p0QzFtfX5/UmWOXkRi1luKzmX77HkifmMKM5Bm6u2w
         uAi5U2d50ZQUDLA8nOCURuYezIKmvIIITst4yHxJtXmc7rC94z5ZE6m0XoXrgVlvGAqo
         +XYQ==
X-Gm-Message-State: AOUpUlGGwDY8glVOr42jGmNrTtcugb3yGA8yUaJwgb7WQAhwSB4VIEWA
        xM40fnrCY/WdK/w3k0d9fXCMlW92
X-Google-Smtp-Source: AAOMgpddp0JDvqngK9FzDUNIvPlAlOVV1x7fvZTUrm3bDn89tJouy4eH7aoHk/L7Bez4XNbKT44RAw==
X-Received: by 2002:a62:5f82:: with SMTP id t124-v6mr9329142pfb.223.1532002171047;
        Thu, 19 Jul 2018 05:09:31 -0700 (PDT)
Received: from [192.168.0.77] ([211.196.191.92])
        by smtp.gmail.com with ESMTPSA id 21-v6sm17624849pgx.20.2018.07.19.05.09.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 05:09:29 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] tools/bpftool: ignore build products
From:   Taeung Song <treeze.taeung@gmail.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180719024515.6659-1-treeze.taeung@gmail.com>
Message-ID: <262e416e-d712-c850-4126-6a45632da4eb@gmail.com>
Date:   Thu, 19 Jul 2018 21:09:26 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180719024515.6659-1-treeze.taeung@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'll resend v3 because it is better to add "bpftool*.8"
to tools/bpf/bpftool/.gitignore.

   Untracked files:
     (use "git add <file>..." to include in what will be committed)

           tools/bpf/bpftool/Documentation/bpftool-cgroup.8
           tools/bpf/bpftool/Documentation/bpftool-map.8
           tools/bpf/bpftool/Documentation/bpftool-perf.8
           tools/bpf/bpftool/Documentation/bpftool-prog.8
           tools/bpf/bpftool/Documentation/bpftool.8

Thanks,
Taeung

On 07/19/2018 11:45 AM, Taeung Song wrote:
> For untracked things of tools/bpf, add this.
> 
> Signed-off-by: Taeung Song <treeze.taeung@gmail.com>
> ---
>   tools/bpf/.gitignore | 5 +++++
>   1 file changed, 5 insertions(+)
>   create mode 100644 tools/bpf/.gitignore
> 
> diff --git a/tools/bpf/.gitignore b/tools/bpf/.gitignore
> new file mode 100644
> index 000000000000..dfe2bd5a4b95
> --- /dev/null
> +++ b/tools/bpf/.gitignore
> @@ -0,0 +1,5 @@
> +FEATURE-DUMP.bpf
> +bpf_asm
> +bpf_dbg
> +bpf_exp.yacc.*
> +bpf_jit_disasm
> 
