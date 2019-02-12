Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1E0C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 06:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26C98217FA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 06:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbfBLGll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 01:41:41 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60962 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727247AbfBLGll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 01:41:41 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1C6XoNX052446
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 01:41:40 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qkr1mt8dd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 01:41:39 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <kamalesh@linux.vnet.ibm.com>;
        Tue, 12 Feb 2019 06:41:37 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 12 Feb 2019 06:41:35 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1C6fYlS56819860
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Feb 2019 06:41:34 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C39B52052;
        Tue, 12 Feb 2019 06:41:34 +0000 (GMT)
Received: from JAVRIS.in.ibm.com (unknown [9.122.211.111])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 357E752054;
        Tue, 12 Feb 2019 06:41:33 +0000 (GMT)
Date:   Tue, 12 Feb 2019 12:11:28 +0530
From:   Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>, Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] livepatch: Enforce reliable stack trace as config
 dependency
References: <20190209091728.23046-1-kamalesh@linux.vnet.ibm.com>
 <20190211140813.z7kap634gz3gp6a4@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211140813.z7kap634gz3gp6a4@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 19021206-4275-0000-0000-0000030E6941
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021206-4276-0000-0000-0000381C7CFE
Message-Id: <20190212064128.GA20554@JAVRIS.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-12_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902120049
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 08:08:13AM -0600, Josh Poimboeuf wrote:
> On Sat, Feb 09, 2019 at 02:47:28PM +0530, Kamalesh Babulal wrote:
> > After removal of the immediate flag by commit d0807da78e11
> > ("livepatch: Remove immediate feature"), reliable stack trace became
> > enforcing dependency for livepatch support on any architecture. In
> > the current code, we ensure that the dependency is met when
> > enabling the patch during the module load.
> > 
> > This dependency check can be improved by moving it to the Kconfig,
> > which disables the support for livepatching in the kernel for unmet
> > dependencies. This patch moves both HAVE_RELIABLE_STACKTRACE and
> > STACKTRACE under config LIVEPATCH, it also removes the
> > klp_have_reliable_stack() function.
> > 
> > Loading a livepatching module on an architecture where reliable
> > stack trace is yet to be implemented, the user should see:
> > 
> > insmod: ERROR: could not insert module ./livepatch-sample.ko: Invalid module format
> > 
> > ...
> > [  286.453463] livepatch_sample: module is marked as livepatch module, but livepatch support is disabled
> 
> Wouldn't the module fail to build in the first place, since
> CONFIG_LIVEPATCH is disabled?

Yes, with this patch applied, the livepatch modules will fail to build.
The intention was to paste the output of a module load, marked as the
livepatch but without the reliable stack trace support. I used the
previously compiled livepatch sample module for the illustration but
yeah we would not have a functioning module build in the first place.

> 
> Anyway, I'm not sure about this approach.  This patch makes the s390
> livepatch code no longer compilable, turning it into completely dead
> code.  So if something changes in the s390 code which causes it to stop
> compiling, nobody will notice.

Fair point, we can drop this patch in favor of getting compile time
testing for s390.

> 
> I think I'd rather go in the opposite direction: allow the patches to be
> loaded.  Then they can be forced, if needed.  That enables both compile
> and runtime testing.  That way we don't make any backward progress,
> until such arches get reliable stacktraces.

klp_have_reliable_stack() enforces implementation of reliable
stack trace and run time testing will not be complete with we returning
after the check.  We can re-think about enforcing the dependency after
we have the reliable stack trace for s390.

-- 
Kamalesh

