Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851B1C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 20:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 524E3217D4
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 20:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xinwe3+0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfAYUpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 15:45:04 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:39845 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfAYUpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 15:45:04 -0500
Received: by mail-yw1-f66.google.com with SMTP id k188so4436767ywa.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 12:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4JMZrpfHuyPNRZL7oAWF/+fNEe9mxod6eHYkJMlt7M4=;
        b=Xinwe3+0XjfLU9YY5f+uyYOq0ndUjIcatUdab1ZMsNrnTXQdfvn+swNv0Nyxq7rvHt
         +RoZ1qMAgeHtVi0mayMfUEXwnBxOoQWr2DaFcO902bZK5sc0qIz0+vv0Jofi9RMIgFB8
         a0TChVKNI82mUEw17pJNHPcc4m5m99++AijDmdihSXIA8aRYEQi3NfH+palgTp1MrXf4
         fKFiRwgA0qlNvYGdb+gu8HGNdE9VztrxEaPN2dtvjW1tcIw6yppFTcQ9sgtyrzUiIy6m
         RlLSuk7cfxPU15c14DRwxGFAtfdI1GpGqa555fKe2z4kG0A4/OAosLZhwAOIeCOCtOXp
         d3yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4JMZrpfHuyPNRZL7oAWF/+fNEe9mxod6eHYkJMlt7M4=;
        b=hhvkk+xh+oJSqmMYqYIdvxjEWHI1jda9bBEOQO1OrGIkKYiP00x2FyZUP/G7kt237s
         zv1odgzsYVoHYlcJoQKyz7m5LAx4l+/ya2/AOlNDDTeYcXBDq194Z71jEpEccAEuI5ug
         ae4mTi/3YJeoQQHnfFbX++B6KBMFhcnyk/Xg3aEtjeYTA2sh25bFmwpBzQgNJ833jiRo
         4Elpvf2cwS0Epxd1XJC/iYL4fuz7mwed8WJxe4ji7Kk1sz8rsDVtPUd0UtlAYWn0xiJE
         POdduJAUyRxxfy/Ex/E8pbTfwYn0r2+haURZkZwZIo4jyY8bG84bsv83T/a+nQ1IHRYr
         5UwA==
X-Gm-Message-State: AJcUukfgmDpltHhoqawguJOE1yGfWO1mddNNIfmN3jjHfFIyQKx+pO3c
        DQCFr4K4Bwfb8/j14KkL/hvumgqeBM9t12zLV8S0EMsi
X-Google-Smtp-Source: ALg8bN4Sa2MeeurspnvrTNzyx9dCOsqYjBNWMV+W9u43+JvIPjQOpgXlErBb8J2gIOuWsfmHfayDtsj13zvOlHXIoEs=
X-Received: by 2002:a0d:ea81:: with SMTP id t123mr12444295ywe.496.1548449103338;
 Fri, 25 Jan 2019 12:45:03 -0800 (PST)
MIME-Version: 1.0
References: <1547819127-4439-1-git-send-email-clabbe@baylibre.com>
In-Reply-To: <1547819127-4439-1-git-send-email-clabbe@baylibre.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Fri, 25 Jan 2019 12:44:51 -0800
Message-ID: <CAMo8BfKnNgWXBtDBGEAxMnpv=uVbV5k+NzbPkpMZWFYwRMCBnw@mail.gmail.com>
Subject: Re: [PATCH] xtensa: Fix typo use space=>user space
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     Chris Zankel <chris@zankel.net>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 5:45 AM Corentin Labbe <clabbe@baylibre.com> wrote:
>
> This patch fix a simple typo.
>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  arch/xtensa/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, applied to my xtensa tree.

-- 
Thanks.
-- Max
