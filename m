Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447A7C5AC75
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 14:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF32221871
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 14:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VJ8aTESy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbeLXOiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 09:38:46 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:44462 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbeLXOiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 09:38:46 -0500
Received: by mail-yb1-f195.google.com with SMTP id e1so273074ybn.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 06:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9hmzXNSF3rcxzeNlnW6aEdTLRczQdcIzjMLEHrLazF0=;
        b=VJ8aTESyYZaTHqdX9nKTufETrhx7b5WTXGeMJhGCV5O9EUQc7lZ/FV2rxhQeGnjth3
         SyL2C0CuZ+gSMlZ6a8gJvf+12X21W7AzP7YKNGeWfOMSZw2cyJXsjNJOo+QXw7z3p1ty
         a7tjDMjGrwnJIqGf9wkattJO63GjPlBO/WbeETjUw8TmGBWNAKQGYYxdqqRlI/RJ+aXM
         J00rHA9ltVyBW8tqlwkvnqZYi/GcwjmBhn+S5UufiK04OIHNZfvxvIwOs4PLbUxGZ1Y3
         jmmRYIw6TKLCQLCbdsroSnYfjkN5F3NtHJ6C0N5iKepC7ID9OR53zRsnu177YYbpoWFP
         yTeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9hmzXNSF3rcxzeNlnW6aEdTLRczQdcIzjMLEHrLazF0=;
        b=iG6vUxJ/yx71quaHgDytFbuHfhmaTm2hWsgJZ8tab/EPwWh0SRd7gl009pVMXngpIJ
         oHEtpxKV3ZV8YOocqYw15XWhxQi6D3D/ItD6mWxnqr5cCjxKCODegOEIFEFQfFRbMiCE
         VLiOL6UgxHFP/1AlgYkX/lSMLG56gGDNDI51Xv4l72cckDs+r3b51xrzk16SnwFQx+rT
         efCoDhba0o1o+/l12toKcJyRLIrhuaiMo9KkmwViSQq/zgm8MgC9LYTdP+6377BCLr6U
         Arn01ZtOmzKODgWk5sqA0Yi6IlG1jrVR5W+fphxEqhw9JkP67sxeI7EjCi87kercZ2+o
         mjLA==
X-Gm-Message-State: AA+aEWbW4O8uFf5NGi0eQGgYLo977U4J8SK56gHwW8eJit1Fo+k55t69
        WqrxcdUAPaCnM8xtIih3UeCiXv79bQ+jf3UL8AtSKw==
X-Google-Smtp-Source: ALg8bN4NkHmkTlqb50Dj40tM86zRrKBmvRDr1HuI28rJFw0leDyDn2nAJUbRBOn2oMY7ubdic3CcInDkjPcil8pVzQI=
X-Received: by 2002:a25:48c7:: with SMTP id v190-v6mr12927429yba.7.1545662324014;
 Mon, 24 Dec 2018 06:38:44 -0800 (PST)
MIME-Version: 1.0
References: <20181224083724.75618-1-cychiang@chromium.org> <20181224083724.75618-2-cychiang@chromium.org>
In-Reply-To: <20181224083724.75618-2-cychiang@chromium.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Mon, 24 Dec 2018 06:38:33 -0800
Message-ID: <CABXOdTdoz-sG3t0n3kKUd0ydJmnmMsoaOJ=yQzWOtT0A8Qp2kw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] ASoC: Documentation: Add google,cros-ec-codec
To:     Cheng-Yi Chiang <cychiang@chromium.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Dylan Reid <dgreid@chromium.org>, tzungbi@chromium.org,
        Rohit kumar <rohitkr@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 24, 2018 at 12:39 AM Cheng-Yi Chiang <cychiang@chromium.org> wrote:
>
> Add documentation for Chrome EC codec driver.
>
> Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> ---
>  Change in v2: Fixed name of driver in MAINTAINERS.
>
>  .../bindings/sound/google,cros-ec-codec.txt   | 24 +++++++++++++++++++

Since this is a devicetree binding, it will require an Ack from a DT
maintainer. You might want to check the output of
scripts/get_maintainer.pl to make sure you don't miss anyone
important.

Guenter

>  MAINTAINERS                                   |  5 ++++
>  2 files changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt
>
> diff --git a/Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt b/Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt
> new file mode 100644
> index 0000000000000..57718382b3a36
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt
> @@ -0,0 +1,24 @@
> +* Audio codec controlled by ChromeOS EC
> +
> +Google's ChromeOS EC codec is a digital mic codec provided by the
> +Embedded Controller (EC) and is controlled via a host-command interface.
> +
> +An EC codec node should only be found as a sub-node of the EC node (see
> +Documentation/devicetree/bindings/mfd/cros-ec.txt).
> +
> +Required properties:
> +- compatible: Must contain "google,cros-ec-codec"
> +- #sound-dai-cells: Should be 1. The cell specifies number of DAIs.
> +
> +Example:
> +
> +cros-ec@0 {
> +       compatible = "google,cros-ec-spi";
> +
> +       ...
> +
> +       cros_ec_codec: ec-codec {
> +               compatible = "google,cros-ec-codec";
> +               #sound-dai-cells = <1>;
> +       };
> +};
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5b9c6af98283b..05e1922624e58 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3636,6 +3636,11 @@ S:       Maintained
>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/bleung/chrome-platform.git
>  F:     drivers/platform/chrome/
>
> +CHROMEOS EC CODEC DRIVER
> +M:     Cheng-Yi Chiang <cychiang@chromium.org>
> +S:     Maintained
> +F:     Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt
> +
>  CIRRUS LOGIC AUDIO CODEC DRIVERS
>  M:     Brian Austin <brian.austin@cirrus.com>
>  M:     Paul Handrigan <Paul.Handrigan@cirrus.com>
> --
> 2.20.1.415.g653613c723-goog
>
