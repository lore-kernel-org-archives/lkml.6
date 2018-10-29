Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFFEC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 02:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CC7C2075D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 02:50:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CC7C2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbeJ2Lgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 07:36:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55798 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729054AbeJ2Lgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 07:36:44 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 16ECD300287B;
        Mon, 29 Oct 2018 02:50:04 +0000 (UTC)
Received: from ming.t460p (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ADDD45FCA6;
        Mon, 29 Oct 2018 02:49:42 +0000 (UTC)
Date:   Mon, 29 Oct 2018 10:49:38 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/3] blk-mq: refactor the code of issue request
 directly
Message-ID: <20181029024937.GC32606@ming.t460p>
References: <1540569671-6589-1-git-send-email-jianchao.w.wang@oracle.com>
 <1540569671-6589-2-git-send-email-jianchao.w.wang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540569671-6589-2-git-send-email-jianchao.w.wang@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 29 Oct 2018 02:50:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 27, 2018 at 12:01:09AM +0800, Jianchao Wang wrote:
> Merge blk_mq_try_issue_directly and __blk_mq_try_issue_directly
> into one interface which is able to handle the return value from
> .queue_rq callback. Due to we can only issue directly w/o io
> scheduler, so remove the blk_mq_get_driver_tag.

It isn't correct for dm-rq, see blk_insert_cloned_request().

Thanks,
Ming
