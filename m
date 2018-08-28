Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB20C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF6FD20834
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:44:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF6FD20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbeH1Rfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 13:35:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57326 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726181AbeH1Rfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 13:35:46 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 997EB804B9F2;
        Tue, 28 Aug 2018 13:44:01 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-94.pek2.redhat.com [10.72.12.94])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B6AEE10075E1;
        Tue, 28 Aug 2018 13:43:51 +0000 (UTC)
Date:   Tue, 28 Aug 2018 21:43:47 +0800
From:   Dave Young <dyoung@redhat.com>
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Pingfan Liu <piliu@redhat.com>,
        Philipp Rudo <prudo@linux.ibm.com>,
        catalin marinas <catalin.marinas@arm.com>,
        will deacon <will.deacon@arm.com>, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, bhe@redhat.com, arnd@arndb.de,
        schwidefsky@de.ibm.com, heiko carstens <heiko.carstens@de.ibm.com>,
        ard biesheuvel <ard.biesheuvel@linaro.org>,
        james morse <james.morse@arm.com>, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "piliu@redhat.com Thiago Jung Bauermann" 
        <bauerman@linux.vnet.ibm.com>
Subject: Re: [PATCH v13 03/16] s390, kexec_file: drop arch_kexec_mem_walk()
Message-ID: <20180828134347.GB12178@dhcp-128-65.nay.redhat.com>
References: <20180801075820.3753-1-takahiro.akashi@linaro.org>
 <20180801075820.3753-4-takahiro.akashi@linaro.org>
 <20180801102951.527cfc57@ThinkPad>
 <20180802000150.GN11258@linaro.org>
 <20180806055047.GC4246@dhcp-128-65.nay.redhat.com>
 <20180809033416.GA5069@dhcp-128-65.nay.redhat.com>
 <1235507889.17337085.1533788045597.JavaMail.zimbra@redhat.com>
 <20180828052107.GE12252@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828052107.GE12252@linaro.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 28 Aug 2018 13:44:01 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 28 Aug 2018 13:44:01 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dyoung@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi AKASHI,
On 08/28/18 at 02:21pm, AKASHI Takahiro wrote:
> Hi Dave,
> 
> On Thu, Aug 09, 2018 at 12:14:05AM -0400, Pingfan Liu wrote:
> > 
> > 
> > 
> > 
> > ----- Original Message -----
> > > From: "Dave Young" <dyoung@redhat.com>
> > > To: "AKASHI Takahiro" <takahiro.akashi@linaro.org>, "Philipp Rudo" <prudo@linux.ibm.com>, "catalin marinas"
> > > <catalin.marinas@arm.com>, "will deacon" <will.deacon@arm.com>, dhowells@redhat.com, vgoyal@redhat.com,
> > > herbert@gondor.apana.org.au, davem@davemloft.net, bhe@redhat.com, arnd@arndb.de, schwidefsky@de.ibm.com, "heiko
> > > carstens" <heiko.carstens@de.ibm.com>, "ard biesheuvel" <ard.biesheuvel@linaro.org>, "james morse"
> > > <james.morse@arm.com>, bhsharma@redhat.com, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
> > > linux-kernel@vger.kernel.org, "piliu@redhat.com Thiago Jung Bauermann" <bauerman@linux.vnet.ibm.com>
> > > Sent: Thursday, August 9, 2018 11:34:16 AM
> > > Subject: Re: [PATCH v13 03/16] s390, kexec_file: drop arch_kexec_mem_walk()
> > > 
> > > Add more cc. Pingfan Liu confirmed ppc does not use 0 as valid address,
> > > if so it should be safe.
> > > 
> > > Pingfan, can you add more words?
> > > 
> > 
> > ppc64 uses a few KB starting from 0 for exception handler.
> 
> It assures that 0 (zero) is valid, but won't be assigned as a result of
> kexec_add_buffer().
> 
> So do you think that yet I should submit another patch set, introducing
> explicit KEXEC_BUF_MEM_UNKNOWN, while assuming 0 by default is safe for now?
> 
> Now that this is the only comment against my v13, it's up to you.

I'm fine with your proposal.  It is simple enough, and we can look into
it when it becomes a problem in the future which is unlikely.

Thanks
Dave
