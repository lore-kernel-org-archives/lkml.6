Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02615C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7C0720823
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:50:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7C0720823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729931AbeKABtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 21:49:40 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52101 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729857AbeKABtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 21:49:40 -0400
Received: by mail-wm1-f67.google.com with SMTP id w7-v6so4775902wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 09:50:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m4MYkDt5fyvPu71NyYMuaM363BviD/xSenbwmVit2tw=;
        b=QihZ53o8qmaWqeP7/2mVjhR+cod+B5BviZ3qlcOY+MItikN+zqlQHPOp94RVR8HVBB
         S6aLAKimNkharsbPwwkUO/EAD7mbXIYqPvOvUxdDmg8Fbmk46KtxNkZvAuSIIhPLNkr/
         hToxz9neY2pRCM+j+ANUNwNlBbpA4EeH++7XQWzVNK+XtjTMb1weO4eSdikfJ+gDwUMs
         pPa/JU5B5VHhMMgtJg3Z919kc/5l+YM+LIkgCa8mGLPZDEPCxiis3GZ9vCKEqjZfvzwZ
         +2wTpGtWCY5dhLOm1HFSEdbdRGmMmafy1K8WVNj7sXVoVVg7ByDM/7wQVmFAHnfiC0Wu
         Egeg==
X-Gm-Message-State: AGRZ1gJaTs54718e9asDSomCt8BawjARx4KaApXEhRsDtTDLGfMB88yM
        6K3zDmIqghXOpXnFV789FwOHGQ==
X-Google-Smtp-Source: AJdET5enqobYYiadQYBvg0lA7l+2N53TlY8b0n2By7AglLeTmZN507faJ2H92RR1b+er0HJwP7r5Lg==
X-Received: by 2002:a1c:2cc5:: with SMTP id s188-v6mr3129465wms.52.1541004649364;
        Wed, 31 Oct 2018 09:50:49 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id l5-v6sm3672979wrv.84.2018.10.31.09.50.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 09:50:48 -0700 (PDT)
Subject: Re: linux-next: Tree for Oct 31 (vboxguest)
To:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20181031145907.1ee2e866@canb.auug.org.au>
 <661e44c7-396a-6d58-efa7-ed292f2677c6@infradead.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <560c85c8-1ee2-31b0-3148-a08f56a25a2e@redhat.com>
Date:   Wed, 31 Oct 2018 17:50:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <661e44c7-396a-6d58-efa7-ed292f2677c6@infradead.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 31-10-18 16:51, Randy Dunlap wrote:
> On 10/30/18 8:59 PM, Stephen Rothwell wrote:
>> Hi all,
>>
>> Please do not add any v4.21/v5.1 code to your linux-next included trees
>> until after the merge window closes.
>>
>> Changes since 20181030:
>>
> 
> 
> on i386:
> 
> ld: drivers/virt/vboxguest/vboxguest_core.o: in function `vbg_ioctl_hgcm_call':
> vboxguest_core.c:(.text+0x212b): undefined reference to `vbg_hgcm_call32'

Are you perhaps using weird compiler options?

This call should be optimized out on i386 (and we rely on calls being
removed be dead code elimination to avoid #ifdefs in various places,
iow this is a normal thing to rely on) :

First we have:

	bool f32bit = false;

...

         switch (req_no_size) {
#ifdef CONFIG_COMPAT
         case VBG_IOCTL_HGCM_CALL_32(0):
                 f32bit = true;
                 /* Fall through */
#endif
         case VBG_IOCTL_HGCM_CALL(0):
                 return vbg_ioctl_hgcm_call(gdev, session, f32bit, data);
	}

And then we also have:

static int vbg_ioctl_hgcm_call(struct vbg_dev *gdev,
                                struct vbg_session *session, bool f32bit,
                                struct vbg_ioctl_hgcm_call *call)
{
	...

         if (f32bit)
                 ret = vbg_hgcm_call32(gdev, client_id,
                                       call->function, call->timeout_ms,
                                       VBG_IOCTL_HGCM_CALL_PARMS32(call),
                                       call->parm_count, &call->hdr.rc);
         else
                 ret = vbg_hgcm_call(gdev, client_id,
                                     call->function, call->timeout_ms,
                                     VBG_IOCTL_HGCM_CALL_PARMS(call),
                                     call->parm_count, &call->hdr.rc);
}

So on i386 CONFIG_COMPAT is never set, this f32bit is a 0 const
and the compiler removes the if branch of the if ... else ...

This has been upstream like this since 4.16 without any problems sofar.

Regards,

Hans
