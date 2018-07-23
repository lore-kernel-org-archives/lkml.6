Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E53FECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 06:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15A7520846
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 06:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BPMb/wNT";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WZ04VA9T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15A7520846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387877AbeGWHPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 03:15:55 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58688 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728230AbeGWHPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 03:15:55 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 58D9E6074D; Mon, 23 Jul 2018 06:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532326580;
        bh=EqBKv756JkV/O/QWgaRNJduC+LWGjAUhwgDMCK4fsNA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BPMb/wNTHnpwRCVNj9j5LqKIi4UaOhlrDnuUPMVrttyRF/FOx33utSNdQuXzQrgUR
         fLrL9rC26xhDiPdU0Y5akh/+ZhmFG/SSO3U+iViO3MK0l0NF2IjLteyk1BpCTJvtcG
         HoN9coJaaG+2QHzPsFSEOPrkz7uvJRxNYA65THm4=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 95895602D7;
        Mon, 23 Jul 2018 06:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532326579;
        bh=EqBKv756JkV/O/QWgaRNJduC+LWGjAUhwgDMCK4fsNA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WZ04VA9TjM2u5SM20ya5SOG1KaRIPtqNa51rwfSkhu8Fp2uozK4PPU5U7ODrnQOaP
         pgI8+Nw+KvtNdWAx+IgfT7/DttOZDnVZSXt0Vq+YRMbje4DSPIWiHCyZAozZzhjq1q
         paORsCXyQzDNAKH5DTQmR8bYdqt8BGRxavQgE69E=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 23 Jul 2018 11:46:19 +0530
From:   kgunda@codeaurora.org
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        bjorn.andersson@linaro.org, jingoohan1@gmail.com,
        lee.jones@linaro.org, b.zolnierkie@samsung.com,
        dri-devel@lists.freedesktop.org, jacek.anaszewski@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH V4 6/8] backlight: qcom-wled: Add support for WLED4
 peripheral
In-Reply-To: <20180720212128.GA13883@amd>
References: <1531131741-19971-1-git-send-email-kgunda@codeaurora.org>
 <1531131741-19971-7-git-send-email-kgunda@codeaurora.org>
 <e5bdf2fe-321a-f2e5-22f5-c886f019ac1a@linaro.org>
 <20180720212128.GA13883@amd>
Message-ID: <038029fded9ee724097685a3f0e8bdf9@codeaurora.org>
X-Sender: kgunda@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-21 02:51, Pavel Machek wrote:
> Hi!
> 
>> >@@ -332,6 +529,7 @@ static u32 wled_values(const struct wled_var_cfg *cfg, u32 idx)
>> >  }
>> >  #define	WLED3	3
>> >+#define	WLED4	4
>> 
>> Are these macros always going to define 3 to be 3 and 4 to be 4. If so 
>> we
>> probably don't need them (and they should be removed from patch 5/8 
>> too).
>> 
>> There is a degree of nitpicking here however. The rest looks OK to me.
> 
> Really nitpicking, and I don't care much either way, but as natural
> numbering would be 0-based, I'd keep the defines.
> 									Pavel
Thanks Pavale/Daniel! I will remove the macros and use the number 3 and 
4 instead.
