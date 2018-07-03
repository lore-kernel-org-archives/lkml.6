Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D0CC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3A4C2497F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TaG8B+Bb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3A4C2497F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934331AbeGCRlD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 13:41:03 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:41881 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934004AbeGCRlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 13:41:01 -0400
Received: by mail-ua0-f193.google.com with SMTP id t14-v6so1768897uao.8;
        Tue, 03 Jul 2018 10:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kJEOx6+v+KNUdClGiyxZp7NEKY0BBxaw8d11yOEkpiU=;
        b=TaG8B+BbtszM77C0Y9LzgD5Yz1SX8ICXNrLQoQ7kLMgDAVWAV3VX+rf3Vuc+8qYRb1
         tXbilJxkSS10gILoe6td1o9qdKxrT9TmYNxSiovSZ+jUBfp8Ulxfq8MDk3hWf7Y5VQ+H
         cm8hP+C+WkysD06Q13CuEqlddh5ukRSEbavK5vMrHn033UnGn87NfgAX146ksH6Wfha1
         cigr1VQwzeKoUhR+JVkVYdbn+a5s5wXJBz8hmzR+q02ewuPFNASbBmlntn+A56rfcTC0
         2V7Cxbn623Bu/umbMWxzqXiuT20EbgxkaMPzZC9i4HpIJgYMw0ggvzcAsA6XtWUrbAfu
         BBHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kJEOx6+v+KNUdClGiyxZp7NEKY0BBxaw8d11yOEkpiU=;
        b=sZkTs1ngf78fysqVjAGsT+N7vGeQOQZr8liaBgAUeagSUdcdZSMPfPOLLt4DBnb9XV
         rSPUODGTuaD7dfazFpZm/YSDtdIQ0XLt0fGmlvn+TmPE9IQoQQKVorCm8+YC6UcewuTH
         SKH42XXnqcTJ06qHR8SHjA0pimKEhmlKdNivnwqegjKteQegSlQ001m0s7aQEewtxPGT
         aDbiwYvfLJPVze+8DK2wn2fmLFqgmiKYkX/mPEUAPusF2B3+F2TnQXXt9QO3k/GGCfwf
         0L2hqbIP9qA8ofMDfiMFa2y1PSfFjkozn/GypbbRLG8/yV0HUUeWj+PoQGiK4BObM8Rm
         WhXA==
X-Gm-Message-State: APt69E2+G5zEAA6pDFTTP1xIW4zbfq0dBxicXM+590hi3AQ3v/4G05z7
        HRh5z2/yIo0MKYEyC4SSN2sDGrq0OZbENU68DIU=
X-Google-Smtp-Source: AAOMgpdkJY0ysMZeI7bBdIaMydmz7wUh/Tnb2Mw+9xOq08Aq8AwJ981SrWqIy6Zxz0jjPcge22PfmkIk6GyEnFBYD5A=
X-Received: by 2002:ab0:1446:: with SMTP id c6-v6mr19156947uae.12.1530639660841;
 Tue, 03 Jul 2018 10:41:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 10:41:00 -0700 (PDT)
In-Reply-To: <1530609760-8919-1-git-send-email-srinath.mannam@broadcom.com>
References: <1530609760-8919-1-git-send-email-srinath.mannam@broadcom.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 3 Jul 2018 20:41:00 +0300
Message-ID: <CAHp75VfPvCD7xpp73jbya4ONN=wxpVGNpOfNeqZYjfyirms0PA@mail.gmail.com>
Subject: Re: [RFC PATCH] ACPI: bus: match of_device_id using acpi device
To:     Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Ray Jui <ray.jui@broadcom.com>,
        vladimir.olovyannikov@broadcom.com, vikram.prakash@broadcom.com,
        scott.branden@broadcom.com,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 3, 2018 at 12:22 PM, Srinath Mannam
<srinath.mannam@broadcom.com> wrote:
> This patch provides a function, to get of_device_id after
> matching with ACPI device _DSD object compatible property
> in the case driver does not contain acpi_device_id list
> and driver probe called for ACPI device ID PRP0001 with
> compatible property match with of_device_id compatible.

I don't see any usefulness of this function. Care to provide a real use case?

-- 
With Best Regards,
Andy Shevchenko
