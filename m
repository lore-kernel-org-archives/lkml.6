Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0289C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 18:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 666D420827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 18:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GiZ5i0r5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 666D420827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbeKJEOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 23:14:51 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42554 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727995AbeKJEOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 23:14:51 -0500
Received: by mail-lf1-f68.google.com with SMTP id q6-v6so2020290lfh.9;
        Fri, 09 Nov 2018 10:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hEx7WvExQACs9A+tZ6xJESgNOFjkcvD0IDRyaC1Tx2w=;
        b=GiZ5i0r5zy6uB3xlH/patczc/JoNg8yJj4ph52/eSulZpcDGRJgUTA12qm5oSaUDK6
         LwB3Jsp8jHosZKZEmgw2vIXZkHRlKtPokS94vZ4y5RO4A9MAyIDA6VOQs+0unP/uzs4H
         HZI6yLeLsGUm+B9luLL1U/Aq+J9Fm2gmAyGQcz7Gxq22yy1byiOG0Z4M9WUDKd0Li3Yv
         tJImGgNPMGBNZPx8FrVXaRIb1E21WAqHBwWKlNg3dSql9k1txP/kG8Owa9GOR+d1mhN8
         y8OjWDEinNMH75E4pyC1MyNF8VIrsmOtMdLchdHZEMaMywPBxFTg6HivzysTkjmy75qr
         0A9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hEx7WvExQACs9A+tZ6xJESgNOFjkcvD0IDRyaC1Tx2w=;
        b=b/cNjbpFnjuu0u8zFIDmaI5tC2r1atJljm7aZ6ovlktF9HK9Ls2bhRd2CDM6GXRWxk
         /RMbeQeVG0O810DnK0MDZKeKtyIltaDYycUBM/j8VVPTCe83y1qTVhuHY4Zb9fZAlY3P
         xEhhvd+GorFhmS9ljl9CrHe4k4V8KnopwZEzhBmvvjxaKKTT6n1+xsVMn69f2CmaxM49
         tOK8bb+CO0hHOfVU7Yt4xQZQp6IUxRlP3Jdh2vm3cD4Js4kWuu5+QRWRRgx5A93uR5nR
         cHb2JXNJoZ1rIUOGv/TS7DWL1g2jy/RzfcOsavdgacdq/4Myo5VO3Q9RM4fXMEnwtFmJ
         YrSw==
X-Gm-Message-State: AGRZ1gLU0/Gd63MVBG2JDUsyR9hr5dSe1bZb3zsdprhqreFxm22pklVg
        aZ9DL0GqKxfzZd+ZuRY73oc=
X-Google-Smtp-Source: AJdET5caq3MuIQ+5sm3Y7Ysn/6e+u6A15TWe4b7+ROasv6BGL5k/+/f7/wCxNcPUYPG2CvHnCaAkCQ==
X-Received: by 2002:a19:5a05:: with SMTP id o5mr6435821lfb.140.1541788382278;
        Fri, 09 Nov 2018 10:33:02 -0800 (PST)
Received: from [192.168.2.145] (109-252-91-202.nat.spd-mgts.ru. [109.252.91.202])
        by smtp.googlemail.com with ESMTPSA id r199sm1503119lff.50.2018.11.09.10.33.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 10:33:01 -0800 (PST)
Subject: Re: [PATCH 4.14 07/31] clk: tegra: Add quirk for getting CDEV1/2
 clocks on Tegra20
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
References: <20181108215129.641434673@linuxfoundation.org>
 <20181108215130.285950754@linuxfoundation.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <16709e1c-16d4-cf22-2218-5bc9c12151bb@gmail.com>
Date:   Fri, 9 Nov 2018 21:32:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181108215130.285950754@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.11.2018 0:52, Greg Kroah-Hartman wrote:
> 4.14-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> [ Upstream commit 5d797111afe12e488e08432fd9b372fae2cc7e93 ]
> 
> CDEV1 and CDEV2 clocks are a bit special case, their parent clock is
> created by the pinctrl driver. It should be possible for clk user to
> request these clocks before pinctrl driver got probed and hence user will
> get an orphaned clock. That might be undesirable because user may expect
> parent clock to be enabled by the child, so let's return -EPROBE_DEFER
> till parent clock appears.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

[snip]

Hello Greg,

You should either pick up c59487075659 in addition or don't backport anything at all. The original problem was gone while we were trying to fix it and these commits only helping to ensure that the problem won't re-occur, AFAIK it shouldn't be necessary to backport any of these patches.
