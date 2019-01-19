Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF90C61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 11:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4E5D2084C
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 11:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbfASLwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 06:52:42 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:44649 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727879AbfASLwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 06:52:42 -0500
Received: from oxbsltgw64.schlund.de ([212.227.220.202]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MDhpf-1gtvRd3XRn-00Aq7B; Sat, 19 Jan 2019 12:52:26 +0100
Date:   Sat, 19 Jan 2019 12:52:25 +0100 (CET)
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Jeremy Linton <jeremy.linton@arm.com>, marc.zyngier@arm.com
Cc:     mlangsdo@redhat.com, suzuki.poulose@arm.com,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        julien.thierry@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, steven.price@arm.com,
        ykaukab@suse.de, dave.martin@arm.com, shankerd@codeaurora.org
Message-ID: <247598924.444809.1547898745403@email.ionos.de>
In-Reply-To: <3af70b49-22e7-f394-1b35-ce3c86640bb7@arm.com>
References: <20190109235544.2992426-1-jeremy.linton@arm.com>
 <884332236.499392.1547581848222@email.ionos.de>
 <c99f5da9-259c-3fc5-6150-7327ba0ff429@arm.com>
 <575913854.422488.1547834735236@email.ionos.de>
 <3af70b49-22e7-f394-1b35-ce3c86640bb7@arm.com>
Subject: Re: [PATCH v3 0/7] arm64: add system vulnerability sysfs entries
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev47
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:CCXtxrzf1TbPqLsEu/M0bGh9ETIUU9N9SsbCEctrj3/5F7N+aZM
 +iO/2hGPcxNODcOq2d+7K+PPYueDvGVJEsfx560xC5f2VJIOOQa1atNDbQ7dyNXMXVNWGZG
 LlmidxhUiKocXLe9U/VoZJM3ckJ9EvobOSZDJZIC4GpQ+AMQ0Isl2yhyMNlHnZiMTr3gihB
 FzggT5aTXvQVSDc/e6vQA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Qt0HaB/TrSc=:L3y0w8w8P8Le3F6TGPpMJF
 zqjqB6SdBvax+nsmjUj6Kw+TXOXaXg12OZGl4OwEXig8suvQSy+eKNn+ZAkwpIi5PxLjkLNqZ
 Ur/f28AEaqKD8I6rkMRe8YHmmnOFPwtd/fwg3cZJS/K0Pr4Jyyi9JBruHHtchgre4iAr0CPry
 JaWwHpWLn06WLTX9Xa2xauQsAuu/P8PBDPUoUAWl/kBN7JcL2FDLyO2fuIjAqJYqNCEI/Nk6J
 dB8qjfxeqydnXwRr8CE2PckObw4ZYfBTL71rBJOHUc/FiRD3/5RC/B7qgLJwRSJrVj5iF8nPn
 WYqiImBmfHoH2yph9J9CKj57CHfdGQhKsuwrSSNWt3D1IxVzXx9vjxRpIpgkpTkHhrO/8U2y3
 1PbH1Wf5kxCMSNhGlHffJZknKUGMxtCRM8+AXFPQH/pJouBkjbDNs2P0H+XTl2hYuesQnf2gf
 i/HoFc1Llpx81/EI2xbdxZUFp+piplC0s2EkWhhkrIRBNO5QitkrNJLmSF+bj9ff3ecaONhyn
 evgy9ycn2WQohqZUxMUzXh4NU/0mdwLbm8P+4gZHqoizsposdlxDpJOMAc+wJvOh72ME9Wqdu
 bsOeg+dpBAdeybn2nzN6Q+Z4b8Yhi8S+JE5bRiKfohoaD5a296VvcHZlRsETm3WCC01E6gBng
 0p0TJH5NIx6Dv2EIgPIoRZJYZJawTEAb7guXAF/ZLbQMXd8apF4yhxZB+ky6sF9eYeVqj/NaE
 f1BiJsQmIkX7RqIghvB2ssO0ebPoCbKZYhg6zjS/rxYJwcJRbMgc9HWL1/U=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Jeremy Linton <jeremy.linton@arm.com> hat am 18. Januar 2019 um 23:22 geschrieben:
> 
> 
> On 01/18/2019 12:05 PM, Stefan Wahren wrote:
> > Hi,
> > 
> > ...
> > 
> > a snippet or a new version would be nice
> 
> Sure, I've got another version, to be posted soon (probably Tue of next 
> week).
> 
> In the meantime, Marc's tree should work with the following fix:
> 
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index b44f87e7360d..7cfd34b2c0e5 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -286,11 +286,15 @@ static int detect_harden_bp_fw(void)
>   }
>   #endif /* CONFIG_HARDEN_BRANCH_PREDICTOR */
> 
> +#if defined(CONFIG_ARM64_SSBD) || \
> +       defined(CONFIG_GENERIC_CPU_VULNERABILITIES)
> +static bool __ssb_safe = true;
> +#endif
> +
>   #ifdef CONFIG_ARM64_SSBD
>   DEFINE_PER_CPU_READ_MOSTLY(u64, arm64_ssbd_callback_required);
> 
>   int ssbd_state __read_mostly = ARM64_SSBD_KERNEL;
> -static bool __ssb_safe = true;
> 
>   static const struct ssbd_options {
>          const char      *str;
> @@ -569,6 +573,8 @@ check_branch_predictor(const struct 
> arm64_cpu_capabilities *entry, int scope)
> 
>          WARN_ON(scope != SCOPE_LOCAL_CPU || preemptible());
> 
> +       arm64_requested_vuln_attrs |= VULN_SPECTREV2;
> +
>          /* If the CPU has CSV2 set, we're safe */
>          if 
> (cpuid_feature_extract_unsigned_field(read_cpuid(ID_AA64PFR0_EL1),
>                                                   ID_AA64PFR0_CSV2_SHIFT))
> @@ -578,17 +584,17 @@ check_branch_predictor(const struct 
> arm64_cpu_capabilities *entry, int scope)
>          if (is_midr_in_range_list(read_cpuid_id(), spectre_v2_safe_list))
>                  return false;
> 
> +       __spectrev2_safe = false;
> +
>          /* Fallback to firmware detection */
>          need_wa = detect_harden_bp_fw();
>          if (!need_wa)
>                  return false;
> 
> -       __spectrev2_safe = false;
> -
>          if (need_wa < 0)
>                  pr_warn_once("ARM_SMCCC_ARCH_WORKAROUND_1 missing from 
> firmware\n");
> 
> -       arm64_requested_vuln_attrs |= VULN_SPECTREV2;
> +
> 
>          return (need_wa > 0);
>   }
> 
>

fine with these changes i'm getting the following:

meltdown:Not affected
spec_store_bypass:Not affected
spectre_v1:Mitigation: __user pointer sanitization
spectre_v2:Not affected

Thanks
Stefan
