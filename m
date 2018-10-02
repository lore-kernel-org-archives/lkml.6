Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE62C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92D482083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:29:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92D482083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbeJBVNB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 17:13:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40284 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbeJBVNB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 17:13:01 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CBE63C03E013
        for <linux-kernel@vger.kernel.org>; Tue,  2 Oct 2018 14:29:21 +0000 (UTC)
Received: from sansharm.bos.com (dhcp-17-34.bos.redhat.com [10.18.17.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6AFAD66D20;
        Tue,  2 Oct 2018 14:29:19 +0000 (UTC)
From:   Sanskriti Sharma <sansharm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Joe Lawrence <joe.lawrence@redhat.com>
Subject: [PATCH 0/5] perf tool: small coverity clean ups
Date:   Tue,  2 Oct 2018 10:29:09 -0400
Message-Id: <1538490554-8161-1-git-send-email-sansharm@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 02 Oct 2018 14:29:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set fixes a few coverity static code analyzer complaints. Build 
tested only.

Sanskriti Sharma (5):
  perf strbuf: match va_{add,copy} with va_end
  perf tools: cleanup trace-event-info 'tdata' leak
  perf tools: free 'printk' string in parse_ftrace_printk()
  perf tools: avoid double free in read_event_file()
  perf tools: free temporary 'sys' string in read_event_files()

 tools/perf/util/strbuf.c            | 10 ++++++++--
 tools/perf/util/trace-event-info.c  |  2 ++
 tools/perf/util/trace-event-parse.c |  1 +
 tools/perf/util/trace-event-read.c  |  9 +++++----
 4 files changed, 16 insertions(+), 6 deletions(-)

-- 
1.8.3.1

