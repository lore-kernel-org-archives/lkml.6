Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3C7ECE566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 00:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C8B421536
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 00:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="sV3mkYXy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C8B421536
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388686AbeIUGAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 02:00:48 -0400
Received: from sonic304-18.consmr.mail.bf2.yahoo.com ([74.6.128.41]:45053 "EHLO
        sonic304-18.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725869AbeIUGAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 02:00:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1537488881; bh=E/yt1JDo26weKI4VHA+N6C7Ayiti7zZBAg6RAyZfOZk=; h=Subject:From:To:Cc:References:Date:In-Reply-To:From:Subject; b=sV3mkYXyR5CXzlPnDWKRg3QZG7zPsiP7Di7xnRuGA5ua9PUYXEITSJaNsQJoTrQwce8Z3To6e8PxbXcH75LEdpTBw1ZCxIlqlNJbXVEz4bELaKlWOrQvuQDBsc37eII1bY4OpdcQUV0I0XrHBHwusbG7TEdGkUNkpUODxASq0NiXiBbQqW4x3t8RTk2jcxlOu4Fj95U0oN/S+8HbMAmOws0JN4tMSECg79cK9K7crZVJoAwT2obG6OFW9uefYRON+Eow0cDNz15rCZ7271tZtM16H/jcP14YGAFQKvHACxmOI0YfBL2l9w7CV9j4Dow8qMwG9ytN4h6pDKo3grN2cw==
X-YMail-OSG: 4a02VjMVM1lHUpysTm_Ru3VyzT4x4Lk_yXKPBE.1V4wh1gJ6.ankMjd3Oo41aj3
 OW2QF7mpx0qbFZjglOjHzl6Gt6bDr06qeQBb9O8Tc37a4KafnEUZkHQQYHB_wje6f5CUrUoY5Hvb
 qHZgFcStOVKeuKt0Q69HIolVaxpNIQv3iBRHe5v9QPfQf1dDaadGlG9cWBh8HIpnNth6r_0G92.v
 oC5B44YQlsrYb8pBV9oBjQWkl8iaBGEQBNc8tHMlb8qSQK3sH6_IlSCqMQdOpsVptxylLn0PihBe
 Qq1feX21tDvKNMWLcrDNmwUJ2tO.Iws0Tz2z6Rh_jbAgqqaMrOJZYU35.8ydi6n.V6l2Wevmgra2
 A0hwbA9UNEI31V5CB3ZaUEuJSI1oi.G6CAoxM.smfy08rk_2tPHQdnG6225yvObPZ1_8WcVjWTTI
 bn5Hq.g9kYE_LfuMtR6OLYRykfZSFJAzCHaUKDK6_8cDIWllNihoQzBxslxZ3.gso1TCkUqsMVLs
 udlDsqbN4C0LJjnQwvVqIAhArFTK9j_cFmNsBwKZDoZejTrf2n239.xx08QRgJFjrkTeQZ4e21AT
 1F6v0ys9XkcnwBV2szoE7PZLfkqgTZEdgfWIsYmuDt9YNyRo2_Rwk0vuX98cbpsMqBIinREQDD3p
 PvXByuQWQczYExt8cBBi_52ejeEjN_cRx.dYWPjXxIsqntO9MsPd9CKMEHG8gjFinpwdC5ngKP8B
 RP7TpJJdPZLpuNqPfmVzEsc9M4HBL81t2Cw6pxkCrV2D0YL2x4BoYCmWmJttf4Uxvu.q28gQC7g2
 hPAThkrxGmvU9lOtRvbc7vAt1MY2LpbjZf_2sqU3kJLDSNNE0RP8b9efd9Ya86L3guBg5S7meE75
 jAigUJ7eNmAJLYV6a7xbdFAz2U8pxFbHxudns4a2Huq3g04ntMYbluAmG8.viygDKZTmwTpT1HxD
 kLYeHrII0ZVz2Qput8DmMFA1ngPMpM99SL3m2Z5InKwFlRC0EGCcj7Ew2UsMCPZuFkd1q4xBnl4h
 gIkaSwC9JzRjzDYGl_kB3lMkY6WaeN5DgRqPPgA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.bf2.yahoo.com with HTTP; Fri, 21 Sep 2018 00:14:41 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp405.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID c452f7b141a744a99a2ecd2c73b7e72c;
          Fri, 21 Sep 2018 00:14:39 +0000 (UTC)
Subject: Re: [PATCH security-next v2 19/26] LSM: Introduce CONFIG_LSM_ORDER
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     Kees Cook <keescook@chromium.org>, James Morris <jmorris@namei.org>
Cc:     John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180920162338.21060-1-keescook@chromium.org>
 <20180920162338.21060-20-keescook@chromium.org>
 <25825681-a465-684d-d48e-79473bca7606@schaufler-ca.com>
Message-ID: <17226f0a-e320-dab0-8691-aa0a22f07544@schaufler-ca.com>
Date:   Thu, 20 Sep 2018 17:14:35 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <25825681-a465-684d-d48e-79473bca7606@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/2018 5:10 PM, Casey Schaufler wrote:
> On 9/20/2018 9:23 AM, Kees Cook wrote:
>> This provides a way to declare LSM initialization order via Kconfig.
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>  security/Kconfig    | 11 +++++++++++
>>  security/security.c | 38 +++++++++++++++++++++++++++++++++++---
>>  2 files changed, 46 insertions(+), 3 deletions(-)
>>
>> diff --git a/security/Kconfig b/security/Kconfig
>> index 27d8b2688f75..de8202886c1d 100644
>> --- a/security/Kconfig
>> +++ b/security/Kconfig
>> @@ -276,5 +276,16 @@ config DEFAULT_SECURITY
>>  	default "apparmor" if DEFAULT_SECURITY_APPARMOR
>>  	default "" if DEFAULT_SECURITY_DAC
>>  
>> +config LSM_ORDER
>> +	string "Default initialization order of builtin LSMs"
>> +	default "integrity"
> I would like to see the default spelled out rather than
> provided implicitly.
>
>   +	  default "integrity,yama,loadpin,selinux,smack,apparmor,tomoyo"

I see now that comes later in the patch set. Never mind.

