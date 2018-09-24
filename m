Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F9AECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7861B20883
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O/D3GOj2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7861B20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731884AbeIXV7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:59:36 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54038 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729466AbeIXV7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 17:59:36 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8OFtVmG007031;
        Mon, 24 Sep 2018 15:56:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : subject
 : from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=corp-2018-07-02;
 bh=JeXS/Oe0a3nuKVWXJ4CvZTHHp94Hw951F4lmmWOQeYM=;
 b=O/D3GOj2TOFczuXaxzMhkIU/FjEcdYVthnTPeCcwhhvuDdiEyoR8ctk8hEuvYer4VU2V
 fXKHWwGqSPyJYeeuS/Oc+SDdtyraLigWL78JV+BNxCwdgQtbb8gUUUKEe4L78Jym65oa
 a/sPbvMRnDqV4ndaSf9ISg6VRqlQxEQPuxmmLvMxZXO71tuG7RWkp8X8di59CbR+DwNa
 ldh1LBvfZ2pBVsmPITlAYxEkS+alUbXAApjIxJ/gMSRkCM8bMGOmDSj7FmctfCikIzp7
 f4lG++SLjINaXptK9kxHNfUv4bdqinOpBYycHNyp3OrFCSKD4e6pU0Dsv6iDV1muAimY zA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2mnd5t6sa1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Sep 2018 15:56:11 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8OFu9EQ023565
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Sep 2018 15:56:10 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8OFu8jn029849;
        Mon, 24 Sep 2018 15:56:08 GMT
Received: from asu.omang.mine.nu (/80.203.111.41)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Sep 2018 08:56:08 -0700
Message-ID: <1537804564.23582.113.camel@oracle.com>
Subject: Re: [Announce] LPC 2018: Testing and Fuzzing Microconference
From:   Knut Omang <knut.omang@oracle.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Dhaval Giani <dhaval.giani@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        alice.ferrazzi@gmail.com, Kevin Hilman <khilman@baylibre.com>,
        Tim Bird <tbird20d@gmail.com>,
        Laura Abbott <labbott@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        gustavo.padovan@collabora.co.uk,
        "Carpenter,Dan" <dan.carpenter@oracle.com>
Date:   Mon, 24 Sep 2018 17:56:04 +0200
In-Reply-To: <CACT4Y+ZN0OcTkY0ahvF0CGZv1bbLHGH2aEbCFuQzpC498cNojw@mail.gmail.com>
References: <CAPhKKr_XFzGcBBuQ51w7HjZd_Kq3nTOB6uAFG2vP5JH+Vx_eng@mail.gmail.com>
         <20180922125256.GB14042@bombadil.infradead.org>
         <CACT4Y+ZN0OcTkY0ahvF0CGZv1bbLHGH2aEbCFuQzpC498cNojw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9025 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809240157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-09-24 at 15:42 +0200, Dmitry Vyukov wrote:
> On Sat, Sep 22, 2018 at 2:52 PM, Matthew Wilcox <willy@infradead.org> wrote:
> > On Wed, Sep 19, 2018 at 10:13:15AM -0700, Dhaval Giani wrote:
> >> Sasha and I are pleased to announce the Testing and Fuzzing track at
> >> LPC [ 1 ]. We are planning to continue the discussions from last
> >> year's microconference [2]. Many discussions from the Automated
> >> Testing Summit [3] will also continue, and a final agenda will come up
> >> only soon after that.
> >>
> >> Suggested Topics
> >>
> >> - Syzbot/syzkaller
> >> - ATS
> >> - Distro/stable testing
> >> - kernelci
> >> - kernelci auto bisection
> >> - Unit testing framework
> >>
> >> We look forward to other interesting topics for this microconference
> >> as a reply to this email.
> >
> > I would like to talk about the IDA test suite that was recently merged.
> > See lib/test_ida.c.  It can be built as a module (CONFIG_TEST_IDA=m),
> > built-in (=y) or built in userspace (as part of the radix tree test
> > suite for historical reasons) along with the current kernel code.
> >
> > Being able to build the test suite in userspace allows for much more
> > rapid development.  Building it in kernel space offers testing across
> > a wide range of configurations that I don't have access to and can't
> > necessarily simulate well in userspace.
> >
> > My userspace implementation of kmalloc() simulates failures (in a rather
> > heavy-handed way; every non-GFP_KERNEL allocation fails).  That's rather
> > harder to simulate in kernel space.  I'd like there to be a way for a
> > kernel space test suite to ask for kmalloc failures so that the failure
> > paths can be tested.
> 
> Hi Matthew,
> 
> kmalloc fault injection is already implemented with
> CONFIG_FAULT_INJECTION. For original fault injection, you more-or-less
> ask to fail X% of allocations at random. It's great for testing
> servers for stability, but not so well suited for testing. Recently
> I've added so-called "systematic" fault injection
> (/proc/thread-self/fail-nth) which is perfect for unit testing. It
> allows to ask to fail N-th allocation request in the current task. So
> a unit test for a syscall can do:
> 
> for (i = 0;; i++) {
>   write(/proc/thread-self/fail-nth, i);
>   syscall_under_test();
>   if (read(/proc/thread-self/fail-nth) != 0)
>     break;
> }
> 
> which allows to examine each failure site one-by-one systematically
> (without making random processes on the machine fail too).
> 
> 
> > I think the idea of building parts of the core kernel libraries in
> > userspace and testing them there has greater generality than just the
> > IDA, IDR, XArray & radix tree and might profitably be adopted by other
> > parts of lib/.  The userspace simulation of other parts of the kernel
> > may well need to be extended.
> 
> This would be great. Besides providing faster turn-around time, this
> allow us to finally have something like:
> 
> make test [subsystem]
> 
> which will run all tests for the subsystem locally (in parallel,
> giving final OK/FAIL). This is not possible to in-kernel tests,
> because they require a machine and an image, and it's not possible to
> support everything that people use.

With KTF (https://github.com/oracle/ktf) we are using kprobes to inject 
modifying behaviour (by modifying a function's return value or input).

To cater for the needs for failover testing from user space, our approach 
is what we call "hybrid tests", where parts of the test execute in user land and 
parts of the test execute in the kernel. 

One limitation with config based test functionality is that it requires
rebuilding the kernel to enable the functionality. I think having the tests
available for running even on pre-existing kernels can be of great value.

I agree with Matthew in that there's good time savings to be made to be
able to "lift" code out of the kernel and execute it completely in user space.
The challenge is to be able to compile the kernel code in user land unmodified. 
The pieces under lib/ is probably the easiest ones since they have few 
dependencies on other kernel components.

If interesting, I could say a few words in this context about some work I did 
to allow me to run the Infiniband driver I was working on - and also developed 
the precursor of KTF for 
(https://github.com/oracle/linux-uek/tree/uek4/master/drivers/infiniband/hw/sif)
- entirely in user space under valgrind.
I used it a.o. to test the fairly complex page table management driver code for the on-
board MMU. I have wanted to make it available in a similar way as KTF, just haven't had
the time to get back to it yet.

Knut
