Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFF8C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 19:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B98420854
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 19:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rPuc8jBY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B98420854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730813AbeGVUDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 16:03:43 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50739 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730699AbeGVUDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 16:03:42 -0400
Received: by mail-wm0-f67.google.com with SMTP id v25-v6so13890055wmc.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 12:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Nn5GLq0MQxAU2i1hO+g1ugMweI0gPxSiXCfbvM9iMwE=;
        b=rPuc8jBYxowM9VnTpiWXY9XmrDGQZZXWy8ZGtOeLKSbTEqurU73WpQnCZxQ61PX/Xr
         dmTLMxmiEy60PZWnzYr5Qleb+XGO2eJ5nNBySH8D+OiNdU+76q/Va195ta6q0d3lGFUR
         y3a9F2PTeoSj1Gk9uiZkbsji7phcGYkBCczs6VhIRWb95kEscMGnvklwbLsz9YCy0wdY
         5Zsuj4ejWOK9skTsqO7qLyr/oAIqayRyoR16qeyumo72GmbEF8LN0y0lO4CnYw13nbZ6
         cII0EaLt8YNx/by1UfAZwKVaX3wJuhfdqNlSW6QbWVoeETZ1YRu99ySf4P/v6OjhKst6
         ZYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Nn5GLq0MQxAU2i1hO+g1ugMweI0gPxSiXCfbvM9iMwE=;
        b=kNuRuFc+Er42gtgtI/MYadxlCot5KyVFcudcTYzzPxjQQNBrYXWFhcv/YD3bMTpYXJ
         NWRyahBj8MnwCvIF/Ez6dWp7UlDq+fw2xmA0OSxveSf35jvgianziQiq9O+vyMQbBAGh
         DpWa/40v6TCKuO27erm4ZFdhEkcYrmZXskzbMmL8ipscStDhipniIyotmakbePRK/yXv
         scfVG67I65DASdWZBpS5JdpmypwBNrqzE/oYxNtgI2Tv1MPk8hFPYtYOd81+WdFOoIjA
         SjFkqJ5S8z847Rt3ets8HVCeV10T36skB5Mvs89qs77ZBgy2N6ESFI2vWc+PxtD4i3QE
         oCKA==
X-Gm-Message-State: AOUpUlH1/BfSj2YkaLs4HO0+j6Snle7L8wkLorNuPPW5Dl1w/lJPjGtj
        LtajMPzHXynXUezgpD0vQSJsVyCAd8/t5ExI998=
X-Google-Smtp-Source: AAOMgpf8e+jHcjOJ/Xd0rp1rzByeHHY+Pa17IjyePcwoIHWpnHfg51OnXUVfeSL/Enl0X4ITqU0ZhAJytycMaSMjhcs=
X-Received: by 2002:a1c:70b:: with SMTP id 11-v6mr5751833wmh.151.1532286361313;
 Sun, 22 Jul 2018 12:06:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:4812:0:0:0:0:0 with HTTP; Sun, 22 Jul 2018 12:06:00
 -0700 (PDT)
In-Reply-To: <cover.1532043059.git.theuns.verwoerd@alliedtelesis.co.nz>
References: <cover.1532043059.git.theuns.verwoerd@alliedtelesis.co.nz>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Sun, 22 Jul 2018 21:06:00 +0200
Message-ID: <CAFLxGvyqZNLeRgxGvNNnc-zsPydYLisEB3eX0R5CVCEhEuN4QQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Secure deletion under JFFS2
To:     Theuns Verwoerd <theuns.verwoerd@alliedtelesis.co.nz>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        "linux-mtd @ lists . infradead . org" <linux-mtd@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 1:50 AM, Theuns Verwoerd
<theuns.verwoerd@alliedtelesis.co.nz> wrote:
> Security certifications such as FIPS require the capability to securely
> delete files, which is problematic under JFFS2's log-based model.  We can

Can you please be a little more specific about the certifications?

These days secure deletion at file system level is almost impossible to achieve
since you don't have full control of the storage stack.
I know, I know, In the raw flash case we have, but still. It makes
things very complicated.

A common approach do delete a file in a secure way is having it
encrypted and upon deletion
you forget the key.
Wouldn't that work for you too?

-- 
Thanks,
//richard
