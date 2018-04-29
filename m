Return-Path: <linux@rainbow-software.org>
X-Google-Smtp-Source: AB8JxZpdYJfsIUixy2oq4wToPBVIHoywHd4e2FI9YhKphPa9fee9pprPFlTVQQWMfJcwPFHYygpd
ARC-Seal: i=1; a=rsa-sha256; t=1525032466; cv=none;
        d=google.com; s=arc-20160816;
        b=vw9fBxbrSgbke1Yvv0LQRRtXfkHgzYKVCVNO02+us3ghPsGfufVCA0sTsqStiDPSVz
         kk6gvz6s/jhIF2MDe4hUVPRzWuEpT6cI8aF2SmUg33e7KzUwUJ4i3126dvXWLSEFXmwm
         oIyEO0441vdVmR36qI+pCMPlGNoCUSob9fOJr0hY5P2JSCieI35I5NGEjrH0zHkMKEBN
         BqDKTfHlU/UYaiu4VmFnlWQ4B4fKy++jjXf+R4TdL22fdibkvHd5AZRhayWI6nrMIpFZ
         ROgQ9ZdqXNHjAw+h4jiF6lWeqXkNr5UovLaPev7VuV+dIgxx9fiOkm22HC0up6xzii/G
         1AJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-disposition:content-transfer-encoding
         :mime-version:in-reply-to:references:cc:user-agent:date:subject:to
         :from:dkim-signature:arc-authentication-results;
        bh=T74J2whe8V7AZI99fSppWBh9yXd6reSQpUtyFyyKI74=;
        b=ZE2S7/4sXHssI83YG6xSLXFieP0lred8NMr1ZrWH86OOJSKgDmALIhJyQFuPvIbH+u
         VO3JFLUK1ruiCKlFFA+iZnDSZhDfO/ACvfJqEPqwGynXGZ8y/P/cbf57YOSeAz+1t/gP
         H5Yy+8z1wzWJOscqc/n6Vr+XdBGiEXgo9TwfdPRtThvFKE/AqsKBxtRZoL6pDVH4BEuM
         kgk7pg8hWhIayat8SQtsFewpgpQqLxq1NvjVX5UuZZjJVWZFKi0SMOYnnEhAOWBtFc/Y
         14R/wHMAZFWTbl/OpymfGwF+R9m/syH7xOrNd5KKPBD3LjdbgQlbz0y/8gQJwFnn9j5+
         XWpg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=temperror (no key for signature) header.i=@rainbow-software.org header.s=atlsmtp header.b=HZ/3vIPp;
       spf=pass (google.com: domain of linux@rainbow-software.org designates 80.94.52.26 as permitted sender) smtp.mailfrom=linux@rainbow-software.org
Authentication-Results: mx.google.com;
       dkim=temperror (no key for signature) header.i=@rainbow-software.org header.s=atlsmtp header.b=HZ/3vIPp;
       spf=pass (google.com: domain of linux@rainbow-software.org designates 80.94.52.26 as permitted sender) smtp.mailfrom=linux@rainbow-software.org
From: Ondrej Zary <linux@rainbow-software.org>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Moving unmaintained filesystems to staging
Date: Sun, 29 Apr 2018 22:07:26 +0200
User-Agent: KMail/1.9.10 (enterprise35 0.20100827.1168748)
Cc: Pavel Machek <pavel@ucw.cz>,
 Matthew Wilcox <willy@infradead.org>,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20180425154602.GA8546@bombadil.infradead.org> <20180426061108.GB4977@amd> <20180429120705.GA18149@kroah.com>
In-Reply-To: <20180429120705.GA18149@kroah.com>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201804292207.26775.linux@rainbow-software.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1599112443844355668?=
X-GMAIL-MSGID: =?utf-8?q?1599112443844355668?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sunday 29 April 2018 14:07:05 Greg KH wrote:
> On Thu, Apr 26, 2018 at 08:11:08AM +0200, Pavel Machek wrote:
> > On Wed 2018-04-25 08:46:02, Matthew Wilcox wrote:
> > > Recently ncpfs got moved to staging.  Also recently, we had some fuzzer
> > > developers report bugs in hfs, which they deem a security hole because
> > > Ubuntu attempts to automount an inserted USB device as hfs.
> >
> > We promise "no-regressions" for code in main repository, no such
> > promise for staging. We have quite a lot of code without maintainer.
> >
> > Moving code to staging means it will get broken -- staging was not
> > designed for this. I believe moving anything there is bad idea.
> >
> > Staging is for ugly code, not for code that needs new maintainter.
>
> Staging is used for getting code _out_ of the kernel tree as well as
> _in_.  We use it all the time to move code there, see if anyone shows up
> in 6-8 months to say "I will fix this!", and if not, we delete it.
>
> Look at what just happened to IRDA in the 4.17-rc1 release as an example
> of this.

Really a "great" example of deleting working code :( 

-- 
Ondrej Zary
