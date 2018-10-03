Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91151C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 19:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 402A4206B2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 19:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="tjZa23br"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 402A4206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=Oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbeJDCGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 22:06:24 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34002 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbeJDCGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 22:06:23 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w93J4aZm160520;
        Wed, 3 Oct 2018 19:16:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=LhAcWoSVZvRezv4jk3xe3ItHjEot6WxoDlrkED1nPkU=;
 b=tjZa23brp870o4sScZIILuY5pJAHc0mi0LeymEQ5cwbyAfFXoyH3twbYu1xlL3vnMbvP
 lF8kCFJpgU4yyzeOgKytDYo1xnEsrdlNACKMttJXnJ+e4HAcePGO0qFr+nPCvunspih7
 or2DRkNji//pjs97tR635owqUO+fFnxIH824v7HTD+AJFn6MXNpI5NRFIlU562s4RRMg
 tPqTNC7XkMrp10TPIm3bL7cIK2jh4G0sQ5IRSrmp3OcjrzGN5+Flq8v8VtMb/nRRY3uI
 gGJe1F3s2jXVsJFxm9RaSsj6WsMkIF9/02emNS7uKAijJxQJykZ6DC2l4ECigp110KH3 0Q== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2mt0ttx73x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Oct 2018 19:16:13 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w93JGCSO029649
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 3 Oct 2018 19:16:12 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w93JG9VE003189;
        Wed, 3 Oct 2018 19:16:09 GMT
Received: from oracle.com (/23.233.26.138)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 03 Oct 2018 19:16:08 +0000
Date:   Wed, 3 Oct 2018 15:16:01 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Sasha Levin <levinsasha928@gmail.com>
Cc:     dhaval.giani@gmail.com,
        Sasha Levin <alexander.levin@microsoft.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>, alice.ferrazzi@gmail.com,
        khilman@baylibre.com, tbird20d@gmail.com,
        Dmitry Vyukov <dvyukov@google.com>, labbott@redhat.com,
        Steven Rostedt <rostedt@goodmis.org>,
        gustavo.padovan@collabora.co.uk, dan.carpenter@Oracle.com,
        willy@infradead.org, knut.omang@Oracle.com,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Subject: Re: [Announce] LPC 2018: Testing and Fuzzing Microconference
Message-ID: <20181003191600.ocbplbxdtikltavo@oracle.com>
Mail-Followup-To: Sasha Levin <levinsasha928@gmail.com>,
        dhaval.giani@gmail.com, Sasha Levin <alexander.levin@microsoft.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>, alice.ferrazzi@gmail.com,
        khilman@baylibre.com, tbird20d@gmail.com,
        Dmitry Vyukov <dvyukov@google.com>, labbott@redhat.com,
        Steven Rostedt <rostedt@goodmis.org>,
        gustavo.padovan@collabora.co.uk, dan.carpenter@oracle.com,
        willy@infradead.org, knut.omang@oracle.com
References: <CAPhKKr9vWJ4d8yV7N4=XqaEyKEjC_ZiPX_2RJSR9ZiR9k6yS1w@mail.gmail.com>
 <20181002202256.vchh4j5k2wfjqdry@oracle.com>
 <CA+1xoqc+aZkQ01oYwby9pvOv3rVh+Qm7t5iJZ1+iT+t19QY6oA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+1xoqc+aZkQ01oYwby9pvOv3rVh+Qm7t5iJZ1+iT+t19QY6oA@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9035 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810030176
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Sasha Levin <levinsasha928@gmail.com> [181002 17:03]:
> On Tue, Oct 2, 2018 at 4:44 PM Liam R. Howlett <Liam.Howlett@oracle.com> wrote:
> >
> > * Dhaval Giani <dhaval.giani@gmail.com> [180919 13:15]:
> > > Hi folks,
> > >
> > > Sasha and I are pleased to announce the Testing and Fuzzing track at
> > > LPC [ 1 ]. We are planning to continue the discussions from last
> > > year's microconference [2]. Many discussions from the Automated
> > > Testing Summit [3] will also continue, and a final agenda will come up
> > > only soon after that.
> > >
> > > Suggested Topics
> > >
> > > - Syzbot/syzkaller
> > > - ATS
> > > - Distro/stable testing
> > > - kernelci
> > > - kernelci auto bisection
> > > - Unit testing framework
> > >
> > > We look forward to other interesting topics for this microconference
> > > as a reply to this email.
> > >
> > > Thanks!
> > > Dhaval and Sasha
> > >
> > > [1] https://blog.linuxplumbersconf.org/2018/testing-and-fuzzing-mc/
> > > [2] https://lwn.net/Articles/735034/
> > > [3] https://elinux.org/Automated_Testing_Summit
> >
> >
> > Hello,
> >
> > I have a new way to analyze binaries to detect specific calls without
> > the need for source.  I would like to discuss Machine Code Trace
> > (MCTrace) at the Testing and Fuzzing LPC track.  MCTrace intercepts the
> > application prior to execution and does not rely on a specific user
> > input. It then decodes the machine instructions to follow all control
> > flows to their natural conclusions.  This includes control flows that go
> > beyond the boundaries of the static executable code into shared
> > libraries. This new technique avoids false positives which could be
> > produced by static analysis and includes paths that could be missed by
> > dynamic tracing.  This type of analysis could be useful in both testing
> > and fuzzing by providing a call graph to a given function.
> >
> > MCTrace was initially designed to help generate the seccomp() filter
> > list, which is a whitelist/blacklist of system calls for a specific
> > application. Seccomp filters easily become outdated when the application
> > or shared library is updated. This can cause failures or security
> > issues [ 1 ].  Other potential uses including examining binary blobs,
> > vulnerability analysis, and debugging.
> 
> Hi Liam,
> 
> Is MCTrace available anywhere?

Hello Sasha,

I missed this email as I was not CC'ed.

MCTrace is currently a proof-of-concept and the source is not available.
There are a number of instructions that need additional work, but I have
some test applications that can be analyzed.  I'd like to explain the
concept, why it is useful, and debate other potential uses.

Thank you,
Liam

