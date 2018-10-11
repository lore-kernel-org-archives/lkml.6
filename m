Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFF8C67837
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 21:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21C802077C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 21:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n37/wR2V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21C802077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbeJLEcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 00:32:02 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44319 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727182AbeJLEcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 00:32:01 -0400
Received: by mail-lj1-f194.google.com with SMTP id v6-v6so9487564ljc.11;
        Thu, 11 Oct 2018 14:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SxkiP8ZdsiqtnMiZxvk47B9l9yBJI0qvBgSdtldy6eo=;
        b=n37/wR2VQUhXdo2zKDM1LNFbHwKRYRGY361GLHfGJv9N9Yt/t0Hb0EAai9yxaK3Q8A
         tt2EDD7xAoa+Zv9GD7tqk0iYJsPb8CKk0/IhGrO2genzBz6zpqz2LQiautX5q9nq32n0
         SoJz7XP6L0c/TEAVEdFr6lyHt+QRoIXk34uJx17iHnwIKytzC1B/dwJqxykOjWUqCbHH
         ne5ZI/Ymf42Ms1PzZbvjHP+gjz1IwYtoaLaFitAeriVAdiwYJ4vivQjEJOVl1Y01O5Gc
         i4extIie+N3R2UttQMuyLR+d5MIFTMlWajIMebhTaix4/Ea813QnjTEz8XGv3RoTG4rx
         KuXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SxkiP8ZdsiqtnMiZxvk47B9l9yBJI0qvBgSdtldy6eo=;
        b=j1hwINqugf3eHFGlnPiPM85/tyMiOv/iDcyWFKTY/Y4KKI4noJkw+QjicX5UbUz5YA
         0quUHIizY3fWM1okJZIwj0YLtRIVc4BPS+aehcnwBJBI/nawHzlSAP+if7jyk7bX9vA/
         LX4sYLYQaa6jX86e0RdpOq+01RNhLVmpWqJwhgFQwz5pnTklo6bit82wS7S5sj7MwijW
         AOAyYDZ+FDA6kvO8W67rIQ4P7+BhK8fj8q8lA7cf3Gqun2/on/oclXil4Mem799Ei4Jp
         sjkVr59Z38n7f5ljj+6a2mjs74zY7UbslhIcUpmtBAc1yaPkjH9yW/79fiyWC/icLXLl
         N7yA==
X-Gm-Message-State: ABuFfohUt/FnhQHGbHLlVT9MKTFMaRS3QJ7vjPgdpi/p4vCN4hGTgDUv
        l/WfVoLOSGa1wWhyaVRLreF+Dv/a
X-Google-Smtp-Source: ACcGV63Io99Ep3C7mrB3RlZccJw0AvvgYiXtRhoXvT0+H9HIRO71owwpLChTQejdQ/mii8vz9L+fBQ==
X-Received: by 2002:a2e:80d2:: with SMTP id r18-v6mr2454455ljg.100.1539291778236;
        Thu, 11 Oct 2018 14:02:58 -0700 (PDT)
Received: from uranus.localdomain ([5.18.102.224])
        by smtp.gmail.com with ESMTPSA id a17-v6sm5803662lfj.13.2018.10.11.14.02.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 14:02:57 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id A4E4F46072D; Fri, 12 Oct 2018 00:02:56 +0300 (MSK)
Date:   Fri, 12 Oct 2018 00:02:56 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Rafael David Tinoco <rafael.tinoco@linaro.org>,
        linux-kselftest@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        shuah@kernel.org
Subject: Re: [PATCH] proc: fix proc-self-map-files selftest for arm
Message-ID: <20181011210256.GE2401@uranus.lan>
References: <20181011184359.15627-1-rafael.tinoco@linaro.org>
 <20181011205601.GA32757@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011205601.GA32757@avx2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 11:56:01PM +0300, Alexey Dobriyan wrote:
> 
> As the comment in the beginning says this test is specifically for addresss 0.
> Maybe it should be ifdeffed with __arm__ then.

Is there some other reason than allocating non-mergable VMA?
