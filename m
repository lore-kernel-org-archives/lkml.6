Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752034AbeDELeW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 07:34:22 -0400
Received: from lhrrgout.huawei.com ([194.213.3.17]:34330 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751967AbeDELeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 07:34:11 -0400
Subject: Re: [PATCH v4 0/1] Safe LSM (un)loading, and immutable hooks
To: Peter Dolding <oiaohm@gmail.com>, Sargun Dhillon <sargun@sargun.me>
CC: linux-security-module <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>, Stephen Smalley <sds@tycho.nsa.gov>,
        <paul@paul-moore.com>, <plautrba@redhat.com>
References: <cover.1522560550.git.sargun@sargun.me>
 <911d9855-cd45-26f0-90eb-563db899d5ee@huawei.com>
 <CANA3KFX_sVhqvV7C0kR1nkLijiwWc286KcPBfY94LOe=YKGBwg@mail.gmail.com>
From: Igor Stoppa <igor.stoppa@huawei.com>
Message-ID: <63eaa2d5-3662-2240-15fb-ab2227b6903a@huawei.com>
Date: Thu, 5 Apr 2018 14:34:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CANA3KFX_sVhqvV7C0kR1nkLijiwWc286KcPBfY94LOe=YKGBwg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/04/18 13:31, Peter Dolding wrote:
> On Thu, Apr 5, 2018 at 7:55 PM, Igor Stoppa <igor.stoppa@huawei.com> wrote:

[...]

>> A) hooks that are either const or marked as RO after init
>>
>> B) hooks that are writable for a short time, long enough to load
>> additional, non built-in modules, but then get locked down
>> I provided an example some time ago [1]
>>
>> C) hooks that are unloadable (and therefore always attackable?)

[...]

>> Do you have any specific case in mind where this trade-off would be
>> acceptable?
>>
> 
> A useful case for loadable/unloadable LSM is development automate QA.

I did not consider this case, but I see the point.

[...]

> I would say normal production machines being able to swap LSM like
> this does not have much use.

yes, this is what I had in mind

[...]

> There is a shade of grey between something being a security hazard and
> something being a useful feature.

Maybe the problem I see is only in the naming: if what right now is
addressed as "mutable" were to be called in some other way that does not
imply that it's impossible to lock it down, then I think there wouldn't
be much of a problem anymore.

How about s/mutable/protectable/g ?

Then it could be a boot time parameter to decide if the "extra" hooks
should be protected or stay writable, for example for performing more
extensive testing.

--
igor
