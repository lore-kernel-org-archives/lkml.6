Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC722C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 782E220693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8j1DxVU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 782E220693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937299AbeFSFMS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 01:12:18 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:39396 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935908AbeFSFMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 01:12:17 -0400
Received: by mail-lf0-f65.google.com with SMTP id t2-v6so21682877lfd.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 22:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FNSOZOmA2ot7rKxU/a3LenCBv8RIBV3UFCmvkiMr8uc=;
        b=T8j1DxVUCvoe3RD8rnHF8KpwRdD2YDRNAvfkcHfeBujbb4rZPgWMP7RRJtjzeYj+r5
         1/V+2nK7pItUeZWYsWDtWLLIfvfsZRf7v6u65bdxVALl9BgtZfRn8BdFHMOTIdCshqf8
         fXQPblhfbAbqJEj6bjoVSfN6Pe6gONDF2/L6m5trkvJvETEu5a8Sjzyx//hXRYa+rdTz
         eme3AFv/Y+bNob8Cleu3//sYHO3/jz1cdyXlHVBWyMYkFXcACFkXBUJ8sgHuKl9jqewP
         pjmGAWaIG0OvIs/mgmTWwxTzviciD6qzQOXcbJZqzWuXphh1WaNignfGjN9WEtNtwBkE
         BKNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FNSOZOmA2ot7rKxU/a3LenCBv8RIBV3UFCmvkiMr8uc=;
        b=iDHlo6LNDBbtHmM/4HFzbLUNKAN7IIQnZnHylua9phdvMukIP8cpd0rOPygE0EiAJE
         qC+mfIJii01WoPnF28GMHnzeV2+wqDkGyw/wkovGv5hicdADEJvotsaofqoK6FHHHwPS
         Z/hFAxcsXrQ+xF4F/8It+XgOp6v32Bzv91bijydWClLkVHNe0OReGSlwgePHI7bIdAcz
         FY+yAV7v+bJkyuEbK1hSSEERf+solEAMk+HkM/MKWXam2iRYd9otGCDmqaUhbFJyvsu0
         WNt4R9wJDeyTX8HF3Jq/I3RKnDATLNcl0oEX/tjUwCSVlFqVPWBG3xpYR9jTUmVP1Frz
         PBaw==
X-Gm-Message-State: APt69E0mMGZzm2OyLdXHeYdRQ3ISnjKnWHYfSm+fRf0TgRBojyHdXxyn
        /NMRjOOI0Bow/m2JFpSWbUNRQbsMxOKiWNvbx5I=
X-Google-Smtp-Source: ADUXVKKDzviAmE368UqPzamw95RMNJFJoC5tsX1N27LnjysM8fY/eYXIjVluYecaixuwr71Quujw8z2Y/zsdcUEFKuA=
X-Received: by 2002:a2e:3613:: with SMTP id d19-v6mr9905589lja.31.1529385136204;
 Mon, 18 Jun 2018 22:12:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:2b43:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 22:12:15
 -0700 (PDT)
In-Reply-To: <CAFqt6zbQxx+20SNT8r1q2ZjtQZLTh=CC50s4LkHExkBju-1KJA@mail.gmail.com>
References: <20180510150448.GA26306@jordon-HP-15-Notebook-PC>
 <20180511092205.GB16141@n2100.armlinux.org.uk> <CAFqt6zY2amJC4bkRZJgjs7=wCuTTxZbufk9cXcMZLE8VGh_dww@mail.gmail.com>
 <CAFqt6zYyL6YfvmiX90=Te3PQdcK32irdPPU0awEbp9Q16Bz9=w@mail.gmail.com> <CAFqt6zbQxx+20SNT8r1q2ZjtQZLTh=CC50s4LkHExkBju-1KJA@mail.gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 19 Jun 2018 10:42:15 +0530
Message-ID: <CAFqt6zacTP-HgQzkXS=d2w-+=QbhkPA0oH9X5Py_GJ0+8_PcYQ@mail.gmail.com>
Subject: Re: [PATCH v2] gpu: drm: armada: Adding new typedef vm_fault_t
To:     Russell King - ARM Linux <linux@armlinux.org.uk>, airlied@linux.ie
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 4, 2018 at 10:46 AM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> On Wed, May 23, 2018 at 3:09 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
>> On Wed, May 16, 2018 at 10:05 AM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
>>> On Fri, May 11, 2018 at 2:52 PM, Russell King - ARM Linux
>>> <linux@armlinux.org.uk> wrote:
>>>> On Thu, May 10, 2018 at 08:34:48PM +0530, Souptick Joarder wrote:
>>>>> Use new return type vm_fault_t for fault handler in
>>>>> struct vm_operations_struct. For now, this is just
>>>>> documenting that the function returns a VM_FAULT
>>>>> value rather than an errno. Once all instances are
>>>>> converted, vm_fault_t will become a distinct type.
>>>>>
>>>>> commit 1c8f422059ae ("mm: change return type to vm_fault_t")
>>>>>
>>>>> Previously vm_insert_pfn() returns err which driver
>>>>> mapped into VM_FAULT_* type. The new function
>>>>> vmf_insert_pfn() will replace this inefficiency by
>>>>> returning VM_FAULT_* type.
>>>>>
>>>>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>>>>> Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
>>>>
>>>> Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
>>>>
>>>> Thanks.
>>>
>>> If no further comment, we would like to get this patch in queue
>>> for 4.18.
>>
>> We would like to get this patch in queue
>> for 4.18.
>
> We  would like to get this patch in 4.18.

Russell, This patch is not merged in 4.18-rc-1.
