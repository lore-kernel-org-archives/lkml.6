Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBF9C00449
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 01:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EEEB21473
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 01:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="tFZGVcKm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EEEB21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbeJFIOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 04:14:39 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45791 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbeJFIOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 04:14:38 -0400
Received: by mail-ed1-f65.google.com with SMTP id v18-v6so12037047edq.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 18:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bbcOSfmGPqGsrdH+cPdIozpr646I99ZSJ1i/nHZ0A3E=;
        b=tFZGVcKmUw8OHecLASEe+AkStjykIYoxzwS3jc9RWFKVbNulzkJv91kQpGpmGBBxyw
         Y4/pkgguz/mxDb1il2ELYfQQ9jcx3JX5dbWXY+xP5tiJ8/w5gbREFdQVn8LIepn21FuZ
         d3oNXUlqnk3CINPB0Q3OX2bRoI0VcpCQ/z0Syu2lJPgChgRQufA74Oh221fthRIIkAXE
         Zgoz9iM40xO82cPJ47JntKa/qXPVXwADWmH/txhnS9yBAb5BkP/+c9BuhbgD/iN3XniC
         dNdlz4p9d21g9DlBDZ32wC3HBXj0pi9CaYDAjKQNVl5Qs8lvP6dMBh4KVeCaAKlLU6uG
         sS6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bbcOSfmGPqGsrdH+cPdIozpr646I99ZSJ1i/nHZ0A3E=;
        b=nrHMw9Dc4cuELGWxQfN8bbbJe/Za9AXGW3nHjPmiHS3hpTuVwokxCbuf00bUtt/tao
         OtfOl4bfIqnW6zJSVCoVFATM+nflZhwgHFib9SO442sR6voxUP6oLVdn0Gs6VDjm+Ahr
         /ogc/2QO3c8i/ulhhMB/zzrdazZY5B9wveXHlhYpt23R3jxRxm6XLJabsIZsuR8102r7
         B3iwtRZuViz2ULKBxu4gVQfVaJDLRuIepmIZmCevfClzBPIbmmQKtGbesoR2Ngn9MTZI
         Bs768rYdGyZ/aZPn0txlaQfc3WhKv6TL5LzKxr5hdeKhRsRAIG2IEyegyy8C/vKTOCmf
         BBHw==
X-Gm-Message-State: ABuFfoj7q0PU7GoSHmeZt3vItpdzVUjmAjTkYPeg/JHTeJcAK2+CE4ei
        6PGkALjzDpHDV/OSWCJfy59toaRxaUg=
X-Google-Smtp-Source: ACcGV614Q8/Kae4mijjWLaWGYHsf7TZ2y3A0B06HCw/PoCPcWP0BlFAiGVYyOww230aSM+eaRs5Wxg==
X-Received: by 2002:a17:906:64c:: with SMTP id t12-v6mr13763381ejb.113.1538788399942;
        Fri, 05 Oct 2018 18:13:19 -0700 (PDT)
Received: from [192.168.0.10] (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.googlemail.com with ESMTPSA id v15-v6sm38151edr.45.2018.10.05.18.13.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 18:13:18 -0700 (PDT)
Subject: Re: [V2 PATCH 0/2] lightnvm: pblk: retrieve chunk metadata on erase
To:     javier@javigon.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier@cnexlabs.com
References: <1538637235-25469-1-git-send-email-javier@cnexlabs.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <afc7d53c-b514-293d-f876-f2bdaa3c5dbb@lightnvm.io>
Date:   Sat, 6 Oct 2018 03:13:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1538637235-25469-1-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/2018 09:13 AM, Javier González wrote:
> Changes singe V1:
>    - remove sanity checks on the fast path
> 
> This patchset implements support for retrieving chunk metadata on reset.
> This is the base for implementing wear-leveling and allowing chunks to
> shrink at runtime.
> 
> Javier
> 
> Javier González (2):
>    lightnvm: pblk: add helper for printing chunk state
>    lightnvm: pblk: retrieve chunk metadata on erase
> 
>   drivers/lightnvm/core.c      | 44 ++++++++++++++++++++++++++++++++++--
>   drivers/lightnvm/pblk-core.c | 54 +++++++++++++++++++++++++++++++++-----------
>   drivers/lightnvm/pblk.h      |  9 ++++++++
>   3 files changed, 92 insertions(+), 15 deletions(-)
> 

Right now there isn't a way in the spec to tell if the drive supports 
this feature or not, and DSM Reset doesn't support it either. Making it 
a bug in the spec. Until the updated spec is out, I like to avoid adding 
this feature into the kernel.

The Get Log Page approach can be used for wear-levelling information. 
Similarly for knowing when a chunk shrink, pblk can't rely on a chunk 
not shrinking at runtime (and reporting early close error), so in the 
case this happens, pblk can either continue business as usual, or resync 
with the drive.
