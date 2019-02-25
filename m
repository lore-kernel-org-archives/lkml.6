Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6740DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FEBB20842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbfBYQKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 11:10:20 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41443 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727661AbfBYQKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 11:10:19 -0500
Received: by mail-pl1-f196.google.com with SMTP id y5so4703488plk.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 08:10:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CmwbzRCJCntcQtYZWtvmmZ01G39/UDZL2rkwvw0Kc50=;
        b=feucwJRAmBTV2fSCGOrAAP9/0El+EX1nuuMFQypNuL6XtYUnx/zVf+lw9jCPLfGgTB
         0GnukR29gC8xtPi5bZ/dFVHQ6BEhZTCAgFj1WESTJ9NX1iLteirkhweKrCyAG0gFoijA
         wsSOW1/pZdLqpB6fFUa8n7tp8q2mYHFO5nMvSuXK6BClNkUDEWjzJw8WTEhIRsBBJXtQ
         yZRL8yTHhQzrtHDi/281VsChcZQ3VHN7LBu45LTwP9B8/DOFqoSkzdyE5pr64YJzidFk
         u2TnBLYrXkyKMjuuWNcw5E0ZxTabx1BtOnh6L1XoNKnK4E3QP0h+dFzvuf5k7jATQYNM
         O+7A==
X-Gm-Message-State: AHQUAubA/ZL+rzbRWIs9JResToP728Chxzc8jov6L2x++0iGj6w5ltFz
        JHd76eJL6UhaxJJ55QMVdI0=
X-Google-Smtp-Source: AHgI3IZJSZZ+OQ8l7ZVGkIyGbtet5CfcFauQGSOgdxg0szCA0e1zGoRBIxE2o2rusbirq78s75FbSw==
X-Received: by 2002:a17:902:3283:: with SMTP id z3mr21403879plb.76.1551111018571;
        Mon, 25 Feb 2019 08:10:18 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id k74sm25024583pfb.172.2019.02.25.08.10.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 08:10:17 -0800 (PST)
Message-ID: <1551111016.31902.149.camel@acm.org>
Subject: Re: [PATCH] nvmet: disable direct I/O when unavailable
From:   Bart Van Assche <bvanassche@acm.org>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Max Gurtovoy <maxg@mellanox.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>
Date:   Mon, 25 Feb 2019 08:10:16 -0800
In-Reply-To: <20190225153827.GA17442@linux-x5ow.site>
References: <20190221182234.22345-1-jthumshirn@suse.de>
         <SN6PR04MB4527A810D247541AA7C4A512867F0@SN6PR04MB4527.namprd04.prod.outlook.com>
         <6c3fa30a-d516-a453-a001-1014202ff9ce@suse.de>
         <9d8e96de-d68d-8961-21e8-4cb8e79b4a08@mellanox.com>
         <2185e4e5-086a-d0c2-0fee-a7a5c98267bb@suse.de>
         <a85e85d6-6a06-7663-3a12-710b6467dedd@acm.org>
         <20190225153827.GA17442@linux-x5ow.site>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-02-25 at 16:38 +-0100, Johannes Thumshirn wrote:
+AD4 On Mon, Feb 25, 2019 at 06:49:04AM -0800, Bart Van Assche wrote:
+AD4 +AD4 On 2/25/19 1:37 AM, Johannes Thumshirn wrote:
+AD4 +AD4 +AD4 On 24/02/2019 11:54, Max Gurtovoy wrote:
+AD4 +AD4 +AD4 +AD4 What is the status of iSCSI/SRP targets in this case ?
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 iSCSI/SRP passes in the following:
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4   /+ACo
+AD4 +AD4 +AD4    +ACo Use O+AF8-DSYNC by default instead of O+AF8-SYNC to forgo syncing
+AD4 +AD4 +AD4    +ACo of pure timestamp updates.
+AD4 +AD4 +AD4    +ACo-/
+AD4 +AD4 +AD4   flags +AD0 O+AF8-RDWR +AHw O+AF8-CREAT +AHw O+AF8-LARGEFILE +AHw O+AF8-DSYNC+ADs
+AD4 +AD4 
+AD4 +AD4 That code fragment comes from the LIO file backend. There is no requirement
+AD4 +AD4 for a SCSI target core file backend to use O+AF8-DSYNC. SCST allows users to
+AD4 +AD4 choose whether or not O+AF8-DSYNC should be used:
+AD4 
+AD4 Yes, LIO file backend is the in-tree equivalent to NVMe's file backend. That's
+AD4 why I copied it here.
+AD4 
+AD4 
+AD4 +AD4 
+AD4 +AD4 	if (virt+AF8-dev-+AD4-wt+AF8-flag +ACYAJg +ACE-virt+AF8-dev-+AD4-nv+AF8-cache)
+AD4 +AD4 		open+AF8-flags +AHwAPQ O+AF8-DSYNC+ADs
+AD4 +AD4 
+AD4 
+AD4 OK. Do your open+AF8-flags include O+AF8-DIRECT per default as well?

I don't think it has ever been supported to pass O+AF8-DIRECT to filp+AF8-open().
As one can see in build+AF8-open+AF8-flags() O+AF8-DIRECT is ignored. The only way I
know of to submit direct I/O from kernel context is by setting the
IOCB+AF8-DIRECT flag.

Bart.
