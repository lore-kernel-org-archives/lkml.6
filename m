Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18DFC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B4572086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20150623.gappssmtp.com header.i=@linbit-com.20150623.gappssmtp.com header.b="B8uESlLH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B4572086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbeIJRja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 13:39:30 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:56165 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727815AbeIJRja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 13:39:30 -0400
Received: by mail-wm0-f66.google.com with SMTP id f21-v6so21411150wmc.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 05:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n8lSDqnHi4bVqautm2beJdS+qDTrEK2Gazzns3VX8N0=;
        b=B8uESlLHsybQBT/2Sw3RdOBdp/hl7p6bhpOo8p3xOn/fThE4WjmzJOizCANtxTTlNg
         ItSoNRW1iCMvIq7NBeoc4zw7yMWxEDZ+0FHVjaE2M3A0NcGdKUut9EUPXVoL/nZCs05k
         fFobN1lgcAcrR5oDuZkcoV+gj05kWDuHS+IMdJaElGNX6AMscvcbH+ALQ886ohh8Viiv
         V9bdvepUZx+QTpORqc21hgrcFUTm1Bl/dkjgmJEpPLFfpi7m5HzIYNRWUA6mg7//OwiY
         EStayIjbSxquIhPxAatNFaeeh5FyCyQTgIP9KZixm+I1H5k1g9p57lQAdKLbQKec6/Y5
         kWeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=n8lSDqnHi4bVqautm2beJdS+qDTrEK2Gazzns3VX8N0=;
        b=oMFNDhRTBF6EQ63W3XM9ltREV1NF4+1W/4Fqdlxz47kwQl4fnvvnH3ah7StKnuwyxV
         YBSsw2REx4A0UpqhRhdXE+Lb8qX0aNw0nFJYQosfagEmCr72PWLvZ1K0WSVbj8LnDNuV
         XhsEUQgkBHlxopVTIf2N3ycuuQb+XlJ3PJQ6+Q0pwrAleNdhkxo+QRWFD09XaFnW8IgM
         DTAxpo3UoLRn80IwbZb1lT+uMMGJji0NxDLyx1+ZNbkWHJD/AFAR/x7p00ehADGuxaTX
         kwN6KtBgpWZWLuf85F7Yjer1nrFGVg7GDxQgYAqQ1n/MXOaRM/UmKxGcTi3OAyyoh7tP
         BJZw==
X-Gm-Message-State: APzg51DRip0luyWtUMkNiRLccde/kTLHsaWNEv0lI+mm+k4fwv6yxR4d
        scHaAvCEn6nqGZYD1T6xIlKzKQ==
X-Google-Smtp-Source: ANB0VdaIQypliyjxoJrBCktMZW8Tz3Klo8lUSkvv+L4rk0SVuRIeAwcm7FRyV80oQped2cpj86L9pQ==
X-Received: by 2002:a1c:9cd3:: with SMTP id f202-v6mr618928wme.148.1536583532798;
        Mon, 10 Sep 2018 05:45:32 -0700 (PDT)
Received: from soda.linbit (212-186-191-219.static.upcbusiness.at. [212.186.191.219])
        by smtp.gmail.com with ESMTPSA id t131-v6sm23810152wmg.10.2018.09.10.05.45.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 05:45:32 -0700 (PDT)
Date:   Mon, 10 Sep 2018 14:45:31 +0200
From:   Lars Ellenberg <lars.ellenberg@linbit.com>
To:     Valentin Vidic <Valentin.Vidic@CARNet.hr>
Cc:     drbd-user@lists.linbit.com, Jens Axboe <axboe@kernel.dk>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-block@vger.kernel.org, xen-devel@lists.xenproject.org,
        Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Subject: Re: [DRBD-user] [PATCH] xen-blkback: Switch to closed state after
 releasing the backing device
Message-ID: <20180910124531.GA31737@soda.linbit>
Mail-Followup-To: Valentin Vidic <Valentin.Vidic@CARNet.hr>,
        drbd-user@lists.linbit.com, Jens Axboe <axboe@kernel.dk>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-block@vger.kernel.org, xen-devel@lists.xenproject.org,
        Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
References: <20180829065214.23546-1-Valentin.Vidic@CARNet.hr>
 <20180905103649.edugijsjx4v2fbxd@mac.bytemobile.com>
 <20180905162756.GA26705@gavran.carpriv.carnet.hr>
 <20180907120337.GB11834@soda.linbit>
 <20180907121348.GM26705@gavran.carpriv.carnet.hr>
 <20180907132828.GC11834@soda.linbit>
 <20180907164500.GN26705@gavran.carpriv.carnet.hr>
 <20180907171459.GO26705@gavran.carpriv.carnet.hr>
 <20180908073432.GP26705@gavran.carpriv.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180908073432.GP26705@gavran.carpriv.carnet.hr>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 08, 2018 at 09:34:32AM +0200, Valentin Vidic wrote:
> On Fri, Sep 07, 2018 at 07:14:59PM +0200, Valentin Vidic wrote:
> > In fact the first one is the original code path before I modified
> > blkback.  The problem is it gets executed async from workqueue so
> > it might not always run before the call to drbdadm secondary.
> 
> As the DRBD device gets released only when the last IO request
> has finished, I found a way to check and wait for this in the
> block-drbd script:

> --- block-drbd.orig     2018-09-08 09:07:23.499648515 +0200
> +++ block-drbd  2018-09-08 09:28:12.892193649 +0200
> @@ -230,6 +230,24 @@
>  and so cannot be mounted ${m2}${when}."
>  }
>  
> +wait_for_inflight()
> +{
> +  local dev="$1"
> +  local inflight="/sys/block/${dev#/dev/}/inflight"
> +  local rd wr
> +
> +  if ! [ -f "$inflight" ]; then
> +    return
> +  fi
> +
> +  while true; do
> +    read rd wr < $inflight
> +    if [ "$rd" = "0" -a "$wr" = "0" ]; then

If it is "idle" now, but still "open",
this will not sleep, and still fail the demotion below.

> +      return
> +    fi
> +    sleep 1
> +  done
> +}
>  
>  t=$(xenstore_read_default "$XENBUS_PATH/type" 'MISSING')
>  
> @@ -285,6 +303,8 @@
>          drbd_lrole="${drbd_role%%/*}"
>          drbd_dev="$(drbdadm sh-dev $drbd_resource)"
>  
> +        wait_for_inflight $drbd_dev
> +
>          if [ "$drbd_lrole" != 'Secondary' ]; then
>            drbdadm secondary $drbd_resource

You try to help it by "waiting forever until it appears to be idle".
I suggest to at least limit the retries by iteration or time.
And also (or, instead; but you'd potentially get a number of
"scary messages" in the logs) add something like:
	  for i in 1 2 3 5 7 x; do
            drbdadm secondary $drbd_resource && exit 0
            if [ $i = x ]; then
	      # ... "appears to still be in use, maybe by" ...
              fuser -v $drbd_dev
              exit 1
	    # else ... "will retry in $i seconds" ...
            fi
            sleep $i
	  done
...

Or, well, yes, fix blkback to not "defer" the final close "too long",
if at all possible.

    Lars
