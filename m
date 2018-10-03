Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD1CC64EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3479A20684
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:37:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3479A20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbeJCUZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 16:25:47 -0400
Received: from upbd19pa10.eemsg.mail.mil ([214.24.27.85]:9388 "EHLO
        upbd19pa10.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbeJCUZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 16:25:47 -0400
X-EEMSG-check-008: 172424293|UPBD19PA10_EEMSG_MP10.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by upbd19pa10.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 03 Oct 2018 13:37:16 +0000
X-IronPort-AV: E=Sophos;i="5.54,336,1534809600"; 
   d="scan'208";a="18979063"
IronPort-PHdr: =?us-ascii?q?9a23=3Aza8k7xxqW16ag87XCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd0uwVKfad9pjvdHbS+e9qxAeQG9mDtLQc06L/iOPJYSQ4+5GPsXQPItRndi?=
 =?us-ascii?q?QuroEopTEmG9OPEkbhLfTnPGQQFcVGU0J5rTngaRAGUMnxaEfPrXKs8DUcBg?=
 =?us-ascii?q?vwNRZvJuTyB4Xek9m72/q99pHPYQhEniaxba9vJxiqsAvdsdUbj5F/Iagr0B?=
 =?us-ascii?q?vJpXVIe+VSxWx2IF+Yggjx6MSt8pN96ipco/0u+dJOXqX8ZKQ4UKdXDC86PG?=
 =?us-ascii?q?Av5c3krgfMQA2S7XYBSGoWkx5IAw/Y7BHmW5r6ryX3uvZh1CScIMb7Vq4/Vy?=
 =?us-ascii?q?i84Kh3SR/okCYHOCA/8GHLkcx7kaZXrAu8qxBj34LYZYeYO/RkfqPZYNgUW2?=
 =?us-ascii?q?xPUMhMXCBFG4+wcZcDA+8HMO1FrYfyukEOoAOjCweyCuPhyjxGiHH40qI10e?=
 =?us-ascii?q?suDQ7I0Rc8H98MqnnYsMn5OakQXO2z0aLGzS/Db/RT2Trl9YbIbg4uoemMXb?=
 =?us-ascii?q?1ud8ra1FQhFwbfgVWUrYzqITOU3fkKvmiA8uVgTvmii3Inqg5tojivwd0gio?=
 =?us-ascii?q?/Sho0P0FzE+iJ5wJgsKNC+VUV1YsakHYNNuyyVOIZ6WMMvT3xytCokxbAKp4?=
 =?us-ascii?q?S3cDUMxZ863RDQceaHfJKN4h/7UeaRJip3i2x9dbKkghay7VCgyurhVsmoyF?=
 =?us-ascii?q?pKrjRKkt3Ltn0Vyxzc8NKHSvpg/ke6wzqPywDS5f1EIUAzj6bbLYIuwqUsmZ?=
 =?us-ascii?q?YJtETDHyv2lF33jK+QaEok5vCl5/nob7jpvJORN5J4hhvgPqkhhMCzG/k0Ph?=
 =?us-ascii?q?ALX2eB+OS80LPj/Vf+QLVPlvA2ibTWsIvBKMQHpq+2Hw9V0oE55xa5FDepys?=
 =?us-ascii?q?4UnXYALFJbYB6HlZTmO0nSIPDkCveym1esnyl1yPDdIrLhBZLNLnvYnbj9fb?=
 =?us-ascii?q?Z98UlcyA8yzdBC4pJYELYBIOj8WkXprtzXEgc5MxCow+bgENh91IQeWWKJAq?=
 =?us-ascii?q?ODMqPStl+I6fgpI+mXeoAVvi3wJOQ/6P7oin85n14dcrWz0psTcny3AvNmI0?=
 =?us-ascii?q?CBa3r2ntgBCXsKvhY5TOHyil2CVDlTZ2yoX6I9/TE2E4SmAp3GRo+zgbyNxi?=
 =?us-ascii?q?C7HodZZmpeEFCDDW/od5mYW/cLcC+cI8hhkjgZWre/TY8uzRagtA7+y7pjMO?=
 =?us-ascii?q?XU4C4VuJz42dht/e3Tkg0y9TtyD8SYyW6NTmV0knkUSD82xKp/u1Byyk+f0a?=
 =?us-ascii?q?hkhPxVDcRT6OlUUgc+LpPc1/Z1C832Wg7Ye9eJT1GmQs+4Dj0rUt0xxNoOaV?=
 =?us-ascii?q?5nG9q+lhDDwzaqA7gNmrOXHpM06bzT3njqKsZm13nG1LMuj0QoQstLK2KmnL?=
 =?us-ascii?q?dz+BTJCILTj0qZkKOqf7wG3CHR7GeD0XaOvEZAXQ5oT6rFW38fZlbXrdT//0?=
 =?us-ascii?q?/CTKGhCa4hMgRfzc6PMapKZsTtjVVBWvfsJs7SY3mrlGezGBaI3KmDYJDse2?=
 =?us-ascii?q?oDxindClAEmRgJ/XmaLQg+Gjuho2XGATNyD13veF3j8OlkpHOgUkA0zxuFb1?=
 =?us-ascii?q?Bv17qx5BEVn+eRS/IV3rIYpighry94E0q639LTE9CAvRZufL1AYdMh51dKzW?=
 =?us-ascii?q?bZtw17Ppy9IKFun0UefBprsEPzzRV3C5lAkMgzoHMvywp9NL+Y0FdfeD6Dw5?=
 =?us-ascii?q?DwNaPYKnPo8BCsdaHWwFfe38iS+qsV7/Q4sVrjthmzFkU+63Vnz8VV03yE65?=
 =?us-ascii?q?rWCwoSS4n+XVgr9xVho7HbbC8965nS1XJyLam+qiXC1M4xBOs51hageM9SMK?=
 =?us-ascii?q?eFFA/0Ds0bCNGiJ/Etm1e1dR8EIu9S+7AuP8+8dPuJxrSrPOB+kzKil2hH55?=
 =?us-ascii?q?p90k2U/SpmVuHIx4oFw+2f3gafUzf8jVGhst34mIxdfz4SBHawySj/CY5Paa?=
 =?us-ascii?q?19Y5wLBX2tI8Kp3NV+gYDiW3pC+F6kHVMG19ejeQCOYFzlwQ1QyUMXrGSjmS?=
 =?us-ascii?q?u5yTx0jj4oorOc3CPQ2eTicgQIOmpQSWl8glfjP5K0g8oZXEe2dQgpkgWq5U?=
 =?us-ascii?q?Lgy6hcvqR/IDqbfUAdXCX7NClJVayz/u6BbsNU45Qvsg1cUP67ZFGHT/j6uR?=
 =?us-ascii?q?RMl2vBGGtYjBI8dzisoZj/10h4j2KbanR0rHPfYsx27RzW4tvaRPVY2nwNQy?=
 =?us-ascii?q?wu2hfNAV3pBMWk5dWZkd/4t+m6U2+wHslIfTLD0ZKLtCz943ZjRxK4gabgyZ?=
 =?us-ascii?q?XcDQEm3HqjhJFRXiLSoUO5O9Oz2g=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BzAACgxLRb/wHyM5BcGgEBAQEBAgEBAQEHAgEBAQGDN?=
 =?us-ascii?q?SqBZSiDdJQ1TQEBAQEBBoEILYhtj2k2AYRAAoQgITgUAQMBAQEBAQECAWwog?=
 =?us-ascii?q?jUkAYJfAQUjFUEQCxgCAiYCAlcGAQwGAgEBgl4/gXUNpQqBLoR3hRiBC4oWF?=
 =?us-ascii?q?3mBB4E5gmuHf4JXAo4ZQI50CZA4BhePYpcqIYFVKwgCGAghDzuCbJBwIzB7A?=
 =?us-ascii?q?QGNHQEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 03 Oct 2018 13:37:15 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w93DbDC2012556;
        Wed, 3 Oct 2018 09:37:13 -0400
Subject: Re: [PATCH security-next v4 23/32] selinux: Remove boot parameter
To:     Kees Cook <keescook@chromium.org>,
        John Johansen <john.johansen@canonical.com>
Cc:     James Morris <jmorris@namei.org>,
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
 <20181002005505.6112-24-keescook@chromium.org>
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
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <583a703e-18af-a1b2-dfc9-62a2a3384825@tycho.nsa.gov>
Date:   Wed, 3 Oct 2018 09:39:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5jKqSZ5LhQ_HwbA9-_DAg3efNzWfLjpxO_rurBgUZ-nnAA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/2018 07:54 PM, Kees Cook wrote:
> On Tue, Oct 2, 2018 at 4:46 PM, John Johansen
> <john.johansen@canonical.com> wrote:
>> On 10/02/2018 04:06 PM, Kees Cook wrote:
>>> I think the current proposal (in the other thread) is likely the
>>> sanest approach:
>>>
>>> - Drop CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE
>>> - Drop CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE
>>> - All enabled LSMs are listed at build-time in CONFIG_LSM_ENABLE
>>
>> Hrrmmm isn't this a Kconfig selectable list, with each built-in LSM
>> available to be enabled by default at boot.
> 
> That's not how I have it currently. It's a comma-separated a string,
> including the reserved name "all". The default would just be
> "CONFIG_LSM_ENABLE=all". Casey and I wanted this to have a way to
> capture new LSMs by default at build-time.
> 
>>> - Boot time enabling for selinux= and apparmor= remain
>>> - lsm.enable= is explicit: overrides above and omissions are disabled
>> wfm
> 
> Okay, this is closer to v3 than v4. Paul or Stephen, how do you feel
> about losing the SELinux bootparam CONFIG? (i.e. CONFIG_LSM_ENABLE
> would be replacing its functionality.)

I'd like to know how distro kernel maintainers feel about it. They would 
need to understand that if they were previously setting 
CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE to 0 and want to preserve that 
behavior, then they must set CONFIG_LSM_ENABLE explicitly to a list of 
security modules (that does not include selinux, of course).  In 
practice, this means that even the distros that choose to build all 
security modules into their kernels must explicitly set 
CONFIG_LSM_ENABLE to a specific list of security modules.  So no one 
would use "all" in practice.
