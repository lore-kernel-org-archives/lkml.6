Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752822AbeDJMEI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 08:04:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54720 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752541AbeDJMEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 08:04:06 -0400
Subject: Re: [PATCH v2] target-i386: add KVM_HINTS_DEDICATED performance hint
To: Eduardo Habkost <ehabkost@redhat.com>,
        Wanpeng Li <kernellwp@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <1518185725-69559-1-git-send-email-wanpengli@tencent.com>
 <20180309141653.GA2871@localhost.localdomain>
 <CANRm+CzKFoo4DfdiHyBiVPYaeMpMBq2MGck+i=qC2y8xfyCgKA@mail.gmail.com>
 <20180410115711.GE29865@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; prefer-encrypt=mutual; keydata=
 xsEhBFRCcBIBDqDGsz4K0zZun3jh+U6Z9wNGLKQ0kSFyjN38gMqU1SfP+TUNQepFHb/Gc0E2
 CxXPkIBTvYY+ZPkoTh5xF9oS1jqI8iRLzouzF8yXs3QjQIZ2SfuCxSVwlV65jotcjD2FTN04
 hVopm9llFijNZpVIOGUTqzM4U55sdsCcZUluWM6x4HSOdw5F5Utxfp1wOjD/v92Lrax0hjiX
 DResHSt48q+8FrZzY+AUbkUS+Jm34qjswdrgsC5uxeVcLkBgWLmov2kMaMROT0YmFY6A3m1S
 P/kXmHDXxhe23gKb3dgwxUTpENDBGcfEzrzilWueOeUWiOcWuFOed/C3SyijBx3Av/lbCsHU
 Vx6pMycNTdzU1BuAroB+Y3mNEuW56Yd44jlInzG2UOwt9XjjdKkJZ1g0P9dwptwLEgTEd3Fo
 UdhAQyRXGYO8oROiuh+RZ1lXp6AQ4ZjoyH8WLfTLf5g1EKCTc4C1sy1vQSdzIRu3rBIjAvnC
 tGZADei1IExLqB3uzXKzZ1BZ+Z8hnt2og9hb7H0y8diYfEk2w3R7wEr+Ehk5NQsT2MPI2QBd
 wEv1/Aj1DgUHZAHzG1QN9S8wNWQ6K9DqHZTBnI1hUlkp22zCSHK/6FwUCuYp1zcAEQEAAc0f
 UGFvbG8gQm9uemluaSA8Ym9uemluaUBnbnUub3JnPsLBTQQTAQIAIwUCVEJ7AwIbAwcLCQgH
 AwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEH4VEAzNNmmxNcwOniaZVLsuy1lW/ntYCA0Caz0i
 sHpmecK8aWlvL9wpQCk4GlOX9L1emyYXZPmzIYB0IRqmSzAlZxi+A2qm9XOxs5gJ2xqMEXX5
 FMtUH3kpkWWJeLqe7z0EoQdUI4EG988uv/tdZyqjUn2XJE+K01x7r3MkUSFz/HZKZiCvYuze
 VlS0NTYdUt5jBXualvAwNKfxEkrxeHjxgdFHjYWhjflahY7TNRmuqPM/Lx7wAuyoDjlYNE40
 Z+Kun4/KjMbjgpcF4Nf3PJQR8qXI6p3so2qsSn91tY7DFSJO6v2HwFJkC2jU95wxfNmTEUZc
 znXahYbVOwCDJRuPrE5GKFd/XJU9u5hNtr/uYipHij01WXal2cce1S5mn1/HuM1yo1u8xdHy
 IupCd57EWI948e8BlhpujUCU2tzOb2iYS0kpmJ9/oLVZrOcSZCcCl2P0AaCAsj59z2kwQS9D
 du0WxUs8waso0Qq6tDEHo8yLCOJDzSz4oojTtWe4zsulVnWV+wu70AioemAT8S6JOtlu60C5
 dHgQUD1Tp+ReXpDKXmjbASJx4otvW0qah3o6JaqO79tbDqIvncu3tewwp6c85uZd48JnIOh3
 utBAu684nJakbbvZUGikJfxd887ATQRUQnHuAQgAx4dxXO6/Zun0eVYOnr5GRl76+2UrAAem
 Vv9Yfn2PbDIbxXqLff7oyVJIkw4WdhQIIvvtu5zH24iYjmdfbg8iWpP7NqxUQRUZJEWbx2CR
 wkMHtOmzQiQ2tSLjKh/cHeyFH68xjeLcinR7jXMrHQK+UCEw6jqi1oeZzGvfmxarUmS0uRuf
 fAb589AJW50kkQK9VD/9QC2FJISSUDnRC0PawGSZDXhmvITJMdD4TjYrePYhSY4uuIV02v02
 8TVAaYbIhxvDY0hUQE4r8ZbGRLn52bEzaIPgl1p/adKfeOUeMReg/CkyzQpmyB1TSk8lDMxQ
 zCYHXAzwnGi8WU9iuE1P0wARAQABwsEzBBgBAgAJBQJUQnHuAhsMAAoJEH4VEAzNNmmxp1EO
 oJy0uZggJm7gZKeJ7iUpeX4eqUtqelUw6gU2daz2hE/jsxsTbC/w5piHmk1H1VWDKEM4bQBT
 uiJ0bfo55SWsUNN+c9hhIX+Y8LEe22izK3w7mRpvGcg+/ZRG4DEMHLP6JVsv5GMpoYwYOmHn
 plOzCXHvmdlW0i6SrMsBDl9rw4AtIa6bRwWLim1lQ6EM3PWifPrWSUPrPcw4OLSwFk0CPqC4
 HYv/7ZnASVkR5EERFF3+6iaaVi5OgBd81F1TCvCX2BEyIDRZLJNvX3TOd5FEN+lIrl26xecz
 876SvcOb5SL5SKg9/rCBufdPSjojkGFWGziHiFaYhbuI2E+NfWLJtd+ZvWAAV+O0d8vFFSvr
 iy9enJ8kxJwhC0ECbSKFY+W1eTIhMD3aeAKY90drozWEyHhENf4l/V+Ja5vOnW+gCDQkGt2Y
 1lJAPPSIqZKvHzGShdh8DduC0U3xYkfbGAUvbxeepjgzp0uEnBXfPTy09JGpgWbg0w91GyfT
 /ujKaGd4vxG2Ei+MMNDmS1SMx7wu0evvQ5kT9NPzyq8R2GIhVSiAd2jioGuTjX6AZCFv3ToO
 53DliFMkVTecLptsXaesuUHgL9dKIfvpm+rNXRn9wAwGjk0X/A==
Message-ID: <951766c8-3cac-af10-e63d-ea96aa99fa1b@redhat.com>
Date: Tue, 10 Apr 2018 14:04:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180410115711.GE29865@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/2018 13:57, Eduardo Habkost wrote:
> On Tue, Apr 10, 2018 at 05:13:21PM +0800, Wanpeng Li wrote:
>> Hi Eduardo,
>> 2018-03-09 22:16 GMT+08:00 Eduardo Habkost <ehabkost@redhat.com>:
>>> On Fri, Feb 09, 2018 at 06:15:25AM -0800, Wanpeng Li wrote:
>>>> From: Wanpeng Li <wanpengli@tencent.com>
>>>>
>>>> Add KVM_HINTS_DEDICATED performance hint, guest checks this feature bit
>>>> to determine if they run on dedicated vCPUs, allowing optimizations such
>>>> as usage of qspinlocks.
>>>>
>>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>>> Cc: Radim Krčmář <rkrcmar@redhat.com>
>>>> Cc: Eduardo Habkost <ehabkost@redhat.com>
>>>> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
>>>> ---
>>>> v1 -> v2:
>>>>  * add a new feature word
>>>>
>>>>  target/i386/cpu.c | 14 ++++++++++++++
>>>>  target/i386/cpu.h |  3 +++
>>>>  target/i386/kvm.c |  4 ++++
>>>>  3 files changed, 21 insertions(+)
>>>>
>>>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>>>> index d70954b..e2974ad 100644
>>>> --- a/target/i386/cpu.c
>>>> +++ b/target/i386/cpu.c
>>>> @@ -358,6 +358,20 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>>>>          .cpuid_eax = KVM_CPUID_FEATURES, .cpuid_reg = R_EAX,
>>>>          .tcg_features = TCG_KVM_FEATURES,
>>>>      },
>>>> +    [FEAT_KVM_HINTS] = {
>>>> +        .feat_names = {
>>>> +            "hint-dedicated", NULL, NULL, NULL,
>>>
>>> I suggest naming it "kvm-hint-dedicated", to indicate it's
>>> KVM-specific.
>>
>> I found this feature is enabled by default w/o kvm-hint-dedicated
>> parameter, any idea how to make it disabled by default?
> 
> You mean on "-cpu host", right?
> 
> The assumption in most of the code is that anything enabled on
> GET_SUPPORTED_CPUID should be enabled on "-cpu host".  This
> shouldn't be the case for FEAT_KVM_HINTS.
> 
> Untested fix below.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  target/i386/cpu.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 1a6b082b6f..a20fe26573 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -295,6 +295,8 @@ typedef struct FeatureWordInfo {
>      uint32_t tcg_features; /* Feature flags supported by TCG */
>      uint32_t unmigratable_flags; /* Feature flags known to be unmigratable */
>      uint32_t migratable_flags; /* Feature flags known to be migratable */
> +    /* Features that shouldn't be auto-enabled by "-cpu host" */
> +    uint32_t no_autoenable_flags;
>  } FeatureWordInfo;
>  
>  static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
> @@ -400,6 +402,11 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>          },
>          .cpuid_eax = KVM_CPUID_FEATURES, .cpuid_reg = R_EDX,
>          .tcg_features = TCG_KVM_FEATURES,
> +        /*
> +         * KVM hints aren't auto-enabled by -cpu host, they need to be
> +         * explicitly enabled in the command-line.
> +         */
> +        .no_autoenable_flags = ~0U,
>      },
>      [FEAT_HYPERV_EAX] = {
>          .feat_names = {
> @@ -4062,7 +4069,8 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
>               */
>              env->features[w] |=
>                  x86_cpu_get_supported_feature_word(w, cpu->migratable) &
> -                ~env->user_features[w];
> +                ~env->user_features[w] & \
> +                ~feature_word_info[w].no_autoenable_flags;
>          }
>      }
>  
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
