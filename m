Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF45C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 05:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 307E02145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 05:56:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 307E02145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbeJRN4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 09:56:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42780 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727328AbeJRN4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 09:56:07 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A55B989E3;
        Thu, 18 Oct 2018 05:56:48 +0000 (UTC)
Received: from localhost (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E7644608E0;
        Thu, 18 Oct 2018 05:56:47 +0000 (UTC)
Date:   Thu, 18 Oct 2018 13:56:44 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org,
        bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        keescook@chromium.org, msys.mizuma@gmail.com,
        indou.takao@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v9 3/8] x86/boot: Add efi_get_rsdp_addr() to dig out RSDP
 from EFI table
Message-ID: <20181018055644.GG1885@192.168.1.4>
References: <20181017102012.872-1-fanc.fnst@cn.fujitsu.com>
 <20181017102012.872-4-fanc.fnst@cn.fujitsu.com>
 <20181018043539.GF1885@192.168.1.4>
 <20181018055403.GE12871@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181018055403.GE12871@localhost.localdomain>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 18 Oct 2018 05:56:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/18 at 01:54pm, Chao Fan wrote:
> On Thu, Oct 18, 2018 at 12:35:39PM +0800, Baoquan He wrote:
> >On 10/17/18 at 06:20pm, Chao Fan wrote:
> >> There is a bug that kaslr may randomly choose some positions
> >> which are located in movable memory regions. This will break memory
> >> hotplug feature and make the movable memory chosen by KASLR can't be
> >> removed. So dig SRAT table from ACPI tables to get memory information.
> >
> >This patch is only adding a function efi_get_rsdp_addr() which will be
> >used in later patch. Do we need to describe bug here?
> 
> Yes, it's the first mail of this serial, so I add more log.

patch 3/8?

