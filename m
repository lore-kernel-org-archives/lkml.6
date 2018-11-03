Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97FEDC0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 14:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41CE72082E
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 14:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oj3Ul7qn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41CE72082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbeKCXnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 19:43:17 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39196 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbeKCXnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 19:43:16 -0400
Received: by mail-pg1-f194.google.com with SMTP id r9-v6so2232563pgv.6;
        Sat, 03 Nov 2018 07:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3W/kXpXDGV/6D9RzAzhWDhjFSJgv1UDOTCi8wok30VI=;
        b=Oj3Ul7qnE/qUDHJMPZQA2hNr0s6/oL/sg9tQ7foB1xfc+JyjoTt8wLjIAjg2ub/LK4
         U/DfmumuaPU7mH5UNovxosoZADbdik2lxI/gU06OhHlqbJfmbD2LpMDTjG1PGhNRZkZC
         qLYapObOJ1yikNleAGl5I1FXfyC/Z0E+/PkrrDEit1yU6C7ziJBF6RQPu5Kqe5LxYF6Y
         pnTLkNqX1j5UvLs9F4T9utHTOLm3x48ykFePnQfaPgUaWZ//3CUtqWf+88JLoCkq5a26
         vhcqWBSeOQG7ViuEjgJbcagkFDI+URqBeyn8d08xtmR1XqNOQ4gfaGUSDx3bd/tSY6O5
         b6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3W/kXpXDGV/6D9RzAzhWDhjFSJgv1UDOTCi8wok30VI=;
        b=G+n9nNwtZZeh+iPzUyHLg+UaXodYk9YwzgpUow6bmsCHeQnoQ+K6Vq5flOi6LDtWmo
         XFtYpb/9ljdJgCyRVayi5xz6TPLmV8J7LG+vMJWOcut/sIc6TLWbgXDXBGCZAVc+C1Zv
         F88GOZ+d4YKfrniB6TnDagERgjf4RcTCe4XfEPZ6r3MnHy9+6G0XuTfNdGBR42phNPYx
         KWfrf2XoMDwNWY5MTXUnke0JRsIrptMdk3IGOPVcfcg2MmCzVjzawsIWjGZdImbQMd2j
         slU2hfm2v+pg3vY9dtnSdgrPXqGWpY2YRxQv8FIgcbEmySE0+zHwibq/k6Nd9TipOnQX
         kv0Q==
X-Gm-Message-State: AGRZ1gJWtltfmoKjQMlzbqdM+edxstwGpAJV6UvIrno6sPINSlRibDIW
        FYgU9ZB+fr+cWZnID2Q02Azz71Af
X-Google-Smtp-Source: AJdET5cmNBzt5XApZMVwh1ZgGBpFlYcBa/XDE265hnHEHjEgb/S4CQfUfTrqvfStQ1uGjgmk912QmQ==
X-Received: by 2002:a62:8a0d:: with SMTP id y13-v6mr15684318pfd.142.1541255505822;
        Sat, 03 Nov 2018 07:31:45 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t4-v6sm39252148pfh.45.2018.11.03.07.31.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 07:31:44 -0700 (PDT)
Subject: Re: [PATCH 4.14 000/143] 4.14.79-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20181102182857.064326086@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <34e8a999-20e1-5e7d-863b-b0585a24e83b@roeck-us.net>
Date:   Sat, 3 Nov 2018 07:31:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/18 11:33 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.79 release.
> There are 143 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Nov  4 18:27:59 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 150 pass: 149 fail: 1
Failed builds:
	xtensa:allmodconfig
Qemu test results:
	total: 318 pass: 318 fail: 0\

Build failure:

In file included from include/linux/mlx5/port.h:36:0,
                  from include/linux/mlx5/driver.h: In function ‘mlx5_get_vector_affinity_hint’:
include/linux/mlx5/driver.h:1208:13: error:
	‘struct irq_desc’ has no member named ‘affinity_hint’

Caused by commit 19b743c448db ("net/mlx5: Fix mlx5_get_vector_affinity function").

Details are available at https://kerneltests.org/builders/.

Guenter

