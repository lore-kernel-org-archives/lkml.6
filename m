Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E18DC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 16:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2667B208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 16:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h2gilgFM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2667B208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbeH0T5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 15:57:54 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42992 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbeH0T5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 15:57:54 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7RG8tGK187612;
        Mon, 27 Aug 2018 16:10:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to : content-transfer-encoding; s=corp-2018-07-02;
 bh=FKmnZdRXAKGiKfqrGGMSVMyfMhDD1vG6HSST5wFQiKk=;
 b=h2gilgFMkMwXezKn2rwOA7nrujnDfrwk4zRtvDNaj2ru0HeRdvu9TKr12RBiGrpcRRrI
 8Wz8UNRfNSn8JZePk/kjJbyk6f5Wfcziv7RPv7JBNuZH6/qpeLjLdUGIlHKkjU048kVI
 /1I2Lktx5S8jGcOzJ+wIYbBOecH++7mleWL1Acy1JeCyKEHyNW2WN4LakylwTiWKhaH9
 1se6IkoCnWsc/r4Rbd9E43WADTg06WxrZV2odDTdisO9t8bSgvdRMyflIJl4k+NV1xhR
 0rgxZDRWPpzxm3nkAIWch+Ro8u5pkq+jJEFEPIAfPpvYQwvs1e1ojzwqMSfLSvBY1gud SQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2m2y2p6vr3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Aug 2018 16:10:31 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w7RGAPh9020643
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Aug 2018 16:10:25 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7RGAOA0004871;
        Mon, 27 Aug 2018 16:10:24 GMT
Received: from char.us.oracle.com (/10.152.35.101)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 27 Aug 2018 09:10:24 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 924576A0112; Mon, 27 Aug 2018 12:10:23 -0400 (EDT)
Date:   Mon, 27 Aug 2018 12:10:23 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Juergen Gross <jgross@suse.com>
Cc:     Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        boris.ostrovsky@oracle.com
Subject: Re: [PATCH v3 0/5] xen/blk: persistent grant rework
Message-ID: <20180827161023.GV10467@char.us.oracle.com>
References: <20180813140114.20126-1-jgross@suse.com>
 <20180817155909.4cwiy6bhhgiala5m@mac>
 <8aaf02b1-999d-81fc-2732-ed556b959a8a@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <8aaf02b1-999d-81fc-2732-ed556b959a8a@suse.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8998 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808270171
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 03:52:23PM +0200, Juergen Gross wrote:
> On 17/08/18 17:59, Roger Pau Monn=E9 wrote:
> > On Mon, Aug 13, 2018 at 04:01:09PM +0200, Juergen Gross wrote:
> >> Persistent grants are used in the Xen's blkfront/blkback drivers to
> >> avoid mapping/unmapping of I/O buffers in the backend for each I/O.
> >>
> >> While this speeds up processing quite a bit there are problems relat=
ed
> >> to persistent grants in some configurations: domains with multiple
> >> block devices making use of persistent grants might suffer from a la=
ck
> >> of grants if each of the block devices experienced a high I/O load a=
t
> >> some time. This is due to the number of persistent grants per device
> >> only to be limited by a rather high maximum value, but never being
> >> released even in case of longer times without any I/O.
> >>
> >> This series modifies xen-blkback to unmap any domU page mapped via a
> >> persistent grant after a timeout (default: 60 seconds). The timeout
> >> is set to its default value again when a persistent grant has been
> >> used for an I/O.
> >>
> >> xen-blkfront is modified to scan every 10 seconds for persistent gra=
nts
> >> not in use by blkback any more and to remove such grants.
> >>
> >> The last 3 patches are small cleanups of blkfront and blkback driver=
s.
> >>
> >> V3:
> >> - patch 1: make timeout parameter static
> >=20
> > Konrad if you are OK with this series, could you please send a pull
> > request to Jens?
>=20
> Ping?

Yes, let me do that now.
>=20
>=20
> Juergen
