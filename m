Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95FBC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 14:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FD4A21582
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 14:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tjader-xyz.20150623.gappssmtp.com header.i=@tjader-xyz.20150623.gappssmtp.com header.b="rLoloOfi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FD4A21582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tjader.xyz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388451AbeKPAyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 19:54:25 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44794 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388379AbeKPAyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 19:54:25 -0500
Received: by mail-oi1-f193.google.com with SMTP id p82-v6so16891479oih.11
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 06:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tjader-xyz.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZPJGai7fwi6+Zi/4GIV7DgsJ/cloY+TjHG0xsfyN+FA=;
        b=rLoloOfigGFs9WVjZA8NevOkSgm9QxJfQ5pf4awwVrvQUsbIeYI5h5rIDVdFl/GDyn
         oHREawVFKOaNBPHaCB1BztmlPI66LuRtLCbnJdQ2785c/Y8T8uuSpikViEE4hIu9L4x4
         xjuaKo4IN1WIGSQk0OkDLcuor9lh8ZBiIqRAqgf+B/U1g+NLP1TS2FrrM0lGmUEwZFnE
         V7vFl9VO4dFGGCfmaOWis1oMbcdWtHpkBvWFJv3jAPxdl7j6ktSp+RS1XSIW+7wTQhsJ
         j+YbVKjubj/3zvJ5eKSyrgacU3atz1PCbGeDdBFT6WTFoL4Hstw8UquvTDUZTHqo8pt2
         ggeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZPJGai7fwi6+Zi/4GIV7DgsJ/cloY+TjHG0xsfyN+FA=;
        b=fH5H/TmRUXAuJUzJfmozGoW4I/H+0YFoXBNiMqE4Q4ZkKc0qzRDUcJ1a3S0sZDKgM5
         Zw6MnzS5nyjLjvWhOVEblu4RUK/qJrTuAphAV2cDvDl54xSbs314LF+gj9k1pNExexz0
         0CMzgiwzzc3VeSYsDdS8ddoubCoGVN1TcAb0RFvylI5uqSq8Dy7bod9CVIF1mFbWD33a
         3aJgHqq7nyX/P1V7HIoipUm+PsfmK8bR2kiyQv0s9ZRD6oxGxmqowUvxDruiMPrzcvBy
         SCZSnZV5/Uc6WIDX2KWobbIPjm1hBvVwacaf7xj9pZjsFNDh4Bcj9QKIHXmEZVDv4IJh
         co1g==
X-Gm-Message-State: AGRZ1gLNZSXyXrUuFisfYWEFkR7i/GIV5esuIWWQ4dFP4lBf1l56+2Ji
        4Rqg+p5BdJrhyQUo3Vh987AqMi+yZ2d2z6RGNgjZ8w==
X-Google-Smtp-Source: AJdET5f+f/d18AaGOAdX1MGql+Hfw8gs5sOj4Q8nPtCag6M1xtJ+YT6HIUEuja2Hnk97g4CWBhXDIhbAsM8LCSuhLJ0=
X-Received: by 2002:aca:440b:: with SMTP id r11-v6mr3568456oia.3.1542293177661;
 Thu, 15 Nov 2018 06:46:17 -0800 (PST)
MIME-Version: 1.0
References: <20180921142811.h5jraemk565alh3i@flea> <CAG7TQgE_KU_cK_4E+NG8Qcw-QB2=C6YoqBYR2svmWxywFyySCw@mail.gmail.com>
 <20180925090139.qbu6tqav5oth7zkw@flea> <CAG7TQgFTsR4pf4jAcWMFoOmiP7AXYqjts60RP2kuJGU44AcQJQ@mail.gmail.com>
 <20180927081711.llmwnvpu73loe5iv@flea> <CAG7TQgGMkvBnNE_WEth8gscKxN3qN8a44mNMWz3QP-2+JKfOzg@mail.gmail.com>
 <20180929154754.abz3byvrufvnf4dq@flea> <CAG7TQgGS7DkLpNVYqfCD-9vMZkeY6r+L-5oXKWef3x-OVbqjtw@mail.gmail.com>
 <20181002131312.soqwybsohdifvso3@flea> <CAG7TQgHWCJTaM+pFYFq0_8nWg7sA+d0huqu96sjhqZfeHwqbGQ@mail.gmail.com>
 <20181005154844.234g5k3fw5txqxsl@flea>
In-Reply-To: <20181005154844.234g5k3fw5txqxsl@flea>
From:   =?UTF-8?Q?Rodrigo_Exterck=C3=B6tter_Tj=C3=A4der?= 
        <rodrigo@tjader.xyz>
Date:   Thu, 15 Nov 2018 12:46:06 -0200
Message-ID: <CAG7TQgGO-CjPE6SAUa53GYhMr5-yVe0YaAL3UV15E+f9kKZVwA@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: allwinner: Olimex A64-OLinuXino: enable eMMC.
To:     maxime.ripard@bootlin.com
Cc:     wens@csie.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 5, 2018 at 12:48 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > What about the idea of keeping the current dt for the most featureful
> > variant and creating new dts for the other two?
> >
> > That would make it so that no one's device stops working and would
> > have mailine support for all three devices.
>
> IIRC that has been the first introduced version, so that would make
> sense. Chen-Yu, any opinion?
>
> > Also, the current device tree doesn't represent any existing device:
> > it has wifi on but no emmc. That variation does not exist.
>
> Most of our device tree are far from complete, so you shouldn't treat
> them as such.

So, any agreement on what is to be done about the devices tree for the
A64-OLinuXino devices?

In my opinion the best path would be keeping the current dt for the
most featureful variant and creating new dts for the other two.
