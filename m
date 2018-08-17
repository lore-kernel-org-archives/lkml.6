Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B450DC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 17:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B06121A62
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 17:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSwI9CZy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B06121A62
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbeHQUXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 16:23:00 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:45555 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbeHQUXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 16:23:00 -0400
Received: by mail-oi0-f65.google.com with SMTP id q11-v6so15185769oic.12;
        Fri, 17 Aug 2018 10:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ttMv68j21L+A8QTS5+nvo1SY3KMrI9G3t2OQLxOKBHE=;
        b=XSwI9CZy4EF9vTDnyciGjtQmCT5yg+sdgbQw25ydxEb5I426aY0P4DRr6/VHyMOlr5
         17hD80jnnR5g+zbghNmqUswcWd/xgq/Tk2xg5AjyFLiZmPsBXLWHJ0OLoTddH78nUztS
         tr6CP+WVVMxpj0+Ycn2W2fVx5CUWidTT7LJbH5y3vbce7w/T7gOvHeFDaNhgsB98ZQsg
         oMOO2ZXWIKDv5Fpq/C/LOJSbmkDNBGwnjVejn+WaA3zh7USSx+jKXZUrlpdB89eBqarK
         zt2B3xZc5KzW4bUF08meqrihviHzvlwmDhu5Jp3fHRP30vVURgw1TapPT/XOmgnPhh3w
         JiSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ttMv68j21L+A8QTS5+nvo1SY3KMrI9G3t2OQLxOKBHE=;
        b=taUl29hnvciq0FkWdjNTbp+wIGq17RChvamFFf7rvQAdP/QJ7vIpQtw9GSfj9MC8ON
         41ORsBFE7JKMBg5ar67Pdhhpxyl9Nj1CdVLVKh/tTk5eNBHK3u/lJzT0S7TA9oL1Bf38
         GV4/vGhVn1jBBElN/zEMo3NlWk8mpXf2ToOqYm4eAG/NipFoOzPUCzIaMezX34FTTM5i
         rrsZC/OjfT7BPkjLVTp4JvNAMp3HRCB5+GcSNzVgNLkqOhg2X662pGbI41R2jEt9F8cT
         tssA1Y5ekEjj2fEFhKVaPP3Rr02UT3Ucq3XsA3N2wueZ9fcG3IxYY1P2Sa+EjDBLCeUj
         Qu9A==
X-Gm-Message-State: AOUpUlH+rt9C/4ku6yQ5fq8Uxl6eg5F0g7znRcPUxY1ta2Dw1pmGtP8y
        V2KPfvivulfP14qgsjhigTni3Qhq
X-Google-Smtp-Source: AA+uWPwXx10pIwGRrYJdI0qU/6qUhF23Fo0IsgQKSq781wvHVHu5m82M80ALIVhyxbyQ1UkqaAIg2A==
X-Received: by 2002:aca:c601:: with SMTP id w1-v6mr3586856oif.27.1534526328815;
        Fri, 17 Aug 2018 10:18:48 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id 22-v6sm1222016oix.58.2018.08.17.10.18.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 10:18:48 -0700 (PDT)
Date:   Fri, 17 Aug 2018 10:18:47 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.18 00/22] 4.18.2-stable review
Message-ID: <20180817171847.GF11442@roeck-us.net>
References: <20180816171556.502583508@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180816171556.502583508@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 08:45:16PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.18.2 release.
> There are 22 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Aug 18 17:15:44 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 134 pass: 134 fail: 0
Qemu test results:
	total: 302 pass: 302 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
