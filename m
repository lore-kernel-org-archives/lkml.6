Return-Path: <poza@codeaurora.org>
X-Google-Smtp-Source: AG47ELvIBVdIQzl96/DVZ2f24trSFurQCsNn6NKoExVUxZbdRyEFizy2d6D2injxxQr8LRMiuto0
ARC-Seal: i=1; a=rsa-sha256; t=1520868888; cv=none;
        d=google.com; s=arc-20160816;
        b=0TFX276kuxprKl33zIlyc3H7q5V6Un5EXRyf+RiMObmYYUsxzIorIXmpWpVFcb2s/E
         gxX0pkBjTJJlZ7mjwr3dZTNBvoTdBUvGXRzKSslI3WnoiyaPOF+N7v/hthgMBWE/LtLq
         Ap6E5JrOdzJpdymPR2MJdnae/2z8JKiwVdiJ5dDkfiL9RGiLv6wYyhmGFAh1lH/AlaZ4
         NtK20zUk8gtpBbd70MsaNw0lhLMA/A/kc3VaD5MxirEpNaqXSfy6ctFgPYqFH30PvNVF
         8GErjS4iU88hwuhpPXEgMN57S2oziqzMCuUKBkkE57yWbM5H59p7gkG0MRN4As0UMEUE
         oAJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:message-id:references:in-reply-to:subject:cc:to:from
         :date:content-transfer-encoding:mime-version:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=VECrUoFAS86F7iqhgbMuGa3Ga7zFy2uj22cT92w7wWk=;
        b=yqSamq4WG642QzqMcIGE+800HHzOAXN1MD/O7XhpEFz0IiI0topsRvKk1uMivbaftE
         R38g6MnmPfcqekthCZ12YeVLIaUQCE7gxZD2vawOXwqIRlRYJ7dljaqiceAObaa9gVE2
         xq3Bmpa4F5U6hdZ/Nu1Xemh0v9+BiZe8AwQMmCTBZIV+fFuZ+fpK5mYwbuc6mLJNJknA
         PVBwJ9fjzompgSMjx6ZiJqshxaWHqtLMAxH8mBzQXUX3ODB++OR3vAD19Olp94gNm5/B
         CEQArVq+HdAKnlckDZZe1y8i2ujKmGR73dyu01qgtoVIHJFiBnASL/DQ2mxr9W0tbTmA
         GQ/Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=BnzC/yWL;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=BnzC/yWL;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=BnzC/yWL;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=BnzC/yWL;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 12 Mar 2018 21:04:47 +0530
From: poza@codeaurora.org
To: Keith Busch <keith.busch@intel.com>
Cc: Sinan Kaya <okaya@codeaurora.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Philippe Ombredanne
 <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart
 <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>, Wei
 Zhang <wzhang@fb.com>, Timur Tabi <timur@codeaurora.org>,
 linux-pci-owner@vger.kernel.org
Subject: Re: [PATCH v12 0/6] Address error and recovery for AER and DPC
In-Reply-To: <20180312145823.GC18494@localhost.localdomain>
References: <1519837457-3596-1-git-send-email-poza@codeaurora.org>
 <20180311220337.GA194000@bhelgaas-glaptop.roam.corp.google.com>
 <04ade52e-d1ea-fe67-bb26-246621d159e6@codeaurora.org>
 <20180312142551.GB18494@localhost.localdomain>
 <3e1a2036675de6b8456145a022640f3d@codeaurora.org>
 <20180312145823.GC18494@localhost.localdomain>
Message-ID: <eb2810113f98c2ff8201da1a0f827493@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593665102741565714?=
X-GMAIL-MSGID: =?utf-8?q?1594746615328923492?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-03-12 20:28, Keith Busch wrote:
> On Mon, Mar 12, 2018 at 08:16:38PM +0530, poza@codeaurora.org wrote:
>> On 2018-03-12 19:55, Keith Busch wrote:
>> > On Sun, Mar 11, 2018 at 11:03:58PM -0400, Sinan Kaya wrote:
>> > > On 3/11/2018 6:03 PM, Bjorn Helgaas wrote:
>> > > > On Wed, Feb 28, 2018 at 10:34:11PM +0530, Oza Pawandeep wrote:
>> > >
>> > > > That difference has been there since the beginning of DPC, so it has
>> > > > nothing to do with *this* series EXCEPT for the fact that it really
>> > > > complicates the logic you're adding to reset_link() and
>> > > > broadcast_error_message().
>> > > >
>> > > > We ought to be able to simplify that somehow because the only real
>> > > > difference between AER and DPC should be that DPC automatically
>> > > > disables the link and AER does it in software.
>> > >
>> > > I agree this should be possible. Code execution path should be almost
>> > > identical to fatal error case.
>> > >
>> > > Is there any reason why you went to stop driver path, Keith?
>> >
>> > The fact is the link is truly down during a DPC event. When the link
>> > is enabled again, you don't know at that point if the device(s) on the
>> > other side have changed. Calling a driver's error handler for the wrong
>> > device in an unknown state may have undefined results. Enumerating the
>> > slot from scratch should be safe, and will assign resources, tune bus
>> > settings, and bind to the matching driver.
>> >
>> > Per spec, DPC is the recommended way for handling surprise removal
>> > events and even recommends DPC capable slots *not* set 'Surprise'
>> > in Slot Capabilities so that removals are always handled by DPC. This
>> > service driver was developed with that use in mind.
>> 
>> Now it begs the question, that
>> 
>> after DPC trigger
>> 
>> should we enumerate the devices, ?
>> or
>> error handling callbacks, followed by stop devices followed by 
>> enumeration ?
>> or
>> error handling callbacks, followed by enumeration ? (no stop devices)
> 
> I'm not sure I understand. The link is disabled while DPC is triggered,
> so if anything, you'd want to un-enumerate everything below the 
> contained
> port (that's what it does today).
> 
> After releasing a slot from DPC, the link is allowed to retrain. If 
> there
> is a working device on the other side, a link up event occurs. That
> event is handled by the pciehp driver, and that schedules enumeration
> no matter what you do to the DPC driver.

yes, that is what i current, but this patch-set makes DPC aware of error 
handling driver callbacks.

besides, in absence of pciehp there is nobody to do enumeration.

And, I was talking about pci_stop_and_remove_bus_device() in dpc.
if DPC calls driver's error callbacks, is it required to stop the 
devices  ?
