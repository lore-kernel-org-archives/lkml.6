Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8B92BC07E80
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 18:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FD662087E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 18:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lA5GxmVR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FD662087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934483AbeFKS5x (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 14:57:53 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:39067 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933289AbeFKS5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 14:57:51 -0400
Received: by mail-lf0-f65.google.com with SMTP id t134-v6so32171040lff.6;
        Mon, 11 Jun 2018 11:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0yMOs9usCeb9T5XEebbZ84a8uolnDc8ZKmKoxe/xUoo=;
        b=lA5GxmVRPggHKqwTSmvSy1aKcR5FYD/K3gH1BIKb5b2MJURi+6f7fj5Jmo9kipdjHs
         nt9sFdA90ILQsjXn1EiwzQpzhCyu/zLXP73H20Yx8uTk5mHrhUJF6E5bbfTtzHp6H0eg
         0sM9p7oK3cxf+nlAIdKFGXQdA7OPSnug2QBENUgg842e4SC9dv6LBSKIlbarSVTKiyK2
         grktmzTjvqScq8ur5/LHXgwCt0foEJ9GvmqPOiDWyJ/wimcBVxE3kPdNIcDxCRH/7SBu
         xGknotDhhSv0BBNvtlx30B5/Q4BkUo6t4U9e5NULC0kuIDQ8fYFgw8GU/2k10NpTBCm9
         yoLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:user-agent
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=0yMOs9usCeb9T5XEebbZ84a8uolnDc8ZKmKoxe/xUoo=;
        b=s+WD22ayiviKYScSXGH+gskvdGjUMu4hADxh4CbbPwasItgnWFFSm4douDiK62HqC/
         cCHG04wP/oduVDkadN4mrOWtMeNCwSYJUOq5C5y0GZHKgND/l4GHh9o6b09sjGID1Mtf
         LlZsNeeeB54qG/QMPYpLwqKuwSRCImMwFlvpy1gpsKUkZWTkdXjFwPkVr3ZmHH/B55ta
         1vsM5l6Iuh0jPHURRV9n+a01wW3j0eergih30tdClSLDwJzLyYT1ruB0LsVrUvaGTZHn
         buu+KFaNIVxoAvijEyv5HDrpVXSAxkP/4H+g1KQAzkcJPF+Z4T96T+4t4y9Vh8gZv1P0
         S5zQ==
X-Gm-Message-State: APt69E0RNYh4/0/uaXVPPKrp7dUA5pAaRB/rS2gz/r2fzvHc56gGna51
        s9NO4qq+2D5xkBZ4szrmNAk=
X-Google-Smtp-Source: ADUXVKICD781QTEPF8gU4uODfbRi0hupQ8+PoEbsCXdTPxh+zCPuU7lYWjsODa8gH0lCPfjk9OJAmQ==
X-Received: by 2002:a19:a413:: with SMTP id q19-v6mr192134lfc.143.1528743468909;
        Mon, 11 Jun 2018 11:57:48 -0700 (PDT)
Received: from acerlaptop.localnet (user-94-254-173-75.play-internet.pl. [94.254.173.75])
        by smtp.gmail.com with ESMTPSA id p28-v6sm5931229lfh.24.2018.06.11.11.57.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 11:57:48 -0700 (PDT)
From:   =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kgene@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] ARM: dts: s5pv210: Add missing interrupt-controller property to gph2
Date:   Mon, 11 Jun 2018 20:57:39 +0200
Message-ID: <4072275.4u7YMACK2s@acerlaptop>
User-Agent: KMail/5.1.3 (Linux/4.13.0-43-generic; KDE/5.18.0; x86_64; ; )
In-Reply-To: <CAJKOXPcVqaeYoU=tht5GSyEunnboG-+Mxo96LCDewbqDjCfy-A@mail.gmail.com>
References: <1528640149-2195-1-git-send-email-pawel.mikolaj.chmiel@gmail.com> <CAJKOXPcVqaeYoU=tht5GSyEunnboG-+Mxo96LCDewbqDjCfy-A@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, June 11, 2018 2:43:59 PM CEST Krzysztof Kozlowski wrote:
> On Sun, Jun 10, 2018 at 4:15 PM, Pawe=C5=82 Chmiel
> <pawel.mikolaj.chmiel@gmail.com> wrote:
> > This commit adds missing interrupt-controller property to gph2 block,
>=20
> Just "Add missing". See:
> https://elixir.bootlin.com/linux/latest/source/Documentation/process/subm=
itting-patches.rst#L151
>=20
> > to silence following warnings during build
> >   /soc/pinctrl@e0200000/gph2: Missing interrupt-controller or interrupt=
=2Dmap property
> >
> > Observed on not yet mainlined, an S5PV210 based
> > Samsung Galaxy S (i9000) phone.
>=20
> The warning is not reproduceable (as you mentioned board is not
> present in mainline) thus please skip it. Instead, either describe
> existing reason for this change (e.g. because bindings require it for
> node of every bank of pins supporting GPIO interrupts) or include this
> in series mainlining new board (where the reason will be - it will be
> used by new board etc).
>=20
> Best regards,
> Krzysztof
>=20
Ok, I'll send this patch (fixed) with other patches adding new board.

Thanks

