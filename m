Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FCBECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 17:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E54EA2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 17:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pHizfILV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E54EA2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbeJ0CYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 22:24:41 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45448 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbeJ0CYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 22:24:41 -0400
Received: by mail-ed1-f65.google.com with SMTP id t10-v6so1995107eds.12;
        Fri, 26 Oct 2018 10:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=If/IGptPHzILpFx3PL9PXPUun8Jex1Kxx4Z0rpFyb2Y=;
        b=pHizfILVGF5evrQgQ6GArOnl2BdWTTT0dqXZTnKsiX6s6/NvUyyvgkdv0Cu5nSWtyo
         x4xGhqp0+j8VyFSZxU64bFHZCSPJEkKkeUiIWp2+YJkKux++wtMfUBAur92I9HdwkOds
         E5phvYMSzCY/vsBmXE2U6JGZGmWpVqp6ahU4eM1KGY3O05THYpp2WZGnjzLna9/OZESW
         1oyA+guqbmzqiidql3TBUxJy2kWeqJAP5PY1pp8tsDXZ6WnCJ23vG2oPff/YWKy5LIsS
         ds+eP4UbhvdxxgINeDf/M6aqqjE+YEM5A3SNjzBvnzKCfEuwjFnIZsjvFYN8tZulfZaK
         nNdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=If/IGptPHzILpFx3PL9PXPUun8Jex1Kxx4Z0rpFyb2Y=;
        b=fLX0WEV928uV7WnRn9ar3icftqGzmCjOuvgJ5MWAIBz0pBSkq/hbw1TxieEr0t+FvY
         SDng3hcL6O60qlYLw4pgBmPoyz/nAIR0a0UAXDSeXxN8Zgi1KbhWbvUywxIQU33HbW8v
         Do79X99xpV2/epxu872FzGDbh5KiLIAGM/J6hsBF8tziDTa2y1eFM/JcVpch6lPdAfoQ
         gQc7Erxqug3/WYBqramI8c1QnPTODFMZPwJoW+tetTyNPKI1k4zlXUluAGiCHqMTqLqX
         CPEXba3esvOJZDnmVgoJ/z4S+QM16ofDAqZy1cvxjhFQOaoV8qhDX7KGR4VZrY84VZyH
         dNZw==
X-Gm-Message-State: AGRZ1gIHCAxlo5cuBuS1uzfOnIVZZ3S76uBRY2KkJmg9gj0DFcxcRHAN
        MdLnZVYqSV/+QmGZTKzpDzY=
X-Google-Smtp-Source: AJdET5db2MkgAXyyw4vLPVEAZ4TTxJQod2XwkMYJ8OiohFEG4BBbsQSESMl7sam7riiKnyreubdfhw==
X-Received: by 2002:a05:6402:168f:: with SMTP id a15mr3763841edv.135.1540576004362;
        Fri, 26 Oct 2018 10:46:44 -0700 (PDT)
Received: from dell.be.48ers.dk ([84.198.244.197])
        by smtp.gmail.com with ESMTPSA id i25-v6sm1221227ejd.19.2018.10.26.10.46.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Oct 2018 10:46:42 -0700 (PDT)
Received: from peko by dell.be.48ers.dk with local (Exim 4.89)
        (envelope-from <peter@korsgaard.com>)
        id 1gG6C2-00074J-1D; Fri, 26 Oct 2018 19:46:42 +0200
From:   Peter Korsgaard <peter@korsgaard.com>
To:     Federico Vaga <federico.vaga@cern.ch>
Cc:     Peter Korsgaard <jacmet@sunsite.dk>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] i2c:ocores: stop transfer on timeout
References: <20180625161303.7991-1-federico.vaga@cern.ch>
        <20180625161303.7991-2-federico.vaga@cern.ch>
        <CACXmVia0vStmBwd4ndFk6UjE9wGsjp7Y75ej0AGq68H8-XkZqw@mail.gmail.com>
        <1549360.saVjYH78Bt@pcbe13614>
Date:   Fri, 26 Oct 2018 19:46:41 +0200
In-Reply-To: <1549360.saVjYH78Bt@pcbe13614> (Federico Vaga's message of "Wed,
        24 Oct 2018 16:51:04 +0200")
Message-ID: <87sh0s38ji.fsf@dell.be.48ers.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Federico" == Federico Vaga <federico.vaga@cern.ch> writes:

Hi,

 > I had another look at the HDL code and apparently my assumption was wrong, and 
 > STOP just do stop, and IACK is still necessary.

 > So, yes, without try is better because we save an extra, useless, IRQ call

Ok, great!

-- 
Bye, Peter Korsgaard
