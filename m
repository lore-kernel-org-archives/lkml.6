Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59889C65C30
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 11:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0786F2147D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 11:28:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0786F2147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbeJFSbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 14:31:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39884 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727456AbeJFSbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 14:31:38 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5780E30820D1;
        Sat,  6 Oct 2018 11:28:45 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8E6A95C21D;
        Sat,  6 Oct 2018 11:28:44 +0000 (UTC)
Date:   Sat, 6 Oct 2018 19:28:27 +0800
From:   Baoquan He <bhe@redhat.com>
To:     mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-doc@vger.kernel.org, tglx@linutronix.de, thgarnie@google.com,
        corbet@lwn.net
Subject: Re: [PATCH 0/3] x86/mm/doc: Clean up mm.txt
Message-ID: <20181006112827.GD5140@MiWiFi-R3L-srv>
References: <20181006084327.27467-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181006084327.27467-1-bhe@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Sat, 06 Oct 2018 11:28:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/18 at 04:43pm, Baoquan He wrote:
> This clean up is suggested by Ingo.
> 
> It firstly fix the confusions in mm layout tables by unifying
> each memory region description in the consistent style.
> 
> Secondly take the KASLR words out of the mm layout tables to make
> it as a separate section to only list mm layout in non-KASLR case.
> Then add KASLR document at the end of mm.txt.
> 
> Meanwhile update description about KERNEL_IMAGE_SIZE in
> arch/x86/include/asm/page_64_types.h .

Sorry, this is V3 post. I forgot adding v3 tag in patch subject.

> 
> v2->v3:
> Ingo helped to prettify the patch log and code comment, repost them
> after updating accordign to Ingo's suggestions.
> 
> v1->v2:
> 
> Resend v2 since some typo and incorrect descriptions found in v1 post.
> 
> Baoquan He (3):
>   x86/KASLR: Update KERNEL_IMAGE_SIZE description
>   x86/mm/doc: Clean up the memory region layout descriptions
>   x86/doc/kaslr.txt: Create a separate part of document abourt KASLR at
>     the end of file
> 
>  Documentation/x86/x86_64/mm.txt      | 150 +++++++++++++++++++++++------------
>  arch/x86/include/asm/page_64_types.h |  15 ++--
>  2 files changed, 107 insertions(+), 58 deletions(-)
> 
> -- 
> 2.13.6
> 
