Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F9F6C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 12:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9AE22154B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 12:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YwAXo7Fw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9AE22154B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389749AbeIUSEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 14:04:47 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53192 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728184AbeIUSEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 14:04:47 -0400
Received: by mail-wm1-f67.google.com with SMTP id y139-v6so2831997wmc.2;
        Fri, 21 Sep 2018 05:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:references:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6nxSV/yp3pP1W6UTvaxCsR0C0bepRoAtJBkDPqR/3jg=;
        b=YwAXo7FwowqgqBbi4Y+6t+7/6jA/SM7co3kgDisD93E+wwCG/cycyMq3vM3aL8Bma5
         ZA7m+785EHRHneCQYp7FfH4PAPScTkMIPNA4JS5p872sbzlo+tAUh7Quwu/N+5VHipgQ
         mP6Wz9adn5TPmH/y9hlihUOmWHouac256bAKUR8dL4xXBK+ISXlN0GyYNnsrTFFwziDo
         1F7yCC8D/x69MJeKjsF1lkU7bM+wglyWLKo0/B9nfZ67ZigFlmnN/2iijCTxFLNxO3IK
         Ut8KAUELMaAEMn4ZcpqKUlAPCE8C4WSup+UkehdviexHNhKUt3ypZB8A7DePVHzMaqCV
         O9fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:references:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=6nxSV/yp3pP1W6UTvaxCsR0C0bepRoAtJBkDPqR/3jg=;
        b=D0oL7LS0xK0ShFRYV+LYMuIWaQHCOk+mkj8dXjbScfWg5AngZS2E7EabdTTr7pdVRg
         J8whQiDx8mnD7mvG8BS7xOM2F0RHYzEdF5bYL39kOVCMa4IFaMNRc4ilaSNZxYzfjDTN
         fBObHYoYQ1CvIJvKPwe2Kiu6ZIwIYV0L8hfxcE+xkOI9ewfR5439dxRjTISiRDW4Ecav
         M1ziL/xAnThKFbaI+Xvtwx5326/olRGgsYPQAJn85lxKe7UAMi8hn8bhWVSHpIlRe7nK
         oWxPkf2I23u5Mqqnr9wF0nrHDGyySCa/d9xr0oxPmf12NsAf6UokgMRI1fK7V+meH7nZ
         kcUw==
X-Gm-Message-State: APzg51CevK6Z1WSuHN0wPcabbO1qYLJPXM2CfUpp354mt354dHltkwia
        UpSHj2EUwE1ScnhOFqkEZVN4tmzd
X-Google-Smtp-Source: ANB0Vda4FyVDwUI0PFMTZi1ZJv+PcBAhmVyczLW6DlKkufCu4DUG/Rldhc3daIqxZ5PnWcvyluYlxg==
X-Received: by 2002:a1c:760a:: with SMTP id r10-v6mr7116519wmc.86.1537532168472;
        Fri, 21 Sep 2018 05:16:08 -0700 (PDT)
Received: from [192.168.10.165] (94-36-187-248.adsl-ull.clienti.tiscali.it. [94.36.187.248])
        by smtp.googlemail.com with ESMTPSA id 124-v6sm6318875wmk.20.2018.09.21.05.16.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 05:16:07 -0700 (PDT)
Subject: Re: [GIT PULL] KVM changes for Linux 4.20-rc5
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     gregkh@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, rkrcmar@redhat.com,
        kvm@vger.kernel.org
References: <1537532067-42759-1-git-send-email-pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
Message-ID: <7bc25340-cb12-43d1-aefd-01123407a850@redhat.com>
Date:   Fri, 21 Sep 2018 14:16:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1537532067-42759-1-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2018 14:14, Paolo Bonzini wrote:
> Greg,
> 
> The following changes since commit 7876320f88802b22d4e2daf7eb027dd14175a0f8:
> 
>   Linux 4.19-rc4 (2018-09-16 11:52:37 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/virt/kvm/kvm.git queue
> 
> for you to fetch changes up to 26b471c7e2f7befd0f59c35b257749ca57e0ed70:
> 
>   KVM: nVMX: Fix bad cleanup on error of get/set nested state IOCTLs (2018-09-20 18:54:08 +0200)
> 
> ----------------------------------------------------------------
> This pull request is slightly bigger than usual at this stage, but
> I swear I would have sent it the same to Linus!  The main cause for
> this is that I was on vacation until two weeks ago and it took a while
> to sort all the pending patches between 4.20 and 4.21, test them and
> so on.
> 
> It's mostly small bugfixes and cleanups, mostly around x86 nested
> virtualization.  One important change, not related to nested
> virtualization, is that the ability for the guest kernel to trap CPUID
> instructions (in Linux that's the ARCH_SET_CPUID arch_prctl) is now
> masked by default.  This is because the feature is detected through an
> MSR; a very bad idea that Intel seems to like more and more.  Some
> applications choke if the other fields of that MSR are not initialized
> as on real hardware, hence we have to disable the whole MSR by default,
> as was the case before Linux 4.12.
> 
> ----------------------------------------------------------------

A good way to start sending pull requests to you, all version numbers
are off-by-one. :/  That vacation mood is still in the air.

Paolo
