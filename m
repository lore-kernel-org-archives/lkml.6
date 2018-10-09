Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24F9C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96E8B2087D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:15:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96E8B2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbeJIVcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 17:32:47 -0400
Received: from mail-pf1-f173.google.com ([209.85.210.173]:42180 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbeJIVcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 17:32:47 -0400
Received: by mail-pf1-f173.google.com with SMTP id f26-v6so908587pfn.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 07:15:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DllrrJvfSrvoX/LM9Br5BLksqMz1X+Zbrw1FVmbykwY=;
        b=YzvDAMzwQzBKrKOd7dif1YmjWYxhrOMmNg8k0L0vr32nf2hmdaL2eqSA6jd4XGM/wa
         hWOuG9tjBlS2kxWwIKLe/bOPLbjOIMCQDjSUPIvvkZI5pz4VhUZXc9yqPPMpo7eeg+U2
         MIjav1YuxmhKx3KF2KcYy8/+xtgc2ZzG9jChD/LD+wCrZ4Q/3L2mfJCLOlhjNvtN80L/
         8jBDmD7XKckal7ys964eCgNYDz6qQPvvXLI+oqyktONuh+MHYf+TLYb7xjuCvRtLAotT
         WKyQsWqZvdOzYEOjjGnCug9PSyNMS8MNnUlQD8Wmy0Bq4mmuqlHeo3dfn+flO1ME+0Fm
         N0Uw==
X-Gm-Message-State: ABuFfojC2iJXIUnQxZ277pEmTqH7n6UtvRHpp+/TXUUyUBOphIcmRKqr
        cx1O10o171JT+Z+1+BGuS6CdlgoB
X-Google-Smtp-Source: ACcGV618RFD2+P7gKJpgWgKGrAWfyIeOf9zcXHGZg0qVucsn0xkJkl4odkaS19IoN+paM7Ijme535g==
X-Received: by 2002:a62:1d16:: with SMTP id d22-v6mr30664708pfd.159.1539094537083;
        Tue, 09 Oct 2018 07:15:37 -0700 (PDT)
Received: from ?IPv6:2405:6580:9660:3200:f4bc:2ef8:9cc1:3cac? ([2405:6580:9660:3200:f4bc:2ef8:9cc1:3cac])
        by smtp.gmail.com with ESMTPSA id 19-v6sm35945008pft.97.2018.10.09.07.15.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 07:15:36 -0700 (PDT)
Subject: Re: [PATCH 0/4] Various cleanup + Mic Fix
To:     Connor McAdams <conmanx360@gmail.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Alastair Bridgewater <alastair.bridgewater@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <1539027601-20910-1-git-send-email-conmanx360@gmail.com>
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
Message-ID: <2ded9b74-4140-c0b9-b628-42811284f403@sakamocchi.jp>
Date:   Tue, 9 Oct 2018 23:15:33 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1539027601-20910-1-git-send-email-conmanx360@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018年10月09日 04:39, Connor McAdams wrote:
> This patch set fixes the microphone inconsistency issue, which means
> the microphone now works all the time on all of the cards I've tested
> (ZxR, Z, AE-5), along with the input effects.
> 
> It also includes changes suggested by Takashi Sakamoto, I believe I did
> what he asked properly, but if I messed it up I'm sure you guys will
> let me know.
> 
> This should finish up most of the ca0132 work, with all inputs and
> outputs working on the desktop cards.
> 
> Connor McAdams (4):
>    ALSA: hda/ca0132 - Fix microphone inconsistency issues
>    ALSA: hda/ca0132 - Clean up patch_ca0132()
>    ALSA: hda/ca0132 - Add error checking in ca0132_build_controls()
>    ALSA: hda/ca0132 - Fix input effect controls for desktop cards
> 
>   sound/pci/hda/patch_ca0132.c | 75 +++++++++++++++++++++++++++++++-------------
>   1 file changed, 54 insertions(+), 21 deletions(-)

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>


Thanks

Takashi Sakamoto
