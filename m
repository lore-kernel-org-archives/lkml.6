Return-Path: <mst@redhat.com>
X-Google-Smtp-Source: AB8JxZrwh1+TYvSdtDCMTyPnviJthBXoBQfl/PbbznSXW+twsLNieRWDqZ3FyzqsRWb1FWAu5bdi
ARC-Seal: i=1; a=rsa-sha256; t=1525375713; cv=none;
        d=google.com; s=arc-20160816;
        b=Vru7SPuz6BzilZAfXZcegbCp4jlFKkQWPcGjbVHOHcDzS8XbcJc384F+9cAY9A8VGW
         XcoMu4INjgqyF/CV6owUHKL74poqJShj0ACeDeFusfBw8TmICfd5CqlFhXTrZ0Yavl78
         HroQde/r5WthH4UibpXnV5tT1L8bbxIeRIWF1B4OGH3pkUYTfPnS6HsBMFYWduHxMJwZ
         /L36fClgMu+V5uhzf4DPHEgZRqmD/yBxcAUDh/VUC26oDSFY6sRVUv5kJX5VzZ62ziW6
         zkyqDaeu6wVTkG5M51b/tn+LdNR9R/hAASKf2BT480eb1PoeHctAzaNI8PI2cJFzcVI2
         qAug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:arc-authentication-results;
        bh=6shUN1+gCJjg0eJDuX2f1aCr0hZOV/T3neK4/6Y0pL0=;
        b=SldfV9MTvq3LIYKXIwU8ZlHb185W9B7+ChwLQELtnAkRpe6r+nMWWBhJydD61Cfuqx
         ZCoJmGkctG+kdfGhvFWGsvVsT8n9yaOTuWNoeUjIwR2nwT58FfhYufEkQUKyKb8lD9wX
         ZvnCX6Nc1D9CmqMrglxDWZZ/YuWwdM319UljVjBbbYxoaMVbMQ/QU+A9YDi1c8Ntj+Eg
         nmf29vDp4zWXzbxqk/tujEPHu3wEymoooA/1tib64uyFOpCmIg5ZFi2Q+lztan6qkVGm
         aaIlALwEGQYonmQ2Gq3O0bgzmUZgcnZ2ljdmZQR+LQRLM8Hcecj4JqEYXvm5/2VAXYD+
         jbYQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of mst@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=mst@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of mst@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=mst@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Date: Thu, 3 May 2018 22:28:32 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Amit Shah <amit@amitshah.net>
Cc: linux-kernel@vger.kernel.org, Amit Shah <amit@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	virtualization@lists.linux-foundation.org, stable@vger.kernel.org,
	Tiwei Bie <tiwei.bie@intel.com>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 0/6] virtio-console: spec compliance fixes
Message-ID: <20180503222702-mutt-send-email-mst@kernel.org>
References: <1524248223-393618-1-git-send-email-mst@redhat.com>
 <20180424214104-mutt-send-email-mst@kernel.org>
 <20180503034529.GA16676@grmbl.mre>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180503034529.GA16676@grmbl.mre>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598290166308217501?=
X-GMAIL-MSGID: =?utf-8?q?1599472364676411024?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 03, 2018 at 05:45:29AM +0200, Amit Shah wrote:
> (apologies if you received a dup)
> 
> On (Tue) 24 Apr 2018 [21:41:29], Michael S. Tsirkin wrote:
> > On Fri, Apr 20, 2018 at 09:17:59PM +0300, Michael S. Tsirkin wrote:
> > > Turns out virtio console tries to take a buffer out of an active vq.
> > > Works by sheer luck, and is explicitly forbidden by spec.  And while
> > > going over it I saw that error handling is also broken -
> > > failure is easy to trigger if I force allocations to fail.
> > > 
> > > Lightly tested.
> > 
> > Amit - any feedback before I push these patches?
> 
> The changes look good spec-wise.
> 
> There are a bunch of tests in avocado-vt that test virtio-console
> functionality.  Can you give those a try before pushing?
> 
> 		Amit

I pushed before I did that test, will try to find the time later.  BTW
do you still want to be on the maintainers list?

> -- 
> http://amitshah.net/
