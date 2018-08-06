Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29531C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 07:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D31982198E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 07:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghJyKE2x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D31982198E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbeHFJ7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 05:59:15 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:34344 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725735AbeHFJ7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 05:59:15 -0400
Received: by mail-pl0-f68.google.com with SMTP id f6-v6so5317774plo.1;
        Mon, 06 Aug 2018 00:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Sib7iUGqU4okqA3LvH6W9pRkrNp/0scGTTNxOeHql8o=;
        b=ghJyKE2x/CZqoH/OPnnujxdPXFW4BW7JEuXxlLpWTwTKI9wYQecFD7AOnt0XrLhWIX
         QysmiOzFesVnjQqZKoMwVl2tXkxzNMnUCUZizNRD9/DQoYUH0TUZSIseTThrbpf1UMti
         mOFPZqH8BmVM+8rgV9OoNliqVuJpfZcD7Hc4QFCVNlF63acJ4uDYWJttcTTGtW2zQIUi
         DW5PZTeEIqDzveT/cj0HsLeHG4FTC3HO/VMDbltVXJMGvSCUHqYBDQ+R7OFhZuW2evz9
         LkxWRUaPXvqikl9H7WcGy0n3RXFthznYFcj9UFOj59mszz00agVHv1WXNGvkvmnyKLjv
         +oHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Sib7iUGqU4okqA3LvH6W9pRkrNp/0scGTTNxOeHql8o=;
        b=qANuNjPHABQUF2mgOS/h0wxdGv5rHscv4VJdQIoWXTLiql9zdrcreFjXkZCmUK1DHY
         Fs0ZbV+JwXFIEfosJOm+LWKGD/7y0vGWz8QqG68ZN7vNxGpGJbS4aCsjmL1z2ClalJEp
         iye5fmeepwWNd29PSWZXVSI67tLIZ54WoNbhbAYJNncYp/wxmcXQHWHKjSuosyyHjkct
         9Pn5/hTazoZMo0hKfEiFCho255zBsGhNKgUxtOFiU7ZtBoFYPINt1e5xkeCYZ91iYdnG
         mcABwqaYuhmy2tYo3HPAIUl+N0u2gNJ3tJcT9QlIFWnhlh5Q8J57ZqNFFojkP1xX5SG3
         9SuQ==
X-Gm-Message-State: AOUpUlHt1xnLcKrw+4QJ6tMjVWNvW9sk9hiH5E8Fd2S+CS7JbhvE+0W+
        dUjfUEMn+4I1YsgPFqm1rHs=
X-Google-Smtp-Source: AAOMgpeC+vI3N3/+MnbjmxaAE/sSKeEIiMoWS7UFiGCuuSQdj+G4mVQg3yahdqWP4a0rxvOvLUi7hg==
X-Received: by 2002:a17:902:bd93:: with SMTP id q19-v6mr12821985pls.238.1533541886751;
        Mon, 06 Aug 2018 00:51:26 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.37])
        by smtp.gmail.com with ESMTPSA id v8-v6sm15023419pff.120.2018.08.06.00.51.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Aug 2018 00:51:26 -0700 (PDT)
Subject: Re: [PATCH] KVM: try __get_user_pages_fast even if not in atomic
 context
To:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     rkrcmar@redhat.com, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Junaid Shahid <junaids@google.com>,
        Xiao Guangrong <xiaoguangrong@tencent.com>
References: <1532706407-11380-1-git-send-email-pbonzini@redhat.com>
From:   Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <54a94492-bb0a-3d2c-6c34-64b6c4336b0a@gmail.com>
Date:   Mon, 6 Aug 2018 15:51:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1532706407-11380-1-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/27/2018 11:46 PM, Paolo Bonzini wrote:
> We are currently cutting hva_to_pfn_fast short if we do not want an
> immediate exit, which is represented by !async && !atomic.  However,
> this is unnecessary, and __get_user_pages_fast is *much* faster
> because the regular get_user_pages takes pmd_lock/pte_lock.
> In fact, when many CPUs take a nested vmexit at the same time
> the contention on those locks is visible, and this patch removes
> about 25% (compared to 4.18) from vmexit.flat on a 16 vCPU
> nested guest.
> 

Nice improvement.

Then after that, we will unconditionally try hva_to_pfn_fast(), does
it hurt the case that the mappings in the host's page tables have not
been present yet?

Can we apply this tech to other places using gup or even squash it
into  get_user_pages()?
