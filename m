Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E37BEC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE462147C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="Y7JEBOXE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EE462147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732501AbeGLOP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 10:15:29 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:42051 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbeGLOP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 10:15:29 -0400
Received: by mail-pf0-f196.google.com with SMTP id l9-v6so9028098pff.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 07:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=olIhscENtRFNw7nxBXVbUkwqx8whA3Oz+bbnAxZqcPc=;
        b=Y7JEBOXEQYqiawFTbkbuVpMVEyByW27fVLNJoUYeFTiZeEe2rk6NfogScqVfpoVjxK
         zgu1OmhQJu84PW1N+VAWr38YFO7Mg8A0OkxTxXpPy6aTkhWYDxAGpFc/LtZ7a0AUcf6M
         Y0F3n8Y59E37KpYvpYZdk5KRdQ+s2/HpyNJqJNLne5cntWGkOptkCQXtti0Db/JYENiL
         6sDkSxx32FuMDBZb+dZzjLlBQG/7mknF/sLwTmdr0fToKHNj5H+ESrKFRzo7aznHoUNl
         qU5vuAZkiFoRpptjM6c7gMQU0s8MWUFtyPaxnv09lsiao4DPnZXbt7W2Mj5fHaVDYol8
         aJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=olIhscENtRFNw7nxBXVbUkwqx8whA3Oz+bbnAxZqcPc=;
        b=hbkgD2Eei7h5daf9u3mmJ3qKDTbRbLZiUnjFjXZWEvruPmhLut9sMF1u3hqBaFy6a4
         EXQ/3JUtKQF1gxyTytF9XOBP1+bk6O6lDzgNG5w12Hd2P7yaev1S8kWPg8E9mXfNVRxD
         4j2t51NaJ75v+u/MToj4GGmAC/dvUJdxcq+/T9mxyWEci79lFr9fUn7L+x3CPy8v4+7s
         DFDBKkw4YtA7/VwLVuC15pcWVW4OBJQWZ7zTPJfE2igKk8cWB9T3KtV8K5DDEEn5bUlT
         haq5nDj2SIK3z/cuQBY0wzucCUknqbgKx8ZFlRzRUFlrWueBeqldPXb0nnn+50ISpaHn
         Kntw==
X-Gm-Message-State: AOUpUlFG6uSDFrO6bYXl1z8vIYnCZ+abFaOAo7579QY4/3iic1BInFoV
        zqehVSTf8CzCFco0gkuUZVOisg==
X-Google-Smtp-Source: AAOMgpcd9B9niHrTJWizMS2m0vEN+aHMtd57IAqZpUVSxprIHBl157E9/jN61q4DV02PrLRrG6XmFQ==
X-Received: by 2002:a62:8a83:: with SMTP id o3-v6mr2625010pfk.12.1531404345579;
        Thu, 12 Jul 2018 07:05:45 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain (fmdmzpr04-ext.fm.intel.com. [192.55.54.39])
        by smtp.gmail.com with ESMTPSA id 84-v6sm38930361pfj.33.2018.07.12.07.05.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 07:05:44 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 37C0630029E; Thu, 12 Jul 2018 17:05:40 +0300 (+03)
Date:   Thu, 12 Jul 2018 17:05:40 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kbuild@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        x86@kernel.org, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Russell King <rmk+kernel@armlinux.org.uk>,
        openrisc@lists.librecores.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, Jeff Dike <jdike@addtoit.com>
Subject: Re: [PATCH 0/6] kbuild: clean-up and rename LDFLAGS to KBUILD_LDFLAGS
Message-ID: <20180712140539.4b5xdraq34i5dbii@kshutemo-mobl1>
References: <1531382496-3719-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531382496-3719-1-git-send-email-yamada.masahiro@socionext.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 05:01:30PM +0900, Masahiro Yamada wrote:
> 
> This series renames LDFLAGS to KBUILD_LDFLAGS
> after some Makefile cleanups.
> 
> Currently, the last patch does not apply to Linus' tree
> due to missing pre-requisite patches.
> 
> I will resolve conflicts as needed.
> 
> 
> 
> Masahiro Yamada (6):
>   um: remove redundant 'export LDFLAGS' in arch/x86/Makefile.um
>   ARM: vfp: clean-up arch/arm/vfp/Makefile
>   kbuild: remove redundant LDFLAGS clearing in arch/*/Makefile
>   kbuild: replace $(LDFLAGS) $(ldflags-y) with $(ld_flags)
>   kbuild: change ld_flags to contain LDFLAGS_$(@F)
>   kbuild: rename LDFLAGS to KBUILD_LDFLAGS

Thanks! Looks sane to me

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
