Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B893C282C0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 01:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6326421855
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 01:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrXg/1Wk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbfAZBt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 20:49:26 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34978 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbfAZBt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 20:49:26 -0500
Received: by mail-pg1-f194.google.com with SMTP id s198so4925326pgs.2;
        Fri, 25 Jan 2019 17:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z31oC3yzCXeE8gwNzZb7c+UyH2VYUHaOsK2yTfHBL38=;
        b=mrXg/1Wk6jQhvCIai+RxDFsBL9W9egTtNMpDrQt5qcqmpvPILdn7IRcwwd2iAT/kKV
         46XrJIleLhD13kWeYOsrX36zdkZLpl1F+QYul9OpGMfCuFUyDQz96yuqR08m96BzcOCC
         2wAkIibqR8+Rh7s1Oo8LCOuiB+DNS8jcLAll5CuLmMM2gdS5OrKmM+yzL+dBak8JfvAA
         sEX8PFDmp9vXMIqIEpeiUgukkaeJxrxeIYOuaGqhoorbU/CPkFGvGo3RFyxhJ67qnz2A
         oL/n2yLk2+RqItbiY3vlXIjPONMtDn8yIkjM3NS1nUewE2r8PDmLHFUvCAsmVPVhozZN
         eDkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z31oC3yzCXeE8gwNzZb7c+UyH2VYUHaOsK2yTfHBL38=;
        b=XKGCzN5XQPDBapyeAk7Wb+0zCGKi0wRU511ykksVg4P9tVcIPO+AE01T4XmN9cy5Hs
         Epg++hYxgy+ISy86ZgOfjRvSkHkOBnygnC3LEykFQXr4VUg89DefWuPTJY9vr1h4zdKV
         TcYWgBgspuvQoOqGR9jfVBkXNxohKIA+L9/PRcc17biMq+lYalpUyiYuFjBTLyuL7Fev
         uzViV+XU9SVOJ/cSp/ipnANzLhGcoPiwRVBAv3W6SS4SI1MfLeFECTRzkdzCp8kjHJP6
         okhrNhA6Pgwy2mFUSQpbbWs97UHXNEbglvUxyfplsyFntQIA/kOiNlj3fM0qoaXv/jt2
         Cm6Q==
X-Gm-Message-State: AJcUukeS0JdwlX8Yh3TFIhN8pOavcTZP09aCBi8nNkvO6a34hiMe3Hdb
        P3H2CgGuwSvfUOMeJoGscPc=
X-Google-Smtp-Source: ALg8bN6LNwjIcCOtzPL86VZMRi8QaLPut6xIKH1PZUt4RMpqs+MBj9+pyxUIqu3HuBajUJFlLuUWQg==
X-Received: by 2002:a63:4d:: with SMTP id 74mr12263296pga.248.1548467365246;
        Fri, 25 Jan 2019 17:49:25 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id o66sm42745234pgo.75.2019.01.25.17.49.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 17:49:24 -0800 (PST)
Date:   Fri, 25 Jan 2019 17:49:19 -0800
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Viorel Suman <viorel.suman@nxp.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Timur Tabi <timur@kernel.org>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Cosmin Samoila <cosmin.samoila@nxp.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Viorel Suman <viorel.suman@gmail.com>
Subject: Re: [PATCH v3 2/4] ASoC: add fsl_audmix DT binding documentation
Message-ID: <20190126014918.GA2617@Asurada-Nvidia.nvidia.com>
References: <1547729177-14317-1-git-send-email-viorel.suman@nxp.com>
 <1547729177-14317-3-git-send-email-viorel.suman@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547729177-14317-3-git-send-email-viorel.suman@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 12:46:29PM +0000, Viorel Suman wrote:

> +  - dais		: Must contain a list of phandles to AUDMIX connected
> +			  DAIs. The current implementation requires two phandles
> +			  to SAI interfaces to be provided, the first SAI in the
> +			  list being used to route the AUDMIX output.

Another small thing, that I just noticed, is this list. It forces
the first input source to be the output source without giving any
chance. I feel that we could have some flexibility here: one node
for two input sources, and one node for the output source.

Well, there is no critical problem with the current binding since
it follows the SoC design. Yet I doubt if this routing logic will
never break.

Any suggestion, Rob?
