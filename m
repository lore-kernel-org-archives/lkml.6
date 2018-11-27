Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FBA1C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1F9B2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:15:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1F9B2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbeK0SMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 13:12:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36440 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727311AbeK0SMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 13:12:25 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E3E383086259;
        Tue, 27 Nov 2018 07:15:29 +0000 (UTC)
Received: from localhost (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B88A5C5BB;
        Tue, 27 Nov 2018 07:15:28 +0000 (UTC)
Date:   Tue, 27 Nov 2018 15:15:25 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Bhupesh Sharma <bhsharma@redhat.com>
Cc:     linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        bp@alien8.de, mingo@kernel.org, tglx@linutronix.de,
        k-hagio@ab.jp.nec.com, anderson@redhat.com, james.morse@arm.com,
        osandov@fb.com, x86@kernel.org, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] x86_64, vmcoreinfo: Append 'page_offset_base' to
 vmcoreinfo
Message-ID: <20181127071525.GF1824@MiWiFi-R3L-srv>
References: <1542318469-13699-1-git-send-email-bhsharma@redhat.com>
 <20181126012824.GB1824@MiWiFi-R3L-srv>
 <CACi5LpPqdzNxi4=UQqVgT6aCyn9nx+sjM-ds0Xx6qBji_xgP1g@mail.gmail.com>
 <20181127064816.GE1824@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127064816.GE1824@MiWiFi-R3L-srv>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Tue, 27 Nov 2018 07:15:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/18 at 02:48pm, Baoquan He wrote:
 
> #ifdef CONFIG_DYNAMIC_MEMORY_LAYOUT
> 	VMCOREINFO_SYMBOL(node_data);
	^^^ 

> #endif

Wrong copy
#ifdef CONFIG_DYNAMIC_MEMORY_LAYOUT
	VMCOREINFO_NUMBER(page_offset_base);

#endif

