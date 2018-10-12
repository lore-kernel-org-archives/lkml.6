Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B4AC67879
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFFB621477
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s+8GxCWH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFFB621477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbeJMAl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 20:41:26 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34510 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbeJMAl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 20:41:26 -0400
Received: by mail-wm1-f65.google.com with SMTP id z25-v6so18452725wmf.1;
        Fri, 12 Oct 2018 10:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wplAbZGUn5eJhe+HP29S5/fzE0kzsAZ2NpRQ3XG7w64=;
        b=s+8GxCWHND2ogHpubU9Do2g9FPx4RCB8JMS7MZsHrBWm6EY3gHVRSXCmwNv9ZdKshu
         qiYJnY+I7Yq45QZnzKLDfIzpgvoxI7/G1+8HZtdSBrkxd5NkrL2xtny6eNTt8LxxgvdM
         qUda3G3kcOFTPKenzWWqlSObdtRrALnsWJnJxpUb2njc7g9RQSIm+ZIrUHDAkZYOV2SA
         A/icUeaZ3sMu3A/lgSCe5TRz2G4JMh7O9xHl2DMBAeD9wcL3lET420f+oC/FON2lDsvP
         nyqtDRlF3ieHCaOpGPoxu0uUfgl8PKDj1AIJlSIge4FSff2duy1F/C7/rmbsoxoaOWTi
         nJZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wplAbZGUn5eJhe+HP29S5/fzE0kzsAZ2NpRQ3XG7w64=;
        b=YWi95Z9do1vm3Vrn7/Vdeu3O6Tx8/+5DhTGXsWe8KSL7mS7ErQmHC5l4gXOhsdwwo3
         v0XnL7RMNMckpEIiRXgBd6mQrtnbcTPC5WTHPtlEsfq2ps8YwX5Br3hk2JOTP1ImN25s
         xKPxjzsphAfpma7eLDH0f4oN0FxpstaeYYVIf2s/l9/Qdgpuysmks4Fw4ySUe6pczuKR
         8g/hPlol6Jf9iCADzM4m9An0dQZFCWQFeNvtP4olInlpTOefJ1Z0vPuPCsRpSjMESKzk
         38IwJVP8CwZPBvdLcoQdooZsJ17JVNYYbsb4YJbcwfeERWPuyaRCRCDYMWT931aXHg1K
         ywPg==
X-Gm-Message-State: ABuFfohuAwZlCm9adGY+c2uXOT/8RClKjLo2u2QQEqkk0Bcyxz2Y0dQa
        MVTRDj7lExUlvwkfLIiaPkrV1c7DKLuFgw==
X-Google-Smtp-Source: ACcGV63gzDnvaO35qhqSUtzLSGNAlB91VheC1LLnRCFfcckkg+9MoFzrzcGEAY7256Biyk8iDVp3jw==
X-Received: by 2002:a1c:7a0a:: with SMTP id v10-v6mr5954236wmc.41.1539364077643;
        Fri, 12 Oct 2018 10:07:57 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id t13-v6sm1169146wrn.22.2018.10.12.10.07.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 10:07:57 -0700 (PDT)
Date:   Fri, 12 Oct 2018 10:07:55 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/35] 4.9.133-stable review
Message-ID: <20181012170755.GC28298@flashbox>
References: <20181011152520.174949126@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011152520.174949126@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 05:35:02PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.133 release.
> There are 35 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Oct 13 15:25:09 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.133-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Merged, compiled with -Werror, and installed onto my OnePlus 6.

No initial issues noticed in dmesg or general usage.

Thanks!
Nathan
