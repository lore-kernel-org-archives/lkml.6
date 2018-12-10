Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC426C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 06:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70DDF2081C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 06:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544424872;
	bh=lNIFJX4VyV0/RCb52HAnk/Baq8kRfNS2e/hYAIDDzrU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=fhuHBUly6HxnoOY8NJ4J9/8WklwYryHlf4mSxYltaCDOInZ2hGp1kNaWWK+0lrQ07
	 qgmPNWjuol+loFAZgMICvVvldSjxAbjqLqcawD82eWNFuxZ2OLSJarSPh4nDS9N2mq
	 YZaW5F4ZoLlEMupTaV5X8OfGyG6XtyGipA3ijJX8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70DDF2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbeLJGyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 01:54:31 -0500
Received: from mga02.intel.com ([134.134.136.20]:47638 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbeLJGya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 01:54:30 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Dec 2018 22:54:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,337,1539673200"; 
   d="asc'?scan'208";a="302470539"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.175])
  by fmsmga005.fm.intel.com with ESMTP; 09 Dec 2018 22:54:25 -0800
From:   Felipe Balbi <balbi@kernel.org>
To:     Anurag Kumar Vulisha <anuragku@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Johan Hovold <johan@kernel.org>,
        Jaejoong Kim <climbbb.kim@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Roger Quadros <rogerq@ti.com>,
        Manu Gautam <mgautam@codeaurora.org>,
        "martin.petersen\@oracle.com" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Mike Christie <mchristi@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Colin Ian King <colin.king@canonical.com>
Cc:     "linux-usb\@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "v.anuragkumar\@gmail.com" <v.anuragkumar@gmail.com>,
        Thinh Nguyen <thinhn@synopsys.com>,
        Tejas Joglekar <tejas.joglekar@synopsys.com>,
        Ajay Yugalkishore Pandey <APANDEY@xilinx.com>
Subject: RE: [PATCH v7 09/10] usb: dwc3: Check for IOC/LST bit in both event->status and TRB->ctrl fields
In-Reply-To: <BL0PR02MB56331B2ECFFEB96A99936C32A7AB0@BL0PR02MB5633.namprd02.prod.outlook.com>
References: <1543662811-5194-1-git-send-email-anurag.kumar.vulisha@xilinx.com> <1543662811-5194-10-git-send-email-anurag.kumar.vulisha@xilinx.com> <875zw82vfj.fsf@linux.intel.com> <BL0PR02MB563352F83A80E3B92347A7A4A7A80@BL0PR02MB5633.namprd02.prod.outlook.com> <874lbpx3vg.fsf@linux.intel.com> <BL0PR02MB56331B2ECFFEB96A99936C32A7AB0@BL0PR02MB5633.namprd02.prod.outlook.com>
Date:   Mon, 10 Dec 2018 08:54:13 +0200
Message-ID: <87pnu927oq.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Anurag Kumar Vulisha <anuragku@xilinx.com> writes:
> HI Felipe,
>
>>-----Original Message-----
>>From: Felipe Balbi [mailto:balbi@kernel.org]
>>Sent: Friday, December 07, 2018 11:42 AM
>>To: Anurag Kumar Vulisha <anuragku@xilinx.com>; Greg Kroah-Hartman
>><gregkh@linuxfoundation.org>; Shuah Khan <shuah@kernel.org>; Alan Stern
>><stern@rowland.harvard.edu>; Johan Hovold <johan@kernel.org>; Jaejoong Kim
>><climbbb.kim@gmail.com>; Benjamin Herrenschmidt <benh@kernel.crashing.org=
>;
>>Roger Quadros <rogerq@ti.com>; Manu Gautam <mgautam@codeaurora.org>;
>>martin.petersen@oracle.com; Bart Van Assche <bvanassche@acm.org>; Mike
>>Christie <mchristi@redhat.com>; Matthew Wilcox <willy@infradead.org>; Col=
in Ian
>>King <colin.king@canonical.com>
>>Cc: linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org;
>>v.anuragkumar@gmail.com; Thinh Nguyen <thinhn@synopsys.com>; Tejas Joglek=
ar
>><tejas.joglekar@synopsys.com>; Ajay Yugalkishore Pandey <APANDEY@xilinx.c=
om>
>>Subject: RE: [PATCH v7 09/10] usb: dwc3: Check for IOC/LST bit in both ev=
ent->status
>>and TRB->ctrl fields
>>
>>
>>Hi,
>>
>>Anurag Kumar Vulisha <anuragku@xilinx.com> writes:
>>>>> @@ -2286,7 +2286,12 @@ static int
>>>>dwc3_gadget_ep_reclaim_completed_trb(struct dwc3_ep *dep,
>>>>>  	if (event->status & DEPEVT_STATUS_SHORT && !chain)
>>>>>  		return 1;
>>>>>
>>>>> -	if (event->status & (DEPEVT_STATUS_IOC | DEPEVT_STATUS_LST))
>>>>> +	if ((event->status & DEPEVT_STATUS_IOC) &&
>>>>> +	    (trb->ctrl & DWC3_TRB_CTRL_IOC))
>>>>> +		return 1;
>>>>
>>>>this shouldn't be necessary. According to databook, event->status
>>>>contains the bits from the completed TRB.  Which means that
>>>>event->status & IOC will always be equal to trb->ctrl & IOC.
>>>>
>>> Thanks for reviewing this patch. Lets consider an example where a
>>> request has num_sgs > 0 and each sg is mapped to a TRB and the last
>>> TRB has the IOC bit set. Once the controller is done with the
>>> transfer, it  generates XferInProgress for the last TRB (since IOC bit
>>> is set). As a part of trb reclaim process
>>> dwc3_gadget_ep_reclaim_trb_sg() calls
>>> dwc3_gadget_ep_reclaim_completed_trb() for req->num_sgs times. Since
>>> the event already has the IOC bit set, the loop is exited from the
>>> loop at the very first TRB and the remaining TRBs (mapped to the sglist=
) are left
>>unhandled.
>>> To avoid this we modified the code to exit only if both TRB & event
>>> has the IOC bit set.
>>
>>Seems like IOC case should just test for chain flag as well:
>>
>
> Okay. Along with this logic the code for updating chain bit should also b=
e modified I guess.

not really

> Since the IOC bit is also set when there are not enough TRBs available, t=
he code should be
> modified to not set DWC3_TRB_CTRL_CHN bit when the IOC bit is set. I will=
 update below
> changes along with your suggestions and resend the patches.

no. Actually I don't think we're allowed to split a scatter/gather like
that. I did that quite a while ago, but I don't think we're allowed to
do so. What we should do, in that case, is not even queue that request
until we have enough for all members of the scatter/gather. But that's a
separate patch, anyway.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlwODZcACgkQzL64meEa
mQZaSRAAyNq2TKRZPznYqR/04p9Aip5KW/VtDfvM217J4J67CMszeRiJ131FHbeX
43JRSgZ2ThO2MSvIAhMDld50AmVfyh/5Um9lrYBWk2NZijYazNYb1rGO2dQoOoRI
VR0SO9dEbjHpWx1Wq971KdHX9zYmqFvcWlwgvVxf2wItBOBwhPw3vQcNkCgq/tEc
A6+Hr+JAZdsARTopcQfJSxYluyT/6xYLzzI5dC9jztUkZb45gfU6aV2L0OHHbEBK
5xCWPrW1qZIYI1AGi075Sli9XfsPogut4YZ5vATHb5+PQDLMB9W3h82HF+GH7azL
EClmX5EPdd7VyPUPaFEPaP2Yra8uVEeuRe/VyS8He0Kndq/kMJIuFTAYRSycYnRL
0DaWpnVA7MLaHBDcUdQeNXtXR1O+V90igNjOhXuAqaWuJ/TJdkEWNsJrmN15vDHu
GJrhRq09H3myDkUfUurLJfU7Zx5Lqi7ylhIF7Jbrb/jCAm3MNeAusm2rY5Zfo1m5
uzNER9fdltlzPspE/57APXlQIbCEKftapyOFdwxGwNPpIgzpBBWwbNG3oOfI1VsR
1keznt8hxZQuAXNDJNbzgiw5IsZQSI/dcxmC+Son/h1Fpv985ht7ytkRsSaoBLXZ
K59+Q3T25qT5HvmEE7ESJMCxFvcBKSny4qF6XHBCiIL7TNUIbAY=
=FGqq
-----END PGP SIGNATURE-----
--=-=-=--
