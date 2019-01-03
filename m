Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8D9C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 09:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A516206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 09:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMu9Eeip"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730573AbfACJsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 04:48:05 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35766 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfACJsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 04:48:05 -0500
Received: by mail-wm1-f67.google.com with SMTP id t200so17815140wmt.0;
        Thu, 03 Jan 2019 01:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=LQwgSl+CgOa/5Y27xidea06XhW+iIQrwCz51od71/yw=;
        b=DMu9Eeip5oFqGAHsDUEGb/ebt/S+s1GFNY8pdooyUzvm1XDidrkSBxLTyFGfZkmgtK
         H8brnaUsD9yZ2UNLfmEZp81WaOAk4UgLAPVJcewRejNnMxs97rYu7lTxRZIWwdGLV2xY
         wzTlbE9CU0Xm2zrtBWMnnvmFA/2/k9S7D/ekIyv3VNCtUAn8AxTv3vJoUj0rgueACoro
         Ks5Ww2ZJHhlnHgWppiIScWuJeCqX5M5MfmePEApKG8R3FubPx1zRdpG7yqBsAjIa3Yah
         puC1gAGIw/cpqw5MyvJvICUnA7QCIHE+mB0M5mfrYElpDdxqEx5w0V+VyS5p+KqOSwBP
         vOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=LQwgSl+CgOa/5Y27xidea06XhW+iIQrwCz51od71/yw=;
        b=ZN8Dwnn/eUna4V01cOmNHQlEbUfLWmuNKcBHWNmdvoyEzaHbieBuudVxITBv7SkCRo
         aVNik0Zgl5l1n4CpGv9GLnrZhWz7sDF5fBRBdyMwNknrBGS56bRzRdd5Wstc8tz3WAE9
         9Umf4I+GQ5f/zYax4rz+Yr05ZyWUR9cdSyAlEtH33vcmOZgBZcxceJ9+YBzKbKcQbYBB
         07E6r9MstsUpa/dn2VS4pVllxwODU2ZphO6GmPBKXTs5Dwj8rvDwkhlJN7UIpDE1TB1Z
         5fIX3PeVONgwTl8k7KO3IR68tFp6mAPs1FZGaHYV2kvI0k8twJ2LUVpN6iW0MFZbffFg
         16xg==
X-Gm-Message-State: AA+aEWadgfPV4EBbz+oXw5Oz1mytoulfpB5syizxfO8zRuI4PkafufT1
        TCXKcKwIHE06XG8XwHqRZSM=
X-Google-Smtp-Source: AFSGD/XBoSWqzmPTDR4CynSumNyWtd67qD5+WeoBtHD5p0xlFNjx1fc+v7P1QmZO5BivpzWEy5VEUw==
X-Received: by 2002:a1c:2902:: with SMTP id p2mr37198500wmp.19.1546508882199;
        Thu, 03 Jan 2019 01:48:02 -0800 (PST)
Received: from google.com ([2401:fa00:fc:1:6924:4b22:cf4b:bbca])
        by smtp.gmail.com with ESMTPSA id o81sm87935462wmd.10.2019.01.03.01.47.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Jan 2019 01:48:01 -0800 (PST)
Date:   Thu, 3 Jan 2019 17:47:55 +0800
From:   Randall Huang <ihhuang@abmail.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     huangrandall@google.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: associate bio write hint with WRITE CDB
Message-ID: <20190103094755.GA96532@google.com>
References: <20181226041504.66283-1-huangrandall@google.com>
 <20190103075133.GA5141@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190103075133.GA5141@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2019 at 11:51:33PM -0800, Christoph Hellwig wrote:
> On Wed, Dec 26, 2018 at 12:15:04PM +0800, Randall Huang wrote:
> > In SPC-3, WRITE(10)/(16) support grouping function.
> > Let's associate bio write hint with group number for
> > enabling StreamID or Turbo Write feature.
> > 
> > Signed-off-by: Randall Huang <huangrandall@google.com>
> > ---
> >  drivers/scsi/sd.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> > index 4b49cb67617e..28bfa9ed2b54 100644
> > --- a/drivers/scsi/sd.c
> > +++ b/drivers/scsi/sd.c
> > @@ -1201,7 +1201,12 @@ static int sd_setup_read_write_cmnd(struct scsi_cmnd *SCpnt)
> >  		SCpnt->cmnd[11] = (unsigned char) (this_count >> 16) & 0xff;
> >  		SCpnt->cmnd[12] = (unsigned char) (this_count >> 8) & 0xff;
> >  		SCpnt->cmnd[13] = (unsigned char) this_count & 0xff;
> > -		SCpnt->cmnd[14] = SCpnt->cmnd[15] = 0;
> > +		if (rq_data_dir(rq) == WRITE) {
> > +			SCpnt->cmnd[14] = rq->bio->bi_write_hint & 0x3f;
> > +		} else {
> > +			SCpnt->cmnd[14] = 0;
> > +		}
> 
> No need for braces here.
Already send a new version
> 
> But what I'm more worried about is devices not recognizing the feature
> throwing up on the field.  Can you check what SBC version first
> references these or come up with some other decently smart conditional?
My reference is SCSI Block Commands – 3 (SBC-3) Revision 25.
Section 5.32 WRITE (10) and 5.34 WRITE (16)

> Maybe Martin has a good idea, too.
