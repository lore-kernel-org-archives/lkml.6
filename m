Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-287146-1526675751-2-3268975920137562658
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
    1526675750; b=HGPVeRKzATWk1Amkj7FZbZx55Fub6HD0jeKjTrhMPEyvMkwa59
    dx6MfY/DNfM5QYAplIL4TmJ+Lb4It7slinwQCh7R2kJF1XII3g6a14KSoQdG3O0L
    JFteeBktWBjSllyF/3iE0e/Y+7/ZfCGAKVDgeha6K8mUOskR8jgfAKKKvLRxEDbw
    Djab53qSxK6StyAr5k1PZXvT+tUj3+BPFc133VMdcUW8HojxD/rNgHmC/bajd32i
    3K70V+lBMYxCW+jsdjOr7yzeix16R/O2zvTXj4W1+dXptS6KQboSu7GdP8vW/PMo
    ItB4WMP7j0yotnH7QUcHLjytlTEJf80YhAQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:mime-version:content-type:sender:list-id; s=fm2; t=
    1526675750; bh=fSNEhRHm2skr/SlCrB2A5uRSVqQlqlwFqoge1rq1t40=; b=O
    CpBEKDW/D3TrD2jyU+3KvNfTAWpGXqn5B3y6j6HX1MbgUWy1ELBBW7GUMnbE9z8T
    BsMgVmrGgjh8gYUsHM9aFgZp1dtRSPH73BDZFPN2UZu+ksi5M/7KgF1D3VWgxSwh
    J/l+VXKfi74VSaRKb3Ccuxuv/z5LIKSd7SoU6sMKGxUHr46W1wixST3Z7qb+dEoa
    5gjsqkASL9D9l3QBMB3bexVuW9ziD+PkEQpY0g7PX9HFbRxNFK1EuCy3FQVDcUOE
    +ypZqEZFgy0iKMAEj3Xi7uyMY30dup6ttz9XTw+AQ04AK6twoyTcHq+HF9aI7zTB
    IESffP1CrEeW1GaV9C0PA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
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
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCMpirLQpHUksuSwC1aqMN/AEYeF8LvsL8n57w3DYL3cZXVu//4pDUSUiGhtgAPaFLJsSjtOGOBNByP6l9oztHnsSg3wAL7wEaMulVTMcVkxfhf4/HmB
    eYZET4jnVYkJmpAIYE0sLDn9ovINcIzHXsMthWdm62wb1i7HTpxBnmZrokp/FStAPEd5/H4W3uYILvHJ0UrFZE1DdWClIsTwkUqyhtNkylinhbw+VkKk/mIk
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=n0M7-IIr1I-kQGb2KQEA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751696AbeERUfT (ORCPT <rfc822;greg@kroah.com>);
        Fri, 18 May 2018 16:35:19 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:43622 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1751280AbeERUfT (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 18 May 2018 16:35:19 -0400
Date: Fri, 18 May 2018 16:35:17 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Alexander Kappner <agk@godking.net>
cc: Oliver Neukum <oneukum@suse.com>, <gregkh@linuxfoundation.org>,
        <usb-storage@lists.one-eyed-alien.net>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] usb-storage: Add quirks to make G-Technology "G-Drive"
 work
In-Reply-To: <f12e75ed-206c-3cca-766c-447cd73b4280@godking.net>
Message-ID: <Pine.LNX.4.44L0.1805181634000.1645-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 18 May 2018, Alexander Kappner wrote:

> Further debugging shows that the code that causes the device to hang is in 
> drivers/scsi/sd.c:2698. So the reason why usb-storage works and UAS does 
> not is because the device setting both skip_ms_page_3f=1 and 
> skip_ms_page_8=1 is required. The US_FL_NO_WP_DETECT flag does the former, 
> and usb-storage (but not UAS) by default does the latter 
> (drivers/usb/storage/scsiglue.c:198):
> 
>  /*
>                  * A number of devices have problems with MODE SENSE for
>                  * page x08, so we will skip it.
>                  */
>                 sdev->skip_ms_page_8 = 1;
> 
> 
> Forcing both skip_ms_page_3f and skip_ms_page_8 to 1 results in UAS and 
> usb-storage working. Oliver's code only set skip_ms_page_3f. 

Good detective work!

> Do we want a patch to introduce a quirk flag for skip_ms_page_8,  similar to 
> the US_FL_NO_WP_DETECT quirk bit for skip_ms_page_3f? This may even resolve 
> the issues with other devices in unusual_uas.h that currently have all UAS 
> support disabled. I'd be happy to write the patch, but I'm not sure we want 
> to reserve a quirk bit for what's currently only a single device known to 
> have this issue.  Please advise. 

Yes, I think we want a patch.  Unless Oliver disagrees, please go ahead 
and prepare one.

Alan Stern

