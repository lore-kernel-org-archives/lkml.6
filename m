Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C08C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 23:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26C7220842
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 23:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYgkKe28"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26C7220842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731507AbeG2Afv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 20:35:51 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46644 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730656AbeG2Afv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 20:35:51 -0400
Received: by mail-wr1-f68.google.com with SMTP id h14-v6so8700032wrw.13
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jul 2018 16:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RqCoUn7/bi3Uy5v9p9ZriAmLLGm3JhOtEDs5Pb92SJQ=;
        b=ZYgkKe28S+vsDFWWzuqxt+cTR/YMb8d7akr+CoXWMccngINljzXYA/x/OTokXucquP
         kxtynh5uYxohX8Fuj2KC7JV4XXybspac5G4U4oyQeOBjj/Mm9QvQVH8PBiUNL+rVbklO
         u6M/+ybh31R3x6/dk6e5xofChVS9itY+zYcrKrYzALKUsQfZ2r+yowsHrMjtbgPsvq32
         cv111wRgKcVM6OLpYhHErq4+K7eXUHiRSTFfd0dyPub590AXBTp7Kj4Kl/vcDp9VS2cC
         91/vDiw70sh5DyQI6AbE+imrBmacK30mUfOwetC6OAQn5ZgXU5kO4JwHhKiH8MfGhjPR
         um3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RqCoUn7/bi3Uy5v9p9ZriAmLLGm3JhOtEDs5Pb92SJQ=;
        b=jYk8j57nsmPM9iht3GuQM/CoH0JTnZ8XltqVqiR9FPvj/aPwfxKrwnTE9tBxfTUj87
         3mjZ3bMZv83fPdu5bvFziI6O34JuVIfo1KU5fcoCJErZGdzs/zu1v06olbLFrve8GRR/
         CDmhDnKdOU83BnOMWCkR0R1MlxkumzgOV4T9tQP8xdfaBvu6801Agbi5O1+kvms/oxo8
         Eyl2LTGB6fY84THIKfv9L7E8hwRpPfpn4p+zfCHSRnDOWUqYPESHN6boYelDnTCmoQse
         adFO6k0melJe1wt3J3+D71uda4uLE1gllIc0T+uYs8FOX9iiPUhKjmJfB4w8LZhPD3VO
         r0vw==
X-Gm-Message-State: AOUpUlE5D8gIglqxQkE4xAB2t5M679s81xWW2JhmF1e+/4/D7/dGy99H
        XLskACWIc+Xa+mKk++TJyDA=
X-Google-Smtp-Source: AAOMgpcNQogQEj5mOKiSklkoVoqopAb09qgv2YVpHaDN6fn2ieJjOJd5A1MkhxTB5gA/QB3qnW/SGw==
X-Received: by 2002:adf:db11:: with SMTP id s17-v6mr5515777wri.221.1532819261171;
        Sat, 28 Jul 2018 16:07:41 -0700 (PDT)
Received: from xux707-tw (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id r1-v6sm8223327wrs.39.2018.07.28.16.07.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 28 Jul 2018 16:07:40 -0700 (PDT)
Date:   Sun, 29 Jul 2018 00:07:41 +0100
From:   John Whitmore <arigead@gmail.com>
To:     John Whitmore <johnfwhitmore@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH 00/08] staging:rtl8192u: cleanup of rtl819x_Qos.h - Style
Message-ID: <20180728230740.GA19821@xux707-tw>
References: <20180728230300.19732-1-johnfwhitmore@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180728230300.19732-1-johnfwhitmore@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 29, 2018 at 12:02:52AM +0100, John Whitmore wrote:
> These are a few coding style changes to the file
> drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
> I had more patches in the list but had to dump some of the later
> patches as I made a mistake. Thought I'd send these 8.
> 
> John Whitmore (8):
>   staging:rtl8192u: Add spaces around operators - Style
>   staging:rtl8192u: Rename ACI_AIFSN - Style
>   staging:rtl8192u: Rename member variables - Style
>   staging:rtl8192u: Remove unused  union AC_PARAM - Style
>   staging:rtl8192u: Remove unused union ECW -Style
>   staging:rtl8192u: Rename enum DIRECTION_VALUE - Style
>   staging:rtl8192u: Rename union QOS_TSINFO - Style
>   staging:rtl8192u: Remove unused constants - Style
> 

Sorry I forgot to edit the subject of each of the patch emails to
truncate the patch series to just the 8 that were good. I'll edit and
resend.

jwhitmore
