Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D1F0C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E890C20883
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="RQXK6BmI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E890C20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbeGZJEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 05:04:40 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43676 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728749AbeGZJEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 05:04:40 -0400
Received: by mail-lj1-f193.google.com with SMTP id r13-v6so668744ljg.10
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 00:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wH6jEE4tEDnjxHiTEgkraSPGXLtShOquLCetIgdPezU=;
        b=RQXK6BmI/Q5NcCGqejkVGiVn171f1Bz4I34XaMGpNUg7DHmi9RJjh5b8xvORl6E/WW
         DCbG0xPVFKAl5AXCG5cFM83GdXZ34NhtoAHKEkLLMCEFm4ZuiB56/Muz4SWwM0OsoUYE
         hbOBHnDpeyKknlij2HCAxOEgdcR5YEIF6H6M8LjY5gdQOtQo6KXLuZubaxmTdICxnpds
         FNKntaZJUJjAMfx7UnoWOKqrPRqcVgsyK/aMTnqytzcwIn+D+jzQCOzWb8WKOnmuyc3p
         t+P4t6mGCi2tQfyu1OEmm8xlFCuYB1QQ499ZNRupwQ3Qlfiij9xcBxPN2TOQrQ0UWz9L
         yRoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wH6jEE4tEDnjxHiTEgkraSPGXLtShOquLCetIgdPezU=;
        b=nQ/QyYQOsgR6OGJZsi8mZ12N5dfHQnKqH0sacy+3TifqT3qXzbreFjh/1cROn7OQpl
         e3BC0pr3wtGx1RSM32LqoK2Bi9P3wInuVlyhWqNNGTQJKJTori6e7LsAu1k7uwWfhgMD
         jnVslmvvSoam9Uix6XjIMk4YI4lnqAnoNkIEtCvxWRkAKOG7UBbEgnSU5XbfuJgybuZz
         WRlDKA2UFujw7gD7+5+efilMlHp4kkuGGDQNQHyx0KfrKjx66ScQU5tlXj6+CGJE1lvx
         QfvVS+BcG+QHpk29wslEE78xJnkGzlYu1gR7FIBG+LWo5+ik2XLdEfs2T4kFB5Mlxu4+
         XlCA==
X-Gm-Message-State: AOUpUlEOfmCqgQ65TRvUVMS4ZlMpqTFEfMt0nj2bgtfzKPWd7q1EdMha
        22qhARfO6upoKtvc57JoGa4BbjSQqQE=
X-Google-Smtp-Source: AAOMgpcDBljV9GJhVKSz50InkqrzH6DDxoJFEhBUIbgFfLQjulabORqqdsIQM2fK4rCg1jOOVeuXEw==
X-Received: by 2002:a2e:9dc7:: with SMTP id x7-v6mr732346ljj.142.1532591343186;
        Thu, 26 Jul 2018 00:49:03 -0700 (PDT)
Received: from [192.168.0.126] ([31.173.87.248])
        by smtp.gmail.com with ESMTPSA id c83-v6sm88218lfg.18.2018.07.26.00.48.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 00:49:01 -0700 (PDT)
Subject: Re: [PATCH 1/4] docs: bpf: Rename README.rst to index.rst
To:     "Tobin C. Harding" <me@tobin.cc>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-doc@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180725022926.8993-1-me@tobin.cc>
 <20180725022926.8993-2-me@tobin.cc>
 <0141716c-e909-1429-68fe-6da71d4c6677@cogentembedded.com>
 <20180725222823.GD6067@eros>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <b19e7506-30d1-7935-ceff-b9aa665dbe49@cogentembedded.com>
Date:   Thu, 26 Jul 2018 10:48:50 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180725222823.GD6067@eros>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/2018 1:28 AM, Tobin C. Harding wrote:

>>> Recently bpf/ docs were converted to us RST format.  'README.rst' was
>>
>>     s/us/use/?
> 
> Thanks for the review Sergei, will fix and re-spin.

    Perhaps could be fixed while applying...

>>> created but in order to fit in with the Sphinx build system this file
>>> should be named 'index.rst'.  Rename file, fixes to integrate into Sphinx
>>> build system in following patches.
>>>
>>> docs: Rename Documentation/bpf/README.rst to Documentation/bpf/index.rst
>>>
>>> Signed-off-by: Tobin C. Harding <me@tobin.cc>
>> [...]
>>
>> MBR, Sergei
> 
> What does MBR stand for please (not master boot record I'm guessing)?

    My best regards. :-)

> 	Tobin

MBR, Sergei
