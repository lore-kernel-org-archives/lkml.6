Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5DFC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 903F72183F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547195576;
	bh=azJo3pr89+SKEM362N0XLet7Y0w+F6c96PjeR6Lm2uI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=cJAiVa8UcO+tW1zsjj5wgXsZ1ZDluCq4UMNinDPBHuW4fOqoQykjTw0N0p9g3l+Pf
	 6DDlhjDqq87AGnZEyl10syPO0WoSdX1Zw+RRK68Li5iox9ccz2Y0nl5dmPvKl6kg+m
	 NittCVDdqa99YubosgGHv2wjnbiPv6dur6Aahcvo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730674AbfAKIc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 03:32:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:56108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730517AbfAKIcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 03:32:55 -0500
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A176C2173B;
        Fri, 11 Jan 2019 08:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547195575;
        bh=azJo3pr89+SKEM362N0XLet7Y0w+F6c96PjeR6Lm2uI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rOQlCBLv5mqJhT1DVajIbXdDBdTz/C6NfKeHt2tAKIqS5EDsUcjcQ0Vo9Is96U3eD
         OycWsy6HCVV/GBcXipfYy0QjP59CRvlj0u3dasiAi6tqKm2uEgtrSA/NAkcU9a5Brl
         RPIJWP5y5Wg9FgOhi5pbqm26zS/qcNROsepUO8jE=
Received: by mail-lf1-f48.google.com with SMTP id b20so10181138lfa.12;
        Fri, 11 Jan 2019 00:32:54 -0800 (PST)
X-Gm-Message-State: AJcUukeF9YyG4jAD9Xup2dSMUPHxc4FUw92qDuw4RU2k4ck+HqxVxmhg
        H9tU/8DaTTDsXUkAk4ddde8KcRbrs0H17vZ3U7M=
X-Google-Smtp-Source: ALg8bN7DnleXAa10jFv80f5pt8kv86oa/SCKTA0ka4ni5pAL6JXCTJhpc8llfAdDAA6ujc/DGKWSBpNdYyfpNiu0HTw=
X-Received: by 2002:a19:660a:: with SMTP id a10mr8129491lfc.146.1547195572807;
 Fri, 11 Jan 2019 00:32:52 -0800 (PST)
MIME-Version: 1.0
References: <20190110205215.22030-1-pawel.mikolaj.chmiel@gmail.com> <20190110205215.22030-2-pawel.mikolaj.chmiel@gmail.com>
In-Reply-To: <20190110205215.22030-2-pawel.mikolaj.chmiel@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 11 Jan 2019 09:32:41 +0100
X-Gmail-Original-Message-ID: <CAJKOXPcWOtTh5nDpZuX=NfrcOcQDPUXoFJLc8JtLs6UEY9LL6w@mail.gmail.com>
Message-ID: <CAJKOXPcWOtTh5nDpZuX=NfrcOcQDPUXoFJLc8JtLs6UEY9LL6w@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] ARM: dts: s5pv210: Add dmc nodes
To:     =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Cc:     kgene@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, viresh.kumar@linaro.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2019 at 21:53, Pawe=C5=82 Chmiel
<pawel.mikolaj.chmiel@gmail.com> wrote:
>
> This commit adds dmc nodes, which are needed by s5pv210 cpufreq driver
> to work.
>
> Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  arch/arm/boot/dts/s5pv210.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>

Thanks, applied (actually I applied v1 - I hope there were no changes).

Best regards,
Krzysztof
