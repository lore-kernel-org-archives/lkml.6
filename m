Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595D4C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 18:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A9462150E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 18:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8mIR2pE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A9462150E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391216AbeIVAHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 20:07:54 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53214 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732114AbeIVAHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 20:07:54 -0400
Received: by mail-wm1-f65.google.com with SMTP id y139-v6so3946909wmc.2;
        Fri, 21 Sep 2018 11:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7lcZ9HEXpdOtLhJgsGrRqskTh+Z8npjUEAOzsae1hi4=;
        b=I8mIR2pEeWheBgxD4CE52nljC4jHCrjAm6Gy5vbp4+nSxwjxIWZIHJNP/q3PDQQyxF
         NK3Be2FZc2UVUI6uRuntuz7C6YoZ0QygU/37oeMJKArH6CWqa+Z5pojcg2biShz2jygx
         thLAZ7ThmwZY1JNLMikdZDn8+THL/1InfJNnKYg8WxWLtvIC7mIVAK0blGrlDTCIe9Ga
         h+0GVZSmnnhAdtT1bTq09HrgyzEj1xnzvGHMVQPyiH8Mb0dIY6lJWHH5M0qS4+qbImAM
         5QrkLmrQICk2OE0WYvQan5s5uWroG7tgLSpTercWPFVhGnAhmJCF+WwSanQ4DzkXXPlM
         DNhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7lcZ9HEXpdOtLhJgsGrRqskTh+Z8npjUEAOzsae1hi4=;
        b=ah+KHu9l74YSHC3sRtzrp3bbGOh81jf0vgbDR4CKUHMrCNehm3ycECJfyddeezdyog
         8xnBlJ1aPxBSo+H7IQmBiqe8noWDlo8CP6T6Ni9ntFN98ceD/iFlF1+LAXqP3yfWgGRm
         kDcVdlAfJbK3yzI3TJvcFxIcyO09UroCb9VyrcDqBfwf2PrER4/TT4QFTD3XVBOQe0xL
         kbmOc+7BCz4HLs1quA57RP3tXfHN958kDT3380FlEhVfWCFSnvZ9Q/Jx0DQ7nWEBpU2s
         fZh3jO2L3UvzlNp+Gbzstq1KHaP/e1hXaCslY4bk8LFsTnFgSq3lioP4H4tuIFaHT9Qu
         FFvg==
X-Gm-Message-State: APzg51DTba4p5Y8O91GP5OjN0C5iR/tg8D+uzrLvN9lQ648EPiHBwZvh
        SUW27Aga2H6WaF00qg5+iIg=
X-Google-Smtp-Source: ANB0VdbmCBesZr6FU0LB+fDBJM2AitQreoJ8BOHxj2ZS/isD1yr4ypjDs1ASoqaf7TA6YcuGugpt6g==
X-Received: by 2002:a1c:889:: with SMTP id 131-v6mr5886798wmi.142.1537553869050;
        Fri, 21 Sep 2018 11:17:49 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id h73-v6sm13641477wma.11.2018.09.21.11.17.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 11:17:48 -0700 (PDT)
Date:   Fri, 21 Sep 2018 11:17:46 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Khalid Aziz <khalid@gonehiking.org>
Cc:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: FlashPoint: Remove unnecessary parentheses
Message-ID: <20180921181746.GA5415@flashbox>
References: <20180920211032.21840-1-natechancellor@gmail.com>
 <bb9c20c4-f13a-497a-0ad1-73978a9f4f3b@gonehiking.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb9c20c4-f13a-497a-0ad1-73978a9f4f3b@gonehiking.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 09:19:40AM -0600, Khalid Aziz wrote:
> On 09/20/2018 03:10 PM, Nathan Chancellor wrote:
> > Clang warns when multiple pairs of parentheses are used for a single
> > conditional statement.
> > 
> > In file included from drivers/scsi/BusLogic.c:57:
> > drivers/scsi/FlashPoint.c:2947:34: warning: equality comparison with extraneous parentheses [-Wparentheses-equality]
> >                                 if ((currSCCB->Sccb_scsistat == SELECT_SN_ST)) {
> >                                      ~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~
> > drivers/scsi/FlashPoint.c:2947:34: note: remove extraneous parentheses around the comparison to silence this warning
> >                                 if ((currSCCB->Sccb_scsistat == SELECT_SN_ST)) {
> >                                     ~                        ^              ~
> > drivers/scsi/FlashPoint.c:2947:34: note: use '=' to turn this equality comparison into an assignment
> >                                 if ((currSCCB->Sccb_scsistat == SELECT_SN_ST)) {
> >                                                              ^~
> >                                                              =
> > drivers/scsi/FlashPoint.c:2956:39: warning: equality comparison with extraneous parentheses [-Wparentheses-equality]
> >                                 else if ((currSCCB->Sccb_scsistat ==
> >                                           ~~~~~~~~~~~~~~~~~~~~~~~~^~
> > drivers/scsi/FlashPoint.c:2956:39: note: remove extraneous parentheses around the comparison to silence this warning
> >                                 else if ((currSCCB->Sccb_scsistat ==
> >                                          ~                        ^
> > drivers/scsi/FlashPoint.c:2956:39: note: use '=' to turn this equality comparison into an assignment
> >                                 else if ((currSCCB->Sccb_scsistat ==
> >                                                                   ^~
> >                                                                   =
> > 2 warnings generated.
> > 
> > Link: https://github.com/ClangBuiltLinux/linux/issues/156
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  drivers/scsi/FlashPoint.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> 
> There are more places in this file with extraneous parentheses, for example:
> 
>  952         if ((RD_HARPOON(ioport + hp_vendor_id_1) != ORION_VEND_1))
>  953                 return (int)FAILURE;
>  954
>  955         if ((RD_HARPOON(ioport + hp_device_id_0) != ORION_DEV_0))
>  956                 return (int)FAILURE;
>  957
>  958         if ((RD_HARPOON(ioport + hp_device_id_1) != ORION_DEV_1))
> 
> Wonder why the compiler does not complain about these, but this patch is
> good for now. I will clean up the rest in another patch.
> 
> James, Martin, please pull this patch into the scsi tree.
> 
> Acked-by: Khalid Aziz <khalid@gonehiking.org>

Hi Khalid,

Clang only warns about this construct when the left hand is a variable
because it thinks that an assignment may have been intended so macros
and functions don't trigger it.

Thank you for the review, I appreciate it,
Nathan
