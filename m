Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73588C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 14:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2595421CCE
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 14:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KViOBjum"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2595421CCE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbeHJQ4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 12:56:00 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33191 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727432AbeHJQ4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 12:56:00 -0400
Received: by mail-oi0-f68.google.com with SMTP id 8-v6so16152806oip.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 07:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=fnaS4uVFqTvqIZb70ZaW5pdrA5hrWuwgqkgACiYhgA4=;
        b=KViOBjumd8deOdoV/+uVymLq2OZeNooaSy/ys4mRowcQOHMFVPqSnq/ZxcxWBa/x/K
         NuuRaGRGXTG3MQmCTBDigbOf6n8XZnVxUuqYDgFwgmyNC0jh+glUkzUnMMpXn56LALrf
         7xPYc6uAyzCUTTkfdW9o4/YTBcpFOjhZZMhVACB/ow3IpfMqW8GVYz1pYDCNmaED4eVl
         QSGSIdcBbZcHahlC6F4bs6HWVnuSxL5A+L0CnoKwJR5fjl6BQxywWbaOXwaJ/2EFnPKO
         fvGNedmp4Veu72hMQA/9SnLjRVGnIuTt9N/zJA612Topepy+vN+i7oqdGSTI83Fgi7Qq
         NWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=fnaS4uVFqTvqIZb70ZaW5pdrA5hrWuwgqkgACiYhgA4=;
        b=iNUYHfcsmW6LCjcl8H5mdxuVcKQjxBHYP/wWCvgwxS7IFKMcjC5WK4l5QsQqcly9Jz
         F/Gc5DpzKY4VgejqZkV2BCiF/QQBfkkuOsI8aTffrg0NTySf/2iQPVH7tqKHLd5II1jN
         TV8A26/dJAmwVhtg45uUsyIQau2xp3OPUX5Y/bK0IsBG/sqgOWXPA83ZyiNAaD6yHAlV
         e+tG1fJGxir/P5tI8ROvspRSd5ZkRDS3gWP7VvTsW8vc1wtvrdmbS+vzFPcVEv56U1sA
         USn4T+UyCqis2bKtRV3WsXTI3VVhexb3TATYgmR1SEQOEw0TfeNnAVksDTTb6WkNXsU8
         aVew==
X-Gm-Message-State: AOUpUlHnwp0we9fRVhvKwiyX90vJHIeCY6ZNDtYs/wNO1tgpl3QsUHYW
        JYjdDb/4WWpNBwyjky/YwaSLX6jOFHKPT4cHKT8=
X-Google-Smtp-Source: AA+uWPwH9RuzqBRxN3l35a05xNNQCocoTvCwLaWBvHCEjZmnc7HkPt2QrxVpGFK0uMZB2R9+/lfT9iq6TLd80muwDMQ=
X-Received: by 2002:a54:4081:: with SMTP id i1-v6mr7211327oii.73.1533911140323;
 Fri, 10 Aug 2018 07:25:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:1785:0:0:0:0:0 with HTTP; Fri, 10 Aug 2018 07:25:39
 -0700 (PDT)
In-Reply-To: <20180810130052.GC1644@dhcp22.suse.cz>
References: <20180809025409.31552-1-rashmica.g@gmail.com> <20180809181224.0b7417e51215565dbda9f665@linux-foundation.org>
 <CAC6rBs=yYYZw-c02yp6rx-+TN2oUGgrp=uuLhZ=Kc_nnjmTRqA@mail.gmail.com> <20180810130052.GC1644@dhcp22.suse.cz>
From:   Rashmica Gupta <rashmica.g@gmail.com>
Date:   Sat, 11 Aug 2018 00:25:39 +1000
X-Google-Sender-Auth: zOj9B6xeL2IOkIPWYET0HsCt8UI
Message-ID: <CAC6rBsmkTSSg1RhWkpU-t+tQdyz7NKbfu96tX9BG1=LOGVg-Bw@mail.gmail.com>
Subject: Re: [PATCH v3] resource: Merge resources on a node when hot-adding memory
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, toshi.kani@hpe.com,
        tglx@linutronix.de, bp@suse.de, brijesh.singh@amd.com,
        thomas.lendacky@amd.com, jglisse@redhat.com,
        gregkh@linuxfoundation.org, baiyaowei@cmss.chinamobile.com,
        dan.j.williams@intel.com, iamjoonsoo.kim@lge.com,
        Vlastimil Babka <vbabka@suse.cz>, malat@debian.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Oscar Salvador <osalvador@techadventures.net>,
        yasu.isimatu@gmail.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Mike Rapoport <rppt@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 11:00 PM, Michal Hocko <mhocko@kernel.org> wrote:
> On Fri 10-08-18 16:55:40, Rashmica Gupta wrote:
> [...]
>> Most memory hotplug/hotremove seems to be block or section based, and
>> always adds and removes memory at the same place.
>
> Yes and that is hard wired to the memory hotplug code. It is not easy to
> make it work outside of section units restriction. So whatever your
> memtrace is doing and if it relies on subsection hotplug it cannot
> possibly work with the current code.
>
> I didn't get to review your patch but if it is only needed for an
> unmerged code I would rather incline to not merge it unless it is a
> clear win to the resource subsystem. A report from Oscar shows that this
> is not the case though.
>

Yup, makes sense. I'll work on it and see if I can not break things.

> --
> Michal Hocko
> SUSE Labs
