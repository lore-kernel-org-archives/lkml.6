Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-886641-1526504119-2-14458484874875051988
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
    1526504118; b=HQ3Gf+EFmWpdgl5J/TyY9wmD6SCLuQnZVAiOqnGxbrZmYwAnFB
    Iu0935RAKZSdisaQnZ6ZG9U3lmRJnBpoGYCG6Kj90ki0nBdQTjt2MD63H0lBeYGA
    UFbhbi30y0G74mQZgzXVak4pb6XREuda3Gr3/5Jcyj41ZC7AEI85wnnhwCIfsWG7
    XD8zHrA3K46CBDPcU3IFX2ZTx8kSd5opNFWr91gsvNxTzqA+n+9yQhA+v8zT4EPq
    eX5NAWuxUVr81lPS6gm24XyHDQGzcVajSTwaudZS6uFUV40NDtxl6v+kwAbjTsOj
    kauMNYqTNKNvReFdsDxW4AY/j+PfiwDx22jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:mime-version:content-type:sender:list-id; s=fm2; t=
    1526504118; bh=51k1QhugwHV90QO8Ll5bJw4AU38tb7vgkf/glY/IQEk=; b=O
    m5nxaWCfzptAwtIVBoitFrMxNjl2d7XVKxSh7XJyLCMFkVTt1B9b+eqrapZZIw0t
    C9YDLdzy4h4Q+9+xnWSJDuldisNUmdiR1hlyLH6K/qTLoyKMw4U1Lp3/Jn0GmDPs
    T0ZtIaPXKNZYHOCzu/Nb40SL5/VuiiomOVhFHjeM4DQ5/eheYFVQu2wPitxJYaws
    YkNUaFH8lvYitxt8/bNL3Yt11AZujZS3UeXMVYx/G26G+57Y3a2JEHuSG/xAQK9E
    MAdsXTQ3CcrtTCfBf4cJVWgJkD7q89R2gbj4iLh0ShPNojVvLLtVHcE7hjOqJbg1
    LwDBSbbLs9y1lKQMyvRNA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfD8WnBZfxmoLHoI/BKBfCCSY0IR5oEtiQ3C2rYUjTf/8aJcCmBwvL5CsmGr77ystM7MWE3cZ2oIrdBfjxejyYJihZhPkLH1w9XGckXUtF2whMGLtm05U
    D0yr7HMnV1vSavKrLRxY3DvRE6RVZwQFFFJ0wuqJ8qN8DzIJX6mxurF3xw0yyaqodJQTlNa6RXGBoRGHLMaEROCwzgX1CerhMHD4wp8Tbf4ogCuR183UMbdl
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=97dSWYl1AAAA:8 a=FXmwvOYqAAAA:8 a=VwQbUJbxAAAA:8 a=JR7S4ufJwooxJk2lg38A:9
    a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10 a=OJayMvquMdr9gCXU5-l_:22
    a=kXiaH_QbUnwHKQcifsFq:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751307AbeEPUzQ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 16 May 2018 16:55:16 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:60248 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1751153AbeEPUzQ (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 16 May 2018 16:55:16 -0400
Date: Wed, 16 May 2018 16:55:14 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Alexander Kappner <agk@godking.net>
cc: gregkh@linuxfoundation.org, <linux-usb@vger.kernel.org>,
        <usb-storage@lists.one-eyed-alien.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb-storage: Add quirks to make G-Technology "G-Drive"
 work
In-Reply-To: <1526500880-26512-1-git-send-email-agk@godking.net>
Message-ID: <Pine.LNX.4.44L0.1805161647330.1604-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 16 May 2018, Alexander Kappner wrote:

> The "G-Drive" (sold by G-Technology) external USB 3.0 drive
>  hangs on write access under UAS:
> 
> [  136.079121] sd 15:0:0:0: [sdi] tag#0 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
> [  136.079144] sd 15:0:0:0: [sdi] tag#0 Sense Key : Illegal Request [current]
> [  136.079152] sd 15:0:0:0: [sdi] tag#0 Add. Sense: Invalid field in cdb
> [  136.079176] sd 15:0:0:0: [sdi] tag#0 CDB: Write(16) 8a 08 00 00 00 00 00 00 00 00 00 00 00 08 00 00
> [  136.079180] print_req_error: critical target error, dev sdi, sector 0
> [  136.079183] Buffer I/O error on dev sdi, logical block 0, lost sync page write
> [  136.173148] EXT4-fs (sdi): mounted filesystem with ordered data mode. Opts: (null)
> [  140.583998] sd 15:0:0:0: [sdi] tag#0 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
> [  140.584010] sd 15:0:0:0: [sdi] tag#0 Sense Key : Illegal Request [current]
> [  140.584016] sd 15:0:0:0: [sdi] tag#0 Add. Sense: Invalid field in cdb
> [  140.584022] sd 15:0:0:0: [sdi] tag#0 CDB: Write(16) 8a 08 00 00 00 00 e8 c4 00 18 00 00 00 08 00 00
> [  140.584025] print_req_error: critical target error, dev sdi, sector 3905159192
> [  140.584044] print_req_error: critical target error, dev sdi, sector 3905159192
> [  140.584052] Aborting journal on device sdi-8.

That's kind of weird.  Does the drive work under Windows in UAS mode?  
If so, why are the WRITE(16) commands failing under Linux?

> The proposed patch adds compatibility quirks. Because the drive requires two
> quirks (one to disable UAS, and another to work with usb-storage), adding this
> under unusual_devs.h and not unusual_uas.h so kernels compiled without UAS
> receive the quirk.

That doesn't quite make sense.  Since you prevent the uas driver from 
binding to this device, it will end up using usb-storage no matter how 
the kernel was built.  Therefore the second quirk flag has to go into 
unusual_devs.h no matter what.

>  With the patch, the drive works reliably
> (tested on NEC Corporation uPD720200 USB 3.0 host controller).

You don't describe the second quirk flag at all.  Are you sure it is 
needed?

> Signed-off-by: Alexander Kappner <agk@godking.net>
> ---
>  drivers/usb/storage/unusual_devs.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/usb/storage/unusual_devs.h b/drivers/usb/storage/unusual_devs.h
> index 747d3a9..b8661a1 100644
> --- a/drivers/usb/storage/unusual_devs.h
> +++ b/drivers/usb/storage/unusual_devs.h
> @@ -2321,6 +2321,15 @@ UNUSUAL_DEV(  0x4146, 0xba01, 0x0100, 0x0100,
>  		"Micro Mini 1GB",
>  		USB_SC_DEVICE, USB_PR_DEVICE, NULL, US_FL_NOT_LOCKABLE ),
>  
> +/* "G-DRIVE" external HDD hangs on write without these.
> + * Reported-by: Alexander Kappner <agk@godking.net>
> + */
> +UNUSUAL_DEV(0x4971, 0x8024, 0x0000, 0x9999,
> +		"SimpleTech",
> +		"External HDD",
> +		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
> +		US_FL_IGNORE_UAS | US_FL_NO_WP_DETECT),
> +
>  /*
>   * Nick Bowler <nbowler@elliptictech.com>
>   * SCSI stack spams (otherwise harmless) error messages.
> 

