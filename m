Return-Path: <jani.nikula@intel.com>
X-Cyrus-Session-Id: sloti22d1t05-1938260-1517560595-2-16728580469737044162
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_HI -5, SPF_PASS -0.001,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='134.134.136.65', Host='mga03.intel.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: cc='utf-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: jani.nikula@intel.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517560594; b=HK+QW9v+XruzqYFdZyhf01I0WLE8sAHcglLN45ghuyMh+By
    1ie3Gurjh/WWC0DHwZVQcfWN6yKr5ZC+iJP3duZtz9fFN8ES+jJxRk1TmzcS4hix
    pWwdUyiNRuQNPletEEDcQNN1j8ZJWLpV8UN1C540SoGUmmamyMGqONQQYcmuRKvD
    xflLXZrp0rQ9jIcuYlrPK3HFxeLzdCI9YwNQCeccGIS6gi/3QmF7zk9kN0RLQplq
    kGXQX8d3nJHTQLip8v7w56Cm5otdVPFOT8pvYWIsmDt1/E01pUArpsf/RIcrlPYL
    QT0fUS9KtNM4xwx0ngQN6lTUCFybF9+u/cYB8Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:in-reply-to:references
    :date:message-id:mime-version:content-type
    :content-transfer-encoding; s=arctest; t=1517560594; bh=ROGHrMbs
    ymPgF6FK6fwET16sTtj10IDbBYcaj+qsVCo=; b=ckYPG5BWOCrOChs5sLUapvDn
    thDDar3Dk85l0919aBO0oZcamaLzOgGwnsjTbz+zGYzZqiOMzUu3Z2nicGHMBwMI
    YvT6l1lnz8dqDmgUHtURCyqdlto79RH76GOXyWGys+2LX2Plol0C6Tk3V4nTB/w5
    tbP3kr9h2gcpwrLJpL43f0MgWGx6Rdq3wh6K0BGgpcFJPpYJ3laJllevRPug+jMT
    /lZgJgvN4QBcfmVfXe5+wMbEmXQSUXKg+3EF7YVyVE2TFZGMxEHRW5hHbY496sjx
    OiV82rGysrrxt0qroMSeP0yFYodDJRbJjLhhngvuHySppAvGFQOkbCF1ks+ryQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=134.134.136.65 (mga03.intel.com);
    spf=pass smtp.mailfrom=jani.nikula@intel.com smtp.helo=mga03.intel.com;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=mga03.intel.com x-ptr-lookup=mga03.intel.com;
    x-return-mx=pass smtp.domain=intel.com smtp.result=pass smtp_is_org_domain=yes header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=134.134.136.65 (mga03.intel.com);
    spf=pass smtp.mailfrom=jani.nikula@intel.com smtp.helo=mga03.intel.com;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=mga03.intel.com x-ptr-lookup=mga03.intel.com;
    x-return-mx=pass smtp.domain=intel.com smtp.result=pass smtp_is_org_domain=yes header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,447,1511856000";
   d="scan'208";a="27488440"
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>, Greg KH <greg@kroah.com>
Cc: Ozan Alpay <ozyalpy@gmail.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 sil2review@lists.osadl.org, kernelnewbies@kernelnewbies.org, David Airlie
 <airlied@linux.ie>, intel-gfx@lists.freedesktop.org, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, llvmlinux@lists.linuxfoundation.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 lukas.bulwahn@gmail.com
Subject: Re: clang warning: implicit conversion in intel_ddi.c:1481
In-Reply-To: <alpine.DEB.2.20.1802012045570.29994@hsp>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <alpine.DEB.2.20.1802011823340.4316@alpaca> <20180201180240.GA28042@kroah.com> <alpine.DEB.2.20.1802012045570.29994@hsp>
Date: Fri, 02 Feb 2018 10:36:18 +0200
Message-ID: <87372jkcu5.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 01 Feb 2018, Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> Hi Greg,
>
> On Thu, 1 Feb 2018, Greg KH wrote:
>
>> On Thu, Feb 01, 2018 at 06:33:30PM +0100, Ozan Alpay wrote:
>> > Dear Rodrigo Vivi, Ville Syrj=C3=A4l=C3=A4,
>> >=20
>> > My name is Ozan Alpay, and I am a student mentored by Lukas Bulwahn. W=
e=20
>> > intend to use static analysis tools on the kernel source to identify,=
=20
>> > analyze and report issues. As a very first step, we are looking into=20
>> > clang compiler warnings and will then move to more sophisticated tools=
.=20
>> >
>> > [...]
>> >
>> > Linux 4.15 is shipped with this clang warning, but we don't see the=20
>> > crucial need to provide a backport commit to the stable branch for 4.1=
5.=20
>> > We just wanted to inform you about our analysis of this clang warning.=
=20
>> > Ultimately the final call if you would like to address this clang warn=
ing=20
>> > in 4.15 is yours.
>>=20
>> Note, I have not taken "clang warning fixes" for stable kernel updates
>> in the past, and I doubt I will in the future, unless the tree "builds
>> clean" with clang.  If it eventually gets there, then yes, I will do
>> that.
>>=20
>> Note, if you are going to email this out to everyone who fixes a warning
>> message, you might want to reconsider it.  That's going to be a lot of
>> work, and for people who have already fixed an issue, it's kind of
>> pointless to just remind them of work they have done in the past, right?
>>=20
>> What is the goal of these types of emails?
>>=20
>
> We are interested in providing useful information on potential bugs or bu=
g=20
> patterns that we get from static analysis tools, after we pre-assess them=
=20
> and manually select them to send to the review process of the patch=20
> submission.
>
> For me, the clang warnings were an easy starting point for a student to=20
> set up and look at, compared to much more sophisticated tools, such as=20
> coccinelle, sparse or new tools for the kernel development, such as CMBC=
=20
> or facebook's Infer.
>
> Once we really understand which tools are useful and which information ca=
n=20
> be quickly pre-assessed and sent out in a useful way without just creatin=
g=20
> more noise in the discussion, I would have contacted the 0-day=20
> infrastructure team or the kernelci.org team to continue the discussion=20
> how to include our first setup into a proper semi-automated service.
>
> Using the clang warnings, I wanted to explore how this would even=20
> potentially work.
>
> Considering clang, of course, currently, we cannot compile the whole=20
> kernel with all possible kernel configurations with clang, but I believe=
=20
> Nick Desaulniers, Matthias Kaehlcke and others are already working on=20
> that and are getting close to this goal. Hence, assuming they will be=20
> successful soon, I wanted to explore the next step of using static=20
> analysis tools around the clang/LLVM compiler.
>
> Actually, v4.15 builds almost "cleanly" with clang: For defconfig, there=
=20
> are only two clang compiler warnings and the one that we looked into=20
> deeper here is already resolved in linux-next, so chances are actually=20
> high that we might get to this "builds clean" soon-ish, at least for=20
> defconfig.
>
> Concerning clang warnings and how to progress towards that goal of=20
> building cleanly, my strategy is to identify when new clang compiler
> warnings are introduced and just point these warnings out as code smells=
=20
> during the review discussion before they are merged into the=20
> first maintainer tree. If we manually inspect these clang warnings
> to make sure that they are genuine code smells of some "imprecise=20
> implementation" before we send them to the mailing list, I would hope tha=
t=20
> they are of some value for the developer in the submission process and=20
> he/she could address the warning in a patch v2 while he/she is reacting t=
o=20
> the other review comments from the human reviewers.
>
> At best, I always considered them as useful information during the review=
=20
> process, but I certainly DO NOT want to start patching the kernel due to=
=20
> clang warnings. The chances/risk that we just break more due to naively=20
> fixing warnings without proper understanding is much higher than the=20=20
> benefit of actually improving the situation. If I recall correctly, I=20
> think this is also one of the lessons learned from motivating newcomers=20
> to address warnings in previous kernel newbies activities.
>
> Greg, do you think it is worthwhile to invest some effort to move=20
> towards the goal "kernel builds cleanly with clang"?
> Would you agree that providing information during the patch review is a=20
> good way to move forward to this goal if we find a suitable manner to=20
> provide this feedback quickly and cleanly at this very early stage of=20
> development?
>
> If not, we will immediately stop to move in this direction and this is th=
e=20
> first and last email that you have seen of this kind, and we will have to=
=20
> come up with better/other ideas around work on the Linux kernel.
>
> If so, we will continue in the direction sketched above, and I think I=20
> just have to point out and apologize for the two obvious things that we=20
> did wrong in this specific case here:
>
>   - We noticed that there were further changes in linux-next, but we
>     thought that our investigation on v4.15 was valuable nevertheless
>     for the developers that had touched the source code that we looked at,
>     although, there is nothing to be done if commits from linux-next are
>     merged into Linus' tree soon. Taking your response, we have clearly=20
>     been WRONG here, overestimating our contribution versus the noise=20
>     ratio that we contribute to.
>=20=20=20
>   - We looked at a clang warning, for which we could only provide the=20
>     information on this clang warning at this very late stage, i.e., when
>     the commit under investigation has already been merged and the kernel=
=20
>     was released. So pointing out shortcoming of that kind seems to have=
=20
>     no value, as you, Greg, would not backport commits to stable anyway.
>
> This has been both errors on my side as a mentor. After my student
> has started this week and has worked hard for a week learning a lot about=
=20
> Linux kernel development and all the tools around it, I did not want to=20
> discourage him and say that the goal set at the beginning of the week to=
=20
> identify and report a code smell on one commit on the mailing list has=20
> not been achieved as for the reasons above. Instead, we decided to send i=
t=20
> out and were interested in the general reception of our work of this firs=
t=20
> week.
>
> I apologize for that and hope we can leave the specific reported issue no=
w=20
> just rest in peace.
>
> This experiment shows that I still need to improve my understanding how=20
> to contribute properly to the kernel development. At least to me, the=20=
=20
> policy on clang warnings was not clear; and I have learned this now in=20
> this more indirect way.
>
> We only sent out this one email to see if clang warnings are of interest=
=20
> at all, and we are glad that you came back to us so quickly with feedback.
>
> Greg, if you can continue to be a sparing partner and point out when=20
> we are moving in the wrong direction, we will try our best to understand
> how we can contribute to turn results from bug finders and static analysi=
s=20
> tools with the manual pre-assessment we can do into valuable contribution=
s=20
> on the mailing list and the linux kernel development.
>
> We certainly do not intend to spam the mailing list with reports of=20
> findings nobody cares about.

Being brutally honest, please write shorter reports and shorter emails
to the lists.

The static analysis reports are welcome, but only when 1) we didn't
already fix it in linux-next, or 2) it reveals an actual bug, not just a
warning, warranting a backport.

Thanks,
Jani.


--=20
Jani Nikula, Intel Open Source Technology Center
