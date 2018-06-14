Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A6FBAC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A80F208B8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="V5b4Aau/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A80F208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755098AbeFNLmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 07:42:20 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:41202 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754912AbeFNLmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 07:42:18 -0400
Received: by mail-pg0-f68.google.com with SMTP id l65-v6so2803941pgl.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 04:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dzBLKrWSoS3atBjEk7O/H3sfpLhAL9vaJhj7FVUsuxU=;
        b=V5b4Aau/hPrQU27slbVAB5kxJhco2ZKp+ORzx2G2pR5L2/u3nQ04+1E9J2WkIqdkNy
         ZBhgSJlYmTFFdqO286O4MX+lHHQ42nD/V7uiQyAcvFYBHAKycTIJuQdzbKSzfcNP7G8w
         KASAc3U1fkM3y+doo387ISGwI3PmWY8i1MVhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dzBLKrWSoS3atBjEk7O/H3sfpLhAL9vaJhj7FVUsuxU=;
        b=hRNume3L9Iz3j/RiAdfZ3OUdj/WTGXd7izVAQMZA+stE28L28f3TA0N/Oa6gdjKmWF
         lV6A3UVWb3lvDEIdwMiScqK6rQ7tQLbs0gqYue2roqk1DE9G7lhHwgNX1ylNHsznmWxj
         TUyMKB57DUIRquYJmbZOgx+awLoXGIrGBciWAi+EfzJswUR2X9ayuz+uAydxbKAcRkwV
         4HC6tVjoShz/qHXcYsFa5vSFVjI+Z0Y6sYMpvlpbHgXfRjB24pJEHA40ARacqjdNops6
         Wrgcpc+5UdwJNucCI/Va3OQ5tT70/tlR01I6W/KiahDqa/Gb7FM+ag8Vht1yVrcW7PSp
         ldfw==
X-Gm-Message-State: APt69E0LbNvhnQ1ILfeP5rVpVxCdyenC5MgznYG9LDmMqaPcKel8f5M3
        1OAM2hu0cImXg00Y0aA7CDK+MuOv2gOLVRCjAmFPmw==
X-Google-Smtp-Source: ADUXVKJISlRAY9TnQ66H7KIK86gf5uE+9wXmAQweyzugnGphhp6opBV6VpDLi80f5vigsJJ+i9Reqa789VRN93tw4Sk=
X-Received: by 2002:a63:ba56:: with SMTP id l22-v6mr2009793pgu.161.1528976538132;
 Thu, 14 Jun 2018 04:42:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:178d:0:0:0:0 with HTTP; Thu, 14 Jun 2018 04:42:17
 -0700 (PDT)
In-Reply-To: <CALDO+SY3qNYAOSiYC3645C7YY9LSx7ggg0GjY76m4TbBfF_t3A@mail.gmail.com>
References: <20180612110510.11731-1-anders.roxell@linaro.org>
 <d6851756-ae3b-09ec-f487-1eeece6bd4c6@iogearbox.net> <CALDO+SY3qNYAOSiYC3645C7YY9LSx7ggg0GjY76m4TbBfF_t3A@mail.gmail.com>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Thu, 14 Jun 2018 13:42:17 +0200
Message-ID: <CADYN=9+3V4fpqbjh-X4VUVWd_X38XSYhEbZoRBffcx=-nMtF8g@mail.gmail.com>
Subject: Re: [PATCH] selftests: bpf: config: add config fragments
To:     William Tu <u9012063@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 June 2018 at 13:06, William Tu <u9012063@gmail.com> wrote:
> On Tue, Jun 12, 2018 at 5:08 PM, Daniel Borkmann <daniel@iogearbox.net> wrote:
>> On 06/12/2018 01:05 PM, Anders Roxell wrote:
>>> Tests test_tunnel.sh fails due to config fragments ins't enabled.
>>>
>>> Fixes: 933a741e3b82 ("selftests/bpf: bpf tunnel test.")
>>> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
>>> ---
>>>
>>> All tests passes except ip6gretap that still fails. I'm unsure why.
>>> Ideas?
>
> Hi Anders,
>
> ip6erspan is based on ip6gretap, does ip6erspan pass?

it did pass  when I was sending the email.
However, I retested this on next-20180613 and now it fails.

Cheers,
Anders
