Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765F5C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 06:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44A192084A
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 06:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbfBCG2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 01:28:51 -0500
Received: from zimbra.cs.ucla.edu ([131.179.128.68]:38472 "EHLO
        zimbra.cs.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbfBCG2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 01:28:51 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.cs.ucla.edu (Postfix) with ESMTP id C70861611BE;
        Sat,  2 Feb 2019 22:28:50 -0800 (PST)
Received: from zimbra.cs.ucla.edu ([127.0.0.1])
        by localhost (zimbra.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id g065fdssKUeO; Sat,  2 Feb 2019 22:28:50 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.cs.ucla.edu (Postfix) with ESMTP id 18A3B1611C0;
        Sat,  2 Feb 2019 22:28:50 -0800 (PST)
X-Virus-Scanned: amavisd-new at zimbra.cs.ucla.edu
Received: from zimbra.cs.ucla.edu ([127.0.0.1])
        by localhost (zimbra.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id SDnYZL__BnGx; Sat,  2 Feb 2019 22:28:49 -0800 (PST)
Received: from [192.168.1.9] (cpe-23-242-74-103.socal.res.rr.com [23.242.74.103])
        by zimbra.cs.ucla.edu (Postfix) with ESMTPSA id C2CF116119F;
        Sat,  2 Feb 2019 22:28:49 -0800 (PST)
Subject: Re: 0e334db6bb4b1fd1e2d72c1f3d8f004313cd9f94 (posix-timers: Fix,
 division by zero bug). Problems with glibc.
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Alex Branham <alex.branham@gmail.com>, Alan Mackenzie <acm@muc.de>,
        Eli Zaretskii <eliz@gnu.org>, linux-kernel@vger.kernel.org,
        34235@debbugs.gnu.org
References: <17880b13-2fde-764d-a284-11cf0caf1cec@cs.ucla.edu>
 <alpine.DEB.2.21.1902021020020.8200@nanos.tec.linutronix.de>
From:   Paul Eggert <eggert@cs.ucla.edu>
Organization: UCLA Computer Science Department
Message-ID: <1682db6c-0e70-f4d2-ecc7-6dabbccdcccc@cs.ucla.edu>
Date:   Sat, 2 Feb 2019 22:28:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1902021020020.8200@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner wrote:
> Can you please verify whether the issue is fixed with 4.19.19?

It depends on what you mean by "verify". I looked at the Linux kernel source 
code and checked that the "posix-cpu-timers: Unbreak timer rearming" patch is in 
4.19.19 (but not 4.19.18) and in 4.20.6 (but not 4.20.5). I did not test Emacs's 
CPU profiler on these kernels, as I don't have them installed. I expect to 
upgrade soon to 4.20.6 (whenever Fedora 29 release does - 4.20.6 was submitted 
for testing a couple of days ago) and plan to give it a try then.
