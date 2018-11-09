Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145EDC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 12:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE97D20892
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 12:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QnHBjOzP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE97D20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbeKIWGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 17:06:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:38820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727731AbeKIWGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 17:06:16 -0500
Received: from localhost (71-6-98-120.static-ip.telepacific.net [71.6.98.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAB0220825;
        Fri,  9 Nov 2018 12:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541766351;
        bh=DZ7TiM8HzwoyCgCwlElQy4GaO0g+Sey7KvQJoVUDc/A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QnHBjOzPlHuiaOrAVAxe4dpdB1ujeURVjbJQSgi+ec4FHmQ+shZ2YkWv/E9LtWq3A
         l46Z6SL3l9ItukbS/emUsCXWGoTia2M1lBiaUOTLG0kjSWnbxvv9E4tqrkHzwwERFB
         vxpZWIQPeyxFtypmG3ZI7vUjhxGt4TuVHUv3DPKg=
Date:   Fri, 9 Nov 2018 04:25:51 -0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     wang.yi59@zte.com.cn, matz@suse.de, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        suravee.suthikulpanit@amd.com, puwen@hygon.cn,
        davidwang@zhaoxin.com, linux-kernel@vger.kernel.org,
        zhong.weidong@zte.com.cn
Subject: Re: [PATCH v2] x86/cpu: fix prototype warning
Message-ID: <20181109122551.GA2647@kroah.com>
References: <20181108172225.GH7543@zn.tnic>
 <201811090843126464658@zte.com.cn>
 <20181109105538.GA21243@zn.tnic>
 <20181109111225.GA26335@kroah.com>
 <20181109114101.GB21243@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109114101.GB21243@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 12:41:01PM +0100, Borislav Petkov wrote:
> On Fri, Nov 09, 2018 at 03:12:25AM -0800, Greg KH wrote:
> > Sure, sounds like a good task.  Post it to the driverdevel mailing list
> > and see if people are interested.
> 
> By "driverdevel" do you mean this guy, per chance:
> 
> http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

Yes.

> Also, I guess I should send to kernel-janitors@vger.kernel.org too, no?

I don't know if that list is still alive, but it could not hurt :)
