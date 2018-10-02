Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020F1C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6A6420666
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:56:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6A6420666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbeJBVkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 17:40:31 -0400
Received: from ucol19pa14.eemsg.mail.mil ([214.24.24.87]:5229 "EHLO
        ucol19pa14.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbeJBVkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 17:40:31 -0400
X-EEMSG-check-008: 627432046|UCOL19PA14_EEMSG_MP12.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.54,332,1534809600"; 
   d="scan'208";a="627432046"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by ucol19pa14.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 02 Oct 2018 14:56:19 +0000
X-IronPort-AV: E=Sophos;i="5.54,332,1534809600"; 
   d="scan'208";a="16433955"
IronPort-PHdr: =?us-ascii?q?9a23=3Az8DBMBzx92/g4nPXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd0u8XLvad9pjvdHbS+e9qxAeQG9mDtLQc06L/iOPJYSQ4+5GPsXQPItRndi?=
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
 =?us-ascii?q?Z98UlcyA8yzdBC4pJYELYBIOj8WkXprtzXEgc5MxCow+bgENh9zpkRWX+LAq?=
 =?us-ascii?q?KCKKPdq0KI5uY2L+mJY48Vvyz9JOY/6/Hyin85nEcXfbO10psPdHC4AvNmLl?=
 =?us-ascii?q?2bYXrphdcBC30KvgslTOHxjl2NSztTaGizX64m4TE7Eo2mB5/ZRo+xmLyBwD?=
 =?us-ascii?q?u7HppOa29aEF+MCmnndoWfVvcXdC2SItVukiEKVbilVYAhzwiiuxPgxLZ9Mu?=
 =?us-ascii?q?XU/SgYv4r51Ndp/+3TiQ0y9TtsAsSf1GGNT2d0knkKRz8x3KBwu0p9ykyd3q?=
 =?us-ascii?q?h+mPFXCcZc5/VOUgc8NJ7T0/Z1C9ToVg3dedeJTU6sQs+6DjEpUtIx39gObl?=
 =?us-ascii?q?5lG9q8iBDD0DeqA74Tl7CSB5w77Ljc337vKMZ50HvG1bAtj10hQstRK2KqnL?=
 =?us-ascii?q?V/+BLQB47UiUWWjbymdaIC0yLX9meD1XKEvFtEXw5oTaXFQXcfa1PKotvj/U?=
 =?us-ascii?q?PNUb+vBa48MgRdyc6NMLZKatPtjVpYXvfuI9XeY2Stm2iuARaE3K+DbI3ve2?=
 =?us-ascii?q?8FxiXSFFAEkxwP/XaBLQU+Aiaho2TDDD1hDF7veF3j/vVjqHOhT0800wGLY1?=
 =?us-ascii?q?Rk17qy5xEVmPicRO0I07IatycutS90EEy+393IEdqAoRRufKFGbdM6+ldH2n?=
 =?us-ascii?q?rTtxZhMZy4M6BimlkefhxrsEPpzRV4EZtPkdQxoXMuwgtyL7iU0FVfeDOExZ?=
 =?us-ascii?q?rwIKHYKnHu/BCzbK7bwlXe0NeQ+qcS5/U0skjsvAa1GUc57XVn3Mda02GG6p?=
 =?us-ascii?q?XJEgUSS5TxXVgz9xRgoLHaeCY97ZvO1XJwKam0riPC29UxCeshyxagecpfMa?=
 =?us-ascii?q?ydGADoCc0VG8iuJfc0m1imcB0EJvpe9K0qMMO8cfuJxqqrMPxnnDK8gmRN+J?=
 =?us-ascii?q?p93V6U9ypgVu7I2I4Iw/WZ3guBSjf9g06tssPploBeYzEdAG6/xDP6BI5eeK?=
 =?us-ascii?q?JyZ5wHCWSwLM2twNVxmZrtV2Rf9F65CFNVkPOuLDmfYke19gpX1gxDonGqgi?=
 =?us-ascii?q?C/yD9cmDEzqa+ewSmIxP7tIkkpIGlOEVJ+gE/sLI78tNUTWEylfkB9jxe+zV?=
 =?us-ascii?q?rrzKhc4qJkJi/cRlkeLHu+FH1rTqbl7unKWMVI8p599HwNCOk=3D?=
X-IPAS-Result: =?us-ascii?q?A2AfAACYhrNb/wHyM5BaGwEBAQEDAQEBBwMBAQGBUoFjK?=
 =?us-ascii?q?oFlKIN0lDBSBoE1iG2Nb4F6NgGEQAKEDiE1FwEDAQEBAQEBAgFsKII1JAGCX?=
 =?us-ascii?q?wEFIxVBEAsYAgImAgJXBg0GAgEBgl4/gXUNpkOBLoR3hSWBC4l4F3mBB4ESJ?=
 =?us-ascii?q?4Jrh3+CVwKIUIVCQI5qCZAyBhePWpcEATWBVSsIAhgIIQ+DJ4M3AQmNLyMwe?=
 =?us-ascii?q?wEBjVcBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 02 Oct 2018 14:56:20 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w92EuHaf010320;
        Tue, 2 Oct 2018 10:56:17 -0400
Subject: Re: [PATCH security-next v4 23/32] selinux: Remove boot parameter
To:     Kees Cook <keescook@chromium.org>
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
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <809f1cfd-077b-ee58-51ba-b22daf46d12b@tycho.nsa.gov>
Date:   Tue, 2 Oct 2018 10:58:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5jKNzG3rGUAV39D0w4txHRG3H2qU1Z1e_b+03OgycTaWqA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/2018 10:44 AM, Kees Cook wrote:
> On Tue, Oct 2, 2018 at 6:42 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On 10/02/2018 08:12 AM, Paul Moore wrote:
>>>
>>> On Mon, Oct 1, 2018 at 9:04 PM Kees Cook <keescook@chromium.org> wrote:
>>>>
>>>> Since LSM enabling is now centralized with CONFIG_LSM_ENABLE and
>>>> "lsm.enable=...", this removes the LSM-specific enabling logic from
>>>> SELinux.
>>>>
>>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>>> ---
>>>>    .../admin-guide/kernel-parameters.txt         |  9 ------
>>>>    security/selinux/Kconfig                      | 29 -------------------
>>>>    security/selinux/hooks.c                      | 15 +---------
>>>>    3 files changed, 1 insertion(+), 52 deletions(-)
>>>>
>>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt
>>>> b/Documentation/admin-guide/kernel-parameters.txt
>>>> index cf963febebb0..0d10ab3d020e 100644
>>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>>> @@ -4045,15 +4045,6 @@
>>>>                           loaded. An invalid security module name will be
>>>> treated
>>>>                           as if no module has been chosen.
>>>>
>>>> -       selinux=        [SELINUX] Disable or enable SELinux at boot time.
>>>> -                       Format: { "0" | "1" }
>>>> -                       See security/selinux/Kconfig help text.
>>>> -                       0 -- disable.
>>>> -                       1 -- enable.
>>>> -                       Default value is set via kernel config option.
>>>> -                       If enabled at boot time, /selinux/disable can be
>>>> used
>>>> -                       later to disable prior to initial policy load.
>>>
>>>
>>> No comments yet on the rest of the patchset, but the subject line of
>>> this patch caught my eye and I wanted to comment quickly on this one
>>> ...
>>>
>>> Not a fan unfortunately.
>>>
>>> Much like the SELinux bits under /proc/self/attr, this is a user
>>> visible thing which has made its way into a lot of docs, scripts, and
>>> minds; I believe removing it would be a big mistake.
>>
>>
>> Yes, we can't suddenly break existing systems that had selinux=0 in their
>> grub config.  We have to retain the support.
> 
> Is it okay to only support selinux=0 (instead of also selinux=1)?

For Fedora/RHEL kernels, selinux=1 would be redundant since it is the 
default.  However, in other distros where SELinux is not the default, I 
think they have documented selinux=1 as the way to enable SELinux.  So 
users may be relying on that as well. I don't think we can safely drop 
support for either one.  Sorry.
