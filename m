Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BDCC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 20:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 376C720892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 20:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgqdJK+w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 376C720892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731861AbeG3VzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 17:55:21 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:37115 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731418AbeG3VzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 17:55:21 -0400
Received: by mail-oi0-f65.google.com with SMTP id k81-v6so23672437oib.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 13:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d8Aa49i6UZlynlyuUiYCrV+/UzhlPVdCZDLgHOvc7Qs=;
        b=NgqdJK+wmQKnNBgRRf12PwYy8KY4F41bUI/prVYI79xJhMalB53YXklhoxw+hJCBT9
         UJQfByqIGjYdsAKHiImnzBD8aYa1zRxNCXtMwG3iLl0IOLya1Rc6aCpivniyz6+jtInC
         f4xVWieLupIFW0EVBOcdk7MUQ0Nw0G3zBseqhZXioCdhvbpVQDsX1T22f6jBA18tGsmB
         +GN0cu7QFkC2IxTTBDqgqESyKYP5rdGiJ27pPAhBbEnAJrgMz3/PtP/0hibtmmSrMzBd
         igYpMMXL83+M8H0M2cDxXBsdx9nK79J5cLfRSCUKk9ws3hG7Vb05RjjZj9xmUJaHrk0e
         F/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d8Aa49i6UZlynlyuUiYCrV+/UzhlPVdCZDLgHOvc7Qs=;
        b=Qn1ulN3fR6e3vG0qeb3BCSg75C6vsv1idIbYXPi7Ii9D4vZlgpyw16+1Tf/u0HyXAi
         wpn3HBpu58RBEDTsqekaKZnU8oeBl1z6OhZLnV8c/QX6zap6lPE1V20n/g5FIScbJG+h
         MZRsCfmpGZUG7/KE30HzBRc4qTv8Xq2e4LPTSqjYN5HWz9uvgMJ+EMdjCy77CDQn+cs+
         JRnyV2V1hpdycY66tH73lUhLQg1k58DGfbtNRRzPt5/8X1FlpYdeBhE54D8dv0IaiqeF
         AXBT4yvVGpCrH8Um0jGQQy7ihEp5siwuI54Ot1mSTt3gZ5ceAP/u2N808FRuum3u5+UV
         UzIw==
X-Gm-Message-State: AOUpUlHAqKtJsqmogyUeFqo+gaGBQmKIPyoC7LniKgbEfE18VFeXQs55
        NXR+clI2p9PHEgvFhJASJ9W/SGFWidY4u29EZhE=
X-Google-Smtp-Source: AAOMgpdmJa0alDRGCbKLavHbXBr25maxK9PAqV4iQM5389ACYEiMxWqhkV8IhPVN44g+iUlWZ6RH8s++ksZ7meJD5Hc=
X-Received: by 2002:aca:390a:: with SMTP id g10-v6mr20894199oia.145.1532981922424;
 Mon, 30 Jul 2018 13:18:42 -0700 (PDT)
MIME-Version: 1.0
References: <20180729202108.GB14390@darkstar.musicnaut.iki.fi>
 <20180729222936.27608-1-tsotsos@gmail.com> <20180730085149.GA8460@kroah.com>
In-Reply-To: <20180730085149.GA8460@kroah.com>
From:   Georgios Tsotsos <tsotsos@gmail.com>
Date:   Mon, 30 Jul 2018 23:18:31 +0300
Message-ID: <CADERADM_ZAa1yNPOEmjnmdqAPU6CbT-Hb44ExYQ3B-x5ceL8ow@mail.gmail.com>
Subject: Re: [PATCH v5] Staging: octeon-usb: Using defined error codes and
 applying coding style.
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, James Hogan <jhogan@kernel.org>,
        linux-kernel@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes reseeding in a better way seems logical, i even got lost
with the patch series. I will return with more consistent
series.
On Mon, 30 Jul 2018 at 11:51, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jul 30, 2018 at 01:29:36AM +0300, Georgios Tsotsos wrote:
> > Replaced -1 with defined error code EINVAL
> >
> > Signed-off-by: Georgios Tsotsos <tsotsos@gmail.com>
> > ---
> > v2: Apply coding style to function cvmx_usb_poll_channel
> > v3: Break down function cvmx_usb_poll_channel
> > v4: Return defined error code and applying coding style for function calls
> > v5: Fixing wrong patch applied before with typo on dev_err and applying coding
> > style as suggested on v3
> >
> >  drivers/staging/octeon-usb/octeon-hcd.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>
> Ugh, I have no idea anymore what patches to apply from you for this
> driver, sorry, there are too many flying around.
>
> Take a day off, relax, and then resend all of your pending patches as
> one series, properly numbered, and we can go from there.  I've dropped
> all of your patches from my queue for now.
>
> thanks,
>
> greg k-h



-- 
Best regards!
Georgios Tsotsos
Greece-Evia-Chalkida
tsotsos@linux.com
skype: tsotsos
------------------------------------
Georgios Tsotsos
*Greece - Evia - Chalkida*
tsotsos[at]linux.com
skype: tsotsos
