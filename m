Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B44C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 04:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47A0E20872
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 04:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20150623.gappssmtp.com header.i=@landley-net.20150623.gappssmtp.com header.b="gIA3zXLo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfALEVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 23:21:33 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42628 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbfALEVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 23:21:32 -0500
Received: by mail-oi1-f195.google.com with SMTP id w13so13908443oiw.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 20:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8eiHyWKZGcZUp+R6uaRKDmEv1IchLphQOgNqk4uTp7M=;
        b=gIA3zXLoGIzf2axhoVoG/yJcS2FVN1/ldPtLWOsew5p3kO2pO7JzcK7rNKHuFbguXi
         V/LnquXmPVpqsfVMKrykueyUwGmZ5Jlc72EL9MuGx/jVBFnzp5eZXaCEo/QpM+iYfeDt
         wHrZN6a68AgZ6q8UVgcdlrWQjJ0+hkqR1eMlGm5wiwBsEtaZGIUF7dvy+PSfC2vflWmK
         XZq2Beqp/wck7bR6lJecpPhCu7qYRrp/2IWg68p3BLKMapcqi0Fg3AxFaBUliPR/rGmR
         iN7wUlMjWLggj+PkamihXOCUqbACM/L2elk5TPqSP9YbtwQorcvF4N9pMf1uxm88Sz1r
         8D+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8eiHyWKZGcZUp+R6uaRKDmEv1IchLphQOgNqk4uTp7M=;
        b=dpEuip11nPoEO9I4gbwOg310brWKodjER0DeIEsHZA5A8dd9Fqhn7trje+WgHYE+gF
         vxP2E9sqdKymw0nAegaitivk1XZTMQHZW06oCRw5bweoADFsYLaxYLKFGm8ZCgRNl5wX
         a4dRjNjNd88iL0QeYaG5WiMfNU72wUh7bvpo4OypeZHvCgDSGwQOW2PQG3zTurwSgesm
         Yub9soKPsUjzErRRQq8wM4+GOgq+PJPI4F7uPSDQ7yXzDJaOxEKPdny3ct6YK/iXHEMU
         kyimh6NXZVbK6pjXYvZpZo2DK9JkcDAuLBPqEvwNaSZqWARAJiYljB8Smcv/EEjHae1v
         PIwA==
X-Gm-Message-State: AJcUukfdcKY9ElBxkR8NKPM8DDUdREPrfhs8aP0nqEAjpTUSHoQ3OZZB
        1mviBQiUNfgFru+WHlKx2vdXlQ==
X-Google-Smtp-Source: ALg8bN4voZCvoahJV/YotWfC08cBgs/KqleFduWgMyk7iXk/3QcjXUwhRhBeG5kQ6pc3NHvSX3cZwQ==
X-Received: by 2002:aca:1e17:: with SMTP id m23mr11241094oic.332.1547266891858;
        Fri, 11 Jan 2019 20:21:31 -0800 (PST)
Received: from [192.168.1.10] (072-182-052-210.res.spectrum.com. [72.182.52.210])
        by smtp.googlemail.com with ESMTPSA id 14sm12048593otg.68.2019.01.11.20.21.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 20:21:31 -0800 (PST)
Subject: Re: [PATCH 2/2] sh: generate uapi header and syscall table header
 files
To:     Guenter Roeck <linux@roeck-us.net>,
        Firoz Khan <firoz.khan@linaro.org>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Simon Horman <horms+renesas@verge.net.au>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        linux-sh@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org
References: <1546443445-21075-1-git-send-email-firoz.khan@linaro.org>
 <1546443445-21075-3-git-send-email-firoz.khan@linaro.org>
 <20190110235428.GA10016@roeck-us.net>
From:   Rob Landley <rob@landley.net>
Message-ID: <d329d7b8-62fb-9cb0-521e-ee7887f122a1@landley.net>
Date:   Fri, 11 Jan 2019 22:21:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190110235428.GA10016@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/19 5:54 PM, Guenter Roeck wrote:
> On Wed, Jan 02, 2019 at 09:07:25PM +0530, Firoz Khan wrote:
>> Unified system call table generation script must be run to
>> generate unistd_32.h and syscall_table.h files. This patch
>> will have changes which will invokes the script.
>>
>> This patch will generate unistd_32.h and syscall_table.h
>> files by the syscall table generation script invoked by
>> sh/Makefile and the generated files against the removed
>> files must be identical.
>>
>> The generated uapi header file will be included in uapi/-
>> asm/unistd.h and generated system call table header file
>> will be included by kernel/syscall_32.S file.
>>
>> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
> 
> Have you tested this patch ?

I tested it at one point, but not recently. (It was before 4.20 came out...)

Rob
