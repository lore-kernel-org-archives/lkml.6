Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA48C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 08:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0D7420881
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 08:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netrounds-com.20150623.gappssmtp.com header.i=@netrounds-com.20150623.gappssmtp.com header.b="C1vnXUeW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfAGIyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 03:54:31 -0500
Received: from mail-lj1-f182.google.com ([209.85.208.182]:45931 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbfAGIyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 03:54:31 -0500
Received: by mail-lj1-f182.google.com with SMTP id s5-v6so37383158ljd.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 00:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netrounds-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oVrd3hGB8eOD/1WlKdXZjprlra+eH5eFFVfVm5XL6GQ=;
        b=C1vnXUeWurhsk1U/Aspwb+O9O3QIUnKFxf1mR3tfr1iBBAvjI7xiZ7f5gfFysTJqzk
         nWdbx6b/jWacIOOmx6SBRaasEiHf1wZHPdMm+2G+KVFiuR2H4lor01vnNACeqWeeZT2b
         EsRS9YI2KVEum6X0VqelpeSUfpWSvR5AD3QC70zTv3ZP+B61MAlmx301V07sgFehkJHO
         HiJ4wUiTZ/1dQ7fr9lCmoqV7Vhp4Tubcd4UIsrDzVr572uK7yf8rLlImSwzGjiRlU+Z5
         UOP/aoZXOCo3JF+sKF6tbbNzjfS17o+Sg+o805I8cH9Ui90LJWcjUN4tzg5/Ftd9cP0M
         5Wjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oVrd3hGB8eOD/1WlKdXZjprlra+eH5eFFVfVm5XL6GQ=;
        b=lxzZzB+ytJM9QMQmy/NZI6jWU/1RIiwQyFchKTjMaH4x2Zl8TDytTJLSwv4Mea8UXZ
         ajZ5kOM5iTir9I9urwJZ93zMsVngGrapWpC1Gy85vZa4srzXzgvJwuFGr9b8KQPSq0i0
         0XxG/3yLSZznWV64n5vpiJFJMhs9BIjqOnoW5nRpu/n2dLdQJ/Y2bWsP1Y9+KO1vNRtq
         hp1B5kkhjte+P1GD/vX8uzKTFeiqYcXhWiEE/BN29Z3Wtyscu0+Nh/SLnEdqhZApbWTa
         a5SEmFBU8FqzyWTLDce6H0WD6/++AnRljp9TtQs8LToyp6n5XtxWKudFq/EAGm2dJJon
         EPqw==
X-Gm-Message-State: AJcUukfrGj5NQ+maxv+Cg7ph0ktiDWVaJA81tUR2ub1VWyjzEmPGgKDk
        p0wUy3SEH0zTPUey8MaUz84T71E5hfc=
X-Google-Smtp-Source: ALg8bN5tWw/6Mdn8seoZdslzI7l21A0dyU8YHcd3tQTehcNh4sTOIcBEnjLLl07dZcKaDm08EhOeeA==
X-Received: by 2002:a2e:8945:: with SMTP id b5-v6mr5115281ljk.55.1546851269021;
        Mon, 07 Jan 2019 00:54:29 -0800 (PST)
Received: from [10.10.134.108] (31-186-192-122.static.chello.pl. [31.186.192.122])
        by smtp.gmail.com with ESMTPSA id s20sm12295071lfb.51.2019.01.07.00.54.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 00:54:28 -0800 (PST)
Subject: Re: PROBLEM: Old content of /proc/net after switching network
 namespace
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <4749d3bd-eac9-2a3e-aa93-d76d2e015945@netrounds.com>
 <20190104110933.GA2682@avx2>
From:   =?UTF-8?B?TWF0ZXVzeiBTdMSZcGllxYQ=?= 
        <mateusz.stepien@netrounds.com>
Message-ID: <165a35df-0a38-3507-fb8d-0f4b45af0dc3@netrounds.com>
Date:   Mon, 7 Jan 2019 09:54:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190104110933.GA2682@avx2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for the quick response, unfortunately the patch does not work, 
problem still persist.
I saw the other mail thread, and it looks like the proper solution 
described by Al will take some time. I don't know if we can afford right 
now to write a proper patch ourselves, also at least my understanding is 
that this is a regression, so my question is: can we expect a proper 
patch in a coming weeks? If not, will reverting the patch at fault have 
any more negative side effects? Of course it will bring back the 
behaviour it was supposed to fix, but are there any other issues?

Thanks,
Mateusz
