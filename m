Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC69AC67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 13:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83B212152D
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 13:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKbtbw1O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83B212152D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbeJTWC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 18:02:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:59610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727364AbeJTWC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 18:02:27 -0400
Received: from localhost (10.193.71.37.rev.sfr.net [37.71.193.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 440CE204FD;
        Sat, 20 Oct 2018 13:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540043513;
        bh=cB6RChXrrUVpMXseZFC47GeJNWHKAwASqdbtibCvBxQ=;
        h=Date:From:To:Cc:Subject:From;
        b=aKbtbw1OygNAsdqw4ps0nU6qY8QrWTN10OIirMrHPsWuk0rBSJR0AfiSJ4JIouJCr
         ZY1UnO5fH+Nmkets6Qw9EWQ67sc/5l6obIrFaxlHvn1QTVJkU3PV2HASpqgHTXgHZY
         AfzFs6707PqYlJteF5anoyajvg+WfU2ZjuHjFcBE=
Date:   Sat, 20 Oct 2018 15:49:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel <linux-kernel@vger.kernel.org>
Cc:     ksummit-discuss@lists.linuxfoundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Olof Johansson <olof@lixom.net>, Chris Mason <clm@fb.com>,
        Mishi Choudhary <mishi@linux.com>
Subject: [PATCH 0/7] Code of Conduct: Fix some wording, and add an
 interpretation document
Message-ID: <20181020134908.GA32218@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

As everyone knows by now, we added a new Code of Conduct to the kernel
tree a few weeks ago.

When we did this, it raised a number of questions as to how this would
affect the kernel community.  To help address these issues, I, and a few
other kernel developers including the TAB, have come up with the
following patch series to be added to the tree to both modify the
existing Code of Conduct to remove a confusing paragraph as well as to
add a new document to help explain how the Code of Conduct is to be
interpreted by our community.

I originally sent the first two patches in this series to a lot of
kernel developers privately, to get their review and comments and see if
they wanted to ack them.  This is the traditional way we have always
done for policy documents or other "contentious" issues like the GPLv3
statement or the "closed kernel modules are bad" statement.  Due to the
very unexpected way that the original Code of Conduct file was added to
the tree, a number of developers asked if this series could also be
posted publicly before they were merged, and so, here they are.

This patch series adds this new document to the kernel tree, as well as
removes a paragraph from the existing Code of Conduct that was
bothersome to many maintainers.  It also does a bit of housekeeping
around these documents to get the documentation links correct as well as
fix up the email address and other links and add a MAINTAINER entry for
the files.

Also I would like to publicly thank Mishi Choudhary for being willing to
serve as a mediator for Code of Conduct issues.  She has a long history
of working in many open source communities, many much more contentious
than ours.  For more information about her, please see her wikipedia
entry:
	https://en.wikipedia.org/wiki/Mishi_Choudhary
or take the chance to talk with her at the Plumbers conference in a few
weeks, as she will be attending that along with almost everyone on the
TAB as well as many kernel developers and maintainers, myself included.

thanks,

greg k-h



Chris Mason (1):
  Code of conduct: Fix wording around maintainers enforcing the code of
    conduct

Greg Kroah-Hartman (6):
  Code of Conduct Interpretation: Add document explaining how the Code
    of Conduct is to be interpreted
  Code of Conduct Interpretation: Properly reference the TAB correctly
  Code of Conduct: Provide links between the two documents
  Code of Conduct Interpretation: Put in the proper URL for the
    committee
  Code of Conduct: Change the contact email address
  MAINTAINERS: Add an entry for the code of conduct

 .../code-of-conduct-interpretation.rst        | 156 ++++++++++++++++++
 Documentation/process/code-of-conduct.rst     |  25 +--
 Documentation/process/index.rst               |   1 +
 MAINTAINERS                                   |   6 +
 4 files changed, 178 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/process/code-of-conduct-interpretation.rst

-- 
2.19.1

