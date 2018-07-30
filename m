Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D65EFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D79C420881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cR6XsJHh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D79C420881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbeG3LlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 07:41:06 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:38175 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbeG3LlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 07:41:06 -0400
Received: by mail-wm0-f51.google.com with SMTP id t25-v6so13020366wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 03:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dBwsOlOmg91Py/yQ8w+Wp9haxWzdVMGe5s48XJg7mQI=;
        b=cR6XsJHhndMKg8IV7iCduFTGn9PxXW6oHK95TJPSECuoUM8QrNP0P2boxIk5QcTl2F
         coBrx10XuowNR/8qV0Xd22xS5G+33RVTgwxPDbAN0fGU5bSoJTM0vRRnNQkyGjRgy1Kf
         uFLkOzAL0Mxauof33aJfpkfVZEljeXNYgiVIFwgaxaXIgS+VY3nPCr0hXeovqfw5CxFV
         QbxlJd64oRhS7tF8GM9yMDJodncDbeKgwJsZohCjbni6TGQmX9yOYDEdT1VaolPHgKxZ
         SeTZXCSF0I8vJUC2s7bnJCOrbd+DFWU02rL4OIoOT6ZJ4tZqXmYzvQKfix8zn/Yglx68
         MXDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=dBwsOlOmg91Py/yQ8w+Wp9haxWzdVMGe5s48XJg7mQI=;
        b=moBrJHF/fkQ5Lxjh7nDvGIFwnbBhMo7rahRxcJ1c3mY+WKjahvsVO/YqTbNKNaDqED
         ZIfi07Xu6gaC9txotIUw+lRVutlzCLpNJ469VHQNRS/+wXFzo6Dhr44nxAqc9ppcDE04
         BnyCyL6qCEPqCf68oTnPjFDTaMob7lGUH8JINZWb62pIZxDvYbcU4O7zCdJubPAM5Dff
         GlHHPLtNujFspfMaUdJaACJekHz4IksInBWgsbfOHtsb/lzHi3VbeY3XeC2GXsg307SL
         7J57Mn2JazihuIVZg4Zk3NaEaaEB2IgcM6A4mnW1yYWhm3q+iO1XFC+nAEPiDm1FejjJ
         H3XQ==
X-Gm-Message-State: AOUpUlHxCRX5/pU6ccMeU2lCMULaYHgZUUKWZEJLMdfTUfIktFIkAj+a
        hWa44MXBPYAjgBh/kNKEYRg=
X-Google-Smtp-Source: AAOMgpdMn6K327Ig6jJdu4FPcm1ab9r6e9A/cbovHihDI3BonN03ZESgu4pXtz2+1rO9WOGZITZ8zA==
X-Received: by 2002:a1c:8f0e:: with SMTP id r14-v6mr6245112wmd.79.1532945211080;
        Mon, 30 Jul 2018 03:06:51 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id h5-v6sm13574297wrr.19.2018.07.30.03.06.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 03:06:50 -0700 (PDT)
Date:   Mon, 30 Jul 2018 12:06:48 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc:     kan.liang@linux.intel.com, kan.liang@intel.com, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, m.mizuma@jp.fujitsu.com
Subject: Re: [PATCH] [RESEND] perf/x86/intel/uncore: Fix the index of PCU.3
 Broadwell CPUs
Message-ID: <20180730100648.GA16689@gmail.com>
References: <20180710233158.21037-1-msys.mizuma@gmail.com>
 <20180715223444.GA16209@gmail.com>
 <7d97606b-67b6-4eb7-48ca-99250edc3fba@linux.intel.com>
 <376d5419-9ba5-ef5e-3089-f841fbb1772b@gmail.com>
 <55fd243f-7c3c-1a02-65d4-3fae3c540d50@linux.intel.com>
 <1677c9ca-a522-ae7e-6a1f-86c3767a35f8@gmail.com>
 <3aed5057-7328-90aa-3c35-7c143866aaf0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3aed5057-7328-90aa-3c35-7c143866aaf0@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Masayoshi Mizuma <msys.mizuma@gmail.com> wrote:

> Hi Ingo,
> 
> Is the following Kan's patch ready to merge...?

Looks good at first sight - but it was whitespace damaged here so I couldn't apply it.

Kan, mind re-sending it properly as a standalone patch, with Masayoshi's Reported-by, Debugged-by and Tested-by 
tags added?

Thanks,

	Ingo
