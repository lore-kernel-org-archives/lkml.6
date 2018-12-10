Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE2CC5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E2A72082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:39:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E2A72082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbeLJRjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:39:17 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36151 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbeLJRjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:39:16 -0500
Received: by mail-qk1-f195.google.com with SMTP id o125so6976291qkf.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 09:39:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=0Tzw+bPbD552yre4ofe6O8Z7D/IxI1vXcVBweiDlGPY=;
        b=pu/JISFdnqaTNSzheZikCyFx7jN5Ocpzt3P8yI1dJe2QWVpIsss3qGho+zEMNHxy/J
         7O/23ZJUiWEhORf0nan0KR4r6QFLwR8oYiFaa9X+xRP/7gi4imSb7c4Nn5kOmIgB2hTy
         ScY9iOngu0Gyx+UIx7ejRbvCVcWLR9HV0tH8/PEF0Yrraesl3jSzNLpGD3wsI/pgGwzN
         bAWQzsC3PFIjIaR/kCABocDb1c1CrqtxXvQhO1cRRwsVqWyZmjo87VcPNlq+/LnXJ4o6
         p0hbKhWcXrMndwdHFN3wVQMEiAi5VzmoB80+VQI6R2jntWJMjsB3iVQK2sTgBiPKVkCZ
         //bg==
X-Gm-Message-State: AA+aEWaovADRcVKTlQNjveI5UGK+0DZS6p88Kir6cDFuBigO4v107UxQ
        BVR97AGCSLTeRlt81XE+wj7yLXKTpwtXNQ==
X-Google-Smtp-Source: AFSGD/XSNd2iZ7i9gvHnF5qO8nxwbSi3Qt+i5lewbU62qJMvNeD75kQvOhygVrT/EWC3r0QcQAwRfQ==
X-Received: by 2002:a37:7e86:: with SMTP id z128mr11326487qkc.20.1544463555817;
        Mon, 10 Dec 2018 09:39:15 -0800 (PST)
Received: from [10.150.73.190] (122.sub-174-228-2.myvzw.com. [174.228.2.122])
        by smtp.gmail.com with ESMTPSA id u50sm7886787qta.23.2018.12.10.09.39.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 09:39:14 -0800 (PST)
Subject: Re: Official Linux system wrapper library?
To:     Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Daniel Colascione <dancol@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Linux API <linux-api@vger.kernel.org>
References: <CAKOZuesB4R=dCz4merWQN0FSCGrXmOgUUr4ienSbStBJguNv8g@mail.gmail.com>
 <20181110192027.GA29892@kroah.com>
 <cd4717c4-4950-7513-726d-2e1873aeceb5@redhat.com>
 <20181112023630.GA20359@kroah.com> <20181112090828.2573987d@lwn.net>
 <b3d765e1-69a0-d4f0-b04a-40c19df8111c@infradead.org>
 <20181210092706.1aa54432@lwn.net>
From:   Carlos O'Donell <carlos@redhat.com>
Openpgp: preference=signencrypt
Organization: Red Hat
Message-ID: <f3db1a75-e6f2-06a8-5264-a6807b7b4538@redhat.com>
Date:   Mon, 10 Dec 2018 12:39:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181210092706.1aa54432@lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/18 11:27 AM, Jonathan Corbet wrote:
> On Sat, 8 Dec 2018 20:38:56 -0800
> Randy Dunlap <rdunlap@infradead.org> wrote:
> 
>> On 11/12/18 8:08 AM, Jonathan Corbet wrote:
>>> On Sun, 11 Nov 2018 18:36:30 -0800
>>> Greg KH <gregkh@linuxfoundation.org> wrote:
>>>   
>>>> We should have a checklist.  That's a great idea.  Now to find someone
>>>> to write it... :)  
>>>
>>> Do we think the LPC session might have the right people to create such a
>>> thing?  If so, I can try to put together a coherent presentation of the
>>> result.  
>>
>> Hi,
>> Did anything ever happen with this syscall checklist suggestion?
> 
> No, we really didn't have the right people around to do that,
> unfortunately.  

We already have Documentation/process/adding-syscalls.rst.

The documentation there is quite thorough.

It lists things that people commonly forget e.g. email linux-api@vger.kernel.org.

Would it be acceptable to attempt to collate per-libc information
into the adding-syscalls.rst under a new section called:

"Integration with libc"

-- 
Cheers,
Carlos.
