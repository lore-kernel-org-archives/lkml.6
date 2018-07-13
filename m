Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D79ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 13:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7EC3208A4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 13:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="GCjzAIsU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tDcr83Mc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7EC3208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729725AbeGMNgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 09:36:37 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:49303 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729284AbeGMNgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 09:36:36 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 08D1B22164;
        Fri, 13 Jul 2018 09:21:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 13 Jul 2018 09:21:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=6idyi7eeKErLkQGmoKy1dOB6qNOlUSCEAHRN5FQYFcM=; b=GCjzAIsU
        CzRVDZEf4+31bNktztBa8oXxZo66G236wYA8DooUK6FYrXe8QXql5GNG6SjzGcpy
        VU29FnsUAyC0SAVTw4mAIz34MGh+ldQ0Za4Kst0UulxV+V+2pnR+PKQERy8LWkup
        2y6P1vYGEM2j3ggMTzyDOLgaxclL2TebpB+ilUuxR4ElCtOc9ArE2MYEgKfb7Kn/
        SO1IRNurBoukH/D4mkpfx7u2VbaygHeK6u/9gYWFRtTGsoxulo2A2sL4gd/CQsTy
        3sWUv+8B3PWS5Yn/p8nGS8kAi92dSDJ2uYwUT122tAvhwWVYjZ/UhkKeewjY1wsT
        feavmrlTrUkNOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=6idyi7eeKErLkQGmoKy1dOB6qNOlU
        SCEAHRN5FQYFcM=; b=tDcr83Mc04gQ4i85uTGpZo7LkwKyxP+Cr8J3NTMRjRcHA
        2PKTliLuQblM5P6GGCuFZkZv/WGNmBDgo0x9BcDwbdHpy7h3Qu+YL4YwW0FW5ICx
        xzkStiwAIl6tcVlsHQytG88LkmYmyVsgtrS4PvMq0cVsyOE6V2sPddslu1yG5Pkj
        xZN0WPjokML/Hq2Ed8KhgiQsl1UAHjzfBOZEOJ6ld5PpejxbG0B+qbxh1IQnwZCw
        B5YOhJflOjBLO1Lqye1iuNogvu8shLb98QPT3uKAs/TD+3BU3OcqTwpOtqhOAXjq
        7016keoXtlHtP50v1TJasWe+d0c0npgL0Hke6VbtA==
X-ME-Proxy: <xmx:dadIWy9VxnnyRvOARlZWpPxv1WbMo4MHO7LGTWFwNwYJN6c5FNW9hQ>
    <xmx:dadIWy51l4eyEhamAFO08Ou9bJeINeC8KTjarFJfAb_-I8z-XfUl3Q>
    <xmx:dadIW52BBuGSAkcEMvDme2-cc5mXoPWOHhumfatMjJnIvdhjG2hn8A>
    <xmx:dadIW5C7ujS8L4nZYPW5JL4YuN1IdGwttEBNQZsnTAr-ncXbmDEj9g>
    <xmx:dadIW70nXZ6UH1k4K9IJmy0CXMa9LNYQ-ASkNJCx-hy2NH3Rwe2IHA>
    <xmx:dadIWz30zSMQGXmdvntdcs2RNXSLsbHMccwSN3v5ewxie_X-VnnoKQ>
X-ME-Sender: <xms:dadIW6qexoJpzFOhiMkq4lFIxOUFwi61e43bWyQFAMeCQCvUWghD0w>
Received: from localhost (lfbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.messagingengine.com (Postfix) with ESMTPA id 49508E4B23;
        Fri, 13 Jul 2018 09:21:57 -0400 (EDT)
Date:   Fri, 13 Jul 2018 15:21:56 +0200
From:   Greg KH <greg@kroah.com>
To:     Tomasz Kramkowski <tk@the-tk.com>
Cc:     stable@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Patch to consider for stable 3.18, 4.4 and 4.9
Message-ID: <20180713132156.GD21619@kroah.com>
References: <20180305204341.GB4897@gaia.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180305204341.GB4897@gaia.local>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2018 at 08:43:41PM +0000, Tomasz Kramkowski wrote:
> In September last year, Ben Hutchings submitted commit [9547837bdccb]
> for 3.16.48-rc1 and I informed him that it would be useless without
> [3f3752705dbd] (and that maybe [c3883fe06488] would be useful as well).
> Ben dropped the patch but suggested I email this list with the
> information of the other two patches but I never quite got around to it.
> 
> Now I see Sasha Levin is submitting [3f3752705dbd] and [c3883fe06488]
> for 4.9, 4.4 and 3.18 it would now make sense to include [9547837bdccb].
> This patch fixes a minor problem where a certain USB adapter for Sega
> Genesis controllers appears as one input device when it has two ports
> for two controllers. I imagine some users of emulator distributions
> might use stable kernels and might benefit from this fix.
> 
> I'm actually not entirely sure that patch is something suitable for
> stable but since it was already submitted once then I don't think it
> hurts to bring it up again (despite it breaking stable-kernel-rules as
> far as I understand it).
> 
> Commits mentioned:
> [9547837bdccb]: HID: usbhid: add quirk for innomedia INNEX GENESIS/ATARI adapter
> [3f3752705dbd]: HID: reject input outside logical range only if null state is set
> [c3883fe06488]: HID: clamp input to logical range if no null state
> 
> If the patch [9547837bdccb] is not relevant then feel free to ignore
> this email.

Sorry for the long delay, now queued up.

greg k-h
