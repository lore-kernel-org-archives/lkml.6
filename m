Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD65C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 18:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03B402083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 18:31:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03B402083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbeJCBQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 21:16:27 -0400
Received: from uphb19pa13.eemsg.mail.mil ([214.24.26.87]:32938 "EHLO
        usfb19pa16.eemsg.mail.mil" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726293AbeJCBQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 21:16:26 -0400
X-EEMSG-check-008: 132432016|USFB19PA16_EEMSG_MP12.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by usfb19pa16.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 02 Oct 2018 18:31:41 +0000
X-IronPort-AV: E=Sophos;i="5.54,332,1534809600"; 
   d="scan'208";a="16448865"
IronPort-PHdr: =?us-ascii?q?9a23=3A8y+CxBdviVH+02Kz661Y8+cklGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxc28ZxGN2/xhgRfzUJnB7Loc0qyK6/+mATRIyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfbF/IA+qoQnNq8IbnZZsJqEtxx?=
 =?us-ascii?q?XTv3BGYf5WxWRmJVKSmxbz+MK994N9/ipTpvws6ddOXb31cKokQ7NYCi8mM3?=
 =?us-ascii?q?0u683wqRbDVwqP6WACXWgQjxFFHhLK7BD+Xpf2ryv6qu9w0zSUMMHqUbw5Xy?=
 =?us-ascii?q?mp4rx1QxH0ligIKz858HnWisNuiqJbvAmhrAF7z4LNfY2ZKOZycqbbcNwUX2?=
 =?us-ascii?q?pBWttaWTJHDI2ycoADC/MNMfhEo4X4oVYFsBmwChS2BO731zFGmHH206053e?=
 =?us-ascii?q?ovHw7J0w4vEM4BvnnPsNX4Nr0fXfypwKTGzzjOae5d1zfn6IjPdxAsueyCXa?=
 =?us-ascii?q?5ufsrJyUkgCQXFhUiNp4zgJTyV0uANvHab7uF9Uu+vkHMoqxpqrzizxsYjlo?=
 =?us-ascii?q?nJhoUPxlDC7iV22pw5JdK/SE5leNOpFoZbuSKCN4ZuX88vTG5ltDw6x7Ebo5?=
 =?us-ascii?q?K3YicHxIo9yxLCbfGMbpKG7Qj5VOmLJDd1nHdleLWiiBms6UWg0ej8VtWs0F?=
 =?us-ascii?q?ZNsypFjsHAtnAT2BzX7ciKUud98V272TaOygDT8ftIIVw0lKXHK54hxaQ8lp?=
 =?us-ascii?q?wPvkTYAiD6gkD2jK6Sdkk8++io7froYqn+q5OBOIJ5hRvyP6QzlsClH+g1PR?=
 =?us-ascii?q?YCU3KG9eik0b3s50z5QLFEjv0slanZtYjXJd8Gqa6iGAJVzoYi5Aq/Dzehyt?=
 =?us-ascii?q?gYm2IHI0hfdBKIiIjpJUnCIOrkAvenn1SsjDBryujFPrL/HJrNNWTMkLDmfb?=
 =?us-ascii?q?Z+8ENT1AozzcpY55JRC7EBPffzVlX2tNzCAR8zKxa0zPr/CNVhyoMeXnqCDK?=
 =?us-ascii?q?6eMKPWrFCH+OQvLPGLao8UvDb9L+Yq5+TtgHI3glIdZbOp3ZwLaHC/GPRmJl?=
 =?us-ascii?q?+WYXvogtsbDWgKvhI0TPb2h12aTT5Te3GyUrok5j4hFYKmCZzORpi3j7yc2C?=
 =?us-ascii?q?e3B5hWZmdBClCWD3jkbZmLW/AJaCiKOM9ujiQEVaS9S48mzRyutgr6y719Lu?=
 =?us-ascii?q?rO+y0Yronu1N5v6O3Wix4y9CZ4D8OH02GCV2t0hH8HRycq3KBjpkxw0kuM3r?=
 =?us-ascii?q?Jjg/NGFd1e/OhJXRs6NZHG0ux6BdTyVRzbftuQVFmpWM+qDi02TtI029UOeV?=
 =?us-ascii?q?pyG82+jhDf2CqnG70Vl7uLBJwy6K7c3X/xJ8ZnxHbAz6kukV8mT9BTOmK8gK?=
 =?us-ascii?q?5/8A7TB4/VnEqDk6amb7gT3CnI9G2b12qBoFlYUBJsUaXCRX0fflXZrdL25k?=
 =?us-ascii?q?PfTr+uD60rMghfxs6YLKtFdNnpgE5HRPv6PNTeZHyxlHmqCRaT3LyMb5fqe3?=
 =?us-ascii?q?8H0ynHDkgLjRof/XSeNQImHCeuv3reDCByFVLoe07j7fNxqGilQU401Q2KdF?=
 =?us-ascii?q?Fu17qv9R4Ii/ycT+0c3qgftScgrTV0AEiy39bMB9WcoApheb1WYckh71dfyW?=
 =?us-ascii?q?LZqwt9M4SkL6BjgF4ebgt2s1r11xppFopAjNIqrHI2zAtyMK6Y1VRBeC6F3Z?=
 =?us-ascii?q?D0JLLaMXfy/B+xZK7MwF3e08iZ+r0J6Psmr1XvpgapFlAt839/ydlaz2Oc5o?=
 =?us-ascii?q?nWDAoVSZ/+TkE39wJhqL7Efikw/IfU1HNqMaWutD/Nxc4pDvM/yhm8Z9dfLL?=
 =?us-ascii?q?+EFAjqHs0eBsiuLvEqmlewYh0ZO+Bd6LU5P92pd/SYwq6nJuVgkyy8jWRB/o?=
 =?us-ascii?q?991liA9y1mSu7Hx5wF2e2X3hObVzfgi1esqsT3mYFCZTEPEWuz0DLrBJRNaa?=
 =?us-ascii?q?1yZosLF2iuLNOtxtlkhJ7iRWRY9Fi9CFMCwsOpfgCSb1Pl1w1KyUsXuWCnmT?=
 =?us-ascii?q?e/zzFslzEpr6yf3DHBwuj7dxoIJHRLRG98glfoOoW0kd8aU1aybwQzlxuq+1?=
 =?us-ascii?q?z6x65Fq6R7NWXTRl1IfyelZ11lB4i9u6HKSMlI69t8sihaS++7ZlOyQb7npB?=
 =?us-ascii?q?4bzialGHFRknRzVTawtpz/1zN+j3yQNj4ng33ddcx28jLe4NjRX64K9iIcQz?=
 =?us-ascii?q?V/jzzeB1z6NNn/rvuOkJKWifyzT2KsUNVodCDvyY6R/H+g6XZCHQy0n/f1nM?=
 =?us-ascii?q?buVwc9z3mohJFRSSzUoUOkMcHQ3KOgPLciJxMwCQ=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2AgAAA2ubNb/wHyM5BbGgEBAQEBAgEBAQEHAgEBAQGBV?=
 =?us-ascii?q?IFhKoFlKIN0lDBSBoE1iG2OA4FmNgGEQAKEDiE3FQEDAQEBAQEBAgFsKII1J?=
 =?us-ascii?q?AGCXgEBAQECASMVQRALGAICJgICVwYBDAYCAQGCXj+BagMIBQinWIEuhHeCQ?=
 =?us-ascii?q?hmCRYELiXgXeYEHgTmCa4RmgxmCVwKOUo5qCZAyBhePWpcYIoFVKwgCGAghD?=
 =?us-ascii?q?4MngiUXjjQjMHsBAY1XAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 02 Oct 2018 18:31:40 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w92IVb8v011037;
        Tue, 2 Oct 2018 14:31:37 -0400
Subject: Re: [PATCH security-next v4 23/32] selinux: Remove boot parameter
To:     Kees Cook <keescook@chromium.org>,
        Jordan Glover <Golden_Miller83@protonmail.ch>
Cc:     Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20181002005505.6112-1-keescook@chromium.org>
 <20181002005505.6112-24-keescook@chromium.org>
 <CAHC9VhQjMfH6Q+Tif8nBknZojgxrb6x+oDz4vHRiZN8rb8MZ5Q@mail.gmail.com>
 <785ef6a9-ae46-3533-0348-74bcf6f10928@tycho.nsa.gov>
 <CAGXu5jKNzG3rGUAV39D0w4txHRG3H2qU1Z1e_b+03OgycTaWqA@mail.gmail.com>
 <809f1cfd-077b-ee58-51ba-b22daf46d12b@tycho.nsa.gov>
 <QpdcE4QSCQKJqDmB2QBEGBlnlioHuRHlM0g5HF8KbHjU1zIUAOjnQ2r9EIMu3m0S2OWNR3_M_TSp_M6CVDqkp6kKuFPUvegsyDPNw1AGju4=@protonmail.ch>
 <CAGXu5jKqXNbEvPr1axQtGCCnWsGhDgjynW5u326mcx4vZ1oH8g@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <cc2ff677-a45e-e171-7a71-7d8e202bcabd@tycho.nsa.gov>
Date:   Tue, 2 Oct 2018 14:33:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5jKqXNbEvPr1axQtGCCnWsGhDgjynW5u326mcx4vZ1oH8g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/2018 12:54 PM, Kees Cook wrote:
> On Tue, Oct 2, 2018 at 9:33 AM, Jordan Glover
> <Golden_Miller83@protonmail.ch> wrote:
>> It's always documented as: "selinux=1 security=selinux" so security= should
>> still do the job and selinux=1 become no-op, no?
> 
> The v3 patch set worked this way, yes. (The per-LSM enable defaults
> were set by the LSM. Only in the case of "lsm.disable=selinux" would
> the above stop working.)
> 
> John did not like the separation of having two CONFIG and two
> bootparams mixing the controls. The v3 resolution rules were:
> 
> SECURITY_SELINUX_BOOTPARAM_VALUE overrides CONFIG_LSM_ENABLE.
> SECURITY_APPARMOR_BOOTPARAM_VALUE overrides CONFIG_LSM_ENABLE.
> selinux= overrides SECURITY_SELINUX_BOOTPARAM_VALUE.
> apparmor.enabled= overrides SECURITY_APPARMOR_BOOTPARAM_VALUE.
> apparmor= overrides apparmor.enabled=.
> lsm.enable= overrides selinux=.
> lsm.enable= overrides apparmor=.
> lsm.disable= overrides lsm.enable=.
> major LSM _omission_ from security= (if present) overrides lsm.enable.
> 
> v4 removed the per-LSM boot params and CONFIGs at John's request, but
> Paul and Stephen don't want this for SELinux.
> 
> The pieces for reducing conflict with CONFIG_LSM_ENABLE and
> lsm.{enable,disable}= were:
> 
> 1- Remove SECURITY_APPARMOR_BOOTPARAM_VALUE.
> 2- Remove apparmor= and apparmor.enabled=.
> 3- Remove SECURITY_SELINUX_BOOTPARAM_VALUE.
> 4- Remove selinux=.
> 
> v4 used all of 1-4 above. SELinux says "4" cannot happen as it's too
> commonly used. Would 3 be okay for SELinux?

Let's say a user/packager/distro has been building kernels for the past 
14 years (*) with a config that has SECURITY_SELINUX_BOOTPARAM_VALUE=0, 
and now they build a new kernel that includes these patches using that 
same config.  Won't SELinux be enabled by default because 
SECURITY_SELINUX_BOOTPARAM_VALUE is now ignored and LSM_ENABLE defaults 
to all?  Is it ok to require them to specify a new config option to 
preserve old behavior?

(*) how long this config option has been around

> 
> John, with 4 not happening, do you prefer to not have 2 happen?
> 
> With CONFIGs removed, then the boot time defaults are controlled by
> CONFIG_LSM_ENABLE, but the boot params continue to work as before.
> Only the use of the new lsm.enable= and lsm.disable= would override
> the per-LSM boot params. This would clean up the build-time CONFIG
> weirdness, and leave the existing boot params as before (putting us
> functionally in between the v3 and v4 series).
> 
> -Kees
> 

