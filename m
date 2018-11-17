Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DD7C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 20:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AA8B20815
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 20:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="p+jlhSD5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AA8B20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbeKRGuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 01:50:24 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35957 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbeKRGuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 01:50:23 -0500
Received: by mail-ot1-f68.google.com with SMTP id k98so24443186otk.3;
        Sat, 17 Nov 2018 12:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=00snXeh7557yzMxzdXvmUgS4LegSqm94ttqQmDwzQpg=;
        b=p+jlhSD5odqonxKDooEfQnn2lTUszIF+9/djRKr5MQmWAl6Ja4OdiFAyyjn7TIBstu
         xXCEOBYYn4Vq/11qzCT9PgVQB6CmMz0wwMO9i+JkrgQn/fX/UtBMoVcS4xNUZ1mb7jZ1
         yIUxQpHCYEhH2Gbsh8xKH41jAOgArLebMvxWMxhKUZuihsnAr5s2lVURVNWICA0DhEF3
         hE6w1QTLeb0K96K16Bb8fLiacWaXjLFKCasqg1KuRS8dpVstRt3eGmpB8TD8XepQOr2v
         M/rYsNW9jeoDmaEdwEK7MDbttmZ8wH7XCwJKsSWHrA2MzMhiNobUJtK3AkzKDs3NDiru
         vrZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=00snXeh7557yzMxzdXvmUgS4LegSqm94ttqQmDwzQpg=;
        b=jlD4x0Bfr7bpef8mhYiKyrAXiUzFHKWzzcNx7tdKo97lC01hE3WI8gP+2yy+Bj4xCA
         UFGyUk3+xx3hFSDvG+TVpRkJRtxTJRhfRD4juqX+2pHnIiz0ZA+74cA54KhF7X5hI+d0
         hmrzDqKdI0OoOrKervHKJx7WA83DhqcwFtsqZhxwng39xLiMhDz8XsrAlKz3BuEPXy2Q
         NNy76zsfB0632AgsfvXFA5uIW1BGwoPrudKxTntDLppjKxJAMxxY/M65OlRi7ckhi8bu
         GY9qhKGKpn0tPbf5C/SXrCP4brMVTM8Vsen+pr1ui1xkJeVzMez2T2q2T6PUVIY2jtN5
         5mNQ==
X-Gm-Message-State: AGRZ1gLaXBUSLOV5iNN+6KZMiZ+Z0Jmontt1ub5H4PFMV5D7Wp1gc0XP
        rBI+1syj4IikjKbQqXK8j0YrtdGwcHlihVVgV+5779tv3aU=
X-Google-Smtp-Source: AJdET5e0P/DREOYwL+IomHxYcsGxBWnT/oXQohdKRnGOV/wXFagCnF5LCQIb1044tul+lKEsI0zzxBpMe8t6OoXyku0=
X-Received: by 2002:a9d:491e:: with SMTP id e30mr10001732otf.131.1542486751757;
 Sat, 17 Nov 2018 12:32:31 -0800 (PST)
MIME-Version: 1.0
References: <20181114131627.17766-1-narmstrong@baylibre.com> <20181114131627.17766-2-narmstrong@baylibre.com>
In-Reply-To: <20181114131627.17766-2-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 17 Nov 2018 21:32:20 +0100
Message-ID: <CAFBinCAD=muhsHgqGu2pV8T=EyfnEKrocyVWf536nbL0pa5y7A@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: amlogic: Add Internal Clock Measurer bindings
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Wed, Nov 14, 2018 at 2:16 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> The Amlogic Meson GX SoCs embeds a clock measurer IP to measure the internal
> clock paths frequencies.
I would skip the "GX" in that sentence: there's a similar (identical?)
clock measurer in Meson6, Meson8, Meson8b and Meson8m2 as well

>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
with the comment above and below:
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

> ---
>  .../bindings/soc/amlogic/clk-measure.txt          | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt
>
> diff --git a/Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt b/Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt
> new file mode 100644
> index 000000000000..ba9183a42032
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt
> @@ -0,0 +1,15 @@
> +Amlogic Internal Clock Measurer
> +===============================
> +
> +The Amlogic SoCs contains an IP to measure the internal clocks.
> +The precision is multiple of MHz, useful to debug the clock states.
> +
> +Required properties:
> +- compatible: Shall contain "amlogic,meson-gx-clk-measure"
can you please add "amlogic,meson8-clk-measure" and
"amlogic,meson8b-clk-measure" as well?
(I will provide a patch on top of yours to add Meson8 and Meson8b support)


Regards
Martin
