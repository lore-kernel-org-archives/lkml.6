Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D10C282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A52842083B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="LnReKgU1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbfAYRSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 12:18:54 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40688 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbfAYRSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 12:18:53 -0500
Received: by mail-ot1-f65.google.com with SMTP id s5so9169026oth.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 09:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XQwzfQ+g8/lwIfGTHRGy1n0AEx0pfFH9xW5jjLm4zeo=;
        b=LnReKgU1U8CYpZEXj/E+XkJangeDFTWfzzfavvZdkAkpQTyY1TAz0xaSRcFl+r9588
         hzSjjOgsBvX/mmhC+hqK3Iu/dwyzLhDCoSk0/SrbX7BjIabkzkXlcjheU4zHmT1Q+H3U
         vScxDxkffouKoUOHajbWWsSZyMw9+LA6uijy2GTT1WJpAZMv8TCp0BuujG0XRkxtGI9a
         WWCvLALgPULG70Y4vw235J7uT1+jOE1v16iHqUkFD0f5Zh8Mh5hx4/HJIj2OfYjvOmaU
         ma3s55tagkmtXmlcPFUVykbMOHUJ1Cm1tlgBK2uSgK3Y3TO6t+ZHBQZ0O51gt4fq5Se+
         Ek+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XQwzfQ+g8/lwIfGTHRGy1n0AEx0pfFH9xW5jjLm4zeo=;
        b=DkAN9aT61NEsgDyKv09AGUhxsoEGh8Y2VxhbFF+iCrpIPmVRDnwVlJnu9aEhIx86j8
         2Cju4/bJ+q6qzDNUqh18Tt7OGauxWoAER8NFNwKbxlvopYuOM+h6axQ/43P68AqgtBiC
         /ddoW6+fh5ZdBYhdCuDisPmnSB4SYOlu6qaMaYo+Tf+znC7x4DPTbUmF52TQSh0id61o
         mKHAS1AAZg/7Y+WbLMGHkLnDQxIawjkhQk1LoTJgNWk3JFIGSjN5GYDDJkX2audw9h/J
         Qn6MeLPPvqJ5Dqj3NqVsOUaK9iG0G074ROrlN3WuljUx9SGDY8goPOq4Kh36LODOA7ru
         6tdg==
X-Gm-Message-State: AJcUukfFB8wjmQA9huSEm5xObTygGGr5CCd2Rx8kgKl6mhHdlPVFU9y6
        BHTkVG9h0ahrC/X6G8cks9wFFIHmQ4GOJG7aj11z9w==
X-Google-Smtp-Source: ALg8bN5oXuw31EEf9F2R3TGHkiMr4UbkVW8V+zOC4h8DDdYruCknwG8HxfvTjalNj3CF4xuUYQl0atiwjUuLPUEpMCE=
X-Received: by 2002:a9d:7dd5:: with SMTP id k21mr8634698otn.214.1548436732242;
 Fri, 25 Jan 2019 09:18:52 -0800 (PST)
MIME-Version: 1.0
References: <20190124231441.37A4A305@viggo.jf.intel.com> <20190124231448.E102D18E@viggo.jf.intel.com>
 <0852310e-41dc-dc96-2da5-11350f5adce6@oracle.com> <CAPcyv4hjJhUQpMy1CVJZur0Ssr7Cr2fkcD50L5gzx6v_KY14vg@mail.gmail.com>
 <5A90DA2E42F8AE43BC4A093BF067884825733A5B@SHSMSX104.ccr.corp.intel.com>
In-Reply-To: <5A90DA2E42F8AE43BC4A093BF067884825733A5B@SHSMSX104.ccr.corp.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 25 Jan 2019 09:18:41 -0800
Message-ID: <CAPcyv4ikXD8rJAmV6tGNiq56m_ZXPZNrYkTwOSUJ7D1O_M5s=w@mail.gmail.com>
Subject: Re: [PATCH 5/5] dax: "Hotplug" persistent memory for use like normal RAM
To:     "Du, Fan" <fan.du@intel.com>
Cc:     Jane Chu <jane.chu@oracle.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Michal Hocko <mhocko@suse.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Takashi Iwai <tiwai@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        =?UTF-8?B?SsOpcj9tZSBHbGlzc2U=?= <jglisse@redhat.com>,
        Borislav Petkov <bp@suse.de>,
        Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Wu, Fengguang" <fengguang.wu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 12:20 AM Du, Fan <fan.du@intel.com> wrote:
>
> Dan
>
> Thanks for the insights!
>
> Can I say, the UCE is delivered from h/w to OS in a single way in case of machine
> check, only PMEM/DAX stuff filter out UC address and managed in its own way by
> badblocks, if PMEM/DAX doesn't do so, then common RAS workflow will kick in,
> right?

The common RAS workflow always kicks in, it's just the page state
presented by a DAX mapping needs distinct handling. Once it is
hot-plugged it no longer needs to be treated differently than "System
RAM".

> And how about when ARS is involved but no machine check fired for the function
> of this patchset?

The hotplug effectively disconnects this address range from the ARS
results. They will still be reported in the libnvdimm "region" level
badblocks instance, but there's no safe / coordinated way to go clear
those errors without additional kernel enabling. There is no "clear
error" semantic for "System RAM".
