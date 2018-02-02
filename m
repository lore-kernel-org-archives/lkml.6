Return-Path: <kernelnewbies-bounces@kernelnewbies.org>
X-Cyrus-Session-Id: sloti22d1t05-2700043-1517586641-2-6330484059258727844
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001,
  RCVD_IN_DNSWL_NONE -0.0001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='96.67.55.147', Host='shelob.surriel.com', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: cc='iso-8859-1', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: kernelnewbies-bounces@kernelnewbies.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517586641; b=J3sEcfSRI6G5mHT7VumKkrSdac4eekQcFCx4+0iM7Nid3nl
    +IWOe+w7Ka214+kQ9/8yVWeBeey3/eb7aspvmjZ+kW6d8cb0OTPyFNnFu/8IPbFa
    oyisjpvDDR0M8b2Wwh9fn0zagJzZGLpivyJBR0p9SB10T9gJ0Rd0sWOYHY3Nazvi
    ZcNIZP0awIRjn/DVlSk3CM9EFxw4KZ1HPt/KgkdzWJmPfSBnXp4EoYWoUn5ce/c3
    SF7sZ2RTHylQ6BNuVU6AwRpJT2ipBgsL+SMCNpv83RVuChdXfT1gaqdlgFHBf4tm
    UYMtiw5sPyo8G2/B+huU/0B+uAe/Ou6P8zKEuTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:cc:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding; s=arctest; t=1517586641; bh=vLj7cXeP
    vMCOT8uv9ttNAk0l4Q5h9mSogRtqYuTBeI8=; b=brj+5Tpx63T6i3CNz/GvMu4c
    kgL9STBHt+vQJRkJDxj0W/6RJeMtz2RHUHZHO7Bn6HlyOM4myidpDDYb5giQOwwH
    1nU2DIQOkLdRaDo+QtwUpI1Pn+za6W6xRgvpwK8ZFMYEMHGDZKVMjPlMwygUPAoH
    UYGl96avqtHTlTLH+u7D1KMqKXF+8EGpFZy5CuFPj7y/PzKeJcU0aHxUtuW/uTNo
    IdTwi3WbBlIxhUKZQncohXrP1+bqzVgeUd3xqskffb/x8xoK5csEOIGkBauofl/s
    wtYeKaq9VJ0qBu4ScdlArYFwfHDvB5fZR3X+RXe2OOBb5PjouglE6xKoQFz4TA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=96.67.55.147 (shelob.surriel.com);
    spf=permerror smtp.mailfrom=kernelnewbies-bounces@kernelnewbies.org smtp.helo=shelob.surriel.com;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=shelob.surriel.com x-ptr-lookup=shelob.surriel.com;
    x-return-mx=pass smtp.domain=kernelnewbies.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=96.67.55.147 (shelob.surriel.com);
    spf=permerror smtp.mailfrom=kernelnewbies-bounces@kernelnewbies.org smtp.helo=shelob.surriel.com;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=shelob.surriel.com x-ptr-lookup=shelob.surriel.com;
    x-return-mx=pass smtp.domain=kernelnewbies.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Date: Fri, 2 Feb 2018 16:50:22 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: clang warning: implicit conversion in intel_ddi.c:1481
Message-ID: <20180202155022.GA29918@kroah.com>
References: <alpine.DEB.2.20.1802011823340.4316@alpaca>
 <20180201180240.GA28042@kroah.com>
 <alpine.DEB.2.20.1802012045570.29994@hsp>
 <87372jkcu5.fsf@intel.com>
 <alpine.DEB.2.20.1802021054500.13838@hsp>
 <20180202100613.GA21492@kroah.com> <87h8qzisbt.fsf@intel.com>
 <20180202131328.GA4456@kroah.com> <871si3ihj0.fsf@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <871si3ihj0.fsf@intel.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Cc: sil2review@lists.osadl.org, kernelnewbies@kernelnewbies.org,
 David Airlie <airlied@linux.ie>, llvmlinux@lists.linuxfoundation.org,
 intel-gfx@lists.freedesktop.org,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Knut Omang <knut.omang@oracle.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Ozan Alpay <ozyalpy@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kernelnewbies-bounces@kernelnewbies.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 02, 2018 at 04:37:55PM +0200, Jani Nikula wrote:
> On Fri, 02 Feb 2018, Greg KH <gregkh@linuxfoundation.org> wrote:
> > On Fri, Feb 02, 2018 at 12:44:38PM +0200, Jani Nikula wrote:
> >> 
> >> +Knut, Fengguang
> >> 
> >> On Fri, 02 Feb 2018, Greg KH <gregkh@linuxfoundation.org> wrote:
> >> > 	- If clang now builds the kernel "cleanly", yes, I want to take
> >> > 	  warning fixes in the stable tree.  And even better yet, if you
> >> > 	  keep working to ensure the tree is "clean", that would be
> >> > 	  wonderful.
> >> 
> >> So we can run sparse using 'make C=1' and friends, or other static
> >> analysis tools using 'make CHECK=foo C=1', as long as the passed command
> >> line params work. There was work by Knut to extend this make checker
> >> stuff [1]. Since mixing different HOSTCC's in a single workdir seems
> >> like a bad idea, I wonder how hard it would be to make clang work like
> >> this:
> >> 
> >> $ make CHECK=clang C=1
> >> 
> >> Or using Knut's wrapper. Feels like that could increase the use of clang
> >> for static analysis of patches.
> >
> > Why not just build with clang itself:
> > 	make CC=clang
> 
> Same as HOSTCC, mixing different CC's in a single build dir seems like a
> bad idea. Sure, everyone can setup a separate build dir for clang, but
> IMHO having 'make CHECK=clang C=1' work has least resistance. YMMV.

"O=some_output_dir" is your friend.  If you aren't doing that already
for your test builds, you don't know what you are missing :)

thanks,

greg k-h

_______________________________________________
Kernelnewbies mailing list
Kernelnewbies@kernelnewbies.org
https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies
