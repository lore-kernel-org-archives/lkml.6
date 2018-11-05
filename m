Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE6AC46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC3862081D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JveS1ziF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC3862081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729980AbeKFCRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 21:17:04 -0500
Received: from mail-it1-f174.google.com ([209.85.166.174]:51234 "EHLO
        mail-it1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729762AbeKFCRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 21:17:03 -0500
Received: by mail-it1-f174.google.com with SMTP id h13so13677868itl.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 08:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3MmaN0jrCJbz+INAFVwP74cEKeTv/a6+GsClckRLvu0=;
        b=JveS1ziF8Uj9TTS9AkouaGGAyeBsmvU4KrS00loZqZ/0UE8z0OUnmXoU2c4xLkBI4K
         0woa9CafNuvxeCd1k62x3X0Ojy6Y4mRIGkr+BSpPjpD/+Tkl9tT76Mz5N+OVpjTls+xB
         e+It28czsNoURIXVf1LBM1g/4/rv7oD7EbWTA8EYKYUIY3uhq/n6fX7u03jWRn6Dho3e
         EQl3hjN+kkwRw/0XfB9O4UQgJ3KKEp9yGMCPuvnN+kByv0pkOrzTaIGcqI4frk80GFf8
         5Auv6vbGyB/p6xaShSCI2Du4FmMtS5wtiZFtvUCpE2KmC7ewc1UCMzfj+jyY7QLSDDo4
         gitA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3MmaN0jrCJbz+INAFVwP74cEKeTv/a6+GsClckRLvu0=;
        b=P2rSM88LUvrNzDct5wuLmKIwwYlXe7XoJlJ0MleH2SAFzHPJzElYXGTvEr9gq0LkK6
         zTOCJS3AT1LlNFx+3tRaSCLWnzmhFxgTZtlC6Hm39+4VfZXYerJtvPC7snhIWEykNe9n
         zKz6wCafTHSju2MMAjr30Q8qQxsjqVkTb/1Dp+ZPKvHj5PY08rTJFFCF26gkLpmTJZB/
         m9wsCHC6eJXPO6SygXIJ+aD0za7IVaypATuq5JMfDUjlN3SVjA5hFTsoePwl1POAxdwo
         SlclxYXeYtHrACfJakxGiBuLoAVWtW+eul15W06p5KDpXXBror2yHiHB93iJV2zKTgLl
         9yPw==
X-Gm-Message-State: AGRZ1gJex1TZ3yvSgw/xOTek/BSQhipA2c2glgE5RH7uXnOTY6wQFpWV
        HEYwphMXI0s7Gy0aA0loC08=
X-Google-Smtp-Source: AJdET5d/X8bdzB55EkKlK/V8UBq9M+GMJt0wgpW7vErTmxCc2wCYYZQD08Fyf3qL6HiT3TMY+p7MRg==
X-Received: by 2002:a24:8a84:: with SMTP id v126-v6mr7018089itd.132.1541436988836;
        Mon, 05 Nov 2018 08:56:28 -0800 (PST)
Received: from [191.9.209.46] (rrcs-147-0-47-180.central.biz.rr.com. [147.0.47.180])
        by smtp.gmail.com with ESMTPSA id d10-v6sm14243923itd.27.2018.11.05.08.56.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 08:56:27 -0800 (PST)
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
 <6a1f57b6-503c-48a2-689b-3c321cd6d29f@gmail.com>
 <83467.1541436836@turing-police.cc.vt.edu>
From:   "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Message-ID: <20fe7145-8426-c67d-2ab2-258ec5717966@gmail.com>
Date:   Mon, 5 Nov 2018 11:55:58 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <83467.1541436836@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/2018 11:53 AM, valdis.kletnieks@vt.edu wrote:
> On Mon, 05 Nov 2018 11:28:49 -0500, "Austin S. Hemmelgarn" said:
> 
>> Also, it's probably worth noting that BTRFS doesn't need to decompress
>> the entire file to read or write blocks in the middle, it splits the
>> file into 128k blocks and compresses each of those independent of the
>> others, so it can just decompress the 128k block that holds the actual
>> block that's needed.
> 
> Presumably it does something sane with block allocation for the now-compressed
> 128K that's presumably much smaller.  Also, that limits the damage from writing to
> the middle of a compression unit....
> 
> That *does* however increase the memory requirement - you can OOM or
> deadlock if your read/write from the swap needs an additional 128K for the
> compression buffer at an inconvenient time...
> 
Indeed, and I can't really comment on how it might behave under those 
circumstances (the systems I did the testing on never saw memory 
pressure quite _that_ bad, and I had them set up to swap things out 
pretty early and really aggressively).
