Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36DCC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B91526C56
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="U3aDOUE/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bcuacwxV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B91526C56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932351AbeFZSPV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 14:15:21 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:33097 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752989AbeFZSPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 14:15:18 -0400
Received: by mail-vk0-f65.google.com with SMTP id f200-v6so3265105vke.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 11:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=hNDLuRpjoOinG+RYBwJ2iqM8kFqSLM5NEbxWxbbbFiE=;
        b=U3aDOUE/khrVut+d0/POAxvVRzxKjF6nJVlrHUr7lhnJplW2IZB8hJmISFQASizXI3
         WXviwpU4UNvP42uX87CTADLX6bU/9iD73jqZOsNhlwO9qqbfGZF9KWq50bxevEb2a84I
         ocRO78K1OzfTRT7r/NNw1z0cn/aBoYjFJ0hH9/GyS7WAI7/bxYzovVWnVJ/qtf4WAtRh
         ea8LSdXH5JDeoxZ02fHAj9X+EIUrtkV0Q3W2ZeVge2Na+zsKc5UZ2EAMhovRXc1q5C0W
         ABgiLl0184lpNIX8VbcYekwFt/mKvq+dY23J4oB5jkdj11UGVzpGiWJqS7XH5+dgKpYE
         Q4ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=hNDLuRpjoOinG+RYBwJ2iqM8kFqSLM5NEbxWxbbbFiE=;
        b=bcuacwxVtRsTWW8dPyqJmH8hp/b0tArWJoX8LAqTFJEjwy8dN1hpr4GPper1H9mAH+
         J9CYGoaOjd8ZKtnaCMsb2H8X9znLkkgstp6kSD5aGciu3BA9MIiIDKkhfpthxHWzJ0WG
         xOkRmuVPKd0XqWjC/AJPt4VzqSHdsCJgx0/OU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=hNDLuRpjoOinG+RYBwJ2iqM8kFqSLM5NEbxWxbbbFiE=;
        b=PlOksa+F3Gtkr1gzmG/xQ2IyrnfgM8JIHScZp7H3wG9z8xlid4DN3J/itPcc6korsD
         bgmecAYLZmxTBu2YYPEES2+SQ78a7RIKBMvMNiXuR2NJUxdw/CzRFeykbrt8+EIlM/Er
         sBTxmgpW4Xh2WU9f0JY28GZpuqDqAmY9lSap4GdlTAhHgBQzszSqKUt1RHyC73rY65q3
         TaoxqyWfUsBoKOf4RfLWRtWSRUzcgmYnk20rk18Z0Vxw1iD+KGxtPp5exLB83gijaOlA
         Ny1x6/rbWUs1JSf/g4KIV5tDK9Lp/if0QjZgMpnM/HXBqQQuEdRS7KoUpr+Meh0yW0YL
         b9ng==
X-Gm-Message-State: APt69E1ra/Cpw/2LCvP37FJ5pbItPIGsGUTSpVZZiN3XoWP9FgDiC+8H
        oBaxANdGAXOh170v76uWbz2XYombwIz7X9zc69+W6w==
X-Google-Smtp-Source: AAOMgpf1Pcf5cdIGRHy3cb7R30dvN2vracJFipEmLRzr5Lw0KCkYLOWZc0/pREzzBt5LenuYedWX+oWzFRfOVh5ekak=
X-Received: by 2002:a1f:7c4:: with SMTP id 187-v6mr1645801vkh.60.1530036916078;
 Tue, 26 Jun 2018 11:15:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:9495:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 11:15:14
 -0700 (PDT)
In-Reply-To: <20180626150203.GG1779@sirena.org.uk>
References: <cover.1529712888.git.collinsd@codeaurora.org> <35c4ea70cdf5caba560fb6f40e866ee8bc456d93.1529712888.git.collinsd@codeaurora.org>
 <CAD=FV=XVEEPgjBXxR+-46RgxLOq63Xvq-jtruoaCxccmMoKUuA@mail.gmail.com>
 <20180626120733.GD1779@sirena.org.uk> <CAD=FV=X1E8Cz=L93G-zJwhM0R=N3YuBBhkvCnLvWuxMU9KJkTw@mail.gmail.com>
 <20180626150203.GG1779@sirena.org.uk>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 26 Jun 2018 11:15:14 -0700
X-Google-Sender-Auth: dfZHZGLctuH0wP4BjV2FR8VQTEI
Message-ID: <CAD=FV=WC_XWRk-6OELOFFWGnhRq1VeoiiveqXLSy+xqsVb22pA@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] regulator: add QCOM RPMh regulator driver
To:     Mark Brown <broonie@kernel.org>
Cc:     David Collins <collinsd@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jun 26, 2018 at 8:02 AM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Jun 26, 2018 at 08:00:29AM -0700, Doug Anderson wrote:
>> On Tue, Jun 26, 2018 at 5:07 AM, Mark Brown <broonie@kernel.org> wrote:
>
>> > Please do not submit new versions of already applied patches, please
>> > submit incremental updates to the existing code.  Modifying existing
>> > commits creates problems for other users building on top of those
>> > commits so it's best practice to only change pubished git commits if
>> > absolutely essential.
>
>> Sorry, wasn't suggesting making any changes to those two patches, just
>> was noting the dependency.  ...but, as you said, the two dependent
>> patches have already landed and I just didn't notice.  :(  Sorry for
>> the noise.
>
> Ah, so there's no revisions that need merging?  That's great.

Right.  So all that's left to do is decide if ${SUBJECT} patch is
ready to land and how to land it.  Andy has landed RPMh into his
for-next tree.  You can see it at
<https://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git/log/?h=for-next>.
I think he's still planning on re-shuffling his tree a bit.  When he
does this, do you need him to put the RPMh patches somewhere you can
merge into your tree?

Thanks!

-Doug
