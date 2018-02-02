Return-Path: <ruben@mrbrklyn.com>
X-Cyrus-Session-Id: sloti22d1t05-2618836-1517582024-2-18030208416108508896
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, SPF_HELO_PASS -0.001, SPF_PASS -0.001,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='96.57.23.82', Host='www2.mrbrklyn.com', Country='US', FromHeader='com',
  MailFrom='com'
X-Spam-charsets: cc='iso-8859-1', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: ruben@mrbrklyn.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517582023; b=WxXIt6iO941e6/CqLm42K28cqxduUtoUVeU650DQHPAEDdE
    Ly7j1jvoAI/T8YtcQtKd+Yk28ciIBAIjM3gDNPtBgumniFbADtJtB/hmM0dPbcim
    /nCfK/FFF7EwwaoHnhbnXjytsG25D3+5s3pr1d6VVExkrl71JsaNc70WL7poUQDj
    eeooze+34EoeAwh+W1KmMAsSBWvCH/cqVuBGM6gXM7Qv/LyJMhGuFyG6JG7gxM/H
    9YlYt7A8Uwj74qDsPpm+dYpJ0L15FCBseJMdw/4W85ZJftPLL+uU322D/WJLH1ik
    +7OrkDKlXUJsoHqJW4NmppjbpbDZ0BKvcgXTi/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to; s=arctest; t=
    1517582023; bh=4iZ1NPEluXgnc9leGqNtxy750ERFfFXhggbUPuTaVZw=; b=H
    kFA7z5JNbaVWV07G93CmWTQjmWI7d7ZCbOpsnUmy/8nPTVLPKGIqN9Lq4VnEPmFe
    L4seASn9LhBepUg2sM5wI+/X/6P8sE3UCzkgH5UliJbvnSC90VtDtvu3ZsZs0j+X
    qTLJ/k6VVLWa6ixw5t3QfpweMoC0nbKlWPACBBgEHhCFmECS5xVuY9ImoalhH9ps
    +EGGarW3cZwRXBEBZugCgTS+8ZM0pTq32qqW+/ANXyWfK0gSqpN5MCrMXCgEXSX/
    GgY/qzuHZGeb8r5w2HKWSx/tc8DQ5m37HCIa6DhQ+Ni8KDj5mkADr3YKK/U8RACz
    PjeMvAA0Mvocn+lhVkoCw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=mrbrklyn.com;
    iprev=pass policy.iprev=96.57.23.82 (www2.mrbrklyn.com);
    spf=pass smtp.mailfrom=ruben@mrbrklyn.com smtp.helo=mrbrklyn.com;
    x-aligned-from=pass;
    x-ptr=fail x-ptr-helo=mrbrklyn.com x-ptr-lookup=www2.mrbrklyn.com;
    x-return-mx=pass smtp.domain=mrbrklyn.com smtp.result=pass smtp_is_org_domain=yes header.domain=mrbrklyn.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=mrbrklyn.com;
    iprev=pass policy.iprev=96.57.23.82 (www2.mrbrklyn.com);
    spf=pass smtp.mailfrom=ruben@mrbrklyn.com smtp.helo=mrbrklyn.com;
    x-aligned-from=pass;
    x-ptr=fail x-ptr-helo=mrbrklyn.com x-ptr-lookup=www2.mrbrklyn.com;
    x-return-mx=pass smtp.domain=mrbrklyn.com smtp.result=pass smtp_is_org_domain=yes header.domain=mrbrklyn.com header.result=pass header_is_org_domain=yes
Date: Fri, 2 Feb 2018 09:33:39 -0500
From: Ruben Safir <ruben@mrbrklyn.com>
To: Greg KH <greg@kroah.com>
Cc: Ozan Alpay <ozyalpy@gmail.com>, sil2review@lists.osadl.org,
	kernelnewbies@kernelnewbies.org, David Airlie <airlied@linux.ie>,
	intel-gfx@lists.freedesktop.org,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	llvmlinux@lists.linuxfoundation.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>, lukas.bulwahn@gmail.com,
	Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Subject: Re: clang warning: implicit conversion in intel_ddi.c:1481
Message-ID: <20180202143339.GA769@www2.mrbrklyn.com>
References: <alpine.DEB.2.20.1802011823340.4316@alpaca>
 <20180201180240.GA28042@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180201180240.GA28042@kroah.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> 
> What is the goal of these types of emails?
> 

even more so on this mailing list.  It almost feels like guerilla
advertising for Clang.


> thanks,
> 
> greg k-h
> 
> _______________________________________________
> Kernelnewbies mailing list
> Kernelnewbies@kernelnewbies.org
> https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies

-- 
So many immigrant groups have swept through our town
that Brooklyn, like Atlantis, reaches mythological
proportions in the mind of the world - RI Safir 1998
http://www.mrbrklyn.com 

DRM is THEFT - We are the STAKEHOLDERS - RI Safir 2002
http://www.nylxs.com - Leadership Development in Free Software
http://www2.mrbrklyn.com/resources - Unpublished Archive 
http://www.coinhangout.com - coins!
http://www.brooklyn-living.com 

Being so tracked is for FARM ANIMALS and and extermination camps, 
but incompatible with living as a free human being. -RI Safir 2013
