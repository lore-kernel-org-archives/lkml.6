Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F5FC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EC2F213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:03:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EC2F213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729429AbeJAUla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 16:41:30 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43144 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729134AbeJAUla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 16:41:30 -0400
Received: by mail-pf1-f194.google.com with SMTP id p24-v6so780107pff.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 07:03:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BCHkYXeUMNKhZGewEKCcHkcQHD+titxc0aPt4EbpZlI=;
        b=plymWTCmRlNmENO46nq0RQqrpm3TjaViaD5egVs1AGVkuy6nvEm/gY8t1rM9hcS7dR
         A9zlRXh6YOlteV2q0S7JBRaK4Of1sNs3keJbP3FKyXg8VCIcze44w8J1eZ69LzcWaPPS
         nLTLOPxo2/jc9IlgaJTbZDtUaABX6t4IierjYidx4ZnFKIUToR6gyQX07Z8XJTjuIbED
         /+BdgAuMMT8Ztfr+NEityBGCL3N1VFjh1CuBHgDUpKbFtJ6p3AyX5PUCQOvQnLRwxdxV
         XKkNpq3RjbaacgycRjli76Ysu8RgYJhB8Dh6PiLy0vEOU7Zl5u9vBJOze+xSjG9NGpFi
         NRqA==
X-Gm-Message-State: ABuFfogjwZmvPrI4Rp5QG7/eNvBvFv5F5U5KxDlDYGEkuX4+V/E2XVjq
        w21sL8Jvfd7Yfl58u8sVvwl3lpou
X-Google-Smtp-Source: ACcGV60CgtK0tNT9iu5xEmCDnABFfWf6q+6uok9z6pCEsJiZCbvUKYb6+WjgvbFuJ43AJOf5jkp1lQ==
X-Received: by 2002:a62:d206:: with SMTP id c6-v6mr11669555pfg.8.1538402612324;
        Mon, 01 Oct 2018 07:03:32 -0700 (PDT)
Received: from ?IPv6:2405:6580:9660:3200:613c:58ba:28c:5ee9? ([2405:6580:9660:3200:613c:58ba:28c:5ee9])
        by smtp.gmail.com with ESMTPSA id g66-v6sm20448765pfk.39.2018.10.01.07.03.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 07:03:31 -0700 (PDT)
Subject: Re: [PATCH 00/11] Add ZxR support + bugfixes
To:     Connor McAdams <conmanx360@gmail.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Alastair Bridgewater <alastair.bridgewater@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <1538276607-30234-1-git-send-email-conmanx360@gmail.com>
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
Message-ID: <f6aa819a-3db4-e457-8856-ad2debc85947@sakamocchi.jp>
Date:   Mon, 1 Oct 2018 23:03:28 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1538276607-30234-1-git-send-email-conmanx360@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sep 30 2018 12:03, Connor McAdams wrote:
> This patch series adds support for the Sound Blaster ZxR, as well as a
> few bug fixes. This should be the last ca0132 based Creative card that
> needed support to be added.
> 
> Also, I did check to make sure each patch compiles properly this time,
> but you can check yourself just to be sure. :)
> 
> Connor McAdams (11):
>    ALSA: hda/ca0132 - Fix AE-5 control type
>    ALSA: hda/ca0132 - Fix surround sound with output effects
>    ALSA: hda/ca0132 - Add ZxR quirks + new quirk check function
>    ALSA: hda/ca0132 - Add ZxR pincfg
>    ALSA: hda/ca0132 - Add DBpro hda_codec_ops
>    ALSA: hda/ca0132 - Add ZxR init commands
>    ALSA: hda/ca0132 - Add ZxR DSP post-download commands
>    ALSA: hda/ca0132 - Add ZxR input/output select commands
>    ALSA: hda/ca0132 - Remove input select enum for ZxR
>    ALSA: hda/ca0132 - Add ZxR 600 ohm gain control
>    ALSA: hda/ca0132 - Add ZxR exit commands
> 
>   sound/pci/hda/patch_ca0132.c | 369 ++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 345 insertions(+), 24 deletions(-)

I reviewed the above patches and they looks good to be merged to
upstream.

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

I've already point some nitpickings but they can be solved
after merging them till next merge window.


Thanks

Takashi Sakamoto
