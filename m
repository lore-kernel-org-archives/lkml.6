Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B164FC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C74924C0F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="cXUJdh1B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C74924C0F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754800AbeGCKgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 06:36:02 -0400
Received: from imap.thunk.org ([74.207.234.97]:54198 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754665AbeGCKgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 06:36:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=x5J6GM/MrR0LcRomwv1FUWB37JvBSyDVaMVQttCEZM0=; b=cXUJdh1BFVgvaaPoM5QHLla6k5
        iWAhuTeECrAnKzozVGYQTgkuR2oJ6VnyVOGMvhsL8OFaaYwkff2/YcuuJd3PqRf/jnssFNxV87VmD
        JgDRp2c3cdFxYn3Z/RJsA7Ddk/HSYBBX72a3KW+EAui91ggtC4fG+kd5Zv16qGHvrcvU=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1faIf8-0000w2-7U; Tue, 03 Jul 2018 10:35:58 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 38C107A01EA; Tue,  3 Jul 2018 06:35:57 -0400 (EDT)
Date:   Tue, 3 Jul 2018 06:35:57 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     "Gaoming (ming, consumer BG)" <gaoming20@huawei.com>
Cc:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Liqingchao (sorp)" <sorp.liqingchao@huawei.com>,
        "Shenchen (harry)" <harry.shen@huawei.com>,
        "miaoxie (A)" <miaoxie@huawei.com>,
        "yangfei (D)" <yangfei39@huawei.com>,
        "Renlipeng (OS driver)" <renlipeng@huawei.com>
Subject: Re: =?utf-8?B?562U5aSNOiDnrZTlpI06IOetlA==?=
 =?utf-8?B?5aSNOiDnrZTlpI06IOetlOWkjTog562U5aSNOiBbUEFUQ0hdIGV4dDQ6IGUy?=
 =?utf-8?Q?fsprogs=3A_fix_inode_bitma?= =?utf-8?Q?p?= num not
 integer,incompatible for ancient android devices
Message-ID: <20180703103557.GA27426@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Gaoming (ming, consumer BG)" <gaoming20@huawei.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Liqingchao (sorp)" <sorp.liqingchao@huawei.com>,
        "Shenchen (harry)" <harry.shen@huawei.com>,
        "miaoxie (A)" <miaoxie@huawei.com>,
        "yangfei (D)" <yangfei39@huawei.com>,
        "Renlipeng (OS driver)" <renlipeng@huawei.com>
References: <20180628022900.GA663@thunk.org>
 <FDC91B229D965C458E3615E98C48ADDD0EC416E8@dggemm511-mbx.china.huawei.com>
 <20180628153022.GA8521@thunk.org>
 <FDC91B229D965C458E3615E98C48ADDD0EC4179B@dggemm511-mbx.china.huawei.com>
 <20180629142612.GE1231@thunk.org>
 <FDC91B229D965C458E3615E98C48ADDD0EC41869@dggemm511-mbx.china.huawei.com>
 <20180630130429.GA26529@thunk.org>
 <FDC91B229D965C458E3615E98C48ADDD0EC41D5F@dggemm511-mbx.china.huawei.com>
 <20180702121654.GA15131@thunk.org>
 <FDC91B229D965C458E3615E98C48ADDD0EC41DC4@dggemm511-mbx.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FDC91B229D965C458E3615E98C48ADDD0EC41DC4@dggemm511-mbx.china.huawei.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 12:58:48AM +0000, Gaoming (ming, consumer BG) wrote:
> And can you help me understand *why* such a choice was made?
> -----if there is such a problem in your devices, how will you do? Is there any other choice?
> ----- of course, you cannot format the partition.

You misunderstand my question.  Why was the choice of a blocksize of
1024 made?

I'm trying to understand how many devices, and why any other
manufacture would make, what seems to me, to be a completely insane
choice.

How long has Huawei been using a 1024 byte blocksize?  And why?  And
for how many devices?  Essentially, I'm trying to figure out if this
was a Huawei-specific mistake.

					- Ted
