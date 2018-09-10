Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D83C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D60E2088E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:32:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D60E2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbeIJPZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 11:25:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48528 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727743AbeIJPZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 11:25:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8757E40201BC;
        Mon, 10 Sep 2018 10:31:57 +0000 (UTC)
Received: from krava (unknown [10.43.17.10])
        by smtp.corp.redhat.com (Postfix) with SMTP id 591182016F00;
        Mon, 10 Sep 2018 10:31:55 +0000 (UTC)
Date:   Mon, 10 Sep 2018 12:31:54 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, tmricht@linux.ibm.com, sandipan@linux.ibm.com,
        brueckner@linux.ibm.com, kim.phillips@arm.com,
        kstewart@linuxfoundation.org, tglx@linutronix.de,
        naveen.n.rao@linux.vnet.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf test: Add watchpoint test
Message-ID: <20180910103154.GD15548@krava>
References: <20180910095811.22892-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910095811.22892-1-ravi.bangoria@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 10 Sep 2018 10:31:57 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 10 Sep 2018 10:31:57 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 03:28:11PM +0530, Ravi Bangoria wrote:
> We don't have perf test available to test watchpoint functionality.
> Add simple set of tests: 
>  - Read only watchpoint
>  - Write only watchpoint
>  - Read / Write watchpoint
>  - Runtime watchpoint modification
> 
> Ex on powerpc:
>   $ sudo ./perf test 22
>   22: Watchpoint                                            :
>   22.1: Read Only Watchpoint                                : Ok
>   22.2: Write Only Watchpoint                               : Ok
>   22.3: Read / Write Watchpoint                             : Ok
>   22.4: Modify Watchpoint                                   : Ok

cool, thanks!

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka
