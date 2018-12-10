Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51EFFC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13CF2205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EwujdJb4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13CF2205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbeLJHFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 02:05:20 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33237 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbeLJHFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 02:05:20 -0500
Received: by mail-wm1-f66.google.com with SMTP id r24so5871059wmh.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 23:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=MDv/MAnv9rSBfZiz91T2afQ7f8hkEN6CAhnlHAwM96c=;
        b=EwujdJb4mE+dE+zexV5b+mY6tW18zktVTWVNWcEJVbulj49zEvS/0z3/q4hCXx2Hud
         fr3WsPNRrwJf2o9zOTw8xT4eoia4aTsrXyagpu09c4enkpKrOnM0KPkZ/FanPteSIygq
         0rFo4Wtbdn+RmafqCUlYk92HzuSoMwLh5zyqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=MDv/MAnv9rSBfZiz91T2afQ7f8hkEN6CAhnlHAwM96c=;
        b=TlKnZ+5dLJKOFibnakar4GL8VqZuAm1EyaO0gNWEzvZ9DT+xZGV0gd2WpFwaoccepk
         /HIMzvRbEd9g/zQHIZkQrExX4pLYcxXzO+Aw78nv85hgXEYFPklGNwzoytXm2ZxfyZWX
         Xwaq4h64YR2M9+Wq5ebBuk40YS02ZA4XQGay+qrFZyx/IehXLnohKpcX7HlKyjgCpU6w
         aw3IBMd1DqpWhfw4DZhQIoKETKKi8TK4hEMEy3ltpGuDlnSIQQWJHZJomykG8DmyqR6Q
         Irdnduvcau1nm3xQrJPPASjryY6nlRQ1NHXx4s6LzndRo6tjjfMUydHa8o7Bw3x7DwhQ
         PvfA==
X-Gm-Message-State: AA+aEWZtMW67bNZLafkpS+2DCbbMhb4zdtYhoosd1vN5ggYKLmeUB98a
        Kb4GS3ysRYUkpBb4KCY+s+Dxrw==
X-Google-Smtp-Source: AFSGD/VxXZWZnTUPXR4HvFemT+DhN37RxrLgOiGRttBmDkWgIuCizI9g3uUyuBLkkPkxPHbunkz+/g==
X-Received: by 2002:a1c:67c2:: with SMTP id b185mr8691780wmc.96.1544425518568;
        Sun, 09 Dec 2018 23:05:18 -0800 (PST)
Received: from dell (host109-155-202-221.range109-155.btcentralplus.com. [109.155.202.221])
        by smtp.gmail.com with ESMTPSA id p74sm12753325wmd.29.2018.12.09.23.05.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Dec 2018 23:05:17 -0800 (PST)
Date:   Mon, 10 Dec 2018 07:05:16 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Oskari =?iso-8859-1?Q?Lemmel=E4?= <oskari@lemmela.net>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/2] mfd: axp20x: Re-align mfd cell entries
Message-ID: <20181210070516.GW26661@dell>
References: <20181208175847.32068-1-oskari@lemmela.net>
 <20181208175847.32068-2-oskari@lemmela.net>
 <20181210063642.GT26661@dell>
 <c77951e6-46d9-d48a-b5bb-33bb9d00a929@lemmela.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c77951e6-46d9-d48a-b5bb-33bb9d00a929@lemmela.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Dec 2018, Oskari Lemmelä wrote:
> On 10.12.2018 8.36, Lee Jones wrote:
> > On Sat, 08 Dec 2018, Oskari Lemmela wrote:
> >
> >> From: Chen-Yu Tsai <wens@csie.org>
> >>
> >> In the axp20x driver, the various mfd_cell lists had varying amounts
> >> of indentation, sometimes even within the same list. For the axp288,
> >> there's no alignment at all.
> >>
> >> Re-align the right hand side of the assignments with the least amount
> >> of tabs possible. Also collapse the closing bracket and the opening
> >> bracket of the next entry onto the same line for the axp288, to be
> >> consistent with all the other mfd_cell lists.
> >>
> >> This patch is whitespace change only. No functionality is modified.
> >>
> >> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> >> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> > Why is Oskari Lemmela's SoB here?
> >
> > You both authored this alignment patch?
> I picked up Chen-Yu's patch from
> https://github.com/wens/linux/commit/b99cec26bae2835a0374463570ea9ea26b034afa.
> I should have mentioned it cover letter.
> 
> Chen-Yu is correct author. I'm just sending his patch.

That's fine.  Thanks for the explanation.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
