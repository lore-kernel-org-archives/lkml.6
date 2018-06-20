Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B882EC43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 20:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69F9620874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 20:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="stvI8xy1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69F9620874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933250AbeFTUbz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 16:31:55 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:39717 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932570AbeFTUbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 16:31:53 -0400
Received: by mail-ot0-f195.google.com with SMTP id l15-v6so1000988oth.6;
        Wed, 20 Jun 2018 13:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fgNjJLxxbBgBdPHlvm5HciOpnqYKMNgN6R6+l17rBoI=;
        b=stvI8xy1+wylhkVX2iJD+4tjnxfm/mZzUO7uUhSDJJ4CSy6+g20QySGjxcXw4T6mPd
         zokYY1a+JGFL9yYmq7j2aU5cpCd4EmJ9Gkr4KkUliVsvVDQPsbGFTpBSswJCz8TTcN4W
         HzGBGW0yH+0NQj9Kb1tIHvhCQax5Sz3cT43QN75xikQGRm4+VEqFEjteeQ6W+99Pwra0
         Y0nbvByNjct4x+p/pA/1Vr/KQjS7poe9zKu8JdmNx1nwLMThsz3JQXrn5Me/Ku0qtc4j
         7O3fcSutnRawIHTGEBCJgqinT0Me31K3uKP2GXIKSUSdPQ+lyb5/0qEolX554a9vVN0u
         apdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fgNjJLxxbBgBdPHlvm5HciOpnqYKMNgN6R6+l17rBoI=;
        b=irEbk0o4xm/WppO6WQ5amShr6izAuXvH/l3J4rMkdPFaGXizwaJW3oqLHF7MOsHRta
         ACN4wJPdXie1i/igavZx7didD0im1M2jLKp6SKOVua976C1DTI9VTd50OEMRpf0E5zl3
         /Q2WevF5UjHsLuAbl4TGsgAm8ZKsK2SZ2Mx122DfaRoQ3fxiJbWi/1Yoc+IR8nksF048
         6CxJgNzSSiTSaQzlF4FoM6viTu5CcDHveFifutT+aZ9ddj7sJUKSRfLbJVawTOHyVRIk
         pWszhZtSOXRfNhck1lj//d66hga1K0wSAbKpuZTXhJJ4lqMyhO+8rAadGTAUYOBmi01f
         6rfg==
X-Gm-Message-State: APt69E0wCcOqw7UOSCLuhJeuCuFIl8vjfwfx7kMLZlyXcLTQ0jKLRQw5
        WdA9uEC09bxr9nGCzTNCVlEPL6yvlMHG+YGSZBQ=
X-Google-Smtp-Source: ADUXVKKMIkr+lAApmXX+9X2tgQhgDah0dMcQuH3A7nq2pIeKEr8ZyToZL+BPzn1zCnFrEj5qLYIKg1deuslAJQDJetI=
X-Received: by 2002:a9d:1813:: with SMTP id b19-v6mr388142ote.128.1529526712683;
 Wed, 20 Jun 2018 13:31:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1049:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 13:31:52
 -0700 (PDT)
In-Reply-To: <20180620202045.27965-1-nick@shmanahar.org>
References: <20180620194239.2730-1-nick@shmanahar.org> <20180620202045.27965-1-nick@shmanahar.org>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 20 Jun 2018 17:31:52 -0300
Message-ID: <CAOMZO5BTMRJmrjM7X3-7Qi1wuciOnLZhAUuWN27Dtoc0cZXVSA@mail.gmail.com>
Subject: Re: [PATCH v3] ARM: dts: imx51-zii-rdu1: fix touchscreen pinctrl
To:     Nick Dyer <nick@shmanahar.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 5:20 PM, Nick Dyer <nick@shmanahar.org> wrote:
> The pinctrl settings were incorrect for the touchscreen interrupt line, causing
> an interrupt storm. This change has been tested with both the atmel_mxt_ts and
> RMI4 drivers on the RDU1 units.
>
> The value 0x4 comes from the value of register IOMUXC_SW_PAD_CTL_PAD_CSI1_D8
> from the old vendor kernel.
>
> Signed-off-by: Nick Dyer <nick@shmanahar.org>
> Fixes: ceef0396f367 ("ARM: dts: imx: add ZII RDU1 board")
> Cc: <stable@vger.kernel.org> # 4.15+

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
