Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1424822-1525298399-2-6189067974972718001
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525298398; b=HSEEgoJEBwzbfhJuqGBj/DasHkJ7zU/3NGBohDECtq/W8wJSGt
    M6/3m+Lgp80MJsYAsS8Vsq3Z1CD2wqW8cbS5amXBGs2du2UgWUqb4jexjltqXOZh
    vXxDCISFmUiCDSx/BmYV7wy8nqZRmikUCJK5LSTh3+Dm+QPQ1p4cbo77AMziVSa4
    XU373Tnd1v8BquucPMorI3O0gND1xYKzQ3/e4y6BiIQJPmM3566ilWu6XwzkjXTZ
    QljDv+DozQb5AYdUiVDm+4r2xoHshvFsar/Alj7AGhcAOXAWJNcA0MuNyTps/6+H
    ibWPwnqaIpC0aiBWwbthbDYXAeJ1bvG4+tKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525298398; bh=ly7X564v5cEJEM4wap/JjJ8EifKDiI
    MwEMjh4ccUHMw=; b=BILxbCqlnilTZ/nCgBbek1u1PAXa+A/o8qokQRnnLJtRhs
    uOC0Kk1Jn5uE2A36EVoNZY5J17KDyWiCxGu48YefL14FR4NCTWEz+0VBFuLbb0uo
    UIZ0bUkT/gqkEYil24tw9PrQWayAyozxRhqIAHFEvlF0Ood7K76milQvzOYYzDIi
    hXCEjDyae8VZHs8dGwkN3n/LXDNjfj3c+yuEaJH+qfmnZN3E2snIC5pwrt4/d+ke
    J/4o/zAEsJBvhfLUKaNzsaZo6fAdq69bWn5uhI5qjfXLXJII77xoneOf2yd4vTV6
    HyEAyb1e3AWjoM1kvHELbBP6xxJRImApvG1uxwmw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
    header.i=@gmail.com header.b=diMflFDS x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=F1BvyviY;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
      header.i=@gmail.com header.b=diMflFDS x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=F1BvyviY;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNdCuTPZJjjb9Qolcz/t9+2NZHd3WmhlR484L5AtzVRkJ/XMohmAmY7E/dWgf8M6djYnyl0TSdvtTSqxjhtksGtLizLucXy3eeHpq1+ugYYrEGV18G4Z
    5Ss4cH4qLgD5V/tN7WGY0YaD6VyZ1tYGY+1MOk+1Pv28SP8+9eP5/NxAhatE6kuC8gvOlmrskvlmTzWkDVZ8xsddT4P9fPreBJNbZkhgg7TCzm7UFUvyx4Cy
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=zLncjWLdyN0A:10 a=VUJBJC2UJ8kA:10 a=OLL_FvSJAAAA:8 a=VwQbUJbxAAAA:8
    a=Su8_OrzxtfAo5s6NOz8A:9 a=CjuIK1q_8ugA:10 a=haRAhhrbeAoA:10 a=F5WLKBdkEQcA:10
    a=oIrB72frpwYPwTMnlWqB:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751261AbeEBV74 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 17:59:56 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:36134 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751045AbeEBV7z (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 2 May 2018 17:59:55 -0400
X-Google-Smtp-Source: AB8JxZqN3TWG8idCAe6q6xttRKbDH5/eNkbdwif0i4NMiRYpt7gqCyH+ZrtAiB1E1E3Mgj5fGrJAag==
Date: Wed, 2 May 2018 22:59:50 +0100
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] libata: blacklist Micron SSD
Message-ID: <20180502215950.GA4621@sudip-laptop>
References: <20180429160138.11091-1-sudip.mukherjee@codethink.co.uk>
 <yq1r2mw83cu.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1r2mw83cu.fsf@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Martin,

On Mon, Apr 30, 2018 at 11:24:49PM -0400, Martin K. Petersen wrote:
> 
> Sudip,
> 
> > v1: Only M500IT MU01 was blacklisted.
> >
> > v2: Whitelist M500IT BG02 and M500DC and then blacklist all other Micron. 
> 
> I think my preference would be to blacklist M500IT with the MU01
> firmware (which Micron said was affected) and rely on the "Micron*"
> fallthrough further down for the rest.

This patch was based on your reply at:
https://www.spinics.net/lists/linux-ide/msg55370.html

> 
> I have not gotten firm confirmation on ZRAT behavior so for now we
> should probably just do:
> 
> + { "Micron_M500IT_*", "MU01",	ATA_HORKAGE_NO_NCQ_TRIM, },

My v1 patch had only MU01 with ATA_HORKAGE_NO_NCQ_TRIM and
ATA_HORKAGE_ZERO_AFTER_TRIM. I am not very much confident on only
having ATA_HORKAGE_NO_NCQ_TRIM as we have seen huge regression due to
243918be6393 ("libata: Do not blacklist Micron M500DC"). Unless, Micron
confirms that it can only have 'ATA_HORKAGE_NO_NCQ_TRIM' I think we
should go for both. I don't think we should mark it as ZRAT supported,
(without Micron confirmation) and cause another regression.
My v1 patch is at https://patchwork.kernel.org/patch/10287605/
Do you want me to resend it again?

--
Regards
Sudip
