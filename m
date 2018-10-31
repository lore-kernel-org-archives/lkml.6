Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1835C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 22:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 303362080A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 22:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nw5gQQ4s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 303362080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbeKAHVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 03:21:31 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41316 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbeKAHVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 03:21:30 -0400
Received: by mail-wr1-f65.google.com with SMTP id x12-v6so18177162wrw.8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 15:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Yp7XIPfXwDVhr7HEqIAgcesbzRubt68QHM5Iz3gTfaY=;
        b=nw5gQQ4sOU+qHj8KqvoM5JROT2O5NCz1u11jxn+2ASDY/8/tFAudbGMrFU/rNQ4QA1
         i/30laAsKS2FK1BNh/NVCwOHzHVwLTcUb3EFekDGkqdUjQvUwWQTEcXH6y5EzAp6+8YF
         yoXRNJwKbCq/DSiVTHIiZ54X2NKqUXp3GPA3WKa+da7XiWj/vjj2dIID6nqAHW2ZiHV7
         ABMW7zdsmYS6HB/AZyElo4wyaq2kGznGBEDnYe4LVcsokEjsZi+JJla2lDrPpY3B/69j
         bZ+3Abn39ZLhRIUWYBjwDhsxLOMDkB0NU0sUe3ZLjmpS21SNPdF1V+nfBUCwonMlfKyL
         PPfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Yp7XIPfXwDVhr7HEqIAgcesbzRubt68QHM5Iz3gTfaY=;
        b=uIKmK77ElsHGZJNNgOKaAh0AJRg+o9FzVMJAE5e1rmaSIlZvxDNMNeEdoUWErhwxrj
         YIrALCzNlYxRmT33xwQJg/nqw/QJbCpKpLz4ekbPhM7Y8aPQRClgUZZaqefRJMkAIqXe
         qxh2uCW0m2+VrHh47s/NJb+jTehtpCeSIKSQfgG4jVM1u1dTIUaCByTz4+y/TsuUncGl
         xUZa2Fnn5jUlrBsB7vAbNbylYYPxY8xSXRbo/UsFqKMoUa55zNX8wUVqgxSLHICV4ihR
         jS3SxSNr5iPirIlpBWrIswD2fQVCaX5uXIER9h0vRkJpJpe39lHD2jD2r+cGsR5l7w+T
         HYDg==
X-Gm-Message-State: AGRZ1gJ7S5Dyczm79jZE/os7p8IJ5+y0ORsLRhMJp3p/ZaA7VkUVbt/p
        oJjDWhILt90Qeq3BU2vHxnQ=
X-Google-Smtp-Source: AJdET5eMVPiamRKbOVBBXD74TmJN6zFb5ZuEHfoj7mapr7+JHq/a/HDLPjma+Aae0YK1cSOuuD40uQ==
X-Received: by 2002:a5d:618a:: with SMTP id j10-v6mr4757169wru.300.1541024487417;
        Wed, 31 Oct 2018 15:21:27 -0700 (PDT)
Received: from [10.67.49.121] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id r198-v6sm4032720wmg.0.2018.10.31.15.21.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 15:21:26 -0700 (PDT)
Subject: Re: [PATCH 0/2] perf tests: Check for ARM [vectors] page
To:     linux-arm-kernel@lists.infradead.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kim Phillips <kim.phillips@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        open list <linux-kernel@vger.kernel.org>,
        rmk+kernel@armlinux.org.uk, l.stach@pengutronix.de
References: <20181025000905.6095-1-f.fainelli@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <b4fffe21-cc0d-f691-29fe-a9deda2f7ba1@gmail.com>
Date:   Wed, 31 Oct 2018 15:21:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181025000905.6095-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/18 5:09 PM, Florian Fainelli wrote:
> Hi all,
> 
> I just painfully learned that perf would segfault when
> CONFIG_KUSER_HELPERS is disabled because it unconditionally makes use of
> it. This patch series adds an ARM test for that by leveraging the
> existing find_vdso_map() function and making it more generic and capable
> of location any map within /proc/self/maps.

Any feedback on this?

> 
> Florian Fainelli (2):
>   perf tools: Make find_vdso_map() more modular
>   perf tests: Add a test for the ARM 32-bit [vectors] page
> 
>  tools/perf/arch/arm/tests/Build          |  1 +
>  tools/perf/arch/arm/tests/arch-tests.c   |  4 +++
>  tools/perf/arch/arm/tests/vectors-page.c | 20 +++++++++++++++
>  tools/perf/tests/tests.h                 |  5 ++++
>  tools/perf/util/find-map.c               | 31 ++++++++++++++++++++++++
>  tools/perf/util/find-vdso-map.c          | 30 +++--------------------
>  6 files changed, 64 insertions(+), 27 deletions(-)
>  create mode 100644 tools/perf/arch/arm/tests/vectors-page.c
>  create mode 100644 tools/perf/util/find-map.c
> 


-- 
Florian
