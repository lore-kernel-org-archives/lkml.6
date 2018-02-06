Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752326AbeBFHpG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 02:45:06 -0500
Received: from vulcan.natalenko.name ([104.207.131.136]:40908 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751924AbeBFHpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 02:45:00 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 vulcan.natalenko.name 167192E5874
Authentication-Results: vulcan.natalenko.name; dmarc=fail (p=none dis=none) header.from=natalenko.name
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 06 Feb 2018 08:44:57 +0100
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
        broonie@kernel.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, alban.browaeys@gmail.com,
        ming.lei@redhat.com, ivan@ludios.org, 169364@studenti.unimore.it,
        Serena Ziviani <ziviani.serena@gmail.com>, efault@gmx.de
Subject: Re: [PATCH BUGFIX 1/1] block, bfq: add requeue-request hook
In-Reply-To: <20180205190510.5499-2-paolo.valente@linaro.org>
References: <20180205190510.5499-1-paolo.valente@linaro.org>
 <20180205190510.5499-2-paolo.valente@linaro.org>
Message-ID: <ee76e49c0d1ceab07c20e9d27e2fdc46@natalenko.name>
User-Agent: Roundcube Webmail/1.3.3
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=arc-20170712; t=1517903098;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:content-transfer-encoding:in-reply-to:references;
        bh=qZv/tiETLZiFLv+4JU3fHpW/0QdahVx4mOgT73OxIBc=;
        b=bQml+ByEVXuYygrmT7REMo1K/CHr0v5O1c9PpmbE0qfHSFT60Y7OAVVTB7eUUx7b+Oaxd2
        CHPfrje2zvNzOnBrE5Tg0nnyddFVae6A9HGaFFOQMK+ZjWKlU/isoBWKZbYFo2NucaCXMu
        vIc0wP+ae/q2/lUllm6KDTZ24Z3dfiQ=
ARC-Seal: i=1; s=arc-20170712; d=natalenko.name; t=1517903098; a=rsa-sha256;
        cv=none;
        b=OrQGn0BUsQnk734frANXn6mNi1f9yA1hRUgYIfmF2tq+TWyqCMIVO3M+u/x4XMCW/1bBdwUUf1OEHTS5obW39c/Gx4aO9KEkwexKOE307GgwSN50NuTb/O+0qel7WFlX1BlvEK+xIHhB/z3oivInTcdADFmtFXJHmaBF7/Qf008=
ARC-Authentication-Results: i=1; auth=pass smtp.auth=oleksandr@natalenko.name
        smtp.mailfrom=oleksandr@natalenko.name
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Paolo.

I can confirm that this patch fixes cfdisk hang for me. I've also tried 
to trigger the issue Mike has encountered, but with no luck (maybe, I 
wasn't insistent enough, just was doing dd on usb-storage device in the 
VM).

So, with regard to cfdisk hang on usb-storage:

Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>

Thank you.
