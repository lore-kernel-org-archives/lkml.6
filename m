Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC0CC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52B5421532
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="okG5ptnL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52B5421532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752578AbeGDPZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 11:25:24 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:55018 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752158AbeGDPZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 11:25:22 -0400
Received: by mail-it0-f66.google.com with SMTP id s7-v6so8254007itb.4;
        Wed, 04 Jul 2018 08:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u9Cc2d6qwJs1fGNNRzl/YU7dK6xHRkdXuRCu68vPr7s=;
        b=okG5ptnLHkD9UsUMM6/w1eoUczP9wI5ey4hGKSzCWh7QZGiBdzBooOtUiINz0fVmjK
         P9xHcCnhZktH90Lumxmnvm1DQm02aH3qOG1x6MXzV+WOXv7gV8iwL7Ok8yHJoUeChbpf
         cmlqjngU84P4lNI2N68JtpBJibiGOTGBFehbYSMvwVuwqh56nRB3QdLhZlphgX3tE0EV
         au7n+NS/+TDud29CHsDyqDdIATXNkmO6mfL4khCyv+0wqAuwWQsELTFL8gKMTecvMQRO
         p1VQVJ5sKIkPPvacd/uS+JoqtLW7kAE1qlDJWE4/9xsSW86t4waT0TRH2xaTbTi5xlFx
         gFTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u9Cc2d6qwJs1fGNNRzl/YU7dK6xHRkdXuRCu68vPr7s=;
        b=F0IOqItGfHKiE7bohCHb8SK/ZEF2Of2527wOvQyxHICuUbLPGUMjz5HsPyYka51++3
         LlW8QcSb3fxiwo0l3vvvg4SfRCkV3tgjiq35kMTIgz67KO2Ndv+fEt+FsTzXDF22oI48
         2Klb1dmjVUiogs5/hNYZl3u4jN9009d0+U3EPdgRpXwflrHXI6uF0K0hcMGgf33Wh0B7
         4eEGuYHpQO6dddBv2Q65RDqyGJI1eaZaGNxnGIChVTASIvZX8DZ2788t7gZci7HUBmgo
         JLprnbC/TWoQDad5NEVXT7xHR83+f07QwnkAi5iiMdemUVb3CF3IHU+QP2NvBDGYAjo+
         upFw==
X-Gm-Message-State: APt69E1sdNIIPFsavG3gk1JkQWzzhdsve33F8cCEJmFwHt03K5aWPnu6
        x3xCq2e9wtrV0XP0S2X069w=
X-Google-Smtp-Source: AAOMgpeGBW0OIPpqbQFilRFh66GEyfUL+HAJEyuTRLdZO/aGSFimKBpnoZnMttdmDYlikzfhwwercg==
X-Received: by 2002:a02:5cd3:: with SMTP id w80-v6mr1991374jad.85.1530717921307;
        Wed, 04 Jul 2018 08:25:21 -0700 (PDT)
Received: from localhost ([12.130.117.108])
        by smtp.gmail.com with ESMTPSA id r199-v6sm1967780itb.8.2018.07.04.08.25.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 08:25:20 -0700 (PDT)
Date:   Wed, 4 Jul 2018 15:25:14 +0000
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Chen Zhong <chen.zhong@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [RESEND PATCH] dt-bindings: input: Add common keyboard document
 bindings
Message-ID: <20180704152514.33h52ujqp34hpj2o@penguin>
References: <1529648198-14231-1-git-send-email-chen.zhong@mediatek.com>
 <1529649595.14396.18.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529649595.14396.18.camel@mhfsdcap03>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 02:39:55PM +0800, Chen Zhong wrote:
> Hi Dmitry,
> 
> The other patches in the series to add mediatek pmic keys support are
> now available in 4.18-rc1, but this patch seems not being merged.
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git
> ib-mfd-input-rtc-v4.18
> 
> I have resend the patch, and rebase to 4.18-rc1.
> Could you help to see if it is good enough to be merged into your tree?

I thought Rob would pick it up, but since he hasn't I'll do it.

Thanks.

-- 
Dmitry
