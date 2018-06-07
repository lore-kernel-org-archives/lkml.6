Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id EwSWDS0FGVsLMgAAmS7hNA
	; Thu, 07 Jun 2018 10:13:01 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 19D1B607E7; Thu,  7 Jun 2018 10:13:01 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SbB+CR4b"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9F65260452;
	Thu,  7 Jun 2018 10:13:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9F65260452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753699AbeFGKM6 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 06:12:58 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:35258 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753292AbeFGKMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 06:12:54 -0400
Received: by mail-io0-f194.google.com with SMTP id u4-v6so11177626iof.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 03:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HtNImZI8QtpFGGA/3JWla0D+AKZLy54K1XAVDc2EKtY=;
        b=SbB+CR4bap1yvkhOYCg5IvzN74D0Hku1c4OOn9ksuu5tBnlEblbCjP9C+0fs7q/1fg
         KbpX6wf5tdsA7SmQKrJiamioM9fQmyGhA/HAhFUSg5AX56r6aDf9+dJhzy6gRdxW0WKN
         Z7zpAZwfXcEPXXAxyQ8BnlnmCnciLIQEddRVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HtNImZI8QtpFGGA/3JWla0D+AKZLy54K1XAVDc2EKtY=;
        b=S3lTNvoAtuqPGUhczdy4mlQi49hl7/NTPyJbXsYEcM/5U0qwybHS1Uu5spplJc/WFq
         KBUFCJKKlt1/+TWEBDfJ+sL4haDOyvYkXMLOvD3zpLRvxs/tv5h7/c0FnKHjyUTFeUzm
         73AJTCEyM14iML5Sn45ODaItHpaSDhnpusTUQAaeSDILCeudqHL7P1Qt4daG7xSVluzC
         ieD9oTy/S0rQQwDSN05AZa3s34NM7bVA1bESV7dgEhVypvVaWBOCTEvMWfXsAMqNrf1q
         H1qCheWcY//UO4lpcwGieDNu3uES5q3Ob/+887GuhbcRUR+Il+NlSaoUMHbl0V9zJM8m
         GHtg==
X-Gm-Message-State: APt69E0JGd065UQp6PdnDVUJenIZ66PCycwa0o6LKSC95/oGGhc3cIeS
        ASdP2pP94ABFNSWI8MpeBWFsxg==
X-Google-Smtp-Source: ADUXVKLa36Af3vyz2XTikvU5fpztq2pkV2aU4OWayLMZVdsrFgzsnk1t3WxlLjV4emNU+cf4y9UCNQ==
X-Received: by 2002:a6b:5a0a:: with SMTP id o10-v6mr941119iob.244.1528366373408;
        Thu, 07 Jun 2018 03:12:53 -0700 (PDT)
Received: from [172.22.22.26] (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.googlemail.com with ESMTPSA id n5-v6sm7088607ioa.42.2018.06.07.03.12.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 03:12:52 -0700 (PDT)
Subject: Re: [PATCH v5 2/4] kernel hacking: new config NO_AUTO_INLINE to
 disable compiler auto-inline optimizations
To: Viresh Kumar <viresh.kumar@linaro.org>,
        Johan Hovold <johan@kernel.org>
Cc: Bernd Petrovitsch <bernd@petrovitsch.priv.at>,
        "Du, Changbin" <changbin.du@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        gregkh@linuxfoundation.org, alex.elder@linaro.org,
        kbuild test robot <lkp@intel.com>,
        linux-arch@vger.kernel.org, michal.lkml@markovi.net,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        yamada.masahiro@socionext.com, lgirdwood@gmail.com,
        broonie@kernel.org, rdunlap@infradead.org, x86@kernel.org,
        linux@armlinux.org.uk, linux-sparse@vger.kernel.org,
        mingo@redhat.com, kbuild-all@01.org, akpm@linux-foundation.org,
        changbin.du@gmail.com, tglx@linutronix.de,
        linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <201806060501.btF3aJMZ%fengguang.wu@intel.com>
 <20180606095714.1d3c2def@vmware.local.home>
 <20180606142600.GN13775@localhost>
 <20180606142622.2338abf6@vmware.local.home>
 <20180607041718.qpqucjzlvcm5h3gn@vireshk-i7>
 <20180607074628.kd3iyxevwj3ypzbr@intel.com>
 <20180607083856.ealw62v3wx43zeqz@vireshk-i7>
 <1303b1abf9f9229a8d3ccbb68a3e413266b360d7.camel@petrovitsch.priv.at>
 <20180607091025.m7dfix3e2xbwx4cs@vireshk-i7>
 <20180607091816.GT13775@localhost>
 <20180607091923.n5q5uzsxuymy3vov@vireshk-i7>
From: Alex Elder <elder@linaro.org>
Message-ID: <314bb2b3-186e-d7b0-d800-f77a42fd80fa@linaro.org>
Date: Thu, 7 Jun 2018 05:12:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180607091923.n5q5uzsxuymy3vov@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/2018 04:19 AM, Viresh Kumar wrote:
> On 07-06-18, 11:18, Johan Hovold wrote:
>> If you want to work around the warning and think you can do it in some
>> non-contrived way, then go for it.
>>
>> Clearing the request buffer, checking for termination using strnlen, and
>> then using memcpy might not be too bad.
>>
>> But after all, it is a false positive, so leaving things as they stand
>> is fine too.
> 
> Leave it then :)
> 

It's interesting that the warning isn't reported for this in
fw_mgmt_interface_fw_version_operation().  The difference there is
that you actually put a zero byte at that last position before
returning.  I'm mildly impressed if gcc is distinguishing that.

You *are* returning the fw_info->firmware_tag array newly filled
with a non-null-terminated string in one of the two cases that
get warnings in "fw-management.c".  But the other one is only
updating a buffer in a local/automatic variable.

Weird.  I wish there were a non-clumsy way of marking false positives
like this as A-OK.

					-Alex
