Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1F5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 12:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B87020874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 12:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="afmvxOt8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732495AbfAKMxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 07:53:44 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:46338 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731592AbfAKMxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 07:53:44 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190111125342euoutp0278949535fa43dca7497d7876c4ae7773~4zGjdVTgP1765017650euoutp02B
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 12:53:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190111125342euoutp0278949535fa43dca7497d7876c4ae7773~4zGjdVTgP1765017650euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1547211222;
        bh=89w4z185cKSpKoEuON8iIMsFITImEqT/iU3vDRDgzLI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=afmvxOt8LYbU1jzhExPNtIas9xG/BJgY3FbFB+iBC6TPjb1PcJBsaMcMO00tTtRlr
         bedwb+g7gt1vuEAB2FwQj3IBR2ZE10G56Oh5KhNtL4lyQ0S7z51eGkPpgNaZD1DlSE
         2Ygsjmwl0ZO5CmI35g6g6zM65lLGdA/soT24DDNQ=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190111125341eucas1p28346b77c409e8eb4c33efef616475279~4zGir3FeZ0303203032eucas1p29;
        Fri, 11 Jan 2019 12:53:41 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 27.C1.04441.5D1983C5; Fri, 11
        Jan 2019 12:53:41 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190111125341eucas1p22005c473fcb349fcd7d11fc74230534f~4zGh3iuga0321003210eucas1p20;
        Fri, 11 Jan 2019 12:53:41 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190111125340eusmtrp1d651706311c6b3f414ba6faa161686a6~4zGhpCV-p1325913259eusmtrp1I;
        Fri, 11 Jan 2019 12:53:40 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-d5-5c3891d537e4
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id DD.82.04284.4D1983C5; Fri, 11
        Jan 2019 12:53:40 +0000 (GMT)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190111125340eusmtip2f32139c5cd66da9eae76b6ef93e323c8~4zGhSKCar0320903209eusmtip2C;
        Fri, 11 Jan 2019 12:53:40 +0000 (GMT)
Subject: Re: [PATCH] fbdev: offb: Fix OF node name handling
To:     Mathieu Malaterre <malat@debian.org>, Rob Herring <robh@kernel.org>
Cc:     Elimar Riesebieter <riesebie@lxtec.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "# v4 . 11" <stable@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <c1ee1bb0-3144-6752-b4ae-d65c65f96543@samsung.com>
Date:   Fri, 11 Jan 2019 13:53:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <CA+7wUswqMNc1js6hyszYKVOeXrVPVDYLxSmZ97Uaqqo7u0Z9vQ@mail.gmail.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsWy7djP87pXJ1rEGExep2Fx5et7NosTfR9Y
        LS7vmsNmcXbTWxaLzk9LWCz+79nBbrFg4yNGB3aPX21zmT02repk87jffZzJo+XBVnaPz5vk
        AlijuGxSUnMyy1KL9O0SuDJ+z7zJVvCNs+L50kfMDYxNHF2MnBwSAiYS77Z2s3cxcnEICaxg
        lPj3axIzhPOFUaJn4kGozGdGiUn/J7J0MXKAtezZIQgRX84ocX7OSyYI5z2jxKnHr1hB5goL
        WEsc/XudGaRBRMBd4uRMCZAaZoEnjBK9/xexgNSwCVhJTGxfxQhi8wrYSayf3QrWyyKgKtF4
        fikjSK+oQIRE/xl1iBJBoDFPwFo5BQIlfu/fyQRiMwvIS2x/OwfsagmBRewSb2fdZoM41EVi
        wj8jiDeFJV4d38IOYctInJ7cwwJRP51R4s2vpVDOekaJNWeOMUFUWUscPn6RFWQQs4CmxPpd
        +hBhR4nNW78wQcznk7jxVhDiBj6JSdumM0OEeSU62oQgqtUkNizbwAaztmvnSqgSD4mZt9Um
        MCrOQvLYLCTPzEJYu4CReRWjeGppcW56arFhXmq5XnFibnFpXrpecn7uJkZgmjn97/inHYxf
        LyUdYhTgYFTi4e3wNY8RYk0sK67MPcQowcGsJMJ7Os8iRog3JbGyKrUoP76oNCe1+BCjNAeL
        kjhvNcODaCGB9MSS1OzU1ILUIpgsEwenVAOj8HV7pxvMjOkBrho/H2/0YOJ1rVg581rz5q+J
        le/WJSZd//ah6Mlm36nHFy6RnzhN/6zAjUey1q7rhJfL7HvE9Ct416a02cK2Z84x5U9fZ97w
        7umvuic/BGKCflhs8uY30v+17Wip/gnfJR+U3Z85qFxPu9B9STvkTO3KnbOUzPROPXq8dfep
        VCWW4oxEQy3mouJEAFwvuzMvAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsVy+t/xe7pXJlrEGEw9pGtx5et7NosTfR9Y
        LS7vmsNmcXbTWxaLzk9LWCz+79nBbrFg4yNGB3aPX21zmT02repk87jffZzJo+XBVnaPz5vk
        Alij9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DJ+
        z7zJVvCNs+L50kfMDYxNHF2MHBwSAiYSe3YIdjFycQgJLGWUOLXoCjtEXEbi+PqyLkZOIFNY
        4s+1LjaImreMEse2v2cHSQgLWEsc/XudGaReRMBd4uRMCYia84wS6963s4HUMAs8YZRo70gD
        sdkErCQmtq9iBLF5Bewk1s9uZQWxWQRUJRrPLwWLiwpESNx62MECUSMINPMJmM0pECjxe/9O
        JoiZ6hJ/5l1ihrDlJba/ncM8gVFwFpKWWUjKZiEpW8DIvIpRJLW0ODc9t9hQrzgxt7g0L10v
        OT93EyMwgrYd+7l5B+OljcGHGAU4GJV4eDt8zWOEWBPLiitzDzFKcDArifCezrOIEeJNSays
        Si3Kjy8qzUktPsRoCvTERGYp0eR8YHTnlcQbmhqaW1gamhubG5tZKInznjeojBISSE8sSc1O
        TS1ILYLpY+LglGpgbDl08deXpg8dnpqGSUKi68JvHBN6XL8u8XrC96O2L93uhj88cqmt+Oys
        CexXCuQLAnZfc8xaHFryS4zlv7bdy7+JXP5HAxR0ttrE3v8UbbN1sU7Jsq0iO/7z2LW+jvnA
        9HX5acZ4yQnrs3g7WmX+PZq2qcL2ENOnHrbDh3TmGmn47BR5WMe3V4mlOCPRUIu5qDgRAC8+
        lr62AgAA
X-CMS-MailID: 20190111125341eucas1p22005c473fcb349fcd7d11fc74230534f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190107201154epcas5p4e94984fb6be9a3263e97c79d362048a5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190107201154epcas5p4e94984fb6be9a3263e97c79d362048a5
References: <20190107173132.27316-1-robh@kernel.org>
        <CGME20190107201154epcas5p4e94984fb6be9a3263e97c79d362048a5@epcas5p4.samsung.com>
        <CA+7wUswqMNc1js6hyszYKVOeXrVPVDYLxSmZ97Uaqqo7u0Z9vQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 01/07/2019 09:11 PM, Mathieu Malaterre wrote:
> On Mon, Jan 7, 2019 at 6:31 PM Rob Herring <robh@kernel.org> wrote:
>>
>> Commit 5c63e407aaab ("fbdev: Convert to using %pOFn instead of
>> device_node.name") changed how the OF FB driver handles the OF node
>> name. This missed the case where the node name is passed to
>> offb_init_palette_hacks(). This results in a NULL ptr dereference
>> in strncmp and breaks any system except ones using bootx with no display
>> node.
>>
>> Fix this by making offb_init_palette_hacks() use the OF node pointer and
>> use of_node_name_prefix() helper function instead for node name
>> comparisons. This helps in moving all OF node name accesses to helper
>> functions in preparation to remove struct device_node.name pointer.
>>
>> Fixes: 5c63e407aaab ("fbdev: Convert to using %pOFn instead of device_node.name")
> 
> Looks good to me:
> 
> ...
> [    0.000000] Linux version 5.0.0-rc1+ (malat@debian.org) (gcc
> version 6.3.0 20170516 (Debian 6.3.0-18)) #21 Mon Jan 7 21:03:53 CET
> 2019
> ...
> 
> So here is my :
> 
> Tested-by: Mathieu Malaterre <malat@debian.org>

Patch queued for 5.0, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
