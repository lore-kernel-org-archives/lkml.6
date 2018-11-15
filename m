Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDBFC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 05:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58FDF2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 05:05:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58FDF2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbeKOPLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 10:11:20 -0500
Received: from mga17.intel.com ([192.55.52.151]:34713 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbeKOPLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 10:11:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Nov 2018 21:05:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,235,1539673200"; 
   d="scan'208";a="85945985"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga007.fm.intel.com with ESMTP; 14 Nov 2018 21:05:02 -0800
Subject: [RFC PATCH 0/3] Maintainer Handbook: Subsystem Profile
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ross Zwisler <zwisler@kernel.org>,
        Joe Perches <joe@perches.com>,
        "Tobin C. Harding" <me@tobin.cc>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steve French <stfrench@microsoft.com>,
        Olof Johansson <olof@lixom.net>, corbet@lwn.net,
        linux-nvdimm@lists.01.org,
        ksummit-discuss@lists.linuxfoundation.org
Date:   Wed, 14 Nov 2018 20:53:13 -0800
Message-ID: <154225759358.2499188.15268218778137905050.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At a recently concluded session at the Linux Plumbers Conference I
proposed a "Subsystem Profile" as a document that a maintainer can
provide to set contributor expectations and provide fodder for a
discussion between maintainers about the merits of different maintainer
policies.

For those that did not attend, the goal of the Subsystem Profile, and the
Maintainer Handbook more generally, is to provide a desk reference for
maintainers both new and experienced. The session introduction was:

    The first rule of kernel maintenance is that there are no hard and
    fast rules. That state of affairs is both a blessing and a curse. It
    has served the community well to be adaptable to the different
    people and different problem spaces that inhabit the kernel
    community. However, that variability also leads to inconsistent
    experiences for contributors, little to no guidance for new
    contributors, and unnecessary stress on current maintainers. There
    are quite a few of people who have been around long enough to make
    enough mistakes that they have gained some hard earned proficiency.
    However if the kernel community expects to keep growing it needs to
    be able both scale the maintainers it has and ramp new ones without
    necessarily let them make a decades worth of mistakes to learn the
    ropes. 

To be clear, the proposed document does not impose or suggest new
rules. Instead it provides an outlet to document the unwritten rules
and policies in effect for each subsystem, and that each subsystem
might decide differently for whatever reason.

---

Dan Williams (3):
      MAINTAINERS: Reclaim the P: tag for Subsystem Profile
      MAINTAINERS, Handbook: Subsystem Profile
      libnvdimm, MAINTAINERS: Subsystem Profile


 Documentation/maintainer/index.rst             |    1 
 Documentation/maintainer/subsystem-profile.rst |  145 ++++++++++++++++++++++++
 Documentation/nvdimm/subsystem-profile.rst     |   86 ++++++++++++++
 MAINTAINERS                                    |   26 +++-
 4 files changed, 249 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/maintainer/subsystem-profile.rst
 create mode 100644 Documentation/nvdimm/subsystem-profile.rst
