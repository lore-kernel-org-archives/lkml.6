Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E82C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 21:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D1C921B18
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 21:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FL3qqA/v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392161AbfBOVVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 16:21:34 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43880 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731095AbfBOVVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 16:21:32 -0500
Received: by mail-lj1-f194.google.com with SMTP id z20so8531569ljj.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 13:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9NUDVWDGlk+W64BIyrD3CDMgek7FDlDsRj/IyrCVw3o=;
        b=FL3qqA/vygB3WTglRdtp46GRjmk651nLFFWJzjcqm+ThvJqXLWULo9NT1DdxFSnNPT
         tg780nGibxnANqqNXrJ38gU56tCYugkl/aE2NHBDna7Hz5+OTqi4Ixwk99SEZWRby/Ml
         pFme5lJB89CQ+32aGryMx3NR4LO8zr3lOncA4GAqDNbkXy36C3TFz/bznbH1x4ej4JjV
         obpj5fecdsCnX+yt4GtU3+Ofvh20gTflmIuy1h/Dkx21krEZqH7wG/4t+3LL8Aw03TGy
         5I+Tli4uzQuogeameN1rmZQy6SgieERxVUZxjNYxxM8p2OsooGvokMr4wuAPeJCNBTMB
         HF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=9NUDVWDGlk+W64BIyrD3CDMgek7FDlDsRj/IyrCVw3o=;
        b=nVZFZL5zPW9YFiCcm9BoKqnZprvPUEWlA8+aMUGfmw+1pELmmUuANniKMcgJKQ1iKh
         s/oHleq8oIrVzzN2F7UINdVaGnTddIwTgYrgeLL4hNcxXpaxrzZZZXOE9zLyrkGnLDlE
         cU4Fwqg9/CyUj/Jylb6yzKG6jKf7+7JUvdaqQU76jb3z25yUYXA/7u9HpkxVM2NwCfVE
         3S7k7497kJ7nd90Eudo40k8ao/5Ltp4ehneUSp3PUkwU2IDavKz2oYTo1i2f6cmz26+p
         UYqvEYo21db05hXs2r2VM3FJPV8iCX/3L4viYa1lYi2nAsXUNKdCDTFA662NmeSRlFcc
         ewMw==
X-Gm-Message-State: AHQUAuYS9GotWPY/oQJX5WXIIO6ZTjvQegnvoA7NxyD3eiNZDDZVF2Ns
        xED4dS31DXXZmuiTwmQo7Ks=
X-Google-Smtp-Source: AHgI3IbM8tXxlueWqeQ/oJBypD2aClR8lU14oxRFGVl7AwLo5FjNI2j1T0GmVkkKLbU6HuujJrW9Bw==
X-Received: by 2002:a2e:9c52:: with SMTP id t18-v6mr6800971ljj.149.1550265690646;
        Fri, 15 Feb 2019 13:21:30 -0800 (PST)
Received: from mobilestation ([83.220.237.45])
        by smtp.gmail.com with ESMTPSA id e98-v6sm1897566lji.81.2019.02.15.13.21.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 15 Feb 2019 13:21:29 -0800 (PST)
Date:   Sat, 16 Feb 2019 00:21:26 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     "Mehta, Sanju" <Sanju.Mehta@amd.com>
Cc:     "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "jdmason@kudzu.us" <jdmason@kudzu.us>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "allenbh@gmail.com" <allenbh@gmail.com>,
        "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] bug fixes in ntb_hw_amd and ntb_perf
Message-ID: <20190215212123.mqne3sjy2rrngiij@mobilestation>
Mail-Followup-To: Serge Semin <fancer.lancer@gmail.com>,
        "Mehta, Sanju" <Sanju.Mehta@amd.com>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "jdmason@kudzu.us" <jdmason@kudzu.us>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "allenbh@gmail.com" <allenbh@gmail.com>,
        "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1550222224-26475-1-git-send-email-Sanju.Mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550222224-26475-1-git-send-email-Sanju.Mehta@amd.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 09:17:51AM +0000, Mehta, Sanju wrote:
> From: Sanjay R Mehta <sanju.mehta@amd.com>
> 
> Add bug fix for ntb_perf and ntb_hw_amd
> 
> Sanjay R Mehta (4):
>   NTB: ntb_perf: Increased the number of message retries to 1000
>   NTB: ntb_perf: Disable NTB link after clearing peer XLAT registers
>   NTB: ntb_perf: Clear stale values in doorbell and command SPAD
>     register
>   NTB: ntb_hw_amd: set peer limit register
> 
>  drivers/ntb/hw/amd/ntb_hw_amd.c |  8 ++++----
>  drivers/ntb/test/ntb_perf.c     | 14 +++++++++++---
>  2 files changed, 15 insertions(+), 7 deletions(-)
> 

Thanks for the fixes.

Acked-by: Serge Semin <fancer.lancer@gmail.com>

> -- 
> 2.7.4
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/1550222224-26475-1-git-send-email-Sanju.Mehta%40amd.com.
> For more options, visit https://groups.google.com/d/optout.
