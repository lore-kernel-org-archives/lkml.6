Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2237303-1526568288-2-11649113840147296491
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='edu', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526568288; b=N6q9Duj2vwnO0eLDhO4ftmt6T+8ws+Zvu3/1Sp9CIpo5cQI0pL
    w+JuRDXADv1KOiZQPfVYGm5dr32WFAIBEm986ripAOItJ8ClxHiiJT9MAp24+ZCG
    HjgT1B4kxSFQvQGcyFggGS+8XjGRKfo2GIOUfWxLhcb2isKADRK9Vm1cgGh4S6/r
    2fJtW+1XfBE4OLcb+EbxCMKxGb194CTo1oBWVRgvPluwZPv9WG/bAe3fx+eCaavJ
    3dL1RzvBFxtayCXTDe8oD7mhBIyBpS4jZ35gKBivoZiOUx9U9xD80D4xMx74rVqY
    elk+mfITGFex+GslhwJw9Wp+FB5GJ0XVtLIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:mime-version:content-type:sender:list-id; s=fm2; t=
    1526568288; bh=90MchvnVI/kvTZghcvIQLOpIWvspjZgryiqbrGOgDTQ=; b=j
    esOrca5u+n2e9g2u1pKWhxvKd7diwdwYfc6+sfQSbUpFv2G1eMBpnZz3EsexmGdT
    IjXZYruUXg4v1o12al4d7yjJwzLeKTX1Mn06aN+m7msDPVRR3I/E5IjBVOc5NeDp
    9s8C5+naWc2AN5w7HU4DgBW8XMebaG9RaaQAUAj3eTy+081mGcdKslZa0xbaBohc
    pZSUpxdepCKFWAaRL6B2Xnm8GI+m1Yg+ic85uW/2xGLW2e1gbTSPTX01QTNlbzJ3
    2WaUOq+MxGidZECKDHsDTRp4X/ouoJHVL/me4zaN80ZAgTdy93R8rZy8BVmkV+ZN
    bQ6jK3ktVQsBT7/8OV8WA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=rowland.harvard.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=rowland.harvard.edu header.result=pass
    header_org.domain=harvard.edu header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=rowland.harvard.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=rowland.harvard.edu header.result=pass
      header_org.domain=harvard.edu header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfL7xEfnpJ/euwQDSW1n6+z7RZ9NQng0a5uapYeuiLn7Xu33+z3rwyg1aIbsmz31uf353Gz9jjNgp40FMUOBVJzucLfpXzuH9sMc5l4sS4znvjlcO3TcI
    l1I6hPu5dAA3PdH5BdAEvKBJc3VTIIwA1KJh/AFNZ/uU70wXvzu5ykq5kZMHYcE4waWHY7k2X7ik30FcPkGLDzi5v+IkQx91ksxA1deMxUIDkTcmRx4WtO3L
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=fbH23MgRRhzbnx02vHgA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752408AbeEQOob (ORCPT <rfc822;greg@kroah.com>);
        Thu, 17 May 2018 10:44:31 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:51514 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1751649AbeEQOob (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 17 May 2018 10:44:31 -0400
Date: Thu, 17 May 2018 10:44:30 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Alexander Kappner <agk@godking.net>
cc: gregkh@linuxfoundation.org, <linux-usb@vger.kernel.org>,
        <usb-storage@lists.one-eyed-alien.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [usb-storage] Re: [PATCH] usb-storage: Add quirks to make
 G-Technology "G-Drive" work
In-Reply-To: <9c638d96-d2b4-cf19-d7e8-4ef93549bd79@godking.net>
Message-ID: <Pine.LNX.4.44L0.1805171034240.1519-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 17 May 2018, Alexander Kappner wrote:

> Hi Alan,
> 
> thanks for reviewing. (This is my first contribution that touches 
> usb-storage, so please bear with me.)
> 
> > That's kind of weird.  Does the drive work under Windows in UAS mode?  
> 
> On the Windows 10 VM that I just spun up for testing this, access to the 
> drive uses "usbstor.inf" (rather than "uaspstor.sys"). So I believe the 
> answer is no. 
> 
> > If so, why are the WRITE(16) commands failing under Linux?
> 
> I don't know exactly why they're failing, but another entry in the 
> unusual_uas.h shows another SimpleTech device (only with a slightly 
> different product ID) needing the same UAS quirk (see 
> https://bugzilla.redhat.com/show_bug.cgi?id=1124119). So my guess is those 
> drives are just buggy. 

Okay, that's quite possible.

> > That doesn't quite make sense.  Since you prevent the uas driver from 
> > binding to this device, it will end up using usb-storage no matter how 
> > the kernel was built.  Therefore the second quirk flag has to go into 
> > unusual_devs.h no matter what.
> 
> Yes that's what I was trying to get at. So even though the UAS flag would 
> conceptually belong into unusual_uas, I'm putting both into unusual_devs to 
> avoid having to create two separate entries for the same device.
> 
> > You don't describe the second quirk flag at all.  Are you sure it is 
> > needed?
> 
> Yes. Without this flag, the device keeps throwing similar errors on 
> usb-storage. That's the same result I get on a host that doesn't have UAS 
> compiled in. Here's a dmesg:
> 
> [    2.183472] usb 3-1: New USB device found, idVendor=4971, idProduct=8024, bcdDevice=24.03
> [    2.184285] usb 3-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [    2.184980] usb 3-1: Product: G-DRIVE
> [    2.185447] usb 3-1: Manufacturer: HGST
> [    2.185829] usb 3-1: SerialNumber: AA015010004C
> [    2.195509] usb-storage 3-1:1.0: USB Mass Storage device detected
> [    2.198668] Floppy drive(s): fd0 is 2.88M AMI BIOS
> [    2.202981] scsi host2: usb-storage 3-1:1.0
> ...
> [    3.233085] scsi 2:0:0:0: Direct-Access     G-DRIVE                   2403 PQ: 0 ANSI: 6
> [    3.234514] sd 2:0:0:0: Attached scsi generic sg1 type 0
> [    3.235465] sd 2:0:0:0: [sda] Very big device. Trying to use READ CAPACITY(16).
> [    3.236847] sd 2:0:0:0: [sda] 7814037168 512-byte logical blocks: (4.00 TB/3.64 TiB)
> [    3.237794] sd 2:0:0:0: [sda] 4096-byte physical blocks
> [    3.241255] sd 2:0:0:0: [sda] Write Protect is off
> [    3.242096] sd 2:0:0:0: [sda] Mode Sense: 47 00 10 08
> [    3.243595] sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, supports DPO and FUA
> [    3.257893]  sda: sda1 sda9
> [    3.261402] sd 2:0:0:0: [sda] Attached SCSI disk
> ...
> [   92.433428] sd 2:0:0:0: [sda] tag#0 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
> [   92.434759] sd 2:0:0:0: [sda] tag#0 Sense Key : Illegal Request [current] 
> [   92.435637] sd 2:0:0:0: [sda] tag#0 Add. Sense: Invalid field in cdb
> [   92.436401] sd 2:0:0:0: [sda] tag#0 CDB: Write(16) 8a 08 00 00 00 00 00 00 00 00 00 00 00 08 00 00
> [   92.437493] print_req_error: critical target error, dev sda, sector 0
> [   92.438211] Buffer I/O error on dev sda, logical block 0, lost sync page write
> [   92.516692] EXT4-fs (sda): mounted filesystem with ordered data mode. Opts: (null)
> [  101.449311] sd 2:0:0:0: [sda] tag#0 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
> [  101.450598] sd 2:0:0:0: [sda] tag#0 Sense Key : Illegal Request [current] 
> [  101.451401] sd 2:0:0:0: [sda] tag#0 Add. Sense: Invalid field in cdb
> [  101.452041] sd 2:0:0:0: [sda] tag#0 CDB: Write(16) 8a 08 00 00 00 00 e8 c4 00 18 00 00 00 08 00 00
> [  101.452906] print_req_error: critical target error, dev sda, sector 3905159192
> [  101.453593] print_req_error: critical target error, dev sda, sector 3905159192
> [  101.454889] Aborting journal on device sda-8.
> [  101.457103] sd 2:0:0:0: [sda] tag#0 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
> [  101.457988] sd 2:0:0:0: [sda] tag#0 Sense Key : Illegal Request [current] 
> [  101.458637] sd 2:0:0:0: [sda] tag#0 Add. Sense: Invalid field in cdb
> [  101.459250] sd 2:0:0:0: [sda] tag#0 CDB: Write(16) 8a 08 00 00 00 00 e8 c4 00 00 00 00 00 08 00 00

That's bizarre too.  Even though the only difference is a MODE SENSE 
command, the command that actually failed was WRITE(16).

> Source code comments describe this as a known problem (scsiglue.c:182):
> 
>                 /*
>                  * Some devices don't like MODE SENSE with page=0x3f,
>                  * which is the command used for checking if a device
>                  * is write-protected.  Now that we tell the sd driver
>                  * to do a 192-byte transfer with this command the
>                  * majority of devices work fine, but a few still can't
>                  * handle it.  The sd driver will simply assume those
>                  * devices are write-enabled.
>                  */
>                 if (us->fflags & US_FL_NO_WP_DETECT)
>                         sdev->skip_ms_page_3f = 1;

Yeah, but that comment referred to driver that fail when they receive 
the MODE SENSE.

Have you tried using uas _and_ setting the sdev->skip_ms_page_3f flag?

Alan Stern

