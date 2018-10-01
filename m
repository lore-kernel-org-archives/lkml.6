Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5E4C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 23:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54857213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 23:44:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54857213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbeJBGYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 02:24:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52738 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbeJBGYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 02:24:49 -0400
Received: from static-50-53-48-205.bvtn.or.frontiernet.net ([50.53.48.205] helo=[192.168.192.153])
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <john.johansen@canonical.com>)
        id 1g77ra-0005vN-85; Mon, 01 Oct 2018 23:44:30 +0000
Subject: Re: [PATCH security-next v3 18/29] LSM: Introduce lsm.enable= and
 lsm.disable=
To:     Kees Cook <keescook@chromium.org>
Cc:     Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20180925001832.18322-1-keescook@chromium.org>
 <20180925001832.18322-19-keescook@chromium.org>
 <68e4e323-3216-7e77-2807-c3207126ae68@canonical.com>
 <CAGXu5j+jzmFh-iuXDVHQTq7e=mftpfaqS-45TP_UR3B+qtGcLQ@mail.gmail.com>
 <9b3e1733-7cfa-5047-1422-0f9d92d88d39@canonical.com>
 <CAGXu5jJheexJgnJ+OWaDoRFraqm9yxj1Vr290tfZ7kELBPUpAw@mail.gmail.com>
From:   John Johansen <john.johansen@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=john.johansen@canonical.com; prefer-encrypt=mutual; keydata=
 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
Organization: Canonical
Message-ID: <b2952ffe-545f-931f-e6a2-589be5ac8ac0@canonical.com>
Date:   Mon, 1 Oct 2018 16:44:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5jJheexJgnJ+OWaDoRFraqm9yxj1Vr290tfZ7kELBPUpAw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/01/2018 04:30 PM, Kees Cook wrote:
> On Mon, Oct 1, 2018 at 3:48 PM, John Johansen
> <john.johansen@canonical.com> wrote:
>> On 10/01/2018 03:27 PM, Kees Cook wrote:
>>> On Mon, Oct 1, 2018 at 2:46 PM, John Johansen
>>> <john.johansen@canonical.com> wrote:
>>>> On 09/24/2018 05:18 PM, Kees Cook wrote:
>>>>> This introduces the "lsm.enable=..." and "lsm.disable=..." boot parameters
>>>>> which each can contain a comma-separated list of LSMs to enable or
>>>>> disable, respectively. The string "all" matches all LSMs.
>>>>>
>>>>> This has very similar functionality to the existing per-LSM enable
>>>>> handling ("apparmor.enabled=...", etc), but provides a centralized
>>>>> place to perform the changes. These parameters take precedent over any
>>>>> LSM-specific boot parameters.
>>>>>
>>>>> Disabling an LSM means it will not be considered when performing
>>>>> initializations. Enabling an LSM means either undoing a previous
>>>>> LSM-specific boot parameter disabling or a undoing a default-disabled
>>>>> CONFIG setting.
>>>>>
>>>>> For example: "lsm.disable=apparmor apparmor.enabled=1" will result in
>>>>> AppArmor being disabled. "selinux.enabled=0 lsm.enable=selinux" will
>>>>> result in SELinux being enabled.
>>>>>
>>>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>>>
>>>> I don't like this. It brings about conflicting kernel params that are
>>>> bound to confuse users. Its pretty easy for a user to understand that
>>>> when they specify a parameter manually at boot, that  it overrides the
>>>> build time default. But conflicting kernel parameters are a lot harder
>>>> to deal with.
>>>>
>>>> I prefer a plain enabled= list being an override of the default build
>>>> time value. Where conflicts with LSM-specific configs always result in
>>>> the LSM being disabled with a complaint about the conflict.
>>>>
>>>> Though I have yet to be convinced its worth the cost, I do recognize
>>>> it is sometimes convenient to disable a single LSM, instead of typing
>>>> in a whole list of what to enable. If we have to have conflicting
>>>> kernel parameters I would prefer that the conflict throw up a warning
>>>> and leaving the LSM with the conflicting config disabled.
>>>
>>> Alright, let's drill down a bit more. I thought I had all the
>>> requirements sorted out here. :)
>>>
>>> AppArmor and SELinux are "special" here in that they have both:
>>>
>>> - CONFIG for enable-ness
>>> - boot param for enable-ness
>>>
>>> Now, the way this worked in the past was that combined with
>>> CONFIG_DEFAULT_SECURITY and the link-time ordering, this resulted in a
>>> way to get the LSM enabled, skipped, etc. But it was highly CONFIG
>>> dependent.
>>>
>>> SELinux does:
>>>
>>> #ifdef CONFIG_SECURITY_SELINUX_BOOTPARAM
>>> int selinux_enabled = CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE;
>>>
>>> static int __init selinux_enabled_setup(char *str)
>>> {
>>>         unsigned long enabled;
>>>         if (!kstrtoul(str, 0, &enabled))
>>>                 selinux_enabled = enabled ? 1 : 0;
>>>         return 1;
>>> }
>>> __setup("selinux=", selinux_enabled_setup);
>>> #else
>>> int selinux_enabled = 1;
>>> #endif
>>> ...
>>>         if (!security_module_enable("selinux")) {
>>>                 selinux_enabled = 0;
>>>                 return 0;
>>>         }
>>>
>>>         if (!selinux_enabled) {
>>>                 pr_info("SELinux:  Disabled at boot.\n");
>>>                 return 0;
>>>         }
>>>
>>>
>>> AppArmor does:
>>>
>>> /* Boot time disable flag */
>>> static bool apparmor_enabled = CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE;
>>> module_param_named(enabled, apparmor_enabled, bool, S_IRUGO);
>>>
>>> static int __init apparmor_enabled_setup(char *str)
>>> {
>>>         unsigned long enabled;
>>>         int error = kstrtoul(str, 0, &enabled);
>>>         if (!error)
>>>                 apparmor_enabled = enabled ? 1 : 0;
>>>         return 1;
>>> }
>>>
>>> __setup("apparmor=", apparmor_enabled_setup);
>>> ...
>>>         if (!apparmor_enabled || !security_module_enable("apparmor")) {
>>>                 aa_info_message("AppArmor disabled by boot time parameter");
>>>                 apparmor_enabled = false;
>>>                 return 0;
>>>         }
>>>
>>>
>>> Smack and TOMOYO each do:
>>>
>>>         if (!security_module_enable("smack"))
>>>                 return 0;
>>>
>>>         if (!security_module_enable("tomoyo"))
>>>                 return 0;
>>>
>>>
>>> Capability, Integrity, Yama, and LoadPin always run init. (This series
>>> fixes LoadPin to separate enable vs enforce, so we can ignore its
>>> "enable" setting, which isn't an "am I active?" boolean -- its init
>>> was always run.) With the enable logic is lifted out of the LSMs, we
>>> want to have "implicit enable" for 6 of 8 of the LSMs. (Which is why I
>>> had originally suggested CONFIG_LSM_DISABLE, since the normal state is
>>> enabled.) But given your feedback, I made this "implicit disable" and
>>> added CONFIG_LSM_ENABLE instead. (For which "CONFIG_LSM_ENABLE=all"
>>> gets the same results.)
>>>
>>>
>>> I think, then, the first question (mainly for you and Paul) is:
>>>
>>> Should we remove CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE and
>>> CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE in favor of only
>>> CONFIG_LSM_ENABLE?
>>>
>>
>> We can remove the Kconfig for the apparmor bootparam value. In fact I
>> will attach that patch below. I can't get rid of the parameter as it
>> is part of the userspace api. There are tools and applications
>> checking /sys/module/apparmor/parameters/enabled
>>
>> but we can certainly default it to enabled and make it work only as a
>> runtime kernel parameter to disable apparmor which is how it has been
>> traditionally been used.
>>
>>> The answer will affect the next question: what should be done with the
>>> boot parameters? AppArmor has two ways to change enablement:
>>> apparmor=0/1 and apparmor.enabled=0/1. SELinux just has selinux=0/1.
>>> Should those be removed in favor of "lsm.enable=..."? (And if they're
>>> not removed, how do people imagine they should interact?)
>>
>> I am not against removing the apparmor one, it does mean retraining
>> users but it is seldmon used so it may be worth dropping. If we keep
>> it, it should be a disable only flag that where the use of apparmor=0
>> or apparmor.enable=0 (same thing) means apparmor is disabled.
> 
> If we keep it, "apparmor=0 lsm_enable=apparmor" would mean it's
> enabled. Is that okay?
> 
ugh I would rather get rid of apparmor=0 or to emit a warning with apparmor
disabled, but if we have to live with it then yes I can live with last
option wins


