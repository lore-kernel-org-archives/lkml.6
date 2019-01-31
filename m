Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C40C282D7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 01:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5EF820989
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 01:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="j2K3tzNz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbfAaBvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 20:51:46 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46941 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfAaBvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 20:51:46 -0500
Received: by mail-qk1-f194.google.com with SMTP id q1so977762qkf.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 17:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/XwVO1Pn4RUkxVrCsGWlYM4V0DkVklmqW2WuVnHNo4Y=;
        b=j2K3tzNzpH5dFF+OW1Pb7a1RCZNblqzHpKvMiopFTgIDusG7rl46NmFLLt9lc248c7
         YQGm6nDyekbf1IF34ijUz3Nuw/NIOjtOlMGmSdzHQ8+JM28jZFpFXgWza7DzQyWd8gDB
         UFWv+NLsfcqu1YGA/xF31VScqVc+IO+6TcJAu7aA6LEI35AkOUWgFrsekvcwE4HR6Cnu
         iy6/zX/jJilmotygkFxg16TSujAzvBJJwVXvp8b3VHlowyr7DS1RFe50+akGEqg5OuGB
         yLuNRb3JYEsXNlzAfUEdWKEtf2s4XB++v0UXj6BhlCks9UMgTEiHI6v0p99arR2hQaJV
         u6OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/XwVO1Pn4RUkxVrCsGWlYM4V0DkVklmqW2WuVnHNo4Y=;
        b=uYYihG7O2dbRydpqBy3dlwyjrX8PpUQB6w9nSwuBsuoVRHM/A4PAYudK+WD7BQ0ms7
         vOHQiYN+08dRXoKc2COp4bx661zcyUswSET9nt5gGC2poZ0mC/7tdVS4R2EPYTKwX0Zk
         wRfwTtffOdIISTD3fILx22r3PGv8z94TywAShXuiPa/E1JBt6n6MZ9rakKtPHj8I9ep+
         FqUnTTn49b1ulLo03T1R1Efb8Nt+C1nPnq4CTXHdoy0xsIZiPKq/nm+OySi+j5hZ6tTM
         aUDxJLpgSANJJjf6pakzM6rhBlNxeCt6s/tEa5Zs+FKs8oI+zU0DZIsHo4WM5He3ZFnb
         /5Hw==
X-Gm-Message-State: AJcUukfqNeoEqjcE+YCrIvxtia/81fjmG5lP0notvVQ17UX1ZQX0hSei
        vQfGbIVVRamDyFbeKYLsiXDiHg==
X-Google-Smtp-Source: ALg8bN5fIHvGfSv4W4I8MSfN8zo9WFq3gcqUYso5l7kaDeSn7dlJ3p5jLwhBs4/xPZCOc2EnKFSGCg==
X-Received: by 2002:a37:6801:: with SMTP id d1mr28986124qkc.283.1548899505038;
        Wed, 30 Jan 2019 17:51:45 -0800 (PST)
Received: from ovpn-120-54.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 12sm6726227qka.83.2019.01.30.17.51.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 17:51:44 -0800 (PST)
Subject: Re: linux-next: Fixes tags needs some work in the akpm-current tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Liviu Dudau <liviu@dudau.co.uk>
References: <20190131110541.3f3a808c@canb.auug.org.au>
From:   Qian Cai <cai@lca.pw>
Message-ID: <6d110fc4-85b6-cf66-6045-dc81956ffc5c@lca.pw>
Date:   Wed, 30 Jan 2019 20:51:42 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190131110541.3f3a808c@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/30/19 7:05 PM, Stephen Rothwell wrote:
> In commit
> 
>   6e9ed490d190 ("mm/page_owner: fix for deferred struct page init")
> 
> Fixes tag
> 
>   Fixes: fe53ca54270 ("mm: use early_pfn_to_nid in page_ext_init")
> 
> has these problem(s):
> 
>   - SHA1 should be at least 12 digits long
>     Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
>     or later) just making sure it is not set (or set to "auto").
> 

I think it is better to replace with this version instead,

https://lore.kernel.org/lkml/20190115202812.75820-1-cai@lca.pw/
