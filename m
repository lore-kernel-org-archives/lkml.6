Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD28C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 07:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85C912531A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 07:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALbMDAVy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85C912531A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752614AbeFYHxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 03:53:43 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:36231 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751026AbeFYHxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 03:53:40 -0400
Received: by mail-io0-f172.google.com with SMTP id k3-v6so11638625iog.3;
        Mon, 25 Jun 2018 00:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=JhUGnw/n/asUcNs1+8L7S71YPf4qYXAT7adlL0Pd2uI=;
        b=ALbMDAVyF42qZXY4b0sy6ZqIPSTNbwZ3XGnMSvLD99/wLSWUkyds8MQYKXhXHcviBc
         hjtA+qOyTpHa3xdckuHyLxfCWtWCB3cyRhiNKEF4mOR9O6hD6FnrmKzL+Q8guN0gjYfE
         +Npb7NMEKLnk2nxymRDZLmVQRMb55icZgk2qm06qW74hTXnIV5Lx/UhoWzM0FNlt9UJV
         3ztq4XIP/3VKjlCF80tc2cRcEpZUcG0ws9KIlPcdJS+v0HALVxKnBvyDogHxIXAb1ApF
         KnxueErpwROEhRTvsVIIxHmvjw4Mi6o0rBDYp3PwakBMcUhrFr/kHXpdw/JbWYHd/nvi
         c0fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=JhUGnw/n/asUcNs1+8L7S71YPf4qYXAT7adlL0Pd2uI=;
        b=eE9tcQ7c9pO0B7w22I3rcb3btwPzzLsxLEj4CCAjiwYb/tPlc1iOqthmm5zFaHBKYD
         hbEqAURb/hcEGtpJ2XQ3UjtDBk1OeYeDsVjk0m40HBtPPyo5s+aSR0S5Pq3ldZtuSJ5g
         dqf2PYx2ArkbX/jKuMWB0vyxnDqdYZPPz75nNhq+LeAYYlW2WAH8y46foeuVq2ot7GsO
         vZs0bqVISn9er87wUoGxQQYrp3UuGp3Ys21A2Tg+2dnOvDLeNu4Gg2UaENo7WfcvM3uR
         x3WcudeSwB2SoUVWhlPixNkZ+ks6iyoDuMqeDXgKP5c02C8kuiN7xrVQ6USrRmLq8VXI
         DflQ==
X-Gm-Message-State: APt69E3sI8s2JFyCFMUM6KP8l1C9RV7H+yxfWM8miZh7sh3BRFPbEtqu
        Q6sf1FLUzLdNzu0cuszXBXU=
X-Google-Smtp-Source: AAOMgpdEZwtsWHB9TgaVY4lVEbvh65twBktS3jtgc3iaQnBbxKcdTtKPrWe7AqupDdHzg3tXrqrTjg==
X-Received: by 2002:a6b:b458:: with SMTP id d85-v6mr1108726iof.163.1529913219807;
        Mon, 25 Jun 2018 00:53:39 -0700 (PDT)
Received: from Schmitz-MBP.telecom (222-154-41-72-adsl.bb.spark.co.nz. [222.154.41.72])
        by smtp.googlemail.com with ESMTPSA id 62-v6sm3802143ity.37.2018.06.25.00.53.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 00:53:39 -0700 (PDT)
Subject: Re: moving affs + RDB partition support to staging? (was: Re: Moving
 unmaintained filesystems to staging)
To:     Martin Steigerwald <martin@lichtvoll.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Sterba <dsterba@suse.cz>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Joanne Dow <jdow@earthlink.net>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
References: <20180425154602.GA8546@bombadil.infradead.org>
 <CAMuHMdXt11A-3wZ2uhxF9WE-3+=VV-AbQhpXrkxnV_nwa+E4tA@mail.gmail.com>
 <CAOmrzkKunsjZzwpj9gtovKwXVkj1kTt81ea1zmB7BCDtZz409g@mail.gmail.com>
 <1910962.ItDVNtUG5Q@merkaba>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <2491cfa6-c227-9c91-6630-f56d86cd80e5@gmail.com>
Date:   Mon, 25 Jun 2018 19:53:32 +1200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1910962.ItDVNtUG5Q@merkaba>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

OK, I'll prepare a patch and submit it to linux-block for review. I'll
have to refer to your testing back in 2012 since all I can test is
whether the patch still allows partition tables on small disks to be
recognized at this time (unless Adrian has a 2 TB disk and a SATA-SCSI
bridge to test this properly on).

Cheers,

    Michael



Am 24.06.18 um 21:06 schrieb Martin Steigerwald:
> Hi.
>
> Michael Schmitz - 27.04.18, 04:11:
>> test results at https://bugzilla.kernel.org/show_bug.cgi?id=43511
>> indicate the RDB parser bug is fixed by the patch given there, so if
>> Martin now submits the patch, all should be well?
> Ok, better be honest than having anyone waiting for it:
>
> I do not care enough about this, in order to motivate myself preparing 
> the a patch from Joanne Dow´s fix.
>
> I am not even using my Amiga boxes anymore, not even the Sam440ep which 
> I still have in my apartment.
>
> So RDB support in Linux it remains broken for disks larger 2 TB, unless 
> someone else does.
>
> Thanks.

