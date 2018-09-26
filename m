Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEEC7C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 00:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6740C21480
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 00:44:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6740C21480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vt.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbeIZGy6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 02:54:58 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:35920 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726265AbeIZGy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 02:54:58 -0400
Received: from mr4.cc.vt.edu (junk.cc.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id w8Q0imiv008433
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 20:44:48 -0400
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        by mr4.cc.vt.edu (8.14.7/8.14.7) with ESMTP id w8Q0ihZW006329
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 20:44:48 -0400
Received: by mail-qt1-f198.google.com with SMTP id d12-v6so10295433qtk.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 17:44:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=sIP7gHKEtexL5M9PPLcXiOIKvq5d5gduR2aNe9uHcJw=;
        b=tVHHKXA96hFlZ3/kP3oezAyZs2nprAO2CpOJIuhpNQ/Ip8wxSSNgACTwW3q1Z22ROi
         FLKm4ssByFeravux6aCVhz+RZxBMgRSOvJFD67Jgxhzu5ZLpPr+bsJicqLEBu2Bf7P32
         /OA11Sa/1cyM90y8M9ljuyaarX47e7M4V+QUU2piOU4il+0+Ahox5YfwMBd7WcLCuYHJ
         S9aVybIFMDv2IJIYnVAyaHIhng9btd8nLKI4phmHSZa981ZVyAB7HEj53c1MH0KQ9Ya4
         V6pyo1ulSvp+Siq2uNjXYKwfyChQwkwS2PkYFORsQrzy8QstUZWhxfaHPNbKQXb6oo5N
         ZXsA==
X-Gm-Message-State: ABuFfohn897NNM3RksiEiXHOUidGaq6+PcXDil9CEhpFAXDkk/AMQ5u6
        W7Kv2eG+H8CyaTawWp9Q7uWoBLFCVngKEXwsWAvjH1x6NgyMmZ8oouHRC+J6rbRuyv88+5i+YCy
        oseB+znldCQRGnrNYdkRoQywbZZH1wNc0vRE=
X-Received: by 2002:a37:5c81:: with SMTP id q123-v6mr2590070qkb.8.1537922682963;
        Tue, 25 Sep 2018 17:44:42 -0700 (PDT)
X-Google-Smtp-Source: ACcGV61/s2L5omAYt517lcfyTR66zlfZYK6aj33DzDwyrTwYL8Hq4cEggSrydnM/8LnLhIymEXAbXg==
X-Received: by 2002:a37:5c81:: with SMTP id q123-v6mr2590055qkb.8.1537922682768;
        Tue, 25 Sep 2018 17:44:42 -0700 (PDT)
Received: from ?IPv6:2601:5c0:c100:49da:1857:54ff:f889:7a68? ([2601:5c0:c100:49da:1857:54ff:f889:7a68])
        by smtp.gmail.com with ESMTPSA id q10-v6sm2117797qtp.7.2018.09.25.17.44.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 17:44:41 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: Leaking path for set_task_comm
From:   TongZhang <ztong@vt.edu>
In-Reply-To: <20180925183953.GI15710@uranus>
Date:   Tue, 25 Sep 2018 20:44:39 -0400
Cc:     adobriyan@gmail.com, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Wenbo Shen <shenwenbosmile@gmail.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <0CD63E6E-7512-4DD6-8858-4408416DC730@vt.edu>
References: <F7DFF547-5267-4EF3-8BF3-70DAF6C2A53A@vt.edu>
 <20180925183953.GI15710@uranus>
To:     Cyrill Gorcunov <gorcunov@gmail.com>
X-Mailer: Apple Mail (2.3445.100.39)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, this is exactly what I am saying.
A process can change its own name using prctl or /proc/self/comm.
prctl is protected by security_task_prctl, whereas /proc/self/comm is not protected by this LSM hook.

A system admin may expect to use security_task_prctl to block all attempt to change process name, however, it can still change name using /proc/self/comm.

> On Sep 25, 2018, at 2:39 PM, Cyrill Gorcunov <gorcunov@gmail.com> wrote:
> 
> On Tue, Sep 25, 2018 at 01:27:08PM -0400, Tong Zhang wrote:
>> Kernel Version: 4.18.5
>> 
>> Problem Description:
>> 
>> When using prctl(PR_SET_NAME) to set the thread name, it is checked by security_task_prctl.
>> 
>> We discovered a leaking path that can also use method implemented in 
>> fs/proc/base.c:1526 comm_write(), to do similar thing without asking LSM’s decision.
> 
> I don't understand how it is a problem. Could you please explain?
> procfs/comm is created with S_IRUGO|S_IWUSR permissions. So
> prctl and procfs are simply different interfaces.

