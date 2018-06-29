Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268D4C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 19:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D29CF27C4A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 19:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qENjSI96"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D29CF27C4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935698AbeF2TAQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 15:00:16 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:39844 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932377AbeF2TAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 15:00:14 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5TIwcIq146638
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 19:00:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2017-10-26;
 bh=gQVgpw0AOrDWl7OARgqJSMwACPY7ddyLJb32MmSyeWA=;
 b=qENjSI96ACsOxqloAP3BFax1MOsintmvx4Q0JkZa9F+Y4RJDMtDJJGTm6tabvx7v3A+V
 kFaCBfxNoOAj9cR32//9tBQHTR90vYKGZp73Pxt74DyX7luiaHGy0eHXj8pIZ3Fjcvul
 Oa3vJk4zrBZWaZm9+VGQr6G9tGF/ITyr6kqrI9C5iuKPs5jAsLUVOGVBQ3dNf4y1qTpu
 F1jj7uWBtz7tlDNffqu8AcEi3p5Y2Q0uUpCeOKVUd0s46cql66+/A/2ipQ68QFIzENkY
 gXFXh6EOq7V4K8yq6pt2qGkB1j1B+TLw/4lheIu4Zr8Jx9wnmOQuOsqhBP/9zMxYYuYM mw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2jukmu7r3r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 19:00:13 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5TJ0CVP019363
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 19:00:12 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5TJ0Crw008539
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 19:00:12 GMT
Received: from mail-oi0-f48.google.com (/209.85.218.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 29 Jun 2018 12:00:12 -0700
Received: by mail-oi0-f48.google.com with SMTP id n84-v6so9356375oib.9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 12:00:12 -0700 (PDT)
X-Gm-Message-State: APt69E0D9hZFJoWnbo6qJcaz686XKv8DCEl1VaCx9rJpGGmQ2NBED8QI
        AW3ZrRItxmncNtMPapwcfYUGu02qGlqKr3TNG1w=
X-Google-Smtp-Source: AAOMgpfDBmvAD1fidikSB8f7FtRV2th/gaQxYLBdCKQPff0/RCEpNXRXJck9n3Qk0qrQfCaBAGvq335VIje2jvv4tnM=
X-Received: by 2002:aca:db0a:: with SMTP id s10-v6mr9493793oig.339.1530298811618;
 Fri, 29 Jun 2018 12:00:11 -0700 (PDT)
MIME-Version: 1.0
References: <20180627013116.12411-1-bhe@redhat.com> <20180627013116.12411-5-bhe@redhat.com>
 <cb67381c-078c-62e6-e4c0-9ecf3de9e84d@intel.com> <CAGM2rebsL_fS8XKRvN34NWiFN3Hh63ZOD8jDj8qeSOUPXcZ2fA@mail.gmail.com>
 <88f16247-aea2-f429-600e-4b54555eb736@intel.com> <b8d5b9cb-ca09-4bcc-0a31-3db1232fe787@oracle.com>
 <7ad120fb-377b-6963-62cb-a1a5eaa6cad4@intel.com>
In-Reply-To: <7ad120fb-377b-6963-62cb-a1a5eaa6cad4@intel.com>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Fri, 29 Jun 2018 14:59:35 -0400
X-Gmail-Original-Message-ID: <CAGM2rebmK30_jDyXa60uRC1q1wTAbJkxv3CDaao4JUMOrMTx4A@mail.gmail.com>
Message-ID: <CAGM2rebmK30_jDyXa60uRC1q1wTAbJkxv3CDaao4JUMOrMTx4A@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] mm/sparse: Optimize memmap allocation during sparse_init()
To:     dave.hansen@intel.com
Cc:     bhe@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, pagupta@redhat.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        kirill.shutemov@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8939 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=315
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806290202
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > This is done so nr_consumed_maps does not get out of sync with the
> > current pnum. pnum does not equal to nr_consumed_maps, as there are
> > may be holes in pnums, but there is one-to-one correlation.
> Can this be made more clear in the code?

Absolutely. I've done it here:
http://lkml.kernel.org/r/20180628173010.23849-1-pasha.tatashin@oracle.com

Pavel
