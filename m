Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3358FC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFD172081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="0Z5FwZa+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFD172081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbeJaWVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 18:21:38 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42254 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728789AbeJaWVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 18:21:38 -0400
Received: by mail-pl1-f196.google.com with SMTP id t6-v6so7279712plo.9
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 06:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qg+qgY/KRbI9l36FYG5HWIL8AoBTQp/az+NWlSr3MnU=;
        b=0Z5FwZa+HDPtDfx+wpse2/NSpCse5KEZgbXicEMynHlUEL/Cr0aUB9JrecvuS9k/O9
         CBK5aTGYwGSgSAEGxfO5dQtz5Ear/JD5OGAg9MN5sfS8GAsd5dlaOb3dZr1R15yv0wV2
         dxcr/FqkWt3EjlFvV44kvFPuO8xpLo1Af9CeB3+N5yjxF9jAaEmFez+IkzhgR2ZgCYZO
         +xQ93juOmkUY8db+FNu/RKwWHeIX0GuP4ygAYTb6gJDb6e0iIieXT7Y2zTR10mT7vkNy
         tmYLEbMOByfDYBEW2Ip6HPDEo+62fsbmnpgbxnPeX0E/hSSAvyXwobt2hnJyt6Jzmf4b
         nezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qg+qgY/KRbI9l36FYG5HWIL8AoBTQp/az+NWlSr3MnU=;
        b=h7bcSixUyGZ0h8wsqhnOxEqVo7I5O20LHJKaOlvuY+E7f/F/V+pjfW2b3P9vkffuOl
         w9gZ3Bfox2uUudjsmdwg7odurq3vNnxTBjuUAo2gDoWc7iuA2pez/gcVVdxaGVwfVnDr
         FBXaOvMqeHjg5k/ZkxFRfFjRyT9JdTjpqj/DFp5dxMet2KeBekSZyKXfQ5VHD3cm1HOP
         cjggi322pdXts4qZqNRDYCmntM1nB77Jtr/fGGFPpq2wqDhdjC6uPIcYK3O0Oqx58TUv
         Mco1ZoH2aeKlbHxYg6F6c1C9DrGQHdFojiL0EHZZybT+CeFE3IQ7qMK5m6PuM4llI8x8
         BpTw==
X-Gm-Message-State: AGRZ1gJEOct8IXqV82XlNdoEJDclqtpnom8biwBl8ujvmVbw4xSBxZld
        DZNmOAKExEaxZM38m9lb82wpHA==
X-Google-Smtp-Source: AJdET5cPzmGOYCYHHPG2R/4TAtV3zPacWqga3WNJSOcR9IVDTOk4ivtqUVavGnYGYUKalsmABiPk2Q==
X-Received: by 2002:a17:902:4383:: with SMTP id j3-v6mr3455610pld.265.1540992217057;
        Wed, 31 Oct 2018 06:23:37 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([134.134.139.82])
        by smtp.gmail.com with ESMTPSA id c128-v6sm22968712pfb.147.2018.10.31.06.23.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 06:23:35 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 428A0301604; Wed, 31 Oct 2018 16:23:31 +0300 (+03)
Date:   Wed, 31 Oct 2018 16:23:31 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc:     Li Wang <liwang@redhat.com>, Guenter Roeck <linux@roeck-us.net>,
        Janosch Frank <frankja@linux.vnet.ibm.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 1/4] mm: make the __PAGETABLE_PxD_FOLDED defines non-empty
Message-ID: <20181031132331.s5l77nsjoyiwhqhd@kshutemo-mobl1>
References: <1540990801-4261-1-git-send-email-schwidefsky@de.ibm.com>
 <1540990801-4261-2-git-send-email-schwidefsky@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540990801-4261-2-git-send-email-schwidefsky@de.ibm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 01:59:58PM +0100, Martin Schwidefsky wrote:
> Change the currently empty defines for __PAGETABLE_PMD_FOLDED,
> __PAGETABLE_PUD_FOLDED and __PAGETABLE_P4D_FOLDED to return 1.
> This makes it possible to use __is_defined() to test if the
> preprocessor define exists.
> 
> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
