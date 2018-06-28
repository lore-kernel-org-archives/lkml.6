Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55919C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 02:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC40425CF1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 02:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="kEXNGQUv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC40425CF1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932398AbeF1C3F (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 22:29:05 -0400
Received: from imap.thunk.org ([74.207.234.97]:34480 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752574AbeF1C3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 22:29:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=5PVa6D/+gBDK1mhhIqHowoPRoL5Fic1b/p8YgTGlS4Y=; b=kEXNGQUvZabVwVqD52Un8Ujs5w
        dYtYeJzi6m/wpdfVLxmRI2x8a7s70oVYQTAhAttGv7DzG1fnqxKIlS5LiQwgObF0KjmP23HLU3/a8
        EKHNs2hVXZJxw5k58s88RpRiZzm0IBVcOs2nOsPvDinBnu4u+pD4pOjUizLX58MWbS6o=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fYMg9-0005G2-N3; Thu, 28 Jun 2018 02:29:01 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 7D2AE7A44C4; Wed, 27 Jun 2018 22:29:00 -0400 (EDT)
Date:   Wed, 27 Jun 2018 22:29:00 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     "Gaoming (ming, consumer BG)" <gaoming20@huawei.com>
Cc:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Liqingchao (sorp)" <sorp.liqingchao@huawei.com>,
        "Shenchen (harry)" <harry.shen@huawei.com>,
        "miaoxie (A)" <miaoxie@huawei.com>,
        "yangfei (D)" <yangfei39@huawei.com>
Subject: Re: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIGV4dDQ6?=
 =?utf-8?Q?_e2fsprogs=3A_fix_inode_bitma?= =?utf-8?Q?p?= num not
 integer,incompatible for ancient android devices
Message-ID: <20180628022900.GA663@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Gaoming (ming, consumer BG)" <gaoming20@huawei.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Liqingchao (sorp)" <sorp.liqingchao@huawei.com>,
        "Shenchen (harry)" <harry.shen@huawei.com>,
        "miaoxie (A)" <miaoxie@huawei.com>,
        "yangfei (D)" <yangfei39@huawei.com>
References: <1530014046-62466-1-git-send-email-gaoming20@huawei.com>
 <20180627140937.GA3348@thunk.org>
 <FDC91B229D965C458E3615E98C48ADDD0EC41667@dggemm511-mbx.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FDC91B229D965C458E3615E98C48ADDD0EC41667@dggemm511-mbx.china.huawei.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 01:40:30AM +0000, Gaoming (ming, consumer BG) wrote:
> Hi tytso,
> 
> I have checked that make_ext4fs code was deleted o Jun 21th 2018 on master branch of /system/extras repository.
> e.g. 
> https://android-review.googlesource.com/c/platform/system/extras/+/708003

Make_ext4fs was fixed not create invalid file systems a *long* time
ago.  What I'm not sure about is why the patch hasn't gotten out to
more Android manufacters sooner.

It should have been fixed by sometime in 2012 --- I complained to the
Android team in early 2011.  What I don't understand is why people are
coming out of the woodwork *now*.

					- Ted
