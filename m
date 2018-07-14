Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1012AECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 14:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A578320896
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 14:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="U+e/kh/0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A578320896
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbeGNOuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 10:50:07 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36076 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbeGNOuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 10:50:07 -0400
Received: by mail-oi0-f67.google.com with SMTP id r16-v6so67280650oie.3;
        Sat, 14 Jul 2018 07:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=K71bv3tEkrjb6T6L4YoGd8PgOOTWL76rKwt8JJdM6GU=;
        b=U+e/kh/0At83BTyYjMTLnr29ysFkY3TQ8rSQervcKZU9jtI8R5OCy4Xd/Ktb+ySnnV
         HVMTDCamxdpr88WLkCAdkSEn3Gr7esRmjbQcQcYKNnW4fnDj+N/mURBfqBo1Gv7wDiT2
         3Bj+iYPSfdvDFZKJ5ccSFtZo3Xu8kiSm4EDyeAgC8uyFWnrakukscywGCKSw1w9ywA/e
         uuW2qJQ3inhhZ6FKnPmfucvPh0gyFsb5GFl303mouyR8d1ErJX4zS7g0IOQ/bXwQ34de
         c5WkF/z5gMXeBXW7XZMa3r7gecEvfo30pM9R5DqCR6we+NAUkU04s1d9uMHBktwjpf1/
         a2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=K71bv3tEkrjb6T6L4YoGd8PgOOTWL76rKwt8JJdM6GU=;
        b=DcUX8Sp4BK9XUjVZpMv2RJPrstgoGtuu8T+JHmBQWBkuNMvLjBSMq4z/8vqt8MO/dk
         CpWuB0TclH8CyHnMqSNod/ScK3ETOys+4o2o8pmxyygwl9+0bYD2LTY8APjtcOZueU2c
         pkWiit/IMpKw1KAGMHyROPvY1R18JtSTFrnsAQ23ahq5WrZzxRqCalIhLYMn7gWmxbGc
         th0COKvJNkFYIwW8wynZ2VNDiykeqWT/KRA4o7J4Wt6wGWPDRWY7ovpD/3gaeRmek01o
         9BFRVWbrwDKlri48uB0AJj5r9ltWfPXYDLQ2O9zMn8qU0PLmnyDjWyaPRFotStPeArIs
         r+9Q==
X-Gm-Message-State: AOUpUlH2wSL4mACWQ3DSC7dMc8NuC54NVPADxn9EBSPGYhaDyOJiEM8j
        nMhRKFgKaoyBZggfpTr46F+7oyN+x+03cf3e39k=
X-Google-Smtp-Source: AAOMgpdxTNJlACw4zMPiIKLtOp5zwKUSrCFz+bwh/EPTpg7kreFgZzeV+3FquWACU/P4AFzyEvzi5zA0MwXyvURzx5I=
X-Received: by 2002:aca:b685:: with SMTP id g127-v6mr11624894oif.263.1531578651298;
 Sat, 14 Jul 2018 07:30:51 -0700 (PDT)
MIME-Version: 1.0
References: <1531134767-29927-1-git-send-email-jian.hu@amlogic.com>
 <1531134767-29927-2-git-send-email-jian.hu@amlogic.com> <1531214976.2708.52.camel@baylibre.com>
 <f6f387ff-271b-9b4b-5b6e-072b4e56d840@amlogic.com>
In-Reply-To: <f6f387ff-271b-9b4b-5b6e-072b4e56d840@amlogic.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 14 Jul 2018 16:30:40 +0200
Message-ID: <CAFBinCDW_Z-Ku+x8YsaM0CuTP6KD4PQ2uf94m3DZn5kCmvK9GA@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: clk: g12a: New binding for Meson-G12A SoC
To:     jian.hu@amlogic.com
Cc:     jbrunet@baylibre.com, Neil Armstrong <narmstrong@baylibre.com>,
        qianggui.song@amlogic.com, devicetree@vger.kernel.org,
        sboyd@kernel.org, khilman@baylibre.com, mturquette@baylibre.com,
        yixun.lan@amlogic.com, linux-kernel@vger.kernel.org,
        bo.yang@amlogic.com, qiufang.dai@amlogic.com,
        linux-arm-kernel@lists.infradead.org, carlo@caione.org,
        linux-amlogic@lists.infradead.org, sunny.luo@amlogic.com,
        linux-clk@vger.kernel.org, xingyu.chen@amlogic.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 3:06 PM Jian Hu <jian.hu@amlogic.com> wrote:
>
>
>
> On 2018/7/10 17:29, Jerome Brunet wrote:
> > On Mon, 2018-07-09 at 19:12 +0800, Jian Hu wrote:
> >> Add new binding for Meson-G12A SoC Everything-Else part
> >
> > nitpick: I would prefer if the words 'clock' and 'controller' was somew=
here in
> > the description.
> >
> > Maybe "add new clock controller compatible for the EE domain of the g12=
a SoC" ?
>
> Patch 1 and 2 have squashed, the commit message focuse which one=EF=BC=9F
I would use the information from both commit messages (for example you
could use the what Jerome already suggested and extend it with "and
add a header file which contains preprocessor macros to identify the
clocks provided by this clock controller")


Regards
Martin
