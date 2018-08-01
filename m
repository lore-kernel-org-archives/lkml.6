Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C44C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 14:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4555208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 14:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSBsCfE/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4555208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389647AbeHAQiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 12:38:06 -0400
Received: from mail-yb0-f178.google.com ([209.85.213.178]:37185 "EHLO
        mail-yb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389498AbeHAQiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 12:38:06 -0400
Received: by mail-yb0-f178.google.com with SMTP id r3-v6so7637151ybo.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 07:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ritjFSrfhyyLHDydrfrCpVSfVWEe6wG32VB3u/ugljo=;
        b=kSBsCfE/gxxxIrD08fssJNwc0eDWWymu226KhF9fWKVudMM03lYB6s8C2MYX2F3JRn
         gYkwFricLVasZPuuMJufxrXcuXmQEVk6zujAlX//FmbyfWMLOELr7IrPdMvWVl7Wi3o2
         bj4/xvti8yC2PFflB7MS7Vfw6pVveaZBzFy9hSdS62DMrHQgyU0orNkppkRsnriMtYh0
         bMHO8NkE5JOI/cMyzPjE7TmvS5bBxm3CLbD+58mlolD6OYbWfUdndEPNDZHLDehQ7XD/
         GchJy9f501B3UsrFjzanZRwToxcoUYs+h9uux/Xr29ZoX7UzKMKDw8+ZofMGgBTeguuq
         gtgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ritjFSrfhyyLHDydrfrCpVSfVWEe6wG32VB3u/ugljo=;
        b=BWQUP/v1g/zLoYu+pUgiGjKf8Qm337yA8jD0Tc/b+WLGYnarNLaUHJCUBYGzKY3Hc/
         ZbVvdmOR5An2Qxv+VcFPTPZuwhkKR5b3jjVOHwU+rCEjh3kyE/OSRUPF4izESPl/dtBg
         gbWbSbcmUtoZ0PGp+WUXXH9ObV1GHgyZFaphIqjoA4pVR3gMngpFLNlS1ohKR0/J+rKw
         l8aSQAlAEcq52Dj5UkYKQPNWnO4//INBSg4AylvsLLfyRk9BkQqWLQpRXH3KaIRrvkbT
         A2A4ZnI2PqBX/Upi3Qu0qqZmOgQFLetOtC8HoaAL5sA4r5rK0EPCOpTZ5YB3TyoI1D0W
         HRGA==
X-Gm-Message-State: AOUpUlHA6yXE90DXTWSSEqQjEL7nd5y49a+F1kM95Xp0n0o7sOkX8vtU
        XxWS4ii4dAWbmV8Y9WEORpLEDDGDJFOZhkna7K0=
X-Google-Smtp-Source: AAOMgpfiU5VZc7n4Lp67Wh+EAk5EQxGTcAmISQHTqBuMPneQU9/f8aQS8hLWTZJBiI+P2QpblBIc5rFkaWN+rpyASBs=
X-Received: by 2002:a25:2d44:: with SMTP id s4-v6mr13825467ybe.284.1533135120664;
 Wed, 01 Aug 2018 07:52:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a81:3007:0:0:0:0:0 with HTTP; Wed, 1 Aug 2018 07:52:00 -0700 (PDT)
In-Reply-To: <CAAJw_ZtZ8hXi_B6+duiQYpaeSsQ7BQD-KwtE3H6K8Y8O8pAuig@mail.gmail.com>
References: <CAAJw_ZuQXrYaEu9_pXWtoDpUjR2au1gGT_FP9F1e1Y7veHSz2Q@mail.gmail.com>
 <CACVXFVPpSJDqR8ki2PiDBbU36KsGFMYsOEf_9bmN6Cpo3w_YoQ@mail.gmail.com> <CAAJw_ZtZ8hXi_B6+duiQYpaeSsQ7BQD-KwtE3H6K8Y8O8pAuig@mail.gmail.com>
From:   Jeff Chua <jeff.chua.linux@gmail.com>
Date:   Wed, 1 Aug 2018 22:52:00 +0800
Message-ID: <CAAJw_Zvaw8yoyejg5T6CtRFjoS4i_EBYKRVWocpH+mpwfaVC1Q@mail.gmail.com>
Subject: Re: How to secure erase PCI-E NVME SSD connected via USB3?
To:     Ming Lei <tom.leiming@gmail.com>
Cc:     lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 1, 2018 at 1:02 PM, Jeff Chua <jeff.chua.linux@gmail.com> wrote:
> On Tue, Jul 31, 2018 at 7:07 PM, Ming Lei <tom.leiming@gmail.com> wrote:
>> On Sun, Jul 29, 2018 at 5:09 PM, Jeff Chua <jeff.chua.linux@gmail.com> wrote:
>>> I'm testing the USB3-to-PCI-E NVME SSD. It's works using uas module,
>>> recognized it as /dev/sda.
>>>
>>> Since it's an USB device, the nvme-cli tools won't work, nor does
>>> hdparm, as it's a NVME SSD.
>>>
>>> So, how to secure-erase the NVME SSD connected via the JMS583 chip?
>>
>> You may try 'blkdiscard --secure' and see if you are luck.
>
> Interesting, will try that.

# blkdiscard --secure /dev/sda
blkdiscard: /dev/sda: BLKSECDISCARD ioctl failed: Operation not supported

# hdparm --user-master u --security-erase p /dev/sda
(returns immediately and does nothing).

I've tried hdparm on an SSD connected via USB3 and it secure-erased ok.

Anyone working on this?

Thanks,
Jeff
