Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B60BC64EBC
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 19:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4E0121470
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 19:42:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4E0121470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbeJDCbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 22:31:49 -0400
Received: from ucol19pa09.eemsg.mail.mil ([214.24.24.82]:34604 "EHLO
        ucol19pa09.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726966AbeJDCbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 22:31:48 -0400
X-EEMSG-check-008: 776624413|UCOL19PA09_EEMSG_MP7.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.54,337,1534809600"; 
   d="scan'208";a="776624413"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by ucol19pa09.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 03 Oct 2018 19:41:58 +0000
X-IronPort-AV: E=Sophos;i="5.54,337,1534809600"; 
   d="scan'208";a="19010183"
IronPort-PHdr: =?us-ascii?q?9a23=3AeI2cnxNpdTPvSAGsEPYl6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0K/nzr8bcNUDSrc9gkEXOFd2Cra4c1KyO6+jJYi8p2d65qncMcZhBBV?=
 =?us-ascii?q?cuqP49uEgeOvODElDxN/XwbiY3T4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx?=
 =?us-ascii?q?7xKRR6JvjvGo7Vks+7y/2+94fcbglUhjexe69+IAmrpgjNq8cahpdvJLwswR?=
 =?us-ascii?q?XTuHtIfOpWxWJsJV2Nmhv3+9m98p1+/SlOovwt78FPX7n0cKQ+VrxYES8pM3?=
 =?us-ascii?q?sp683xtBnMVhWA630BWWgLiBVIAgzF7BbnXpfttybxq+Rw1DWGMcDwULs5Qi?=
 =?us-ascii?q?qp4bt1RxD0iScHLz85/3/Risxsl6JQvRatqwViz4LIfI2ZMfxzca3HfdMeWG?=
 =?us-ascii?q?FPQMBfWSJcCY+4docDEfYNMeNeooLgpVUBsAG+CBGxCu3xxD9Ghnz406M03O?=
 =?us-ascii?q?suEw7JwAMuEskSsHnWttj5KLseXO63waTO0D7Nb+lW2TD46IXQbx4hve+DXa?=
 =?us-ascii?q?pwccXPz0kkCh7LjlCKpozhOzOayOQMuHWc4up7SO2vkHUqqx1xozezxscsjZ?=
 =?us-ascii?q?PFhoQOyl/e7yl5z4E1JcOhRUN9fNWqE4NQujmHO4Z5Tc4uWWFltDsgxrEYtp?=
 =?us-ascii?q?O3YjIGxIkhyhXCcfKIaZKI7QjmVOuJJDd4g29qd6ynihap9Eig1vX8Vs6p0F?=
 =?us-ascii?q?ZWtiZFksfDtnQK1xHL9siIUOF9/ka82TaUzQzT9uFFLlw0larcMZIhxKI/lo?=
 =?us-ascii?q?EPvkjZGy/2mUH2gLeXdkUi5Oeo9/zqbqjpq5KTLYN5ihzyPr4wlsGwH+g0KB?=
 =?us-ascii?q?UCU3Ce+eum1b3j+UP5QK9Njv0ziqTZq43VJd8Aq66lAw5azoYj6xGlAzegy9?=
 =?us-ascii?q?QXh2MLLF1CeBKZl4TpIU3BIOjkDfejhFShiDRryO7YMb36HprNKX/DkLT6cL?=
 =?us-ascii?q?lh605c0g0zzdVe55JJD7ENOvXzWlX+tNbAFB82LxS0w/r7CNV6zo4eW2WPAq?=
 =?us-ascii?q?+fMK/Is1+I4eIvLPOKZI8Opjn9LeMo6OL0gn8/nl8de6ip0ocNZ3C8BPhpP0?=
 =?us-ascii?q?KZYX/0iNcbDWgKphY+TPDtiFCaUz5TYnGyX7gm5jE6E4KrFoHDSZqogLOf3S?=
 =?us-ascii?q?e3BJpWZnpJClqUC3fna52EW+sQaCKVOsJvkzsEVby8RIA/0xGhrAj0y7tjLu?=
 =?us-ascii?q?rQ5CIYr5Hu2dZu6u3LjxEy8iB0D8Ob02GIVW50n2cISyUq06B/uUZ90EuM0b?=
 =?us-ascii?q?Bkg/xEEtxe/+tJXR0nNZ7Y1OF6E8r9Wh/FftuQTVamRdKmASsvQd4r39AOZE?=
 =?us-ascii?q?N9Ec24jh/fxyqqH6MVl7uTCZMo6K3cxGb+JsZmxnbdyKYhj0MpQtZBNW2imK?=
 =?us-ascii?q?F/7RHfCJLTnEmDi6mqcqEc1jbX9Gif1WqOoF1YUAloXKXdQ38fYETWrcn45k?=
 =?us-ascii?q?PEVrOuCqooMhFHycGcLqtHcdzpgUxCRPfkJtTRfXi9m3yqChaL27OMdpDld3?=
 =?us-ascii?q?8b3CrDEkQEkRgT926cNQciHiehv37eDDt2GF3zeUzs6vdxqXOhQk8v0w6Kb1?=
 =?us-ascii?q?du16e7+h4Rm/OcUege3rMCuCc9tTp0GEyx0M7RC9qFvwBhZrlTYcsh4Fdb0m?=
 =?us-ascii?q?LUrwh9Pp2mL6B/iV8Sah93sF3y2BVqEIVAkNQqrXMzwAp3LqKXzU5BdzeG0p?=
 =?us-ascii?q?3rJL3XJXf9/Aq1Z67VxF7eytCW9bkL6PgirFXjpg6pHFI483p7y9lVz2ec5p?=
 =?us-ascii?q?LSAQUOVpLxSF04+AZmp7zBZik86YXU2WdqMaaqrj/Iw8gpC/c9yha8Y9dfN7?=
 =?us-ascii?q?uJFAvzE80cGsivJ/UmlEWubh0YJ+1S6qE0MN28d/ec266kIvxgnDS4gmRD+o?=
 =?us-ascii?q?x91ViM9yVkQO7Sw5kF2+2Y3heAVzrkiFehs8b3mZ1LZD0LBGW/0zTrBI5Ka6?=
 =?us-ascii?q?1scoYEF32uL9e0xtpgnZ7tXWBX9Fq5C1MBws+pdgKYb0bh0g1IyUQXvXunlD?=
 =?us-ascii?q?O8zzx1lTEps6We0DXNw+v8bhoHPHBERG15gFfyLoi7kcoaUFKrbwc3jhul41?=
 =?us-ascii?q?j1x6xBqKR4NWnTThQAQy+jDGxvSeObsb2BK5pM5Z4zuiJQU8y3YUqdT7/gpl?=
 =?us-ascii?q?0dySy1TEVEwzVuTC2nopX0mVRBjWuZKHti5C7CddpY2QbU5NuaQ+VYmDUBWn?=
 =?us-ascii?q?8r2nHsGlGgMozxrp2vnJDZv7X7Djj5Ww=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2DrAACBGrVb/wHyM5BbGwEBAQEDAQEBBwMBAQGDNSqBZ?=
 =?us-ascii?q?SiDdJR7BgaBCAgliG2PaTYBhEAChCAhOBQBAwEBAQEBAQIBbCiCNSQBgl8BB?=
 =?us-ascii?q?SMVQRALGAICJgICVwYNBgIBAYJeP4F1DaVTgS6Ed4UegQuKFhd5gQeBOQyCX?=
 =?us-ascii?q?4d/glcCiFGFSECOdAmJWIZgBheNEIJSlyohgVUrCAIYCCEPO4JskHAjMHsBA?=
 =?us-ascii?q?Y0YAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 03 Oct 2018 19:41:59 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w93Jfugd000579;
        Wed, 3 Oct 2018 15:41:56 -0400
Subject: Re: [PATCH security-next v4 23/32] selinux: Remove boot parameter
To:     Kees Cook <keescook@chromium.org>
Cc:     John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        Jordan Glover <Golden_Miller83@protonmail.ch>,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20181002005505.6112-1-keescook@chromium.org>
 <CAHC9VhQjMfH6Q+Tif8nBknZojgxrb6x+oDz4vHRiZN8rb8MZ5Q@mail.gmail.com>
 <785ef6a9-ae46-3533-0348-74bcf6f10928@tycho.nsa.gov>
 <CAGXu5jKNzG3rGUAV39D0w4txHRG3H2qU1Z1e_b+03OgycTaWqA@mail.gmail.com>
 <809f1cfd-077b-ee58-51ba-b22daf46d12b@tycho.nsa.gov>
 <QpdcE4QSCQKJqDmB2QBEGBlnlioHuRHlM0g5HF8KbHjU1zIUAOjnQ2r9EIMu3m0S2OWNR3_M_TSp_M6CVDqkp6kKuFPUvegsyDPNw1AGju4=@protonmail.ch>
 <CAGXu5jKqXNbEvPr1axQtGCCnWsGhDgjynW5u326mcx4vZ1oH8g@mail.gmail.com>
 <abe03d09-4dcb-2b02-4102-5e108d617a42@canonical.com>
 <CAGXu5jJtC1gkJ0ZKDFroL8UzvjiPfmC+6EsrzyB0j0oETdSQQg@mail.gmail.com>
 <alpine.LRH.2.21.1810030758460.23596@namei.org>
 <CAGXu5jLKgrdhah-5TtAXDL-odbLGeyAUH2=PkAU769AkEnZFfQ@mail.gmail.com>
 <5955f5ce-b803-4f58-8b07-54c291e33da5@canonical.com>
 <CAGXu5jKqSZ5LhQ_HwbA9-_DAg3efNzWfLjpxO_rurBgUZ-nnAA@mail.gmail.com>
 <583a703e-18af-a1b2-dfc9-62a2a3384825@tycho.nsa.gov>
 <CAGXu5jLmQQd4e=B3YsiEoRVih2m889ia2tnzu5r8bqcms2sOqQ@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <cf40d66d-6594-7efc-54b6-004f2e74bcb3@tycho.nsa.gov>
Date:   Wed, 3 Oct 2018 15:43:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5jLmQQd4e=B3YsiEoRVih2m889ia2tnzu5r8bqcms2sOqQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/2018 01:26 PM, Kees Cook wrote:
> On Wed, Oct 3, 2018 at 6:39 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On 10/02/2018 07:54 PM, Kees Cook wrote:
>>>
>>> On Tue, Oct 2, 2018 at 4:46 PM, John Johansen
>>> <john.johansen@canonical.com> wrote:
>>>>
>>>> On 10/02/2018 04:06 PM, Kees Cook wrote:
>>>>>
>>>>> I think the current proposal (in the other thread) is likely the
>>>>> sanest approach:
>>>>>
>>>>> - Drop CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE
>>>>> - Drop CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE
>>>>> - All enabled LSMs are listed at build-time in CONFIG_LSM_ENABLE
>>>>
>>>>
>>>> Hrrmmm isn't this a Kconfig selectable list, with each built-in LSM
>>>> available to be enabled by default at boot.
>>>
>>>
>>> That's not how I have it currently. It's a comma-separated a string,
>>> including the reserved name "all". The default would just be
>>> "CONFIG_LSM_ENABLE=all". Casey and I wanted this to have a way to
>>> capture new LSMs by default at build-time.
>>>
>>>>> - Boot time enabling for selinux= and apparmor= remain
>>>>> - lsm.enable= is explicit: overrides above and omissions are disabled
>>>>
>>>> wfm
>>>
>>>
>>> Okay, this is closer to v3 than v4. Paul or Stephen, how do you feel
>>> about losing the SELinux bootparam CONFIG? (i.e. CONFIG_LSM_ENABLE
>>> would be replacing its functionality.)
>>
>>
>> I'd like to know how distro kernel maintainers feel about it. They would
>> need to understand that if they were previously setting
>> CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE to 0 and want to preserve that
>> behavior, then they must set CONFIG_LSM_ENABLE explicitly to a list of
>> security modules (that does not include selinux, of course).  In practice,
> 
> That's not how it would be done. See below...
> 
>> this means that even the distros that choose to build all security modules
>> into their kernels must explicitly set CONFIG_LSM_ENABLE to a specific list
>> of security modules.  So no one would use "all" in practice.
> 
> This is why I had originally wanted to do CONFIG_LSM_DISABLE. Right
> now, distro kernel maintainers have two ways to trigger enablement:
> via the SELinux and AppArmor BOOTPARAM_VALUE _and_ DEFAULT_SECURITY
> (which is an implicit "enable" for Smack or TOMOYO). All the minors
> are on-if-built. So, really, the BOOTPARAM_VALUEs were only used for
> disabling. Distros would build what they wanted, then use
> DEFAULT_SECURITY for their desired major, and if their
> DEFAULT_SECURITY wasn't SELinux or AppArmor, they'd _also_ have to set
> those BOOTPARAM_VALUEs to 0.
> 
> The goal of the series is to split this more cleanly between "enable"
> and "order": the way to handle the LSMs is to enable _everything_ and
> then set the desired init order: the first exclusive "wins". So I *do*
> think the default would be CONFIG_LSM_ENALBE=all, since it's
> CONFIG_LSM_ORDER= that effectively replaces CONFIG_DEFAULT_SECURITY.
> 
> Either a distro builds a very specific subset of LSMs, or they build
> in all LSMs (for the user to choose from). In both cases, they set an
> explicit order, which defines which exclusive LSM get selected.
> 
> AppArmor wants to drop BOOTPARAM_VALUE, which make sense, since it's
> even now redundant to CONFIG_DEFAULT_SECURITY. I think it makes sense
> to drop SELinux's BOOTPARAM_VALUE too. The current way to "enable" a
> major LSM is via CONFIG_DEFAULT_SECURITY. No sane distro kernel is
> going to set CONFIG_DEFAULT_SECURITY=selinux and
> CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE=0. If you wanted no major LSM
> (but still build them all in), you'd set CONFIG_DEFAULT_SECURITY="".

Ok, then I have no objection to removing BOOTPARAM_VALUE.
