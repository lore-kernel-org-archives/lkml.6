Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2531651-1526582338-2-11576894954910873381
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
    1526582337; b=gWgdOpYb91S+zQVCl+UfeqKmdqiEKvqRa1bBZgh2A+2NSi+rkG
    EcMHm6LZYRXPEsFeaXGxhlhWFSp2oOGtdRkT2EW6NrVHqr5yzWMN1ejzRNafMCFw
    RVALJ0V94Gj3t7MslZtje69M9jxgF8DvlKuMh2z+7C6BCIc1o/xvKrVYwawrPJ85
    8qN2pPDRJy2sx0yE8MpAAKUXcZ5hnpDRrJflz8wdbyq2nLn0hxehWuPJIHBG0HvG
    k2EyoQuia1aJ3HhNO8kEkscKFuHsCL4uTg+8CF1GY8uChOEuvWEJ6S56fRVkXhIh
    5vdVW8nOYbg+N8h96SNu6amhh26SyzoyHpZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526582337;
    bh=Zg589wjIHVrwHYNfpc8ZNfWBTa3XOYf90jcdIeHbsvE=; b=nh1cx1fuH29M
    RZS891pnCRMmqBf7XcON8jlUP62t7j/M15vqm/Q8669Kn8BoCJ6SmQoX2Q0nVwPa
    6RPoRj2qZG70RvDMslvqGC6N4dF1ErzQQzw4yUNPYXC383lBnSxi8YxDgZ82h8qK
    mNYBbNPYCwX/j6ifBXZ0iTEX3mYdSwKJ3gA4JxJCcmvpq5V0oAA/4IXdVmMUpBdX
    DstJGBiJWjSsH5U2Oj03idf98ptK7GIIDBk/+SAGYNazVNwd9gI7wvde7JeKsh9E
    SaG8OFGZPGqAq6f1eG5vb0QPanm9LAqWDLAHjyDSNfvkU/jrn+oVaZPAmhy8Vg3F
    cY5wI+f/VQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfFtRWcXJn7dv2XA7K9t5CiNsrlARgFO9+hMO3rjhRlTWR/hNDON1Ut9g8d2T+BlODf7JQxyw40CtsgifWnV6zqG3IvhtFwAcm2B9cfmf0CMSbVhRMuCJ
    k1bSNZl0hoKToNOLQBhH0HNl+PKNUT6x5xiwrstPTyaat9EL6iDyE3NBJNgT4zzePYALcVsh1v7Vb0QhwZj/pLskjopM0lRnXXHsarYsyLWN7/UNTGc9qE9l
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=xIJcPw8s8Mx52nLzkEYA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751879AbeEQSin (ORCPT <rfc822;greg@kroah.com>);
        Thu, 17 May 2018 14:38:43 -0400
Received: from s18231873.onlinehome-server.info ([217.160.179.168]:35726 "EHLO
        godking.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750924AbeEQSim (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Thu, 17 May 2018 14:38:42 -0400
Subject: Re: [PATCH] usb-storage: Add quirks to make G-Technology "G-Drive"
 work
To: Oliver Neukum <oneukum@suse.com>,
        Alan Stern <stern@rowland.harvard.edu>
Cc: gregkh@linuxfoundation.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <Pine.LNX.4.44L0.1805161647330.1604-100000@iolanthe.rowland.org>
 <9c638d96-d2b4-cf19-d7e8-4ef93549bd79@godking.net>
 <1526561908.15506.5.camel@suse.com>
From: Alexander Kappner <agk@godking.net>
Message-ID: <7dc7ea60-81b5-3546-5a12-9b0ff0b734cb@godking.net>
Date: Thu, 17 May 2018 11:38:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1526561908.15506.5.camel@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Oliver and Alan,

thank for investigating.

> this is suspicious. You do not actually whether US_FL_NO_WP_DETECT
> by itself would make the device work. Can you please test that?

US_FL_NO_WP_DETECT without US_FL_IGNORE_UAS does not make a difference, 
even with the patch you included applied:

[   44.108417] JBD2: Clearing recovery information on journal
[   44.119593] sd 2:0:0:0: [sda] tag#1 FAILED Result: hostbyte=DID_OK 
driverbyte=DRIVER_SENSE
[   44.121605] sd 2:0:0:0: [sda] tag#1 Sense Key : Illegal Request 
[current] 
[   44.123254] sd 2:0:0:0: [sda] tag#1 Add. Sense: Invalid field in cdb
[   44.124798] sd 2:0:0:0: [sda] tag#1 CDB: Write(16) 8a 08 00 00 00 00 e8 
c4 00 00 00 00 00 08 00 00
[   44.126847] print_req_error: critical target error, dev sda, sector 
3905159168
[   44.128450] Buffer I/O error on dev sda, logical block 488144896, lost 
sync page write
[   44.130776] JBD2: Error -5 detected when updating journal superblock for 
sda-8.
[   44.141059] sd 2:0:0:0: [sda] tag#0 FAILED Result: hostbyte=DID_OK 
driverbyte=DRIVER_SENSE
[   44.141376] sd 2:0:0:0: [sda] tag#0 Sense Key : Illegal Request 
[current] 
[   44.141376] sd 2:0:0:0: [sda] tag#0 Add. Sense: Invalid field in cdb
[   44.141376] sd 2:0:0:0: [sda] tag#0 CDB: Write(16) 8a 08 00 00 00 00 00 
00 00 00 00 00 00 08 00 00
[   44.141376] print_req_error: critical target error, dev sda, sector 0
[   44.141376] Buffer I/O error on dev sda, logical block 0, lost sync page 
write

> That's bizarre too.  Even though the only difference is a MODE SENSE 
> command, the command that actually faliled was WRITE(16).
It looks to me like the MODE SENSE simply hangs the drive, so anything 
issued after that will fail. Of course the drive says it's the "current 
command" that caused the failure, but I wouldn't give too much credence to 
that. FYI -- this device is a consumer grade rotational drive that you can 
get for less than $200, so I wouldn't be surprised if the implementations 
have issues. 

Also, I noticed that copying onto the drive with dd works fine, whereas 
trying to mount a filesystem immediately crashes it. I suspect this is 
because check_disk_change is called on mount (which eventually calls down 
to sd_read_write_protect_flag, which is where the US_FL_NO_WP_DETECT flag 
comes into play).



On 05/17/2018 05:58 AM, Oliver Neukum wrote:
> Am Donnerstag, den 17.05.2018, 01:15 -0700 schrieb Alexander Kappner:
>> Yes. Without this flag, the device keeps throwing similar errors on 
>> usb-storage. That's the same result I get on a host that doesn't have UAS 
>> compiled in. Here's a dmesg:
> 
> Hi,
> 
> this is suspicious. You do not actually whether US_FL_NO_WP_DETECT
> by itself would make the device work. Can you please test that?
> You will need the attached patch for the quirk to be supported.
> 
> 	Regards
> 		Oliver
> 
