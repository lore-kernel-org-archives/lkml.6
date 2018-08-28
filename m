Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60DFC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A46F208B9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Ik6LwdHU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A46F208B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbeH1FEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 01:04:34 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:37741 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbeH1FEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 01:04:34 -0400
Received: by mail-it0-f68.google.com with SMTP id h20-v6so309382itf.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 18:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=M3ez6hCMhPojy3f9MIT2QuThBmSKud9oU0cbUmYzwcI=;
        b=Ik6LwdHUu7vHckH3oaBCw1tnT5A9t4uOMCEfW9v1xn/tNSwWgDp8d81NeCC5v8VOe3
         K5zZKlfjsuHY9ap/l+Bp+4b3Eu56/Cia7j50j7Da0Xagn8vyUMZQ1iPZXJczqq96UgCU
         Hk3vQH+4sdXs3+3eUEhZKaelvUF5J6GYwGz+w6xG33RbABWsHX2s0N2Qd4dDOq0Z2iOO
         Hlv4n0KgdGv+t4sAsZOvqgNc0SSz7tBVboTMnH19EYwuAg9u5wTJPghTPaXVjwnwyiMK
         9PyLZ35MRf/ISUNk2HvEVPPGew9+VG+UZ9hKqto+/3G7KVC+ZalvdeY6ojzwYI4YrKm4
         OzUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M3ez6hCMhPojy3f9MIT2QuThBmSKud9oU0cbUmYzwcI=;
        b=ec2LytaGJzh9PI6DZ+M6NCqilR46kOBi3M9akgHMppYyiS9GKEO4q8iNCVj4b+JsPw
         C+bLVOrH0/VitGtD7WxQ0afBuaEHElJ9Ol0SZX4nR1DmNd3F5bkcHC/JBgMsUeQAmprh
         7nRBLeNpdqcdibB5JKnHQQ0Iitr6wPiNjUP6J2UpYr6CaUR+8fTKCyK6x1cYOkbrmvHR
         5bC0RG+8Dip+sWwyEa3b9MILrwCTYskhC8CxlDA/e89vRg5FSkaI/2yUH/pim/wI3+o9
         eixkh9VRyEvwWoZKUfOuc+Yft8F2B6b8x/Vpi8zek+CC5iyO6Z35QWQRuDz2Kkr6MqRv
         YQ7w==
X-Gm-Message-State: APzg51Cq2ykw8U9MYVS/wBwqIkkAJP8ATK/eE93a9zDdo7WAg3PHYQLw
        9PA8Z1ag8zvuzFzwRGrzXe+o7CIHC98=
X-Google-Smtp-Source: ANB0VdY23vZ2rveKPhV3B+9lk0Qhoe0lX+26U9NQMiJ7TZRL2K0wBL3iDf7M/6dtfooBG1Jtyk6Wag==
X-Received: by 2002:a24:a20f:: with SMTP id j15-v6mr9080187itf.125.1535418926002;
        Mon, 27 Aug 2018 18:15:26 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.22.static.utbb.net. [107.191.0.22])
        by smtp.gmail.com with ESMTPSA id h123-v6sm331787itb.32.2018.08.27.18.15.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 18:15:24 -0700 (PDT)
Subject: Re: linux-next: new maintainer/tree for the libata tree?
To:     Stephen Rothwell <sfr@canb.auug.org.au>, Tejun Heo <tj@kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180828071944.02b13db4@canb.auug.org.au>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <27ef8afc-c490-5984-5a18-1ee5ce51d556@kernel.dk>
Date:   Mon, 27 Aug 2018 19:15:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180828071944.02b13db4@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/18 3:20 PM, Stephen Rothwell wrote:
> Hi Tejun, Jens,
> 
> I noticed the maintaership change - so what shuld I sues for linux-next,
> now?
> 
> I currently have
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git#for-next

I'll merge into my for-next branch on the block tree, I'm don't plan on
doing separate trees for this, just separate branches. And everything I
queue up for the next version will end up in my for-next branch.

-- 
Jens Axboe

