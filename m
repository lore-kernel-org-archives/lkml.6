Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E6DC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 14:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62F27206B6
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 14:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECYWKAqa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfADOpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 09:45:18 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41141 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbfADOpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 09:45:18 -0500
Received: by mail-lf1-f68.google.com with SMTP id c16so25567172lfj.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 06:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0dI5rEhndhu+K3+lyXwpjPYzolhLNRqDoEHNxA8UdDs=;
        b=ECYWKAqaEICoxwvH5x8/H3NJ+e/XglteFUkYLwe8fT0dAfA+fvgcTKe/jsy6c9bwjn
         /niEN9AcTcAUatr7cCz3w/bjj6Pacysu1hoDo/K4OFWqfnkVf1TVnUZZy2G8fjt8Ptxp
         3MvOXnl1ts61JHQb3RcAMg+WHDsVu1oa9HxjC2N90yTAyc+9V/4eophNtajS40j+hAYH
         IGy081O5rjrbTujUuoc2XgLmzXq1nKRL9S+3DMQTNr+sq4IVfzoxIWKi4u4zzEd2kMd6
         F2ZJfjUHiFOPXlFYnw7EPJwSjWYDQvzBdORzTzZ9R1Y7Sbqhfrg6UYQ7BBmwPyvaVnz5
         D7wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0dI5rEhndhu+K3+lyXwpjPYzolhLNRqDoEHNxA8UdDs=;
        b=LPX4COsSjsXse1nT/DXX285tYz76hD+OdoGRem08o6JkXELr/PR+jP/SR23DrB2/1+
         AchUkJNu4/VayAoPrRyNkE5KxoGef/2ammypb5bbIFOi1fGY5WJSes6a2O4zUyTlq+EG
         sCaCXNAmvew+tzVqUuSxJbpLmZw43MfzRsi2JDQl+4RWyKXavyGgaQF6ulgqQC4/3S2T
         dT00ORU+GT1TsaJCd0vCfA1RAWmdymO+x4QCRKz8K5avSSAk1ua1b1ABNXAGoCvmZ2AM
         nG0WyRqWRrPUJ8gSa5K1AUaqeEoerziRJbWjSSzIrbud3csA/AbGI/n03qPV7lXOi+aN
         4Lvw==
X-Gm-Message-State: AA+aEWahniJXB6/rYVd0KcLZOZwSSBXPZ2F8rVfLI9xp4MXYVQgDhlMn
        /VBu3/e0DsRtwxKYX4PL50GJCzeDt3unv4XCIBg=
X-Google-Smtp-Source: AFSGD/XeoOKbTQsc41N/U/vEV37rlGlfDb/O2vHP+H6TJzFFI01H1E7I/vLVswy+zZXAOroIT0rzRziC1qbWS31GSvc=
X-Received: by 2002:a19:690d:: with SMTP id e13mr25670432lfc.84.1546613115910;
 Fri, 04 Jan 2019 06:45:15 -0800 (PST)
MIME-Version: 1.0
References: <74950d502cd8bd3578d8ac702e2afaa3@memeware.net>
In-Reply-To: <74950d502cd8bd3578d8ac702e2afaa3@memeware.net>
From:   Ivan Ivanov <qmastery16@gmail.com>
Date:   Fri, 4 Jan 2019 17:43:41 +0300
Message-ID: <CAAaskFDsBAN58wPyhpk1O=434enXP_59SbNpeddnPHc0HROOMQ@mail.gmail.com>
Subject: Re: (Audio/Video): The Truth about Linux GPLv2 and license recission (revocation).
To:     vsnsdualce@memeware.net
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        gentoo-user@lists.gentoo.org, ubuntu-users@lists.ubuntu.com,
        debian-user@lists.debian.org, freebsd-women@freebsd.org,
        freebsd-chat@freebsd.org, misc@openbsd.org, esr@thyrsus.com,
        rms@gnu.org, bruce@perens.com, bkuhn@sfconservancy.org,
        editor@lwn.net, labbott@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        moglen@columbia.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sadly your informative videos deleted (by NSA?), could you please reupload?
This could be useful for removing your source code if you disagree
with Cock of Conduct

=D0=BF=D1=82, 4 =D1=8F=D0=BD=D0=B2. 2019 =D0=B3. =D0=B2 16:04, <vsnsdualce@=
memeware.net>:
>
> Information regarding the rights of the linux programmers, regarding
> rescission (revocation) of their granted license to use their code.
>
> Video:
> http://www.liveleak.com/view?t=3D9O5vz_1546606404
>
> ( Audio Only: )
> (Part1: http://www.liveleak.com/view?t=3Ds3Sr9_1546605652  )
> (Part2: http://www.liveleak.com/view?t=3DaOkfS_1546605889  )
>
