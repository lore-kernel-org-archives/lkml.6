Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8052C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8994820676
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQttvulW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8994820676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbeI1VQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 17:16:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:59290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726934AbeI1VQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 17:16:45 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 889EF2064D;
        Fri, 28 Sep 2018 14:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538146357;
        bh=tbeLucJf7uqZcaFvHRtMt9IkxE2ncxyWPV9p2UJrrtc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PQttvulW+Tm92l/lvVW0IAnvCIj5RtcG2GkhSjDc33ffj3yKZBaXyojowV4pmCcPl
         cyctnGOHrme9WV5TOUdwcGatnWqhyiw+GqBK5Cw5ncPv0fjTC1FMuj4BS9wlIowdOK
         au2ygII6TTJO+WK+eco8eTNKyTqfI3a3Rv/PIc1s=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 2CAAC14024D; Fri, 28 Sep 2018 11:52:34 -0300 (-03)
Date:   Fri, 28 Sep 2018 11:52:34 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCH v3] perf test: S390 does not support watchpoints in test
 22
Message-ID: <20180928145234.GK25764@kernel.org>
References: <20180928105335.67179-1-tmricht@linux.ibm.com>
 <f1ee3dc0-6b96-c7e5-f449-caabd3bf7f8a@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1ee3dc0-6b96-c7e5-f449-caabd3bf7f8a@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Sep 28, 2018 at 04:43:06PM +0530, Ravi Bangoria escreveu:
> On 09/28/2018 04:23 PM, Thomas Richter wrote:
> > S390 does not support the perf_event_open system call for
> > attribute type PERF_TYPE_BREAKPOINT. This results in test
> > failure for test 22:

> > [root@s8360046 perf]# ./perf test 22
> > 22: Watchpoint                                :
> > 22.1: Read Only Watchpoint                    : FAILED!
> > 22.2: Write Only Watchpoint                   : FAILED!
> > 22.3: Read / Write Watchpoint                 : FAILED!
> > 22.4: Modify Watchpoint                       : FAILED!
> > [root@s8360046 perf]#

> > Add s390 support to avoid these tests being executed on
> > s390 platform:

> > [root@s8360046 perf]# ./perf test 22
> > [root@s8360046 perf]# ./perf test -v 22
> > 22: Watchpoint                                : Disabled
> > [root@s8360046 perf]#

> > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
 
> Acked-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

Thanks, applying.

Just one nit, in cases like this I think a Reviewed-by tag fits better
than a Acked-by, as per Documentation/process/submitting-patches.rst:

--------------

Reviewed-by:, instead, indicates that the patch has been reviewed and found
acceptable according to the Reviewer's Statement:

Reviewer's statement of oversight
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

By offering my Reviewed-by: tag, I state that:

         (a) I have carried out a technical review of this patch to
             evaluate its appropriateness and readiness for inclusion into
             the mainline kernel.

         (b) Any problems, concerns, or questions relating to the patch
             have been communicated back to the submitter.  I am satisfied
             with the submitter's response to my comments.

         (c) While there may be things that could be improved with this
             submission, I believe that it is, at this time, (1) a
             worthwhile modification to the kernel, and (2) free of known
             issues which would argue against its inclusion.

         (d) While I have reviewed the patch and believe it to be sound, I
             do not (unless explicitly stated elsewhere) make any
             warranties or guarantees that it will achieve its stated
             purpose or function properly in any given situation.

A Reviewed-by tag is a statement of opinion that the patch is an
appropriate modification of the kernel without any remaining serious
technical issues.  Any interested reviewer (who has done the work) can
offer a Reviewed-by tag for a patch.  This tag serves to give credit to
reviewers and to inform maintainers of the degree of review which has been
done on the patch.  Reviewed-by: tags, when supplied by reviewers known to
understand the subject area and to perform thorough reviews, will normally
increase the likelihood of your patch getting into the kernel.

----------

While an Acked-by conveys just some quick look was performed, and in
this case you did what Reviewed-by signifies, I think.

I'm tentatively converting this Acked-by to a Reviewed-by, please let me
know if you disagree,

Thanks a lot!

- Arnaldo
