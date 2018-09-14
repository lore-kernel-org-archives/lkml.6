Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,GAPPY_SUBJECT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82DDFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 00:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85F0C2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 00:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="V9NkIe/c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85F0C2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbeINFPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 01:15:42 -0400
Received: from sonic311-29.consmr.mail.ne1.yahoo.com ([66.163.188.210]:38128
        "EHLO sonic311-29.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726939AbeINFPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 01:15:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1536883434; bh=KwkHP5YDYbvY8PCtLTk+LZqVJSk+cGSwgxM2XR/WbfE=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=V9NkIe/cManpTJPskrWMd88YDqHIQpFPMQ7mihTjZt25JR+qUVRuZBP25gbuXQE1oxNx9azUBz6HisDyppEmfU7HF1VDqFW2bqpTFNxtlcCzdtTnPgGzGNEhmwT5KtemWltmffnfsNySMlD+xMhKQOW4Tg5NQA4W5vBwp6KWdK1j2TP5fLit7J+0FRv4pdc6++8x3K5dmZYfmp8pInwMCksa61zRjMt8l3D7rk0Ald9RV4JJ54vG4sjAnMqp5Nliv7NGKVbNG+wDPz1E1TUmkwrQMh86rBtyWOF2TjfsquCPuE/rgoQu+fUXRrNXJ2XgPpCCoi9y9d1ZpmZBPSk8ow==
X-YMail-OSG: kxavvygVM1nqdUlvR.Aj9blZQVnjQN9_jyMoCrENsWfDifYWTNSU08Hd8PmpwC5
 iii7UQHsuyAr2eQuQsn8X5rWZ0891akRr1MHR176ZA3yUk2CUsx3Ljs863oNDMGibjTvCgLz1RmI
 CXUBTYVIHJhCcovr8VTvajHhEbRAY5Fi2Ptag._yRibXZLBm18PDhDdYdRl1UabIBkLa64paFQsb
 HRe6EvFHfYBlMUlqDTnP9VYtrUI_m6NY0Y5qtLSZYUM1JgEXyV7UAiv2ERm3YW7kIA2mdNwXzXOZ
 QwUnUYjJSzREdmNMtbRVbRtv6.lw3sEYFQa9a8gg00_oSNwzYZ86SEcCAiAisopcee3HgGHVuQwP
 pDwkHvq9IV_nd7wmKHlgfaIudSq5tPuv7grWEoZnbfwLv_Ao0UpOiTHL3gcUtFMZ18XbvwIYhYab
 _XqxXLJu0GR1ZBnWP_IGxSXS3BjGHseK9ooFWucKp_3lXvm8mVMOjS.2aiCzj8GtK8wkBQVGFUPS
 S935RqjplN6XRvFj9sEZ2zSwIi5KKGIDJ54cnLfnhJtvurm7jZxtCwxuB_32RiuBCaXwpNnHog.Q
 SHpRGf__1c2ANMZMp8j_EplB1gBJe2Dt0lZSrs.8WimrAffHxq1pTzNyMib6zTPZPVUZwG1Gc.An
 Tem8Oop5avfg.1gij6vnV0EnNuvG8TwILNap5zMLDWd_QiydSUhmVCsk3DjP.aydQ9G6bELUkpyL
 vNKI_w7aeqbLedW3GiQachvPLMbaOLuStYvFaMI.l7spqUgpv7cVPL8nwosqXIcvQhXvs3A_ymi0
 XIfi3wG3q.fWgZmKqCAYAm0g3F7p87zvpSr6nH9ChoI1___nMW.C3M5z2ZcR5KDyPwxZYL_llp4g
 l_fXJY9K.akBf39svb0qCj0pV09Nku_fFVX81CbOAqzGaycuthHedUVDo8Xr2WvBnqdizpOY3l1.
 Uf_r55T3H5r0FH5kSm7m5WN9b.T0wZP42J1YLsiO20HNRkD6aWK7cigxHN1LLxso_w8TfkveoMNH
 Q8tZUp7CfpWdN234-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Fri, 14 Sep 2018 00:03:54 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp427.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID ba9551b23cf89fcd004e95b6ce426145;
          Fri, 14 Sep 2018 00:03:53 +0000 (UTC)
Subject: Re: [PATCH 10/10] LSM: Blob sharing support for S.A.R.A and LandLock
To:     Kees Cook <keescook@chromium.org>,
        John Johansen <john.johansen@canonical.com>
Cc:     Paul Moore <paul@paul-moore.com>,
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
 <0eb75e66-ed50-4013-6440-38bc2f814c6f@canonical.com>
 <CAGXu5jKZ7rquTux5fS+5tQ==0w_9rDTRaJWS_mS7C+Fy2dXRRQ@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <a2ffa6b7-5d05-39a1-11c3-d715566e4d51@schaufler-ca.com>
Date:   Thu, 13 Sep 2018 17:03:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5jKZ7rquTux5fS+5tQ==0w_9rDTRaJWS_mS7C+Fy2dXRRQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/2018 4:51 PM, Kees Cook wrote:
> On Thu, Sep 13, 2018 at 4:32 PM, John Johansen
> <john.johansen@canonical.com> wrote:
>> On 09/13/2018 04:06 PM, Kees Cook wrote:
>>> - what order should any stacking happen? Makefile? security=?
>>>
>> Preferably not. For the single LSM we have the ability to choose the default LSM, ideally we let the distro decide in the Kconfig and the user with security=...
> I can't find a non-crazy way to do this in Kconfig. Right now, if I
> threw out all the _DEFAULT stuff, I could do:
>
> config SECURITY_SELINUX_ENABLED
>         bool "SELinux LSM enabled at boot time"
>         depends on SECURITY_SELINUX
>         depends on !SECURITY_APPARMOR_ENABLED && !SECURITY_SMACK_ENABLED
>         default SECURITY_SELINUX
>
> config SECURITY_SMACK_ENABLED
>         bool "SMACK LSM enabled at boot time"
>         depends on SECURITY_SMACK
>         depends on !SECURITY_APPARMOR_ENABLED && !SECURITY_SELINUX_ENABLED
>         default SECURITY_SMACK
>
> config SECURITY_APPARMOR_ENABLED
>         bool "AppArmor LSM enabled at boot time"
>         depends on SECURITY_APPARMOR
>         depends on !SECURITY_SMACK_ENABLED && !SECURITY_SELINUX_ENABLED
>         default SECURITY_APPARMOR
>
> config SECURITY_TOMOYO_ENABLED
>         bool "TOMOYO LSM enabled at boot time"
>         depends on SECURITY_TOMOYO
>         default y if !SECURITY_SELINUX_ENABLED &&
> !SECURITY_SMACK_ENABLED && !SECURITY_APPARMOR_ENABLED
>
> config DEFAULT_SECURITY
>         string
>         default "selinux" if SECURITY_SELINUX_ENABLED
>         default "smack" if SECURITY_SMACK_ENABLED
>         default "apparmor" if SECURITY_APPARMOR_ENABLED
>         default "tomoyo" if SECURITY_TOMOYO_ENABLED
>
> (As before CONFIG_DEFAULT_SECURITY basically means the effective
> "security=" contents. Reminder than Kconfig default are "first match",
> so tomoyo would only happen if all others are not enabled by default.)
>
> But this doesn't provide a way for Kconfig to declare the ordering of
> TOMOYO followed by SELinux. If we just declare ordering is a function
> of the Makefile, then the above would work as expected. The
> "conflicting major LSM" could be specified on "security=" and stacked
> could be enabled with $lsm.enable=1 (or disabled).
>
> So, before we can really make a decision, I think we have to decide:
> should ordering be arbitrary for even this level of stacking?

Do we have a case where it matters? I know that I could write a
module that would have issues if one hook got called and another
didn't because because a precursor module hook failed. I don't
think that any of the existing modules have this problem.

