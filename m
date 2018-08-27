Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A7EC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A466C20658
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20150623.gappssmtp.com header.i=@mojatatu-com.20150623.gappssmtp.com header.b="x6OrzxAe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A466C20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbeH0Pd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 11:33:58 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:39005 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbeH0Pd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 11:33:56 -0400
Received: by mail-io0-f193.google.com with SMTP id l7-v6so12518910iok.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 04:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=7d+nuv8T6V3cx/jA5Jk9stv49frCzwQ568PgwcO1x3U=;
        b=x6OrzxAekMfzQrPI4HVNGR5Xlt8NaovC9V/vcw1R2Nzu1BgI0orC92jFVoUDgUiYtx
         xMV1ruIIBhW+APpov4hNvXE52cs/+oF1xwZKMsrY0oDjqzZ6wWWAWHF2pQNLRXEctSIy
         CPrhcih18KNl4C8IkA2YrfLZllX2vsHPYHtV3ZRj32mMEIm23pfKebP0lytZObzArFeJ
         mJZmmLl0z9KfFgsQ1259T3T7dJBzEns0mBpC8vlp/eguM7MJq1ivjVdXvAZNZP4q2fn9
         Y0EQa9LlDmlrwoLjXwGT8+eDJnLewI+31UUwusu1jo8X6UaOHEkIiFjWqpnIxYLRdOLb
         2DHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=7d+nuv8T6V3cx/jA5Jk9stv49frCzwQ568PgwcO1x3U=;
        b=YKWH0DYfpbu9b5lsIyxXMg1fPBRTpHcoYtYq4OBWvxLW3K/FRQgd7+Gvyt+NU8zAmU
         hxOcegQZxipeyL1r0CkaEzHDDDcgE3OkGvWbBwDeGyg7WLWnwCAtMle4gdrR+OhN4msw
         uEme8YzQaHeCpkzSS8RBLqZk4v428yMTm9OCG9ai/r7DWwLhLPg9Tl3TO5jNx8JbZBKF
         UG/OO8IREIeBmVkdVgmvBHE15bsDHKihR+NEiQs72WOLMK1xi2wjyHgUagsDaJSrcoJn
         RM75PBd3kyaAtRAWdnl5G2gSIV/8vp7gWGybrLlGTR6FmpVNFk+wfYZjzEwVQt5pXO8q
         ic2Q==
X-Gm-Message-State: APzg51BtsdtXqHo20mGGzBKJy5/E+lFH2aGPF/5QPFGXLxH4uFVetXGT
        NCQvlVI1BoFBRKx4z2O/B1/t4A==
X-Google-Smtp-Source: ANB0VdZY0ioC3muKqHEdpIT/f++xvnUsxfUzuJw5IpsUVlUAsVPdnatY5BT2U7I+ApnnmjSPv+5YlA==
X-Received: by 2002:a6b:9f46:: with SMTP id i67-v6mr3508156ioe.182.1535370455836;
        Mon, 27 Aug 2018 04:47:35 -0700 (PDT)
Received: from [10.0.0.137] (198-84-205-232.cpe.teksavvy.com. [198.84.205.232])
        by smtp.googlemail.com with ESMTPSA id o8-v6sm5865165ioh.56.2018.08.27.04.47.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 04:47:34 -0700 (PDT)
Subject: Re: [PATCH] net: sched: Fix memory exposure from short TCA_U32_SEL
To:     Kees Cook <keescook@chromium.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>
References: <20180826055801.GA42063@beast>
 <20180826061534.GT6515@ZenIV.linux.org.uk>
 <CAGXu5jK7VzayzZTcxgZBf-+YHWO+Hv7s8utj2rzTc3gFtA8pFQ@mail.gmail.com>
 <5c88b08d-b9ca-f3df-ae78-cf685ee6723a@mojatatu.com>
 <CAGXu5jJZ-BfJPA+m1BOuVVQxPb8SXpSRo+F2cVTF62C9JTyRXQ@mail.gmail.com>
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Message-ID: <d68f13e6-339a-2a40-9c0d-7549cd9aabb3@mojatatu.com>
Date:   Mon, 27 Aug 2018 07:46:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAGXu5jJZ-BfJPA+m1BOuVVQxPb8SXpSRo+F2cVTF62C9JTyRXQ@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------CFDA4ED4F955F7BF032C8AE4"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------CFDA4ED4F955F7BF032C8AE4
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2018-08-26 5:56 p.m., Kees Cook wrote:
> On Sun, Aug 26, 2018 at 10:30 AM, Jamal Hadi Salim <jhs@mojatatu.com> wrote:
>> We should add an nla_policy later.
> 
> What's the right way to do that for cases like this?

Meant something like attached which you alluded-to in your comments
would give an upper bound (Max allowed keys is 128).

cheers,
jamal

--------------CFDA4ED4F955F7BF032C8AE4
Content-Type: text/plain; charset=UTF-8;
 name="patchlet"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="patchlet"

ZGlmZiAtLWdpdCBhL25ldC9zY2hlZC9jbHNfdTMyLmMgYi9uZXQvc2NoZWQvY2xzX3UzMi5j
CmluZGV4IGQ1ZDJhNmRjMzkyMS4uY2I3YTNmYTBlNzI4IDEwMDY0NAotLS0gYS9uZXQvc2No
ZWQvY2xzX3UzMi5jCisrKyBiL25ldC9zY2hlZC9jbHNfdTMyLmMKQEAgLTc2MSw3ICs3NjEs
OSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG5sYV9wb2xpY3kgdTMyX3BvbGljeVtUQ0FfVTMy
X01BWCArIDFdID0gewogCVtUQ0FfVTMyX0hBU0hdCQk9IHsgLnR5cGUgPSBOTEFfVTMyIH0s
CiAJW1RDQV9VMzJfTElOS10JCT0geyAudHlwZSA9IE5MQV9VMzIgfSwKIAlbVENBX1UzMl9E
SVZJU09SXQk9IHsgLnR5cGUgPSBOTEFfVTMyIH0sCi0JW1RDQV9VMzJfU0VMXQkJPSB7IC5s
ZW4gPSBzaXplb2Yoc3RydWN0IHRjX3UzMl9zZWwpIH0sCisJW1RDQV9VMzJfU0VMXQkJPSB7
IC50eXBlID0gTkxBX0JJTkFSWSwKKwkJCQkgICAgLmxlbiA9IChzaXplb2Yoc3RydWN0IHRj
X3UzMl9zZWwpICsKKwkJCQkJICAgICgxMjgqc2l6ZW9mKHN0cnVjdCB0Y191MzJfa2V5KSkg
fSwKIAlbVENBX1UzMl9JTkRFVl0JCT0geyAudHlwZSA9IE5MQV9TVFJJTkcsIC5sZW4gPSBJ
Rk5BTVNJWiB9LAogCVtUQ0FfVTMyX01BUktdCQk9IHsgLmxlbiA9IHNpemVvZihzdHJ1Y3Qg
dGNfdTMyX21hcmspIH0sCiAJW1RDQV9VMzJfRkxBR1NdCQk9IHsgLnR5cGUgPSBOTEFfVTMy
IH0sCg==
--------------CFDA4ED4F955F7BF032C8AE4--
