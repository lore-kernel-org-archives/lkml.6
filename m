Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F8CC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 13:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD00520883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 13:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=birdec.tech header.i=@birdec.tech header.b="QxfNOone"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD00520883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=birdec.tech
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbeKIWpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 17:45:20 -0500
Received: from host.euro-space.net ([87.117.239.2]:60316 "EHLO
        host.euro-space.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727784AbeKIWpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 17:45:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=birdec.tech
        ; s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Qm+1QkJK3o1xhQVxZtnhNPRliV76QpTd9/7K1JBty00=; b=QxfNOonedfoPkkpQ3/FsMR8S5v
        3lmS5jjWamngyGT81goHiSFTMIWPU00frWN2uVJln0XQwgqZgBfR9ErINHr/UTUM+oZ1a88SzYyey
        gP3lvnfsd6Okeef962q1Sh8mUqVryTikhgeV8606pfH2ZrfBw8gMfGIrm2ckQG5oRpG4MbLHO2Pkh
        ZL+mHWsqzcxGNebSg5V4s1N2DIbexdgGjtprFuME2sbbQ+DyfvPsTiKAG+LPRxSqH+kRzuT4BTnD+
        na3iaENFt/SQsUFE7JJGVSsDSfZ4vxTZXDNfqK640DtSq3L9o26i9qii1U/3rr+AqfvLL4+yJ/MXT
        K+yXX2Fw==;
Received: from x4e37285c.dyn.telefonica.de ([78.55.40.92]:37570 helo=[192.168.1.3])
        by host.euro-space.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <kmarinushkin@birdec.tech>)
        id 1gL6Sq-00030g-5R; Fri, 09 Nov 2018 13:04:44 +0000
Subject: Re: [PATCH 1/2] ASoC: pcm3060: Add control for differential output
To:     Mark Brown <broonie@kernel.org>
Cc:     Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20181029085913.17298-1-kmarinushkin@birdec.tech>
 <20181105112036.GC5365@sirena.org.uk>
From:   Kirill Marinushkin <kmarinushkin@birdec.tech>
Message-ID: <34162ae4-5000-f355-a5a2-90c7b7c6c3e7@birdec.tech>
Date:   Fri, 9 Nov 2018 14:06:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20181105112036.GC5365@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host.euro-space.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - birdec.tech
X-Get-Message-Sender-Via: host.euro-space.net: authenticated_id: kmarinushkin@birdec.tech
X-Authenticated-Sender: host.euro-space.net: kmarinushkin@birdec.tech
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,

On 11/05/18 12:20, Mark Brown wrote:
> On Mon, Oct 29, 2018 at 09:59:12AM +0100, Kirill Marinushkin wrote:
>> DAC may be switched between differential and single-ended output.
> 
> Isn't this something that'd be better controlled by DT - it's usually
> going to be part of the board design?
> 

I agree with that. I implemented it as a switch, just because that's how other
codec drivers do. In such situations, I prefer to be aligned with already
existing code.

Indeed, it's more logical to implement such setup via DT. I will rewrite and
send it as patch v2.

Best Regards,
Kirill
