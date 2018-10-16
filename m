Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630B0C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AFB32089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqL/1weJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AFB32089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbeJPMmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:42:46 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36980 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbeJPMmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:42:46 -0400
Received: by mail-wr1-f66.google.com with SMTP id y11-v6so23744446wrd.4;
        Mon, 15 Oct 2018 21:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=4RTbRxsDJCzmWQwMBiR5E1tOA3tl/s4MT9DXmaGA/kU=;
        b=aqL/1weJMDrL/H2GKHmrv77f2RiXWGEEWOh+Baizc71+7kbk2kS9unYtjFkNm4xqcO
         v6oWQQutNz0kWK4AWL9eAX/D1updyAaAzR7CijrhADwYdbcn27a8sAS+QMqrQH+K+vju
         wUQ9THQlrjHDrLjIhwxcqXOSIlpRYzd6XaLAEpBeTTW2abrCIvYONmKJ38saYNKaBAjw
         XY9ANoU7Ye3azK01opnTwOX3xol3fPImQ7I/wkWb6fU/WrKH2k2nOUkTyXDoU3pkB/9T
         y1M3pwZAv9mv+FIaToynnS7KZ+WFcIcUj9OsgCWl4mu07P+0z0v+Z6WwASQGJUbtz6sc
         32tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=4RTbRxsDJCzmWQwMBiR5E1tOA3tl/s4MT9DXmaGA/kU=;
        b=Oi83a2lUHNVAZRLTxzixICaLyccL4rowFlqyS6sY/P/Gk0iP/O6h8YHGQfc4FYfFmH
         xDgXtGYO+N4686A11cbv+wexsDLzUTWnWfG5U2DTp7AIiHFk9hNqYxWoRDOmjBnJqxui
         eHBnjwVVSLLTgXuIQUUCMeAoVfH/zGpVfThTPfxjPHilmBdIWMNoPV2Ru6hSSHj6sSUG
         k/ZuU4uF2Qy3y2PaPwEHIlJpHm2mZ9us7HwJgCEe/kbbMmjNURd4nO5KJlWCSxipQmhe
         Qu4Z0QR9l2xvyqko2fpx0iDOosxFBVDcY6gNYUs/7Jp3ZFDsqGwrokleojcX+vljeTPh
         23yw==
X-Gm-Message-State: ABuFfojRtzVqkVcmH8ZmdQ1d10WBPF9y/DFgwZ22bT1ddkluAwm7xgvz
        T8Z03ndHXOaFd0zH7gj9YzM=
X-Google-Smtp-Source: ACcGV602hE29hsHiup7T9fnI186jwpUvwBypXVqUUBsA7n6jXibqYau9lF459PJpDNCwZphlBPQtCA==
X-Received: by 2002:a5d:6242:: with SMTP id m2-v6mr16999498wrv.162.1539665650976;
        Mon, 15 Oct 2018 21:54:10 -0700 (PDT)
Received: from [172.16.20.20] ([94.204.252.234])
        by smtp.gmail.com with ESMTPSA id d16-v6sm9674559wrw.78.2018.10.15.21.54.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 21:54:10 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] clk: meson-gxbb: set fclk_div3 as CLK_IS_CRITICAL
From:   Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <ed6a889eeec4e2809f0840c9e8188b5e4b24fa76.camel@baylibre.com>
Date:   Tue, 16 Oct 2018 08:54:05 +0400
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <8A3A1316-DC7F-4C5A-9DD8-C115EBB613BB@gmail.com>
References: <1539425086-10997-1-git-send-email-christianshewitt@gmail.com>
 <20181013160810.88481.14237@resonance>
 <ed6a889eeec4e2809f0840c9e8188b5e4b24fa76.camel@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Oct 2018, at 9:07 pm, Jerome Brunet <jbrunet@baylibre.com> wrote:
>=20
> On Sat, 2018-10-13 at 18:08 +0200, Michael Turquette wrote:
>> Quoting Christian Hewitt (2018-10-13 12:04:46)
>>> On the Khadas VIM2 (GXM) and LePotato (GXL) board there are problems
>>> with reboot; e.g. a ~60 second delay between issuing reboot and the
>>> board power cycling (and in some OS configurations reboot will fail
>>> and require manual power cycling).
>>>=20
>>> Similar to 'commit c987ac6f1f088663b6dad39281071aeb31d450a8 ("clk:
>>> meson-gxbb: set fclk_div2 as CLK_IS_CRITICAL")' the SCPI Cortex-M4
>>> Co-Processor seems to depend on FCLK_DIV3 being operational.
>>>=20
>>> Bisect gives 'commit 05f814402d6174369b3b29832cbb5eb5ed287059 ("clk:
>>> meson: add fdiv clock gates") between 4.16 and 4.16-rc1 as the first
>>> bad commit. This added support for the missing clock gates before =
the
>>> fixed PLL fixed dividers (FCLK_DIVx) and the clock framework which
>>> disabled all the unused fixed dividers, thus it disabled a critical
>>> clock path for the SCPI Co-Processor.
>>>=20
>>> This change simply sets the FCLK_DIV3 gate as critical to ensure
>>> nothing can disable it.
>>=20
>> I'm a bit skeptical of this. If FCLK_DIV3 is gated at run-time, there =
is
>> no side effect other than long and/or failed reboot?
>>=20
>> Seems like someone should be managing this clock, and simply leaving =
it
>> on all the time isn't necessarily the right approach. Any chance that
>> you can dig into this behavior to better understand it?
>>=20
>> It's easy to solve issues by leaving clocks on all the time, but this
>> becomes a problem later on when trying to tune a device for power.
>=20
> Hi Mike,
>=20
> I totally agree with you and, in perfect a world, I would prefer not =
to use this
> CLK_IS_CRITICAL at all. It looks like a cheap fix for:
>=20
> "this is required, I don't for what but it is, so please leave it on"
>=20
> The problem is this issue is a regression. We added a few gates to =
better model
> the clock tree a while ago. Before, those those clock were left =
enabled by the
> bootloader.
>=20
> Now that linux turn them off, we are learning a few things about what =
the FWs
> are doing behind our backs.
>=20
> Among the 5 clocks which got a new gates, only 2 needs to back the old =
way using
> CLK_IS_CRITICAL, so this is still an improvement.
>=20
>>=20
>> Also, if this commit really is the right fix, it should include a
>> comment for FCLK_DIV3 stating why the CLK_IS_CRITICAL flag was set,
>> which may be helpful later on to know if it is safe to remove it. =
Same
>> is true for FCLK_DIV2 in c987ac6f1f088663b6dad39281071aeb31d450a8.
>=20
> +1 There should be FIXME notice in the driver explaining why we put =
that flag in
> the first place, so we can remove it as soon as a driver properly =
handle this
> clock.
>=20
> Christian, is Ok if I amend your patch, or do you prefer to post a v2 =
?
> Mike, with explained, is this change OK with you ?

I=E2=80=99m happy for you to amend, it=E2=80=99s easier for me.
Christian

>>=20
>> Regards,
>> Mike
>>=20
>>>=20
>>> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
>>> ---
>>> drivers/clk/meson/gxbb.c | 1 +
>>> 1 file changed, 1 insertion(+)
>>>=20
>>> diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
>>> index 86d3ae5..4c8925d 100644
>>> --- a/drivers/clk/meson/gxbb.c
>>> +++ b/drivers/clk/meson/gxbb.c
>>> @@ -509,6 +509,7 @@ static struct clk_fixed_factor =
gxbb_fclk_div3_div =3D {
>>>                .ops =3D &clk_fixed_factor_ops,
>>>                .parent_names =3D (const char *[]){ "fixed_pll" },
>>>                .num_parents =3D 1,
>>> +               .flags =3D CLK_IS_CRITICAL,
>>>        },
>>> };
>>>=20
>>> --=20
>>> 2.7.4

