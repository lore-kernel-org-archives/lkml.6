Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79571ECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 01:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 155E72088F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 01:09:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 155E72088F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbeIRGjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 02:39:06 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60671 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbeIRGjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 02:39:06 -0400
Received: from static-50-53-48-205.bvtn.or.frontiernet.net ([50.53.48.205] helo=[10.8.192.6])
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <john.johansen@canonical.com>)
        id 1g24Vj-0007ul-Tx; Tue, 18 Sep 2018 01:09:04 +0000
Subject: Re: [PATCH 16/18] LSM: Allow arbitrary LSM ordering
To:     Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Cc:     James Morris <jmorris@namei.org>,
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
From:   John Johansen <john.johansen@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=john.johansen@canonical.com; prefer-encrypt=mutual; keydata=
 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
Organization: Canonical
Message-ID: <2c47978a-eabe-5fa6-bd92-3dc62535f099@canonical.com>
Date:   Mon, 17 Sep 2018 18:08:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5jK4pa7-G8zhHE-noM4qVQGytTzcKX4BkQFkuJmEbLONaw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/17/2018 05:45 PM, Kees Cook wrote:
> On Mon, Sep 17, 2018 at 5:24 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 9/17/2018 5:00 PM, Kees Cook wrote:
>>> The legacy per-LSM
>>> enable/disable ordering is the same, but ordering between
>>> lsm.enable/disable and the per-LSM options is NOT ordered. i.e. the
>>> precedent mentioned in the prior paragraph.
>>
>> That is, capability,yama,loadpin,<major>
> 
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
>>
>> Right.
> 
> Cool.
> 
>>> I think we have to support runtime ordering for the reasons John
>>> specifies. Additionally, I have the sense that anything we can
>>> configure in Kconfig ultimately ends up being expressed at runtime
>>> too, so better to just make sure the design includes it now.
>>
>> Right.
>>
>>> What we have now:
>>>
>>> "first" then "order-doesn't-matter-minors" then "exclusive-major"
>>>
>>> - we can't change first.
>>> - exclusivity-ordering only matters in the face of enable/disable
>>> which we have solved now (?)
>>
>> I'm not sure where you get the conclusion we've solved this.
>> Today I can't say "lsm.enable=smack lsm.enable=apparmor", and
>> there's no mechanism to prevent that.
>>
>>> so, ordering can be totally arbitrary after "first" (but before some
>>> future "last"). We must not allow a token for "everything else" since
>>> that overlaps with enable/disable, so "everything else" stay implicit
>>> (I would argue a trailing implicit ordering).
>>
>> There's an assumption you're making that I'm not getting. Where does
>> this overlap between ordering and enable/disable come from?
> 
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
>>
>> We're missing a description of what happens at build time.
>> It's hard to see what you expect to happen if I want to build in
>> all the major modules and don't plan to use the boot command line
>> options.
>>
>>> I would argue that this is a design feature (LSMs aren't left behind),
>>> and order of enabled exclusive LSMs "wins" the choice for the
>>> exclusivity (instead of operating "by name" the way "security="
>>> works).
>>
>> I think I see more, but I'm guessing. At build time it looks like
>> you're dropping the specification on the "major" module. We can't
>> do that because I want to build kernels that run Smack by default
>> but include SELinux for when I'm feeling less evil than normal.
> 
> Do we need build time _ordering_, or can we just go with build time

depends on what you mean by build time ordering. Ordering like we
currently have based on link order, no. The ability to specify
the lsm order just like on the command line yes.

Distros are very much going to have a preferred order they want
LSMs to make supporting this more tractable when trying to deal
with issues.

> "first exclusive"? For the v1, I went with "first exclusive" from
> CONFIG_SECURITY_DEFAULT, and left the rest of the ordering up to the
> Makefile.
> 

First exclusive from CONFIG_SECURITY_DEFAULT is fine for now, I am
more interested in making sure we get it right for when exclusivity
goes away.



