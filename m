Return-Path: <knut.omang@oracle.com>
X-Google-Smtp-Source: AH8x227aHMaLq+TKhH2d6ayBeK07xpFqMNfD0HvyAxNkUka8DBa3LerP9b5GyGi8k4BVcREmTjxb
ARC-Seal: i=1; a=rsa-sha256; t=1517641520; cv=none;
        d=google.com; s=arc-20160816;
        b=sPuv5bmo8Zb76duI2701DnKLDrMpffGj33ws803O4GOuP4j3QB5Rj7NeMoZkvv/QGk
         AkbCOkBcvl61WTmGx6mNiJyh3rNK9z62HInwXLNJbsFfTOBjPk14Yd0HFV7FunX3hTP5
         Lk9++5FdyWfSQhtNT18Qhanw91dPeePT2EPnHRPJ+g6cC3y0mtOu8Eyka1834qmQgCW/
         6TY5KVcISwwJCMeHkZaVVR7xKwHk5q2eLduRSGEChYePhlGfRCUnDXWLhIML/m0eq8QN
         UE1FpxUDcU6DD55OxavK7xHpQfGFI/xRPzgx09YwSysvHRdwpFAiZgz2LuY9InxdESwH
         BLvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:dkim-signature
         :arc-authentication-results;
        bh=8iQnjGptyTSkSKoz7zuyPSK8WRBtZZQ/aQb8VNQ3+JM=;
        b=Hy9k4FaSLVAFV5xT0e14nEDYu+/dO/m9di2d+JeW/7nGIBMnlZXT93XHGkYhmWhiSv
         DaiVsmMwhEUlvz/WHVXHHKEZD51L8r3+vMFuuNv7XiBUQF/xsUuCxBA6+ff2tocx/fRn
         JhhBW4TTCYAA9RNLuj1cQdfNATPsOH66cm/anx0JeAjgf50MwT8MrcL6vuHlDt4zfVQi
         sdkHybD7xN79xmFZTtj1zLQKcpAYK6WbtfIWDPn1XafPScNNypiZcQZg297wY+E3p84q
         9s7A0+0JLv8gMXEupdUVO2VI5DIQWV6ZDEiB+046XS3K9decsg4wcMzPTzeN8KOEqrkE
         UH5Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=nsDs93Yh;
       spf=pass (google.com: domain of knut.omang@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=knut.omang@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=nsDs93Yh;
       spf=pass (google.com: domain of knut.omang@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=knut.omang@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Message-ID: <1517641445.3118.342.camel@oracle.com>
Subject: Re: clang warning: implicit conversion in intel_ddi.c:1481
From: Knut Omang <knut.omang@oracle.com>
To: Greg KH <gregkh@linuxfoundation.org>,
        Jani Nikula
	 <jani.nikula@linux.intel.com>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>, Ozan Alpay <ozyalpy@gmail.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Ville =?ISO-8859-1?Q?Syrj=E4l=E4?=
 <ville.syrjala@linux.intel.com>,
        sil2review@lists.osadl.org, kernelnewbies@kernelnewbies.org,
        David Airlie <airlied@linux.ie>, intel-gfx@lists.freedesktop.org,
        Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>,
        llvmlinux@lists.linuxfoundation.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Date: Sat, 03 Feb 2018 08:04:05 +0100
In-Reply-To: <20180202155022.GA29918@kroah.com>
References: <alpine.DEB.2.20.1802011823340.4316@alpaca>
	 <20180201180240.GA28042@kroah.com>
	 <alpine.DEB.2.20.1802012045570.29994@hsp> <87372jkcu5.fsf@intel.com>
	 <alpine.DEB.2.20.1802021054500.13838@hsp>
	 <20180202100613.GA21492@kroah.com> <87h8qzisbt.fsf@intel.com>
	 <20180202131328.GA4456@kroah.com> <871si3ihj0.fsf@intel.com>
	 <20180202155022.GA29918@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8793 signatures=668661
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802030090
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1591285684265715697?=
X-GMAIL-MSGID: =?utf-8?q?1591362475650060812?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 2018-02-02 at 16:50 +0100, Greg KH wrote:
> On Fri, Feb 02, 2018 at 04:37:55PM +0200, Jani Nikula wrote:
> > On Fri, 02 Feb 2018, Greg KH <gregkh@linuxfoundation.org> wrote:
> > > On Fri, Feb 02, 2018 at 12:44:38PM +0200, Jani Nikula wrote:
> > >> 
> > >> +Knut, Fengguang
> > >> 
> > >> On Fri, 02 Feb 2018, Greg KH <gregkh@linuxfoundation.org> wrote:
> > >> > 	- If clang now builds the kernel "cleanly", yes, I want to take
> > >> > 	  warning fixes in the stable tree.  And even better yet, if you
> > >> > 	  keep working to ensure the tree is "clean", that would be
> > >> > 	  wonderful.
> > >> 
> > >> So we can run sparse using 'make C=1' and friends, or other static
> > >> analysis tools using 'make CHECK=foo C=1', as long as the passed command
> > >> line params work. There was work by Knut to extend this make checker
> > >> stuff [1]. Since mixing different HOSTCC's in a single workdir seems
> > >> like a bad idea, I wonder how hard it would be to make clang work like
> > >> this:
> > >> 
> > >> $ make CHECK=clang C=1
> > >> 
> > >> Or using Knut's wrapper. Feels like that could increase the use of clang
> > >> for static analysis of patches.
> > >
> > > Why not just build with clang itself:
> > > 	make CC=clang
> > 
> > Same as HOSTCC, mixing different CC's in a single build dir seems like a
> > bad idea. Sure, everyone can setup a separate build dir for clang, but
> > IMHO having 'make CHECK=clang C=1' work has least resistance. YMMV.
> 
> "O=some_output_dir" is your friend.  If you aren't doing that already
> for your test builds, you don't know what you are missing :)

I use O= a lot myself - so good not to have all the output files "pollute" the source
tree, and to be able to switch branches and compile without having to recompile everything
by having multiple O= set up.

I think what my runchecks wrapper script brings in addition is the ability to to a number
of checks which may or may not pass, even return error codes, from the same 'make' command
and configure what errors to fix now and what to postpone/ignore (and thus not fail from).

As an example, I just tried clang (on v4.15-rc6) with:

cd $HOME/src/kernel
make O=$HOME/build/kernel/clang
cd $HOME/build/kernel/clang
make

and it fails to compile for me in arch/x86/xen/mmu_pv.o. 

If I'd want to just make sure that some patches did not introduce new errors with clang, 
I would waste some time with unrelated errors, and there will be noise in the output, also
consuming personal "cycles".

I haven't really looked at the details of much of what clang outputs of errors yet, but I
can imagine that specific errors reported by clang might be useful to correct even in old
kernels, where some files inevitably will fail to compile like this.

This would be easy to handle with runchecks using a few exceptions for those
problems/files not yet fixed, allowing a run to easily detect (while compiling with gcc as
the main compiler) that no new clang errors were introduced of any other kind than those
suppressed.

Thanks,
Knut

> 
> thanks,
> 
> greg k-h
