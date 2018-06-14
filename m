Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E4580C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88E5F208D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DuJT75Wc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88E5F208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935900AbeFNLQQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 07:16:16 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35146 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754869AbeFNLQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 07:16:13 -0400
Received: by mail-qk0-f194.google.com with SMTP id d130-v6so3353129qkc.2;
        Thu, 14 Jun 2018 04:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ORwrH8lRQBIRGUV1HLVFHNeOJihIU9PFC8TgUzNQmLw=;
        b=DuJT75WcDoHPmQlbhyc0OqQrg5YIa6WM60nUN1k7fVr+GGY0Wkxyqn3Va04l+2ysxT
         y/9sY0VgTouw6tVjwXIh5ncWrMomHb66atj2U/oPzJibzU4YqYkUA35p2VZg0lOkPeBB
         pjQoDfl1EuKmH11oA/0RPF3cqx2tzLrft3wY3I0GzYkrpg12Z20Ek6rnIXPNf18ufOkb
         ALMyKj0RGLtvXaCxrzH2zoLe2WJfsmoNxn6q4GOv8CdRpZLh2AAkM92UP+nqe+uiNvkM
         JERx94X8dyTty3LbCdexi6Bdtu5l7REGdy2oJCdU5UXXrTxqRoP0Jv805NG8CLgFZY0F
         9m6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ORwrH8lRQBIRGUV1HLVFHNeOJihIU9PFC8TgUzNQmLw=;
        b=GifmfXHqK8UkRF5R3HiSetPR6B+ktCdFu8uC2wezXOKm5+FDpqVgY4rORCWorQ/y/I
         BRzxf2pCHHaHlgdAuIyhTzgIHzoY3kt0F4tXQKUxA9sChSzzi8qtPmpsL7btAfxc5mC/
         XcViEviTV2/cSPHTwbPmRDBUlG3XS48PolUzIhY9vuWo+zPeVaJdgfm3qtUlv/yn8St5
         IrHn2VowDCD+0YGcRipBDtlbZRYE9QWnP8kZDbFvNuATPJIUMmKKl10Uh7EGzla8tw2i
         xV+HglY1ZC3ONIMpefJwM7O2oJXjayNMILK1Fu7L15zMY4qcWQQXjHfCJrjctp1goQRJ
         nszA==
X-Gm-Message-State: APt69E0fBWo3rDGW5mTUkfeVixJSB9P4b4YLRzhOPTpJ26gAU5z1WW74
        I+FXqNVoUGsG3STixEP65uKGA46hBs0AG+Rg7aI=
X-Google-Smtp-Source: ADUXVKJSvs9dnNmkBSPyIxz7ryGYIdWXirOknp71vcf8jemGwlrTruEHywh5GyIiPyDpnRZSZwUALmPXb4gh+OqZ9HM=
X-Received: by 2002:a37:4142:: with SMTP id o63-v6mr1659659qka.287.1528974972833;
 Thu, 14 Jun 2018 04:16:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:22b2:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 04:15:32
 -0700 (PDT)
In-Reply-To: <CADYN=9LztFGUOb-RaEByN-G-E1MpnEv_HtZtObhyZUWWt0nffg@mail.gmail.com>
References: <CA+G9fYuuiYES7ucAhgf8P-YXJPaYY2pi6kRKf6eBrfHvXJbQiw@mail.gmail.com>
 <20180612083435.7f7k4exergraaa2u@gauss3.secunet.de> <CADYN=9LztFGUOb-RaEByN-G-E1MpnEv_HtZtObhyZUWWt0nffg@mail.gmail.com>
From:   William Tu <u9012063@gmail.com>
Date:   Thu, 14 Jun 2018 04:15:32 -0700
Message-ID: <CALDO+SY6BGctJtZamvATrXDpy7zFCCGid5kqsZRQ7mtFUdxZ-Q@mail.gmail.com>
Subject: Re: mainline: x86_64: kernel panic: RIP: 0010:__xfrm_policy_check+0xcb/0x690
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Networking <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        herbert@gondor.apana.org.au,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 5:09 AM, Anders Roxell <anders.roxell@linaro.org> w=
rote:
> On 12 June 2018 at 10:34, Steffen Klassert <steffen.klassert@secunet.com>=
 wrote:
>> On Mon, Jun 11, 2018 at 10:11:46PM +0530, Naresh Kamboju wrote:
>>> Kernel panic on x86_64 machine running mainline 4.17.0 kernel while tes=
ting
>>> selftests bpf test_tunnel.sh test caused this kernel panic.
>>> I have noticed this kernel panic start happening from
>>> 4.17.0-rc7-next-20180529 and still happening on 4.17.0-next-20180608.
>>>
>>> [  213.638287] BUG: unable to handle kernel NULL pointer dereference
>>> at 0000000000000008
>>> ++[ ip xfrm poli  213.674036] PGD 0 P4D 0
>>> [  213.674118] audit: type=3D1327 audit(1528917683.623:7):
>>> proctitle=3D6970007866726D00706F6C69637900616464007372630031302E312E312=
E3130302F3332006473740031302E312E312E3230302F33320064697200696E00746D706C00=
737263003137322E31362E312E31303000647374003137322E31362E312E3230300070726F7=
46F006573700072657169640031006D6F64650074756E6E
>>> [  213.677950] Oops: 0000 [#1] SMP PTI
>>> cy[ add src 10.1.  213.677952] CPU: 2 PID: 0 Comm: swapper/2 Tainted:
>>> G        W         4.17.0-next-20180608 #1
>>> [  213.677953] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
>>> 2.0b 07/27/2017
>>> [  213.726998] RIP: 0010:__xfrm_policy_check+0xcb/0x690
>>> [  213.731962] Code: 80 3d 0a d8 f1 00 00 0f 84 c1 02 00 00 4c 8b 25
>>> 2b af f4 00 e8 66 a6 6a ff 85 c0 74 0d 80 3d eb d7 f1 00 00 0f 84 d5
>>> 02 00 00 <49> 8b 44 24 08 48 85 c0 74 0c 48 8d b5 78 ff ff ff 4c 89 ff
>>> ff d0
>>
>> This looks like a bug that I've seen already. If it is what I think,
>> then commit 2c205dd3981f ("netfilter: add struct nf_nat_hook and use
>> it") introduced this bug.
>>
>> There was already a fix for this on the netdev list, but
>> I don't know the current status of that patch:
>>
>> https://patchwork.ozlabs.org/patch/921387/
>
> Hi, I applied the patch and ran bpf/test_tunnel.sh and I I couldn't
> see any crash.
> However, the script never returned (I had to Ctrl+c to get back), any ide=
as ?
> See log from the test below.
>
> Cheers,
> Anders
>
> [0;92mPASS: xfrm tunnel[0m

Hi Anders,
I think it should return 0 if you reach the above line.
The console output looks pretty messy due to using 'tee'
I will send a patch to make the output more readable.

Thanks
William
