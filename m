Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881EDC5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 19:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C212075E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 19:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="rbKxbSnK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40C212075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936249AbeFRTS3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 15:18:29 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:44771 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936040AbeFRTS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 15:18:27 -0400
Received: by mail-pg0-f52.google.com with SMTP id p21-v6so7963190pgd.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 12:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=MEGMrQazpc74n9IOCwqfsLFkAPFgwcCj8Cly9S0nyAg=;
        b=rbKxbSnK4IeHQv2k+AxOWGSXMqe6aBfM4rkVB5ekWOTvnKeX09NREr3g2cLTJOBmCt
         6L5bjoOmkv2ZfSfJvO46xLcG4gk/h5AhMfMGmdjZyrhda77AgTJtUkgvQnwgOYlhqGI6
         B1ArjTufq3nWWQGSfwAmUfDcKFLi20VFkvBksDdPRIOrSrkA/Fs2inc6mxPz/ffE9AmT
         xJJtCSo4t/F/UCOyYjRzN0p3Klw5VUyS5m/x+cR0iJSnGJ1kTMSp0m/pvWWkC+h2V0P3
         mGRWOMoz2szqnwiJexY7MWrKfPLJvirLTN5KUWQI5sprTssD7vpHXVyW+D4Pw7AmN4Lh
         nRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=MEGMrQazpc74n9IOCwqfsLFkAPFgwcCj8Cly9S0nyAg=;
        b=Sv40FeLByKyU8+jkcsXfRAdlmRJS0fkVwrgPX4BocuA8eGimxjyg5M9MiZvU087A2K
         9bHOZFnVzPeTmwsLI8+4Qx2idAPb7Z3Dgg0PUBqdUaVJpklyNfqQaz9g25DpNv9YUrsz
         Vj1by0t3ruVNYLsr5Blr7K7gCLDMxFkQD3V/cql2SjGH1qRejErHctgklAkQzkRghCu2
         3Ar3Q7xaEjn7FW2RIUTG4EL9V0YcgmtSff4nANzlPrSoaTgmN7irnBdH1M1wdgUJR9zr
         f7I+9x9RiTy3k2k/GgRmNLTtZka7pUO9mb9Vlmw4n5IXtaclyu0kblXjSepjpdBUxRfo
         shFg==
X-Gm-Message-State: APt69E3o1w2UMU8u0RJ9lc470wXCchLEwLlzHZNBxxHEJLo3QLwZ8X34
        t3hXLMik97Ix8wUWXpwCCACOOA==
X-Google-Smtp-Source: ADUXVKKMzPrA+geJ1FpIDL3maIgeT4e9ICf3M+FxOTQjSbt29oUBZUhU2pFQjpDDwCn92CDzr6Q5yg==
X-Received: by 2002:a62:3c15:: with SMTP id j21-v6mr14869275pfa.7.1529349506916;
        Mon, 18 Jun 2018 12:18:26 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1611:6077:8eec:bc7e:d0f4])
        by smtp.googlemail.com with ESMTPSA id x8-v6sm32820302pfa.87.2018.06.18.12.18.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 12:18:26 -0700 (PDT)
Subject: Re: overlayfs: caller_credentials option bypass creator_cred
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-unionfs@vger.kernel.org, linux-doc@vger.kernel.org
References: <20180618154222.19279-1-salyzyn@android.com>
 <20180618185448.GA8749@redhat.com>
From:   Mark Salyzyn <salyzyn@android.com>
Message-ID: <f141f883-0dbd-10ea-83b9-a1b38119b0c5@android.com>
Date:   Mon, 18 Jun 2018 12:18:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180618185448.GA8749@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/18/2018 11:54 AM, Vivek Goyal wrote:
> On Mon, Jun 18, 2018 at 08:42:15AM -0700, Mark Salyzyn wrote:
>> All accesses to the lower filesystems reference the creator (mount)
>> and not the source context.  This is a security issue.
> Can you elaborate with an example that how this is a security issue.
> mounter's check is in addition to caller's check. So we have two
> checks in ovl_permission(). overlay inode gets the credentials from
> underlying inode and we first check if caller is allowed to the
> operation and if that's allowed, then we check if mounter is allowed
> to do the operation.
init which does the mount and represents the creator_cred which is 
granted a restricted MAC to do just what it needs to do, eg mount, but 
not be able to access the files. The caller comes in and is rejected 
because init domain is not allowed, even though the caller's domain is. 
MAC does not require overlap in privileges between the creator and the user.

-- Mark
