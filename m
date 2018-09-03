Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A65C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 06:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 770D620652
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 06:15:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 770D620652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbeICKeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 06:34:06 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:40897 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbeICKeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 06:34:06 -0400
Received: by mail-oi0-f65.google.com with SMTP id l202-v6so31673439oig.7;
        Sun, 02 Sep 2018 23:15:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q2ZCunzbkkFXTlYNcvypMLR2svkaZRvfiiTFPiOaAzA=;
        b=a8B1dZjs+rl7uj1+DYFwz6ZC9a9qX+9WZ0dbvSnwYdepCkoSE/+d11vo8se59yO1sw
         ZBujh+UD5l22757DMbq1+W4OVsep9JR2McogoqIvoMQzEenhr24P/LKLd/A5YW2adK6J
         Fw1NmXpZNdAA71Ucgh/dJWgGFVOhyXp65Wih2BZ9eZXTpEcXI/wFT78nZKNPzxTZAVIk
         zM23LXhFhABt4TBfgZnBCvmocuSPKPq+q+QvPaK4CvhKi71vSpULPC14jXT7GaGJoez9
         NHcMuWoe2Dnjw2/NoE3FqMlTzRVW7PSxz5IDPHDNPSihZgGeLNvtooxJzekDwTz1RLoZ
         3h9w==
X-Gm-Message-State: APzg51CFao7V/fl4FjM6so2H/Kqihnsz7ulmrhLFQ64EyiKmARcG/wEr
        VnFa6LswqxWFaENe0Ab4QNeBwvUWkyYwpK0j2To=
X-Google-Smtp-Source: ANB0Vdb/hJo0L/AShWTtV6kB9uWAxVDLJRB1IrivJiAO+cstM53oCiRK5hGGTFr7rH0L7nXLWkMpJr+vbn6Fdim7jvg=
X-Received: by 2002:aca:c7c2:: with SMTP id x185-v6mr17274435oif.43.1535955326907;
 Sun, 02 Sep 2018 23:15:26 -0700 (PDT)
MIME-Version: 1.0
References: <20180606193811.16007-1-malat@debian.org> <20180724204757.qrgjttepzcfdzxlv@pburton-laptop>
 <20180831203752.37rsceiwotcmeses@pburton-laptop> <20180831205857.nb3ij3rzhfs2fu42@pburton-laptop>
In-Reply-To: <20180831205857.nb3ij3rzhfs2fu42@pburton-laptop>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Mon, 3 Sep 2018 08:15:14 +0200
Message-ID: <CA+7wUswC1SfC3G0RRH7OV4C6nQsp59R62FN_NiDSyCpxRDf__Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] MIPS: jz4780: Allow access to jz4740-i2s
To:     Paul Burton <paul.burton@mips.com>
Cc:     James Hogan <jhogan@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 10:59 PM Paul Burton <paul.burton@mips.com> wrote:
>
> On Fri, Aug 31, 2018 at 01:37:52PM -0700, Paul Burton wrote:
> > Further to that, this series doesn't seem to work for me. With
> > v4.19-rc1, with the patch from [1] & then this series applied I see the
> > following when booting a ci20_defconfig kernel:
> >
> >   [    0.846684] ALSA device list:
> >   [    0.849642]   No soundcards found.
>
> D'oh! Apparently I haven't drunk enough coffee today - missing link can
> be found below:
>
> [1] https://www.spinics.net/lists/linux-gpio/msg31965.html

Awesome, thanks for testing. I'll return to this series once I receive
replacement for my laptop hard drive.

thanks,
-M
