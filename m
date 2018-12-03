Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821CEC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 450B420851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="MdPr8Zne"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 450B420851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbeLCJVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 04:21:19 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37746 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbeLCJVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 04:21:18 -0500
Received: by mail-lf1-f67.google.com with SMTP id p17so8548314lfh.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 01:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YtH6Mpen/JSxBK/FpENcKMBe8cOvhgELLmE9FMOGZWE=;
        b=MdPr8Zne7UbgrSWbo/Ber3nNK32Qy3gcot4i6tqJI3sEr5lI1GkXc3fP86VhiNh6SZ
         CchJnb+CQuTx6Co/8FaV5IVQ2vqoDmmoTSuEwuayDlWnQ6SjTMcUDznNAzNjNiCqx6HU
         fWAb6swmnXCRCH5+P6D/+KhU8nbByLuM3I7C20Tcy4hFVFxestkAVYIoZAXOEXR9gxQ6
         UknUVVE5x50sKQq+ilgJh+QFcMBGsoP/6XI+hvppHeUIxrf+fyFRBWQaNlUYUZFryUud
         zfO8qAm9DdnV7YnmAOZmsgnvtRCCaapqGhKoqv+GJYQGrYHZOyyFCQ86y5SMA8jiNQMG
         bbUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YtH6Mpen/JSxBK/FpENcKMBe8cOvhgELLmE9FMOGZWE=;
        b=B3BlSLjUJDRqgCerdS3s8k0sAjoKBVFRPr38oVTiWDW4egUW2q5wd8qV0XTAo52XAP
         aMLyIks25fugiCPE44NZD1K+O3ViDWNPSaofVKgDxbKTLJdRsZh63VDPbBpyNYSaXuuK
         MbHvHg4A2zq+CuQo2PjpV+mflEYafobBGE0x2R4W/ZP5iyMYiGgwt77IM7GICenv2++D
         jlu8QTj/lmR3ElTf5RUtygDikjtBgowJZc8fifGHcSOi8v7XSve2zT5hI8zZAtk7HoYT
         flg4/oHDiLrC+BDo0YS33cbDnUiL4rEGu2fqLE5KdtNerQUlYcAg3vW7dADsK132Ncot
         1NVQ==
X-Gm-Message-State: AA+aEWZINZoGeCyQPxBYnUXAiPWJaa2+gpC/2kRNRllN9IGBFXXJ7mOU
        BeTI0e4Gnt8SOBFqRF5fq6mrPU0yfN8=
X-Google-Smtp-Source: AFSGD/VHqaERwyVOEacnOQ8WjYKW4YciHmrP0XQJu1nV+ZP9cfsDVG6JmZK/IvEQpjxHPwlu/qLLNg==
X-Received: by 2002:a19:f20:: with SMTP id e32mr9136212lfi.51.1543828865406;
        Mon, 03 Dec 2018 01:21:05 -0800 (PST)
Received: from kshutemo-mobl1.localdomain (mm-162-212-127-178.mogilev.dynamic.pppoe.byfly.by. [178.127.212.162])
        by smtp.gmail.com with ESMTPSA id a18-v6sm2401925ljk.86.2018.12.03.01.21.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 01:21:04 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 4F1BA3003F7; Mon,  3 Dec 2018 12:21:03 +0300 (+03)
Date:   Mon, 3 Dec 2018 12:21:03 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     tglx@linutronix.de,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>, stable@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] x86/mm: Drop usage of __flush_tlb_all() in
 kernel_physical_mapping_init()
Message-ID: <20181203092102.qlflplfznsuogci6@kshutemo-mobl1>
References: <154362450646.2367148.16448130381211111341.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154362450646.2367148.16448130381211111341.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 04:35:06PM -0800, Dan Williams wrote:
> Dan Williams (5):
>       generic/pgtable: Make {pmd,pud}_same() unconditionally available
>       generic/pgtable: Introduce {p4d,pgd}_same()
>       generic/pgtable: Introduce set_pte_safe()
>       x86/mm: Validate kernel_physical_mapping_init() pte population
>       x86/mm: Drop usage of __flush_tlb_all() in kernel_physical_mapping_init()

Looks good to me. For the whole patchset:

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
