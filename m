Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,GAPPY_SUBJECT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12276C04AB8
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 00:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5FBC20853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 00:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="PPSl+Aty"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5FBC20853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbeINFUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 01:20:32 -0400
Received: from sonic304-28.consmr.mail.ne1.yahoo.com ([66.163.191.154]:38885
        "EHLO sonic304-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726911AbeINFUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 01:20:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1536883724; bh=66ahGOta3Ly9LRZ07VeRJfs7LhhBO7MxXqiHMG05RXg=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=PPSl+AtyqVKNxtfteyt5wt4uOozLzz0EofVQbNFxzzCoToHU959oD/gWjPMr2bVmv//ARYlnoYFuUk5x1PhsvE/TMdku30LzQcS5y6Z5hp6i8PlnFTdPQ3nhTj6h/xq3uiTy9q4BjW8emsdLg3PVrFKgSfTtNtiKRMXc4MuyIVAVuK6qR1Oe98gF3E7/tJxapfOZ4kNYLFINCPDIWtjjMwIUvyRGXhUW/JrEw2nu8Tx2BuDroZdv3PHlCb9uqK8I7iiKWseLFt9WbXxZvz6pTfr6d6SkJKEhGqMiEdwfCVJ7nNco34SVuKbrvn1OU1f8Yop8eEW+bsf+t6tBkCUY6Q==
X-YMail-OSG: BvRM1jsVM1kc2IR_Q76p8iYOrG_Ojn6RNsJhGv6yde6jmQ2VGgQX5Aw8ga2a8Bn
 AT4mI5jBpjDckxP0LLe8LF6Qd26VR9rApWvbQN4LucLHmG4lGegnpn5s.H9pHBcGaYyWRSaVDIUz
 Ku11JVTq5EkkE_0yv_eIeM0s8RxESCZdNl9_Sj3YvORCbGm0msPUVisa1ei53zeyO7dCQpXX9._d
 pf7beaNGphjkQa8b.8dp.n_4YsBbKNuLf8aKlh9OgSPt364GYiupWtumkJNdqef.P2L4MbXmysqh
 71zc5VEKlZsb7YDa9oNVi7ULTZRxu.RswxCcxb6ZqpBby9mmiAoBkLAinpgKkkuFbHi8Ib7Wyhfu
 lTv_1lnzn3bzOSW.6GQl8xdv0SltACFqqfs.IcArTrvkx95rD6nv_HIGBqfaFsJeszQTL8Ga7dH_
 FxTZ7eKG0JsF6jwJH323172KUgej2dBL1oXa68QpS03HR9wKzyiT1gWHCAjnhBSzFs7.F.D3Nbg_
 AZVnlJLlVws7WuBiY0u9hLAQXEpAAA22nuHMPzODNte4vZJwGjsVA6k2d0T3U3mPSnWzAjRtYbLS
 2BlrzmG7Dd5dEUW0zH62Z5KaOyvam7gHVYkme9lqy1JC7j.TI1TDxFoUmSuIt4z71FUHFh2nZzO5
 voakZeFwD49NtIphkja2Pd2TZQctaBqdCxV34zDbgb7qR7zPLVJmMqGMLsCG4DAQhkfjjBQjCZIw
 t576feV9I6QlakgEk7U9sUahStWXoLFC2K.N8bj4SkuxiedvkJBZadEZnZUKCxY7L4ZWqkN8kbiu
 5tlc12As8arWWHAVOety7tUVEQAoDk80qdafhlg_Bp8eVMj5cE8mZxk8QZJsaNDF9Fdp6YVnl0ZB
 hxSgL5y9fidgFvtvfKfNhfqXb6TCMMUuVygeghEEGe2X3fcG7Z8MPORbuJ.u7gnh6SITYVMrT5KC
 JGoqFbWaYqwkeLpPIRgLE62LBz9N50L0NVxP2b7nCIgxb8qsgTK6LsVCeMLhZHkFHgezvc8ZVvSm
 YBH.bnvZCYRpuq760sEUjXnlkSra2
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Fri, 14 Sep 2018 00:08:44 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp403.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 2d3f7c4a149abb53dce8b7ea864472ca;
          Fri, 14 Sep 2018 00:08:44 +0000 (UTC)
Subject: Re: [PATCH 10/10] LSM: Blob sharing support for S.A.R.A and LandLock
To:     Kees Cook <keescook@chromium.org>
Cc:     Paul Moore <paul@paul-moore.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        LKML <linux-kernel@vger.kernel.org>,
        SE Linux <selinux@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Schaufler, Casey" <casey.schaufler@intel.com>
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
 <99cb1ae7-8881-eb9a-a8cb-a787abe454e1@schaufler-ca.com>
 <CAGXu5jLONSfPHYYYTLSma-+arVHSQKaEWb9JxpOn6TNKtyLNhw@mail.gmail.com>
 <CAHC9VhQN0wq0zZS5BYU9jBomaWvCaJ_BqJjHF3AT7FG8Z0nLDQ@mail.gmail.com>
 <CAGXu5jJs6kmd6Tjgwqb2Zx7e-jNbHqfJ57poZuyz4Qj=AKVfmQ@mail.gmail.com>
 <CAHC9VhQ20tBAMwOJ9mg0tBHYUoxjh0Szr3d62HuPw2SyT4XDLw@mail.gmail.com>
 <CAGXu5jKec1JTsoqwKGThcJoamdL618AHu4jfFbqqQiauz1kjyg@mail.gmail.com>
 <CAHC9VhQwT4d3wC37cVrrX-hZq1L3e6=TEAse4m-YH9SiFnkieA@mail.gmail.com>
 <CAGXu5jLapViSK-j08Tq8cCZodiZXFsXze71xFPg6MQhDWDHDAA@mail.gmail.com>
 <CAGXu5j+j47FH5RF2vrJh95=YFX76oSBFo8O6GZqa0utcfE1AVA@mail.gmail.com>
 <d1d12866-d557-8c15-6506-a54b9d927952@schaufler-ca.com>
 <CAGXu5jJG=wk6e_RU=KYDY48kOc=RmL3OB79T+rHqCyzaDSn=zg@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <5b983bba-049c-795a-3354-a2e8ab33cecf@schaufler-ca.com>
Date:   Thu, 13 Sep 2018 17:08:41 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5jJG=wk6e_RU=KYDY48kOc=RmL3OB79T+rHqCyzaDSn=zg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/2018 4:57 PM, Kees Cook wrote:
> On Thu, Sep 13, 2018 at 4:51 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 9/13/2018 4:06 PM, Kees Cook wrote:
>>> - what order should any stacking happen? Makefile? security=?
>> Makefile by default.
> Okay, if ordering is by Makefile and everyone dislikes my
> $lsm.enabled=0/1 thing, then these mean the same thing:
>
> security=selinux,tomoyo
> security=tomoyo,selinux
>
> i.e. order of security= is _ignored_ in favor of the Makefile ordering.

No, I think that the two lines above should have a different
execution order. If we really need to specify multiple modules
at boot time that is what makes the most sense.

It's a matter of mechanics and probably another pass during the
init process, but it's doable. If we determine it's necessary for
this stage it is just work.

