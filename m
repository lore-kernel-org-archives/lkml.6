Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C49D7C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 19:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BC0C20875
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 19:53:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BC0C20875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbeJFCyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 22:54:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36800 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728061AbeJFCyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 22:54:07 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1FDC26822;
        Fri,  5 Oct 2018 19:53:41 +0000 (UTC)
Date:   Fri, 5 Oct 2018 12:53:39 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        jreck@google.com, john.stultz@linaro.org, tkjos@google.com,
        gregkh@linuxfoundation.org, Al Viro <viro@zeniv.linux.org.uk>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH RFC] mm: Add an fs-write seal to memfd
Message-Id: <20181005125339.f6febfd3fcfdc69c6f408c50@linux-foundation.org>
In-Reply-To: <20181005192727.167933-1-joel@joelfernandes.org>
References: <20181005192727.167933-1-joel@joelfernandes.org>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  5 Oct 2018 12:27:27 -0700 "Joel Fernandes (Google)" <joel@joelfernandes.org> wrote:

> To support the usecase, this patch adds a new F_SEAL_FS_WRITE seal which
> prevents any future mmap and write syscalls from succeeding while
> keeping the existing mmap active. The following program shows the seal
> working in action:

Please be prepared to create a manpage patch for this one.
