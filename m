Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4EDC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F287B2064E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="ywhtCYG8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F287B2064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbeH3A3d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 20:29:33 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33272 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbeH3A3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 20:29:33 -0400
Received: by mail-lf1-f67.google.com with SMTP id m26-v6so5384164lfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 13:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/MJjWbvOj2L4HxWUZlnnTfzFucXEwj266GUzdasv9CA=;
        b=ywhtCYG8+6P6ImAyC11hayVFvQuZ27eWo8hQwlWdHI/Uigvst6scGgkLH/Ps8EUYk3
         cSBAalB41hoofhHkZ4JbzBQql8GgBbx99v7KMF0yAU5Q0ksg9MgZ//6Vsg+oWN1Ql2LS
         QepzE81t2f86IyOAqSAyppCFjdugAu76WN+Ffit+kB2Y6/kUkE8MxiKmaMl2AcwJtETY
         /ZrjMl584zEeOiMlmHrIF37hX2iG5nm7ScHeMDPofW6S7XdykWCZIPWdkxRjR8UstzF4
         TKeF5H/BXvc4JI4YC3wjAzCWzrVnrgj3xiPAqU7KRPPMlE7qXoBfQfqJNF7/wHeWlGsW
         +t8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/MJjWbvOj2L4HxWUZlnnTfzFucXEwj266GUzdasv9CA=;
        b=HFhQBb9Hml8DMOuYCEQ/8q/oYQSSpJuaULunV69PNGjqil+sv0P1AHO7+GOKzqeG/s
         28M5xTn4o/AbJINi3DQfm/G2fqAwnh1sF0AzE+8XMUskqhT/6DS1rtqKSMIG/wCTR5Bt
         bSV7g+E6vKnSVVJNFG7zuDMujwAVzvoixBdiJsbj4vH2HaHVtipbSue+/1NcO15elxqO
         qmi+1XsU7RwdQ9LOyYWiVjSNWvs4FnnJeVfpaqhyJj1J9DOf4ZNWpqb9SN+v0P+Loyuq
         x4KtY9XGfcRrDr6KcVrjJH8mkS825sk+CYjXHDXEpq+cJNWQD12OEfPG8FKCrJMjCD7y
         nryg==
X-Gm-Message-State: APzg51AFCp3JBV2vfCv8aMQRjxNwUhPAlx5FcnUf6yy3gk9L7en6oB3q
        VfxmvgVe0vW3W/eyI7n8ttMd/Q==
X-Google-Smtp-Source: ANB0VdYIhwNaAU4DiVubgtHct0N9kjNFC2hzFGhnJxiwZh5+zZLHAdUATibrQ4o0IrAn33vBKjwNOA==
X-Received: by 2002:a19:cf05:: with SMTP id f5-v6mr5578429lfg.73.1535574658991;
        Wed, 29 Aug 2018 13:30:58 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.se.alltele.net. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id r63-v6sm899472lja.18.2018.08.29.13.30.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 13:30:57 -0700 (PDT)
Date:   Wed, 29 Aug 2018 11:51:45 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Nishanth Menon <nm@ti.com>, arm@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        t-kristo@ti.com
Subject: Re: [PATCH] arm64: defconfig: Enable TI's AM6 SoC platform
Message-ID: <20180829185145.gzjj3sfk2n5kqvu6@localhost>
References: <20180828004650.2184-1-nm@ti.com>
 <20180828162027.GO7523@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828162027.GO7523@atomide.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 09:20:27AM -0700, Tony Lindgren wrote:
> * Nishanth Menon <nm@ti.com> [180828 00:50]:
> > Enable K3 SoC platform for TI's AM6 SoC.
> > 
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> > ---
> > Ref: https://www.spinics.net/lists/arm-kernel/msg667805.html
> > 
> > Unfortunately, Kconfig changes did'nt hit v4.19-rc1 window.
> > So, as promised, patch based off v4.19-rc1 tag.
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

Applied to fixes. Thanks.


-Olof
