Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C4A7FC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 21:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80A722086D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 21:20:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80A722086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=thebollingers.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934562AbeFKVUY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 17:20:24 -0400
Received: from resqmta-po-09v.sys.comcast.net ([96.114.154.168]:53902 "EHLO
        resqmta-po-09v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934487AbeFKVUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 17:20:19 -0400
Received: from resomta-po-03v.sys.comcast.net ([96.114.154.227])
        by resqmta-po-09v.sys.comcast.net with ESMTP
        id SU1PfpQ4dv8ZOSUEcfVhUX; Mon, 11 Jun 2018 21:20:18 +0000
Received: from thebollingers.org ([73.223.250.230])
        by resomta-po-03v.sys.comcast.net with ESMTPA
        id SUEZfGLqvbew8SUEafpaUd; Mon, 11 Jun 2018 21:20:18 +0000
Date:   Mon, 11 Jun 2018 14:01:04 -0700
From:   Don Bollinger <don@thebollingers.org>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, brandon_chuang@edge-core.com,
        wally_wang@accton.com, roy_lee@edge-core.com,
        rick_burchett@edge-core.com, quentin.chang@quantatw.com,
        steven.noble@bigswitch.com, jeffrey.townsend@bigswitch.com,
        scotte@cumulusnetworks.com, roopa@cumulusnetworks.com,
        David Ahern <dsa@cumulusnetworks.com>,
        luke.williams@canonical.com, Guohan Lu <gulv@microsoft.com>,
        Xin Liu <xinxliu@microsoft.com>, steve.joiner@finisar.com
Subject: Re: [PATCH] optoe: driver to read/write SFP/QSFP EEPROMs
Message-ID: <20180611210104.cdmzcdexkyte4klz@thebollingers.org>
References: <20180611042515.ml6zbcmz6dlvjmrp@thebollingers.org>
 <496e06b9-9f02-c4ae-4156-ab6221ba23fd@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <496e06b9-9f02-c4ae-4156-ab6221ba23fd@amd.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CMAE-Envelope: MS4wfG7gzwhdNJqL9rWuU6JU7dvc49A8+3BetSqFx+Xx28pWry6rXoZxbKHoAvQAj29TqNECvc1zrX1g5Yy67ENSXqyOt+eaNsj8sJTvOO551x7dn9kDPk2m
 +wO3sUDNthnlfhoIbyfjHYKfXhlgJZ2vWHh070eNISrrMFL95bQLaqIciAcwct34oyxX7/y5CVCcZ6IpID7UKppHcsxvi541AwuQCiiMT8/WKd4FmRdzQRqj
 /yQpeGHXBF/cNbT7b0ixLB51UarY2LU+AmAYKYmzV6pxCsA92yvpDc4J26GL6KikONYZ7FSNabRF8KuZxU6LRLvceKcJk5HtH5OKQ+TX2+8rqhOYuacvaau7
 GXnFnnoknk8T4y2n7jKlW6ov5u3g6z15wPdhwsos6IYlRBYFDO9eBhHvHFRrqHRYBX8lCagAhQ0O6kmhq0zZvg2F8SZxtvXkw3wO+f9Gt4gYcF8bh+yIfld4
 rNJkb/+dkRrhg392ALQVF1g8rrKPNYB2YHwYaMwMRlHzrk9L4R8W8wjY3hxrTqpkXHGVnp1y11Slaf5hrC9MBhVolCZwrwK5QnDyqJMQOfR6gCigFRCvl96N
 BKXy3/gS7CMxx2Nch8cTqZernE7WjFrFblemFtt/9sUT+P3K+aevrgQRYmstlgOg0e2DVmwkFTImA3+r8E6udz58cHgZDh0pJQXdOb5PvViuCfVbw0mz6vTh
 9WDdqD4Atd3UEy4/0fmHiVxQd684BLAHjf+fXXPiH1jfKSh7FarLP85PlH7cYiVjzseyCA7simdJESvp3hocVg+D0O79UWLXXH1K+6FJlCUpQyMOZTHG5Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 01:33:07PM -0500, Tom Lendacky wrote:
> On 6/10/2018 11:25 PM, Don Bollinger wrote:
> > optoe is an i2c based driver that supports read/write access to all
> > the pages (tables) of MSA standard SFP and similar devices (conforming
> > to the SFF-8472 spec) and MSA standard QSFP and similar devices
> > (conforming to the SFF-8436 spec).
> > 
> > These devices provide identification, operational status and control
> > registers via an EEPROM model. These devices support one or 3 fixed
> > pages (128 bytes) of data, and one page that is selected via a page
> > register on the first fixed page.  Thus the driver's main task is
> > to map these pages onto a simple linear address space for user space
> > management applications.  See the driver code for a detailed layout.
> > 
> > EEPROM data is accessible via a bin_attribute file called 'eeprom',
> > e.g. /sys/bus/i2c/devices/24-0050/eeprom.
> > 
> > Signed-off-by: Don Bollinger <don@thebollingers.org>
> > ---
> > 
> > Why should this driver be in the Linux kernel?  SFP and QSFP devices plug
> > into switches to convert electrical to optical signals and drive the
> > optical signal over fiber optic cables.  They provide status and control
> > registers through an i2c interface similar to to other EEPROMS.  However,
> > they have a paging mechanism that is unique, which requires a different
> > driver from (for example) at24.  Various drivers have been developed for
> > this purpose, none of them support both SFP and QSFP, provide both read
> > and write access, and access all 256 architected pages.  optoe does all
> > of these.
> > 
> > optoe has been adopted and is shipping to customers  as a base module,
> > available to all platforms (switches) and used by multiple vendors and
> > platforms on both ONL (Open Network Linux) and SONiC (Microsoft's
> > 'Software for Open Networking in the Cloud').
> > 
> > This patch has been built on the latest staging-testing kernel.  It has
> > built and tested with SFP and QSFP devices on an ARM platform with a 4.9
> > kernel, and an x86 switch with a 3.16 kernel.  This patch should install
> > and build clean on any kernel from 3.16 up to the latest (as of 6/10/2018).
> > 
> > 
> >  Documentation/misc-devices/optoe.txt |   56 ++
> >  drivers/misc/eeprom/Kconfig          |   18 +
> >  drivers/misc/eeprom/Makefile         |    1 +
> >  drivers/misc/eeprom/optoe.c          | 1141 ++++++++++++++++++++++++++++++++++
> >  4 files changed, 1216 insertions(+)
> >  create mode 100644 Documentation/misc-devices/optoe.txt
> >  create mode 100644 drivers/misc/eeprom/optoe.c
> > 
> 
> There's an SFP driver under drivers/net/phy.  Can that driver be extended
> to provide this support?  Adding Russel King who developed sfp.c, as well
> at the netdev mailing list.
> 
> Thanks,
> Tom

I don't think that would work very well.  It's software, anything is
possible, but...

sfp.c appears to be working with mdio, gpio and 'sfp_bus', in addition
to i2c.  optoe only access the EEPROM, and only via i2c.  The linux
standard i2c interfaces are the only dependencies for optoe.

Also, sfp.c does not support QSFP (best I can tell), and it does not
support additional pages beyond the 256 bytes at i2c address 0x50 and
0x51.

Best I can tell, sfp.c supports SFP devices on NIC cards.  Those cards
have a very different hardware architecture from the network switches
that optoe is targeting.
