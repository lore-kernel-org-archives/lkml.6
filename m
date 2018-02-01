Return-Path: <kernelnewbies-bounces@kernelnewbies.org>
X-Cyrus-Session-Id: sloti22d1t05-69569-1517508180-2-9672301687518849715
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: yes ("Address greg@kroah.com in From header is in addressbook");
 in-addressbook; shared/fdfaecbe-d8f0-4518-a17e-0d89bf6dc529 ("Greg")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001,
  RCVD_IN_DNSWL_NONE -0.0001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='96.67.55.147', Host='shelob.surriel.com', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='iso-8859-1', plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: kernelnewbies-bounces@kernelnewbies.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517508180; b=eFugkfsS/qavl5qy/XlAcTouNmMqt41f3pbgL9/865z5xY9
    k7DS6IKLUbuwarPRMHK4h/fqnglYDpJWkgIMDmCGxtOxesR37f93kTaX21WRg7Mb
    bfeVWg/QD62DHF8MHNrbd+PUSHBhK0fjXsJdlE/nw4hbbNwGYWJqT5S6kaF5JpCl
    DNVpr231M9hVYPQ+ccDfHmo2R0RaE4ZIelqZ3yOnQiAAof8DW2J7rJRGHqv6QcYo
    iKujJWJihYRpvPXmm9fyIrOC82VbJVilLB5sjP3m1P+FmaXoCl16xkO1OC6gSZR6
    PXbyZgwf1X6DEuUDJzYmC54hhWl5cuD1AemR8dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:cc:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding; s=arctest; t=1517508180; bh=l3ZoTBEj
    waW2maCSPErA7PhK42jQ+BDJjpyQf3RdHDY=; b=WdfAWs1qLgKUMjekGlX+Pz7k
    qIdMQwvzlzdApRwnWMh0H9tarR49bwNY++IqyUNIefaJfFb6gJRtXmRLSqNqp6Qj
    zzyNmMkhtid2YxzYGaN4Brq1LF7OBzWcK7dahP4UkWPQgqaD93KW17hGuZPrbG+v
    dZKWa0id+B69TAuhcwWv8ZKZFngfqniGCPF+GmOnqjQuIzA4ozlCpNAb8E8fey67
    Eyo/9b0fGy2dLgIIgQds1RU0RbihkeuRR2Qdw31lC7sR3wxHqFouOaGH76gkr+8U
    tNKLi+rMxrcNKFhxVJOeOQIpgPQB/7RvX3ezGOUXBY1Z8YH2nt+Mh6zvHFVIbw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZRBeGL02 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm1;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kroah.com;
    iprev=pass policy.iprev=96.67.55.147 (shelob.surriel.com);
    spf=permerror smtp.mailfrom=kernelnewbies-bounces@kernelnewbies.org smtp.helo=shelob.surriel.com;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=shelob.surriel.com x-ptr-lookup=shelob.surriel.com;
    x-return-mx=pass smtp.domain=kernelnewbies.org smtp.result=pass smtp_is_org_domain=yes header.domain=kroah.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZRBeGL02 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm1;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kroah.com;
    iprev=pass policy.iprev=96.67.55.147 (shelob.surriel.com);
    spf=permerror smtp.mailfrom=kernelnewbies-bounces@kernelnewbies.org smtp.helo=shelob.surriel.com;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=shelob.surriel.com x-ptr-lookup=shelob.surriel.com;
    x-return-mx=pass smtp.domain=kernelnewbies.org smtp.result=pass smtp_is_org_domain=yes header.domain=kroah.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-ME-Sender: <xms:Q1ZzWhyA0dW5k1Ld_S3jmzdeiT6rLj1J1BWl6eyjR7jXQTtpjsG4yg>
Date: Thu, 1 Feb 2018 19:02:40 +0100
From: Greg KH <greg@kroah.com>
To: Ozan Alpay <ozyalpy@gmail.com>
Subject: Re: clang warning: implicit conversion in intel_ddi.c:1481
Message-ID: <20180201180240.GA28042@kroah.com>
References: <alpine.DEB.2.20.1802011823340.4316@alpaca>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1802011823340.4316@alpaca>
User-Agent: Mutt/1.9.3 (2018-01-21)
Cc: sil2review@lists.osadl.org, kernelnewbies@kernelnewbies.org,
 David Airlie <airlied@linux.ie>, intel-gfx@lists.freedesktop.org,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 llvmlinux@lists.linuxfoundation.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, lukas.bulwahn@gmail.com,
 Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
X-BeenThere: kernelnewbies@kernelnewbies.org
X-Mailman-Version: 2.1.15
List-Unsubscribe: <https://lists.kernelnewbies.org/mailman/options/kernelnewbies>,
 <mailto:kernelnewbies-request@kernelnewbies.org?subject=unsubscribe>
List-Archive: <http://lists.kernelnewbies.org/pipermail/kernelnewbies/>
List-Post: <mailto:kernelnewbies@kernelnewbies.org>
List-Help: <mailto:kernelnewbies-request@kernelnewbies.org?subject=help>
List-Subscribe: <https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies>,
 <mailto:kernelnewbies-request@kernelnewbies.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: kernelnewbies-bounces@kernelnewbies.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 01, 2018 at 06:33:30PM +0100, Ozan Alpay wrote:
> Dear Rodrigo Vivi, Ville Syrj=E4l=E4,
> =

> My name is Ozan Alpay, and I am a student mentored by Lukas Bulwahn. We =

> intend to use static analysis tools on the kernel source to identify, =

> analyze and report issues. As a very first step, we are looking into =

> clang compiler warnings and will then move to more sophisticated tools. =

> =

> When compiling Linux 4.15 with clang, we have discovered that your commit =

> 2952cd6fb4cc ("drm/i915: Let's use more enum intel_dpll_id pll_id.") =

> introduced the following warning:
> =

> drivers/gpu/drm/i915/intel_ddi.c:1481:30: warning: implicit conversion fr=
om enumeration type 'enum port' to different enumeration type 'enum intel_d=
pll_id' [-Wenum-conversion] =

> 	enum intel_dpll_id pll_id =3D port;
> =

> To reproduce it, you can compile Linux 4.15 with clang with this command: =

> =

> make HOSTCC=3Dclang-5.0 defconfig && make -j32 HOSTCC=3Dclang-5.0 CC=3Dcl=
ang-5.0
> =

> If you don't have clang installed in your system, you can use this simple =

> docker setup to compile the kernel with clang:
> =

> wget https://raw.githubusercontent.com/bulwahn/linux-kernel-analysis/mast=
er/docker/kernel-clang/Dockerfile && \
> docker build -t kernel-clang . && \
> docker run -v <your kernel source directory>:/linux/ kernel-clang /bin/sh=
 -c "cd linux && make CC=3Dclang-5.0 clean && make HOSTCC=3Dclang-5.0 defco=
nfig && make -j32 HOSTCC=3Dclang-5.0 CC=3Dclang-5.0"
>  =

> While we were doing our analysis on 4.15, we noticed that you already =

> resolved this warning on linux-next with your work in commit bb911536f07e =

> ("drm/i915: Eliminate pll->state usage from bxt_calc_pll_link()"). So, =

> since it is resolved on linux-next and we expect that this commit will be =

> merged in the merge window for 4.16, there is probably nothing further to =

> do.
> =

> Linux 4.15 is shipped with this clang warning, but we don't see the =

> crucial need to provide a backport commit to the stable branch for 4.15. =

> We just wanted to inform you about our analysis of this clang warning. =

> Ultimately the final call if you would like to address this clang warning =

> in 4.15 is yours.

Note, I have not taken "clang warning fixes" for stable kernel updates
in the past, and I doubt I will in the future, unless the tree "builds
clean" with clang.  If it eventually gets there, then yes, I will do
that.

Note, if you are going to email this out to everyone who fixes a warning
message, you might want to reconsider it.  That's going to be a lot of
work, and for people who have already fixed an issue, it's kind of
pointless to just remind them of work they have done in the past, right?

What is the goal of these types of emails?

thanks,

greg k-h

_______________________________________________
Kernelnewbies mailing list
Kernelnewbies@kernelnewbies.org
https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies
