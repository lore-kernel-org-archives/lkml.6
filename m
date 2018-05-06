Return-Path: <amit@amitshah.net>
X-Google-Smtp-Source: AB8JxZr2qgC4UUPsLnqDEnW1MXxUCZbEra7dsBaAhC9sizY12hVWtKV8K7L9bLEAISS/hBndhGi4
ARC-Seal: i=1; a=rsa-sha256; t=1525631073; cv=none;
        d=google.com; s=arc-20160816;
        b=Q18J8h9pDoMRYzXohtDLdfjezOiBg83bp+HRUziDedfJoEx/KK8r0RIwegcgIo+UVp
         rGiQ6+YwpA+WYPgfh8Zy1/1eW6M2Eo1oQNGiXCwCVujk4GnOobyuEXdl2hnPdetI21GV
         HvSyK/ta/tQncrShiQJJBfe+TX7CSnndIiHH+VuEvIrN2/54x/ndrUOrje2vXiw6QeFE
         VvpTBpkXFeDWvOk9YQ6oLd7gB7R2K3QCtfj8juCHHJZo9t2HLwCP3wafRL9Dy7Ek2a7R
         To1yZ8nWkWPPP6oq4+OtmATLsLPE0L9QvZ3U/zZJk53vFCDv+pycIbapz91qsf1bmyb5
         +19w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:arc-authentication-results;
        bh=TmKdTwdPE8FraUrrUSpvK7p0n0j75/1Tb93vNA8uxpo=;
        b=KVQg3GwLLCLTq97FtCS12YldQCII9mJra4ZAzn7oW6n3XPlXmjFa9ZUDp8XlvG1H4C
         quLJ1pyMXesDub8jsQhDZPMr/Dohh2szwhUnMaiCTtW0OT0iHtCw5UpTh0Se7NPdg81q
         ewN+7qOVUK+pvCDNapkwKjw6Z7Gz6CcrWQFsoiozKDGIgkUi8ULYD+Nbj9d0gQU4t3QJ
         zQFNTyCk6i8Q68v5Mhee/nK9AXD7RWMrqvhkqz0+jSjCMQo0WyDr+HPjO2eqLrCVkSso
         6iHjoYJCL4HMzdJefpV8br0InJEJcHJ3PLXawWagtVmZrJkrlEXYxJkqcFWY5VPDva0N
         0o7A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of amit@amitshah.net designates 217.70.178.230 as permitted sender) smtp.mailfrom=amit@amitshah.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of amit@amitshah.net designates 217.70.178.230 as permitted sender) smtp.mailfrom=amit@amitshah.net
Date: Sun, 6 May 2018 20:24:30 +0200
From: Amit Shah <amit@amitshah.net>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	virtualization@lists.linux-foundation.org, stable@vger.kernel.org,
	Tiwei Bie <tiwei.bie@intel.com>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 0/6] virtio-console: spec compliance fixes
Message-ID: <20180506182430.GB19628@grmbl.mre>
References: <1524248223-393618-1-git-send-email-mst@redhat.com>
 <20180424214104-mutt-send-email-mst@kernel.org>
 <20180503034529.GA16676@grmbl.mre>
 <20180503222702-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180503222702-mutt-send-email-mst@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598290166308217501?=
X-GMAIL-MSGID: =?utf-8?q?1599740128541729529?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On (Thu) 03 May 2018 [22:28:32], Michael S. Tsirkin wrote:
> On Thu, May 03, 2018 at 05:45:29AM +0200, Amit Shah wrote:
> > (apologies if you received a dup)
> > 
> > On (Tue) 24 Apr 2018 [21:41:29], Michael S. Tsirkin wrote:
> > > On Fri, Apr 20, 2018 at 09:17:59PM +0300, Michael S. Tsirkin wrote:
> > > > Turns out virtio console tries to take a buffer out of an active vq.
> > > > Works by sheer luck, and is explicitly forbidden by spec.  And while
> > > > going over it I saw that error handling is also broken -
> > > > failure is easy to trigger if I force allocations to fail.
> > > > 
> > > > Lightly tested.
> > > 
> > > Amit - any feedback before I push these patches?
> > 
> > The changes look good spec-wise.
> > 
> > There are a bunch of tests in avocado-vt that test virtio-console
> > functionality.  Can you give those a try before pushing?
> > 
> > 		Amit
> 
> I pushed before I did that test, will try to find the time later.  BTW
> do you still want to be on the maintainers list?

Yes, I want to be on the maintainers list; but won't mind
co-maintainers.  The recent changes seem to be spec-related, and I'd
expect you to have a good handle on that anyway.

		Amit
-- 
http://amitshah.net/
