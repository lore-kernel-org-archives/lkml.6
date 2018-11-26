Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCF0C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A63EF20664
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NKED8KV7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A63EF20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbeK0Gru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 01:47:50 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:34316 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbeK0Gru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 01:47:50 -0500
Received: by mail-io1-f65.google.com with SMTP id f6so14997901iob.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 11:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zP6lpUskG1rDoaB/olEgYPbqOaIy43+0X9FfLGT2CpE=;
        b=NKED8KV7o2WW756UqKrhWkd7CtAhv4Ngb7jjsWNKVqx4WeFjgIGwwELMrmHigy+von
         oZa0tgxRO3jx3VrFVGMbLP0743nPL56vvZjnEgHn5z4uUzpsFbPnip/qHlJr8LcFXMqd
         tdIwyniuZWaypMvq2ES35MEkptFI1Ak0S1M9wZLawfTTX/NZZ6UoGLtzMKnLwlKbeHD9
         zF2Zqtj54odlo1yXeloU7mTADMTta9cp8X5p443R4zY2215Ptii+7wTOCSaMwY0XS/0r
         +8OALVns4bvyEuR1ks0HsLDRZ9M1bde0NPwbLeii1KbrTV6mSGPk6HSfmEICfxBD05X6
         UoqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zP6lpUskG1rDoaB/olEgYPbqOaIy43+0X9FfLGT2CpE=;
        b=PeJuKYDhd2L35j/oNZ4tNC9xbVEZMi0xVfGpgijHlDWiATyM6pJ+U4VDwQ+IA2MJ8y
         U59wAjlA0XHe8gGVKWlSrVCyDrhWTibARWou0jMYI6pt/hG522bxvp6BBEZCbVhVoebf
         Oue8y+pi/qGbG3zPYE2jrUv5eUY8bhpOzUhaj6JE2cDu8YnaEYsDs/O3KoBKoOVz52dn
         Puz6zXho8EeX+iS2Gp5avTxvTW/LmpUgsNy/QQPTar/VnVfPjTpQZClmgqCieytU3fpL
         RLbkfvb+d1cD67ESkq1D8yu8umNe+HJY06ul2zqMJ2mfDwMTMhT6gSlOM1w7rbAHZZIr
         1ITw==
X-Gm-Message-State: AA+aEWZ1KGo9ZzV2zamjoPDxM7fd/8rnfW4sniojZok9CkQIQD0MFaTR
        0M9ZHGoRQ/8yCYgx/695HkwHHLjvARLc3MG+gmJpAA==
X-Google-Smtp-Source: AFSGD/VHQGR5DvDLvkra34FKZmswZn/b6EW4Hx7rkWDEv8CPq541kLP30VyRCbacZibecPJdd1cLoPl/JC7v+dG/ZwQ=
X-Received: by 2002:a6b:d005:: with SMTP id x5mr22477324ioa.46.1543261958612;
 Mon, 26 Nov 2018 11:52:38 -0800 (PST)
MIME-Version: 1.0
References: <20181121031449.255314-1-schuffelen@google.com> <d0ba9821e46e1111bc483188466bb68dc1bb3c4a.camel@sipsolutions.net>
In-Reply-To: <d0ba9821e46e1111bc483188466bb68dc1bb3c4a.camel@sipsolutions.net>
From:   Cody Schuffelen <schuffelen@google.com>
Date:   Mon, 26 Nov 2018 11:52:27 -0800
Message-ID: <CAAELVAEVJK3iezPVCB9fizDwy+HoFtFZp5KTMDu+GmYCy-KG1A@mail.gmail.com>
Subject: Re: [PATCH mac80211-next v4] mac80211-next: rtnetlink wifi simulation device
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        sergey.matyukevich.os@quantenna.com, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        kernel-team@android.com, Alistair Strachan <astrachan@google.com>,
        Greg Hartman <ghartman@google.com>,
        Tristan Muntsinger <muntsinger@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +config VIRT_WIFI
> > +     bool "Wifi wrapper for ethernet drivers"
>
> The built bot complaint is most likely because of this being bool rather
> than tristate (CFG80211=m, VIRT_WIFI=y, I guess, didn't check), I
> thought this was because of the wrong reasons and should be back to
> tristate?
>
> I can change it back, let me know.
>
> johannes

Right, my mistake. This should be a tristate again, sorry about that.
Should I send v5 for this?

Cody
