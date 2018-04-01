Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754602AbeDAUn4 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 16:43:56 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:38010 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754062AbeDAUnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 16:43:53 -0400
X-Google-Smtp-Source: AIpwx4/2J8X87XCjx9BpTFLU+Hg9K+vLKK6pEE/B5gRn11e2SIeID9E7Zlsb4rKItOJnDljnBFlY6jwXNpwPS8KCAh8=
MIME-Version: 1.0
In-Reply-To: <06c4e61e-399f-a1f8-bd45-a27d0eb4571b@schaufler-ca.com>
References: <cover.1522577650.git.sargun@sargun.me> <06c4e61e-399f-a1f8-bd45-a27d0eb4571b@schaufler-ca.com>
From: Sargun Dhillon <sargun@sargun.me>
Date: Sun, 1 Apr 2018 13:43:11 -0700
Message-ID: <CAMp4zn8o0giNY2m=5bmfFA5veKZrux=zYzL0Aaqd2xi0PsZ+bA@mail.gmail.com>
Subject: Re: [PATCH 0/4] security: Split out hook definitions into lsm_hook_types.h
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: LSM <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Kees Cook <keescook@chromium.org>,
        Igor Stoppa <igor.stoppa@huawei.com>, James Morris <jmorris@namei.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 1, 2018 at 10:32 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 4/1/2018 3:17 AM, Sargun Dhillon wrote:
> > This moves all of the LSM hooks type information into a separate file,
> > lsm_hook_types.h. This enables us to use this file, along with macros
> > to generate the security_hook_heads struct, as well as the security
> > hooks union without having to duplicate definitions.
> >
> > This will be useful for further datastructures which want to use
> > the set of security hooks in a completely unrolled way, along
> > with the type information there within.
>
> Can you explain what this patch set is trying to accomplish?
> I see no value. I see massive complexity. Why is this better
> than what is there now?
>

1) Reduce the total amount of code
2) In the process of implementing the loadable hooks stuff, I wanted
to add a few more unrolled datastructures, specifically around static
keys, and I realized I would have to write an entirely new
datastructure like the security heads. To me, rather than having to
touch 3 different parts of code in order to change something, it seems
nice to keep it centralized. Same with RCU.
3) Rather than call_int_hook, and call_void_hook, we could generate an
actual function definitions. I think that will be a bit cleaner, esp.
in the context of the 2nd set of hook patches.
