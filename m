Return-Path: <kernelnewbies-bounces@kernelnewbies.org>
X-Cyrus-Session-Id: sloti22d1t05-2484837-1517577229-2-16972203000700780489
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
    t=1517577228; b=qCln4tlVRo5nHpHyWijHBzOdGFTIShtd2xCeVNrOV8snm7R
    ijVfS+hXUkjJx51LrcfENiZt5CfDeGAqyAztIEtuBiz6tSnjK2mN5PHav6/M28iC
    GIFIsVuI4/AYVKQuEqdUPKDNauS3qYqdqakDs+ybv2W9+nlz/OPkVfgw6rkw1BAP
    g0aWCMb172ZN+oG+FZIXQnLCTrGaLjEUWlYE2H1y40LtJtW/Xc4+KNA1Cv/YfLHQ
    s4b01C336C6Xdhg3h7EBfKCE9dmbllslGchWEOwEQIfgiyY0yrjHAShnUExeY2+U
    3xwRq6JMOXgbT1Epj671GH9GEPr7gBB90HRybBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:cc:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding; s=arctest; t=1517577228; bh=fIEWVIVN
    tDfi0PggaAjQL0nFTAnICANHgr+6dvivxFc=; b=nRb7plwJnz5jUKx0Gsx0akdd
    /VXHjwsgjzKPRWj02ssxnPpng2Nvl8VkCh0s4Oo+Bqxt0kV2gIsbz8j9jwl4V89O
    h1gHobS2AXobvYNysStiabspl/CHKUf9Ivjd1XminKs4cLgGtvYASjDXDtloyIwE
    TYSx++7VaqFr3RiHZWrY96ImSSKXG5Zx84RPcr+oujDK+p6ORIW7mX+ld0H/P2zb
    4qddlN3CEFdyKyySMS2J+IfanbN2J+vH+xUTx9S/gZnd0aQPCDgDoJq8PQ5zPyjP
    5hfXRTURXcbIvWAErxgqXM6pSoYfCEMLW4vNtmu9Owo32lRHyOEZGqb2JQ9QCw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=96.67.55.147 (shelob.surriel.com);
    spf=permerror smtp.mailfrom=kernelnewbies-bounces@kernelnewbies.org smtp.helo=shelob.surriel.com;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=shelob.surriel.com x-ptr-lookup=shelob.surriel.com;
    x-return-mx=pass smtp.domain=kernelnewbies.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=96.67.55.147 (shelob.surriel.com);
    spf=permerror smtp.mailfrom=kernelnewbies-bounces@kernelnewbies.org smtp.helo=shelob.surriel.com;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=shelob.surriel.com x-ptr-lookup=shelob.surriel.com;
    x-return-mx=pass smtp.domain=kernelnewbies.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Date: Fri, 2 Feb 2018 14:13:28 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: clang warning: implicit conversion in intel_ddi.c:1481
Message-ID: <20180202131328.GA4456@kroah.com>
References: <alpine.DEB.2.20.1802011823340.4316@alpaca>
 <20180201180240.GA28042@kroah.com>
 <alpine.DEB.2.20.1802012045570.29994@hsp>
 <87372jkcu5.fsf@intel.com>
 <alpine.DEB.2.20.1802021054500.13838@hsp>
 <20180202100613.GA21492@kroah.com> <87h8qzisbt.fsf@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87h8qzisbt.fsf@intel.com>
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

On Fri, Feb 02, 2018 at 12:44:38PM +0200, Jani Nikula wrote:
> 
> +Knut, Fengguang
> 
> On Fri, 02 Feb 2018, Greg KH <gregkh@linuxfoundation.org> wrote:
> > 	- If clang now builds the kernel "cleanly", yes, I want to take
> > 	  warning fixes in the stable tree.  And even better yet, if you
> > 	  keep working to ensure the tree is "clean", that would be
> > 	  wonderful.
> 
> So we can run sparse using 'make C=1' and friends, or other static
> analysis tools using 'make CHECK=foo C=1', as long as the passed command
> line params work. There was work by Knut to extend this make checker
> stuff [1]. Since mixing different HOSTCC's in a single workdir seems
> like a bad idea, I wonder how hard it would be to make clang work like
> this:
> 
> $ make CHECK=clang C=1
> 
> Or using Knut's wrapper. Feels like that could increase the use of clang
> for static analysis of patches.

Why not just build with clang itself:
	make CC=clang

thanks,

greg k-h

_______________________________________________
Kernelnewbies mailing list
Kernelnewbies@kernelnewbies.org
https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies
