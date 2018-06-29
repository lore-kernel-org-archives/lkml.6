Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 055F2C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B266E27EB3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="vYJv/plF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B266E27EB3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936307AbeF2L4w (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 07:56:52 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45126 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933005AbeF2L4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 07:56:48 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5TBnjgt026304
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 11:56:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2017-10-26;
 bh=ATzPlDagAhc+HhcM+hQjNuon7OLSMPcvSesNKh5zv1o=;
 b=vYJv/plFpQlM0aqKGoE+0AWqVSKZLENwlmERwweqgU0sutQ81CVcpOpykG76Vbb4Ar0J
 eTzjHikzkedZcxf5VC1MpkxtIUrh18cuTXjvWPZv3g8yYtoU9V6iV/eINtqMwRi/o804
 UkOOgiT22qvFpqwzy+a6Rre4WYFzNKKoBgX/f6WqoC6cQp5DtiHDYf/JW6K3PLUFoMFJ
 s0HjS4YxgCQtKnGMGKfXoYeGGO0Ax/pNa+Qz37j76a/1OvZWYvTI4/7Un0aLyjI76YvL
 fU0vUuN3mHqobx8efy9pvLpMgKP1wN/RZEwwsQcdvffhWgLhSiSjTwtvH1fHn3xS79eM cQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2jukhsp8nf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 11:56:46 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5TBuk2d030426
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 11:56:46 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5TBukQ0005580
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 11:56:46 GMT
Received: from mail-ot0-f178.google.com (/74.125.82.178)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 29 Jun 2018 04:56:45 -0700
Received: by mail-ot0-f178.google.com with SMTP id q11-v6so7430976otk.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 04:56:45 -0700 (PDT)
X-Gm-Message-State: APt69E1DxrvZ9OTkjl+BNWP5LYpTEZqoDagUTZwAxrBtvGBSmezk+rjd
        uTGI6/AG0fG2t5NvDwItfL0jM50YtLMGgyLfC5A=
X-Google-Smtp-Source: AAOMgpctnLzoMSu98cVbiE0YPYPrHSHi0Ki1g+kkz0j2HrFbzuIQqrky71xKQjCis5858XRlFU8HRH9+ihyLHaHEUVI=
X-Received: by 2002:a9d:20c5:: with SMTP id x63-v6mr4906397ota.11.1530273405363;
 Fri, 29 Jun 2018 04:56:45 -0700 (PDT)
MIME-Version: 1.0
References: <20180628173010.23849-1-pasha.tatashin@oracle.com>
 <20180628173010.23849-2-pasha.tatashin@oracle.com> <20180629100413.GA21540@techadventures.net>
 <20180629104457.GA23043@techadventures.net>
In-Reply-To: <20180629104457.GA23043@techadventures.net>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Fri, 29 Jun 2018 07:56:09 -0400
X-Gmail-Original-Message-ID: <CAGM2reb=K4D7ZbACvEk1qZBq-dHB9erWxpz3Cmn+Wf+siUFULA@mail.gmail.com>
Message-ID: <CAGM2reb=K4D7ZbACvEk1qZBq-dHB9erWxpz3Cmn+Wf+siUFULA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] mm/sparse: add sparse_init_nid()
To:     osalvador@techadventures.net
Cc:     Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kirill.shutemov@linux.intel.com, Michal Hocko <mhocko@suse.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        dan.j.williams@intel.com, jack@suse.cz, jglisse@redhat.com,
        jrdr.linux@gmail.com, bhe@redhat.com, gregkh@linuxfoundation.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@gmail.com>, dave.hansen@intel.com,
        rientjes@google.com, mingo@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8938 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=616
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806290129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Scratch that.
> I forgot that incrementing the pointer will add up the right bytes.

Hi Oscar,

Thank you for looking at this patch. I will correct sprase/sparse
typos in the next revision. But, will wait for more comments before
sending a new version.

Pavel
