Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248CBC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA9B920859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Oq+9b5Ao"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391741AbfAPJqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 04:46:24 -0500
Received: from mail.skyhub.de ([5.9.137.197]:36442 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730200AbfAPJqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 04:46:24 -0500
Received: from zn.tnic (p200300EC2BC98A00BDE8DF251329FBA0.dip0.t-ipconnect.de [IPv6:2003:ec:2bc9:8a00:bde8:df25:1329:fba0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1328F1EC0543;
        Wed, 16 Jan 2019 10:46:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1547631982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=M++/71/DKaK6+iBzrI+O+F4dhOM43KG6ku0qH1KuJoA=;
        b=Oq+9b5AoiEHbMxKio+CnCxN7BHAV7YEk5s0ifhs7iKmUufeI0jMBQIq77AZBE90TCHrd9Q
        87yKGkvkSy0jVZfhdKI+9P0iGdxfynpbVLjM+U6UaDYXo4bZRiriU5yFlwicJ7INEwegGf
        mksdupApTS5G3VfY5J1DPu2zUS0JcMI=
Date:   Wed, 16 Jan 2019 10:46:19 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Kairui Song <kasong@redhat.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org,
        akpm@linux-foundation.org, robert.moore@intel.com,
        erik.schmauss@intel.com, rafael.j.wysocki@intel.com,
        Len Brown <lenb@kernel.org>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v2 2/2] x86, kexec_file_load: make it work with
 efi=noruntime or efi=old_map
Message-ID: <20190116094619.GB15409@zn.tnic>
References: <20190115095834.22617-1-kasong@redhat.com>
 <20190115095834.22617-3-kasong@redhat.com>
 <20190115231005.GF6596@zn.tnic>
 <CACPcB9dYD2zR7ssXFibkefo3EZuvVnLegovwTMA8MaaLP1UsYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACPcB9dYD2zR7ssXFibkefo3EZuvVnLegovwTMA8MaaLP1UsYQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 03:08:42PM +0800, Kairui Song wrote:
> I didn't see a way to reuse things in that patch series, situation is
> different, in that patch it needs to get RSDP in very early boot stage
> so it did everything from scratch, in this patch kexec_file_load need
> to get RSDP too, but everything is well setup so things are a lot
> easier, just read from current boot_prams, efi and fallback to
> acpi_find_root_pointer should be good.

No no. Early code should find out that venerable RSDP thing once and
will save it somewhere for further use. No gazillion parsings of it.
Just once and share it with the rest of the code that needs it.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
