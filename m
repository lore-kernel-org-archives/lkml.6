Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97F4C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 14:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C1382086B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 14:34:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C1382086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729901AbeIGTPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 15:15:12 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:1054 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727659AbeIGTPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 15:15:12 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 426Kgl3MMfz9ttFX;
        Fri,  7 Sep 2018 16:33:55 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id KZTHsUm-_W7V; Fri,  7 Sep 2018 16:33:55 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 426Kgl2nWhz9ttFT;
        Fri,  7 Sep 2018 16:33:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1EAFE8B94C;
        Fri,  7 Sep 2018 16:33:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id iLhzZ55TFrse; Fri,  7 Sep 2018 16:33:59 +0200 (CEST)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BD2ED8B950;
        Fri,  7 Sep 2018 16:33:58 +0200 (CEST)
Subject: Re: Conflict between sparse and commit cafa0010cd51f ("Raise the
 minimum required gcc version to 4.6")
From:   Christophe LEROY <christophe.leroy@c-s.fr>
To:     Joe Perches <joe@perches.com>, Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org
References: <81a5fd11-366c-0897-4143-d8d041420a41@c-s.fr>
Message-ID: <1324e7d6-83f8-f40f-ad34-c46e4ad3139b@c-s.fr>
Date:   Fri, 7 Sep 2018 16:33:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <81a5fd11-366c-0897-4143-d8d041420a41@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc linux-sparse@vger.kernel.org

Le 07/09/2018 à 14:22, Christophe Leroy a écrit :
> Since commit cafa0010cd51f ("Raise the minimum required gcc version to 
> 4.6"), sparse check fails as follows:
> 
> [root@pc16082vm linux-powerpc]# make C=2 arch/powerpc/kernel/process.o
>    CALL    scripts/checksyscalls.sh
>    CHECK   scripts/mod/empty.c
> ./include/linux/compiler-gcc.h:14:3: error: Sorry, your compiler is too 
> old - please upgrade it.
>    CHECK   arch/powerpc/kernel/process.c
> ./include/linux/compiler-gcc.h:14:3: error: Sorry, your compiler is too 
> old - please upgrade it.
> 
> 
> I have sparse version 0.5.2
> 
> What can be done to fix that ?
> 
> Christophe
