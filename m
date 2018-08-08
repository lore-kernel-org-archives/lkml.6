Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7913C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DCB621A28
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1ATKTcg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DCB621A28
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbeHHSIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 14:08:43 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:43093 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbeHHSIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 14:08:43 -0400
Received: by mail-pl0-f68.google.com with SMTP id x6-v6so1202369plv.10;
        Wed, 08 Aug 2018 08:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iXWkFIaAgADOJSY5pzUWZwDNqxQH2sAmoIwosVF6k/g=;
        b=F1ATKTcg+BSA4MeV6pn+ro/aVPfZ1aBmgTF4iVGAco779N3nNrN8XuULsUeX6FhOEW
         KVluvD1om21knXy7uTA+O1xKxQZg2eeJq90mKJMnNuVKyKUW9gqMj+45Mux4rrVTSs55
         8tnNq3p6YAznNrbbODy+8LgyJuGboOr3fEo3hBNwU1B6sDa997S/0hU/ltJFQ6RidhYZ
         KIeeUIjO5Zf7DNHANpQtROeWIyL6nBbk3S6oz7rmzFbss+2zWRJ8o2dBpQO8eyY9bUfU
         pPDQc1lqqZBe3Jy4feBnajiTZZAvaz3zdAHUGzwjFFqVguDTaPgmcN9Lxd/OFIjLpq6B
         Kwlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=iXWkFIaAgADOJSY5pzUWZwDNqxQH2sAmoIwosVF6k/g=;
        b=QGnjdTqSeO+7n3AmlSJV1fyWGvhNgcUH7XGUIz4QDgEhQdqMp1XQb5atGDF3VyNQrw
         SP2oslOYvILVuPaIVQ0BzEALiVhdfETFsdJmwGo4onnskgr0MAzwR5QkdqpPZul9Wug7
         kF7WgZGFTNBRWNLkV/VRar2p0rjtMkx0s4Xe4q8TcL47M5rXjmdr9s6FwEKVe9fllLpq
         ojeW7QdOzKwkKjJxwsIcI1dxpP6Du+ZGaCczpJcY9JTZofQ1nYl5p5wbW5KBeOvRp92m
         hwVlgAB1JNHSZlRIhNFnnZdXJdmd14JFGlU6LprLvLgF4qBoUmskh1Sxq5WkW0I0xwmg
         yf/g==
X-Gm-Message-State: AOUpUlG0Jze7t/mx+CAl+NgCQfFJjKMuy9/cnxL3FjhWRnjkRlszUOA8
        E3oYn8GCuSM/FFYxafqu7mc=
X-Google-Smtp-Source: AA+uWPy9ytYUnYi+MseCKx31HtErIUwQTZcIAi5tDZx78YdRl+/bBcJXhHyz9+Wb0HwlRVQyY+7LVA==
X-Received: by 2002:a17:902:4081:: with SMTP id c1-v6mr3090884pld.169.1533743308579;
        Wed, 08 Aug 2018 08:48:28 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id e17-v6sm4567627pgo.92.2018.08.08.08.48.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 08:48:28 -0700 (PDT)
Date:   Wed, 8 Aug 2018 08:48:27 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.17 00/18] 4.17.14-stable review
Message-ID: <20180808154827.GD5368@roeck-us.net>
References: <20180807172312.964272530@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807172312.964272530@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 08:51:03PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.17.14 release.
> There are 18 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Aug  9 17:23:05 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 134 pass: 134 fail: 0
Qemu test results:
	total: 290 pass: 290 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
