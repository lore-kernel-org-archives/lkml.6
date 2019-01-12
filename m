Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACAFBC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 13:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 709FF206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 13:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20150623.gappssmtp.com header.i=@mojatatu-com.20150623.gappssmtp.com header.b="uHENRo29"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbfALN7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 08:59:45 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:56150 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbfALN7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 08:59:45 -0500
Received: by mail-it1-f194.google.com with SMTP id m62so7038442ith.5
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jan 2019 05:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n4FYB8axrV+9C+zBDYMhP9KTrRYzd7Hzktn646gZa/k=;
        b=uHENRo29L3D4xjTlZnFmmYnHm2sIRHEhtkRnlzOSfiDi1z4BaYIhS09scTPVlwjGAU
         mE4b5/6cEeGpHaFlAxysmqocXtLoGJTVN6SQc5ntWTB4xIhjxlxbT1nt/fejH9NEyyem
         gB0+OS6EVLidiNH6dhUIhC+UDa1Uq3HAAbSAIA6utRE1VATPqXZcMDEgz4dpEPjoJ/oW
         PuEsWhokObsTP1ZFNIVYU5ddHWzXchhETrucurT2BMFDByZ1jjjr0oLGm+tIY/mkHq/G
         a6K8w4jjNOngZMpgzr2O2DluyGzjWmgjTzApoYmZMjQ17Y4IiP+HK2/+D8DvG6/B93vp
         k7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n4FYB8axrV+9C+zBDYMhP9KTrRYzd7Hzktn646gZa/k=;
        b=RPVbQXtShSM+FGmv9OU6o+Ad7DuWjQcJKGeHMOsj1EPDj2JcPucd+/nZyPURqze9yy
         ucStXF+jJ8ioKCVU5fIpJvGGUYyOFweI20n5gE0xlrNonRLXFjiy/3WqtmdeL0c5MC5/
         k6FkPsBUOIVyCGBxRN02rmiP+CM4glmnbuML9kmGqI2D4eujW0zTTMJeDZQUKa63WVzX
         XED8TYGmAvx4MdMFkpx/IO9HLNJJC5kW/MdeI9uBxGiEi+lUT8VQqvIFX3tFJiWx7Jjq
         H0F9c3KZQ0svu+KuLtPcXbvXhvLV2mTPM83rYmyLB1uf6aaAljeLmWkR2DY7+LycSJbg
         gr4w==
X-Gm-Message-State: AJcUukfbx/flp8AHl3undw9EyynytSp9gXMBmhP3xqLFQqXhFthsBOmS
        5qBkhK1r20AxnKoniE2xlLExsw==
X-Google-Smtp-Source: ALg8bN5OUKs8na0jH0ulGWhEPgkMt64qbkw1YllKI+WPQpyEMUHVsV8fQVlM+73JHcPUqmE7EXHKrA==
X-Received: by 2002:a02:8a69:: with SMTP id e38mr13166408jal.81.1547301583965;
        Sat, 12 Jan 2019 05:59:43 -0800 (PST)
Received: from [10.0.0.135] (24-212-162-241.cable.teksavvy.com. [24.212.162.241])
        by smtp.googlemail.com with ESMTPSA id y23sm5501330ita.1.2019.01.12.05.59.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jan 2019 05:59:42 -0800 (PST)
Subject: Re: [PATCH/RFC] Make perf_event_open() propagate errors for use in
 bpf_perf_event_open()
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Networking Development Mailing List 
        <netdev@vger.kernel.org>
References: <20190111155538.GX22483@kernel.org>
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Message-ID: <b7326024-de29-929d-e6f9-c24c230d45e8@mojatatu.com>
Date:   Sat, 12 Jan 2019 08:59:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190111155538.GX22483@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-11 10:55 a.m., Arnaldo Carvalho de Melo wrote:
> Hi Peter,
> 
> 	bpf_perf_event_open() already returns a value, but if
> perf_event_output's output_begin (mostly perf_output_begin) fails,
> the only way to know about that is looking before/after the rb->lost,
> right?
> 
> 	For ring buffer users that is ok, we'll get a PERF_RECORD_LOST,
> etc, but for BPF programs it would be convenient to get that -ENOSPC and
> do some fallback, whatever makes sense, like in my augmented_syscalls
> stuff for 'perf trace', i.e. don't augment it (i.e. push stuff at the
> end of the normal payload), just don't filter the
> raw_syscalls:sys_enter, 'perf trace' will get the enter syscall enter
> event without the pointer dereference at the end, etc, warn the user but
> don't lose a syscall in the strace-like output.	
> 
> 	What do you think? Am I missing something? Probably ;-)
> 
> 	Ah, its just test built.

Works as advertised ;->
Tested-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal
