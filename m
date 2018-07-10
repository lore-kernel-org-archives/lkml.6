Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B139AC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 09:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FDDF2089B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 09:46:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FDDF2089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932813AbeGJJqm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 05:46:42 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:38003 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751194AbeGJJqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 05:46:40 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="42059564"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 10 Jul 2018 17:46:38 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id E83C24B473FE;
        Tue, 10 Jul 2018 17:46:37 +0800 (CST)
Received: from [10.167.226.60] (10.167.226.60) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.399.0; Tue, 10 Jul 2018 17:46:41 +0800
Subject: Re: kconfig usage in automatic kernel test
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
CC:     Michal Marek <michal.lkml@markovi.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
References: <a2a39cac-79fc-22d9-e1d0-b94787526794@cn.fujitsu.com>
 <CAK7LNAQnpQn5k0fkb+nSASe7qg1UgX6BhdR-3EEuSX=xOuPhrw@mail.gmail.com>
From:   Cao jin <caoj.fnst@cn.fujitsu.com>
Message-ID: <b74953cd-0917-7c02-78e0-516485072601@cn.fujitsu.com>
Date:   Tue, 10 Jul 2018 17:45:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNAQnpQn5k0fkb+nSASe7qg1UgX6BhdR-3EEuSX=xOuPhrw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.60]
X-yoursite-MailScanner-ID: E83C24B473FE.AA120
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/08/2018 10:15 AM, Masahiro Yamada wrote:
> 2018-07-06 17:49 GMT+09:00 Cao jin <caoj.fnst@cn.fujitsu.com>:
>> Masahiro-san,
>>
>>   I am writing some utility for internal kdump test with latest kernel,
>> my purpose is to test the new introduced kernel feature. For automatical
>> test, I see several config target could help, like olddefconfig, all*config.
>>
>> But for my purpose, I don't find a good way. For example, olddefconfig
>> will let the now config item has default value, while some feature may
>> default to "N"; allyesconfig will slow the compilation notably.
>> But "all*config" has KCONFIG_ALLCONFIG help to customizing some config
>> item, that is a good utility, but seems it can't be used in olddefconfig.
>>
>> All these things let me have 2 questions:
>>
>> 1. What would you suggest for my purpose?
> 
> 
> scripts/kconfig/merge_config.sh
> can be used with any *config target.
> 

I took a quick glance at the script, it seems a good method to me.
Thanks very much, Masahiro-san.

> If you want to tweak some symbols based on olddefconfig,
> this could be the one you want.
> 
> 
>> 2. allyesconfig, allmodconfig, randconfig seems useful for test kbuild,
>> but what's the purpose of allnoconfig, alldefconfig? In others words,
>> when people would need allnoconfig, alldefconfig?
> 
> I sometimes use allnoconfig for build testing.
> 
> When I want to test the whole build process quickly,
> I disable as many drivers as possible to save time.
> 
> 
> I do not use alldefconfig.
> Anyway, it would not hurt to have it for completeness.
> 

Thanks for clarifying.

-- 
Sincerely,
Cao jin


