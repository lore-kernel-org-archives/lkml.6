Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ACFFC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 16:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0EC22086A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 16:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="opYxqb18"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0EC22086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390090AbeKQDBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 22:01:01 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44990 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728684AbeKQDBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 22:01:01 -0500
Received: by mail-pl1-f196.google.com with SMTP id s5-v6so11404035plq.11
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 08:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JFVJBaYguqGCKJtcsGe5WbB08SY2ALelAJkTOtnrLis=;
        b=opYxqb186lgIwj0V1z0qYH6J8bVvV6+tOcgp6Tduo++10Y/pbgUFB3sZiBW0ebvJ0/
         NASNmA1UOt9D83jU8oYXdQuRufdsGUfdGEr2dnCdMLgFx4p0UC7+PtQYZ+Ns8wiTlFOU
         cnaPYVbtP5N/4k2hzcyEZ8zWM+iwRIp3hDPh1vnifWSKsefuIc90bZW1qseLO6Y5O8AM
         gySyKPmnNq7fUjh67Y8Tyn8KfNgoFNQaiiW3Vd6jH9NVP7vN/jWn4MZ4QxV/OKAGY/s3
         ojR9IcpZPeg18ZqiA4fx7NKccI/KFooSwqmJ1leuELO5AST0isdwef6o8oc2y7k6JKfT
         1KUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JFVJBaYguqGCKJtcsGe5WbB08SY2ALelAJkTOtnrLis=;
        b=GGvBdYsK5T45hUWJA3NO2z2piztwpEmd+NxsQJAq0iro7MS7AzYgk85yJN6dZRWPfy
         NX6JYmQjIqOfGpjLjgkNB+tX4Z076nr4XsU5BylHz112g0vdfOggO8panaN/xgDjJase
         06h7bTcFDGb/agrJcQrFFfFqgQLdc4LpsLKzMhsrtLfL87uTBaDqbGGcsVDdoZejO4KN
         EmOJ/aW8djwZj60BeFNawCudGeKv4TPTMnPUohLR0KiF2M49/6HX9GM2uvI8xSGkUAQ8
         bOiELJzrBFNCbBu2iBLYpgsNAKrOM8vEIof2M/qzzYALRtd8+UJ18bouv3dmr7kr8vwj
         bBrA==
X-Gm-Message-State: AGRZ1gLwggfYnNYui9hlsMKjb6OpYL58j3rJkxF22KVfRbEsVSCX8gIN
        p/gmChgNUuL4MTjKIVPWsTQ=
X-Google-Smtp-Source: AJdET5fa24JuAVylviWiELOX+spomOUWStNrw9xAvqpT24I9EUpuDGu8S+5ZcSor4YIO/ldWizoOaw==
X-Received: by 2002:a17:902:509:: with SMTP id 9-v6mr11472855plf.3.1542386873729;
        Fri, 16 Nov 2018 08:47:53 -0800 (PST)
Received: from [192.168.36.170] ([64.114.255.114])
        by smtp.gmail.com with ESMTPSA id u7-v6sm22665112pfu.34.2018.11.16.08.47.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 08:47:53 -0800 (PST)
Subject: Re: [Ksummit-discuss] [RFC PATCH 2/3] MAINTAINERS, Handbook:
 Subsystem Profile
From:   Frank Rowand <frowand.list@gmail.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     vishal.l.verma@intel.com,
        ksummit-discuss@lists.linuxfoundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-nvdimm@lists.01.org, Dmitry Vyukov <dvyukov@google.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Steve French <stfrench@microsoft.com>,
        "Tobin C. Harding" <me@tobin.cc>
References: <154225759358.2499188.15268218778137905050.stgit@dwillia2-desk3.amr.corp.intel.com>
 <154225760492.2499188.14152986544451112930.stgit@dwillia2-desk3.amr.corp.intel.com>
 <9f6aece0-da64-78b5-0eda-fe039fc1ad09@gmail.com>
Message-ID: <ad84cf38-279e-1e14-9635-23ad2efe584d@gmail.com>
Date:   Fri, 16 Nov 2018 08:47:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <9f6aece0-da64-78b5-0eda-fe039fc1ad09@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/18 4:11 PM, Frank Rowand wrote:
> On 11/14/18 8:53 PM, Dan Williams wrote:

< snip >

>> +
>> +
>> +Time Zone / Office Hours
>> +------------------------
>> +Let contributors know the time of day when one or more maintainers are
>> +usually actively monitoring the mailing list.
> 
> I would strike "actively monitoring the mailing list".  To me, it should
> be what are the hours of the day that the maintainer might happen to poll
> (or might receive an interrupt) from the appropriate communications
> channels (could be IRC, could be email, etc).
> 
> For my area, I would want to say something like: I tend to be active
> between 17:00 UTC (18:00 UTC when daylight savings) and 25:00 (26:00),
> but often will check for urgent or brief items up until 07:00 (08:00).
> I interact with email via a poll model.  I interact with IRC via a
> pull model and often overlook IRC activity for multiple days).

  ^^^^ typo, that should be "poll", not "pull"

> 
> -Frank
> 

> 

