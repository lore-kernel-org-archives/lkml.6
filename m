Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6F3BCC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C586208B8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="d/Wp0dHy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C586208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755011AbeFNLrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 07:47:17 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33104 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752929AbeFNLrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 07:47:15 -0400
Received: by mail-pf0-f196.google.com with SMTP id b17-v6so3127770pfi.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 04:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=p3n4EcxvrIItbAiPYlP6bZTt6yX8oje+1aaB8fJAtqc=;
        b=d/Wp0dHyz4jYcw+DBH1DJZrMUzvWERr1hVsLGPQ/Cf3GvJv0JIlm/o1eknOvV2FGGF
         r/bYvPAhodqdsMlPBrbi1GH5/Y5qbe0bn5HXSk0Wj44IkQcanCzzeabJYZy67a4IEs8L
         w0qZa1VGB42j+bxa2d2DwJt/c/uljvqRneaWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=p3n4EcxvrIItbAiPYlP6bZTt6yX8oje+1aaB8fJAtqc=;
        b=DL7zpvkdFEurTxxCVRkjvnE8oU1bNJrc6qiYL50uH3KCle6umVa/jcxHLWmGtBgtN1
         kwDWQ4m9RBRW/sZNWbAQ2hRr/BKhwYhjilXR4IFy5hF3JRlf+plmkdaquV0gcO6AyVzT
         DEqPEX/QP2LR6LSdPWF+gwjV46OmmkyrJX1oI3FRsqrXtGR5TfSacRAnThUEp1nIjdF2
         EJXTnaArsxyU0rNEnVdo6j+Rcu+orfdX3VjoX21pkQRnlJLrnn0wMLNaJs/ZYQ9t1Fe/
         /VJ15yKZWevI8ryPnYjM1aMeMAJ8dflKqKwsc0E4ZMSMConkQN8Impvd/88BGV6mumSp
         /INw==
X-Gm-Message-State: APt69E1SAQXgl2KfmpkiudltLszOSh50XnTWaG6NeZDwKrlh/mTFYZlm
        dc8lRk+Mu7gwZpGxMzkFjqHUbwgLiUq7nceb70k0IA==
X-Google-Smtp-Source: ADUXVKInyqDzOnl+Yqo9gMoBoRH3BG8TUVza2PgT2n4BSj3UybQGH1pjD6wsXFY8fSXTwy+wJU42AF0TeRlNtiycziI=
X-Received: by 2002:a62:9c9c:: with SMTP id u28-v6mr9254113pfk.90.1528976835172;
 Thu, 14 Jun 2018 04:47:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:178d:0:0:0:0 with HTTP; Thu, 14 Jun 2018 04:47:14
 -0700 (PDT)
In-Reply-To: <CALDO+SY6BGctJtZamvATrXDpy7zFCCGid5kqsZRQ7mtFUdxZ-Q@mail.gmail.com>
References: <CA+G9fYuuiYES7ucAhgf8P-YXJPaYY2pi6kRKf6eBrfHvXJbQiw@mail.gmail.com>
 <20180612083435.7f7k4exergraaa2u@gauss3.secunet.de> <CADYN=9LztFGUOb-RaEByN-G-E1MpnEv_HtZtObhyZUWWt0nffg@mail.gmail.com>
 <CALDO+SY6BGctJtZamvATrXDpy7zFCCGid5kqsZRQ7mtFUdxZ-Q@mail.gmail.com>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Thu, 14 Jun 2018 13:47:14 +0200
Message-ID: <CADYN=9KM58BVk_+q8ZoUSwHDN0_L+uBXLFBT0rijFsUhdFXE3g@mail.gmail.com>
Subject: Re: mainline: x86_64: kernel panic: RIP: 0010:__xfrm_policy_check+0xcb/0x690
To:     William Tu <u9012063@gmail.com>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Networking <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 June 2018 at 13:15, William Tu <u9012063@gmail.com> wrote:
> On Tue, Jun 12, 2018 at 5:09 AM, Anders Roxell <anders.roxell@linaro.org>=
 wrote:
>> On 12 June 2018 at 10:34, Steffen Klassert <steffen.klassert@secunet.com=
> wrote:
>>> On Mon, Jun 11, 2018 at 10:11:46PM +0530, Naresh Kamboju wrote:
>>>> Kernel panic on x86_64 machine running mainline 4.17.0 kernel while te=
sting
>>>> selftests bpf test_tunnel.sh test caused this kernel panic.
>>>> I have noticed this kernel panic start happening from
>>>> 4.17.0-rc7-next-20180529 and still happening on 4.17.0-next-20180608.
>>>>
>>>> [  213.638287] BUG: unable to handle kernel NULL pointer dereference
>>>> at 0000000000000008
>>>> ++[ ip xfrm poli  213.674036] PGD 0 P4D 0
>>>> [  213.674118] audit: type=3D1327 audit(1528917683.623:7):
>>>> proctitle=3D6970007866726D00706F6C69637900616464007372630031302E312E31=
2E3130302F3332006473740031302E312E312E3230302F33320064697200696E00746D706C0=
0737263003137322E31362E312E31303000647374003137322E31362E312E3230300070726F=
746F006573700072657169640031006D6F64650074756E6E
>>>> [  213.677950] Oops: 0000 [#1] SMP PTI
>>>> cy[ add src 10.1.  213.677952] CPU: 2 PID: 0 Comm: swapper/2 Tainted:
>>>> G        W         4.17.0-next-20180608 #1
>>>> [  213.677953] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
>>>> 2.0b 07/27/2017
>>>> [  213.726998] RIP: 0010:__xfrm_policy_check+0xcb/0x690
>>>> [  213.731962] Code: 80 3d 0a d8 f1 00 00 0f 84 c1 02 00 00 4c 8b 25
>>>> 2b af f4 00 e8 66 a6 6a ff 85 c0 74 0d 80 3d eb d7 f1 00 00 0f 84 d5
>>>> 02 00 00 <49> 8b 44 24 08 48 85 c0 74 0c 48 8d b5 78 ff ff ff 4c 89 ff
>>>> ff d0
>>>
>>> This looks like a bug that I've seen already. If it is what I think,
>>> then commit 2c205dd3981f ("netfilter: add struct nf_nat_hook and use
>>> it") introduced this bug.
>>>
>>> There was already a fix for this on the netdev list, but
>>> I don't know the current status of that patch:
>>>
>>> https://patchwork.ozlabs.org/patch/921387/
>>
>> Hi, I applied the patch and ran bpf/test_tunnel.sh and I I couldn't
>> see any crash.
>> However, the script never returned (I had to Ctrl+c to get back), any id=
eas ?
>> See log from the test below.
>>
>> Cheers,
>> Anders
>>
>> [0;92mPASS: xfrm tunnel[0m
>
> Hi Anders,
> I think it should return 0 if you reach the above line.

Yes it should but it didn't.
However, when I reran the test_tunnel.sh today with kernel next-20180613
I got back from from the script and the test passed "PASS: xfrm tunnel".
So I'm not sure what happened before. =3D/

> The console output looks pretty messy due to using 'tee'
> I will send a patch to make the output more readable.

Great.

Cheers,
Anders
