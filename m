Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A564C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 05:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3A3F26696
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 05:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aleb5pKB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3A3F26696
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752642AbeF0FjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 01:39:25 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:38470 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750942AbeF0FjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 01:39:24 -0400
Received: by mail-pf0-f194.google.com with SMTP id j17-v6so460814pfn.5;
        Tue, 26 Jun 2018 22:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=6E+wHhx51pJJmdd94vw7QaSoXk3opVizm/j2hinYz1A=;
        b=Aleb5pKBQcEy/5smnypk4Re3Ur+rM5UhfH+cT0SqbFXuMX8N39Vhjbx/gp8aiG58xi
         GozoJ7A4N6dhsQ5eRr8zMKRUVz4viGIAZX3CH/ID5YCJgux2e16onb6Yt6djl1Tj3TzT
         l5tgLk/GVOWPL6UYRs643GdwWndP4yqI7thdngfm2gL9HKPcMcMhPYPErA9xPao61gi0
         p4fATWLdTaQRMyPN1XbuAhvUro4ACJKoictl303YvdXiYWJjijP8hzMo4t9iN/8hV/Ux
         O4qvypFxBVsAzXhqFx55f4BA3CcJDTo/QHzOZwepgUMpiQ7I8po9tUSzhMqHCvLMm03Z
         5yaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=6E+wHhx51pJJmdd94vw7QaSoXk3opVizm/j2hinYz1A=;
        b=Rx2dpZXdGM65JWErx7isJ0zqj4CHswqFMDioVXal5tuKyjZ/vDa7g+Z86NOUYuMxPm
         RbgK3KkB+SjyarlhvYXmmZAiNy8vy2MBu11g1DANvDWu9bQOFhhvM3Px7FsH+qrLW4i7
         DHUfJlRObxtC/trJTcSulaHWHg3doer789M6BMduv6xIxqe2XvpFrhP06emFtbqWnEOX
         7Icd9/Ogx3JxSgASKBjJtmjvDrzDN5dvkpxRywOQdd1QW1WVojTFydvX0xZfhOxf5U8F
         QBC09HHfrswpaIW3MDaBjeMcjMKI21rQ6mIR06mZQ4j9kDRL5IoO6gucM8HxTtuAyIP1
         Go+Q==
X-Gm-Message-State: APt69E0IL/6hxeaJPPimd2T/WFkZAymlOEffqNurYMjMAUWVF5gBbgit
        BjMBemYaLM88Jd/wSFV3k+jTXHR4
X-Google-Smtp-Source: ADUXVKLunhUQAi9HNoZV6sTx2bGjGZrNeka5qQgpsP4O3Mkh/YHSpOVEia+6Al1nf9XLS6KJFENcyQ==
X-Received: by 2002:a63:a543:: with SMTP id r3-v6mr3891316pgu.336.1530077963721;
        Tue, 26 Jun 2018 22:39:23 -0700 (PDT)
Received: from [192.168.1.101] (222-154-41-72-adsl.bb.spark.co.nz. [222.154.41.72])
        by smtp.gmail.com with ESMTPSA id o12-v6sm5333839pgs.52.2018.06.26.22.39.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 22:39:23 -0700 (PDT)
Subject: Re: [PATCH v3 00/12] macintosh: Resolve various PMU driver problems
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Finn Thain <fthain@telegraphics.com.au>, geert@linux-m68k.org
References: <cover.1528885172.git.fthain@telegraphics.com.au>
 <alpine.LNX.2.21.1806242119180.34@nippy.intranet>
 <874lhp6i4d.fsf@concordia.ellerman.id.au>
 <cacaecac00c1ac941a78da772bbcfb05142df87d.camel@kernel.crashing.org>
Cc:     linux-m68k@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <5d4d7ca4-1d2f-268f-e5d2-eddb213e894d@gmail.com>
Date:   Wed, 27 Jun 2018 17:39:15 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <cacaecac00c1ac941a78da772bbcfb05142df87d.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ben,

Am 27.06.2018 um 15:27 schrieb Benjamin Herrenschmidt:
> On Wed, 2018-06-27 at 13:08 +1000, Michael Ellerman wrote:
>>> I will rewrite patch 10/12 after Arnd's fixes and this series have all
>>> made their way through both powerpc and m68k trees, and submit it
>>> separately.
>>
>> drivers/macintosh is supposedly maintained by Ben, but I'm not sure this
>> series is high on his todo list.
>
> We need at least to pull out a couple of powerbooks we have sitting in
> drawers and try it out.

No need to root around in drawers - I'm sitting in front of one (G3 
Titanium) writing this. Let me know if that would help (I've forgotten 
most of what I knew about powerpc kernels).

Cheers,

	Michael


>
>>
>> Should it just go in via the m68k tree?
>>
>> Or I can create a topic branch to share it between ppc and m68k?
