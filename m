Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2534C282D7
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 05:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C6412147A
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 05:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbfBDF6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 00:58:53 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:32927 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbfBDF6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 00:58:53 -0500
Received: by mail-ed1-f67.google.com with SMTP id p6so10303826eds.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Feb 2019 21:58:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JIbHb1CH0ikmJo5wypsmsvuNbbXI3f1HDj+0hrIu09Q=;
        b=LYEcUykYMStMxqtDawjgZeT0xbHHafEKAW+ZrgjH/XqKvl6f8YxBadh51ep6L4jdTA
         Wkx26oVpnOEc6d0FJLMUV0j0aXMo0vHqp01tKQIRo3bAvzkXEtJRUgzIp7g7vvALK6cx
         8swRT4aHp+3iVc3SQhxHEcCUkNJAT2FPGZa/ecTg2ePgQgBGd4ybX5R7oQHzxZsQ7JOq
         6/B0K6RA6qNpNXGWwz8NQS+g48diB5nWpGsjbOtCXZZ12mmume0Y35XfEmHqs3wc7tq8
         fTF4gmY9JFwQ2foR6UVarWMQdRgBlmFgEqvcAleqxnT4Kotfe8XCsX3bXZ/R37SJlpum
         YKNw==
X-Gm-Message-State: AJcUukf2M/BKhg2dGi+VLUVvVSRJk13nZQ6UWCwg4OqA7vTqJ3X/vlEv
        OWDU0PysDqImk9bf7wgoqmXJvw==
X-Google-Smtp-Source: ALg8bN7InMHlRpKgkThbNjHihSJS5kzn81iRgLsU2pjvXidgNwEbHUsfEkuigcmQW3CVwFaMLz9RyA==
X-Received: by 2002:a17:906:258d:: with SMTP id m13mr29620376ejb.73.1549259931200;
        Sun, 03 Feb 2019 21:58:51 -0800 (PST)
Received: from [10.43.7.208] ([109.236.136.226])
        by smtp.gmail.com with ESMTPSA id k11sm3837313edq.51.2019.02.03.21.58.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Feb 2019 21:58:50 -0800 (PST)
Subject: Re: Userspace regression with 6baca7601bde ("scsi: target: drop
 unused pi_prot_format attribute storage")
To:     David Disseldorp <ddiss@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lee Duncan <lduncan@suse.com>
References: <57120b72-2ab9-bfa5-f69c-31aee78d5936@redhat.com>
 <20190204014048.1cf91326@suse.de>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <b03a25f0-ea67-3e1b-ffc7-3d9b9f6e838e@redhat.com>
Date:   Mon, 4 Feb 2019 06:58:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190204014048.1cf91326@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/19 1:40 AM, David Disseldorp wrote:
> Hi Laura,
> 
> Thanks for the report...
> 
> On Sun, 3 Feb 2019 17:56:00 +0100, Laura Abbott wrote:
> 
>> Fedora got a bug report of a new permission denied error with 5.0-rc2:
>>
>>>    File "/usr/lib/python3.7/site-packages/rtslib_fb/utils.py", line 100, in fread
>>>      with open(path, 'r') as file_fd:
>>> PermissionError: [Errno 13] Permission denied: '/sys/kernel/config/target/core/fileio_28/xxx/attrib/pi_prot_format'
>>
>> This looks like an intentional behavior change with
>>
>> commit 6baca7601bdee2e57f20c45d63eb53b89b33e816
>> Author: David Disseldorp <ddiss@suse.de>
>> Date:   Fri Nov 23 18:36:11 2018 +0100
>>
>>       scsi: target: drop unused pi_prot_format attribute storage
>>       
>>       On write, the pi_prot_format configfs attribute invokes the device
>>       format_prot() callback if present. Read dumps the contents of
>>       se_dev_attrib.pi_prot_format which is always zero.  Make the configfs
>>       attribute write-only, and drop the always zero se_dev_attrib.pi_prot_format
>>       storage.
>>       
>>       Signed-off-by: David Disseldorp <ddiss@suse.de>
>>       Reviewed-by: Christoph Hellwig <hch@lst.de>
>>       Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
>>
>>
>> Unfortunately, existing code that's opening with read permissions is now broken.
>> Can this be reverted? Full bug at https://bugzilla.redhat.com/show_bug.cgi?id=1667505
> 
> Lee (cc'ed) pinged me a couple of days ago about the same issue.
> My preference would be to add back a dummy read handler without the
> corresponding (unused) se_dev_attrib.pi_prot_format member.
> I'll prepare something tomorrow with this, but if it's urgent then I'd
> also be okay with a straight revert.
> 
> Cheers, David
> 

A fix is fine by me. Thanks for the prompt response.

Thanks,
Laura
