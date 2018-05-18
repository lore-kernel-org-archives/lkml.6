Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-77256-1526665905-2-2695873422552026709
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
    1526665905; b=hcceNraeA8kHBvOxGgXGdFsewRQcD41aU8MENMG2WdzV2LVDuV
    f7mVbgOEh360nHpFXMKpjwxHY8Xz5TvRxgD2mZE7Ose3UYKk/O7a2ImJVzzJrMoo
    ow7YbPsOX6E9qzlvfefq5Le2Gz9s6ytdkNYyFFGjew0i3MjyomIXZV/omnb23WXG
    9vaZK71JdAKbGcuB9bfoLIqlEPxDPFT3X2IEXACzFab+uFdzuQVzPgPtlLmu/Eux
    pGMtgajAOx8xqhpNG2Yu8voZw5s7punYYcqU57ai6kw+CS3TBeFFDQeRGKwr5Q8J
    aPyZ9Fd9Lh1T9a/8nsEVCHse0ulAuAWZ7BMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:subject:to:cc:references:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526665905;
    bh=Fi3IakMeSPHcdkoTt1mlLb89w/SVI7cgUN+DRKVweKY=; b=gyAd20yd2qht
    QmYSV2RHMv2CIwBxTm4ha+xF1T7WcgEb9o6+t2IDYsTMjsRJ7imn7YWyx0katrj9
    cgZMTuUHGKNF8xmaqXKlwlMXllSWn/iDS8HErQT0SxXIbC1WbO7lowq4oGY1ZtFD
    Di/aTrCgeqrFNtXUXdnY/+efvJGX7NIy61cvgShL5h8dGgiU83f6YiKxKnLDuxDw
    swyxc5zvC9y+mpK/Z0siFCHK9qs25oF+ZLt/mIKFR8DnTN5E3nb0v9vb7I3QIgsq
    xXeodIXq6QEgxwXlQYLH+w/1TPqV2GYswwztMloPac5uUE67jwlsY2DVbXnTTV4q
    26Wv8Pkkyw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfOfbMoSUISe09Oraq94nYAbIzRgpI6EXQQRFImY4rhT/SDIxvSEomlSuMj2Im5VFf2jrHv1NT2gc452MSpM/hkWsbVucxh5HGTVzx+bTjeEb+Ob/ku/5
    u4AWHlrQ4AKT9LbuzFwOaAfMLVoKtwJn+UeNsJBa4T8C2HkQg4UxZY+2Y4b/zNdlOaL9+FKO51QGTEahW+Cn97BHaAKPnp+7io5QoGlWb1t7qa23ZrQF44Fx
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=3AnTHOkZfzeHRJnUcEwA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751534AbeERRvb (ORCPT <rfc822;greg@kroah.com>);
        Fri, 18 May 2018 13:51:31 -0400
Received: from s18231873.onlinehome-server.info ([217.160.179.168]:60828 "EHLO
        godking.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751909AbeERRva (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Fri, 18 May 2018 13:51:30 -0400
From: Alexander Kappner <agk@godking.net>
Subject: Re: [PATCH] usb-storage: Add quirks to make G-Technology "G-Drive"
 work
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Oliver Neukum <oneukum@suse.com>, gregkh@linuxfoundation.org,
        usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <Pine.LNX.4.44L0.1805171507420.1294-100000@iolanthe.rowland.org>
Message-ID: <f12e75ed-206c-3cca-766c-447cd73b4280@godking.net>
Date: Fri, 18 May 2018 10:51:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1805171507420.1294-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> Was this tested with uas or usb-storage?
On both. dd works either way.  

> Are you certain Oliver's new code was executed?  If you put 
> US_FL_NO_WP_DETECT only in unusual_devs.h and not in ususual_uas.h then 
> it would not affect the uas driver.
Yes, the code ran.

Further debugging shows that the code that causes the device to hang is in 
drivers/scsi/sd.c:2698. So the reason why usb-storage works and UAS does 
not is because the device setting both skip_ms_page_3f=1 and 
skip_ms_page_8=1 is required. The US_FL_NO_WP_DETECT flag does the former, 
and usb-storage (but not UAS) by default does the latter 
(drivers/usb/storage/scsiglue.c:198):

 /*
                 * A number of devices have problems with MODE SENSE for
                 * page x08, so we will skip it.
                 */
                sdev->skip_ms_page_8 = 1;


Forcing both skip_ms_page_3f and skip_ms_page_8 to 1 results in UAS and 
usb-storage working. Oliver's code only set skip_ms_page_3f. 

Do we want a patch to introduce a quirk flag for skip_ms_page_8,  similar to 
the US_FL_NO_WP_DETECT quirk bit for skip_ms_page_3f? This may even resolve 
the issues with other devices in unusual_uas.h that currently have all UAS 
support disabled. I'd be happy to write the patch, but I'm not sure we want 
to reserve a quirk bit for what's currently only a single device known to 
have this issue.  Please advise. 


On 05/17/2018 12:13 PM, Alan Stern wrote:
> On Thu, 17 May 2018, Alexander Kappner wrote:
> 
>> Oliver and Alan,
>>
>> thank for investigating.
>>
>>> this is suspicious. You do not actually whether US_FL_NO_WP_DETECT
>>> by itself would make the device work. Can you please test that?
>>
>> US_FL_NO_WP_DETECT without US_FL_IGNORE_UAS does not make a difference, 
>> even with the patch you included applied:
> 
> Are you certain Oliver's new code was executed?  If you put 
> US_FL_NO_WP_DETECT only in unusual_devs.h and not in ususual_uas.h then 
> it would not affect the uas driver.
> 
>>> That's bizarre too.  Even though the only difference is a MODE SENSE 
>>> command, the command that actually faliled was WRITE(16).
>> It looks to me like the MODE SENSE simply hangs the drive, so anything 
>> issued after that will fail. Of course the drive says it's the "current 
>> command" that caused the failure, but I wouldn't give too much credence to 
>> that. FYI -- this device is a consumer grade rotational drive that you can 
>> get for less than $200, so I wouldn't be surprised if the implementations 
>> have issues. 
>>
>> Also, I noticed that copying onto the drive with dd works fine, whereas 
>> trying to mount a filesystem immediately crashes it. I suspect this is 
>> because check_disk_change is called on mount (which eventually calls down 
>> to sd_read_write_protect_flag, which is where the US_FL_NO_WP_DETECT flag 
>> comes into play).
> 
> Was this tested with uas or usb-storage?
> 
> Alan Stern
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
