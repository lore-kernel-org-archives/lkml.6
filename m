Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B66C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 09:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1C91208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 09:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSkH9rTQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1C91208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbeJEQxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 12:53:30 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:45173 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727601AbeJEQxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 12:53:30 -0400
Received: by mail-wr1-f45.google.com with SMTP id q5-v6so12875179wrw.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 02:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zZLs9hLYt2mcuDCBb9Onr1UcMhmEpke4iTIF2Y0nvIA=;
        b=hSkH9rTQ5ga2y9jDKBfVUFEfCUL4SI9RcbvN8xGSdueYzypVUW6rWv/PiqX3KjJEol
         FqKsBK1NR3I80lBj2BOF1rjKohcW+PO23PBAxlVqGNL/Hm1R4wraKgG6usNAIA/JijTC
         VN9XL77tHxNFa3TdmaIC+PY7GUsgtPVyj6AfFfNynbfZ2rW3ubR7o4f0f3dpsOpLLY3B
         KT60HJR1J26WW6+D2VapmXsMeQFeVAdUlp1Bz9i04u8sC1jl5oZ62OTP3+3bF/C3cTCt
         9TTMgDIcx2Fs1S/zqkBEhsTmnD52O1UXQVQzDY1J46FoOjGBSN/P4sFNiNsaF8JA6THY
         52sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=zZLs9hLYt2mcuDCBb9Onr1UcMhmEpke4iTIF2Y0nvIA=;
        b=CySURIPnRnZJZkjctwGt/BVKJIGkLOfo4/yeT+STn+jwoLV8l2pOzKpWICM4z5VQrj
         oZsrM8Rb6FjjnqdtsZWrrDO+lDXjkSomTwlFe/HCsi8umRwcNkpQoe0TpTN6h0Fu6N7v
         a+V0DI70PBygqLGbwMbVOnTl/3AHQrvnu0ESvV3RxiHs23zT3WBjDGtYBeffIrSZNnej
         pwE8Rype1XWHoeti+OW6pB2Dy1n88fOrYUZ3saQh18X8ezVJIuiXz6g3KNuWgNsvvXxS
         WLqxoa9yXmb6h0nOzMhKOQfDKcGMtalz83RnzQDBNc7auDzAHPBmb040wR7paN1m5yU+
         YQPg==
X-Gm-Message-State: ABuFfoixfHg4IfFnPWVvTXsFxVEyZXP6srbL+ckGHysSa8bqOcYGD/jD
        WUrqjPO4yr8vvwEdJYAS8JA=
X-Google-Smtp-Source: ACcGV60ZWac9WbPaD7IClsvThte+Dp6RA6EeB9eyyJJUW8kjxsyKCw7DVkQMGOb60wfg/gTJCq3xuw==
X-Received: by 2002:adf:a781:: with SMTP id j1-v6mr5080945wrc.277.1538733327476;
        Fri, 05 Oct 2018 02:55:27 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id b1-v6sm4244838wrt.43.2018.10.05.02.55.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 02:55:26 -0700 (PDT)
Date:   Fri, 5 Oct 2018 11:55:24 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] perf fixes
Message-ID: <20181005095524.GA128006@gmail.com>
References: <20181005094211.GA52891@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005094211.GA52891@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> Linus,

... and Greg as well!! ;-)

Thanks,

	Ingo

ps. script fixed.
