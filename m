Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1744384-1526544941-2-14656986910858348430
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526544940; b=KQKjcgDlGQxqw4WfSgdRoCCIV7kQPfPmhnv+g3jV4CcAT7ZBky
    fVfwis0oux07tIMmO15lVcg0Yq0QGdYwlEPDbf08PHOxNNTffHmiQ8c63nHh9CyU
    /jUzGAAMQqVNb8TvlBvY9f7ACeHBeVlU4yIP2KCqDzLNCvg/ZXEu9cvm+eLnSApn
    CZ46xp0m/50SaSzKpAEc+6EImL3WN1xRPoisEJPkHYkeH1u4UzPQBU+ayJnxvB9N
    vo7K7VRgx5DtLAPhHaio3rFa9xigO6fWC5IOvMFxsgsTkEYe2RvPCeXcItxrUzlR
    g9GDrRKre+V0mPaW2sMCjkYfeIbZ3gcLS/1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:subject:to:cc:references:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526544940;
    bh=vOFd2BlBXWeLmXYU2jVtAE0Rtexa3T7jt+YalmeqXWQ=; b=DGto/ZUHi47u
    T1r3PIzwjCpuwjEQQ/TxWXhCu0mWhEd6ECRwE3IpWmB5lQHjETaF96pn8ud5ABjR
    6MiGSYuMN9N81laPhcBFOI7bIxabvcTDXHed1DO0Suo+/V0G8OygIYnYjMoTJg7A
    rj3lA5Kbluqb2fYhBUNQNVRAFTHCZrz+1o1Tg8vzbYqEMeCNbfTXhTxKq8Us452P
    UvVy3qG89Sslg16BXedfadDhRLKE8OvLYmD9bnDxiXcnBhqOyHG85YUtg1uukc9c
    dD2T+Ys4ntBYljwG1Qzal1KsK82CpGareC8FfHu77s0uGWBZuT9mLFNZkUSvh5bs
    iNHdOHYYDQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=godking.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=godking.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=godking.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=godking.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLsms8F5sgWgss6BHi1pOTPEsOc7QYe+b6uAXlovp37SucN7ifPm/Orf6eh6lBFy5DtG+PCb3v/6c3upUnqr6CRhivGBxfS0bzQhN95nNHe42v2z8Tx8
    eQhLoCymT+167EUcRgPjk8t4XkY/T2tR09CfzHkhOiFfmhDTXV43KDUwGfw8yantsGmDweCcTqXHqeJYg+3ERXmPpq1qbDDYi0bwj523eEATd6UhHBdXqZEU
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=20KFwNOVAAAA:8 a=97dSWYl1AAAA:8 a=FXmwvOYqAAAA:8 a=VwQbUJbxAAAA:8
    a=LmxMlfOCb3ZnksLFJhwA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=OJayMvquMdr9gCXU5-l_:22 a=kXiaH_QbUnwHKQcifsFq:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752391AbeEQIPN (ORCPT <rfc822;greg@kroah.com>);
        Thu, 17 May 2018 04:15:13 -0400
Received: from s18231873.onlinehome-server.info ([217.160.179.168]:56514 "EHLO
        godking.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752296AbeEQIPK (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Thu, 17 May 2018 04:15:10 -0400
From: Alexander Kappner <agk@godking.net>
Subject: Re: [PATCH] usb-storage: Add quirks to make G-Technology "G-Drive"
 work
To: Alan Stern <stern@rowland.harvard.edu>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L0.1805161647330.1604-100000@iolanthe.rowland.org>
Message-ID: <9c638d96-d2b4-cf19-d7e8-4ef93549bd79@godking.net>
Date: Thu, 17 May 2018 01:15:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1805161647330.1604-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Alan,

thanks for reviewing. (This is my first contribution that touches 
usb-storage, so please bear with me.)

> That's kind of weird.  Does the drive work under Windows in UAS mode?  

On the Windows 10 VM that I just spun up for testing this, access to the 
drive uses "usbstor.inf" (rather than "uaspstor.sys"). So I believe the 
answer is no. 

> If so, why are the WRITE(16) commands failing under Linux?

I don't know exactly why they're failing, but another entry in the 
unusual_uas.h shows another SimpleTech device (only with a slightly 
different product ID) needing the same UAS quirk (see 
https://bugzilla.redhat.com/show_bug.cgi?id=1124119). So my guess is those 
drives are just buggy. 

> That doesn't quite make sense.  Since you prevent the uas driver from 
> binding to this device, it will end up using usb-storage no matter how 
> the kernel was built.  Therefore the second quirk flag has to go into 
> unusual_devs.h no matter what.

Yes that's what I was trying to get at. So even though the UAS flag would 
conceptually belong into unusual_uas, I'm putting both into unusual_devs to 
avoid having to create two separate entries for the same device.

> You don't describe the second quirk flag at all.  Are you sure it is 
> needed?

Yes. Without this flag, the device keeps throwing similar errors on 
usb-storage. That's the same result I get on a host that doesn't have UAS 
compiled in. Here's a dmesg:

[    2.183472] usb 3-1: New USB device found, idVendor=4971, idProduct=8024, bcdDevice=24.03
[    2.184285] usb 3-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    2.184980] usb 3-1: Product: G-DRIVE
[    2.185447] usb 3-1: Manufacturer: HGST
[    2.185829] usb 3-1: SerialNumber: AA015010004C
[    2.195509] usb-storage 3-1:1.0: USB Mass Storage device detected
[    2.198668] Floppy drive(s): fd0 is 2.88M AMI BIOS
[    2.202981] scsi host2: usb-storage 3-1:1.0
...
[    3.233085] scsi 2:0:0:0: Direct-Access     G-DRIVE                   2403 PQ: 0 ANSI: 6
[    3.234514] sd 2:0:0:0: Attached scsi generic sg1 type 0
[    3.235465] sd 2:0:0:0: [sda] Very big device. Trying to use READ CAPACITY(16).
[    3.236847] sd 2:0:0:0: [sda] 7814037168 512-byte logical blocks: (4.00 TB/3.64 TiB)
[    3.237794] sd 2:0:0:0: [sda] 4096-byte physical blocks
[    3.241255] sd 2:0:0:0: [sda] Write Protect is off
[    3.242096] sd 2:0:0:0: [sda] Mode Sense: 47 00 10 08
[    3.243595] sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, supports DPO and FUA
[    3.257893]  sda: sda1 sda9
[    3.261402] sd 2:0:0:0: [sda] Attached SCSI disk
...
[   92.433428] sd 2:0:0:0: [sda] tag#0 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
[   92.434759] sd 2:0:0:0: [sda] tag#0 Sense Key : Illegal Request [current] 
[   92.435637] sd 2:0:0:0: [sda] tag#0 Add. Sense: Invalid field in cdb
[   92.436401] sd 2:0:0:0: [sda] tag#0 CDB: Write(16) 8a 08 00 00 00 00 00 00 00 00 00 00 00 08 00 00
[   92.437493] print_req_error: critical target error, dev sda, sector 0
[   92.438211] Buffer I/O error on dev sda, logical block 0, lost sync page write
[   92.516692] EXT4-fs (sda): mounted filesystem with ordered data mode. Opts: (null)
[  101.449311] sd 2:0:0:0: [sda] tag#0 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
[  101.450598] sd 2:0:0:0: [sda] tag#0 Sense Key : Illegal Request [current] 
[  101.451401] sd 2:0:0:0: [sda] tag#0 Add. Sense: Invalid field in cdb
[  101.452041] sd 2:0:0:0: [sda] tag#0 CDB: Write(16) 8a 08 00 00 00 00 e8 c4 00 18 00 00 00 08 00 00
[  101.452906] print_req_error: critical target error, dev sda, sector 3905159192
[  101.453593] print_req_error: critical target error, dev sda, sector 3905159192
[  101.454889] Aborting journal on device sda-8.
[  101.457103] sd 2:0:0:0: [sda] tag#0 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
[  101.457988] sd 2:0:0:0: [sda] tag#0 Sense Key : Illegal Request [current] 
[  101.458637] sd 2:0:0:0: [sda] tag#0 Add. Sense: Invalid field in cdb
[  101.459250] sd 2:0:0:0: [sda] tag#0 CDB: Write(16) 8a 08 00 00 00 00 e8 c4 00 00 00 00 00 08 00 00

Source code comments describe this as a known problem (scsiglue.c:182):

                /*
                 * Some devices don't like MODE SENSE with page=0x3f,
                 * which is the command used for checking if a device
                 * is write-protected.  Now that we tell the sd driver
                 * to do a 192-byte transfer with this command the
                 * majority of devices work fine, but a few still can't
                 * handle it.  The sd driver will simply assume those
                 * devices are write-enabled.
                 */
                if (us->fflags & US_FL_NO_WP_DETECT)
                        sdev->skip_ms_page_3f = 1;

--agk 



On 05/16/2018 01:55 PM, Alan Stern wrote:
> On Wed, 16 May 2018, Alexander Kappner wrote:
> 
>> The "G-Drive" (sold by G-Technology) external USB 3.0 drive
>>  hangs on write access under UAS:
>>
>> [  136.079121] sd 15:0:0:0: [sdi] tag#0 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
>> [  136.079144] sd 15:0:0:0: [sdi] tag#0 Sense Key : Illegal Request [current]
>> [  136.079152] sd 15:0:0:0: [sdi] tag#0 Add. Sense: Invalid field in cdb
>> [  136.079176] sd 15:0:0:0: [sdi] tag#0 CDB: Write(16) 8a 08 00 00 00 00 00 00 00 00 00 00 00 08 00 00
>> [  136.079180] print_req_error: critical target error, dev sdi, sector 0
>> [  136.079183] Buffer I/O error on dev sdi, logical block 0, lost sync page write
>> [  136.173148] EXT4-fs (sdi): mounted filesystem with ordered data mode. Opts: (null)
>> [  140.583998] sd 15:0:0:0: [sdi] tag#0 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
>> [  140.584010] sd 15:0:0:0: [sdi] tag#0 Sense Key : Illegal Request [current]
>> [  140.584016] sd 15:0:0:0: [sdi] tag#0 Add. Sense: Invalid field in cdb
>> [  140.584022] sd 15:0:0:0: [sdi] tag#0 CDB: Write(16) 8a 08 00 00 00 00 e8 c4 00 18 00 00 00 08 00 00
>> [  140.584025] print_req_error: critical target error, dev sdi, sector 3905159192
>> [  140.584044] print_req_error: critical target error, dev sdi, sector 3905159192
>> [  140.584052] Aborting journal on device sdi-8.
> 
> That's kind of weird.  Does the drive work under Windows in UAS mode?  
> If so, why are the WRITE(16) commands failing under Linux?
> 
>> The proposed patch adds compatibility quirks. Because the drive requires two
>> quirks (one to disable UAS, and another to work with usb-storage), adding this
>> under unusual_devs.h and not unusual_uas.h so kernels compiled without UAS
>> receive the quirk.
> 
> That doesn't quite make sense.  Since you prevent the uas driver from 
> binding to this device, it will end up using usb-storage no matter how 
> the kernel was built.  Therefore the second quirk flag has to go into 
> unusual_devs.h no matter what.
> 
>>  With the patch, the drive works reliably
>> (tested on NEC Corporation uPD720200 USB 3.0 host controller).
> 
> You don't describe the second quirk flag at all.  Are you sure it is 
> needed?
> 
>> Signed-off-by: Alexander Kappner <agk@godking.net>
>> ---
>>  drivers/usb/storage/unusual_devs.h | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/usb/storage/unusual_devs.h b/drivers/usb/storage/unusual_devs.h
>> index 747d3a9..b8661a1 100644
>> --- a/drivers/usb/storage/unusual_devs.h
>> +++ b/drivers/usb/storage/unusual_devs.h
>> @@ -2321,6 +2321,15 @@ UNUSUAL_DEV(  0x4146, 0xba01, 0x0100, 0x0100,
>>  		"Micro Mini 1GB",
>>  		USB_SC_DEVICE, USB_PR_DEVICE, NULL, US_FL_NOT_LOCKABLE ),
>>  
>> +/* "G-DRIVE" external HDD hangs on write without these.
>> + * Reported-by: Alexander Kappner <agk@godking.net>
>> + */
>> +UNUSUAL_DEV(0x4971, 0x8024, 0x0000, 0x9999,
>> +		"SimpleTech",
>> +		"External HDD",
>> +		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
>> +		US_FL_IGNORE_UAS | US_FL_NO_WP_DETECT),
>> +
>>  /*
>>   * Nick Bowler <nbowler@elliptictech.com>
>>   * SCSI stack spams (otherwise harmless) error messages.
>>
