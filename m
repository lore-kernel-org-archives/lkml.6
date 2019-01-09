Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3805AC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0C2A217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbfAIQwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 11:52:00 -0500
Received: from smtp.nue.novell.com ([195.135.221.5]:50298 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbfAIQwA (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Wed, 9 Jan 2019 11:52:00 -0500
Received: from linux-l9pv.suse (124-11-22-254.static.tfn.net.tw [124.11.22.254])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Wed, 09 Jan 2019 17:51:50 +0100
Date:   Thu, 10 Jan 2019 00:51:39 +0800
From:   joeyli <jlee@suse.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        keyrings@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Oliver Neukum <oneukum@suse.com>,
        Ryan Chen <yu.chen.surf@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH 0/5 v2][RFC] Encryption and authentication for hibernate
 snapshot image
Message-ID: <20190109165139.GH9503@linux-l9pv.suse>
References: <20190103143227.9138-1-jlee@suse.com>
 <20190106181026.GA15256@amd>
 <20190107173743.GC4210@linux-l9pv.suse>
 <CALCETrWHjn_WN1WRc2pbFPB+H-ZL_1y=8dhhHoVqA53Q7Pj5vA@mail.gmail.com>
 <20190109163958.GG9503@linux-l9pv.suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190109163958.GG9503@linux-l9pv.suse>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 12:39:58AM +0800, joeyli wrote:
> Hi Andy,
>
[...snip] 
> 
> Let's why I encrypt/decrypt data pages one by one, then I copy the
^^^^^^^ That's why

> encrypt/decrypt data from buffer page (only one buffer page reserved
> for encrypt/decrypt) to original page. I encreypt pages one by one, but
> I HMAC and verify the whole snapshot image by update mode.
> 
[...snip]
>  
> > Why are you manually supporting three different key types?  Can’t you
> > just somehow support all key types?  And shouldn’t you be verifying
> 
> I only supported two key typs in my patch set, user defined key and
> TPM trusted key. The EFI secure boot did not accept by EFI subsystem.
                   ^^^^^^^^^^^^^^^^^^^ EFI secure key
   https://lkml.org/lkml/2018/8/5/10

Sorry for I produced too many typo when feeling sleepy...

Thanks a lot!
Joey Lee
