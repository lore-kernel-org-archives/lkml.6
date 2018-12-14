Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A71EC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ABBF20879
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="J/ED42o1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ABBF20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729652AbeLNKiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 05:38:09 -0500
Received: from mail.skyhub.de ([5.9.137.197]:42260 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbeLNKiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 05:38:08 -0500
Received: from zn.tnic (p200300EC2BCFEF009546D97CB482D082.dip0.t-ipconnect.de [IPv6:2003:ec:2bcf:ef00:9546:d97c:b482:d082])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8CC6B1EC03D4;
        Fri, 14 Dec 2018 11:38:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544783887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=z6CR7+j0oY6mPrIPpCOL6AOOSjWqt7moRnBKoLZ5t5Q=;
        b=J/ED42o1wmAvC+ebcnD9t1HTsDYtNs6uCW37KeiC7ERB0XW8ZvZHHw3KWcJajypQeg/TbC
        hGqfgIfExmn49NqsobEEC6yBGiMyR+g/MhHvIZZh+7vwQZDjw4QZDXvpbnGPwub17Isivb
        MyrN/Nv65AfHBZiiRPCe5UUbk/ESbGc=
Date:   Fri, 14 Dec 2018 11:38:05 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, keescook@chromium.org, msys.mizuma@gmail.com,
        indou.takao@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v13 1/6] x86/boot: Introduce kstrtoull() to boot
 directory instead of simple_strtoull()
Message-ID: <20181214103805.GB11710@zn.tnic>
References: <20181212031053.1815-1-fanc.fnst@cn.fujitsu.com>
 <20181212031053.1815-2-fanc.fnst@cn.fujitsu.com>
 <20181212041218.GA28286@localhost.localdomain>
 <20181212080312.GP17340@MiWiFi-R3L-srv>
 <20181213132603.GD25287@zn.tnic>
 <20181214013421.GE24409@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181214013421.GE24409@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 09:34:21AM +0800, Chao Fan wrote:
> On Thu, Dec 13, 2018 at 02:26:03PM +0100, Borislav Petkov wrote:
> >On Wed, Dec 12, 2018 at 04:03:12PM +0800, Baoquan He wrote:
> >> Surely, using the old simple_strtoull() is fine too, we can take its
> >> replacement into TODO list.
> >
> >Yes, that would be nice.
> 
> Thanks, then I can use simple_strtoull() for now.

I don't understand - patch 1 in your v13 has kstrtoull() added to
boot/string.c. Why are you reverting back to simple_strtoull()?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
