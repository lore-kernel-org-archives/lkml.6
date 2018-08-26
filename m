Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C58C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 23:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E4122172A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 23:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="t8++MlW0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E4122172A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbeH0DVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 23:21:20 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35455 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbeH0DVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 23:21:20 -0400
Received: by mail-lf1-f65.google.com with SMTP id q13-v6so10548666lfc.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 16:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IBERYVJISYXKDC5QjFTVObEfHlxjwGG2S9oomeXP+Oo=;
        b=t8++MlW0RFTDzqjZlGcMN1/PYfq+k6w4pY9vkfbyBZdCgaWKpEkPmILoYf5EZ4fcLm
         02vsKzNEGQACHqXMhCTdYeMcLscbXwEJP8zGURQt3MyijGEhT/ECVj3uRupsqo+tkbKZ
         p58SeMcC6buUicnDxvvfgVJkyQ9tuV4AoL46HEvTQ+OYiByOYvk6ddHeM8ryyPB6eKWn
         VleyzI4rXgQ1MREMMJYkoK8uvO2qiPsjc+9lEU0roJgoulh+64A9rb9tEzdtvD9SJZp3
         ThGmThTQyDw9v6shQ6T7gl/mUm9GyKLxuayH227B8IYIP6MF90hv9byoDUr2RXXbhm3i
         r+TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IBERYVJISYXKDC5QjFTVObEfHlxjwGG2S9oomeXP+Oo=;
        b=cfYCkcN6YJeDDJqXa3oh0lLP1fUPeWU2qxWwyjYc+wGztnAS1Cy14lf6oA5izsNVPK
         AlBq/RO8lluwuFrBQgdPiMgsvXyFPpd4TxfpVz9dPbAbEgYfMDswz381Ra21R4+PHQtV
         sLGigbc9nbNW4hfpNIKVtQc2xUDESeRUOh/mCZlHw6b6wyEA67lgFW2kAiq0N2rhxh2q
         oXxyfXzZS/pNS9IUb3cOqpnEPw2A760TiL2P6d4iO/NbsVsaJPWstvlhIaf4MixTdnWo
         DHMEiO2FtFKkqX+sYV8oefsB1sQL+VPU0oM/cikEk5B53/dGZcI14kO6X6sSnZbs1jZi
         GZxQ==
X-Gm-Message-State: APzg51AOQlxF8rK9mgX4XXa7sxDe8Y5nWE+FJAYW0e4fRlWvTXlmE2rt
        AePxfvLXqKZJ821nYIyz6529ufvA3HWkVIATzx2Zqg==
X-Google-Smtp-Source: ANB0VdbCUczJxwZM70paMREOfdhWd2eBuBPQEtNepTJ8HKElA4PZUmYP3CAON5kFGTS8Jzj4m8wlEd5rJS7bWu54VlA=
X-Received: by 2002:a19:2bce:: with SMTP id r197-v6mr6451744lfr.37.1535326633027;
 Sun, 26 Aug 2018 16:37:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:dd41:0:0:0:0:0 with HTTP; Sun, 26 Aug 2018 16:37:11
 -0700 (PDT)
X-Originating-IP: [99.152.116.91]
In-Reply-To: <20180824115545.GA4989@jax.lan>
References: <20180824115545.GA4989@jax.lan>
From:   Olof Johansson <olof@lixom.net>
Date:   Sun, 26 Aug 2018 16:37:11 -0700
Message-ID: <CAOesGMikN1eAzpLMSgY+PwQ0cdgA_Vp9nU+P8BHcacLdh52-iA@mail.gmail.com>
Subject: Re: [GIT PULL] tee subsystem for v4.20
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     arm-soc <arm@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 4:55 AM, Jens Wiklander
<jens.wiklander@linaro.org> wrote:
> Hello arm-soc maintainers,
>
> Please pull these tee driver enhancements. There's one small fix for the
> OP-TEE driver to take DT status into account. There's also a patch
> providing a kernel only tee client interface that can be used by other
> drivers etc. Currently there's no users of this interface in the kernel
> but there seems to be some work in the pipe as some has tested it with
> out of tree patches.
>
> Thanks,
> Jens
>
> The following changes since commit 94710cac0ef4ee177a63b5227664b38c95bbf703:
>
>   Linux 4.18 (2018-08-12 13:41:04 -0700)
>
> are available in the Git repository at:
>
>   git://git.linaro.org/people/jens.wiklander/linux-tee.git tags/tee-drv-for-4.20
>
> for you to fetch changes up to 25559c22cef879c5cf7119540bfe21fb379d29f3:
>
>   tee: add kernel internal client interface (2018-08-24 11:57:37 +0200)

Merged into next/drivers. Thanks!


-Olof
