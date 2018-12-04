Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B01C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0EB12081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:43:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0EB12081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbeLDUnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 15:43:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42582 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725866AbeLDUnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 15:43:20 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wB4Kcc3C141002
        for <linux-kernel@vger.kernel.org>; Tue, 4 Dec 2018 15:43:18 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2p5ygskq3r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 15:43:18 -0500
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 4 Dec 2018 20:43:17 -0000
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 4 Dec 2018 20:43:13 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wB4KhCFd19071152
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Dec 2018 20:43:12 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 440CFB2073;
        Tue,  4 Dec 2018 20:43:12 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0849BB2067;
        Tue,  4 Dec 2018 20:43:11 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.38])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  4 Dec 2018 20:43:11 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id D5CDC16C19ED; Tue,  4 Dec 2018 12:43:12 -0800 (PST)
Date:   Tue, 4 Dec 2018 12:43:12 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        danymadden@us.ibm.com, Dennis.Krein@netapp.com, joe@perches.com,
        joel@joelfernandes.org, ldr709@gmail.com,
        pierceagriffiths@gmail.com, rdunlap@infradead.org,
        zhouzhouyi@gmail.com, connor.shu@gmail.com
Subject: Re: [GIT PULL rcu/next] RCU commits for 4.21/5.0
Reply-To: paulmck@linux.ibm.com
References: <20181203225405.GA21856@linux.ibm.com>
 <20181204080837.GA67285@gmail.com>
 <20181204133817.GB8714@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204133817.GB8714@1wt.eu>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18120420-0064-0000-0000-000003801694
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010171; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01127004; UDB=6.00585347; IPR=6.00907138;
 MB=3.00024447; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-04 20:43:16
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120420-0065-0000-0000-00003B8F53A0
Message-Id: <20181204204312.GF4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-04_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812040177
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 02:38:17PM +0100, Willy Tarreau wrote:
> Hi Ingo,
> 
> On Tue, Dec 04, 2018 at 09:08:37AM +0100, Ingo Molnar wrote:
> > I noticed this bit from Willy:
> > 
> > >  tools/testing/selftests/rcutorture/bin/nolibc.h    | 2197 ++++++++++++++++++++
> > 
> > So <nolibc.h> is a rather large header and it comes with very little 
> > documentation - but once you read through the header it's obvious what it 
> > does, the code is clean and it's pretty cool all around, and in hindsight 
> > the name is a strong hint about what the header does as well. ;)
> 
> Thanks for the positive comment, as it was initially not designed to be
> merged into the kernel and was just a local home project. I figured it
> could be a perfect solution to Paul's executable size issues and offered
> some help to get it in relatively quickly, but surely we can do much better!
> 
> > Still it would be nice to at least add a top level description to the 
> > header to make people (like me) who are reading the code before the 
> > changelogs wonder less. For tooling headers we require a similar 
> > self-explanatory, feel-fuzzy structure as for kernel headers.
> 
> I'm fine with doing this. I even wrote the very small header at the last
> minute, without knowing if there was any chance it survives a review :-)
> 
> > Beyond adding a bit more documentation it would also be useful to factor 
> > nolibc.h out into tools/include/nolibc/ or so, no reason to hide it in 
> > rcutorture, I bet there's a number of other testcases and smaller 
> > utilities in tools/ that could make good use of it.
> 
> Fine as well. It's important however to keep in mind that I only covered
> the few architectures I could test (i386/x86_64/arm/arm64/mips), and even
> there the coverage is still limited. I don't want it to become too much of
> a pain to use for other utilities just by lack of initial coverage. However
> I agree that better exposure will help contributions come in.
> 
> > My long term hope would be that eventually we could even create a minimal 
> > klibc from it (a minimal libc provided by the kernel itself), giving 
> > minimalist binaries a mechanism to link against klibc.so:
> > 
> > - klibc would be an explicit opt-in mechanism, i.e. binaries that are 
> >   coupled with the kernel anyway (and initrd executables certainly are) 
> >   could use this.
> 
> In fact it's very similar to my goal. I'm using it in initramfs and initrds
> that do very little stuff and where it's acceptable to have a few #ifdef to
> adapt to this or that libc. However I found it extremely convenient *not* to
> require any external symbol, thus not to have to link against anything. But
> I'm well aware that this position cannot last forever and that at some
> point if we want to go further we'll possibly have a few layers (naked
> syscalls returning -errno, decorated syscalls making use of an explicit
> errno, libc-specific stuff like string functions). Possibly that in this
> case only the naked version would remain in the .h and that the rest will
> require linking with the .so/.a.
> 
> > - We could also add a way for the kernel to provide (non-swappable) 
> >   binaries via an automatic /klib/ mount point or so. This would allow 
> >   features like a minimal, console based rescue/debug shell that doesn't 
> >   rely on any filesystem state or external library dependencies, other 
> >   than the initial kernel+initrd image.
> 
> This could be convenient indeed, I never thought about this. I'm currently
> doing something comparable using initramfs, so maybe in the end we don't
> need the kernel to create anything beyond this, but instead just let the
> user choose in the configuration what utilities should be added to the
> initramfs sources.
> 
> (...)
> > - klibc would also eventually allow deeper integration with the vDSO 
> >   proper: for example on klibc based embedded systems we could link klibc
> >   and the vDSO into a single vDSO library, further simplifying and 
> >   optimizing it.
> 
> I already looked how to implement vDSO. I figured it was not very difficult
> but will require that I maintain variables with the AUXV, then I thought
> that it went beyond the scope of this minimalist implementaiton and
> postponed this.
> 
> > - klibc would also allow faster feature propagation from kernel to libc 
> >   as well, as we could prototype, test and benchmark new system calls and 
> >   new features on klibc - i.e. klibc integration and testcases could be a
> >   requirement for new system calls.
> 
> This actually is a good idea. There was already a discussion in another
> thread about exposing syscalls better in the kernel for better interactions
> with the libc, but it could start this way with test cases. It also increases
> the likeliness that an awkward API is detected early when the person starts
> to write his/her own part of the libc side.
> 
> > - There's no upper limit to how such a minimal kernel-shell (root only) 
> >   environment would look like, beyond a minimal shell in principle it 
> >   could include bits like:
> (...)
> 
> That's more or less what the preinit present in my initramfs provides. I
> just need a kernel and nothing else to start to manually find and mount
> my rootfs while debugging, it's quite convenient. It's very limited
> though. But I 100% agree with the benefits of such basic recovery
> utilities shipped with the kernel images!
> 
> (...)
> >     - a minimal version of 3D Tetris (just kidding)
> 
> I thought you were already kidding when talking about 3D in fact but
> apparently not! I think you really mean GPU-based acceleration rather
> than 3D since I hardly see how 3D stuff may improve my debugging
> abilities :-)
> 
> > - ... all of which would allow a fully integrated, self-contained (!) 
> >   solution with no external dependencies other than the build environment 
> >   to build the binaries, that allows the debugging of a system and the 
> >   eventual extraction of debug information, without having to interact 
> >   with the local filesystem or even the local X-window state for these 
> >   apps to run.
> 
> In my case I also ship the modules within the kernel image. It's extremely
> convenient to have the choice of a number of kernels for a given rootfs.
> You never have to wonder if the modules are present on the roofs or not,
> you never have to prepare any initrd, you just select the kernel you want
> and you're done. For development, when combined with the preinit I'm
> talking about, it's awesome, because you just want something which barely
> boots to the preinit prompt, then you can start to investigate.
> 
> > - I.e. a minimal Linux distribution done right, optimized for kernel 
> >   development, system bootstrap, rescue enviroment, etc. - far more 
> >   usable than a kdb session.
> 
> The distro I'm using was initially not made for this but to design
> reliable minimalist systems, and it turned out extremely effective for
> kernel development for these reasons. The whole rootfs is an initrd
> which contains all the tools I need, so I can only confirm the comfort
> it brings!
> 
> > Anyway, back to <nolibc.h>: wanted to ask Linus's and Arnaldo's opinion 
> > about the merge of it, we can still re-base and re-try if there's any 
> > objections.
> 
> I'm fine with this as well. I just want to be sure we don't postpone the
> coverage of Paul's rcutorture needs because it started for this initially.
> If we see the discussion going too far, we could also at least cover just
> rcutorture first which would buy us time to decide how it should be done
> better, then remove it once we can port rcutorture to the newly designed
> solution.

I of course prefer starting with what I have, but it would not be at
all difficult for me to rebase if that is what needs to happen.

							Thanx, Paul

