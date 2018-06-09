Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id tM5mKaoqHFviZQAAmS7hNA
	; Sat, 09 Jun 2018 19:30:39 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 70A80608C1; Sat,  9 Jun 2018 19:30:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6EDE860290;
	Sat,  9 Jun 2018 19:30:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6EDE860290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=scientia.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753959AbeFITad (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 15:30:33 -0400
Received: from mailgw-02.dd24.net ([193.46.215.43]:57515 "EHLO
        mailgw-02.dd24.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753261AbeFITac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 15:30:32 -0400
X-Greylist: delayed 392 seconds by postgrey-1.27 at vger.kernel.org; Sat, 09 Jun 2018 15:30:32 EDT
Received: from mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-01.live.igb.homer.key-systems.net [192.168.1.26])
        by mailgw-02.dd24.net (Postfix) with ESMTP id 6841360113
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jun 2018 19:23:58 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at
        mailpolicy-01.live.igb.homer.key-systems.net
Received: from mailgw-02.dd24.net ([192.168.1.36])
        by mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-01.live.igb.homer.key-systems.net [192.168.1.25]) (amavisd-new, port 10236)
        with ESMTP id YhEHj3GdVg5C for <linux-kernel@vger.kernel.org>;
        Sat,  9 Jun 2018 19:23:56 +0000 (UTC)
Received: from [192.168.0.102] (p54B6DCC8.dip0.t-ipconnect.de [84.182.220.200])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgw-02.dd24.net (Postfix) with ESMTPSA
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jun 2018 19:23:56 +0000 (UTC)
Message-ID: <c35dacb574365736229ff04d587abc0390ef7b78.camel@scientia.net>
Subject: sd 6:0:0:0: [sdb] Unaligned partial completion (resid=12,
 sector_sz=512)
From: Christoph Anton Mitterer <calestyo@scientia.net>
To: linux-kernel@vger.kernel.org
Date: Sat, 09 Jun 2018 21:23:56 +0200
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey.

I'm seeing these errors:
Jun 09 21:13:22 heisenberg kernel: sd 6:0:0:0: [sdb] Unaligned partial completion (resid=16, sector_sz=512)
Jun 09 21:13:22 heisenberg kernel: sd 6:0:0:0: [sdb] tag#0 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
Jun 09 21:13:22 heisenberg kernel: sd 6:0:0:0: [sdb] tag#0 Sense Key : Medium Error [current] 
Jun 09 21:13:22 heisenberg kernel: sd 6:0:0:0: [sdb] tag#0 Add. Sense: Unrecovered read error
Jun 09 21:13:22 heisenberg kernel: sd 6:0:0:0: [sdb] tag#0 CDB: Read(16) 88 00 00 00 00 01 cd e6 de 40 00 00 00 e0 00 00
Jun 09 21:13:22 heisenberg kernel: print_req_error: critical medium error, dev sdb, sector 7749426752
Jun 09 21:13:31 heisenberg kernel: sd 6:0:0:0: [sdb] Unaligned partial completion (resid=12, sector_sz=512)
Jun 09 21:13:31 heisenberg kernel: sd 6:0:0:0: [sdb] tag#0 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
Jun 09 21:13:31 heisenberg kernel: sd 6:0:0:0: [sdb] tag#0 Sense Key : Medium Error [current] 
Jun 09 21:13:31 heisenberg kernel: sd 6:0:0:0: [sdb] tag#0 Add. Sense: Unrecovered read error
Jun 09 21:13:31 heisenberg kernel: sd 6:0:0:0: [sdb] tag#0 CDB: Read(16) 88 00 00 00 00 00 00 14 59 60 00 00 01 00 00 00
Jun 09 21:13:31 heisenberg kernel: print_req_error: critical medium error, dev sdb, sector 1333600
Jun 09 21:13:53 heisenberg kernel: sd 6:0:0:0: [sdb] Unaligned partial completion (resid=12, sector_sz=512)
Jun 09 21:13:53 heisenberg kernel: sd 6:0:0:0: [sdb] tag#0 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
Jun 09 21:13:53 heisenberg kernel: sd 6:0:0:0: [sdb] tag#0 Sense Key : Medium Error [current] 
Jun 09 21:13:53 heisenberg kernel: sd 6:0:0:0: [sdb] tag#0 Add. Sense: Unrecovered read error
Jun 09 21:13:53 heisenberg kernel: sd 6:0:0:0: [sdb] tag#0 CDB: Read(16) 88 00 00 00 00 00 c3 a2 56 80 00 00 01 00 00 00
Jun 09 21:13:53 heisenberg kernel: print_req_error: critical medium error, dev sdb, sector 3282196096

(many of them) on a Seagate 8TB Archive HDD.
The disk is only a year old and barely used (since it's just one of the
backups of my main data disks - and the primary disk another Seagate
8TB HDD broke just few days ago).

I have connected them via USB/SATA bridge... and when I now started
copying from the backup (which is sdb) to a fresh HDD I started seeing
vast numbers of these errors.

However, fsck, cp seem to do fine, and the data (as far as it has been
copied) seems good (I have sha512 sums of all of it).


Any ideas what "Unaligned partial completion" and these errors mean?


Thanks,
Chris.
