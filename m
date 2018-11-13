Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C21DAC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8862622507
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="zM9YEymg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8862622507
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbeKMPl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 10:41:29 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:47612 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbeKMPl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 10:41:29 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAD5cv6H170883;
        Tue, 13 Nov 2018 05:44:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=toTx9R2A11Tn+FBrYfNJPSpAx5YRXe6BN+Y5PcHLMAY=;
 b=zM9YEymgptAHRKGKcJS8maqJ0N/lfeLRlD2+aKThnjTTezwVKxGLvcKkYBMujIv+dUTg
 swoyPQ4Oj2g5FWpt5T998kKWh9yxe/Gi0pI82l57R6q9vGi/P4cPa/iLwPIfxsypjnIR
 0priXSfRTzRPYFI6vthAye4x1YS1/lz0VyTEadGZ8tiuG3Uu6iFUEr+PSQkhH1fkyA/Z
 TUtr4oNqScqcNgetmzRkd/hcQ2P0aMnkynwlg8MWG1UHjHfpV546DhSYUngvWkRS5iva
 gObz8qYnu+ni+I8NrrRsjr/zT4mCNmLdtMoc9LkE5C6hvPMlMuAGzla4ig+YjOfZOl04 Lg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2nnw6egb5h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Nov 2018 05:44:51 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wAD5ipaA006199
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Nov 2018 05:44:51 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wAD5ing2006689;
        Tue, 13 Nov 2018 05:44:49 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 12 Nov 2018 21:44:49 -0800
Date:   Mon, 12 Nov 2018 21:44:48 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Joe Perches <joe@perches.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Eric Sandeen <sandeen@sandeen.net>,
        Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xfs: Remove noinline from #define STATIC
Message-ID: <20181113054447.GE4235@magnolia>
References: <7302f4a13c1cbf62b07f636878ce25fcca84b6c4.camel@perches.com>
 <6420cf91-89c8-a876-7a0d-25ab8ba428b8@sandeen.net>
 <20181112214515.GN19305@dastard>
 <bd3806ccc911989c7ef1fed9e8d26a4a5ad347a9.camel@perches.com>
 <20181113011804.GP19305@dastard>
 <20181113015410.GB30750@thunk.org>
 <20181113030926.GQ19305@dastard>
 <b03fda08ee4ca4b488c6f67e64bfc94f49be4e83.camel@perches.com>
 <20181113052651.GR19305@dastard>
 <678d66cc417323f248f721cc8e4d271fe8ac80fb.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <678d66cc417323f248f721cc8e4d271fe8ac80fb.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9075 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811130054
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 09:31:51PM -0800, Joe Perches wrote:
> On Tue, 2018-11-13 at 16:26 +1100, Dave Chinner wrote:
> > On Mon, Nov 12, 2018 at 08:23:42PM -0800, Joe Perches wrote:
> > > On Tue, 2018-11-13 at 14:09 +1100, Dave Chinner wrote:
> > > > On Mon, Nov 12, 2018 at 08:54:10PM -0500, Theodore Y. Ts'o wrote:
> > > > > On Tue, Nov 13, 2018 at 12:18:05PM +1100, Dave Chinner wrote:
> > > > > > I'm not interested in making code fast if distro support engineers
> > > > > > can't debug problems on user systems easily. Optimising for
> > > > > > performance over debuggability is a horrible trade off for us to
> > > > > > make because it means users and distros end up much more reliant on
> > > > > > single points of expertise for debugging problems. And that means
> > > > > > the majority of the load of problem triage falls directly on very
> > > > > > limited resources - the core XFS development team. A little bit of
> > > > > > thought about how to make code easier to triage and debug goes a
> > > > > > long, long way....
> > > > > 
> > > > > So at least in my experience, if the kernels are compiled with
> > > > > CONFIG_DEBUG_INFO and/or CONFIG_DEBUG_INFO_REDUCED,
> > > > > scripts/decode_stracktrace.sh seems to do a very nice job with inlined
> > > > 
> > > > That doesn't help with kernel profiling and other such things that
> > > > are based on callgraphs...
> > > 
> > > If that's really the case:
> > > 
> > > I rather suspect the xfs static v STATIC function marking is not
> > > particularly curated and the marking is somewhat arbitrary.

I disagree.  I've added plenty of code over the past couple of years.
Short functions with few or no branches (e.g. converters) are 'static';
longer functions (loops, iterators, "decide what to do with this"
functions, etc.) with many branches are STATIC to make it easier for me
to ftrace their decisions over a given dataset.

> > That's a common opinion for an outsider to form when they come
> > across something unfamiliar they don't really understand. "I don't
> > understand this, so I must rewrite it" is an unfortunate habit that
> > programmers have.
> 
> Silly.

Yet frequent.

> > > So perhaps given the large number of static, but not STATIC
> > > functions, perhaps a sed of s/static/STATIC/ should be done
> > > when it's not inline for all xfs functions.
> > 
> > That's just as bad as removing them all, if not worse. 
> 
> Why?
> 
> > If you are writing new code or reworking existing code, then we'll
> > consider the usage of STATIC/static in the context of that work.
> > Otherwise, we leave it alone.
> 
> If your statement is as described above, and
> the STATIC use to enable call stack tracing i
> useful, why shouldn't it be systemic?
> 
> > It if ain't broke, don't fix it.
> 
> A generically lazy statement.

Please everyone let's take a breather from this thread for a few hours.
A 3.7% reduction in code size is not worth getting worked up over, IMO.

--D

> 
> 
