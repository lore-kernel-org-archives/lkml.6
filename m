Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_SBL,
	URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D3B8ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00697205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QS9U7FSV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00697205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbeJSX5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 19:57:11 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44476 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbeJSX5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 19:57:10 -0400
Received: by mail-pg1-f195.google.com with SMTP id w3-v6so387066pgs.11;
        Fri, 19 Oct 2018 08:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YMKaHBXlkYTK4ZlPLlwWfjH6ij2NcA2gw7y+bm4qsec=;
        b=QS9U7FSVIpiq1GSfbDpJTW0UZBoYoAM00XV8FfwSaPma9xei11yVYM8fGwUjUp6YuK
         fhaI65TpOAhaD3CM3SQoXjVh7ogkkw9H2GOKai5nMr+FjOBHrYiInVchg2ve3cxUkHi0
         TRtYbjSYotsY7XoqIVp9i1Oe6H2IhuGq7HLf/OAWF/wtBAKs6F8o7Lrp+qeInrumpaPz
         dbOHmUlLz4FlxpEprQSUJlglncfa3VDTt6rVuJrk7SHghP8npSxQg1TGq+xsd0KJfVxW
         5AuiCt7VHl3e4VOkH3TOQrbZW0cTcK1jpwyjrEh6p36L/6C3TVOidd29wNF7mYLxj0/l
         uGwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=YMKaHBXlkYTK4ZlPLlwWfjH6ij2NcA2gw7y+bm4qsec=;
        b=VETo8KMM4nXm2WYsmMMylUyOWJlQIozP3CVHbrvHkL1s9DEcN4JIzuq4e9rv+V6xrx
         dQWZEq8D4nqmvH6f0ov2tX3iTVASkeNaUreCjMKjgEJNnFQcvcWeCr5ej5L8HvRsbB6E
         h/l6e0drMzDvrh7/yOFnRHuUUNQGzYuN4Nvm4lkn8LoiXbOFYcmUh7e4TZ89KE7YxDUD
         FSrxc18WE0ZJjXSkmz9JsJy9ZoAAF+GZeoHBsob9RVHuGkx8lRbdD/Xb6qW7xXZ6IoYH
         uvLfk8/Yv4HYjkwnPeCBzeuUuEoXUSBH3hWOb7dM3tLG6GEhRKa6D/Aa18UvweWfi9Vj
         vF0w==
X-Gm-Message-State: ABuFfohVLs/1tkfCOimaX4cNW6fs96uMMs+1lkEJXhbzLT67StGU4Z+Y
        CUFjDhPtBdMK2D32kwe0YKI=
X-Google-Smtp-Source: ACcGV60GNHVDYqqTo1YXSTwrEu3OMkDz24BIB+tY6h9tD66SHWWR3PbtNfjGvEB2T5gC4vjnWzs9CA==
X-Received: by 2002:a63:65c7:: with SMTP id z190-v6mr5227410pgb.330.1539964230712;
        Fri, 19 Oct 2018 08:50:30 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id v81-v6sm42001850pfj.25.2018.10.19.08.50.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 08:50:30 -0700 (PDT)
Date:   Fri, 19 Oct 2018 08:50:29 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.18 00/53] 4.18.16-stable review
Message-ID: <20181019155029.GC2992@roeck-us.net>
References: <20181018175416.561567978@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181018175416.561567978@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 07:53:53PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.18.16 release.
> There are 53 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 

For v4.18.15-54-g5a51f0f:

Build results:
	total: 136 pass: 136 fail: 0
Qemu test results:
	total: 321 pass: 321 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
