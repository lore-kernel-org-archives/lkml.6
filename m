Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DF8C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 13:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4593D20671
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 13:51:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4593D20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbeKTAPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 19:15:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:50338 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727310AbeKTAPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 19:15:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C28A3AF04;
        Mon, 19 Nov 2018 13:51:50 +0000 (UTC)
Date:   Mon, 19 Nov 2018 14:51:49 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Borislav Petkov <bp@suse.de>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH] l1tf: drop the swap storage limit restriction when
 l1tf=off
Message-ID: <20181119135149.GN22247@dhcp22.suse.cz>
References: <20181113184910.26697-1-mhocko@kernel.org>
 <nycvar.YFH.7.76.1811132054521.19754@cbobk.fhfr.pm>
 <20181114073229.GC23419@dhcp22.suse.cz>
 <nycvar.YFH.7.76.1811191436140.21108@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1811191436140.21108@cbobk.fhfr.pm>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 19-11-18 14:36:32, Jiri Kosina wrote:
> On Wed, 14 Nov 2018, Michal Hocko wrote:
> 
> > > > +				It also drops the swap size and available
> > > > +				RAM limit restriction.
> > > 
> > > Minor nit: I think this should explicitly mention that those two things 
> > > are related to bare metal mitigation, to avoid any confusion (as otherwise 
> > > the l1tf cmdline parameter is purely about hypervisor mitigations).
> > 
> > Do you have any specific wording in mind?
> > 
> > It also drops the swap size and available RAM limit restrictions on both
> > hypervisor and bare metal.
> > 
> > Sounds better?
> > 
> > > With that
> > > 
> > > 	Acked-by: Jiri Kosina <jkosina@suse.cz>
> > 
> > Thanks!
> 
> Yes, I think that makes it absolutely clear. Thanks,

OK. Here is the incremental diff on top of the patch. I will fold and
repost later this week. I assume people are still catching up after LPC
and I do not want to spam them even more.

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a54f2bd39e77..c5aa4b4a797d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2096,7 +2096,8 @@
 				Disables hypervisor mitigations and doesn't
 				emit any warnings.
 				It also drops the swap size and available
-				RAM limit restriction.
+				RAM limit restriction on both hypervisor and
+				bare metal.
 
 			Default is 'flush'.
 
diff --git a/Documentation/admin-guide/l1tf.rst b/Documentation/admin-guide/l1tf.rst
index b00464a9c09c..2e65e6cb033e 100644
--- a/Documentation/admin-guide/l1tf.rst
+++ b/Documentation/admin-guide/l1tf.rst
@@ -405,7 +405,8 @@ The kernel command line allows to control the L1TF mitigations at boot
 
   off		Disables hypervisor mitigations and doesn't emit any
 		warnings.
-		It also drops the swap size and available RAM limit restrictions.
+		It also drops the swap size and available RAM limit restrictions
+                on both hypervisor and bare metal.
 
   ============  =============================================================
 
-- 
Michal Hocko
SUSE Labs
