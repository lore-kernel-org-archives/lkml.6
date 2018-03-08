Return-Path: <kernel-hardening-return-12272-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELt32e9ALwVomUHqgwniqorg7h22I8Nj3ky+fZTnPyar9FVg4E/1Y7yIrL8Q9o1bsfzNPSPS
ARC-Seal: i=1; a=rsa-sha256; t=1520547356; cv=none;
        d=google.com; s=arc-20160816;
        b=q1eVa68VCNNrwwaO0ZXgfMxxkZrTXW9bdN2wlMXtiwhCNzXrpIFHDHAr+szySfiq9D
         h5jYBQ4hneluBqrbWXRoJLvchs6Py8GiDdlXRxcubi6IB0lY28H8usTYOxx6iP+2yR2V
         MEOxjs40aOipn3XrIbh0eYbWvikONb0jvV1//MQ7xpc8OLzydkAgqB5lN5YPPKPtLznM
         /r7/oiiEWvryYdvfIkMqWVRvwIEY6yKPQb5swXZecnJmJf21J1gfTRZ5dP2A1q845Sl7
         J/mTe1nStymglaJMLWFR7oa1MEu8hnQOFbeHxgj0/aClbashunTjNhjcoVxq7rlQyKAi
         o3rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=iH31cBqhWWmEo7Z4NNAWvHONPjKh8LUpNCnGC+pTotQ=;
        b=U31xw3QMfkebo3eOwIhn2CckurQrJZJ0Vq7i0e6JQtXD2+cBn/CxpWKnnxfeQvqw60
         h8aowu5H+s0cFA6LDE3i9+Ll5dtUlPeqB8w5f38kuu1V1lJH8TTEAomvytdOlAe2uNz9
         zOiQzc0ziS0wE4WJa6o1pByq5vy/IIsozDnX+DbqP+lzu6ovC6vhgPPUPw26X95xM1Qf
         8q8PIQu6azL1Q+qSjr41W/EI6eBylVHzXfeoGxPX+fHzIHVVejdEvkddRPWHUACgQ4Qk
         Uxq2jHZ76UJRaM72EXXMbC1kX7t6X2K0+e7FTzFU37GI/MU4QwpCzHLQQaw5pukYXFra
         Fvfw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tycho-ws.20150623.gappssmtp.com header.s=20150623 header.b=llH8ie0m;
       spf=pass (google.com: domain of kernel-hardening-return-12272-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12272-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tycho-ws.20150623.gappssmtp.com header.s=20150623 header.b=llH8ie0m;
       spf=pass (google.com: domain of kernel-hardening-return-12272-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12272-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Thu, 8 Mar 2018 15:15:37 -0700
From: Tycho Andersen <tycho@tycho.ws>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v2] ima: drop vla in ima_audit_measurement()
Message-ID: <20180308221537.46ogqx64cev767ur@smitten>
References: <20180308202347.31331-1-tycho@tycho.ws>
 <1520541374.3605.101.camel@linux.vnet.ibm.com>
 <20180308214547.kdeoeozugxffzumn@smitten>
 <1520546740.3605.124.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1520546740.3605.124.camel@linux.vnet.ibm.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594402547592935810?=
X-GMAIL-MSGID: =?utf-8?q?1594409465421160763?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Mimi,

On Thu, Mar 08, 2018 at 05:05:40PM -0500, Mimi Zohar wrote:
> On Thu, 2018-03-08 at 14:45 -0700, Tycho Andersen wrote:
> > Hi Mimi,
> > 
> > On Thu, Mar 08, 2018 at 03:36:14PM -0500, Mimi Zohar wrote:
> > > On Thu, 2018-03-08 at 13:23 -0700, Tycho Andersen wrote:
> > > 
> > > >  /*
> > > > diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> > > > index 2cfb0c714967..356faae6f09c 100644
> > > > --- a/security/integrity/ima/ima_main.c
> > > > +++ b/security/integrity/ima/ima_main.c
> > > > @@ -288,8 +288,11 @@ static int process_measurement(struct file *file, char *buf, loff_t size,
> > > >  					      xattr_value, xattr_len, opened);
> > > >  		inode_unlock(inode);
> > > >  	}
> > > > -	if (action & IMA_AUDIT)
> > > > -		ima_audit_measurement(iint, pathname);
> > > > +	if (action & IMA_AUDIT) {
> > > > +		rc = ima_audit_measurement(iint, pathname);
> > > > +		if (rc < 0)
> > > > +			goto out_locked;
> > > > +	}
> > > > 
> > > >  	if ((file->f_flags & O_DIRECT) && (iint->flags & IMA_PERMIT_DIRECTIO))
> > > >  		rc = 0;
> > > 
> > > Only when IMA-appraisal is enforcing file data integrity should
> > > process_measurement() ever fail.  Other errors can be logged/audited.
> > 
> > Ok, so previously in ima_audit_measurement() when allocation failed,
> > there was nothing logged. If we just keep this behavior like below,
> > does that look good?
> 
> Before the IMA locking change that were just upstreamed, there were
> problems with measuring/appraising files that were opened with the
> O_DIRECT flag.  Unless the IMA policy specified permit_directio, the
> measurement/appraisal failed.  With the new locking, opening files
> with the O_DIRECTIO flag shouldn't be a problem.  It just needs to be
> fully tested before removing this code.
> 
> On failure, the code below tests the ima_audit_measurement() result
> and skips the IMA_PERMIT_DIRECTIO test.  Unless I'm missing something,
> I don't see the point.

It skips the IMA_PERMIT_DIRECTIO test because it's already going to
fail: we're in enforce mode and we got an allocation failure and so we
can't audit this access (note: there is another allocation failure in
ima_audit_measurement() which is still ignored after this patch, so
maybe ignoring failures is ok; seems like it's not, though).

I'm not sure I really understand the rest of your message though. Can
you suggest what the patch should do here? Should we just ignore all
failures as before?

Tycho
