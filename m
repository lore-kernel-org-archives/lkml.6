Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B65ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 12:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 357F620871
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 12:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJ37/X7s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 357F620871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730110AbeGMNLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 09:11:46 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33464 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729617AbeGMNLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 09:11:45 -0400
Received: by mail-lj1-f193.google.com with SMTP id t21-v6so24445000lji.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 05:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LsZFxSWbidbh6zS+i2hsyZ4722bHHWbtPG4wdHbl7uY=;
        b=ZJ37/X7sT3oOQwLtX/N57qduSNpWqniO/veg3TwE0i3fEw3m8hcsJ1XuWcC1PHNsCN
         /pjC+pDPOIvMAFjkXbYPEJ7ezb4N4noJYjR+DvSdZIhE9rEr5UGZwFZx9JfxZnUKlm0k
         1cNSKsa4WREpnZX1r9I1uY2Vl8TEdsZu46pNkUAHLfB0BJ3rmq8zGkGrPN/Cg9fsnSV0
         NfuiPRv4+N4Vk0VWWENaCQkkt4/N6Y3DMBulSuZYP7AX6DmZ0HblvmY27IOgUaFkGCXg
         DIpknjSj7H3AK94cPCWfTAubULUzgxx/w4Y8tPQCi9tZVWqWTFElPzOurJL2ND0uaY/n
         YV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LsZFxSWbidbh6zS+i2hsyZ4722bHHWbtPG4wdHbl7uY=;
        b=B8lFFP4V9ogh0g+eW8qZ+QeORIDBKO8+ep/JNGcrdN237+Bf/l/7Zb6Hk5sN5ZdYkL
         ls9VZdtpiX1LDvvGKRTFMu0N2/lpOBUHMfKrzZLr3ObsrCwmeEL3/kXQ7Y7cAWgcsTIb
         sIplelBo8oW+iylfwEHLq79N+e3AWyelN7jDW+3b74fLNXf05Pb8TswwpbjYqVkJZhKB
         AYbH5fCni+Hb06p2s+fVLuLb22kr7erc5r7rGVWoT9l0f8sjgqUS6MiOPmFgoz4XCug0
         M0pg7zwYeFGkDfsUtOX10v96wzhsrw2os6TkeUQN1+cyUXRwEd3GaexIA2Zi+RaBLapJ
         q1AQ==
X-Gm-Message-State: AOUpUlElLR8QTH8I5gmqwcTuZ0A676xHZ91XaPHhcxxJnJunTdvspsPZ
        sxtwz7tgY/Az5FDN2ddN/0ew7X04yrGpdYKecqc=
X-Google-Smtp-Source: AAOMgpc5dr5lKH9jhELgzysWPbrGDuga4ktVGB3kxa2pnyjJf9LbcGniP4kX6KR9ryfKwHoZ/gGmfASUJrOWGCL49b4=
X-Received: by 2002:a2e:2d11:: with SMTP id t17-v6mr3314403ljt.145.1531486631215;
 Fri, 13 Jul 2018 05:57:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:2b14:0:0:0:0:0 with HTTP; Fri, 13 Jul 2018 05:57:10
 -0700 (PDT)
In-Reply-To: <41Qft01FR3zB4MS@ozlabs.org>
References: <20180611202904.GA25538@jordon-HP-15-Notebook-PC> <41Qft01FR3zB4MS@ozlabs.org>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Fri, 13 Jul 2018 18:27:10 +0530
Message-ID: <CAFqt6zaBuJ=DRkDA4y4ecMzecGFXE0ddP2m9xfEXKHmnyFfcOQ@mail.gmail.com>
Subject: Re: misc: ocxl: Change return type for fault handler
To:     Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Matthew Wilcox <willy@infradead.org>, fbarrat@linux.vnet.ibm.com,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        brajeswar.linux@gmail.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 6:54 PM, Michael Ellerman
<patch-notifications@ellerman.id.au> wrote:
> On Mon, 2018-06-11 at 20:29:04 UTC, Souptick Joarder wrote:
>> Use new return type vm_fault_t for fault handler. For
>> now, this is just documenting that the function returns
>> a VM_FAULT value rather than an errno. Once all instances
>> are converted, vm_fault_t will become a distinct type.
>>
>> Ref-> commit 1c8f422059ae ("mm: change return type to vm_fault_t")
>>
>> There is an existing bug when vm_insert_pfn() can return
>> ENOMEM which was ignored and VM_FAULT_NOPAGE returned as
>> default. The new inline vmf_insert_pfn() has removed
>> this inefficiency by returning correct vm_fault_ type.
>>
>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>> Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
>> Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
>
> Applied to powerpc next, thanks.
>
> https://git.kernel.org/powerpc/c/a545cf032d11437ed86e62f00d4991
>
> cheers

Thanks :)
