Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981DBC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63F5020652
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WvrRJZck"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731180AbfAPVoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 16:44:38 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51636 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730413AbfAPVoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 16:44:38 -0500
Received: by mail-wm1-f65.google.com with SMTP id b11so3677349wmj.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 13:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=amyYQ0mfOwL3n6qC0TXaw+DPRTwqAe3I4F6HyJ5F61I=;
        b=WvrRJZckgwYnrL8o7H1BhdjbnhUOYZ5cIpiQdXpURKsYQUjBW2kOU4fugchO1Cl4cG
         I/S6SqE+nOQTxvbLPDMfKOPzbnDzFkZhooeD8XGQ0EnzNKKCEgkkxvJALkT0CMe6Kywr
         ZwpQ7x9EkJMHlUql89jGO5p0M7ATjqCAxzwGzychKyRuj536GlWdmov6D4A5G48RGA97
         yEP1BQ9JK95B5AA8idfBRF6opo+UmIX1Yk1OQs2uZg0aUdP7Anmr3dK8UbeQ4ymZS/yC
         qAIv2cbK03txqy/MH7MrDZL0H6nUWVgBTCVY28kOU8wgJ15IeorgnSEIIvrhQrC3iIS/
         Szxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=amyYQ0mfOwL3n6qC0TXaw+DPRTwqAe3I4F6HyJ5F61I=;
        b=adOO5W+ZcjA9vic+8SeFcCshZoCfF1l9A7fTbg9W03fTMfEeazFrEJWlsnpdR6mrg0
         yXl+aQwGOy+TeYq8FZQ3kCEW3iUwcm8/IaaqfzBNUb2DJHKjNY3TOmkOclXMXFhIWPOk
         GVos3Tk3ju0bZrVULHGGHwQLPnR6iiYx2RkV3FBm7z3F0Utg41X8RfEiVlP3xuCZeCDd
         lIE6I8Pg6abQFEYMSGAzJAwALAb9skQUNAJVrEzFe1k762SHV7lgpMqUOSz9EVmCJR//
         K03B//MZsJ9RPu0C59FGQTlLeamYmuLz84yVr1W91Qi4B39n8Kn76Jwjazd/3K7sfJ9i
         Ps0Q==
X-Gm-Message-State: AJcUukdawbmEOxZ/RvBUysp0C2SE9ourGempEpSB3WeBmhkSJ1wF7nGB
        hdku1iN6Sc51yucq3cxQALXOfrD4vBUd+6zmwiKQ
X-Google-Smtp-Source: ALg8bN4aRs8NjUoaYnVv6BJ5a7G4g1K/+JOsgkZQhu8PJhsiMXYYgLxhSUX8+eErltERHwUCx6l/99SRc8QVR567Q/A=
X-Received: by 2002:a1c:5984:: with SMTP id n126mr8815661wmb.62.1547675076484;
 Wed, 16 Jan 2019 13:44:36 -0800 (PST)
MIME-Version: 1.0
References: <20190116181859.D1504459@viggo.jf.intel.com> <20190116181905.12E102B4@viggo.jf.intel.com>
 <CAErSpo55j7odYf-B-KSoogabD9Qqt605oUGYe6td9wZdYNq_Hg@mail.gmail.com> <98ab9bc8-8a17-297c-da7c-2e6b5a03ef24@intel.com>
In-Reply-To: <98ab9bc8-8a17-297c-da7c-2e6b5a03ef24@intel.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Wed, 16 Jan 2019 15:44:24 -0600
Message-ID: <CAErSpo6ipXF1P=tHif_ezksD_ka54LYqsc1B11Ddfksm2hp6Jg@mail.gmail.com>
Subject: Re: [PATCH 4/4] dax: "Hotplug" persistent memory for use like normal RAM
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Dave Hansen <dave@sr71.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, zwisler@kernel.org,
        vishal.l.verma@intel.com, thomas.lendacky@amd.com,
        Andrew Morton <akpm@linux-foundation.org>, mhocko@suse.com,
        linux-nvdimm@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, Huang Ying <ying.huang@intel.com>,
        Wu Fengguang <fengguang.wu@intel.com>,
        Borislav Petkov <bp@suse.de>, baiyaowei@cmss.chinamobile.com,
        Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 3:40 PM Dave Hansen <dave.hansen@intel.com> wrote:
> On 1/16/19 1:16 PM, Bjorn Helgaas wrote:
> > On Wed, Jan 16, 2019 at 12:25 PM Dave Hansen
> > <dave.hansen@linux.intel.com> wrote:
> >> From: Dave Hansen <dave.hansen@linux.intel.com>
> >> Currently, a persistent memory region is "owned" by a device driver,
> >> either the "Direct DAX" or "Filesystem DAX" drivers.  These drivers
> >> allow applications to explicitly use persistent memory, generally
> >> by being modified to use special, new libraries.
> >
> > Is there any documentation about exactly what persistent memory is?
> > In Documentation/, I see references to pstore and pmem, which sound
> > sort of similar, but maybe not quite the same?
>
> One instance of persistent memory is nonvolatile DIMMS.  They're
> described in great detail here: Documentation/nvdimm/nvdimm.txt

Thanks!  Some bread crumbs in the changelog to lead there would be great.

Bjorn
