Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238F4C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 03:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF50C2174B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 03:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TeiJvmSO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF50C2174B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbeHMGNB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 02:13:01 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41857 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbeHMGNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 02:13:01 -0400
Received: by mail-pg1-f196.google.com with SMTP id z8-v6so6897341pgu.8
        for <linux-kernel@vger.kernel.org>; Sun, 12 Aug 2018 20:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=622jTiJu+0MRtm9OtT2f2Hf5UrvCZy9t5E5iQFi9qoc=;
        b=TeiJvmSOyRe3X8One+Rn2MekY0FJr+q/iqbknoMUISpmRGbi9irhuqmYD1gkxn1o5r
         zNd3wVXzIjxrzKBkLSEviPGTpPwtgjttHg7RY21jUGVKvMfPe9ZfUfWbn3q8plXuEvX+
         7DqSSoLL+P/CmspC33y5PXQbmy8Ao+3DvodzD1dxcUVj7+4t6rF31CNsJNlbZGyYpt5Z
         nmoek9yjFEQ8a8Yq073ms++nUOm12l5VA/CEct1uZOOHVI0Mhx8J9sl0X90LJbTjBfbn
         pz3AzUhp5jVgrIWxDEFXO9EZDKrE11uztecScHN/HIZi+F7EmqzzmLYUt9AyWPWIVfXc
         UwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=622jTiJu+0MRtm9OtT2f2Hf5UrvCZy9t5E5iQFi9qoc=;
        b=Pk7tpQ6gSZiMQdedWvwDwemBEAKg/IMoPwNMfV8KqnVatLE5Ayf/WaoGV8b7xZOq2U
         ID1/0YbbdVbfWbd0md7U6s1RUbKWADWur20Q6+0n4qsfZe49Bpzmc/lnj2lOBulUwj3F
         nD7YjjBV2747sm8RQUQHcN4bUd/eVwSic9syFTKUq38S81z2m3pSMJNvcveOPMuy+7aX
         lRS7FE4NbqVZ/vLYGejMaA2b+s2NqvwcIvLEQxr47v+Fi/HGTw/n9ExGFTwywRa6kZHL
         +EAM9b2TBWJX1m1C0jTvGGnJKmcTTOoTq/UUMGDmqc2RHMtigadvuCx/CpdrYah5ZLoT
         Gx7w==
X-Gm-Message-State: AOUpUlGaU9HwwmAGkn0UDBOVupCk7AsJW1jVoeQkl++cLwDR0IUUyJYg
        /b2k9UWD587jrrdDfQnvO9wLRaau
X-Google-Smtp-Source: AA+uWPyoa67+21gznaWyPqhBFEFdUxD/GXfXeeMkcRD4Pebwb1kXNdrBZZrflRnW6BBVcRyIvde51g==
X-Received: by 2002:a63:161a:: with SMTP id w26-v6mr15715199pgl.257.1534131163211;
        Sun, 12 Aug 2018 20:32:43 -0700 (PDT)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.71.57? ([2402:f000:1:1501:200:5efe:a66f:4739])
        by smtp.gmail.com with ESMTPSA id l10-v6sm22193020pfj.179.2018.08.12.20.32.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Aug 2018 20:32:42 -0700 (PDT)
To:     dhowells@redhat.com
Cc:     linux-afs@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] fs: jffs2: possible sleep-in-atomic-context bugs in jffs2_iget
Message-ID: <48808863-2c1e-34bf-5968-8bb88052b556@gmail.com>
Date:   Mon, 13 Aug 2018 11:32:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel may sleep with holding a spinlock.

The function call paths (from bottom to top) in Linux-4.16 are:

[FUNC] schedule
fs/inode.c, 1916: schedule in __wait_on_freeing_inode
fs/inode.c, 826: __wait_on_freeing_inode in find_inode_fast
fs/inode.c, 1107: find_inode_fast in iget_locked
fs/jffs2/fs.c, 263: iget_locked in jffs2_iget
fs/jffs2/fs.c, 665: jffs2_iget in jffs2_gc_fetch_inode
fs/jffs2/wbuf.c, 505: jffs2_gc_fetch_inode in jffs2_wbuf_recover
fs/jffs2/wbuf.c, 462: spin_lock in jffs2_wbuf_recover

[FUNC] mutex_lock_nested
fs/jffs2/fs.c, 273: mutex_lock_nested in jffs2_iget
fs/jffs2/fs.c, 665: jffs2_iget in jffs2_gc_fetch_inode
fs/jffs2/wbuf.c, 505: jffs2_gc_fetch_inode in jffs2_wbuf_recover
fs/jffs2/wbuf.c, 462: spin_lock in jffs2_wbuf_recover

I do not find a good way to fix, so I only report.
Maybe the spinlock should be released before calling jffs2_iget(), and 
then be acquired again.
This is found by my static analysis tool (DSAC).


Thanks,
Jia-Ju Bai

