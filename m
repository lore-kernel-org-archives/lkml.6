Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73004C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ADD725220
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GSSBt5uF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ADD725220
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932767AbeGBHl6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 03:41:58 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36945 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753270AbeGBHlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 03:41:39 -0400
Received: by mail-oi0-f66.google.com with SMTP id k81-v6so14600064oib.4;
        Mon, 02 Jul 2018 00:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Q34IDmNiJV1nBxKJsNz+4VlYbOOuwwxILSxxBAEQKDY=;
        b=GSSBt5uFyQg/nfryomj+Ymx0wtG8/Zt3PZvHL6PXrRMU3bf/lLBYFACsmRRqRfXYgX
         IeIJUFwrVlu/zVV0C5whhb/iyTpG0u1Kkib4RmqqFAgQn0Rqo7Ic5vkfONNHZkwDeLcZ
         3ZquQkme6DpsexBYOid5yx8/y1S1gwqcNbDmbHFXO8yzZSbbvZ3sb2y1b5x04IUHMFdd
         ZWegxh0knn5InWwgCXDRLrr03YTzc+56jj2hAtYoyPOCLPbn6ueS2UUtNqXAmQ/ypo/I
         7HqWPcPFP4+Br+a6aZnzzezzHWcqi4z+Qu67Fo3U1S1PgbY0FfJvFAG5jkHFZT6kzVoy
         V7xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Q34IDmNiJV1nBxKJsNz+4VlYbOOuwwxILSxxBAEQKDY=;
        b=VkaWTpMYh7Qk+5Vp30CODZlRKPXVlxge41jVUoKArMHLBePeddpwrJ1lMKv1zTHv5D
         +djpAzH1bf186uHGnXHqCkU1HFgnlYaoYsmG5fizlyQz/pEgnUQwAKryuCfNiN29DNkE
         8MDZHD6kQy/bBGpdaGAC2SthnRL5eH3qrWOp/LdckZU2Xk6PBHB0P1JMeyEBooYgWSVg
         0PAOqQ6MP8Vymb+8xU4cR+OMvEbGajOjggOplNi8p2V6uyyKK8jrEzaqgiWaToCLrckn
         vRVx8qXkxlqHfH07PKbBR156ayEFxXi+rSSiXfOgykMLJq0BWpR0LBzaypubFXI1KBjc
         WD+g==
X-Gm-Message-State: APt69E0YFsEMa27KRr8TEVuQA4I26MDwMpfFHBQ1HOkMrK9cic5Ruv5M
        //BTj0Wu9yx9w59lyQypvf6TaF7sG4fqoxqw2CY=
X-Google-Smtp-Source: AAOMgpe0CkHAtLkSruBDBz9fwuZF5yhkEgHTntWC65gHjIHSSUChKhwhYvY3ogXnysiFaNr0wcbeBD2JHCyIPJchIWw=
X-Received: by 2002:aca:808:: with SMTP id 8-v6mr14938378oii.198.1530517298647;
 Mon, 02 Jul 2018 00:41:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAE5jQCfP1Z0oTBz_V0QkFwFqtJgekUMD2HZR=qA2oWxPvZrzsQ@mail.gmail.com>
 <20180603184955.zrowxp4y3ij66y5n@eaf> <20180608152557.GB11958@amd>
 <CAE5jQCeCOK5zoH4KbyP+hiMKp4MpkjJN1efzquoXCfPPXoj9Nw@mail.gmail.com> <20180629184542.jwxhruxgp5xv2abt@eaf>
In-Reply-To: <20180629184542.jwxhruxgp5xv2abt@eaf>
From:   Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Date:   Mon, 2 Jul 2018 10:41:27 +0300
Message-ID: <CAE5jQCfP1ZteOhBD3-inASWtp1i-0NuFhZCSKyEy=wx+eQ=bbw@mail.gmail.com>
Subject: Re: Mounting corrupted HFS+ causes kernel NULL pointer dereference
To:     "Ernesto A. Fernandez" <ernesto.mnd.fernandez@gmail.com>
Cc:     pavel@ucw.cz, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you, now (with just this patch applied on top of v4.18-rc2) it
just (asynchronously?) writes `hfsplus: b-tree write err: -5, ino: 3`
to dmesg and does not segfaults.
=D0=BF=D1=82, 29 =D0=B8=D1=8E=D0=BD. 2018 =D0=B3. =D0=B2 21:45, Ernesto A. =
Fern=C3=A1ndez
<ernesto.mnd.fernandez@gmail.com>:
>
> Hi again:
>
> A patch for your original report has already been added to the -mm tree.
>
> On Tue, Jun 12, 2018 at 09:43:26PM +0300, Anatoly Trosinenko wrote:
> > Now, when mounting the attached hfsplus_16mb_segv to /mnt and
> > performing `dd if=3D/dev/zero of=3D/mnt/xyz bs=3D567879 count=3D1` I ge=
t
> >
> > [    1.646451] BUG: unable to handle kernel NULL pointer dereference
> > at 0000000000000043
>
> I just sent you a patch for this second report. It's really simple, so
> it would be great if you could take a look at it and review it yourself.
> Otherwise it's not very likely to get picked up.
>
> Thanks,
> Ernest



--=20
=D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC,
=D0=90=D0=BD=D0=B0=D1=82=D0=BE=D0=BB=D0=B8=D0=B9 =D0=A2=D1=80=D0=BE=D1=81=
=D0=B8=D0=BD=D0=B5=D0=BD=D0=BA=D0=BE
e-mail: anatoly.trosinenko@gmail.com
