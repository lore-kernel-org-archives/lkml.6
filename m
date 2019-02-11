Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26FFC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD3EA2083B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="GAvR1Cyi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388288AbfBKT7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:59:45 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42283 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388179AbfBKT7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 14:59:42 -0500
Received: by mail-pl1-f195.google.com with SMTP id s1so54209plp.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 11:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=p7LG6nbJGBphYA5mjGXF/ASFTAHEuLrBAbiWaFUvMqE=;
        b=GAvR1Cyigt3nLSBgjRTrnQHigFem82pnPb6kHmFc+daUWKbXZKlDqRdoDJKo6PoSCv
         fkT7uvZhp6bBJJU+SFawInICRODezP/ySUBY09wi04/NcyM/+Jt1SC4sefjUD7qLk8bK
         KVVdUrLRO8np2qZXmuPKDEUjNIzxjr/ZpcwxZ4MPiDD+Ix9HZBHMJGqLRp/Nae8F5Xtz
         xrd6Setl6pB1Lgw/59hWgGaj7Gn52qQ/RFUkNC04LFvU0J4gvdwknE9y6JM9awFvA+SY
         aSx08HDEPE0NUYwMF1SQ5BLa3iWFHC2VxBCXysVSS+YVG5VAR6xygrQosoPiLcYexMHV
         o3IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=p7LG6nbJGBphYA5mjGXF/ASFTAHEuLrBAbiWaFUvMqE=;
        b=n1dv0S9ZYGeVPykn6z27BmSeT0Mdzvy1NWMVhm3edgABJ/I7YPzf+ci2GMIvMZiySC
         yNfP0XmMGrz3Es6AJpZ6WHXvYryCi8xvltO0PrFTWZi3p7BiAfAPBW1ERSU1nlH874fr
         pb4OP8nYjfbNpqEVlto1yDX1VgLtw8A8RE0mFDVsHVpqzqDLjyJd00DCt4MjPm3AHuSJ
         fmXXbA9iLOyyx9mluPBZW5HKR0tBmn4ejdpwyOd2Mxtf2FF5m/AwXEU02UHS2ydSZHrS
         Gbj7aNYaHLM4L4WnxFRautk9xQscVszCBEX+vPZpA+4NA2rlpYis3gwVkg69fIvjcGeO
         r5Ew==
X-Gm-Message-State: AHQUAua7by1ZOd4j/OHMFQchOG+TNyrkGcTHT92Xf/yuvM8pCY+JDTuO
        gCpS4WngB+aHUJdjqIy4u4tnHg==
X-Google-Smtp-Source: AHgI3IZ00uDMemnAYx7ttZMpn+gwjSEUSHeJuGwnRJxcnfNI+iTl4vt0TtmzqnfmtZFO1b5Dm7cv2Q==
X-Received: by 2002:a17:902:9885:: with SMTP id s5mr39626594plp.52.1549915182119;
        Mon, 11 Feb 2019 11:59:42 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id d13sm18127615pfd.58.2019.02.11.11.59.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 11:59:40 -0800 (PST)
Date:   Mon, 11 Feb 2019 11:59:40 -0800 (PST)
X-Google-Original-Date: Mon, 11 Feb 2019 11:56:26 PST (-0800)
Subject:     Re: [PATCH 0/5] riscv: minor fixes and cleanups
In-Reply-To: <20190211093406.GW4686@localhost>
CC:     aou@eecs.berkeley.edu, schwab@suse.de, atish.patra@wdc.com,
        anup@brainfault.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, johan@kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     johan@kernel.org
Message-ID: <mhng-d0cd3a60-098d-40dd-912c-f0cb77d54ae7@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Feb 2019 01:34:06 PST (-0800), johan@kernel.org wrote:
> On Fri, Jan 18, 2019 at 03:03:03PM +0100, Johan Hovold wrote:
>> This series fix up some minor issues found through inspection.
>>
>> Note that the fourth patch changes which cpu (hart) devicetree nodes
>> are enabled by following the Linux convention of considering nodes
>> without a status property as enabled.
>>
>> These patches are against the riscv-next (and fixes) branch with Andreas
>> node-reference fix applied:
>>
>> 	https://lore.kernel.org/lkml/mvm8szwwo1o.fsf@suse.de/
>>
>> and have been tested using QEMU.
>
>> Johan Hovold (5):
>>   riscv: add missing newlines to printk messages
>>   riscv: use pr_info and friends
>>   riscv: fix riscv_of_processor_hartid() comment
>>   riscv: treat cpu devicetree nodes without status as enabled
>>   riscv: use for_each_of_cpu_node iterator
>
> Are these still in your queue, Palmer?
>
> Note that the node-reference dependency mentioned above is now in
> Linus's tree.

They're still in my queue.  With any luck I'll have time tonight to go through 
by Linux patch review backlog.
