Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02339C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 06:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98CC620693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 06:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lcksVhzn";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JKs+voeN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98CC620693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756045AbeFSGD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 02:03:58 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45084 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750739AbeFSGD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 02:03:56 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D7AAB60714; Tue, 19 Jun 2018 06:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529388235;
        bh=8XOy0a3mb06c4MblZeMCBP+AqbQHUx4tq0eT23iXBBo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lcksVhzn3aZNi5UayAn9U01t419jAMEfyWN6PaytshGmDr3KRpzRg6UdyKG126u92
         sBGTrAtArZjqwRELsUzcob+ssl4FPqNRLjqC1RC7oAjTrAW18GrQQpoKxaANwEMCbl
         mk6FKoK3uBlmSuKmBNuDVHjvef4j7eTZ5eorAy1I=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id BCFC660714;
        Tue, 19 Jun 2018 06:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529388233;
        bh=8XOy0a3mb06c4MblZeMCBP+AqbQHUx4tq0eT23iXBBo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JKs+voeNfBniexd4ftdG85HDNSdsuWE2qZzNkEyx9RwQ0uTWZZlCTwLNeFxL+A7Ks
         3VeipqSPXIx0WUruxDhhe/q6Jg81PChTTPpJ34VgKUzO0WZv3Utp4fpkS4CgI+pn45
         uGgDCTUUXbyfpp4PGb6k4iPl514M6SLDdsqw+GbY=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 19 Jun 2018 11:33:53 +0530
From:   poza@codeaurora.org
To:     Rajat Jain <rajatja@google.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frederick Lawler <fred@fredlawl.com>,
        "Busch, Keith" <keith.busch@intel.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Thomas Tai <thomas.tai@oracle.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-pci <linux-pci@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jes Sorensen <jsorensen@fb.com>, Kyle McMartin <jkkm@fb.com>,
        Rajat Jain <rajatxjain@gmail.com>
Subject: Re: [PATCH v2 5/5] Documentation/ABI: Add details of PCI AER
 statistics
In-Reply-To: <CACK8Z6EHDv0d5zwgKj2N+DyxKEj9dVkSoN2Y_HTOKv8L9p-OAg@mail.gmail.com>
References: <20180522222805.80314-1-rajatja@google.com>
 <20180523175808.28030-1-rajatja@google.com>
 <20180523175808.28030-6-rajatja@google.com>
 <c27290dd401bb2954db4959559c39a00@codeaurora.org>
 <CACK8Z6EHDv0d5zwgKj2N+DyxKEj9dVkSoN2Y_HTOKv8L9p-OAg@mail.gmail.com>
Message-ID: <7e146f62d1fa82a6f37848b22efc1b97@codeaurora.org>
X-Sender: poza@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-19 05:41, Rajat Jain wrote:
> Hello,
> 
> On Sat, Jun 16, 2018 at 10:24 PM <poza@codeaurora.org> wrote:
>> 
>> On 2018-05-23 23:28, Rajat Jain wrote:
>> > Add the PCI AER statistics details to
>> > Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
>> > and provide a pointer to it in
>> > Documentation/PCI/pcieaer-howto.txt
>> >
>> > Signed-off-by: Rajat Jain <rajatja@google.com>
>> > ---
>> > v2: Move the documentation to Documentation/ABI/
>> >
>> >  .../testing/sysfs-bus-pci-devices-aer_stats   | 103 ++++++++++++++++++
>> >  Documentation/PCI/pcieaer-howto.txt           |   5 +
>> >  2 files changed, 108 insertions(+)
>> >  create mode 100644
>> > Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
>> >
>> > diff --git a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
>> > b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
>> > new file mode 100644
>> > index 000000000000..f55c389290ac
>> > --- /dev/null
>> > +++ b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
>> > @@ -0,0 +1,103 @@
>> > +==========================
>> > +PCIe Device AER statistics
>> > +==========================
>> > +These attributes show up under all the devices that are AER capable.
>> > These
>> > +statistical counters indicate the errors "as seen/reported by the
>> > device".
>> > +Note that this may mean that if an end point is causing problems, the
>> > AER
>> > +counters may increment at its link partner (e.g. root port) because
>> > the
>> > +errors will be "seen" / reported by the link partner and not the the
>> > +problematic end point itself (which may report all counters as 0 as it
>> > never
>> > +saw any problems).
>> > +
>> > +Where:               /sys/bus/pci/devices/<dev>/aer_stats/dev_total_cor_errs
>> > +Date:                May 2018
>> > +Kernel Version: 4.17.0
>> > +Contact:     linux-pci@vger.kernel.org, rajatja@google.com
>> > +Description: Total number of correctable errors seen and reported by
>> > this
>> > +             PCI device using ERR_COR.
>> > +
>> > +Where:               /sys/bus/pci/devices/<dev>/aer_stats/dev_total_fatal_errs
>> > +Date:                May 2018
>> > +Kernel Version: 4.17.0
>> > +Contact:     linux-pci@vger.kernel.org, rajatja@google.com
>> > +Description: Total number of uncorrectable fatal errors seen and
>> > reported
>> > +             by this PCI device using ERR_FATAL.
>> > +
>> > +Where:               /sys/bus/pci/devices/<dev>/aer_stats/dev_total_nonfatal_errs
>> > +Date:                May 2018
>> > +Kernel Version: 4.17.0
>> > +Contact:     linux-pci@vger.kernel.org, rajatja@google.com
>> > +Description: Total number of uncorrectable non-fatal errors seen and
>> > reported
>> > +             by this PCI device using ERR_NONFATAL.
>> > +
>> > +Where:               /sys/bus/pci/devices/<dev>/aer_stats/dev_breakdown_correctable
>> > +Date:                May 2018
>> > +Kernel Version: 4.17.0
>> > +Contact:     linux-pci@vger.kernel.org, rajatja@google.com
>> > +Description: Breakdown of of correctable errors seen and reported by
>> > this
>> > +             PCI device using ERR_COR. A sample result looks like this:
>> > +-----------------------------------------
>> > +Receiver Error = 0x174
>> > +Bad TLP = 0x19
>> > +Bad DLLP = 0x3
>> > +RELAY_NUM Rollover = 0x0
>> > +Replay Timer Timeout = 0x1
>> > +Advisory Non-Fatal = 0x0
>> > +Corrected Internal Error = 0x0
>> > +Header Log Overflow = 0x0
>> > +-----------------------------------------
>> why hex display ? decimal is easy to read as these are counters.
> 
> Have no particular preference. Since these can be potentially large
> numbers, just had a random thought that hex might make it more
> concise. I can change to decimal if that is preferable.
> 
>> > +
>> > +Where:               /sys/bus/pci/devices/<dev>/aer_stats/dev_breakdown_uncorrectable
>> > +Date:                May 2018
>> > +Kernel Version: 4.17.0
>> > +Contact:     linux-pci@vger.kernel.org, rajatja@google.com
>> > +Description: Breakdown of of correctable errors seen and reported by
>> > this
>> > +             PCI device using ERR_FATAL or ERR_NONFATAL. A sample result
>> > +             looks like this:
>> > +-----------------------------------------
>> > +Undefined = 0x0
>> > +Data Link Protocol = 0x0
>> > +Surprise Down Error = 0x0
>> > +Poisoned TLP = 0x0
>> > +Flow Control Protocol = 0x0
>> > +Completion Timeout = 0x0
>> > +Completer Abort = 0x0
>> > +Unexpected Completion = 0x0
>> > +Receiver Overflow = 0x0
>> > +Malformed TLP = 0x0
>> > +ECRC = 0x0
>> > +Unsupported Request = 0x0
>> > +ACS Violation = 0x0
>> > +Uncorrectable Internal Error = 0x0
>> > +MC Blocked TLP = 0x0
>> > +AtomicOp Egress Blocked = 0x0
>> > +TLP Prefix Blocked Error = 0x0
>> > +-----------------------------------------
>> > +
>> > +============================
>> > +PCIe Rootport AER statistics
>> > +============================
>> > +These attributes showup under only the rootports that are AER capable.
>> > These
>> > +indicate the number of error messages as "reported to" the rootport.
>> > Please note
>> > +that the rootports also transmit (internally) the ERR_* messages for
>> > errors seen
>> > +by the internal rootport PCI device, so these counters includes them
>> > and are
>> > +thus cumulative of all the error messages on the PCI hierarchy
>> > originating
>> > +at that root port.
>> 
>> what about switches and bridges ?
> 
> What about them? AIUI, the switches forward the ERR_ messages from
> downstream devices to the rootport, like they do with standard
> messages. They can potentially generate their own ERR_ message and
> that would be reported no different than other end point devices.


yes, what I meant to ask is; the ERR_FATAL msg coming from EP, can be 
contained by switch
and the error handling code thinks that, the error is contained by 
switch irrespective of
AER or DPC, and it will think that the problem could be with 
Switch/bridge upstream link.

hence the pci_dev of the switch where you should be increment your 
counters.
of course ER_FATAL would have traversed till RP, but that doesnt meant 
that
you account the error there.

> 
>> Also Can you give some idea as e.g what is the difference between
>> dev_total_fatal_errs and rootport_total_fatal_errs  (assuming that 
>> both
>> are same pci_dev.
> 
> For a pci_dev representing the rootport:
> 
> dev_total_fatal_errors = how many times this PCI device *experienced*
> a fatal problem on its own (i.e. either link issues while talking to
> its link partner, or some internal errors).
> 
> rootport_total_fatal_errors = how many times this rootport was
> *informed* about a problem (via ERR_* messages) in the PCI hierarchy
> that originates at it (can be any link further downstream). This
> includes the dev_total_fatal_errors also, because any errors detected
> by the rootport are also "informed" to itself via ERR_* messages. In
> reality, this is just the total number of ERR_FATAL messages received
> at the rootport. This sysfs attribute will only exist for root ports.
> 
>> 
>> rootport_total_fatal_errs gives me an idea that how many times things
>> have been failed under this pci_dev ?
> 
> Yes, as above.
> 
>> which means num of downstream link problems. but I am still trying to
>> make sense as how it could be used,
>> since we dont have BDF information associated with the number of 
>> errors
>> anywhere (except these AER print messages)
>> 
> 
> Agree. That is a limitation. The challenges being more record keeping,
> more complicated sysfs representation, and given that PCI devices may
> come and go, how do we know it is the same device before we collate
> their stats etc.
> 
>> 
>> and dev_total_fatal_errs as you mentioned above that problematic EP,
>> then say root-port will report it and increment
>> dev_total_fatal_errs ++
>> does it also increment root-port_total_fatal_errs ++ in above scenario 
>> ?
> 
> Yes, as above, it will also root-port_total_fatal_errs++ for the root
> port of that hierarchy.
> 
> Thanks,
> 
> Rajat
> 
>> 
>> > +
>> > +Where:               /sys/bus/pci/devices/<dev>/aer_stats/rootport_total_cor_errs
>> > +Date:                May 2018
>> > +Kernel Version: 4.17.0
>> > +Contact:     linux-pci@vger.kernel.org, rajatja@google.com
>> > +Description: Total number of ERR_COR messages reported to rootport.
>> > +
>> > +Where:               /sys/bus/pci/devices/<dev>/aer_stats/rootport_total_fatal_errs
>> > +Date:                May 2018
>> > +Kernel Version: 4.17.0
>> > +Contact:     linux-pci@vger.kernel.org, rajatja@google.com
>> > +Description: Total number of ERR_FATAL messages reported to rootport.
>> > +
>> > +Where:
>> > /sys/bus/pci/devices/<dev>/aer_stats/rootport_total_nonfatal_errs
>> > +Date:                May 2018
>> > +Kernel Version: 4.17.0
>> > +Contact:     linux-pci@vger.kernel.org, rajatja@google.com
>> > +Description: Total number of ERR_NONFATAL messages reported to
>> > rootport.
>> > diff --git a/Documentation/PCI/pcieaer-howto.txt
>> > b/Documentation/PCI/pcieaer-howto.txt
>> > index acd0dddd6bb8..91b6e677cb8c 100644
>> > --- a/Documentation/PCI/pcieaer-howto.txt
>> > +++ b/Documentation/PCI/pcieaer-howto.txt
>> > @@ -73,6 +73,11 @@ In the example, 'Requester ID' means the ID of the
>> > device who sends
>> >  the error message to root port. Pls. refer to pci express specs for
>> >  other fields.
>> >
>> > +2.4 AER Statistics / Counters
>> > +
>> > +When PCIe AER errors are captured, the counters / statistics are also
>> > exposed
>> > +in form of sysfs attributes which are documented at
>> > +Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
>> >
>> >  3. Developer Guide
