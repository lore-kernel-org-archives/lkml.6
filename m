Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D06C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 22:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AA912075D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 22:18:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AA912075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbeJXGnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 02:43:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49816 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726493AbeJXGnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 02:43:46 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3CF4E81DEC;
        Tue, 23 Oct 2018 22:18:26 +0000 (UTC)
Received: from agk-dp.fab.redhat.com (agk-dp.fab.redhat.com [10.33.15.10])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B79495D763;
        Tue, 23 Oct 2018 22:18:20 +0000 (UTC)
Received: from agk by agk-dp.fab.redhat.com with local (Exim 4.69)
        (envelope-from <agk@redhat.com>)
        id 1gF50F-0005OD-AJ; Tue, 23 Oct 2018 23:18:19 +0100
Date:   Tue, 23 Oct 2018 23:18:19 +0100
From:   Alasdair G Kergon <agk@redhat.com>
To:     Paul Lawrence <paullawrence@google.com>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Jonathan Corbet <corbet@lwn.net>, Shaohua Li <shli@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org
Subject: Re: [RFC] dm-bow working prototype
Message-ID: <20181023221819.GB17552@agk-dp.fab.redhat.com>
Mail-Followup-To: Paul Lawrence <paullawrence@google.com>,
        Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com, Jonathan Corbet <corbet@lwn.net>,
        Shaohua Li <shli@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
References: <20181023212358.60292-1-paullawrence@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181023212358.60292-1-paullawrence@google.com>
Organization: Red Hat UK Ltd. Registered in England and Wales, number
        03798903. Registered Office: Peninsular House, 30-36 Monument
        Street, 4th Floor, London, England, EC3R 8NB.
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 23 Oct 2018 22:18:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 02:23:28PM -0700, Paul Lawrence wrote:
> It is planned to use this driver to enable restoration of a failed
> update attempt on Android devices using ext4.

Could you say a bit more about the reason for this new dm target so we
can understand better what parameters you are trying to optimise and
within what new constraints?  What are the failure modes that you need
to handle better by using this?  (We can guess some answers, but it
would better if you can lay them out so we don't need to make
assumptions.)

Alasdair

