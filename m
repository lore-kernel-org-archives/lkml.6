Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2331AC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D44B721A37
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lEU6omzd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D44B721A37
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbeHHSIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 14:08:18 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:37308 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbeHHSIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 14:08:18 -0400
Received: by mail-pl0-f67.google.com with SMTP id d5-v6so1216624pll.4;
        Wed, 08 Aug 2018 08:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rw0lxIYY4G1Cri0Ys1ZgvtpJxAy3PNqcCD39X0fRF/U=;
        b=lEU6omzd3AX37gqy6dXsGpqfau6dl34ynpVN2oGC+/GqPuVn+zPoKaWMo4cPgWIIzZ
         WS6bbySCsFIBPnIvn2/4Xic/uZ9hqb7c9a2r0I6dqhdIcczrHqXpWGxPHeXYI+eN/bdy
         yHQA2J4olVa+HfPApmA48yNcNrmus23CuRKVg8hIj4LKwKKliO+HAloSkCs+oGtefulV
         WCyMksHGDrhN+cCY51vFcGPmdcMtjsKyroUswpp6MV//fVnYhYfhjaQD8WqeDeGmv86U
         ZNiqoz9hnmrN93+67Qk4TPknjMXYjWnlLzIQqoW++d/4K5wOwXR1/v24zAT9u+mCrn9D
         xPEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=rw0lxIYY4G1Cri0Ys1ZgvtpJxAy3PNqcCD39X0fRF/U=;
        b=FMeE6e0UK1k+K9yyWxninwF69AJWRgrv0hNCd8sP2Wqoq5ExyNuPhWgZjT67/vjEb5
         J2PTZiZ249HzuEXdQkEAURoggWKNlcGYhOTAhI1473dB9/cT6TMWJbXYpxfGb1bWi0Me
         +Id0MmIMWyr3n8+C01PUqo7piFKrJ78IcxbtdUTXkERYaamK47HB0tqY5g/9tl2MegQR
         vbM2HlvXW7mKn5Wi8hGf+W9x+nGkdoW4ReIv+ZmBsisgQHETPi9Ybrl+SFDRN3VRljZQ
         eR6T7p5YZVFWzxXSugcfnktub1JhVYR6JaQLHOigqdjTu2AO58gd6yZPhZWU3Zx2I/RK
         WcDQ==
X-Gm-Message-State: AOUpUlF+Z2sLHb6kgToJIFwmoibfnnLEstfmtS56WPtZ5HKxOy19G6I6
        V2/ag1/f5UREz3dKNvZal5E=
X-Google-Smtp-Source: AA+uWPyCN4WO9g2Lye/1DWU020BltI5e4l4HeATff4p6w/hJeqyM8/KhFrWZgUR3+QHb1TE2e3luCg==
X-Received: by 2002:a17:902:820a:: with SMTP id x10-v6mr3114129pln.261.1533743283479;
        Wed, 08 Aug 2018 08:48:03 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id n29-v6sm10130402pgl.30.2018.08.08.08.48.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 08:48:02 -0700 (PDT)
Date:   Wed, 8 Aug 2018 08:48:02 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 00/21] 4.14.62-stable review
Message-ID: <20180808154802.GC5368@roeck-us.net>
References: <20180807172330.953888701@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807172330.953888701@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 08:51:14PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.62 release.
> There are 21 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Aug  9 17:23:22 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 148 pass: 148 fail: 0
Qemu test results:
	total: 287 pass: 287 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
