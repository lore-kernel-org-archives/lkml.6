Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E4B9C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 22:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC100217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 22:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHmIEuzZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbeL1Ww0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 17:52:26 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43231 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbeL1Ww0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 17:52:26 -0500
Received: by mail-lj1-f196.google.com with SMTP id q2-v6so19739286lji.10;
        Fri, 28 Dec 2018 14:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PjI0ZHVTu6WYpNrElbpPf/NUK0zpmDF6Y7VvKGBI5UM=;
        b=SHmIEuzZlres43uPFWrHKnFh70b4VEzU3cV5fimT/U+BvMVXVplo6NuP29dazn5Zpb
         f/UqXxlN+XqJ1mNloiJBOMM8WlRjXADhKblh6obZ/3r9bkM/4WDEPte2jV6H7rDbkLJ1
         hWZzBwp21kdzRbPH1JUZ0pvUnwzvtJLQYb2wmaOGikkeMOjr0eB6LvgEbC5x+n8dqFON
         PRR8B28Sew3aOSY9jcsRXLIcXA/5U5pVyzGtibSCbmE2zwx92oXTg5RYCS/K4RVL0Evf
         RC5Hugi5TSDz396V/nepCQN2gJBN+Mz1NcuvyC4Ni5kLNCpPzAs4E6xSJ9vI9mBW4iit
         Klyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PjI0ZHVTu6WYpNrElbpPf/NUK0zpmDF6Y7VvKGBI5UM=;
        b=UBpiYRta+qCTRjI916qBbRBxVQCnlJW0K0HFltJu0562Y+qcqXL5LNkqdnc2DUWPQZ
         HUkTyPKDsEizD60Wr4TUWouglO3ZvG1uKZiex4F72qX6MUf9ndqgUphZC8eK8YtlesaH
         izBRF89q6+zqRcoZF+47V9QiaVeXjVenFegBVYlMxSSW0/nlCzMXoHzc5QnZmvQs3/58
         hWVmzEfTSyoGzGNCGjkxA7bCLDepB6GLMhtkp/bahWJErUj1rfwBd0hfffIl0xc7tkYs
         omVp6EhXBW2ZPAW10W16jglFw9flZPFsmpRZdTt6azNFwYw6vkPxNnAjJ02kqa7z/JQC
         VsIw==
X-Gm-Message-State: AA+aEWamqA4TXcgA+vPo197Lw2IU1n/3Qs6HfeYGw1wZ0O/30TbT58cb
        w8H63ybqre7+8MCS6oz3r+h1Lof1lLHpQKG4wj4=
X-Google-Smtp-Source: ALg8bN7m0oEw5Xi5Ka7uGCpm4lH/npv5HjeKZPpdWe6nNpUGCG7CZPADXhAy7pFk2GcILs72a4tW08STn1eHzThOJ4E=
X-Received: by 2002:a2e:5356:: with SMTP id t22-v6mr16104063ljd.26.1546037543450;
 Fri, 28 Dec 2018 14:52:23 -0800 (PST)
MIME-Version: 1.0
References: <20181228154609.14846-1-pawel.mikolaj.chmiel@gmail.com>
 <20181228154609.14846-6-pawel.mikolaj.chmiel@gmail.com> <20181228224707.GA7218@bogus>
In-Reply-To: <20181228224707.GA7218@bogus>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Fri, 28 Dec 2018 14:52:12 -0800
Message-ID: <CAKdAkRQ6iO5bSUkSuPOUXMy46W1kENqg3ev=i+75459wfWAhfw@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] Input: dt-bindings: tm2-touchkey: Document new
 keycodes property
To:     Rob Herring <robh@kernel.org>
Cc:     =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, xc-racer2@live.ca,
        Simon Shields <simon@lineageos.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 2:47 PM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, 28 Dec 2018 16:46:07 +0100, =3D?UTF-8?q?Pawe=3DC5=3D82=3D20Chmiel=
?=3D wrote:
> > From: Jonathan Bakker <xc-racer2@live.ca>
> >
> > Document new optional property for setting custom keycodes.
> >
> > Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> > Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
> > ---
> > Changes from v1:
> >   - Because key codes could be bigger than 255, use ints for keycodes
> > ---
> >  .../devicetree/bindings/input/cypress,tm2-touchkey.txt        | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
>
> Reviewed-by: Rob Herring <robh@kernel.org>

Shouldn't this be "linux,keycodes" though?

Thanks.

--=20
Dmitry
