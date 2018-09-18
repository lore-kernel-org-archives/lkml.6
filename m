Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE446ECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FC1B214C2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Ya53GYYQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FC1B214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbeIRG1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 02:27:45 -0400
Received: from sonic306-10.consmr.mail.bf2.yahoo.com ([74.6.132.49]:38213 "EHLO
        sonic306-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728949AbeIRG1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 02:27:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1537232267; bh=7DzrIR7KE4iCLcTnQFNpXgZZusQcty4T3ZgJ/8eXBe4=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=Ya53GYYQEkGXEprxH/bT05fUhnoCN5mzCnUHuJ2l6qW6IXiHzRZeUlMNOmIfVA4WeT22dxsHc0qtG5U3RYnK56VMHcIp43EHpkQOmKX68/a7F1rFme5rYIV5APiVMkNBt1FlT4tcBEqsjuGDCxEOUAUOjZzEuZbInIJMX1EVu36xaBVP8EcoWukZtDHq4ch4mj7QwORT+ADaGndhEsyLYcVMOkCXkMReMqfYV8+q3x9JYoqQLD+80lTyQaZPM9EujH+1rryqPrtSHyHhLxY4CUWOj+MFt+NcK90o8qjWfPjulG4TdV0PIzkDaOqcz8mYY8GlV5nCegdgNEkDtXCcCQ==
X-YMail-OSG: SwqoynsVM1n9cYebMKpX9vvHyChnKOybmp68hp4Bhg9u_2kKndlrvdKuHALChAn
 Xu_RSiU9qMarkIzf5TuivJ13X1XhfugqCijGb26lx8vEZQoHtZ_am6JSjW_ES_b8t.ra0gUftJud
 jWL8LlNUObVGOyDF430ZZyKu6rTAkC7et8SRbBdJTMsiFh5eGx3ZuF135aHjcSjb1YoZLDk62PjR
 0Ku8XhpK3Fb4GezYbFrxIxVwUBMyvJIqP1HLgWIMoAum8Ml1XbtTaLaLUSw2ltaJC2ncZHTorTTE
 aMEE87Gi42qpenVKI2.EUpR6623kuXrYv6YSSrIr2NGgNf_x9B_h731gBj9W0tvDEOcF.LZMOqTv
 dC70TPVrYE.Rna474bAOrhM795quYetPjEu8R6r.w8E3c98mi4ntcXJk8qdWzSwLLFnYQ5LOteCP
 LsyE9AXXWHxU7DzF_7ZxV3_VwSFm6qEKftpv5uyTcSzpahHq2saqpWIryhtUzwoEIyDK2xZiS0fg
 ZMhmoLS_WsN4n6AREAi7RouFZ9dXdqmIce19rj8aj_BwXILpCkLQvryHgEh7nJUk7Z.6swBzjD0e
 m1tSjpqybBp91JQs8GvEK9OsMozQ2u9JexGySDNOBFstGs_9fB6afO5gzbVJXMRdHZgiQlTj47Ts
 B1CMF_tDzQl5iCx.iWzF_Od.pZqFn2d_NT0MOXfYC.C7lbihu_BoLZyE1gPz4FsbJrh0mEjln8UP
 MnJ.HzKnwhan_4eY86QOoffOVeucZv6DbqHZ2bFFYEnmCb5Nt_Zo.tuoz8TLKxsySLWOGgSKUdgg
 JiZBTKWMJSC1ARvliMTaJ1bVs2E_6w79SrJGcMID5jEH5ZFfR9_YN_TWnCcWsaRxdTlAvBYzljvv
 aGB1iB0C_zsI8dmfY2YaqWria7NNYNn5Lts9diy8mjJnUTKpeCbYn388uD6ZuDuSbBund4U2cuU3
 29xfztx5wjfp9.qj2n6aDFs8otZVqzGHKrNJaaEkx3D910Nwo7ykvqKPUDeSi1oTlNGKZWZG2sMq
 l01Bl8lKlF5n8LryL1A7FUXBHUnHoYw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.bf2.yahoo.com with HTTP; Tue, 18 Sep 2018 00:57:47 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp402.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 06aef4d67bad3bc778af0161e8267886;
          Tue, 18 Sep 2018 00:57:47 +0000 (UTC)
Subject: Re: [PATCH 16/18] LSM: Allow arbitrary LSM ordering
To:     Kees Cook <keescook@chromium.org>
Cc:     John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>
References: <20180916003059.1046-1-keescook@chromium.org>
 <20180916003059.1046-17-keescook@chromium.org>
 <84e1a5a8-8997-829f-cf09-1d29895a3f99@schaufler-ca.com>
 <CAGXu5jK5CzXUii97q_yk3KzBTw0SOmoc=-zcm+3jAqEHe76AgQ@mail.gmail.com>
 <35b0af5b-e37e-e192-73b5-0d0b37d9e37f@schaufler-ca.com>
 <CAGXu5jJ71RLGh0nDgOaN3vCXFGE0poXFU2Gb9o+20aO+AEdOvw@mail.gmail.com>
 <8f0bd39b-29a6-325d-4558-d9f484249c22@schaufler-ca.com>
 <CAGXu5jLeTfwEXAZLz_H1PCx0ySWZcRhXQMfnE14TG8BvxY46JA@mail.gmail.com>
 <53377892-695f-6336-8574-54c7aa0a4201@schaufler-ca.com>
 <7ecfffc3-d2a4-3ff7-4bf5-db3029d73c59@canonical.com>
 <fbdc2a75-8364-c743-f9c3-9dcd2570c569@schaufler-ca.com>
 <e9292d89-12bd-2c4a-9ca2-5758de790f2f@canonical.com>
 <CAGXu5jKhZTcz_+uQpNRh6Mg34pP2+aNSo9cV=c8pC0r=oJBJog@mail.gmail.com>
 <ee3b287d-95a4-db16-e3c6-fc6f6172a5ae@schaufler-ca.com>
 <CAGXu5jK4pa7-G8zhHE-noM4qVQGytTzcKX4BkQFkuJmEbLONaw@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <580f7894-14d7-c0a3-75b7-9a5f4e3af0b8@schaufler-ca.com>
Date:   Mon, 17 Sep 2018 17:57:43 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5jK4pa7-G8zhHE-noM4qVQGytTzcKX4BkQFkuJmEbLONaw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/17/2018 5:45 PM, Kees Cook wrote:
> On Mon, Sep 17, 2018 at 5:24 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 9/17/2018 5:00 PM, Kees Cook wrote:
>>> The legacy per-LSM
>>> enable/disable ordering is the same, but ordering between
>>> lsm.enable/disable and the per-LSM options is NOT ordered. i.e. the
>>> precedent mentioned in the prior paragraph.
>> That is, capability,yama,loadpin,<major>
> Yeah, sorry, I didn't mean LSM order there, I meant the commandline
> order of appearance of the options. If you mix them, the last
> lsm.enable/disable for an LSM is the "real" setting, and the last
> $LSM.enabled= setting is the last of _that_ one.
>
>>> To support "security=", we'll still have some kind of legacy
>>> LSM_FLAG_MAJOR to perform implicit disabling of the non-operational
>>> other "major" LSMs. This means "security=$foo" will be a short-hand
>>> for "lsm.disable=all-LSM_FLAG_MAJOR-who-are-not-$foo". This will
>>> exactly match current behavior (i.e. "security=smack" and if smack
>>> fails initialization, we do not then fall back to another major).
>> Right.
> Cool.
>
>>> I think we have to support runtime ordering for the reasons John
>>> specifies. Additionally, I have the sense that anything we can
>>> configure in Kconfig ultimately ends up being expressed at runtime
>>> too, so better to just make sure the design includes it now.
>> Right.
>>
>>> What we have now:
>>>
>>> "first" then "order-doesn't-matter-minors" then "exclusive-major"
>>>
>>> - we can't change first.
>>> - exclusivity-ordering only matters in the face of enable/disable
>>> which we have solved now (?)
>> I'm not sure where you get the conclusion we've solved this.
>> Today I can't say "lsm.enable=smack lsm.enable=apparmor", and
>> there's no mechanism to prevent that.
>>
>>> so, ordering can be totally arbitrary after "first" (but before some
>>> future "last"). We must not allow a token for "everything else" since
>>> that overlaps with enable/disable, so "everything else" stay implicit
>>> (I would argue a trailing implicit ordering).
>> There's an assumption you're making that I'm not getting. Where does
>> this overlap between ordering and enable/disable come from?
> Handling exclusivity means the non-active LSMs are disabled. We had
> been saying "the other majors are disabled", but the concept of major
> will become arbitrary. If instead we move to "first exclusive wins
> among the exclusives", we still have the "the others are disabled"
> case. So exclusivity begets disabling.
>
>>> The one complication I see with ordering, then, is that if we change
>>> the exclusivity over time, we change what may be present on the
>>> system. For example, right now tomoyo is exclusive. Once we have
>>> blob-sharing, it doesn't need to be.
>>>
>>> so: lsm.order=tomoyo  after this series means
>>> "capability,tomoyo,yama,loadpin,integrity", but when tomoyo becomes
>>> non-exclusive, suddenly we get
>>> "capability,tomoyo,yama,loadpin,{selinux,smack,apparmor},integrity".
>>> (i.e. if selinux is disabled then move on to trying smack, then
>>> apparmor, etc.)
>> We're missing a description of what happens at build time.
>> It's hard to see what you expect to happen if I want to build in
>> all the major modules and don't plan to use the boot command line
>> options.
>>
>>> I would argue that this is a design feature (LSMs aren't left behind),
>>> and order of enabled exclusive LSMs "wins" the choice for the
>>> exclusivity (instead of operating "by name" the way "security="
>>> works).
>> I think I see more, but I'm guessing. At build time it looks like
>> you're dropping the specification on the "major" module. We can't
>> do that because I want to build kernels that run Smack by default
>> but include SELinux for when I'm feeling less evil than normal.
> Do we need build time _ordering_, or can we just go with build time
> "first exclusive"? For the v1, I went with "first exclusive" from
> CONFIG_SECURITY_DEFAULT, and left the rest of the ordering up to the
> Makefile.

If I read you correctly, "first exclusive" would suit my needs just fine.
I like the notion of build time ordering because I hate using the boot
command line.

