Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=GAPPY_SUBJECT,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B1AC04AB8
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 23:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1BE920853
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 23:32:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1BE920853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbeINEoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 00:44:32 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47840 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbeINEob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 00:44:31 -0400
Received: from static-50-53-48-205.bvtn.or.frontiernet.net ([50.53.48.205] helo=[192.168.192.153])
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <john.johansen@canonical.com>)
        id 1g0b6M-0004nL-08; Thu, 13 Sep 2018 23:32:46 +0000
Subject: Re: [PATCH 10/10] LSM: Blob sharing support for S.A.R.A and LandLock
To:     Kees Cook <keescook@chromium.org>, Paul Moore <paul@paul-moore.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        LKML <linux-kernel@vger.kernel.org>,
        SE Linux <selinux@tycho.nsa.gov>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Schaufler, Casey" <casey.schaufler@intel.com>
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
 <99cb1ae7-8881-eb9a-a8cb-a787abe454e1@schaufler-ca.com>
 <CAGXu5jLONSfPHYYYTLSma-+arVHSQKaEWb9JxpOn6TNKtyLNhw@mail.gmail.com>
 <CAHC9VhQN0wq0zZS5BYU9jBomaWvCaJ_BqJjHF3AT7FG8Z0nLDQ@mail.gmail.com>
 <CAGXu5jJs6kmd6Tjgwqb2Zx7e-jNbHqfJ57poZuyz4Qj=AKVfmQ@mail.gmail.com>
 <CAHC9VhQ20tBAMwOJ9mg0tBHYUoxjh0Szr3d62HuPw2SyT4XDLw@mail.gmail.com>
 <CAGXu5jKec1JTsoqwKGThcJoamdL618AHu4jfFbqqQiauz1kjyg@mail.gmail.com>
 <CAHC9VhQwT4d3wC37cVrrX-hZq1L3e6=TEAse4m-YH9SiFnkieA@mail.gmail.com>
 <CAGXu5jLapViSK-j08Tq8cCZodiZXFsXze71xFPg6MQhDWDHDAA@mail.gmail.com>
 <CAGXu5j+j47FH5RF2vrJh95=YFX76oSBFo8O6GZqa0utcfE1AVA@mail.gmail.com>
From:   John Johansen <john.johansen@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=john.johansen@canonical.com; prefer-encrypt=mutual; keydata=
 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
Organization: Canonical
Message-ID: <0eb75e66-ed50-4013-6440-38bc2f814c6f@canonical.com>
Date:   Thu, 13 Sep 2018 16:32:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5j+j47FH5RF2vrJh95=YFX76oSBFo8O6GZqa0utcfE1AVA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/13/2018 04:06 PM, Kees Cook wrote:
> On Thu, Sep 13, 2018 at 2:51 PM, Kees Cook <keescook@chromium.org> wrote:
>> At the very least, to avoid stacking now (i.e. TOMOYO being enabled
>> with another major LSM), we just do nothing. The existing code already
>> makes the existing major LSMs exclusive. Adding a stackable LSM would
>> need to just have its own "enable" flag (i.e. ignore
>> security_module_enable()), and then either check a runtime "is
>> stacking allowed?" flag or have new "depends on SECURITY_STACKING". (I
>> think the CONFIG will force distros into enabling it without any
>> runtime opt-out.)
> 
> Before stacking, we have:
> 
> - major LSM, pick one
> - all CONFIG minor LSMs, in security.c order
> 
> There are two minor LSMs: Yama and LoadPin. If built, Yama is always
> on (though it has sysctl knobs). If built, LoadPin is controlled by a
> boot param.
> 
> Picking the major LSM happens via "security=$LSM" and a per-LSM check
> of security_module_enable("$LSM").
> 
> Ordering is major, then per security.c for minors.
> 
> 
> Under stacking, we have:
> 
> The minor LSMs remain unchanged.
> 
> We don't have SARA and Landlock yet, but we do have TOMOYO, which we
> can use as an example to future "compatible blob-using LSMs".
> 
> I see two issues:
> 
> - how to determine which set of LSMs are enabled at boot
> - how to determine the ORDER of the LSMs
> 
> 
> Casey's implementation does this (correct me if I'm wrong):
> 
> The minor LSMs remain unchanged.
> 
> SECURITY_$lsm_STACKED determines which major is enabled, with
> SECURITY_TOMOYO_STACKED allowed in addition. If security= is
> specified, all other major LSMs are disabled (i.e. it is not possible
> to switch between SELinux/AppArmor/SMACK without also disabling
> TOMOYO).
> 
> Ordering is per security/Makefile modulo enabled-ness for majors (i.e.
> TOMOYO is always _before_ AppArmor if stacked together, otherwise
> after SELinux and SMACK), and per security.c for minors.
> 
> 
> I don't think this is how we want it to work. For example, Ubuntu
> builds in all LSMs, and default-enables AppArmor. If an Ubuntu user
> wants TOMOYO, the boot with "security=tomoyo". If Ubuntu wants to make
> stacking available to users but off by default, what CONFIGs do they
> pick? They could try SECURITY_APPARMOR_STACKED=y and
> SECURITY_TOMOYO_STACKED=n, but then how does an end user choose
> "apparmor and tomoyo" (or more meaningfully, for the future:
> "apparmor, sara, and landlock")? They can still pick
> "security=tomoyo", but there isn't a runtime way to opt into stacking.
> 

Ubuntu is carrying an early set of the stacking patches and about a
dozen patches on top of that.

It allows choosing to build the LSMs separate from the what the
default LSM(s) are. There is some config patching here that I need to
update and drop onto this thread.

There is also a patch that allows selecting the set of LSMs at boot.

   security=selinux,apparmor

but yama and loadpin are treated differently and I never liked
that. But again another patch to rebase and drop on this thread for
discussion.


> 
> What about leaving SECURITY_$lsm_DEFAULT as-is, and then...
> 
> In the past I'd suggested using "security=" to determine both enabled
> and order: "security=tomoyo,smack" would mean stacked LSMs, with
> tomoyo going first.
> 
> Currently I'm leaning towards "security=" to select ONLY the
> incompatible LSM, and per-LSM "enable" flags to determine stacking:
> 
>     tomoyo.enabled=1 security=smack
>

I don't like this, it makes it hard for the end user specifying option
at boot time. They have to set security= for the modules they want and
then also individual modules $lsm.enabled= which is very inconvenient
for users.

apparmor.enabled really should only default to enabled and provides a
legacy way to disable apparmor during boot. This option was around
before security= was added.

I need to leave it available as its become part of the api (there are
applications checking /sys/module/apparmor/parameters/enabled but we
can remove it from the Kconfig.


> This doesn't explicitly address ordering, though. If we made param
> _position_ meaningful, then we could get ordering (i.e. above would
> mean "tomoyo first").
> 

yes, I think that makes sense

> Note, ordering matters because call_int_hook() will _stop_ on a
> non-zero return value: potentially hiding events from later LSMs. Do
> we need to revisit this? I seem to remember if being a very dead
> horse, and we needed to quick-abort otherwise we ended up in
> nonsensical states.
> 

we shouldn't be in nonsensical states but we are doing work that is
thrown away.

Another potential solution is allowing an LSM to register a set of
post hooks that will get called after the regular LSM hooks are
called. This would allow an LSM that cared about whether a hook
succeeded or not to do some processing.


> The reason for the new approach is because I can't find a meaningful
> way to provide CONFIGs that make sense. We want to provide a few
> things:
> 
> - is an LSM built into the kernel at all? (CONFIG_SECURITY_$lsm)
> - is an LSM enabled by default? (CONFIG_SECURITY_$lsm_ENABLED?)
> - has an LSM been enable for this boot? $lsm.enabled=1 or security=$lsm,$lsm ?

at least for apparmor it is apparmor.enabled=1 AND security=apparmor or security=$lsm,apparmor ...

> - what order should any stacking happen? Makefile? security=?
> 
Preferably not. For the single LSM we have the ability to choose the default LSM, ideally we let the distro decide in the Kconfig and the user with security=...

> And for the incompatible-major, do we stick with CONFIG_SECURITY_$lsm_DEFAULT ?

Ideally Kconfig wouldn't let you choose incompatible LSMs when
selecting what is going to be enabled by default.

> 
> 
> 
> Anyway, if the concern is with exposed behavior for distros, what do
> we want? i.e. what should be done for patch 10. Everything else looks
> good.
> 

well speaking for Ubuntu we want to be able to specify the default LSMs
and we want to enable our users to change this.

The current patchset we have is less than ideal partly because of the
whole $lsm.enabled vs security= mess that needs to be resolved.
