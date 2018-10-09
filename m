Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA535C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 03:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72F812077C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 03:41:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72F812077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbeJIK4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 06:56:07 -0400
Received: from mail-pl1-f175.google.com ([209.85.214.175]:42545 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbeJIK4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 06:56:07 -0400
Received: by mail-pl1-f175.google.com with SMTP id c8-v6so101473plo.9;
        Mon, 08 Oct 2018 20:41:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VhikbRY3bKYlUH6yPCnd0E+YjCAKnRG2AnkcWf+/EOA=;
        b=eypgD6ndQUWangkhy3tMhpA6f9ly0J59UsfsyzWkcWKrvxL9H/1Pt8sN1YrH4iXjPA
         BLmtoo5AydC1LeKQQeiNnS03d1uRvLVuiyHAeOZaGIghJ1aKhoYsznpF3TSTWlVKcGA+
         ZWyXJBzBVHZEOnC+X4b4TEnKoy8DnKdTFOStpwXIN3Nj2BW9O8khLofGiR+2JO6AZvmR
         3EfvnSq+2NOXGhneN/V3/LjsY+Bx6bR4X+eCVveB4sLC+zwNxokUn9nc5dFdzFHnAO5v
         LzAilVAdOptj7lz4qtFCv3ZkPHdO1qjeg2KUFlTvHK4MVTuVeVQG+HnifpQEW1W6Y1c2
         KeRA==
X-Gm-Message-State: ABuFfoi5b3/OOvvo34ttZ5iqxrCjnx4pQQIQ7GNtoHogzeBHhwgpuCTo
        9K6nlnqGocxvr6Kj7/ntbsk1iR+0ujs=
X-Google-Smtp-Source: ACcGV617rUSk3j/NGWp/0YWScQ/DCy7eXLEMQMGk080y+S8z9ymjBKUmbQg8FeUgRWpC6wHbX8hvrQ==
X-Received: by 2002:a17:902:8c84:: with SMTP id t4-v6mr27064344plo.188.1539056477316;
        Mon, 08 Oct 2018 20:41:17 -0700 (PDT)
Received: from asus.site ([2601:647:4601:42b4:3842:3e31:3bb6:cf62])
        by smtp.gmail.com with ESMTPSA id r1-v6sm34066467pgo.81.2018.10.08.20.41.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 20:41:16 -0700 (PDT)
Subject: Re: [BUG] ext4 null pointer crash in linux-next
To:     valdis.kletnieks@vt.edu, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org
References: <36243.1539028475@turing-police.cc.vt.edu>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <839b29df-08af-403c-da3e-e1bc9eca1685@acm.org>
Date:   Mon, 8 Oct 2018 20:41:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <36243.1539028475@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/18 12:54 PM, valdis.kletnieks@vt.edu wrote:
> [  680.692915] RIP: 0010:__get_request+0x31/0x7e0

Can you provide the source code line number that corresponds to that 
address? If you haven't done this before: enter gdb 
${path_to_kernel_source_tree}/vmlinux in a shell and then run "list 
*(__get_request+0x31)" (without the double quotes).

Additionally, which block driver is being used in your setup under the 
ext4 filesystem?

Thanks,

Bart.

