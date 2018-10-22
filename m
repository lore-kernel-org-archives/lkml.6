Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957CAC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 17:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C6E6205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 17:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oh4K+y1K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C6E6205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbeJWBgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 21:36:37 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33102 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbeJWBgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 21:36:37 -0400
Received: by mail-oi1-f195.google.com with SMTP id a203-v6so32896061oib.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 10:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kFIWSwlcatuK7qVAXayXThw+ohAJ50Y01Za95waL/78=;
        b=oh4K+y1KKj6YyJmAB29kgwyrt/IGKLgNs/zdSNEDl4C0o8NAzsziU6TFtDn1mueC1l
         lbWUmO5RJbI2xNhRhn1Pq79TTdvnZkwYoMnQPMyjjTVVt1qK5cORItpnX0BQlHZcf6qF
         KJ6A25DTmRsZUbEg5cX6o7fRUUqPLEeHM65lUgyfL6Fv3hAzuEHaGnrEYDn13xYS2NOx
         a0N7+dLPeHQLXGPs/F6GQ7u3h5BKxeOb0eYHsq730cRIKjQbRQqfaa6g81A8i9GfAWDa
         HHl6rmqmt5EkdZIxp44Mtp+aSiTN9pQvCZtb6o2OePh6wev93AiYyFApXmmBdxQrkFX1
         8bIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kFIWSwlcatuK7qVAXayXThw+ohAJ50Y01Za95waL/78=;
        b=ajftlML2t4hwHADIbCJBlTrm1wcsjk1UgMSB1qTtCMspjBolDzyl6r9/kAGil0osDo
         LILyHvo0v/4PxqU1qJQm/uvbj1O47eaU9DdFxOXAoLtYAN2YVvgkeqNX039vz2RK2Ki4
         Y1tCdwkQxkFlLlzMSZU53kVjFjA9koG/pBQPjQak+PJojZE9OXphCMKDGY/2xMhuwK10
         XygiAg5s7fcZiJHLhuh8Fcad68REgZtJr5WJoDjJQHcxTmQ8FlMVTlJNX6JYR/FsCIGr
         U4w0yD0InSISKY/dGmjGuxYe2g1bGByZAFhRGj3gH0SVxhQ87M1AreLXHDicgG4+MBG9
         fDBw==
X-Gm-Message-State: ABuFfohwwmgA0Jyw6z+5ll/QU4NrLHH7c+K/ctGk690VWJFd6EplC+w/
        JMhKf6jsaNY+NPAkCyNV8nWZL8/9ugPJ8SigNfobQg==
X-Google-Smtp-Source: ACcGV61gtjplMmes948jvbCVlCZfSTnIW/IhOPkUrThuWnldyXFsDGNxlXbA6uUX4YdSJ7hgroi0J1PRBwWm2B6MshY=
X-Received: by 2002:aca:60c5:: with SMTP id u188-v6mr25453180oib.4.1540228634577;
 Mon, 22 Oct 2018 10:17:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:2ac9:0:0:0:0:0 with HTTP; Mon, 22 Oct 2018 10:17:13
 -0700 (PDT)
In-Reply-To: <1540074145-31285-2-git-send-email-karahmed@amazon.de>
References: <1540074145-31285-1-git-send-email-karahmed@amazon.de> <1540074145-31285-2-git-send-email-karahmed@amazon.de>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 22 Oct 2018 10:17:13 -0700
Message-ID: <CALMp9eRBQQoB6d9j8EECQk-vp9j6M7d2d9BYrJuijHUj2-w75A@mail.gmail.com>
Subject: Re: [PATCH v3 01/13] X86/nVMX: handle_vmon: Read 4 bytes from guest memory
To:     KarimAllah Ahmed <karahmed@amazon.de>
Cc:     kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 20, 2018 at 3:22 PM, KarimAllah Ahmed <karahmed@amazon.de> wrote:
> Read the data directly from guest memory instead of the map->read->unmap
> sequence. This also avoids using kvm_vcpu_gpa_to_page() and kmap() which
> assumes that there is a "struct page" for guest memory.
>
> Suggested-by: Jim Mattson <jmattson@google.com>
> Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
Reviewed-by: Jim Mattson <jmattson@google.com>
