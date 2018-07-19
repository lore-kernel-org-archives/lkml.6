Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69578ECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 02:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2563A206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 02:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QasZxfbA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2563A206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731267AbeGSDZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 23:25:17 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:43935 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729209AbeGSDZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 23:25:17 -0400
Received: by mail-pf0-f196.google.com with SMTP id j26-v6so3117426pfi.10;
        Wed, 18 Jul 2018 19:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Yl/AJryFflJ8m1IV+vL8IPGmVYTxrlVBVA1WlFqper8=;
        b=QasZxfbAH0jjcU1nla4Zs5q0YJErGSACcjBsRhIxAwS62T1squ/lthPPlEMP3H0uU/
         pBU2H5oDgxsim3INg8r7fZOBAptmCnRMHSMRi/p9Dz8K4633Ls5TufmB1CFGWJmbQ8uI
         eqqx8Yj6pBsDB43Im0X7lJwAPyz7t1CscSouI92HGYR8aWQ/nJKuvFapu2f3Fh6ZirRx
         c/7LkehL9Amr4Lv6bY6XZ1/mX3sA1F3+upBjj6l86hvatIYogmeeUL3E+YplpuQtqKmc
         8KjuR590rRB6I40X4mPp0RaHDkOi/nNaLBZAd1bx2s7tLvDZ6/0B3R04SHFvUrz/mJJ+
         LZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Yl/AJryFflJ8m1IV+vL8IPGmVYTxrlVBVA1WlFqper8=;
        b=HJOpw5CQUakKLgfbHpU+Rm78u6wx2NtvuqtK5lrdpC+w0+ArxpyPjGzF5oHtTZGSvi
         4wntfciQN0IWtMYQRhVCsHz67Er89hlMNUXB4uIILoK6I/UVqIh0cbWPQYOHQ8WOCtKh
         kXSQaFwTO04nIaI37gUMNjrQFpSumIkzwTvNB604+XTelLw0/LOrL3mH1HOH/XYInC2r
         ylgqcCMsPj2KdokWcVR0sv6oyynKWJYNiDpiiPNyqlfNBTF+T6Qz+GE+mKPZ2HrAom9g
         sHgzldut+5ZCtMLoaMzbXxuSIi/Z/uk9y5eS+BaleqKRMDY044Rxo8WLH7yQT6tgzIb9
         1U7Q==
X-Gm-Message-State: AOUpUlG8jGcJe7EN/HiVLmL8l740a1Jl9L8EE6sPEmLdG+Gx38ML5CaQ
        JyVvi1I/0QrJWUtVPPJqVqPQ9asz
X-Google-Smtp-Source: AAOMgpdbCkYEHW+0SZjgY/C7DijtvdSrSpMhdZWqDObQGkZfF/qlcuJtWJu/tDKySQodZG6uREFeMA==
X-Received: by 2002:a65:6143:: with SMTP id o3-v6mr8371077pgv.52.1531968267955;
        Wed, 18 Jul 2018 19:44:27 -0700 (PDT)
Received: from [192.168.0.77] ([211.196.191.92])
        by smtp.gmail.com with ESMTPSA id f126-v6sm7525043pgc.88.2018.07.18.19.44.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 19:44:26 -0700 (PDT)
Subject: Re: [PATCH 2/2] tools/bpftool: Fix segfault case regarding 'pin'
 arguments
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180718133526.19669-1-treeze.taeung@gmail.com>
 <20180718133526.19669-2-treeze.taeung@gmail.com>
 <20180718111949.325c985b@cakuba.lan>
From:   Taeung Song <treeze.taeung@gmail.com>
Message-ID: <3c25319b-0873-721b-7fd0-a828cc683acf@gmail.com>
Date:   Thu, 19 Jul 2018 11:44:23 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180718111949.325c985b@cakuba.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/19/2018 03:19 AM, Jakub Kicinski wrote:
> On Wed, 18 Jul 2018 22:35:26 +0900, Taeung Song wrote:
>> Arguments of 'pin' subcommand should be checked
>> at the very beginning of do_pin_any().
>> Otherwise segfault errors can occur when using
>> 'map pin' or 'prog pin' commands, so fix it.
>>
>>    # bpftool prog pin id
>>    Segmentation fault
>>
>> Fixes: 71bb428fe2c1 ("tools: bpf: add bpftool")
>> Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
>> Reported-by: Taehee Yoo <ap420073@gmail.com>
>> Signed-off-by: Taeung Song <treeze.taeung@gmail.com>
>> ---
>>   tools/bpf/bpftool/common.c | 11 ++++++++---
>>   1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
>> index 32f9e397a6c0..b1e1ba9e1c90 100644
>> --- a/tools/bpf/bpftool/common.c
>> +++ b/tools/bpf/bpftool/common.c
>> @@ -217,6 +217,14 @@ int do_pin_any(int argc, char **argv, int (*get_fd_by_id)(__u32))
>>   	int err;
>>   	int fd;
>>   
>> +	if (argc < 3) {
>> +		p_err("too few arguments, id PROG_ID and FILE path is required");
> 
> Thanks for the fix!  You can't say PROG_ID here, because this function
> is also called by bpftool map pin id X.  How about s/PROG_ID/ID/ ?
> 

Yep! will fix it :)

--
Thanks,
Taeung

>> +		return -1;
>> +	} else if (argc > 3) {
>> +		p_err("too many arguments");
>> +		return -1;
>> +	}
>> +
>>   	if (!is_prefix(*argv, "id")) {
>>   		p_err("expected 'id' got %s", *argv);
>>   		return -1;
>> @@ -230,9 +238,6 @@ int do_pin_any(int argc, char **argv, int (*get_fd_by_id)(__u32))
>>   	}
>>   	NEXT_ARG();
>>   
>> -	if (argc != 1)
>> -		usage();
>> -
>>   	fd = get_fd_by_id(id);
>>   	if (fd < 0) {
>>   		p_err("can't get prog by id (%u): %s", id, strerror(errno));
> 
