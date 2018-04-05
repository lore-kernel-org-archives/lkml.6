Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751415AbeDEM2g (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 08:28:36 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:41679 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751384AbeDEM2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 08:28:33 -0400
X-Google-Smtp-Source: AIpwx49bQWD/j/C8AO26qPI0CTtgxt4R1e4sHfrKpkrrzZzlQAt8z9LbJjYT/L334JdI2V0lWVj1tgCoYnejV1bhdsc=
MIME-Version: 1.0
In-Reply-To: <63eaa2d5-3662-2240-15fb-ab2227b6903a@huawei.com>
References: <cover.1522560550.git.sargun@sargun.me> <911d9855-cd45-26f0-90eb-563db899d5ee@huawei.com>
 <CANA3KFX_sVhqvV7C0kR1nkLijiwWc286KcPBfY94LOe=YKGBwg@mail.gmail.com> <63eaa2d5-3662-2240-15fb-ab2227b6903a@huawei.com>
From: Peter Dolding <oiaohm@gmail.com>
Date: Thu, 5 Apr 2018 22:28:30 +1000
Message-ID: <CANA3KFWkYJ4kGjZ_9E1Qa4B=onyE5zNucPmX3RPQmcRL6esGqg@mail.gmail.com>
Subject: Re: [PATCH v4 0/1] Safe LSM (un)loading, and immutable hooks
To: Igor Stoppa <igor.stoppa@huawei.com>
Cc: Sargun Dhillon <sargun@sargun.me>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>, Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>, plautrba@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 5, 2018 at 9:34 PM, Igor Stoppa <igor.stoppa@huawei.com> wrote:
> On 05/04/18 13:31, Peter Dolding wrote:
>> On Thu, Apr 5, 2018 at 7:55 PM, Igor Stoppa <igor.stoppa@huawei.com> wrote:
>> There is a shade of grey between something being a security hazard and
>> something being a useful feature.
>
> Maybe the problem I see is only in the naming: if what right now is
> addressed as "mutable" were to be called in some other way that does not
> imply that it's impossible to lock it down, then I think there wouldn't
> be much of a problem anymore.
>
> How about s/mutable/protectable/g ?
>
> Then it could be a boot time parameter to decide if the "extra" hooks
> should be protected or stay writable, for example for performing more
> extensive testing.
>
Due to being a shades of grey area I would say kconfig 2 option and 1
boot time parameter.

Some kernels the ability to change LSM on fly should be fully disabled
in the build process.

The abplity to change LSM at runtime has limited valid usage cases so
even if the kernel is built with the ablity to change LSM at runtime
enabled it should still be off by default until enabled with boot time
parameter.   So those who need the feature turn it on and those who
don't need it on cannot turn it on just by installing a kernel.   For
systems that cannot use Linux kernel command line features to turn
stuff on and off a kernel configuration option to change the default
to on with warning in kernel configure.   So 2 kconfig entries and 1
Kernel Boot Parameter.   Of course when a feature like this is enabled
there should be a kernel message so its recorded in logs and is check
able if a feature like this that can lower security is turn on.

The ability to change LSM on fly i see the development usage cases.
I can not think of a single production system usage case for anyone
who is not a developer.   I might be thinking way to narrow.  Unless
someone else can find another use case I would suggest following what
I suggest how a feature like this is enabled.

Naming the feature what ever you think is suitable.

Peter Dolding
