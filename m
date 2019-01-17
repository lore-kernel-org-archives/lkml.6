Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEE5C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 05:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1D69205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 05:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbfAQFCu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 00:02:50 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:58521 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbfAQFCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 00:02:49 -0500
Received: from mail-pf1-f198.google.com ([209.85.210.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1gjzpG-0002Wh-S4
        for linux-kernel@vger.kernel.org; Thu, 17 Jan 2019 05:02:47 +0000
Received: by mail-pf1-f198.google.com with SMTP id x67so6481776pfk.16
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 21:02:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=MM5RWvNjsypXprGf4euM8vZ9+a0uwkXjiHilGsps0PY=;
        b=BX/sIOlye2NKQmrn4GFb0UVDlRxFpfK9X90/YdcLKcrBVPDcRpDr3FsSBMkpexn+Xj
         LIb95YX5HZHx7mqSaHsaU/8JkyhYKZ9LDETWEYssLElBEc5aHgdIrCCGy+5HaQOLvBur
         rUIXzI1FNDsLrhq6VoddffgExwiJnXKMlawTn17OT7GRibglqEk16Wns9nbES3Tzgfzf
         Jf1mSPd4onjFW8fFRGiZsVJUuj28QEmvTM3cFJnmJf1R/FLwmfNZSHRfO70jt64uuCqy
         idhO87/r7HYSqk4oTIfZjpqr3Gm1ClWMkxBzNIjVItPETPGQCBjpoJykTrTM4so4rac+
         9SdA==
X-Gm-Message-State: AJcUukcJyG9RXQnUYMDOpVSjubbHA4Qs6hMYnfs86zVgpDEayPGQaOQy
        8ETBbSvrBLVJOmFBozZQjfVL+nUU+Ta89MsvrXQBRLiaXdCMGRSGWjqpYkRP7NFP0uSdkaIj7zZ
        rjmjxWhf187dIkbB2zEicsctSTnjxpsL9BH6/0GSP1w==
X-Received: by 2002:aa7:83c6:: with SMTP id j6mr13495356pfn.91.1547701365255;
        Wed, 16 Jan 2019 21:02:45 -0800 (PST)
X-Google-Smtp-Source: ALg8bN511xLazrnU1fPV1LtKxk01aKVlEmOEsUNv47KCETYSQ0fmAJj96KXWj8gTQ0UHRA9ov4pBNQ==
X-Received: by 2002:aa7:83c6:: with SMTP id j6mr13495327pfn.91.1547701364802;
        Wed, 16 Jan 2019 21:02:44 -0800 (PST)
Received: from 2001-b011-380f-13aa-ed95-5ef5-fa2b-0d58.dynamic-ip6.hinet.net (2001-b011-380f-13aa-ed95-5ef5-fa2b-0d58.dynamic-ip6.hinet.net. [2001:b011:380f:13aa:ed95:5ef5:fa2b:d58])
        by smtp.gmail.com with ESMTPSA id n73sm738449pfj.148.2019.01.16.21.02.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 21:02:44 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] HID: i2c-hid: Disable runtime PM on Goodix touchpad
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <663EE74C-02E8-49DB-A197-2022AFE2D863@canonical.com>
Date:   Thu, 17 Jan 2019 13:02:42 +0800
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <2149AEF5-ABBF-4745-89F9-7FF9719251B5@canonical.com>
References: <20190114084734.3362-1-kai.heng.feng@canonical.com>
 <nycvar.YFH.7.76.1901141217550.6626@cbobk.fhfr.pm>
 <663EE74C-02E8-49DB-A197-2022AFE2D863@canonical.com>
To:     Jiri Kosina <jikos@kernel.org>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 16, 2019, at 16:21, Kai Heng Feng <kai.heng.feng@canonical.com> wrote:
> 
> 
> 
>> On Jan 14, 2019, at 19:18, Jiri Kosina <jikos@kernel.org> wrote:
>> 
>> On Mon, 14 Jan 2019, Kai-Heng Feng wrote:
>> 
>>> A Goodix touchpad doesn't work. Touching the touchpad can trigger IRQ
>>> but there's no input event from HID subsystem.
>>> 
>>> Turns out it reports some invalid data:
>>> [   22.136630] i2c_hid i2c-DELL091F:00: input: 0b 00 01 00 00 00 00 00 00 00 00
>>> 
>>> After some trial and error, it's another device that doesn't work well
>>> with ON/SLEEP commands. Disable runtime PM to fix the issue.
>> 
>> Thanks, I've now applied the patch to for-5.0/upstream-fixes. I am 
>> wondering though we are we seeing these at all - do other OSes not do the 
>> runtime PM on i2c at all?
> 
> According to the vendor, Windows does use ON/SLEEP, but infrequently.
> 
> We can use pm_runtime_use_autosuspend() to reduce the frequency of
> ON/SLEEP commands, but it’s just papering over the touchpad firmware
> bug.

Goodix says the firmware needs at least 60ms to fully respond ON and
SLEEP command.

I’ll see if an 200ms autosuspend can solve all Goodix, LG and Raydium
touchpanels.

Kai-Heng

> 
> Kai-Heng
> 
>> 
>> -- 
>> Jiri Kosina
>> SUSE Labs

