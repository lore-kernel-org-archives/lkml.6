Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340DBC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 13:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 035F521848
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 13:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J4j9p4oT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfAWNWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 08:22:21 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:34290 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfAWNWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 08:22:21 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0NDEDgj194366;
        Wed, 23 Jan 2019 13:21:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=/orrWMYiF7s/PRi+ZWvmsxRG9vOAxGOt71oInJg9hNg=;
 b=J4j9p4oTJs9pHPAPfdQosv62OUDUwbW5iXWImy9Xw5mkyPLorUzfOSwXG+Pz6Hl5NkSB
 r7g+cah0pLD+GMOXDTDQdNhx+bMpNRm2LLyU9F20GAsJFQVtmT/suPsxYFEXGtq/+DCh
 uc3umUX8CMgBbaeBa5BjmTn+0doBsH3eKQ/6NTtiNWekzhHOiqwHTzopHj1udcUsoUbu
 CfmWSxPue6oO+dsjgXBfHS8BkBBNTVRS9Ko5wG+R1LWAtsKn2yZiZviqliYhxRl88FMt
 MXd8Lp84GXpqP7gVP7pBVDCL4TvlNExDf+B/GpnjEtfCBFjUbF6X2nF7pQcL8uSnoZ4G xQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2q3sdehx71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jan 2019 13:21:50 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0NDLmbp005483
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jan 2019 13:21:49 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0NDLjiW011995;
        Wed, 23 Jan 2019 13:21:46 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 23 Jan 2019 05:21:45 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 1/3] treewide: Lift switch variables out of switches
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <CAG48ez2vfXkr9dozJiGmze8k49VOXfs=K7M8bv0aQsDDpzrEFQ@mail.gmail.com>
Date:   Wed, 23 Jan 2019 06:21:44 -0700
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Laura Abbott <labbott@redhat.com>,
        Alexander Popov <alex.popov@linux.com>,
        xen-devel <xen-devel@lists.xenproject.org>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        Network Development <netdev@vger.kernel.org>,
        linux-usb@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>, dev@openvswitch.org,
        linux-kbuild@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <536BB69D-6E93-4E32-8303-16D92E07D8AA@oracle.com>
References: <20190123110349.35882-1-keescook@chromium.org>
 <20190123110349.35882-2-keescook@chromium.org>
 <20190123115829.GA31385@kroah.com>
 <CAG48ez2vfXkr9dozJiGmze8k49VOXfs=K7M8bv0aQsDDpzrEFQ@mail.gmail.com>
To:     Jann Horn <jannh@google.com>
X-Mailer: Apple Mail (2.3445.102.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9144 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=809
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901230100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 23, 2019, at 5:09 AM, Jann Horn <jannh@google.com> wrote:
>=20
> AFAICS this only applies to switch statements (because they jump to a
> case and don't execute stuff at the start of the block), not blocks
> after if/while/... .

It bothers me that we are going out of our way to deprecate valid C =
constructs
in favor of placing the declarations elsewhere.

As current compiler warnings would catch any reference before =
initialization
usage anyway, it seems like we are letting a compiler warning rather =
than the
language standard dictate syntax.

Certainly if we want to make it a best practice coding style issue we =
can, and
then an appropriate note explaining why should be added to
Documentation/process/coding-style.rst.=
