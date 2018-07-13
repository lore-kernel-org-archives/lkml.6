Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60784ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 18:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01C6820779
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 18:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J75KOYiJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01C6820779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731970AbeGMSZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 14:25:50 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:43473 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731181AbeGMSZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 14:25:50 -0400
Received: by mail-pl0-f67.google.com with SMTP id o7-v6so2145663plk.10;
        Fri, 13 Jul 2018 11:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=upQTrPcQtmwOjnLgwxljk72fHs9p6GnE7NE07JEJOuA=;
        b=J75KOYiJcTfXhyDsrEhzKV+wivgTu6hIZhzjivx9QPXaayT83IpRifsMxN17t3t8Zf
         UBkL+w5KBIMrZi0zaxHxzkCQLPvZB99LWrQF37M2hv6ly03HxywQJx/Q8Nj2fEqqioOR
         MaZlsVbDAkJbtfbcE6gXYGUfuhYjhBrwjQgMyLHycV1CfGOUcyDCvOZYZyWR1ygIbgcu
         xBg8CF1dHoSLnpeJT7QUymN8bAFUfR6O0cSfBHZN/pE5Pnc+jMt1vA5ZBiBnTpRJp+d4
         tmRNTW9glNc5QWYCeNbRC+s55mw1T+PqNWKOIzThcC312TfPd7ziDLqGsON0Nixq+CVo
         gbHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=upQTrPcQtmwOjnLgwxljk72fHs9p6GnE7NE07JEJOuA=;
        b=M0lENV80qWOkrN1Cm6wvfsrxVVskaNLn1OfTKNIVI4lNgoYEfN99A5/Hbi1vbS0aeJ
         unDOqArasxNrwxovNjOplEbp6KGUK04RDxpHYBXVEvI95hGPbL5f692NQt4ZEE9t3LG7
         Aia7tebR7DMNHWQjPnVnjri+w3aRav50TPw52md+pF6BQQxGDSsJPapHw70Vpdh9SSwX
         jDigdPnZNbvtMtBy7Z4UL/cCSWfxis/ZH9tguqz5Nb0Q8sRkNeBlPMsePLHcPo40Yoxb
         W8NAUuz39sQyGieG/tgMSf4n4YUlDWlOWTuM8VinGUlRyuoVIULT8Kbq04kI/xZnCWKi
         vDSw==
X-Gm-Message-State: AOUpUlH9Ayf4xj+RrSvKESfFifBvKMMxDcGb99OMo6uYbcRrwbkbbtKu
        OgaYwiFUdiJ0KiaUEF5s89E=
X-Google-Smtp-Source: AAOMgpcKfbjuOEt5XtSf1wCL0NGeCMmIgoAHpJ8M/UOlPLZlx7oxJf4MSdm72He2nP01xcgvEMvHww==
X-Received: by 2002:a17:902:a613:: with SMTP id u19-v6mr7324489plq.234.1531505407491;
        Fri, 13 Jul 2018 11:10:07 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::5:95fe])
        by smtp.gmail.com with ESMTPSA id h10-v6sm22568506pfj.78.2018.07.13.11.10.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 11:10:06 -0700 (PDT)
Date:   Fri, 13 Jul 2018 11:10:02 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Constantine Shulyupin <const@MakeLinux.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Joey Pabalinas <joeypabalinas@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scripts/tags.sh: Add BPF_CALL
Message-ID: <20180713181001.2ugugmnmldyrq7li@ast-mbp.dhcp.thefacebook.com>
References: <20180712052850.28396-1-const@MakeLinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712052850.28396-1-const@MakeLinux.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 08:28:46AM +0300, Constantine Shulyupin wrote:
> Signed-off-by: Constantine Shulyupin <const@MakeLinux.com>

Acked-by: Alexei Starovoitov <ast@kernel.org>

