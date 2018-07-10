Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B8CC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B4FB208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="AxPwNJML"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B4FB208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933423AbeGJOKD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 10:10:03 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:52816 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754265AbeGJOKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 10:10:01 -0400
Received: by mail-it0-f66.google.com with SMTP id p4-v6so30680466itf.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 07:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fS6baTSJEG8SaLBt6bqVqyaCk7tDANzIA2Z+Rzj3ki8=;
        b=AxPwNJMLReo3bgBvSHTN/67PCNtE7XjY/SbVINTbBoeGGWe79cYg5z0cdMNduiypKm
         dJ2aISNcUkje/1nVFseKgC4IOrcGqHopoQTvwxDmY4CUFIt+T2dRpml8P8dCZkNOsjQK
         GgMQK2sHCjVMb9iJuRyr06vZTqHABzRRojpZBzBgAXPsqFzOBLCy+Pg8yc9jOoJE9YOJ
         utbQw8esNXBYncx7q9OMwfBaTZk8p4kPoc0Dh/xr4uoa0MM7wcJ7PBM9w542NvZkj4bE
         kWo1hZYjKbdEblYWMuPiOVUQ92BKeXYRRBCqXDhiAV/GgGmEwdzlJkW3Rhh66jHMsuu+
         uldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fS6baTSJEG8SaLBt6bqVqyaCk7tDANzIA2Z+Rzj3ki8=;
        b=Uzw85SgAOzXqIpLKt4kX+Y4upnSyArqhShkqIEyW+RzkwLYOhMg7Vi9MpdffuRkocA
         TKjPYTuiqnlXc3KoW4xlOddTuyztK2Jwn0zeC9jZWZB/eZlBjxZohf1vYdRAHG/ebLmx
         Gcf/nuIIpVAw+klfOVHxBYRToXiIbfglmVoD+X4p8RJHjGpaDQk34PBfreS2vnLrZQXj
         rzoEpjHhHA0Jz4mhe191gRsTNiWf+2A2LPAdLxsYRs8vc7qU14AA1NJDeG7TemfaG8zq
         0+/gCpKG+ZcJPoO+mcCEV7FFKaIlbZQIz/DEG39upqK74UQN90T3NgDC2TQTP5d/LKSd
         MYig==
X-Gm-Message-State: APt69E2n6w69s+KD5FJ2k4VA7DkLag96jCFe/jnA0hJkWeiLWKhzPIvA
        RwURttK/3D6aPm8WGxH8Uk/PVg==
X-Google-Smtp-Source: AAOMgpc6MLzMLMqkEp9xeqV0mCgt9M6jtOAq/pWYXpUR3l/si7mXPsPg6j6tEzwaCRpTt/gdh89Ctg==
X-Received: by 2002:a24:2b56:: with SMTP id h83-v6mr18377032ita.94.1531231800361;
        Tue, 10 Jul 2018 07:10:00 -0700 (PDT)
Received: from [192.168.1.167] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id l82-v6sm9942691itl.25.2018.07.10.07.09.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 07:09:59 -0700 (PDT)
Subject: Re: linux-next: build warning after merge of the scsi tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Omar Sandoval <osandov@fb.com>
References: <20180620132911.5f6ab464@canb.auug.org.au>
 <20180710173114.17ee69ad@canb.auug.org.au>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <280ebbdf-fafb-1744-f517-815a30e682bb@kernel.dk>
Date:   Tue, 10 Jul 2018 08:09:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180710173114.17ee69ad@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/18 1:31 AM, Stephen Rothwell wrote:
> Hi all,
> 
> On Wed, 20 Jun 2018 13:29:10 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> After merging the scsi tree, today's linux-next build (powerpc
>> allyesconfig) produced this warning:
>>
>> In file included from include/target/target_core_base.h:7:0,
>>                  from drivers/target/target_core_tmr.c:31:
>> include/linux/sbitmap.h:331:46: warning: 'struct seq_file' declared inside parameter list will not be visible outside of this definition or declaration
>>  void sbitmap_show(struct sbitmap *sb, struct seq_file *m);
>>                                               ^~~~~~~~
>> include/linux/sbitmap.h:342:53: warning: 'struct seq_file' declared inside parameter list will not be visible outside of this definition or declaration
>>  void sbitmap_bitmap_show(struct sbitmap *sb, struct seq_file *m);
>>                                                      ^~~~~~~~
>> include/linux/sbitmap.h:530:59: warning: 'struct seq_file' declared inside parameter list will not be visible outside of this definition or declaration
>>  void sbitmap_queue_show(struct sbitmap_queue *sbq, struct seq_file *m);
>>                                                            ^~~~~~~~
>> In file included from include/target/target_core_base.h:7:0,
>>                  from drivers/target/target_core_ua.c:30:
>> include/linux/sbitmap.h:331:46: warning: 'struct seq_file' declared inside parameter list will not be visible outside of this definition or declaration
>>  void sbitmap_show(struct sbitmap *sb, struct seq_file *m);
>>                                               ^~~~~~~~
>> include/linux/sbitmap.h:342:53: warning: 'struct seq_file' declared inside parameter list will not be visible outside of this definition or declaration
>>  void sbitmap_bitmap_show(struct sbitmap *sb, struct seq_file *m);
>>                                                      ^~~~~~~~
>> include/linux/sbitmap.h:530:59: warning: 'struct seq_file' declared inside parameter list will not be visible outside of this definition or declaration
>>  void sbitmap_queue_show(struct sbitmap_queue *sbq, struct seq_file *m);
>>                                                            ^~~~~~~~
>>
>> Introduced by commit
>>
>>   24af1ccfe12a ("sbitmap: add helpers for dumping to a seq_file")
>>
>> in v4.11.rc1, but exposed by commit
>>
>>   eca7ee1f33e8 ("scsi: target: Convert target drivers to use sbitmap")
> 
> I am still seeing these warnings ...

Martin queued up the forward declaration patch for this one, not sure
why it isn't showing up in the scsi tree yet.

-- 
Jens Axboe

