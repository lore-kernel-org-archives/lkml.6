Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB504C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 08:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 516E8208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 08:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="Wu9CUNkA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 516E8208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729998AbeGaKEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 06:04:02 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44409 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728227AbeGaKEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 06:04:02 -0400
Received: by mail-lj1-f196.google.com with SMTP id q127-v6so12910860ljq.11
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 01:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CZ0/7b6Y03FEqWT3QOQCjF0sgHc9IgbDo6kMjrPVFuU=;
        b=Wu9CUNkA4vecQ8QYaS0eqbw3+oFtxlMkfFUmobR1E4abJnBBUtxyTVN47LuGDqRxCk
         gPDskleCBCM0fyNpSP2U6txXcI0gr/ZX50mAezLWvGOcOOgxHUgd/5FFG9eA78BTLx+f
         6S8gbDAx7Ais90PsE8FjH6q4rnAGPZkQUsRtrQ38Uz+NkJUwEIfYALy9OFI+I5hmAvld
         eh9f9qJWylkOSoxD3QDjv79qmE7pz4hjuxNX1d1nYvMdHBWS4qnqYJl0M+s1x4fyWNvH
         ddk7t9Spl6E1WDCeTrYxO5wOVDisx7gyn4olztBG6MaUlXvNiDfepTa4ryqPdzKEaFdp
         50Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CZ0/7b6Y03FEqWT3QOQCjF0sgHc9IgbDo6kMjrPVFuU=;
        b=PWUOaVwes4Agl24QosarTYXSm3v7VC72lkskLeFAgsynY/XVHPM5Ds5tB9i31NqS3C
         qMRgU5o3JzE/GZ+mJAuTR6yCDu1XcFFgAv+nYsOXK232SyN9yqab4dcrjqdaspkc1BL3
         E5S1CvZxU4wg6AUKq3n3SHpsOgvFWE6RIlcxVN0YICc2TG+l7wT2+7ikTyR3e7LFUQo+
         Qqw/3itZZhgjBcN2EDa48FwOofW+SEiqXTVtzu+t6tKhzpjf2qHHHun7Jr5/VyXL45Kp
         UER0gEZZk9w9JnCHL1SvsmKqg4KCrdFh3FzqeGPHcPnuSY1S7UTQfk/PytLtSDEhFb0x
         STPA==
X-Gm-Message-State: AOUpUlHxgn1uBWB9pKqBESRSVSEvDvNjzeknVNsfvReBdBe/Q2CAKj24
        nhqQHXcicFRZoJI2tO/ySQwba59d0as=
X-Google-Smtp-Source: AAOMgpczj6TB+dUBdn4SYEOFWyEGclexxcybTo4xlxnTTsKGfPwePKFwTWl8MbXddpqi90juC4iDfw==
X-Received: by 2002:a2e:3313:: with SMTP id d19-v6mr7334000ljc.25.1533025490041;
        Tue, 31 Jul 2018 01:24:50 -0700 (PDT)
Received: from [192.168.0.126] ([31.173.82.83])
        by smtp.gmail.com with ESMTPSA id n19-v6sm2418873lja.87.2018.07.31.01.24.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 01:24:48 -0700 (PDT)
Subject: Re: [PATCH 2/3] drm: rcar-du: Rename var to a more precise name
To:     Jacopo Mondi <jacopo@jmondi.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>
Cc:     "open list:DRM DRIVERS FOR RENESAS" <dri-devel@lists.freedesktop.org>,
        "open list:DRM DRIVERS FOR RENESAS" 
        <linux-renesas-soc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
References: <1532971214-17962-1-git-send-email-jacopo@jmondi.org>
 <1532971214-17962-3-git-send-email-jacopo@jmondi.org>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <8104d980-f433-7fe8-d0d2-9028019332d9@cogentembedded.com>
Date:   Tue, 31 Jul 2018 11:24:48 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1532971214-17962-3-git-send-email-jacopo@jmondi.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 7/30/2018 8:20 PM, Jacopo Mondi wrote:

> Rename the 'value' variable, only used to for writing to DMSR register to a
                                          ^^ not needed

> more precise 'dmsr' name.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
[...]

MBR, Sergei
