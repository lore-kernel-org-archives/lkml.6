Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33066C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4AA620855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebldiHQI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4AA620855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbeKZTJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 14:09:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:48802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726158AbeKZTJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 14:09:57 -0500
Received: from devnote (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F9A02082F;
        Mon, 26 Nov 2018 08:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543220197;
        bh=DqBmaW+/VDsYcwCAqdONkIVBcaCcRnzO0DlNHARcBw4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ebldiHQIYeK3X6Id+VYY8V6ueoSX+dk75j/bypwnorRPKbyrVFCCtRpcbQEv4cqRx
         MoczbeoIgZb21Uj26CQplak8+ebJ41kcsS84IxxvPlYKfTCyIpIMpp7xbv7QGzxW6k
         VC+FblRBnTdCtAfDfaH8oVUTq+xT1N/nl46qfFvM=
Date:   Mon, 26 Nov 2018 17:16:34 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "zhangwei(Jovi)" <jovi.zhangwei@huawei.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: uprobe support mix of ftrace and perf
Message-Id: <20181126171634.a68dbf9d7ce40e8c982ffec6@kernel.org>
In-Reply-To: <20181122143209.GE28270@redhat.com>
References: <20181120220156.7d94d8c707570411870222fd@kernel.org>
        <20181122143209.GE28270@redhat.com>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleg,

On Thu, 22 Nov 2018 15:32:10 +0100
Oleg Nesterov <oleg@redhat.com> wrote:

> Hi Masami,
> 
> On 11/20, Masami Hiramatsu wrote:
> >
> > Hello Oleg,
> >
> > I have a question about the (revert) commit 48212542067a
> > ("tracing/uprobes: Revert "Support mix of ftrace and perf""). I found
> > this limitation still exists on uprobe events.
> 
> Yes...
> 
> > Would you have any plan or idea to fix this issue? I thought this revert
> > patch was a tentative one, and should be fixed afterwards.
> 
> To be honest, I was going to fix this "soon" many years ago, but today I simply
> can't recall how this code actually works and what exactly we need to do to
> support ftrace/perf at the same time...
> 
> I'll try to read this code later, but I can't promise anything :/

I understand, it may take a while... no need to promise :). I'll also look
into it.

Thank you,

> 
> Oleg.
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
