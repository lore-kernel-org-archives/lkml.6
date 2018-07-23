Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD7EECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01EE720880
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:45:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01EE720880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388265AbeGWLqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 07:46:11 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59656 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387962AbeGWLqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 07:46:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A62618A;
        Mon, 23 Jul 2018 03:45:36 -0700 (PDT)
Received: from [10.4.13.119] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0410E3F778;
        Mon, 23 Jul 2018 03:45:34 -0700 (PDT)
Subject: Re: linux-next: manual merge of the kvm-arm tree with the arm64 tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Christoffer Dall <cdall@cs.columbia.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
References: <20180723144641.62b2b226@canb.auug.org.au>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <4707c588-4ad5-aa80-ebe4-45f78d5b52da@arm.com>
Date:   Mon, 23 Jul 2018 11:45:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180723144641.62b2b226@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 23/07/18 05:46, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the kvm-arm tree got a conflict in:
> 
> arch/arm64/include/asm/cpucaps.h
> 
> between commit:
> 
> 314d53d29798 ("arm64: Handle mismatched cache type")
> 
> from the arm64 tree and commit:
> 
> e48d53a91f6e ("arm64: KVM: Add support for Stage-2 control of 
> memory types and cacheability")
> 
> from the kvm-arm tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
>  is now fixed as far as linux-next is concerned, but any non 
> trivial conflicts should be mentioned to your upstream maintainer 
> when your tree is submitted for merging.  You may also want to 
> consider cooperating with the maintainer of the conflicting tree
> to minimise any particularly complex conflicts.
> 

Looks good, thanks Stephen.

	M.
- -- 
Jazz is not dead. It just smells funny...
-----BEGIN PGP SIGNATURE-----

iQJJBAEBCAAzFiEEn9UcU+C1Yxj9lZw9I9DQutE9ekMFAltVscgVHG1hcmMuenlu
Z2llckBhcm0uY29tAAoJECPQ0LrRPXpDlcAP/1ahY/hghk5uJBrWdv13H0/wam85
OBB0xfaPU7f3HWIIZlyccMW+nY/mxxffdpZ4fGIiwMKfUNcshG0pjALNkvSmtgSx
UDehcHjHcdahqTG0SBFe0F8zISdCGgLEPgJ7Ow5RO+5RoNTQckNIPz92nUW5Hu3d
bTE41mMr+isFg6eYSVbBBHwuxN0PAVhQ9xDfJwEezfm5jcSTlg2nenRHbic6cf7o
utOXe27ZU2W278cwWGrk4iMmLg2EDJcPZ1nK15WI4GVL25sQGBX8MYScjiXImaBX
eF8aJtfd8xJ3LWH4ENgD0EEnt7dKGBTidZIZA86g1+LmZH+zA4/1AEWpidvsExPe
zH/b3N3Al8oLPMOJjxJEcFB2yAeTiyMJ+fRc9+6X/Tv0Pxj0FeyqrJrIDCLz8I0Y
fy4VL3nuHCyKtgFGWAM6hznM1scCm4JAwq3kE0Pe2sxHjClRPb1TjQ1IdALtL4tI
iSdth16dSBKluaMeVCBugOG+hfX11REUChkpMaX4X73ISOY87w1u40l1aqE3UBr3
XOOHW8bZ3TkDCrqtWxw4Cgb4fgTzJMbmINwoj77Hc57NdsV9WWTeS0T7lRdRFvbs
ohmMekjvc/3HjkiI1X+vKVFQdLdUtpAoo/j6MLAsx8F4hluneZS0bACM2oO6moVD
qRjj85emuDsA0a2R
=pFup
-----END PGP SIGNATURE-----
