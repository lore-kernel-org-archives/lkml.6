Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FCFECE566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90A8221523
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:20:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90A8221523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390073AbeIUTJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 15:09:12 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48515 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727392AbeIUTJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 15:09:12 -0400
Received: from static-50-53-48-205.bvtn.or.frontiernet.net ([50.53.48.205] helo=[10.8.192.6])
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <john.johansen@canonical.com>)
        id 1g3LLz-000507-Tg; Fri, 21 Sep 2018 13:20:16 +0000
Subject: Re: [PATCH security-next v2 26/26] LSM: Add all exclusive LSMs to
 ordered initialization
To:     Kees Cook <keescook@chromium.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20180920162338.21060-1-keescook@chromium.org>
 <20180920162338.21060-27-keescook@chromium.org>
 <a0165ce9-d15b-eaef-a5e8-2aeb6bdc69f6@schaufler-ca.com>
 <CAGXu5j++wXMUXuqT7m5MZdeXqO=i7RgyKZoLwELfSTx6UPOVSA@mail.gmail.com>
 <7d2cc28b-aee5-ee91-9362-f92f8ca30adc@schaufler-ca.com>
 <6c899d9e-45aa-8159-c402-b3c4d1936112@canonical.com>
 <CAGXu5jKzqij5dY2FYm5rafPNPpF1Tx9BPmK+=FvG+=tpFxpscw@mail.gmail.com>
 <74ecd4ec-491b-93d7-4e3f-46f92121130b@canonical.com>
 <CAGXu5j+QhU2HOicYKqfNo17n9k6DKgt1upa3O2p1b5Gvn6icbQ@mail.gmail.com>
From:   John Johansen <john.johansen@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=john.johansen@canonical.com; prefer-encrypt=mutual; keydata=
 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
Organization: Canonical
Message-ID: <915ba7e5-0e10-87ef-f0a9-1d8db2e6de90@canonical.com>
Date:   Fri, 21 Sep 2018 06:19:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5j+QhU2HOicYKqfNo17n9k6DKgt1upa3O2p1b5Gvn6icbQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/20/2018 08:02 PM, Kees Cook wrote:
> On Thu, Sep 20, 2018 at 7:14 PM, John Johansen
> <john.johansen@canonical.com> wrote:
>> On 09/20/2018 07:05 PM, Kees Cook wrote:
>>> On Thu, Sep 20, 2018 at 6:39 PM, John Johansen
>>> <john.johansen@canonical.com> wrote:
>>>> On 09/20/2018 06:10 PM, Casey Schaufler wrote:
>>>>> On 9/20/2018 5:45 PM, Kees Cook wrote:
>>>>>> On Thu, Sep 20, 2018 at 5:25 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>>>>> On 9/20/2018 9:23 AM, Kees Cook wrote:
>>>>>>>>  config LSM_ORDER
>>>>>>>>       string "Default initialization order of builtin LSMs"
>>>>>>>> -     default "yama,loadpin,integrity"
>>>>>>>> +     default "yama,loadpin,integrity,selinux,smack,tomoyo,apparmor"
>>>>>>> If I want to compile all the major modules into my kernel and use
>>>>>>> AppArmor by default would I use
>>>>>>>
>>>>>>>         default "yama,loadpin,integrity,apparmor,selinux,smack,tomoyo"
>>>>>>>
>>>>>>> or
>>>>>>>
>>>>>>>         default "yama,loadpin,integrity,apparmor"
>>>>>> I was expecting the former, but the latter will have the same result.
>>>>
>>>> t find having the two be equivalent violates expectations. At least
>>>> when considering the end goal of full/extreme stacking, its trivially
>>>> the same with current major lsms being exclusive
>>>
>>> This mixes "enablement" with "ordering", though, and I think the past
>>> threads have shown this to be largely problematic.
>>>
>>> However, with CONFIG_LSM_ENABLED, we get the effect you're looking for, IIUC.
>>
>> no, I was just stating in a world where we have full stacking those two
>> are not equivalent, as I would assume the order of any lsm not listed
>> may end up being different.
> 
> Right, the ordering would be defined first by runtime (lsm.order=)
> followed any missing LSMs then ordered by their order in
> CONFIG_LSM_ORDER=, followed by any still missing LSMs then ordered by
> their order at link-time (which *may* be Makefile order, but could
> change with LTO, etc).
> 
>>>>>>> When we have "blob-sharing" how could I compile in tomoyo,
>>>>>>> but exclude it without a boot line option?
>>>>>> Ooh, yes, this series has no way to do that. Perhaps
>>>>>> CONFIG_LSM_DISABLE in the same form as CONFIG_LSM_ORDER? I would
>>>>>> totally remove LoadPin's CONFIG for this in favor it.
>>>>>
>>>>> I would generally prefer an optional CONFIG_LSM_ENABLE to
>>>>> CONFIG_LSM_DISABLE, but I understand the logic behind your
>>>>> approach. I would be looking for something like
>>>>>
>>>> +1 on the CONFIG_LSM_ENABLE ove DISABLE
>>>>
>>>>> CONFIG LSM_ENABLE
>>>>>       string "Default set of enabled LSMs"
>>>>>       default ""
>>>>>
>>>>> as opposed to
>>>>>
>>>>> CONFIG LSM_DISABLE
>>>>>       string "Default set of disabled LSMs"
>>>>>       default ""
>>>>>
>>>>> where an empty string is interpreted as "use 'em all"
>>>>> in either case.
>>>
>>> Yes, I like CONFIG_LSM_ENABLE if "empty" means "enable all". Should
>>> CONFIG_LSM_ENABLE replace all the other CONFIG-based LSM
>>> enabling/disabling?
>>
>> I don't particularly like "empty" being "enable all". With that
>> how would I disable all builtin lsms so that I just boot with
>> capability.
>>
>> An option of all or even * is more explicit and leaves the empty
>> set to mean disable everything
> 
> Okay, that works. I prefer "all" FWIW.
> 
me too, I was just trying to throw out options.

