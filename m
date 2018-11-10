Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78396C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 23:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36CAE20841
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 23:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="QfCLYI5H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36CAE20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbeKKJoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 04:44:38 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39395 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbeKKJoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 04:44:38 -0500
Received: by mail-oi1-f195.google.com with SMTP id 192-v6so4473945oii.6
        for <linux-kernel@vger.kernel.org>; Sat, 10 Nov 2018 15:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uHjsOLJmeLufXgzKF3JLoyfts9QnyR8Vd5qCx/b6F90=;
        b=QfCLYI5HCR7W4Vb/nO/GuwteVyArCSiPC5i24ZY8aWJKLNfEr7mJeZYAN0sPUXLyoY
         9skqzzX6sogJOzZny64PxemHMXRlSTv/xGZTEfzpjcp8CmQ/4isdF6na35Ke8UxECEdJ
         j3WrWyvU3L+DNl4YBQnpJA+wFmMUs4UExLtUfJcNzWxClTN/tUpjxPkyODFGBnLOx0Jo
         H+K2y6YxrOAXJSOJ+jqxJijyVnX8RnVGm4Wq/HG9eYgatAv6Jhld7jIYXmOMWPKdfcjJ
         +o6vuDurVPOSXSaTD3SOlMrLDgFTk5YI9Yhf/FxXC+N1v29bTNakeFuc39yJM8Qgw9CU
         li1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uHjsOLJmeLufXgzKF3JLoyfts9QnyR8Vd5qCx/b6F90=;
        b=Q2iQDUdspqSl6mecgCvnb9ZwhPXl/1Gsze2+lSur5VzVpye+ksAr0REDPxrJ8dYi6m
         UtASDAvqA/5joahB/a2fO1ljyAkGgHCvD7CXYO0DEtKrMqsamqC6lNOeJBGLnOCB4W9W
         1srkgh2wWS1iZIzYWkghfTTgjLbotlckMV+qrs8AgH0QYdozds4XcomBjhSwj0vRwgHO
         PUa5wgRtB/2MYJA+CYlRqDHjA+6t99ARwo5X8XZPS5px8CytUkQ9cTV1yg20atYoTw/X
         E8nQh3rBA+7elAwSbBA3LOK8s0Xscb/5iymeAK1OVpiYPlau7mT6gCtDJ6C5iGm64x9D
         9Bnw==
X-Gm-Message-State: AGRZ1gIqWfWkpItmP/XxC9Ri0u/U/yXpRuGKb96uUGtMPFK9lQWahnNM
        Ee1+yaJNpQFRsTivc5I6A16MkDAsULMxLnvA+8P+yQ==
X-Google-Smtp-Source: AJdET5eX2egYXSgNnB9qoY2/I6M7K8jG2hvfbrKlkkMzSx+vK/R6c37Zu4r6ZVI+EBdmVh02w7HAahZWOVfUVpWrwPU=
X-Received: by 2002:aca:e691:: with SMTP id d139-v6mr7640468oih.232.1541894272988;
 Sat, 10 Nov 2018 15:57:52 -0800 (PST)
MIME-Version: 1.0
References: <154180834787.2060925.7738215365584115230.stgit@dwillia2-desk3.amr.corp.intel.com>
 <7590EF40-B0CF-40BD-9D29-FB731A2A2E3A@amacapital.net>
In-Reply-To: <7590EF40-B0CF-40BD-9D29-FB731A2A2E3A@amacapital.net>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 10 Nov 2018 15:57:42 -0800
Message-ID: <CAPcyv4hXzBT1LkEdBYw_mkrKV+SK1LRE2PwJ5=T+e7GxWbXaNQ@mail.gmail.com>
Subject: Re: [PATCH] x86/mm/pat: Fix missing preemption disable for __native_flush_tlb()
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        stable <stable@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 9, 2018 at 4:22 PM Andy Lutomirski <luto@amacapital.net> wrote:
>
>
>
> > On Nov 9, 2018, at 4:05 PM, Dan Williams <dan.j.williams@intel.com> wro=
te:
> >
> > Commit f77084d96355 "x86/mm/pat: Disable preemption around
> > __flush_tlb_all()" addressed a case where __flush_tlb_all() is called
> > without preemption being disabled. It also left a warning to catch othe=
r
> > cases where preemption is not disabled. That warning triggers for the
> > memory hotplug path which is also used for persistent memory enabling:
>
> I don=E2=80=99t think I agree with the patch. If you call __flush_tlb_all=
() in a context where you might be *migrated*, then there=E2=80=99s a bug. =
We could change the code to allow this particular use by checking that we h=
aven=E2=80=99t done SMP init yet, perhaps.

Hmm, are saying the entire kernel_physical_mapping_init() sequence
needs to run with pre-emption disabled?
