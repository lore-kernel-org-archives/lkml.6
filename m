Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58BC4C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 22:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECCBD2081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 22:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vbODep+/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECCBD2081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbeKCHx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 03:53:58 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42387 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbeKCHx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 03:53:58 -0400
Received: by mail-pl1-f194.google.com with SMTP id t6-v6so1620706plo.9;
        Fri, 02 Nov 2018 15:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vmZuz33/dyuoV2bzCRh84zxgo/juP4z2WL4+JG+2dSk=;
        b=vbODep+/t8GRK4psKZrpEjWL/zrUY/nlfsT/TXRtbOyW4xuCPDiQgA+ZEXGY9bSnR4
         ES4oV2sHRQ7Vw/OLPb57gSEhNneu6eMIFFYdx7AjxrYGZ2IfI03HhbSc877/qdwqqXlr
         UTGTL1/vsDdDLCsnuWkwtII3O7bQzMBeV1oy/6i76/VYQmGGeJQMV3aQTnxRpUOsO6Iv
         ISjHw5W1BT/kQ3WEyVQHiSd0UJJp2EO4vW+iR1zWfAfhu5YDFl+3dx9t5gLFJRREo3Tx
         WqcFDy3JSXUkZ75MEws8F54fsq5LKZTRzYjQX/pN99Y+XwSU7lAsrtqFNwm0J0MOwvwF
         oQUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=vmZuz33/dyuoV2bzCRh84zxgo/juP4z2WL4+JG+2dSk=;
        b=cPYU6JnYdHJJS6/7Do35Wb1ltr7JPeIgE4ktCbUkmvvVDsU0NXVRGnIivBKkBUS4Lk
         MdJmoRDdojJMTmewgJbIivNWC01KSBtiybQ/uymJwnqkB0/nLdRUUXbTx/j1+k3J62yS
         0tIyX5BBTsm6ZVRu1kkPJ7dSo4WrVZ63+ap52pyPn18vgjb3UfJBYMADOZQwuAakEa82
         hQiDHzcjTIv3y6pM4LLk1Wif2jivNIpUJxpbTlPzEFpCnPO80AG5JrimiTiP+2v/53m0
         uy20NpqRTFpikcU4iui38rpYazZe4ZMyr/Kw9mgdg9Q4hFyVwGv5iUCHbVU3f5BLeeEd
         yQIQ==
X-Gm-Message-State: AGRZ1gIjW5nq47sILiSq1VeZhsIfALC9KlgImdbkDLePFpEvnUnLf+0A
        M2b3SfV+aZAPtCfkX2sCL5l7/GjD
X-Google-Smtp-Source: AJdET5fFGJHGwR33AcGr59JX1yblijjQiPi1spoCyIa3oJ25BozvNiy5Vu8IgBwgPBgwO1b+sfGpBA==
X-Received: by 2002:a17:902:4623:: with SMTP id o32-v6mr13281186pld.187.1541198697164;
        Fri, 02 Nov 2018 15:44:57 -0700 (PDT)
Received: from dell5510 ([62.201.25.198])
        by smtp.gmail.com with ESMTPSA id k72-v6sm76470585pfj.63.2018.11.02.15.44.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 15:44:56 -0700 (PDT)
Date:   Fri, 2 Nov 2018 23:44:51 +0100
From:   Petr Vorel <petr.vorel@gmail.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kbuild@vger.kernel.org, Nasser <afshin.nasser@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kconfig: merge_config: avoid false positive matches from
 comment lines
Message-ID: <20181102224450.GA11633@dell5510>
Reply-To: Petr Vorel <petr.vorel@gmail.com>
References: <1541145151-7319-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541145151-7319-1-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

> The current SED_CONFIG_EXP could match to comment lines in config
> fragment files, especially when CONFIG_PREFIX_ is empty. For example,
> Buildroot uses empty prefixing; starting symbols with BR2_ is just
> convention.

> Make the sed expression more robust against false positives from
> comment lines. The new sed expression matches to config options
> followed by '=' or ' is not set'.

> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
Reviewed-by: Petr Vorel <petr.vorel@gmail.com>

> -SED_CONFIG_EXP="s/^\(# \)\{0,1\}\(${CONFIG_PREFIX}[a-zA-Z0-9_]*\)[= ].*/\2/p"
> +SED_CONFIG_EXP="s/^\(# \)\{0,1\}\(${CONFIG_PREFIX}[a-zA-Z0-9_]*\)\(=.*\| is not set$\)/\2/p"

Good idea, thanks!


Kind regards,
Petr
