Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752343AbeBFIiD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 03:38:03 -0500
Received: from vulcan.natalenko.name ([104.207.131.136]:43192 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751835AbeBFIhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 03:37:54 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 vulcan.natalenko.name E8DF92E595B
Authentication-Results: vulcan.natalenko.name; dmarc=fail (p=none dis=none) header.from=natalenko.name
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 06 Feb 2018 09:37:52 +0100
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Mike Galbraith <efault@gmx.de>
Cc: Paolo Valente <paolo.valente@linaro.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, broonie@kernel.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, alban.browaeys@gmail.com,
        ming.lei@redhat.com, ivan@ludios.org, 169364@studenti.unimore.it,
        Serena Ziviani <ziviani.serena@gmail.com>
Subject: Re: [PATCH BUGFIX 1/1] block, bfq: add requeue-request hook
In-Reply-To: <1517903761.9843.12.camel@gmx.de>
References: <20180205190510.5499-1-paolo.valente@linaro.org>
 <20180205190510.5499-2-paolo.valente@linaro.org>
 <ee76e49c0d1ceab07c20e9d27e2fdc46@natalenko.name>
 <1517903761.9843.12.camel@gmx.de>
Message-ID: <34a0aa9dead3a082615899b2830f60f1@natalenko.name>
User-Agent: Roundcube Webmail/1.3.3
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=arc-20170712; t=1517906273;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:content-transfer-encoding:in-reply-to:references;
        bh=DS1yzaNWEXIeXIAQMKBdmxokxpQy1g0dY2lYmXdTRBI=;
        b=ZEIToC7t91kRCSU+ZJLSf5DoxKvmg87GybjMM/vDWXQJ2wB1wlrQa56VrMONX85pY+hphU
        fVi/OVU9EAGRUMa2tD860mw+fqaT/5N6Qy9YxrXf2JoQR4Y+TAG7jHoyr6wQBdCDIAG7gb
        dsK2iHpIk3Dooex31axjigIh4xFCwLY=
ARC-Seal: i=1; s=arc-20170712; d=natalenko.name; t=1517906273; a=rsa-sha256;
        cv=none;
        b=v71L+sHK1UtdVXsC+6aoAr7d7E5eF3i/62dD3IihRo8emyyvO8RgIdJ7PMH//6oCwqGVbpEY+a0W/3+uMBqfO6Cc3ITdXnqHelzbb0MSBO7Tz7gsxezDtPjndU6X8rNM/BV6vsQ4kkJvyU+uE2n84Aa9E1Ctby5hbvRFsD9C3ak=
ARC-Authentication-Results: i=1; auth=pass smtp.auth=oleksandr@natalenko.name
        smtp.mailfrom=oleksandr@natalenko.name
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

06.02.2018 08:56, Mike Galbraith wrote:
> I was doing kbuilds, and it blew up on me twice.  Switching back to cfq
> seemed to confirm it was indeed the patch causing trouble, but that's
> by no means a certainty.

Just to note, I was using v4.15.1, not the latest git HEAD. Are you able 
to reproduce it on the stable kernel? Also, assuming this issue might be 
unrelated to the BFQ itself, did you manage to reproduce the trouble 
with another blk-mq scheduler (not CFQ, but mq-deadline/Kyber)?

Regards,
   Oleksandr
