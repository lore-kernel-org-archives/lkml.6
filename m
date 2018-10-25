Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B32ECDE44
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EBB220832
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBe0kMPC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EBB220832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbeJYJU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 05:20:59 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39620 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbeJYJU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 05:20:58 -0400
Received: by mail-pg1-f195.google.com with SMTP id r9-v6so3150054pgv.6;
        Wed, 24 Oct 2018 17:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2yQQ/UpVutFpSsN4aBskTRJumS1TQpFGU4Abbn7O30M=;
        b=KBe0kMPCIgqmDhWCtwVXPKx5umJOuS0up28HV42ut/1lacI6s3wbo7L3ZxDCHTH3hZ
         a1jOZ1f/SpJLDX6ljuDGBGFuzF8PdgRnfcqBOffS60uOFSeheQhvcppYoSNp20AekK4I
         b0SgCbFE0r0PP3o9boZW95mQJuMImGsu2zuzS1nwxP6at8C6dvQ2VvhRPatbaxfJzU+F
         hiufdPSYW+VJGemb4EEGSCASucvCi0ws175Lv4tNaNrK5s5gc3NaLSMtPMWi+IOZ6qkv
         FXMKEGcPWytg4GrIwV9ajwSIkdTp9tQL0A/Mx+fgNN6keHOnNK20f1w6wrjvGW41HCUS
         Y7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2yQQ/UpVutFpSsN4aBskTRJumS1TQpFGU4Abbn7O30M=;
        b=Qm5lu78m/3tCqHNMbhf7PmodQoTCg3LfBCEKuAUvuQJO9YkfYEL2vJJG+exQQ0M40j
         3lpZ07lNflrHlxjBDH41tA/nYBdy3rpyAF/jBX/V8vbRgbaUz/g//azcnbszH2nT9uER
         Q3auXO5ss0W3b8Vrg3F0pk8uBUVTD3sMse+mIjwdJe3X7ppqok6iWhfCsshFfRxZUDtf
         AyuFWP5yEnKkU0Nn4HvHWTQ5LJ7UfquGQB8klXa/P4PPN0FhXjWLSMYvq3gEzzaGSp0r
         Sia+TSWhQpTEssbpumBqTZwpSg52PQzJCuJlCYoWtLFEx4MN7JCbNXNloAD2claWBbqJ
         2WgA==
X-Gm-Message-State: AGRZ1gLo54lQvmPwmsanC6w73yNjQlm+8flzvYrqqeMpulrqj3fGf7CX
        WunJ3qREi4eay872Ca7XKGY=
X-Google-Smtp-Source: AJdET5ffzp7UcasBQVMhJNZ17YQFGQmwYAKvZxyv4oh4n/Q8Eqt1uXmnoWLN19K3y79oJxsg7jSkuw==
X-Received: by 2002:a63:1013:: with SMTP id f19-v6mr4660691pgl.38.1540428636745;
        Wed, 24 Oct 2018 17:50:36 -0700 (PDT)
Received: from [192.168.86.235] (c-67-180-167-114.hsd1.ca.comcast.net. [67.180.167.114])
        by smtp.gmail.com with ESMTPSA id b10-v6sm7523480pfe.148.2018.10.24.17.50.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 17:50:36 -0700 (PDT)
Subject: Re: [PATCH] Change judgment len position
To:     Joe Perches <joe@perches.com>, David Miller <davem@davemloft.net>
Cc:     w@1wt.eu, wanghaifine@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, fengguang.wu@intel.com, lkp@01.org
References: <61d94f2a5563db4d6580c8385c3b93c8eeb3669a.camel@perches.com>
 <20181024204852.GA25509@1wt.eu>
 <49ec92564284b5beb0a151bce1d537b51340d0a8.camel@perches.com>
 <20181024.170213.632063387857625082.davem@davemloft.net>
 <825268591809f66eb475c3b41c327809a304388f.camel@perches.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <203ed8b3-2744-44d2-78dc-6d463acfb977@gmail.com>
Date:   Wed, 24 Oct 2018 17:50:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <825268591809f66eb475c3b41c327809a304388f.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/24/2018 05:23 PM, Joe Perches wrote:
> 
> "You can't be serious?" is kind?

Context maybe ? As a non native, I do not see why it is an offense.

I would like very much we discuss about patches here, not about whatever
interpretation you or anyone could make from any answers.

Recipe for disaster in linux community :

1) Write a bot, sending one wrong patch every hour, with a random "From:" name
  and email address.

  Yeah, can you believe a bot can actually 'Signed-off-by:' a patch ???

2) Hundred of emails sent, from reviewers, annoyed maintainers, and flames
  because the proper words for newbies were not _carefully_ chosen.


So just wait for an answer from the supposed patch author, and see what happens next.

Thank you.
