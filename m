Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3994CC04EBC
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F18DD20831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NekcK1z6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F18DD20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729856AbeKTXbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 18:31:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:49920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbeKTXbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 18:31:01 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC32320672;
        Tue, 20 Nov 2018 13:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542718920;
        bh=3ls13v4IDNZ0l20JCPMig83KiJijWKdjgTiKTj89oVc=;
        h=Date:From:To:Cc:Subject:From;
        b=NekcK1z6h0271qAPOznE//MDjaolnnJL9eJQZ4ddFVsayfAT/5UIRd+4tcX8dxl7C
         GCBNoQ0APAwGqZ3hFo4rRnv0FuZAlsKOW+pmrNbTL9RgiGkrrB9ypRxVSVWPGmg0J9
         VPthUgYtAhotiCaUbbUdYevMj65O1V3lIgj3X/tE=
Date:   Tue, 20 Nov 2018 22:01:56 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "zhangwei(Jovi)" <jovi.zhangwei@huawei.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: uprobe support mix of ftrace and perf
Message-Id: <20181120220156.7d94d8c707570411870222fd@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Oleg,

I have a question about the (revert) commit 48212542067a 
("tracing/uprobes: Revert "Support mix of ftrace and perf""). I found
this limitation still exists on uprobe events. 

Would you have any plan or idea to fix this issue? I thought this revert
patch was a tentative one, and should be fixed afterwards.

Since kprobe events already supported the mix of ftrace and perf, user may
confuse why they can not use the uprobe event if it is used by ftrace.
(perf probe treats both events transparently, and ftrace event interface too.)

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
