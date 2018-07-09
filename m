Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0C0C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D10562087C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEH1hE4p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D10562087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933118AbeGIMZ0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 08:25:26 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38003 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932571AbeGIMZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 08:25:25 -0400
Received: by mail-wm0-f66.google.com with SMTP id 69-v6so20423727wmf.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 05:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DeyZxOB98B4drqDW2Qo49EGQ3xCctT2Woeb3pbgffec=;
        b=SEH1hE4pYHdxGeZVi5QgRgtqxuCjRZiMuExSq/Xo8ei1T3m7Qo2EGFYnawuhpYc5nK
         XqOA4jB4eW4LOhAqSOrA4Tz5o0Fta/17QmAuId1v/is/9qCcJIJdz0pWPFq+9ZmreGIy
         MqvgEl+deTxJHFsM591Ae2C3SAMi6yPX2tUDG77FdW+81eCC+LkvpAn342lr+5Y8m8vR
         9eKqS7ULDhI3DIODhOD6sqtbCwvHHdhFSOj5w9fKo1I4hZ3NqELCkZx/gwzlGzNipnNT
         afYQqrtfs8JWZ0Qtnz/dDY56qaK2UIGKoRPI63iqxk052B2D5tqI7j0Dxgy7J3jsVUks
         jl4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=DeyZxOB98B4drqDW2Qo49EGQ3xCctT2Woeb3pbgffec=;
        b=rfin0Hh47oQ1wK0iOol9f47F0kHKNPbI2YT9vV9guSqn6/AWXC5QXMksHNCCp/NOI1
         bT3ySsyZig3+xiNovMHkPHbcLBRf8dbxB9oXNiy/DMaQOEjOGbBz3njbOJYTLlkk7y41
         yKw/heft7OU4omd2kpckiGfIfabXhbrGg3vEr2T1di31CalJ25l1e0I4RXANcgJan9er
         5+aIfFjkCPjQCHZSX0Wd71e7+9+wntmFrUSY57y7mRyk/vbcmbpb41lcLDw2AAs8Q2Bg
         qrvdgbFy64XZvqwr3vQLSM6pu4c034MKrqrv58sPUiwgcue77Fm86JMJFyelomfk+Mtk
         MBrw==
X-Gm-Message-State: APt69E19lLsZoDG2TeeHbGLU+vY+uagcZDJmKbeAA7eUVER9IbgjaixQ
        EvHwh7ffIWI2zYzIy0aNe+Y=
X-Google-Smtp-Source: AAOMgpfqA1IOeCe8HJ8lLMNpjLbawcTCCAqin3yo/akFm6xRqUxPcneR7rY0rG/1r9oeDSrG2IGf4Q==
X-Received: by 2002:a1c:b801:: with SMTP id i1-v6mr11667211wmf.30.1531139124178;
        Mon, 09 Jul 2018 05:25:24 -0700 (PDT)
Received: from [10.178.4.240] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id h2-v6sm6330620wmf.28.2018.07.09.05.25.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 05:25:23 -0700 (PDT)
Subject: Re: [GIT PULL 3/4] bcm2835-defconfig-next-2018-07-03
To:     Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        bcm-kernel-feedback-list@broadcom.com
References: <20180703200511.2725-1-eric@anholt.net>
 <20180703200511.2725-3-eric@anholt.net>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <7da060e8-6726-ac0d-8fad-bcfa33abbe64@gmail.com>
Date:   Mon, 9 Jul 2018 05:25:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180703200511.2725-3-eric@anholt.net>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/03/2018 01:05 PM, Eric Anholt wrote:
> The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:
> 
>   Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
> 
> are available in the Git repository at:
> 
>   git://github.com/anholt/linux tags/bcm2835-defconfig-next-2018-07-03
> 
> for you to fetch changes up to 7b54aafff3ef4571567ff6a7d13ed51554f07a71:
> 
>   ARM: multi_v7_defconfig: Enable RPi voltage sensor (2018-06-21 17:29:51 -0700)
> 
> ----------------------------------------------------------------
> This pull request enables the new RPi HWMON driver in the 32-bit
> defconfigs.
> 
> ----------------------------------------------------------------

Merged, thanks Eric!
-- 
Florian
