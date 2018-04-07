Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752126AbeDGREA (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 13:04:00 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:35448 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751804AbeDGRD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 13:03:58 -0400
X-Google-Smtp-Source: AIpwx48RHuMF+yeGyVOx/ZxH0eTyYlDypOhh54Sr6dECc46q7J8cZVHGtOKKLfroEo8O/bd2ak/Sj/1ZyAjitcOJ/VQ=
MIME-Version: 1.0
In-Reply-To: <1523120055.31267.13.camel@btinternet.com>
References: <CAHC9VhQExmdXutVEhysGzf95CDzO_0sXFWQqndeeuChQ=0xbmA@mail.gmail.com>
 <CA+55aFzzxfAL+Khed9nc-RzB2P3FxrCgr6Whmh_bYondTQvO6A@mail.gmail.com> <1523120055.31267.13.camel@btinternet.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 7 Apr 2018 10:03:56 -0700
X-Google-Sender-Auth: At8i_oLCuxqNFcbf8fVhypCvVUs
Message-ID: <CA+55aFxo4Z3S7qG66esSL_qxg5jwzcFgZpYR0gRpto4Z_yghTQ@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux patches for v4.17
To: Richard Haines <richard_c_haines@btinternet.com>
Cc: Paul Moore <paul@paul-moore.com>, Xin Long <lucien.xin@gmail.com>,
        selinux@tycho.nsa.gov,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 7, 2018 at 9:54 AM, Richard Haines
<richard_c_haines@btinternet.com> wrote:
>>
>> So please check my resolution, but also somebody should tell me
>> "Linus, you're a cretin, sctp_connect() doesn't want that
>> security_sctp_bind_connect() at all because it was already done by
>> XYZ"
>
> sctp_connect() or __sctp_connect() do not need to call
> security_sctp_bind_connect(). This is because the connect(2) call will
> handle the checks required via security_socket_connect():

Ok, thanks, that's exactly what I wanted to get.

Anyway, somebody should still verify that it all looks good in my
tree, but I don't actually expect the merge to have had any issues
even if the refactoring made it a bit more complex than most merges
are.

                      Linus
