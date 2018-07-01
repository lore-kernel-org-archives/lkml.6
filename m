Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45D1C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 23:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D28225799
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 23:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vLR7hYJN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D28225799
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752695AbeGAXcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 19:32:53 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:43422 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752593AbeGAXcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 19:32:50 -0400
Received: by mail-oi0-f65.google.com with SMTP id 8-v6so8552054oin.10;
        Sun, 01 Jul 2018 16:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nCOfVKKgojTUC54CxnDeXd5l5LufLFtPqKQAW8N2PtQ=;
        b=vLR7hYJNq1QwowlhtwYP4GB/SFu7oAdKdUAKVfRRWCb2xcGjZW1cfPwOfOGWP1VGOm
         M9oqhatLg0gHQ1g++GMqQDQwWSUtkD9b6I0vS2Hgf5Kgdkl6Fa/prLtzBpGNaysm9SzR
         WDzv6Pk8a2ovAOTuJNqCl54DtQWl6dgZrJSJ9JddHDIhLe0m7FSVK2s7WNzXO5JUeKn7
         MaqY6UB3anxlP+G730Hh7rNriiWwl7jP9cIMDzL72FXaST/gUJ89yzSqz4se3EBg2DEe
         jN8nJm2RdGlkiv/RSXig9nha0N3LjjqdD/KuuAEq0WpMoGzBkOg7iSYtAQeHz8WSZx31
         Cj7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nCOfVKKgojTUC54CxnDeXd5l5LufLFtPqKQAW8N2PtQ=;
        b=NzEfMyuQNwmEMNfq0O4p2NPxRWVpaRc8HooC7uzLkPifIS/3oQJ0dTau/myen9pbPM
         NfIDTVbXrC4mM7whkvbjGL1fHfczampWAHQWtbBw2CLN8dYZj1F80q8nlbimr7KX3/yE
         AHKxdyPMFa5Gv5Jr3emJNxjMX7A3MyByggMCp8/RoYzVEaV+N1EepUrgS0mbCjO6PKgc
         26TmtID6162m4XWzjt+QenN6ygOda9Q0oL7bs3EUx05Pc4vQgejl1dMakRolAVsyQkWs
         +jJYRyyiUZyeMrakZAxEeaxfQ5wJTIlSI+37fEVFmYTRqXoVqTBI3ccDomwSiW9YBUq2
         orHQ==
X-Gm-Message-State: APt69E1yNLZ5sYHAUxNwSKxgGPHXtj4hIioS0rG0d77tsDLq/6+/1ZgD
        eqg0G4PmQdmIvWj9kdqe8kj7yKzimgovRnmHFZg=
X-Google-Smtp-Source: AAOMgpdIPhm6QDooPTGrQWbS5bNYxUdE6Irhzb2PXw/WbkSXgteOqmvU6tiEbG5jXWNtVpYeNU5ELs2G33AwwylkF/c=
X-Received: by 2002:aca:400b:: with SMTP id n11-v6mr14123191oia.44.1530487970168;
 Sun, 01 Jul 2018 16:32:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:ea3:0:0:0:0:0 with HTTP; Sun, 1 Jul 2018 16:32:49 -0700 (PDT)
In-Reply-To: <20180701093402.GN4348@dragon>
References: <1529930051-14122-1-git-send-email-yibin.gong@nxp.com> <20180701093402.GN4348@dragon>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sun, 1 Jul 2018 20:32:49 -0300
Message-ID: <CAOMZO5BjOEGWv2dC-bp0BYHq+PhLssEKic+o7ock8_1Dobd=sQ@mail.gmail.com>
Subject: Re: [PATCH v1] ARM: dts: imx6sl-evk: keep sw4 always on
To:     Shawn Guo <shawnguo@kernel.org>,
        Yongcai Huang <anson.huang@nxp.com>
Cc:     Robin Gong <yibin.gong@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 1, 2018 at 6:34 AM, Shawn Guo <shawnguo@kernel.org> wrote:
> On Mon, Jun 25, 2018 at 08:34:11PM +0800, Robin Gong wrote:
>> SW4 is one power rail for LPDDR2 on i.mx6sl-evk, so it should
>> be kept always on. But it's disabled after switch disabled
>> interface implemented in pfuze driver
>> 'commit 5fe156f1cab4
>> ("regulator: pfuze100: add enable/disable for switch")'.Thus,
>> it breaks kernel bootup. Add 'regulator-always-on' for SW4.
>>
>> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
>
> Does that mean boards with existing DTB installed will stop working with
> new kernel?  That's bad, and the kernel commit should probably be
> reverted.

Yes, this is a good point.

Anson,

Should 5fe156f1cab4 ("regulator: pfuze100: add enable/disable for
switch") be reverted to avoid such breakage?
