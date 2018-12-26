Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E2DC43612
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 07:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F265218A5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 07:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CqY03vAf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbeLZHRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 02:17:39 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:43693 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbeLZHRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 02:17:38 -0500
Received: by mail-ua1-f65.google.com with SMTP id z11so4874865uaa.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 23:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sStBFDNBDUZRn9wWqTM8W3lcGvwpMuwsZGejygCvw4w=;
        b=CqY03vAftC/ACUr6WenWPXq4+zUzfVZihj99mCbvqjitkbzxximsMsAsL7uSc3Lc6N
         FCWXzKh6CjXX7zwKLL1cHs7Of8nRT1JkqTCr6yk5QNUr+v5kherIz+Z6PgFf4UIeopmd
         nIiZXanec2P54UsQvoqTeHPlABVVDkU30BYt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sStBFDNBDUZRn9wWqTM8W3lcGvwpMuwsZGejygCvw4w=;
        b=gDTXDAAEt/7OCykRz3YCO+YUKmlPDoRbzsze6c6lCk0YQ1+LtpNNasrHNBGF9D1Mu3
         s7eS0ISnnl91suNse4tPmwv76zo/deFQWhKNgOdMw1QXFIgZ2kLEAEz+jlj27uh8ldq6
         pQCWaTpKwNMI5/+BAx+rZS7S85IIIslHX8pxKkZ2lOojwm2nIBrNYHJXAIWePEreiZJZ
         CzlmrGTV4vSmzgyOi7GylHeiQvSVcwLmlEyjkWRqFYBOP+UpekAVidjFhNXTIa/IOqTK
         QxfvEW1dBh1DaczGZZKYSZiaPpQ+e4IQjOYCMwPtkkd5Zg8WcvHkzs72EfnixLBwMKEv
         NXNQ==
X-Gm-Message-State: AJcUukd72zbWVmbgeaUgBldacAmR6Abn6G/ZMxZfBPM3zDox79fIaDeC
        i0D7N1vyXRXK5+9jBy5dSg/3lII7aXdwVAp+QiJJ1Jlm6t0=
X-Google-Smtp-Source: ALg8bN5pSVGirgzA3yT8x8KSuN1zxE9sy0dqi1F+mNzpaXqakACNf9DZHkCIuukSgs2r9nRPcUfugmWipnxwtwWzxHk=
X-Received: by 2002:ab0:225a:: with SMTP id z26mr2233607uan.100.1545808656994;
 Tue, 25 Dec 2018 23:17:36 -0800 (PST)
MIME-Version: 1.0
References: <20181224083724.75618-1-cychiang@chromium.org> <20181224083724.75618-2-cychiang@chromium.org>
 <CABXOdTdoz-sG3t0n3kKUd0ydJmnmMsoaOJ=yQzWOtT0A8Qp2kw@mail.gmail.com>
In-Reply-To: <CABXOdTdoz-sG3t0n3kKUd0ydJmnmMsoaOJ=yQzWOtT0A8Qp2kw@mail.gmail.com>
From:   Cheng-yi Chiang <cychiang@chromium.org>
Date:   Wed, 26 Dec 2018 15:17:10 +0800
Message-ID: <CAFv8NwLRDzJcSWyB444XwDqXAX-PknrV7N4V9KcT0NCVgiAXag@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] ASoC: Documentation: Add google,cros-ec-codec
To:     Guenter Roeck <groeck@google.com>
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

On Mon, Dec 24, 2018 at 10:38 PM Guenter Roeck <groeck@google.com> wrote:
>
> On Mon, Dec 24, 2018 at 12:39 AM Cheng-Yi Chiang <cychiang@chromium.org> wrote:
> >
> > Add documentation for Chrome EC codec driver.
> >
> > Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> > ---
> >  Change in v2: Fixed name of driver in MAINTAINERS.
> >
> >  .../bindings/sound/google,cros-ec-codec.txt   | 24 +++++++++++++++++++
>
> Since this is a devicetree binding, it will require an Ack from a DT
> maintainer. You might want to check the output of
> scripts/get_maintainer.pl to make sure you don't miss anyone
> important.
>
> Guenter
>

Thanks for the suggestion.
cc'ed Rob Herring in v3.

> >  MAINTAINERS                                   |  5 ++++
> >  2 files changed, 29 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt
> >
> > diff --git a/Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt b/Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt
> > new file mode 100644
> > index 0000000000000..57718382b3a36
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt
> > @@ -0,0 +1,24 @@
> > +* Audio codec controlled by ChromeOS EC
> > +
> > +Google's ChromeOS EC codec is a digital mic codec provided by the
> > +Embedded Controller (EC) and is controlled via a host-command interface.
> > +
> > +An EC codec node should only be found as a sub-node of the EC node (see
> > +Documentation/devicetree/bindings/mfd/cros-ec.txt).
> > +
> > +Required properties:
> > +- compatible: Must contain "google,cros-ec-codec"
> > +- #sound-dai-cells: Should be 1. The cell specifies number of DAIs.
> > +
> > +Example:
> > +
> > +cros-ec@0 {
> > +       compatible = "google,cros-ec-spi";
> > +
> > +       ...
> > +
> > +       cros_ec_codec: ec-codec {
> > +               compatible = "google,cros-ec-codec";
> > +               #sound-dai-cells = <1>;
> > +       };
> > +};
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 5b9c6af98283b..05e1922624e58 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -3636,6 +3636,11 @@ S:       Maintained
> >  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/bleung/chrome-platform.git
> >  F:     drivers/platform/chrome/
> >
> > +CHROMEOS EC CODEC DRIVER
> > +M:     Cheng-Yi Chiang <cychiang@chromium.org>
> > +S:     Maintained
> > +F:     Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt
> > +
> >  CIRRUS LOGIC AUDIO CODEC DRIVERS
> >  M:     Brian Austin <brian.austin@cirrus.com>
> >  M:     Paul Handrigan <Paul.Handrigan@cirrus.com>
> > --
> > 2.20.1.415.g653613c723-goog
> >
