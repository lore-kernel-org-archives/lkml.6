Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D90EC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09A0D20859
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547586613;
	bh=a+yhYIgCGS8zOho0awPieGM53ZbswgC6PdvPfksh3N4=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=lNRGZdnU0yQXUD0XlxvyATexXAY0ny8OURin/L2Hx9tmxg/I2lJJYlPGb0Bn0DFbC
	 UYA4wGd4g0AhxNtfQbAcgGUvHCkg9y5Bb7QNHFXL6LmPSaefgVFbqb+ocnB1m5xKvb
	 DrKtuWeoESFjh3ne+65B3MDV12ub69UUgYid4UAM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390247AbfAOVKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 16:10:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:58554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732930AbfAOVKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 16:10:10 -0500
Received: from [10.84.151.17] (unknown [167.220.148.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4816205C9;
        Tue, 15 Jan 2019 21:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547586610;
        bh=a+yhYIgCGS8zOho0awPieGM53ZbswgC6PdvPfksh3N4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=T8oBXhQn4h+VSyhq+OKXwKzIWh/CWRlv8mvJODbYSv2qx1g8f48MPaefU7y6pmhwu
         BFVtcl9nR3hfvOBwtK0CZT1Rf/g2OznoG8Wdi2mb5n0uX52vsRdE8wKHlw/Q5pIgcF
         gENQwb6SjQUCP8kdBqVC3vdL/fNpWzJJGc5uLgbo=
Subject: Re: linux-next: Fixes tags need some work in the pm tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190116075540.78cff44e@canb.auug.org.au>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <0f64417d-be5e-2939-7fc5-ee5ba26c64a6@kernel.org>
Date:   Tue, 15 Jan 2019 16:10:07 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190116075540.78cff44e@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/2019 3:55 PM, Stephen Rothwell wrote:
> [I am experimenting with checking the Fixes tags in commits in linux-next.
> Please let me know if you think I am being too strict.]
> 
> Hi Rafael,
> 
> Commits
> 
>    62b33d57c534 ("drivers: thermal: int340x_thermal: Make PCI dependency explicit")
>    cd793ab22a93 ("x86/intel/lpss: Make PCI dependency explicit")
>    42ac19e7b81e ("ACPI: EC: Look for ECDT EC after calling acpi_load_tables()")
>    6c29b81b5695 ("platform/x86: apple-gmux: Make PCI dependency explicit")
>    34783dc0182a ("platform/x86: intel_pmc: Make PCI dependency explicit")
>    704658d1d3ae ("platform/x86: intel_ips: make PCI dependency explicit")
>    5df37f3a1aa9 ("vga-switcheroo: make PCI dependency explicit")
>    da1df6ee4296 ("ata: pata_acpi: Make PCI dependency explicit")
>    ce97a22a596b ("ACPI / LPSS: Make PCI dependency explicit")
> 
> Have malformed Fixes tags:
> 
> There should be double quotes around the commit subject.
> 

Interesting, can you add this to the checkpatch.pl script so that it doesn't
happen again?
