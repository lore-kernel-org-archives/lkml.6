Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F960C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 028F1204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewJWvKQW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 028F1204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbeJ3Cv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 22:51:29 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37016 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbeJ3Cv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 22:51:29 -0400
Received: by mail-lf1-f66.google.com with SMTP id p17so319806lfh.4;
        Mon, 29 Oct 2018 11:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=7kgQoUjTh24AyO/p9oeeYLOwg1VLACPfdZMGUe9bi24=;
        b=ewJWvKQWE+ZIdEn9+5FvVem8ynSjjOZtQ8ASAQwGo9iqJBUQkujpHsYY5hvGEc3GrL
         mENgeb3vTrUwZN3irUT3epuvMUHXFRzI8xrVsOVCuKbGq++1wtqaDeO1JOFRs6yMbh13
         4EmaE7C2iCp1awkJ1/wlMMXhvXIZgAg7CmXqA/gzhVnDmE+DQG20zxvWVbQmfSnQZJTu
         +DPBATd36Cy3WxLb6zmJbYJueHncElUxafG4+Nlbyy8nSXCHNFmayuiM1g6e6DUnUoiC
         AJmODwTdcCZRrABqDIFNHDofAe8aOsVQgkBL25Mn3cQFdZg05fZxPHrCrN6t5VBKbr6t
         BB6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7kgQoUjTh24AyO/p9oeeYLOwg1VLACPfdZMGUe9bi24=;
        b=SVSaenpszEnB+OzleBRExGqO6SnZ7cmtg8xXwBxznKxzP+eFIQNFoMBcOiAlCm6FpT
         nB7Sp+H2zkBat9Vkov9wEeEME35LX2aHO7HUCv/T7WtuixOSL/8bsAxK/a0518FigUPi
         LKzWAIQxksWmQ/m9Eiv4mGjqf4zLfl5F+Wv47/iTFMoI5uCMUjXAVeYwIFI3iv/8x4eJ
         LP5gdDygmB7ZtHZ+caMao+AldFOouP1+RTuLrwvP4PCbGWSZ0Qm0Kctrzo9OGPKbg0+k
         U7IsDFVVdCPrGdlWOyT4mxHFi1LMoxyJBcU512fTzvZLYwR/STNuAtqf+gMb4wSIhr9c
         fh1A==
X-Gm-Message-State: AGRZ1gIl66hsQCjJK6/x0rEpaIRZXaFwj4IV5AZM1CWYUwUb4CClKAUv
        TDiy4KTkWFjLfzdNvDP5w58=
X-Google-Smtp-Source: AJdET5ev/pCOW16Nali/5oz0BfpyVCCm+SghGErJwQe1Sq/gvslVbV17kdxSCZE2beFxFW1qcLNJEQ==
X-Received: by 2002:a19:cc46:: with SMTP id c67mr8710395lfg.145.1540836105613;
        Mon, 29 Oct 2018 11:01:45 -0700 (PDT)
Received: from ?IPv6:2001:14bb:52:7be:f0bf:dd2d:f008:5213? (dmkd798g-7z2-yccwcp-4.rev.dnainternet.fi. [2001:14bb:52:7be:f0bf:dd2d:f008:5213])
        by smtp.gmail.com with ESMTPSA id j12-v6sm517117lja.8.2018.10.29.11.01.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 11:01:44 -0700 (PDT)
Subject: Re: [PATCH V5 0/5] KVM: X86: Introducing ROE Protection Kernel
 Hardening
To:     Ahmed Abd El Mawgood <ahmedsoliman0x666@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>, rkrcmar@redhat.com,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ovich00@gmail.com, kernel-hardening@lists.openwall.com,
        nigel.edwards@hpe.com, Boris Lukashev <blukashev@sempervictus.com>,
        Hossam Hassan <7ossam9063@gmail.com>,
        Ahmed Lotfy <A7med.lotfey@gmail.com>
References: <20181026151223.16810-1-ahmedsoliman0x666@gmail.com>
From:   Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <1b3eb10e-c492-dc77-cbe6-3a3e692326d7@gmail.com>
Date:   Mon, 29 Oct 2018 20:01:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181026151223.16810-1-ahmedsoliman0x666@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 26/10/2018 16:12, Ahmed Abd El Mawgood wrote:

> This is the 5th version which is 4th version with minor fixes. ROE is a
> hypercall that enables host operating system to restrict guest's access to its
> own memory. This will provide a hardening mechanism that can be used to stop
> rootkits from manipulating kernel static data structures and code. Once a memory
> region is protected the guest kernel can't even request undoing the protection.

This is very interesting, because it seems a very good match to the work 
I'm doing, for supporting the creation of more targets for protection:

https://www.openwall.com/lists/kernel-hardening/2018/10/23/3

In my case the protection would extend also to write-rate type of data.
There is an open problem of identifying legitimate write-rare 
operations, however it should be possible to provide at least a certain 
degree of confidence.

--

igor
