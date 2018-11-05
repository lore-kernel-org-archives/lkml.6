Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45277C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B7042085B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4iXLd45"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B7042085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387500AbeKFBtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 20:49:46 -0500
Received: from mail-it1-f181.google.com ([209.85.166.181]:54217 "EHLO
        mail-it1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387428AbeKFBtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 20:49:45 -0500
Received: by mail-it1-f181.google.com with SMTP id r12-v6so10727745ita.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 08:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3LVzHM5lskTi6bGYYRdf7iXcdzOsbozG4luwh+Hxvzc=;
        b=N4iXLd45rysjFRiE03pt0ErVIJl9uxmH4vJurOZcDFE1T4YXSBkaX6Bga6uUZbcwsA
         k9he3KLJ1ahVmIKBlGzOFzTa3nKjuJQVlVr8Vk8CWzEkEq0jRF8QwZG11E6IBrH7Agb+
         ai9OqnOnlM7LAlnpz+GdVVmHR/JJF0wMAayMDlX5ji5i3zckUQNoKl8loEdKLHmwMtKo
         ci/X1D/E3dLFfe1G/WCStEvE9WrG5HnAGFJuVYtYIVXIeHTUlAlFRS+yhFhNfoQEPg+j
         fTSHQZQiLBILePSH9XdDvEOkbIolkh9Abs0MamxhAsm8EITTHd0TKvFYoRyB0giXA7IC
         mzUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3LVzHM5lskTi6bGYYRdf7iXcdzOsbozG4luwh+Hxvzc=;
        b=Wv26Q9Zvv5XjbVq+jHop9xFLPiGiqm8C4e0EZn/dQV4f/BksH64Ch+736cVadZChqf
         il5yRAsYfpEV27U0X/ePU91hUE16T3UiEOdO6RjcCjBetmQ9aTk53lMoSsxTsj8qDCJN
         mYtr1GqMdRApxYma03NOEKQ+LlqfVxHWjuPVmq4WooZpK3GaurDNL4C3BqKoaviESMgF
         0W9NVVBIkUz4IqHbgOc3xzqKXsAJO89+4xajFtxQnyTPDz/qmZ0YRyIxBWeydyrhSq9c
         AhTE049P5dXWIbsPVBHzq/u9wQgDi4GxXd1VUfWOoVDv88obDMw+wJRYckC1Af+yY3cn
         nmvQ==
X-Gm-Message-State: AGRZ1gLaTKLx5YUBGQa+CIKti9hLvDj6BLGc+/SUr/DsA6fBRqclEJEy
        VZ633UsZ77ydppuZlj6Zlog=
X-Google-Smtp-Source: AJdET5f6gSMgV7q9c7qandTjOAy+zvWm02tf13aTQ/FZlCd3McQyRQwNV5PHg0XpA9Fkjx8AqZImEg==
X-Received: by 2002:a24:1fc1:: with SMTP id d184-v6mr7705608itd.142.1541435357072;
        Mon, 05 Nov 2018 08:29:17 -0800 (PST)
Received: from [191.9.209.46] (rrcs-147-0-47-180.central.biz.rr.com. [147.0.47.180])
        by smtp.gmail.com with ESMTPSA id 131-v6sm7416916itz.31.2018.11.05.08.29.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 08:29:16 -0800 (PST)
Subject: Re: Creating compressed backing_store as swapfile
To:     valdis.kletnieks@vt.edu
Cc:     Adam Borowski <kilobyte@angband.pl>,
        Pintu Agarwal <pintu.ping@gmail.com>, linux-mm@kvack.org,
        open list <linux-kernel@vger.kernel.org>,
        kernelnewbies@kernelnewbies.org
References: <CAOuPNLjuM5qq3go9ZFZcK0G5pQxTQb0DY36xu+8SL4vC4zJntw@mail.gmail.com>
 <20181105155815.i654i5ctmfpqhggj@angband.pl>
 <79d0c96a-a0a2-63ec-db91-42fd349d50c1@gmail.com>
 <42594.1541434463@turing-police.cc.vt.edu>
From:   "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Message-ID: <6a1f57b6-503c-48a2-689b-3c321cd6d29f@gmail.com>
Date:   Mon, 5 Nov 2018 11:28:49 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <42594.1541434463@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/2018 11:14 AM, valdis.kletnieks@vt.edu wrote:
> On Mon, 05 Nov 2018 11:07:12 -0500, "Austin S. Hemmelgarn" said:
> 
>> Performance isn't _too_ bad for the BTRFS case though (I've actually
>> tested this before), just make sure you disable direct I/O mode on the
>> loop device, otherwise you run the risk of data corruption.
> 
> Did you test that for random-access. or just sequential read/write?
> (Also, see the note in my other mail regarding doing a random-access
> write to the middle of the file...)
> 
Actual swap usage.  About 16 months ago, I had been running a couple of 
Intel NUC5PPYH boxes (Pentium N3700 CPU's, 4GB of DDR3-1333 RAM) for 
some network prototyping.  On both, I had swap set up to use a file on 
BTRFS via a loop device, and I made a point to test both with LZ4 inline 
compression and without any compression, and saw negligible performance 
differences (less than 1% in most cases).  It was, of course, 
significantly worse than running on ext4, but on a system that's so 
resource constrained that both storage and memory are at a premium to 
this degree, the performance hit is probably going to be worth it.

Also, it's probably worth noting that BTRFS doesn't need to decompress 
the entire file to read or write blocks in the middle, it splits the 
file into 128k blocks and compresses each of those independent of the 
others, so it can just decompress the 128k block that holds the actual 
block that's needed.
