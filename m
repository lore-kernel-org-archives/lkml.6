Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F30BC4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 09:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DC7D21654
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 09:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=demfloro.ru header.i=@demfloro.ru header.b="hbkK8lch"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DC7D21654
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=demfloro.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbeHOMAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 08:00:36 -0400
Received: from mx.demfloro.ru ([185.52.0.75]:32780 "EHLO mx.demfloro.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726195AbeHOMAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 08:00:36 -0400
Received: from job.localdomain (unknown [81.95.28.29])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: demfloro)
        by mx.demfloro.ru (Postfix) with ESMTPSA id 41r3Yj5Y7bz4X3M
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 09:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=demfloro.ru; s=052018;
        t=1534324154; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VVgpTVK4k8Y9a2FVTSAHGyNNXdbdoDpYS2mc6H63nQ4=;
        b=hbkK8lchpebP+jercB1LNBfb+fjg6uAyPNcHvtWD5Ss28uc1NMDC87CqbtotdpnTIseF2Y
        nt/F/HDZF4W/ysDC5oGy+UA34hgE3DSmOLxMpYAejchV06fH6TupiEADvF1gTl6QtuUQ3H
        49Uj80GiAzjCxMic9hiWugRRiY08BwwhkUo8eiLJ6syb3L2ywN9pKpowsg5yKgYEsPhgmo
        8MqzUnymq8qUzOrhoIWBtd71UxEAjLYBGgW1fubk9xFRwbozXnMHwpcq8rSdg30DP4LJFX
        4x1Y4n5bWxN0P7hSZ6Yxv2L6pelIhjuuDXizgrT82+CYMLo35eNVag9O+m5MhQ==
Date:   Wed, 15 Aug 2018 12:09:08 +0300
From:   Dmitrii Tcvetkov <demfloro@demfloro.ru>
To:     linux-kernel@vger.kernel.org
Subject: Re: Undefined reference to `l1tf_vmx_mitigation' without
 CONFIG_KVM_INTEL
Message-ID: <20180815120908.65257639@job.localdomain>
In-Reply-To: <20180815114200.00fcbd8e@job.localdomain>
References: <20180815114200.00fcbd8e@job.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=demfloro.ru;
        s=arc052018; t=1534324154;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VVgpTVK4k8Y9a2FVTSAHGyNNXdbdoDpYS2mc6H63nQ4=;
        b=KD8Vty34aAvisudRHyvqU1gosepzt4aaY27+d4s+1+jGb6sveUek4GT6msxyCmcH7yjPPF
        8hECLULbpl5xYUhHJ2n6UuwNeChU69neEe/3MLkZuDjkQ7hePq4ovXW3KQgIXSXakn6Yh2
        uRd5wQg3qQHmbgPP5/n6rQcjP5Di8sZ97JUGY0vFiOXX0yHy6iwykJ2KrGcKGxX4K0qzpA
        Kf5dkSZlmae9P65bFDyDkvu70n2Rpr8vtgLTBUd/ARM3FKeXu6zRSaGBbG6BwLlnvdYU/9
        1YwDPEUQn3qy+lh3F0lu5eZzTO3uj4riaR7i6DEi4mDKaxIxyX/nCLfIgAhQWQ==
ARC-Seal: i=1; s=arc052018; d=demfloro.ru; t=1534324154; a=rsa-sha256;
        cv=none;
        b=fDC2aY+S0z8FL0Clj+YgXEZsqk7uC5IYmIoNAenjVnlNazFD5ytvScaLSId/9VXJiGVdstNzMexheeQ/js1EcQR6KNFP4b1zPZPxFndXTgwDmN2bqiouaLUe7m6F6derEv10yYm355EcY4VCIsfwTJwNmqURmGPFLVgHixz4E20etiZYZtPfbOQTbkTkZ2UoM1c+DQ3GAmytKOogCJs64bHTDm0SM3aWWPogqAPgBHhxCOTHxYLQuzO7NaV3fg7RTqgc/R/YmcfAe7o3zdF4XX4Y6i4uVjDBswoYaaPzw6mE2pfPSWtz15RVFZXAoftkebpxc8o6Wf3JP2GQfSPtWg==
ARC-Authentication-Results: i=1; mx.demfloro.ru;
        auth=pass smtp.auth=demfloro smtp.mailfrom=demfloro@demfloro.ru
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Aug 2018 11:42:00 +0300
Dmitrii Tcvetkov <demfloro@demfloro.ru> wrote:

> By build testing 4.18.1-rc2 from
> git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> linux-4.18.y with my custom kernel config I got build error:
>   CHK     include/generated/autoksyms.h
>   GEN     .version
>   CHK     include/generated/compile.h
>   AR      built-in.a
>   LD      vmlinux.o
>   MODPOST vmlinux.o
> ld: arch/x86/kvm/x86.o: in function `kvm_get_arch_capabilities':
> x86.c:(.text+0x46f2): undefined reference to `l1tf_vmx_mitigation'
> make[1]: *** [Makefile:1010: vmlinux] Error 1
> make: *** [Makefile:979: autoksyms_recursive] Error 2
> 
> Build is successful with
> CONFIG_KVM=y
> CONFIG_KVM_INTEL=y
> CONFIG_KVM_AMD=y
> but fails if only
> CONFIG_KVM=y
> CONFIG_KVM_AMD=y
> are selected.
> 
> The issue also reproduces on current mainline master (31130a16d459de)
> with the same error.

Sorry for the noise, only now saw the patch for the issue:
http://lkml.iu.edu/hypermail/linux/kernel/1808.1/04513.html
