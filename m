Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750998AbeDAFQW (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 01:16:22 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35798 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750710AbeDAFQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 01:16:20 -0400
X-Google-Smtp-Source: AIpwx4+TS+4saVcBi/me7xSWqxKRXat8U7TyFne783OfdW3RDea1zSiGbMnoY7CxA5Ut3fhoSqZSe1/4JN+Q7re/vJM=
MIME-Version: 1.0
In-Reply-To: <20180401024015.GA13870@ircssh-2.c.rugged-nimbus-611.internal>
References: <20180401024015.GA13870@ircssh-2.c.rugged-nimbus-611.internal>
From: Sargun Dhillon <sargun@sargun.me>
Date: Sat, 31 Mar 2018 22:15:39 -0700
Message-ID: <CAMp4zn8EkqQZDc1UW9ux0za+99DHpKAXVx72CMzuwApVFZ_=SQ@mail.gmail.com>
Subject: Re: [PATCH] security: Split out hook definitions into lsm_hook_types.h
To: LSM <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Kees Cook <keescook@chromium.org>,
        Igor Stoppa <igor.stoppa@huawei.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>, Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>, plautrba@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 31, 2018 at 7:40 PM, Sargun Dhillon <sargun@sargun.me> wrote:
> This moves all of the LSM hooks type information into a separate file,
> lsm_hook_types.h. This enables us to use this file, along with macros
> to generate the security_hook_heads struct, as well as the security
> hooks union without having to duplicate definitions.
>
> Since the fall-back hooks still require some logic (dispatching
> to commoncap, nulling out some buffer, etc..), they still must
> be created manually.
>
> This will be useful for further datastructures which want to use
> the set of security hooks in a completely unrolled way, along
> with the type information there within.
>
> Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> ---
>  include/linux/lsm_hook_types.h | 1695 ++++++++++++++++++++++++++++++++++
>  include/linux/lsm_hooks.h      | 1946 +---------------------------------------
>  include/linux/security.h       |  416 ++-------
>  kernel/time/time.c             |    6 +-
>  security/security.c            |    2 +-
>  5 files changed, 1783 insertions(+), 2282 deletions(-)
>  create mode 100644 include/linux/lsm_hook_types.h
>
>
Upon further thought, this patch is somewhat unwieldy. I intent to
split it up. I plan to split it into the following:
1. Fixing the settimeofday64 weirdness
2. 1:1 move from lsm_hooks.h to lsm_hook_types.h of the hook
definitions (union + comments)
3. Rewiring lsm_hooks.h to use macros only
4. Rewiring security.h to use macros only

Does that sound reasonable?
