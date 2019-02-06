Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3EC1C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4C0A218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="oJLfYiy/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730353AbfBFOrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 09:47:21 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42465 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728049AbfBFOrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 09:47:20 -0500
Received: by mail-wr1-f65.google.com with SMTP id q18so7825326wrx.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 06:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=USJ6HCrc5EIcZWFDnBygF5kGUHF6deOK++9P1ruU+Ps=;
        b=oJLfYiy/9mzV7s7DQTqOdkKT8EMaIMk4xE8pxoTOnRdJj9TGoqsDh375cVi/GsNQtl
         PRVlEWqirX2zpe9gOl8HHnNi0aaiCcvmgzfr+yowE+2nJcqMmUsslajinzept3aVmEOF
         TAhZbhIWq3n734hFM4ASJYyiYLvoL4GnklsrXGdQd+FNb7KfKI3rnw6M96ghfhApLtpB
         mX8Lt4UPij2qBZJC808tKcFeGKJQMH7rjQJ6dzhaNSQfmFEZm8SDgq7O7+lZUcate3nV
         UBVMDhYPPqCGKQFGzvNK4hc/Jhy7pLB3DxUIj/ombl3sj/WlC3a64s94zK7isErDicLC
         NyjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=USJ6HCrc5EIcZWFDnBygF5kGUHF6deOK++9P1ruU+Ps=;
        b=nTKDDzLXow4fTsJsGU8fRinXrmu5n2QtM62MDos19i60eh/W/PDqqyP9YHQyMRdCpX
         +vbtKjDeadbLH2qU6U7QHpl6zDpZKhPTmZm49+Xhca8uxxKIj0jazJk86VyJvyCM4kh4
         hO03vjnV+bcQjttDyOEyGVM6agyH2I/hL7CBMoS12VPMWbxEdPZ7x4nU/hfGrW6QsR2h
         8Ui8IgLU110untjyEovyXjW+oSUOH7jbfA7HsGyKzbKU2eQM+UOhhmKs2g1EOUCG0C66
         0uZ4sLYIymhzdxx3tvKgBa9n/N8jHySd3qHIHa8HNIo+Y+1ikxG0jjwNg5rH2rkOQezM
         tKKg==
X-Gm-Message-State: AHQUAuZ2q+EfwedJKH53ZHFogsCJn8JTnBuxWSFRcoFvFNW5NM92/LHF
        9Qc3+DVpQwMsQ8At7oUw/iAuvsDtvjNiD55T/Oi5cQ==
X-Google-Smtp-Source: AHgI3IYnxX5B4n+jBu/GdePDDrA4yCWmxInyN3TuQKCZ+OF15V+6raL6XSjiPgogw63thDSl/uiWexo6FEZu7nsH/so=
X-Received: by 2002:adf:ed11:: with SMTP id a17mr852231wro.283.1549464438982;
 Wed, 06 Feb 2019 06:47:18 -0800 (PST)
MIME-Version: 1.0
References: <20190128140219.4414-1-axel.lin@ingics.com> <CAGb2v67UV51oaDXgF2ocTSYJVNhZFPf_bmDtqLDApA_YB-oqWA@mail.gmail.com>
In-Reply-To: <CAGb2v67UV51oaDXgF2ocTSYJVNhZFPf_bmDtqLDApA_YB-oqWA@mail.gmail.com>
From:   Axel Lin <axel.lin@ingics.com>
Date:   Wed, 6 Feb 2019 22:47:07 +0800
Message-ID: <CAFRkauB584T9CqmvwRO3eYhL+N4Xi38Ti6b7aPpCGk-L_-OcUA@mail.gmail.com>
Subject: Re: [PATCH] regulator: axp20x: Fix incorrect vsel_mask settings
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chen-Yu Tsai <wens@csie.org> =E6=96=BC 2019=E5=B9=B42=E6=9C=886=E6=97=A5 =
=E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=886:44=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Mon, Jan 28, 2019 at 10:02 PM Axel Lin <axel.lin@ingics.com> wrote:
> >
> > Fix copy-paste mistake while converting to use defines for masks.
> >
> > Fixes: db4a555f7c4cf ("regulator: axp20x: use defines for masks")
> > Signed-off-by: Axel Lin <axel.lin@ingics.com>
>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
>
> Though I believe the latter three have already been fixed by
>
>     https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git=
/commit/?h=3Dfor-5.0&id=3D16c8a595740035c4a7ede608a60b4a59f67b76e6
>
> Could you respin this patch on top of that commit?

This is similar fix but fixes different places.
BTW, Mark already applied both patches.

Regards,
Axel
