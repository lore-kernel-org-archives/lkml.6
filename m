Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F110C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 18:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14AF52064E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 18:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="UVbd732k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14AF52064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbeH2WJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 18:09:42 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36131 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727693AbeH2WJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 18:09:41 -0400
Received: by mail-pf1-f196.google.com with SMTP id b11-v6so2644262pfo.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 11:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wUxYOpTBhqCaNuXzYHV83oZMCPP8ICX7wAfM7RxrphU=;
        b=UVbd732ka6HFJGwN+NfWieOzh9YbuXnMbPY7HYlZjswu5c/WvmCFtotbSsBKly3rWf
         wlNNX4Gon55B2VSGIKhHni5lh4xerFHx8zXWNWy1smgECyit72B2H82Ci/d3TT1df69Q
         WL4rCxrJZ95b5Io/ZDcSxF8M0c0ClfDxFzthwkWB7rU9CrDnBubgbCSSyyH/1Ym3ts2i
         aHO3pcrTLNUz7BPzbZLu87d1GCwdG2k9li9tiinlhjvJ7NOC7+K47kzPcSMsLRdWK0Rw
         2wGKTaH3tU38Z8mrRNyhdf7maBQVIQDksSdq/MZkJcPE2ZPBJTIA9APBBMn/D3xNMIfK
         bGVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wUxYOpTBhqCaNuXzYHV83oZMCPP8ICX7wAfM7RxrphU=;
        b=ZrabgEdDvSbprJSHVdqIeW/5U1fsXQnNhSDBQZ0RLqbfcGnay3uO6Qln7KLNaa9/TG
         EykhE17zU9V84wv/FPlY3D4dM5k6v0AIjECyk/JfVXqe5t9C/0RngpL2E5l3PriKxs9c
         7f9IAwTu0Ant1Avfkj5mOohKUeqfnckSvzPYp14OGJuEMRttr2Tu9X3xbKxduYiHnjyU
         WK+PR6jtMw71QCPPOzjiaaX3QN8DlCXlTVC8vXXjhdO1XKK+AsMLTPlV3gerxRZJpXy5
         k1QCQMMiyxdNj11sTarYLG7VBX4PVBSEbfeo5DJqkkoSbRcedscVYFIMobD2Y08fynA+
         LCpg==
X-Gm-Message-State: APzg51DwGZRgwDsfy1awwS31UFCuQTWshhhYqw4mOAUcn+6FO/56cy+A
        pncGmexYncgc9WTSa17e+lNrAguVGbXFVA==
X-Google-Smtp-Source: ANB0Vdb52roT2GIzlYuiTQlqRLVeazd4/xxdpBupa6s+LLpzxTjb4xEanqKMu+28aVl8eKm+gCNgaA==
X-Received: by 2002:a65:4147:: with SMTP id x7-v6mr6563751pgp.220.1535566296664;
        Wed, 29 Aug 2018 11:11:36 -0700 (PDT)
Received: from [10.86.62.45] (rap-us.hgst.com. [199.255.44.250])
        by smtp.googlemail.com with ESMTPSA id m26-v6sm16850223pfi.102.2018.08.29.11.11.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 11:11:35 -0700 (PDT)
Subject: Re: [PATCH 0/4] lightnvm: pblk: collection of small fixes
To:     javier@cnexlabs.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1535533313-29944-1-git-send-email-javier@cnexlabs.com>
 <5b8881cd-019a-a1d8-86ed-0131ef3b71af@lightnvm.io>
 <3F0AC430-4499-4D2D-B989-45B5635307A4@cnexlabs.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <115fa3ea-c53b-557f-9465-5f61a02efa49@lightnvm.io>
Date:   Wed, 29 Aug 2018 20:11:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <3F0AC430-4499-4D2D-B989-45B5635307A4@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/29/2018 03:27 PM, Javier Gonzalez wrote:
> 
>> On 29 Aug 2018, at 15.14, Matias Bjørling <mb@lightnvm.io> wrote:
>>
>> On 08/29/2018 11:01 AM, Javier González wrote:
>>> Collection of small helper function fixes, removal of unused variables
>>> and comment typos.
>>> Javier González (4):
>>>    lightnvm: pblk: calculate line pad distance in helper
>>>    lightnvm: pblk: fix comment typo
>>>    lightnvm: pblk: remove unused variable.
>>>    lightnvm: pblk: guarantee emeta on line close
>>>   drivers/lightnvm/pblk-core.c     | 13 +++++++++++--
>>>   drivers/lightnvm/pblk-recovery.c |  2 --
>>>   drivers/lightnvm/pblk-write.c    |  2 +-
>>>   drivers/lightnvm/pblk.h          |  6 +++---
>>>   4 files changed, 15 insertions(+), 8 deletions(-)
>>
>> Thanks. Applied 2-4. The pad distance does not compile due to missing
>> update to pblk_pad_distance call from pblk-recovery.c.
>>
>> Also, it looks like pblk-recovery.c is the only user. Please consider
>> moving it the function from pblk.h to pblk-recovery.c
> 
> I reordered to send the helpers, but you can see that all these are made
> to support.
> 
>    lightnvm: pblk: recover open lines on 2.0 devices
> 
> Can you fix this directly and apply 1 too? I'm fine with moving it to
> pblk-recovery.c. The patch above will use it.
> 

Yes. I've fixed it up in pblk-recovery.c, and also moved the function to 
pblk-recovery.c. Applied for 4.20.

