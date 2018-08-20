Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEEEC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 22:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2852F2174E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 22:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="cgHa7jzc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2852F2174E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbeHUBu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 21:50:58 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:42554 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbeHUBu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 21:50:58 -0400
Received: by mail-pl0-f66.google.com with SMTP id g23-v6so4836973plq.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 15:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=wTZgUpm6tq/TBsn0MSLdl+lMdKESPMr1wdfVJhmYi9A=;
        b=cgHa7jzcBZUKOE6lj0qZPtMSj18IuAYYbOTkoF6mAYOwwdU6E87Ow5ejZfIt/8iRYp
         eLeJLJwkg+b9hczzKLD/TD5uV0l9zeBSVyRWGyuUU3aqMONqRziUKidFjS3ued6eDBjX
         hWTPqJfRmwWXowXAe2xbYmBV4AkppN8TpO1csxEh7TYIMMlt4tawi1m7fKtoQ1ZessT6
         dFMmXYeswhqpHd0eznmvbImz6WBb0HFqpRVKHMtFUUJ/SyqrnmVUsjl8J4rBjK+IJLfE
         iHEJ5nAukqwRcW5v2LovMuR4WExmvQuXgArlqHNYqmS5Sk8q99pEnT5/D9XRBFqJa0hZ
         HQ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=wTZgUpm6tq/TBsn0MSLdl+lMdKESPMr1wdfVJhmYi9A=;
        b=ZSG8jY+1SxWP+s7oeqJl8RdE8X6cJzP12a0Ho92kUFrnvD3aiG/BJCxecGPkOZJYTR
         iWQABfXmY0xK2g/LsOp3r5F7rkP01P+u0WeFrPy97DI7EL0sCZ79D+7BC/MzOuQPv5nE
         raV198/iLTzZcIbAKbuS6GEGtDZlhFlOAEbpiDpdCqNFNYMvDA2x2hzFcfxhm2D5XYBt
         jx+QOsMDysJbOmW1Cn0EYtdF1xpMzm7R+483Pp6I7dqU5eR2w3sg2b9FTg/jYKPVI2Wj
         58bKpdOWUklu7JOuv4/70EnYoLtPLtaisXKxymBbQBN2a4sX44THbyb0px6SJT/JOgjj
         Abmw==
X-Gm-Message-State: AOUpUlH1AmuwQDVyS+tEWdk6Uf1X01GR4uisuFU+xR0LPF8JLf1Tpctv
        yAC0XbEWAfK+wsCDO0a1JivT0Q==
X-Google-Smtp-Source: AA+uWPwqnLI20Np6uaRrLVOMUIpPBxmFaeaDmWEVzSw5kfeNbvqmhqkXYv1h7mo4dBnf/QztvdT0iA==
X-Received: by 2002:a17:902:4601:: with SMTP id o1-v6mr47362833pld.202.1534804410641;
        Mon, 20 Aug 2018 15:33:30 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id t70-v6sm7617385pgd.54.2018.08.20.15.33.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Aug 2018 15:33:29 -0700 (PDT)
Date:   Mon, 20 Aug 2018 15:33:29 -0700 (PDT)
X-Google-Original-Date: Mon, 20 Aug 2018 15:33:20 PDT (-0700)
Subject:     Re: [PATCH] riscv: Drop setup_initrd
In-Reply-To: <1533874300-17656-1-git-send-email-linux@roeck-us.net>
CC:     aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux@roeck-us.net
From:   Palmer Dabbelt <palmer@sifive.com>
To:     linux@roeck-us.net
Message-ID: <mhng-fabb487c-62df-4a45-b629-5a8f59d9bbb8@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Aug 2018 21:11:40 PDT (-0700), linux@roeck-us.net wrote:
> setup_initrd() does not appear to serve a practical purpose other than
> preventing qemu boots with "-initrd" parameter, so let's drop it.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  arch/riscv/kernel/setup.c | 39 ---------------------------------------
>  1 file changed, 39 deletions(-)

I missed this for the merge window but I think it's suitable for an RC so I'll 
target it for next week.  It's at kernel.org/palmer/linux.git/fix-initrd and 
I've added it to for-next.

Thanks!
