Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7440C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 02:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58113259A6
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 02:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5HkMCn5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58113259A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932122AbeF1CF0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 22:05:26 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:44964 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752257AbeF1CFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 22:05:24 -0400
Received: by mail-pf0-f195.google.com with SMTP id j3-v6so1823730pfh.11;
        Wed, 27 Jun 2018 19:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KY4fKmKbMml2ykIN6H+ZZu9s3xL/zIb+xn0usWTnCp0=;
        b=Q5HkMCn5L51X18IMAqlCNc7ri87k0EYhKOHZRuZiiVg5Bs/Jsst55ZsxZT9OBd9pJE
         8a8llvSc1VYmjfGlnOavC2JvgCQLiHmorwLyzy6WUxBmlJKfwXHEuO1Gj8jGXNjea57E
         Wgj/EIy+JsxpJwzAiyNAuFBBUKmNEeYQ/3O2rYsP9/yaUULt3grue5nh/l9CrhOsYL/j
         /fIg1vlqrmRGMv3Vvq4/d7GuDUBSzvR/3J8cs2DCc3I2NSJawmTd5Zbp9v/rWS+9X08y
         lLavglJSmpnf0gEzTDoJ0c3E95R9nhmMcOFJrFADVuW0NOepKwjrslgswBQwmDuSmHou
         Kb3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KY4fKmKbMml2ykIN6H+ZZu9s3xL/zIb+xn0usWTnCp0=;
        b=ekP770QTVyShFNAR4rr9YWvmWPgVW6bKod1wUj5Phr8c0QfR49dETysO1mXLLT7IuM
         rzOMSnMN7Aoh6mS14EzbhQBPMB5ADledFqqoNW0uZpatFioLwHPGinAU6Pg1+CaWHvyB
         bQjwvMJ/RJWPwu/ZC42tK2SpWnZ0Yqld5ht1nGWtWcGIAgZRMI3gMif7k4PTb6p8TexN
         dUyNbqm8vZMKbd7Ov4sbuJR+V6W/MGvRqlAn8z42rjBSK92APk/MoE8YljAV28VDO1o0
         9PdhOOfhnp1BpYa8dngG14Zcrs6gPkWdD4mc/OmHwWAPMxEwlRpbAaKHI/zTEzwm6dxL
         98ag==
X-Gm-Message-State: APt69E26rhv3ftabZYMn9U3LfcqxYBITWgq8C2ni3BhhDAgX+BJ0k1P2
        be6ogB/2mxMYiHdjhbvsi7U=
X-Google-Smtp-Source: AAOMgpeTQv3r3bhntoV5sUtCaVIO8rt/p6olBHLBQ2KUVyszkzVKHYD9pVDvRV7lvaSU/qZK7VaejA==
X-Received: by 2002:a62:e03:: with SMTP id w3-v6mr8195415pfi.173.1530151523696;
        Wed, 27 Jun 2018 19:05:23 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::1:d9d0])
        by smtp.gmail.com with ESMTPSA id h12-v6sm7715227pfi.114.2018.06.27.19.05.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 19:05:22 -0700 (PDT)
Date:   Wed, 27 Jun 2018 19:05:21 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Matteo Croce <mcroce@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kbuild@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [RESEND PATCH] bpfilter: check compiler capability in Kconfig
Message-ID: <20180628020519.txhrgq627cnhqspe@ast-mbp.dhcp.thefacebook.com>
References: <1529985336-27522-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529985336-27522-1-git-send-email-yamada.masahiro@socionext.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 12:55:35PM +0900, Masahiro Yamada wrote:
> With the brand-new syntax extension of Kconfig, we can directly
> check the compiler capability in the configuration phase.
> 
> If the cc-can-link.sh fails, the BPFILTER_UMH is automatically
> hidden by the dependency.
> 
> I also deleted 'default n', which is no-op.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

I haven't tested it yet, but looks good to me as well.
Thank you for the follow up.
Acked-by: Alexei Starovoitov <ast@kernel.org>

