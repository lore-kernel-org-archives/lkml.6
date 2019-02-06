Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D9CC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D57062080D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731202AbfBFPOF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 10:14:05 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36703 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730384AbfBFPOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 10:14:04 -0500
Received: by mail-ed1-f66.google.com with SMTP id d12so5147653edy.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 07:14:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/s+E70YYdc6I/KhbNBXngvUVfd6XKQycMfmIAypMTQU=;
        b=GaxeZy6T+LE3sPgXzliFs0RMZ4/k4yOnyduHfEp7UWzpMzHmwaioRzmYokIf5/TU/o
         4L7t0xgHICg3o8fUjU9FWT8YAB5u3LoSXcAyWPceg0y3hdaFip4Ku6FaMD+1JFpHmJoZ
         H1F5I9Qa8hJWgZuoqPynQEcE2utQ5MquMHVed0SIouIVd5K9G1bCapmX083FQl9UEZkz
         c7nUY2Girhn0N9ml9bS1/WZ1Vo0WINlmjgCztO+COLmo3g/jwOgbZsR9UgrJr5f0ijVj
         wqmY72MKeqmsZ6qU27ash2+XvZRYZKvS+AXu1eMbYmNMn2gOMC/ozRHudBKAtTI9fIYt
         B3Xg==
X-Gm-Message-State: AHQUAuboDm+tL5+YJhvSKoZtdO5BfEH7Kj9qpL3x9x6HS9SyFXyqXNQi
        As9gf2hXnuPKqzkJfCp33TC0tz6haRU=
X-Google-Smtp-Source: AHgI3IaWVPzPl7L+2fFQJkqfEgXgUrPdGldh1aRsFkMysL2tpmyasg0NfKLNowdAReYa2lvcmdpjQw==
X-Received: by 2002:a50:ef18:: with SMTP id m24mr8589152eds.136.1549466042564;
        Wed, 06 Feb 2019 07:14:02 -0800 (PST)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id q16sm5760534eds.60.2019.02.06.07.14.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 07:14:02 -0800 (PST)
Received: by mail-wm1-f47.google.com with SMTP id g67so3135109wmd.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 07:14:02 -0800 (PST)
X-Received: by 2002:a1c:494:: with SMTP id 142mr3558569wme.111.1549466041735;
 Wed, 06 Feb 2019 07:14:01 -0800 (PST)
MIME-Version: 1.0
References: <20190128140219.4414-1-axel.lin@ingics.com> <CAGb2v67UV51oaDXgF2ocTSYJVNhZFPf_bmDtqLDApA_YB-oqWA@mail.gmail.com>
 <CAFRkauB584T9CqmvwRO3eYhL+N4Xi38Ti6b7aPpCGk-L_-OcUA@mail.gmail.com>
In-Reply-To: <CAFRkauB584T9CqmvwRO3eYhL+N4Xi38Ti6b7aPpCGk-L_-OcUA@mail.gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 6 Feb 2019 23:13:47 +0800
X-Gmail-Original-Message-ID: <CAGb2v66Weg_xrpXHdHe6oLuSGn-HXSZ1gCvjTr40SZqoEXPq_g@mail.gmail.com>
Message-ID: <CAGb2v66Weg_xrpXHdHe6oLuSGn-HXSZ1gCvjTr40SZqoEXPq_g@mail.gmail.com>
Subject: Re: [PATCH] regulator: axp20x: Fix incorrect vsel_mask settings
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 6, 2019 at 10:47 PM Axel Lin <axel.lin@ingics.com> wrote:
>
> Chen-Yu Tsai <wens@csie.org> 於 2019年2月6日 週三 下午6:44寫道：
> >
> > On Mon, Jan 28, 2019 at 10:02 PM Axel Lin <axel.lin@ingics.com> wrote:
> > >
> > > Fix copy-paste mistake while converting to use defines for masks.
> > >
> > > Fixes: db4a555f7c4cf ("regulator: axp20x: use defines for masks")
> > > Signed-off-by: Axel Lin <axel.lin@ingics.com>
> >
> > Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> >
> > Though I believe the latter three have already been fixed by
> >
> >     https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git/commit/?h=for-5.0&id=16c8a595740035c4a7ede608a60b4a59f67b76e6
> >
> > Could you respin this patch on top of that commit?
>
> This is similar fix but fixes different places.
> BTW, Mark already applied both patches.

You're right. Sorry for the noise.

ChenYu
