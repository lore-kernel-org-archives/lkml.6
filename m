Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED12C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D2B420868
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547743364;
	bh=0KM7Q2Ye8rje97OoDmOUXJjJ/fcMlZQWalhwewbBS8E=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=Sk2EidgS+H9L+ani5lYCM8dWsu/2k7JChlLj2c76aq4Qs03o/iGNZgoWrRV+84AYz
	 pLsTy1EyzXXhPDHx6K0sgYL/LfAYoayH+hfmnOCgA9+R0qhhqzG3wIwdsJpmbQ5Zfv
	 yZIFb6C1hvHx2FFLaCU92vDh/yCVNeygCbqKs2fc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbfAQQmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 11:42:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:33484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728515AbfAQQmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 11:42:42 -0500
Received: from [10.84.151.4] (unknown [167.220.149.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5FEA20856;
        Thu, 17 Jan 2019 16:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547743361;
        bh=0KM7Q2Ye8rje97OoDmOUXJjJ/fcMlZQWalhwewbBS8E=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=puOyIoGpuUVMZq4iD6xjF+5dYd8NkFNnUj9AjhjGvH+g9gv1FwiNP5RE6/J4EfJnc
         hpRRdhNqOmf8bX984ndwDThe1v5Bhvy72jWyMGVRWfufxta/oGp07BWggvb1L2RMt3
         +D+2+J+TKVQ0R9UiAXqzgas8iNDI8Q6eXgAyfxek=
Subject: Re: [for-next][PATCH] x86/Kconfig: Select PCI_LOCKLESS_CONFIG if PCI
 is enabled
To:     Borislav Petkov <bp@alien8.de>, Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     linux-next@vger.kernel.org, linux-acpi@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
References: <20190117161722.3945-1-okaya@kernel.org>
 <20190117163722.GE5023@zn.tnic>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <c0fa174a-2e7b-2ef2-4913-167934c68c06@kernel.org>
Date:   Thu, 17 Jan 2019 11:42:39 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190117163722.GE5023@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/2019 11:37 AM, Borislav Petkov wrote:
> Also, I see a lot of build failures when doing randconfig builds for the
> stuff in drivers/platform/x86/Kconfig. Is someone picking those up too?

Can you share the build failures you are seeing?
