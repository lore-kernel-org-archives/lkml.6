Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7770BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CEF920842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551131192;
	bh=C25GZO8hpHq5eIuFb82F7meTg5qiVkwMtUcAklNHAp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2KreOVrHbg2mGES27Yzh/Ey93/mYwUlMhSOOnUurUJqhNe9MXuq0F5ObBcr/5OHsZ
	 8VAeokEiVsZqzCFcoE+e08lkAysef7ZR5SPJNous+IvMK8dgmXF3yQYkWf1oJqDqxK
	 jPVlm4VNOLOhIe0I8nHIzZJawrCzfZxvLDWW64aE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730936AbfBYVqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:46:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:34342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730855AbfBYV2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:28:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 866CC2087C;
        Mon, 25 Feb 2019 21:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130111;
        bh=C25GZO8hpHq5eIuFb82F7meTg5qiVkwMtUcAklNHAp4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n01keI70hQmomHTmWci9xmlhhRDY8Icx1jTFA/5PjEaiBSx2OXLf9u7dA53ZntlVu
         iU1aH74LWkohLN9tj1a0XSXviv+ch7M9nU1wiBr5LZPr272rJytnfOBo7wxbumvMzD
         2q9Jq5c/D8b1viY3MtxfBLqZB3qRHjK+xFdpkupc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joel Fernandes <joelaf@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.20 003/183] tracing: Fix number of entries in trace header
Date:   Mon, 25 Feb 2019 22:09:36 +0100
Message-Id: <20190225195055.248478401@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Quentin Perret <quentin.perret@arm.com>

commit 9e7382153f80ba45a0bbcd540fb77d4b15f6e966 upstream.

The following commit

  441dae8f2f29 ("tracing: Add support for display of tgid in trace output")

removed the call to print_event_info() from print_func_help_header_irq()
which results in the ftrace header not reporting the number of entries
written in the buffer. As this wasn't the original intent of the patch,
re-introduce the call to print_event_info() to restore the orginal
behaviour.

Link: http://lkml.kernel.org/r/20190214152950.4179-1-quentin.perret@arm.com

Acked-by: Joel Fernandes <joelaf@google.com>
Cc: stable@vger.kernel.org
Fixes: 441dae8f2f29 ("tracing: Add support for display of tgid in trace output")
Signed-off-by: Quentin Perret <quentin.perret@arm.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/trace.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3384,6 +3384,8 @@ static void print_func_help_header_irq(s
 	const char tgid_space[] = "          ";
 	const char space[] = "  ";
 
+	print_event_info(buf, m);
+
 	seq_printf(m, "#                          %s  _-----=> irqs-off\n",
 		   tgid ? tgid_space : space);
 	seq_printf(m, "#                          %s / _----=> need-resched\n",


