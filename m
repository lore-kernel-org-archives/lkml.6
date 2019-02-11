Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384A1C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 041D42081B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549921210;
	bh=X8nyMZaX8g9bROqPca2gsdYJzKggW3PW7TreKzmYl0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DmV7nwbnpOFkkAzVOAmjGjtX48TLVtRrCKGxRf+U/x38oqulmZSFASA+aiYzG1wj9
	 0bKmwJXiz1OWImsb+5YFsIGgTzpUpD+E//rdjELaGvuuCbTvAfP618jux7vyKBRHDP
	 Y9XyXTkCIpkq0YkCxF0d1WugEXf+IeTiMoS2DBso=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbfBKVkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 16:40:08 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36452 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbfBKVkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 16:40:07 -0500
Received: by mail-pl1-f194.google.com with SMTP id g9so189110plo.3;
        Mon, 11 Feb 2019 13:40:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=APc3Hq3mdGruWVAqmBh1tq9sv+fjeQxPqPpf4EiyTAA=;
        b=Pa/KzfYsHesR5GVZdWN4wktRse4vrMSfLEE0bh+zKxztYRSJWT+lWiXwAol35GVgah
         IzVtehzKFOJZ4ZiA25Nec6Cbqir/QvBT/nqgzXXkO//ZaJruJJGjwthxaK5NN+1q8PQR
         LO5eKLm6Y5jzLK5+HF77y/TL7jRxsp12CqjGYDU3wvSI7pXBmhSlbLNbJBUxv6yObUvM
         Y7K1KQxTVmkyqS4GviJBJVHM/e6wkPuJDKUZ08G/7WpqhGccXpCIBEI7Il4gAidYEbsd
         pOH6kT+w04WQeM3cTlTmQLoqMa/8T7BouZNSDsgNJ3eh6iYDp3SI0ePkTVelGwjSZDUD
         OnTQ==
X-Gm-Message-State: AHQUAuabAPYwxZEAyqMxQmSefeMJr56eTGIXJ42XQhzikJStFTCzrtrh
        oKmcnQfLa7p3miIKYkNIIA0=
X-Google-Smtp-Source: AHgI3IY7CBFQBfM0GstZzQ6PY67Jy6v+5sYc4jJ5dwTRzrUXAHh91smlxMfGP6GvxTqlLkrmbIXucg==
X-Received: by 2002:a17:902:7c83:: with SMTP id y3mr377914pll.260.1549921206921;
        Mon, 11 Feb 2019 13:40:06 -0800 (PST)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id m67sm19219328pfb.25.2019.02.11.13.40.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 13:40:05 -0800 (PST)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Mon, 11 Feb 2019 13:40:02 -0800
Date:   Mon, 11 Feb 2019 13:40:02 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
Cc:     shuah@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, akpm@linux-foundation.org
Subject: Re: [PATCH v2] selftests: kmod: worked on errors which breaks the
 overall execution of the test script. i have manually edited for v2 of the
 patch by changing the date and also commit log.
Message-ID: <20190211214002.GV11489@garbanzo.do-not-panic.com>
References: <20190131183109.10919-1-jeffrin@rajagiritech.edu.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131183109.10919-1-jeffrin@rajagiritech.edu.in>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Your subject is too long.

On Fri, Feb 01, 2019 at 12:01:09AM +0530, Jeffrin Jose T wrote:
> The kmod.sh script breaks because an array is passed as input
> instead of a single element input.This patch takes elements
> one at a time and passed as input to the condition statement
> which in turn fixes the error.There was an issue which had
> the need for passing a single digit to the condition statement
> which is fixed using regular expression.
> Distribution: Debian GNU/Linux buster/sid
> Bash Version: 5.0.0(1)-release

I just tried Debian unstabe with bash 5.0-2 and the issue is not
present there. Debian testing was on 4.4.18-3.1 for me prior to
the upgrade.

*both* work fine.

Please upgrade bash?

  Luis
