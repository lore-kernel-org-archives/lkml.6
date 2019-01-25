Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2907C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 19:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96834218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 19:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548445507;
	bh=Kl6CpE7je6XsPgyneluwNb85V6L1KTSWO092lJEYEgU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=io+l7oVwwFQODvS7coZcz28mPb50xm3SdXL8QNzWinsX08+ec6+oanpDbluJJAxNt
	 C+w15F2iuxyewymyNRMt82LtSWHOFBC+1lJNaoD2k7x1e3VK3kKusDGP/cdO/uWuAL
	 aw021A52TRUdHD+qBKRv95kMOzfBVj4oxZKRuk+k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfAYTpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 14:45:06 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33661 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfAYTpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 14:45:05 -0500
Received: by mail-wr1-f67.google.com with SMTP id p7so11589537wru.0;
        Fri, 25 Jan 2019 11:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JmdXWPZhzyH5PZx96mF9B7z3C7elnoOo/xc9usySFHE=;
        b=U4NRNLf+qQpqc1jcos061ZSKEO6Ax1d8t5bHKFhnWrm7lD6Xrz340opNwOj8BouELM
         PDf5dbKczoXv5WhjpX6JmT0Ox1pJWkMgd6JOKvmJnGHs4nB9i+zDc3DYQgZlCTYur69f
         NnQXaFPV4e+6wMml3ru6gtlqHovBcQCgGkEwennzpNofUE/gsZ6Eeuzy3XqXCY9Wsdq3
         j1eDnadCKplY7/Zu5KUYdo0vNnMOBski7/adUQNYKUQSLr2xXe+TJ+YOjVayCoDb43+0
         UTyCMz9rXyvcx4idI50TczM5S5tSU0p5PmnuPs5frHsvHyKF3ccWpPfOcij4Di6tSuZh
         zmdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=JmdXWPZhzyH5PZx96mF9B7z3C7elnoOo/xc9usySFHE=;
        b=XxTMhm9nRuINGeMm8AgwAH4EPpD/aAmkSTN6k4XkGGQBDnNgNwdpV54XgJC8+hpagm
         VZb4OJXRTLUcACJK+ZkMqCvSlzwvIyAMOtHUCAr6qsP9GyYnKjtvF9AaB51aWLvw2ZgC
         glUyWLsKR5pZIyWnCjHXRzaOjE+DUmfeguKhbEPdCVaXiOUEjXdaGd3GL/1H9/tuJsOa
         O6G+Ug1hsneLLLxrFfmqTyemHlj8eMaM1SPnzcicedMSGXw4S5nTTEPTn8jlNSGtOc6o
         epBrSUChnIp7oKsYR1FV9ex9H7sQgaLb3b8sV+GmlAsQyzSxt3y+FZXI70taTcy9Wmci
         Gt8Q==
X-Gm-Message-State: AJcUukc47vJPMo2ia3M2wegpMZLsLStcQF1D6Sf/7c89bhPT5NsF2Qks
        SjvtumKLP1eTQgTcSYdneu7zrPT7
X-Google-Smtp-Source: ALg8bN5YSYIhsNZFAn7/k5ImOIgH8aHDWSAjTCIzZyVMDreU4Y9ujipHv2cOYUrcd6/l0Cl5WOM1jg==
X-Received: by 2002:adf:cc91:: with SMTP id p17mr12989557wrj.118.1548445503704;
        Fri, 25 Jan 2019 11:45:03 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id p5sm34481621wmh.16.2019.01.25.11.45.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 11:45:02 -0800 (PST)
Date:   Fri, 25 Jan 2019 20:45:00 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>
Subject: Re: [PATCH] RAS: Add a MAINTAINERS entry
Message-ID: <20190125194500.GA34849@gmail.com>
References: <20190125174227.10652-1-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190125174227.10652-1-bp@alien8.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Borislav Petkov <bp@alien8.de> wrote:

> From: Borislav Petkov <bp@suse.de>
> 
> This was long overdue and it is needed at least so that Tony and I get
> CCed on patches.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Acked-by: Tony Luck <tony.luck@intel.com>

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
