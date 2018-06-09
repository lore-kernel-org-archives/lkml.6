Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id FjGFLvpSHFsLRwAAmS7hNA
	; Sat, 09 Jun 2018 22:21:46 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A4B24607E4; Sat,  9 Jun 2018 22:21:46 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V6gt+iH5"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id F09D66074D;
	Sat,  9 Jun 2018 22:21:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F09D66074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753502AbeFIWVn (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 18:21:43 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47032 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753408AbeFIWVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 18:21:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dNWsNu+y+2k76ZV+YNGHk7bOipWyYiS/Fj5iIaQ5QKs=; b=V6gt+iH5/vTduuAFCu64fDbJRw
        XRy/3joPEt2Mt5t3PgthRhWl18pR54vJpo00JRhkSzRyY6dNqW8mizN3xmz3ChWU/Fmrnwe3HZ5Rq
        74zM2vhk8Q66aYiNj3apXD0DC0lb20RfXwmSr6ABfDkTY8CREtL7lCa9DZZ3KyKbZyJRQJpJt4o9V
        0gQMx91lG8vEjzCT9E8BMshNUFy1UTMapS65vm6s4YYvsXoaY/A/EJZyIrGqfpzT+4AXSmKh0oLTV
        nzPhJ4WHD9Q+4aT+8L4mpUYj+mID7pBV2XOa8U7oCCEcJ4SA6gjFd+WKQZVua+gFTToTCOG+JQ9ac
        J7PeFHhw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fRmEu-0006s4-Dy; Sat, 09 Jun 2018 22:21:40 +0000
Subject: Re: sd 6:0:0:0: [sdb] Unaligned partial completion (resid=12,
 sector_sz=512)
To: Christoph Anton Mitterer <calestyo@scientia.net>,
        linux-kernel@vger.kernel.org,
        linux-scsi <linux-scsi@vger.kernel.org>
References: <c35dacb574365736229ff04d587abc0390ef7b78.camel@scientia.net>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f96c1329-929b-44a1-4c3a-74dbcedbbafe@infradead.org>
Date: Sat, 9 Jun 2018 15:21:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <c35dacb574365736229ff04d587abc0390ef7b78.camel@scientia.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[adding linux-scsi mailing list]


On 06/09/2018 12:23 PM, Christoph Anton Mitterer wrote:
> Hey.
> 
> I'm seeing these errors:
> Jun 09 21:13:22 heisenberg kernel: sd 6:0:0:0: [sdb] Unaligned partial completion (resid=16, sector_sz=512)
> Jun 09 21:13:22 heisenberg kernel: sd 6:0:0:0: [sdb] tag#0 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
> Jun 09 21:13:22 heisenberg kernel: sd 6:0:0:0: [sdb] tag#0 Sense Key : Medium Error [current] 
> Jun 09 21:13:22 heisenberg kernel: sd 6:0:0:0: [sdb] tag#0 Add. Sense: Unrecovered read error
> Jun 09 21:13:22 heisenberg kernel: sd 6:0:0:0: [sdb] tag#0 CDB: Read(16) 88 00 00 00 00 01 cd e6 de 40 00 00 00 e0 00 00
> Jun 09 21:13:22 heisenberg kernel: print_req_error: critical medium error, dev sdb, sector 7749426752
> Jun 09 21:13:31 heisenberg kernel: sd 6:0:0:0: [sdb] Unaligned partial completion (resid=12, sector_sz=512)
> Jun 09 21:13:31 heisenberg kernel: sd 6:0:0:0: [sdb] tag#0 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
> Jun 09 21:13:31 heisenberg kernel: sd 6:0:0:0: [sdb] tag#0 Sense Key : Medium Error [current] 
> Jun 09 21:13:31 heisenberg kernel: sd 6:0:0:0: [sdb] tag#0 Add. Sense: Unrecovered read error
> Jun 09 21:13:31 heisenberg kernel: sd 6:0:0:0: [sdb] tag#0 CDB: Read(16) 88 00 00 00 00 00 00 14 59 60 00 00 01 00 00 00
> Jun 09 21:13:31 heisenberg kernel: print_req_error: critical medium error, dev sdb, sector 1333600
> Jun 09 21:13:53 heisenberg kernel: sd 6:0:0:0: [sdb] Unaligned partial completion (resid=12, sector_sz=512)
> Jun 09 21:13:53 heisenberg kernel: sd 6:0:0:0: [sdb] tag#0 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
> Jun 09 21:13:53 heisenberg kernel: sd 6:0:0:0: [sdb] tag#0 Sense Key : Medium Error [current] 
> Jun 09 21:13:53 heisenberg kernel: sd 6:0:0:0: [sdb] tag#0 Add. Sense: Unrecovered read error
> Jun 09 21:13:53 heisenberg kernel: sd 6:0:0:0: [sdb] tag#0 CDB: Read(16) 88 00 00 00 00 00 c3 a2 56 80 00 00 01 00 00 00
> Jun 09 21:13:53 heisenberg kernel: print_req_error: critical medium error, dev sdb, sector 3282196096
> 
> (many of them) on a Seagate 8TB Archive HDD.
> The disk is only a year old and barely used (since it's just one of the
> backups of my main data disks - and the primary disk another Seagate
> 8TB HDD broke just few days ago).
> 
> I have connected them via USB/SATA bridge... and when I now started
> copying from the backup (which is sdb) to a fresh HDD I started seeing
> vast numbers of these errors.
> 
> However, fsck, cp seem to do fine, and the data (as far as it has been
> copied) seems good (I have sha512 sums of all of it).
> 
> 
> Any ideas what "Unaligned partial completion" and these errors mean?
> 
> 
> Thanks,
> Chris.
> 


-- 
~Randy
