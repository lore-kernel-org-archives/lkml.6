Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F855C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11E45204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nexb-com.20150623.gappssmtp.com header.i=@nexb-com.20150623.gappssmtp.com header.b="1I8c1M0N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731767AbfAaPSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 10:18:51 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35335 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfAaPSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 10:18:50 -0500
Received: by mail-wr1-f67.google.com with SMTP id 96so3761541wrb.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 07:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexb-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+u65UW/bzBKl4uWpN9QXuoMUi4J86OV7xIXFJ1qNaUU=;
        b=1I8c1M0NQSh67W/eAkn5R4CDhhUAOOXLhZP/W1HIlmY/iiEeK9E5Rz7VTsNrJ3meXN
         Jyd49UE3kHpJ7GUBNQ4+85epMPFuVV1LovwmhdQWxFdKma5hVQ1klLMRO3+oTYR26TUs
         miwSe8b/64DW1wqev+a/zs8PCz5iBn4S63Jfshp5UGcRMBE+iZYA7KDTZUbU8HPSk/y/
         RsTw6PE/T92wTZB8/dc4Mt3muWcyuACfY4Jxmjwln+vDVBCEoVgDrTpS8xiP9jCJHcfZ
         Xu/sfgbdqZiFROwRsty3FrfOwIwVb5+0yPeNEk7ASw+RKrE0c9iv3rEbZG2lOp4a3Mvy
         71Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+u65UW/bzBKl4uWpN9QXuoMUi4J86OV7xIXFJ1qNaUU=;
        b=LmOZI7Krht6hrOphW98xbGUPplMdTyDubqRtZOn1cY/egKDG8OSLmgSEKRtyDp3LAz
         aviHoo1B3DJrqL88a+Gv813nmHbeTtaEuMKWPFJNAph/BCsTmUDkCOjz6hWn2wZjoDlr
         iFXxn6CDVxpo18SCFO9i/y/0mRlNY4khNR22XmzM7yNvuP8eWfHi9hJq1KiN5ZCxRcKM
         cVoc44WyQg5nVmRBVXQgHWyvBQfEXxgsFLqebWMibqyeKn488/R7H+UCr7jtFc9/LzLT
         +TzsT1STrsabrCZbFzdJwgqJFSDEuty85RczeOzZwpKKxO75TfzO7d200jB1Ja6urrX/
         Zxgw==
X-Gm-Message-State: AJcUukc4XgOGniargSl37Ramss1uPE0KyrwEeSmlAs11vXss2g8M39Hm
        38I+EPfmVYiUTyGVraLk9Lw2Trcwl+wKd8l4+lMN+g==
X-Google-Smtp-Source: ALg8bN4Z0h25omVOfwxNsc+AHEiAXfQ+5qsGS/7hUpPR0K8E6wWIQhgjHKuSRk9epwYSJjwS9d8/Y2scUtfNG0rAFlw=
X-Received: by 2002:adf:e149:: with SMTP id f9mr37638031wri.42.1548947929021;
 Thu, 31 Jan 2019 07:18:49 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1901282105450.1669@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1901282105450.1669@nanos.tec.linutronix.de>
From:   Philippe Ombredanne <pombredanne@nexb.com>
Date:   Thu, 31 Jan 2019 16:18:13 +0100
Message-ID: <CAOFm3uHGnxPHW6X7_q6DORBGp677mXz2aSuz8RMSDq0qS-2zBg@mail.gmail.com>
Subject: Re: [PATCH][RFC] module: Cure the MODULE_LICENSE "GPL" vs. "GPL v2" bogosity
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Jessica Yu <jeyu@kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Christoph Hellwig <hch@lst.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas:
On Mon, Jan 28, 2019 at 11:39 PM Thomas Gleixner <tglx@linutronix.de> wrote:
[...]
> As an unintended side effect this distinction causes a major headache for
> license compliance, license scanners and the ongoing effort to clean up the
> license mess of the kernel.

Glad to be of service and sorry for having helped a bit surface these!

>
> Therefore remove the well meant, but ill defined, distinction between "GPL"
> and "GPL v2" and document that:
>
>   - "GPL" and "GPL v2" both express that the module is licensed under GPLv2
>     (without a distinction of 'only' and 'or later') and is therefore kernel
>     license compliant.
>
>   - None of the MODULE_LICENSE strings can be used for expressing or
>     determining the exact license
>
>   - Their sole purpose is to decide whether the module is free software or
>     not.
>
> Add a MODULE_LICENSE subsection to the license rule documentation as well.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>


Thank you ++ for documenting all this : this is a small change but a big
step towards licensing clarity! Great that you found the commit that
introduced this too.

Feel free to add this if you want:
Acked-by: Philippe Ombredanne <pombredanne@nexb.com>

--
Cordially

Philippe Ombredanne
