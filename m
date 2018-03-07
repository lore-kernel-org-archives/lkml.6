Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754580AbeCGTTB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 14:19:01 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:47051 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754173AbeCGTS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 14:18:59 -0500
X-Google-Smtp-Source: AG47ELsv8OjMq+aNfBXfVh1SD5hVHE6qo2SrktFnmf/NTZTgEQ6MiYJ9a6kAWZqUpJT5213qPud145+Cc/owHnDOpps=
MIME-Version: 1.0
In-Reply-To: <ad43c9ed-9314-1787-911a-f4b206bc5cff@schaufler-ca.com>
References: <cover.1520407240.git.sargun@sargun.me> <3646ff78915fcbadbc660257d92921e5442553e0.1520407240.git.sargun@sargun.me>
 <ad43c9ed-9314-1787-911a-f4b206bc5cff@schaufler-ca.com>
From: Sargun Dhillon <sargun@sargun.me>
Date: Wed, 7 Mar 2018 11:18:17 -0800
Message-ID: <CAMp4zn8gtb7G28F8D_=npc6a7wwp3QMyvXrNKL0LA=EeFxRiKw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] security: Refactor LSM hooks into an array and enum
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: LSM <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Kees Cook <keescook@chromium.org>,
        Igor Stoppa <igor.stoppa@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 7, 2018 at 9:45 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 3/6/2018 11:23 PM, Sargun Dhillon wrote:
>> This commit should have no functional change. It changes the security hook
>> list heads struct into an array. Additionally, it exposes all of the hooks
>> via an enum. This loses memory layout randomization as the enum is not
>> randomized.
>
> Please explain why you want to do this. I still dislike it.
>
Do you dislike it because of the loss of randomization, or some other reason?
The reason for not just having a second list_heads is that it's
somewhat ugly having to replicate that structure twice -- once for
dynamic hooks, and once for 'static' hooks.
Instead, we have one enum that LSMs can use and two arrays of heads
rather than an entire unrolled set of list_heads.

If we had a way to randomize this, would it make you comfortable?
